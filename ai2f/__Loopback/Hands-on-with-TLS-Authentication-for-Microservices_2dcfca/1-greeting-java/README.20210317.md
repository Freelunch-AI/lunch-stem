# Example 1. Enabling MTLS on Spring Boot (Java) REST service

This is a simple REST microservice (Maven Project) based on Spring Boot 2.4.2 and Java 11. 

![](../img/mtls-java-0-greeting-microservice-arch.png)

## Tools used

* OpenJDK 11 and Spring Boot to create the microservice.
* Java KeyTool to generate key-pairs, private and public keys, public key certificates and import, export and encode key material.
* OpenSSL to convert certificates to PEM/DER formats.
* Maven to build and run the application.


## Steps

First of all, open 2 [Wetty Terminals](../) and in both go to the working directory for this example:

```sh
cd $HOME/workdir/mtls-apps-examples/1-greeting-java 
```

Also make sure the owner of all files and directories under `workdir` is `$USER`, if the owner is `root` the labs will not work.  
You can set up a owner using this command: `sudo chown -R $USER $HOME/workdir/`


### I) Saying greeting (without encryption in transit)

#### 1. Check initial configuration of REST service.


```sh
cat src/main/resources/application.yml
```

You should have:
```yaml
server:
  port: 9090
``` 

#### 2. Clean and build the project.  


```sh
mvn clean spring-boot:run
``` 

#### 3. Calling the REST service.  


In other Wetty Terminal, execute this:
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

Just type `Ctrl + C`.   


### II) HTTP over TLS (One-way TLS)

#### 1. Enable One-way TLS.   

Update `src/main/resources/application.yml` with the next configuration:  
```sh
nano src/main/resources/application.yml
```
   
```yaml
server:
  port: 9443
  ssl:
    enabled: true
``` 

#### 2. Restart the REST service so that it can apply the changes.   

```sh
mvn clean spring-boot:run
``` 

