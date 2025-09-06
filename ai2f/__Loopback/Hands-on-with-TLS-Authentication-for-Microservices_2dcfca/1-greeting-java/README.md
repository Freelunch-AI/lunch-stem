# Example 1. Enabling MTLS on Spring Boot (Java) REST service

This is a simple REST microservice (Maven Project) based on Spring Boot 2.4.2 and Java 11. 

![](../img/mtls-java-0-greeting-microservice-arch.png)


## Steps

First of all, open 3 Browser tabs, in 2 of them open a [Wetty Terminal](https://github.com/chilcano/mtls-apps-examples/) and in both go to the working directory for this example. 

```sh
cd $HOME/workdir/mtls-apps-examples/1-greeting-java 
```

In the 3rd Browser tab open the [Code-Server](https://github.com/chilcano/mtls-apps-examples/).

Also make sure the owner of all files and directories under `workdir` is `$USER`, if the owner is `root` the labs will not work.  
You can set up a owner using this command: `sudo chown -R $USER $HOME/workdir/`


### I. Saying greeting (without encryption in transit)

#### 1. Check initial configuration of REST service.


```sh
cat src/main/resources/application.yml
```

You should have:
```yaml
server:
  port: 9090
``` 

> **Recommendation:**   
> You can use the [Code-Server](https://github.com/chilcano/mtls-apps-examples/) that you opened in the 3rd Browser tab. Only select the right file to edit.


#### 2. Clean and build the project.  

In the 1st Wetty Terminal execute this:
```sh
mvn clean spring-boot:run
``` 

#### 3. Calling the REST service.  


In the 2nd Wetty Terminal, execute this:
```sh
curl -i http://localhost:9090/greeting
```

It should give you the following response:  

```sh
HTTP/1.1 200 
Content-Type: application/json
Transfer-Encoding: chunked
Date: Tue, 16 Feb 2021 13:41:15 GMT

{"id":1,"content":"Hello, World!"}
```

#### 4. Close the running REST service.

Just type `Ctrl + C` in the Wetty terminal where are you running your REST service (1st Wetty Terminal).


### II. HTTP over TLS (One-way TLS)

#### 1. Generate the server certificate.   

Any Java application use [keystore](https://en.wikipedia.org/wiki/Java_KeyStore) file as repository of public-key certificates and asymmetric private keys. We can use [Java Keytool](https://docs.oracle.com/javase/7/docs/technotes/tools/solaris/keytool.html) to create the keystore with a public and private key:
```sh
keytool -v \
        -genkeypair \
        -dname "CN=Server (MTLS for Java Microservice),OU=DevOps Playground,O=ECS,C=UK" \
        -keystore src/main/resources/server_identity.p12 \
        -storepass secret \
        -keypass secret \
        -keyalg RSA \
        -keysize 2048 \
        -alias server \
        -validity 3650 \
        -deststoretype PKCS12 \
        -ext KeyUsage=digitalSignature,dataEncipherment,keyEncipherment,keyAgreement \
        -ext ExtendedKeyUsage=serverAuth,clientAuth \
        -ext SubjectAlternativeName:c=DNS:localhost,IP:127.0.0.1
```

If everything goes well, you will see this:
```sh
Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 3,650 days
        for: CN=MTLS for Java Microservice, OU=DevOps Playground, O=ECS, C=UK
[Storing src/main/resources/server_identity.p12]
```

> **Important:**   
> We have to create a keystore with a public and private key for the REST service (server). The public key will be shared with users/clients so that they can encrypt the communication. The communication between both parties (user and server) can be decrypted with the private key of the REST service (server).  
> The private key of the REST service (server) never must be shared and must be keep it secret, symmetrically encrypted or stored in a vault (i.e. PKCS#7, HSM, Hashicorp Vault, AWS Secrets Manager, etc.).

#### 2. Update the REST service onfiguration file.

Once generated the TLS certificate, you will need to update the REST service (server) config file with the location of the keystore and symmetric passwords required for keystore itself and for private key.  
```yaml
nano src/main/resources/application.yml
```

```yaml
server:
  port: 9443
  ssl:
    enabled: true
    key-store: classpath:server_identity.p12
    key-password: secret
    key-store-password: secret
```

#### 3. Run the REST service and test the One-way TLS connection.   

In the 1st Wetty Terminal execute this:
```sh
mvn clean spring-boot:run
```

In the 2nd Wetty Terminal execute this:
```sh
curl --insecure -v https://localhost:9443/greeting

## alternatively with '-k' option
curl -k https://localhost:9443/greeting

{"id":1,"content":"Hello, World!"}
```

Now, if we remove the `--insecure` or `-k` we will get this error:
```sh
curl https://localhost:9443/greeting

curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```
 
The above error means that `curl` (client) can not get validated the REST service's TLS certificate because the client don't have or don't trust the CA that issued the server certificate. Let's get the certificate(s) of the server and pass it to curl with the `--cacert`:
```sh
keytool -v \
    -exportcert \
    -file src/main/resources/server.crt \
    -alias server \
    -keystore src/main/resources/server_identity.p12 \
    -storepass secret \
    -rfc 
```

The server certificate will generated in this path:
```
Certificate stored in file <src/main/resources/server.crt>
```

Now, call the REST service using `--cacert` param. 
```sh
curl --cacert src/main/resources/server.crt \
        --capath /etc/ssl/certs/ \
        https://localhost:9443/greeting
```

> **Important:**  
> Unfortunately curl still will show same error about `verify the legitimacy of the server` because, curl doesn't support self-signed certificates, despite passing it using  `--cacert`. However, you can bypass this by installing CA certificates (root and intermediates, in our case the `server.crt` because it is self-signed) in the trusted CA certificate store of your workstation and compiling curl from source code. The process is explained in below links in References section.    
    
> **Important:**  
> Use self-signed certificates only for testing purposes and running your test in your LAN. The majority of HTTP clients do not support Self-Signed Certificates issued to localhost. Although, you could assume those risks by configuring your HTTP client.   


### III. Enabling Mutual TLS Authentication (Two-way TLS)

The configuration of MTLS (Two-way TLS) will require a new certificate for the client authentication. This configuration will force the client (curl) to identify itself using a certificate, and in that way, the server (REST service) can also validate the identity of the client and whether or not it is a trusted one.  


#### 1. Generating a client certificate.  

We are going to use `Java KeyTool` to create a new client self-signed certificate:

```sh
keytool -v \
        -genkeypair \
        -dname "CN=Client (MTLS for Java Microservice),OU=DevOps Playground,O=ECS,C=UK" \
        -keystore src/main/resources/client_identity.p12 \
        -storepass secret \
        -keypass secret \
        -keyalg RSA \
        -keysize 2048 \
        -alias client \
        -validity 3650 \
        -deststoretype PKCS12 \
        -ext KeyUsage=digitalSignature,dataEncipherment,keyEncipherment,keyAgreement \
        -ext ExtendedKeyUsage=serverAuth,clientAuth 
```


The only difference between the client's keytool command and server's one is that the server's one has `-ext SubjectAlternativeName:c=DNS:localhost,IP:127.0.0.1`. The `SubjectAlternativeName` attribute containing a `fqdn`, `hostname` or `IP address` is no required if the one that has the certificate is running as client.

#### 2. Extract the client certificate from `client_identity.p12`.  

The `client_identity.p12` file containts the key-pair (private and public key) and the public key certificate. We need run the next command to get only the client certificate.
```sh
keytool -v \
        -exportcert \
        -file src/main/resources/client.crt \
        -alias client \
        -keystore src/main/resources/client_identity.p12 \
        -storepass secret \
        -rfc 
```

#### 3. Create the server `truststore` with the client certificate.   

The `truststore` file, in `JKS` format, must contain all certificates that are trusted, and since we have 2 self-signed certificates (client and server), the `truststore` will be the same for the client and server.
```sh
keytool -v \
        -importcert \
        -file src/main/resources/client.crt \
        -alias client \
        -keystore src/main/resources/server_truststore.jks \
        -storepass secret \
        -noprompt
```

#### 4. Update the REST service configuration file.


Update the server configuration:

```yaml
nano src/main/resources/application.ym
```

```yaml
server:
  port: 9443
  ssl:
    enabled: true
    key-store: classpath:server_identity.p12
    key-password: secret
    key-store-password: secret
    client-auth: need                             ## require client authn
    trust-store: classpath:server_truststore.jks  ## trusted root and intermediate certs store
    trust-store-password: secret
``` 

#### 5. Get the client private key in PEM format. 

> The next `keytool` command only is necessary if the previous `Java KeyStore` file was generated in `JKS` format. In our case all `Java KeyStore` files (`client_identity.p12` and `server_identity.p12`) were create with the `-deststoretype PKCS12` flag, so that **next command is not necessary**.   
```sh
keytool -importkeystore \
        -srckeystore src/main/resources/client_identity.jks \
        -destkeystore src/main/resources/client_identity.p12 \
        -srcstoretype JKS \
        -deststoretype PKCS12 \
        -srcstorepass secret \
        -deststorepass secret \
        -srcalias client \
        -destalias client \
        -srckeypass secret \
        -destkeypass secret \
        -noprompt
```

Then, get the `PEM` file from `client_identity.p12` that holds only (note the `-nocerts` flag) the client private key.
```sh
openssl pkcs12 \
          -in src/main/resources/client_identity.p12 \
          -out src/main/resources/client_identity.pem \
          -passin pass:secret \
          -passout pass:secret \
          -nocerts
```

#### 6. Finally, you are able to call to the REST service to test MTLS.   

In the 1st Wetty terminal restart the server:
```sh
mvn clean spring-boot:run
```

In the 2nd Wetty terminal execute curl. The curl command will ask for `PEM pass phrase` to be able opening the `client_identity.pem`. Remmember, the `client_identity.pem` file contains a private key, it has been encrypted and encoded in base64.
```sh
curl -k --cacert src/main/resources/server_fqdn.crt \
       --key src/main/resources/client_identity.pem \
       --cert src/main/resources/client.crt \
       https://localhost:9443/greeting
```

```sh
Enter PEM pass phrase:

{"id":2,"content":"Hello, World!"}
```

#### 7. Testing MTLS using the Client PKCS12 (key-pair).  

We can take advantage of `--cert <certificate[:password]>` flag and avoid curl prompts for the private key's passphrase. Only we need to generate a `PKCS12` file in `PEM` format containing the certificate and key-pair (public and encrypted private key) and use all together. Use the next command:

```sh
openssl pkcs12 \
          -in src/main/resources/client_identity.p12 \
          -out src/main/resources/client_identity_and_cert.pem \
          -passin pass:secret \
          -passout pass:secret
```

Finally, execute curl again passing the passphrase using the aforementioned flag `--cert <certificate[:password]>`:   
```sh
curl -k --cacert src/main/resources/server_fqdn.crt \
       --cert src/main/resources/client_identity_and_cert.pem:secret \
       https://localhost:9443/greeting
```
   
```json
{"id":3,"content":"Hello, World!"}
```

## References

* [Spring Boot REST service](https://spring.io/guides/gs/rest-service/)
* [curl website - SSL Certificate Verification](https://curl.se/docs/sslcerts.html)
* [Daniel Stenberg's blog - Get the CA Cert for curl](https://daniel.haxx.se/blog/2018/11/07/get-the-ca-cert-for-curl/)