You will get the following error:
```sh
Caused by: java.lang.IllegalArgumentException: Resource location must not be null
        at org.springframework.util.Assert.notNull(Assert.java:201) ~[spring-core-5.3.3.jar:5.3.3]
        at org.springframework.util.ResourceUtils.getURL(ResourceUtils.java:130) ~[spring-core-5.3.3.jar:5.3.3]
        at org.springframework.boot.web.embedded.tomcat.SslConnectorCustomizer.configureSslKeyStore(SslConnectorCustomizer.java:129) ~[spring-boot-2.4.2.jar:2.4.2]
        ... 16 common frames omitted
```
> **Important:**   
>   
> We are getting this message because the REST service (server) requires a keystore with the certificate of the REST service (server) to ensure that there is a secure connection with the outside world.  
>  
> To solve this, we are going to create a keystore with a public and private key for the REST service (server). The public key will be shared with users/clients so that they can encrypt the communication.  
> The communication between both parties (user and server) can be decrypted with the private key of the REST service (server).  
> The private key of the REST service (server) never must be shared and must be keep it secret, symmetrically encrypted or in a vault (i.e. PKCS#7, HSM, Hashicorp Vault).

#### 3. Generate the server certificate.   

Any Java application use [keystore](https://en.wikipedia.org/wiki/Java_KeyStore) file as repository of public-key certificates and asymmetric private keys. Then, to create a keystore with a public and private key, execute the following command in your terminal:
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

Generating 2,048 bit RSA key pair and self-signed certificate (SHA256withRSA) with a validity of 3,650 days
        for: CN=MTLS for Java Microservice, OU=DevOps Playground, O=ECS, C=UK
[Storing src/main/resources/server_identity.p12]
```

Once generated the TLS certificate, you will need to update the REST service (server) `src/main/resources/application.yml` file with the location of the keystore and symmetric passwords required for keystore itself and for private key.  
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

#### 4. Run the REST service and test the One-way TLS connection.   

```sh
mvn clean spring-boot:run
```

In other terminal execute this:
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
> **Important:**   
>   
> That means `curl` (client) can not get validated the REST service's TLS certificate because the client don't have or don't trust the CA that issued the REST service certificate.

![](../img/mtls-java-1-err-cert-authority-invalid.png)

To avoid this error, you need to get the certificate(s) of the server and store it in trusted CA certificate store in your server and/or browser.  
You can get the server certificate with the following command. Execute it from `$HOME/workdir/mtls-apps-examples/1-greeting-java`:
```sh
keytool -v \
    -exportcert \
    -file src/main/resources/server.crt \
    -alias server \
    -keystore src/main/resources/server_identity.p12 \
    -storepass secret \
    -rfc 

Certificate stored in file <src/main/resources/server.crt>
```

Now, install `src/main/resources/server.crt` in trusted CA certificate store that curl uses, once done, you will be able to call the REST service without problems.  
```sh
curl --cacert src/main/resources/server.crt \
       --capath /etc/ssl/certs/ \
        https://localhost:9443/greeting
```
Install CA certificates in the trusted CA certificate store and make available to curl requires compile curl from source code. The process is explained in below links:
* [curl website - SSL Certificate Verification](https://curl.se/docs/sslcerts.html)
* [Daniel Stenberg's blog - Get the CA Cert for curl](https://daniel.haxx.se/blog/2018/11/07/get-the-ca-cert-for-curl/)

Unfortunately curl still will show same error about `verify the legitimacy of the server` because, curl doesn't validate self-signed certificates, despite installing it in the CA certificate store. 
However, you would bypass this using Browser instead of curl.

#### 5. Testing the One-way TLS connection using Chrome Browser.   

Bypassing certificate validation is not a recommended option in many of the client libraries and applications. However, we can do it in our Browser, only for testing purposes.  
We need to get access to our REST service from a fully qualified domain name (fqdn) and if you are lucky of using a remote workstation provided by **DevOps Playground Team**, then you that is easy.  
First of all, you need to identify what is your assigned `Panda`, with that you can open this url (`https://<panda-type>.devopsplayground.org:9443/greeting`) in your browser.  
In my case the REST service is available in this URL `https://funny-panda.devopsplayground.org:9443/greeting`. See below images:

![](../img/mtls-java-1-chrome-1.png)

You will see `NET::ERR_CERT_AUTHORITY_INVALID` message, that means you have to install and trust on the CA certificate, and since our server certificate is a self-signed certificate, only the server certificate is needed. You can download it from your remote workstation or copy it directly from browser. See next image.

![](../img/mtls-java-1-chrome-2.png)   

Once downloaded the server certificate, install it in your browser. See next images to how to install the certificate in Chrome.

![](../img/mtls-java-1-chrome-3.png)   


![](../img/mtls-java-1-chrome-4.png)  

Once installed as trusted CA in your browser, reload your browser and you will see the `NET::ERR_CERT_COMMON_NAME_INVALID` message. It means you have trusted on a server certificate that doesn't match with the REST service's Domain Name. In other words, the server certificate has been generated for a REST service hosted on `localhost` and `127.0.0.1` and not on `funny-panda.devopsplayground.org`.   

![](../img/mtls-java-1-chrome-5.png)

At this point you are able to accept the risk and proceed to use the REST service. But, if you don't want it would generate a new server certificate with a proper FQDN. Only follow below steps: 

```sh
rm -rf src/main/resources/server*
```

Now, generate a new server certificate (and private key) using your assigned `Panda` (FQDN). Note this parameter `SubjectAlternativeName:c=DNS:funny-panda.devopsplayground.org,DNS:localhost,IP:127.0.0.1`:
```sh
keytool -v \
        -genkeypair \
        -dname "CN=Server Funny-Panda,OU=DevOps Playground,O=ECS,C=UK" \
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
        -ext SubjectAlternativeName:c=DNS:funny-panda.devopsplayground.org,DNS:localhost,IP:127.0.0.1
```

Get the new server certificate (`server_fqdn.crt`) to be downloaded or just copy the PEM format from your browser like you did above. 
```sh
keytool -v \
    -exportcert \
    -file src/main/resources/server_fqdn.crt \
    -alias server \
    -keystore src/main/resources/server_identity.p12 \
    -storepass secret \
    -rfc 
```

![](../img/mtls-java-1-chrome-6.png)

Once installed the new server certificate with the FQDN as a trusted CA certificate in your browser, reload the REST service `Ctrl + C` and `mvn clean spring-boot:run`, open a Chrome incognito window with the REST service URL and you will not see any error message anymore.

![](../img/mtls-java-1-chrome-7.png)


### III) Enabling Mutual TLS Authentication (Two-way TLS)

The configuration of MTLS (Two-way TLS) in the server will require a new certificate for the authentication of the client. 
This configuration will force the client (curl, your browser or any proper HTTP client) to identify itself using a certificate, and in that way, the server (REST service) 
can also validate the identity of the client and whether or not it is a trusted one. 
You can get this by configuring the server (REST service) that you also want to validate the client with the property `client-auth` in the `src/main/resources/application.yml` file.   

#### 1. Update the REST service (server) properties in `src/main/resources/application.yml`. 


Update `nano src/main/resources/application.ym` with below configuration:

```yaml
server:
  port: 9443
  ssl:
    enabled: true
    key-store: classpath:server_identity.p12
    key-password: secret
    key-store-password: secret
    client-auth: need                             ## require client authn
``` 

#### 2. Restart the REST service and check the MTLS configuration.   

Check if you have `server_identity.p12` and `server.crt` or `server_fqdn.crt`.
```sh
ll src/main/resources/
```

Clean and run the server.
```sh
mvn clean spring-boot:run
```

In other terminal execute curl. Using `server.crt `or `server_fqdn.crt` doesn't matter because we are going to use the `-k` flag to avoid the hostname validation, which is not the purpose of this step.
```sh
curl -k --cacert src/main/resources/server_fqdn.crt https://localhost:9443/greeting

curl: (56) OpenSSL SSL_read: error:14094412:SSL routines:ssl3_read_bytes:sslv3 alert bad certificate, errno 0
```

Running the curl client will fail with the following error message: `error:14094412:SSL routines:ssl3_read_bytes:sslv3 alert bad certificate, errno 0`.   
This indicates that the certificate of the client is not valid because there is no certificate at all. So, let's create one.

#### 3. Generating a client certificate.  

We are going to use ``Java KeyTool` to create a new client self-signed certificate. Use the following command:

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

> The above command will not add the `SubjectAlternativeName` attribute to the client certificate (`-ext SubjectAlternativeName:c=DNS:<client-fqdn>,IP:<client-ip-address>`) because the client (curl or browser) will be executed in the same host where the REST service is running. But if you want to execute the client (curl or browser) from different host, you could set a `SubjectAlternativeName` attribute with a `fqdn`, `hostname` or `IP address` what the REST service (server) can resolve and validate without issues.   
> You can simulate this behaviour when running the client and server in the same host, only you have to add as client's hostname and server's hostname to the `/etc/hosts` file.

Once the `client_identity.p12` (private key and public key certificate) has been generated, we must tell the server about which root and intermediate certificates to trust. This is done creating a `truststore` containing all those trusted certificates. We can get the client certificate extracting it from previously generated `client_identity.p12`.

#### 4. Extract the client certificate from `client_identity.p12`.  

The `client_identity.p12` file containts the key-pair (private and public key) and the public key certificate. We need run the below command to get only the publick key certificate.
```sh
keytool -v \
        -exportcert \
        -file src/main/resources/client.crt \
        -alias client \
        -keystore src/main/resources/client_identity.p12 \
        -storepass secret \
        -rfc 
```

#### 5. Create the server `truststore` with the client certificate.   

The `truststore`, in `JKS` format, file must contain all certificates that are trusted, and since we have 2 self-signed certificates (client and server) in this Lab, the `truststore` will be the same for the client and server.
```sh
keytool -v \
        -importcert \
        -file src/main/resources/client.crt \
        -alias client \
        -keystore src/main/resources/server_truststore.jks \
        -storepass secret \
        -noprompt
```

#### 6. Update the server `src/main/resources/application.yml` file to be aware of `server_truststore.jks`.   

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

#### 7. Get the client private key in PEM format. 

> Since `cURL` only sopports `PEM`, `DER` and `ENG` and all `*.crt` files in format `PEM` and doesn't support `Java KeyStore` files containing key material (`*.jks`). We need to extract the client private key in `PEM` format from `client_identity.p12` file.
> Only if that is the case, we need to convert the `JKS` to ``PKCS12` and then extract the private key from the `PKCS12`. 
> Then, the next `keytool` command only is necessary if the previous `Java KeyStore` file was created in `JKS` format. In our case all `Java KeyStore` files were create with the `-deststoretype PKCS12` flag, so that **next command is not necessary**.   

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

Get the `PEM` file from `client_identity.p12` that holds only the client private key.
```sh
openssl pkcs12 \
          -in src/main/resources/client_identity.p12 \
          -out src/main/resources/client_identity.pem \
          -passin pass:secret \
          -passout pass:secret \
          -nocerts
```

#### 8. Finally, you are able to call to the REST service to test MTLS.   

Restart the server:
```sh
mvn clean spring-boot:run
```

In other terminal execute curl.
```sh
curl --cacert src/main/resources/server_fqdn.crt \
       --key src/main/resources/client_identity.pem \
       --cert src/main/resources/client.crt \
       https://localhost:9443/greeting

Enter PEM pass phrase:

curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.haxx.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

The above error happens because the server certificate's SAN doesn't match the REST service's domain name. Lets bypass this error for a moment and use `-k` flag to check if the REST service and MTLS are working.

```sh
curl -k --cacert src/main/resources/server_fqdn.crt \
       --key src/main/resources/client_identity.pem \
       --cert src/main/resources/client.crt \
       https://localhost:9443/greeting

Enter PEM pass phrase:

{"id":2,"content":"Hello, World!"}
```

#### 9. Testing MTLS using the Client PKCS12 (key-pair).  

To take advantage of `--cert <certificate[:password]>` flag and avoid prompt for the private key's passphrase, we could generate a `PKCS12` file in `PEM` format with a passphrase containing the certificate and use all together according the previous flag (`--cert <certificate[:password]>`). To use it, only follow the next command:

```sh
openssl pkcs12 \
          -in src/main/resources/client_identity.p12 \
          -out src/main/resources/client_identity.pem \
          -passin pass:secret \
          -passout pass:secret
```

Finally, execute curl again passing the passphrase using the aforementioned flag `--cert <certificate[:password]>`:   
```sh
curl -k --cacert src/main/resources/server_fqdn.crt \
       --cert src/main/resources/client_identity.pem:secret \
       https://localhost:9443/greeting
```
   
```json
{"id":3,"content":"Hello, World!"}
```

#### 10. MTLS from the browser.   

Fist of all, download `server_fqdn.crt` and `client_identity.p12`, and install both in the Certificate Store of your Browser. Installing the `server_fqdn.crt` we are trusting in the server, while installing the `client_identity.p12` using its passphrase we are certifying that we are the only ones who have the identity of the client.

To download both files you can use the Code-Server (Web IDE based on VS Code). See below image:

![](../img/mtls-java-1-vs-code-server.png)

Now, we are ready to call the REST service with MTLS (Two-way TLS) through our browser and using a FQDN.

![](../img/mtls-java-1-chrome-fqdn-2-way-1.png)

You will immediately be asked to select your client identity (`client_identity.p12` file that you previously installed)

![](../img/mtls-java-1-chrome-fqdn-2-way-2.png)

![](../img/mtls-java-1-chrome-fqdn-2-way-3.png)

![](../img/mtls-java-1-chrome-fqdn-2-way-4.png)


**Observation:**   
By default, Chrome and Firefox can not stablish TLS truested communication with servers using certificates in localhost or running in your own LAN, however Chrome does have a flag for allowing untrusted certificates from the localhost origin. This option is available from the `chrome://flags/#allow-insecure-localhost` page. Once enabled, install in your browser the client PKCS12 file (`src/main/resources/client_identity.p12`) which contains the public-key certificate and private key protected by the `secret`, passphrase, and open the REST service `https://localhost:9443/greeting`. The browser will prompt to select the client identity to use during Mutual TLS authentication.

![](../img/mtls-java-1-allow-insecure-localhost-in-chrome.png)  

## References

* https://spring.io/guides/gs/rest-service/