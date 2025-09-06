# Example 3. Using Caddy as Sidecar/Proxy for Microservices

Caddy as sidecar proxy for any kind of microservices to manage MTLS and Certificates

![](../img/mtls-caddy-sidecar-microservices-arch.png)


## Tools used

* [Caddy v2 ](https://caddyserver.com/v2)
* [SmallStep Certificates (libraries already embeded in Caddy v2)](https://github.com/smallstep/certificates)
* Docker


## Preparation

1. First of all, open __2 Browser tabs__, in first one open a [Wetty Terminal](https://github.com/chilcano/mtls-apps-examples/) and in it go to the working directory for this example. 
   ```sh
   cd $HOME/workdir/mtls-apps-examples/3-caddy-sidecar
   ```
2. In the 2nd Browser tab open [Code-Server](https://github.com/chilcano/mtls-apps-examples/). Also, you can use it as file editor, to upload and download files.
3. Make sure the owner of all files and directories under `workdir` is `$USER`, if the owner is `root` the labs will not work. You can set up a owner using this command: `sudo chown -R $USER $HOME/workdir/`


#### Caddy and Docker useful commands


Caddy can be installed as a Linux service, the [binary can be downloaded](https://caddyserver.com/download) and embedded in applications or use it in a [Docker Container](https://hub.docker.com/_/caddy). This latest option is the way we are going to use along this Lab.


| Docker commands                                   | Description     
|---                                                | ---
| docker pull caddy                                 | Download/install Caddy Docker image
| docker images                                     | Checking the downloaded Caddy docker image
| docker exec -it caddy2 ls -la /config/caddy/      | * `/config/caddy/` - It is the directory where the Caddy configuration is saved.
| docker exec -it caddy2 ls -la /data/caddy/        | * `/data/caddy/` - It is the directory where the Caddy data (certificates, CA, etc.) is saved.
| docker exec -it caddy2 ls -la /usr/share/caddy/   | * `/usr/share/caddy/` - It is the directory where the static web page is saved. 
| docker ps                                         | Checking the running Caddy docker instances  
| docker rm -f caddy1 caddy2                        | Remove recently created container instances
| docker logs -f caddy2                             | Caddy can [generate formated logs](https://caddyserver.com/docs/caddyfile/directives/log), but in this lab the Docker' stdout is enough 
| CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy2)  </br> sudo tail -f  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log \| jq '.' | Tailing the log file that is stored in the Docker engine directory
    
   

## Scenarios - steps

### I. Caddy as HTTP Proxy or Sidecar Proxy (without TLS).

We are going to configure Caddy as a Proxy (no as `file_server`) to expose Kuard ([Demo application for "Kubernetes Up and Running"](https://github.com/kubernetes-up-and-running/kuard)).

#### 1. Running Kuard

```sh
docker run -d -p 9070:8080 \
    --name kuard \
    gcr.io/kuar-demo/kuard-amd64:1
```

Check if Kuard is running:
```sh
curl http://localhost:9070/healthy
```

And from your browser, you need to use your assigned FQDN (`http://<your-panda>.devopsplayground.org:9070`), you should see this:

![](../img/mtls-3-caddy-2-kuard.png)


#### 2. Setting Caddy as reverse proxy.

We are going to use this configuration (`Caddyfile.example2`):
```sh
cat 1-basic/Caddyfile.example2
```

```sh
localhost:9080

reverse_proxy localhost:9070
```

#### 3. Running Caddy as reverse proxy.

```sh
docker run -d -p 9090:9080 \
    -v $PWD/1-basic/Caddyfile.example2:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy3 \
    caddy
```

Checking all Docker processes:
```sh
docker ps -a
```

Or displays only specified columns:
```sh
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}"

```


#### 4. Calling Kuard through Proxy.

Caddy by default enable TLS. Then, from your Wetty terminal execute next command to call Kuard on `https://localhost:9090` :
```sh
curl -ik https://localhost:9090/healthy
```

```sh
HTTP/2 502 
server: Caddy
content-length: 0
date: Sun, 07 Mar 2021 16:45:15 GMT
```

Since that Caddy is exposing Kuard over HTTPS, we are going to use this URL `https://<your-panda>.devopsplayground.org:9070`. You should see this:

![](../img/mtls-3-caddy-4-kuard-caddy-err-ssl-protocol-error.png)


Let's check the logs. In the Wetty terminal get the caddy logs to check what is happening:

```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
sudo tail -f  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq
```

You should see the below events:
```sh
[...]
{
  "log": "{\"level\":\"error\",\"ts\":1615135306.509363,\"logger\":\"http.log.error\",\"msg\":\"dial tcp 127.0.0.1:9070: connect: connection refused\",\"request\":{\"remote_addr\":\"172.17.0.1:51436\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"localhost:9090\",\"uri\":\"/healthy\",\"headers\":{\"User-Agent\":[\"curl/7.58.0\"],\"Accept\":[\"*/*\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"localhost\"}},\"duration\":0.000472143,\"status\":502,\"err_id\":\"x41mreg93\",\"err_trace\":\"reverseproxy.statusError (reverseproxy.go:783)\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T16:41:46.509521725Z"
}
```

__What is the problem?__   
* We are having `reverseproxy.statusError`, that means the Caddy container is working as proxy but it can not route the traffic to the Kuard container.
* The Caddy container is trying to route the traffic from `<your-panda>.devopsplayground.org:9090` to `localhost:9080` and from `localhost:9080` to `localhost:9070`.
* This error makes sense because Caddy and Kuard are running in the Docker Network, and hostnames like `127.0.0.1` and `localhost` are not the right IP addresses or Hostnames that docker instances have. This is the normal behaviour of running services in Docker containers, they sre running in an isolated manner. Then, to establish communication between 2 containers, we will need to do it through the Docker Network.


#### 5. Creating a Docker Network and add both containers.

We are going to create the `lab3-net` Docker Network and add `caddy3` and `kuard` containers.
```sh
docker network create lab3-net

docker network connect lab3-net caddy3

docker network connect lab3-net kuard
```

Checking the `lab3-net` Docker Network. You should see the Subnet addresses, the Gateway, the Network type and intarnal containers' IP addresses and assigned hostnames.
```sh
docker network inspect lab3-net | jq
```

And finally, you will be able to reach using internal IP address or hostname (it is the value assigned to `--name` when the container was created) to any container associated to `lab3-net` network. We can check it using `ping`:
```sh
docker exec -it caddy3 ping kuard
``` 

If you get the next information, then that means that `caddy3` and `kuard` containers are part of same Docker network and we can call our service through the proxy.
```sh 
PING kuard (172.19.0.3): 56 data bytes
64 bytes from 172.19.0.3: seq=0 ttl=64 time=0.108 ms
64 bytes from 172.19.0.3: seq=1 ttl=64 time=0.095 ms
64 bytes from 172.19.0.3: seq=2 ttl=64 time=0.093 ms
``` 


#### 6. Trying to call Kuard through Proxy.

Now, we need to do make a slight change to Caddyfile.

```sh
cat 1-basic/Caddyfile.example3
```

```sh
{
    debug
}
localhost:9080

## kuard is the docker name
## 8080 is the standard port that kuard uses (it isn't a docker port)
reverse_proxy kuard:8080
```

Redeploy the `caddy3` with above updated Caddyfile. Before, we have to remove it:

```sh
docker rm -f caddy3
```

Now, run an updated Caddy instance:
```sh
docker run -d -p 9090:9080 \
    -v $PWD/1-basic/Caddyfile.example3:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy3 \
    --net lab3-net \
    caddy
```

> __Note__ that the above command will create `caddy3` container and will add it into the `lab3-net` docker network.   

Check the `caddy3` docker logs:   
```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
```

```sh
sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq 
```

In the logs you will see that Caddy has generated a TLS certificate (and key-pair) for `caddy3` running on `localhost`, then we are ready to call the service over HTTPS.   

Let's call to `kuard` container over HTTPS through Caddy Proxy but bypassing the validation of server certificate.   
```sh
curl -ivk https://localhost:9090/healthy
```

You should see a successful response (`HTTP/2 200`) and the TLS handshake in the HTTP headers.


#### 7. Call Kuard through Proxy from a browser.

You will see the same error message you got when both containers are not part of the same Docker network, but the source of error is other.

![](../img/mtls-3-caddy-4-kuard-caddy-err-ssl-protocol-error.png)

And if you check the `caddy3` docker logs, you will see the error:   

```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
```

```sh
sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq 
```

```sh
{
  "log": "{\"level\":\"debug\",\"ts\":1615155607.5234804,\"logger\":\"http.stdlib\",\"msg\":\"http: TLS handshake error from 83.54.18.132:34204: no certificate available for 'funny-panda.devopsplayground.org'\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T22:20:07.523665941Z"
}
```
It means the Browser can not load the page because the certificate that Caddy generated doesn't match the FQDN used to call the `kuard` service.
Caddy embeds an [internal PKI only to generate internal certificates](https://github.com/smallstep/certificates) (i.e. certificate for `localhost`) and it can not establish TLS connection because that certificate was issued to `localhost`, not to your assigned FQDN (`<your-panda>.devopsplayground.org`).  
   
Then, let's update `caddy3` and get a proper certificate for your assigned FQDN. 


### II. Enabling One-way TLS.

#### 1. Update Caddyfile to use the FQDN.

Add a slight change to Caddyfile`1-basic/Caddyfile.example4`. Make sure you get the right FQDN, if not, it will fail. In my case, mine is `funny-panda.devopsplayground.org`.


```sh
cat 1-basic/Caddyfile.example4
```

```sh
{
    debug
}
## add the fqdn of your assigned remote workstation
funny-panda.devopsplayground.org:9080

reverse_proxy kuard:8080
```

#### 2. Redeploy Kuard and Caddy


Remove previous `caddy3` container.
```sh
docker rm -f caddy3
```

Redeploy the `caddy3` container.
```sh
docker run -d -p 9090:9080 -p 443:443 \
    -v $PWD/1-basic/Caddyfile.example4:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy3 \
    --net lab3-net \
    caddy
```

> __Note__ that `443` port is being used for the new `caddy3` docker instance (`-p 443:443`). That port is required for Caddy in order to get a certificate issued by Let's Encrypt or ZeroSSL through ACME protocol. The ACME protocol uses the port `80` and/or `443` ports.


#### 3. Check the Caddy logs.

Check the Caddy logs using other Wetty terminal.
```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
```

```sh
sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq 
```

You should see that Caddy has requested and got a certificate for your assigned FQDN (`<your-panda>.devopsplayground.org`):
```sh
[...]
{
  "log": "{\"level\":\"info\",\"ts\":1615159892.8294432,\"logger\":\"tls.obtain\",\"msg\":\"certificate obtained successfully\",\"identifier\":\"funny-panda.devopsplayground.org\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T23:31:32.829497212Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615159892.829536,\"logger\":\"tls.obtain\",\"msg\":\"releasing lock\",\"identifier\":\"funny-panda.devopsplayground.org\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T23:31:32.829565267Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615159892.8301756,\"logger\":\"tls\",\"msg\":\"loading managed certificate\",\"domain\":\"funny-panda.devopsplayground.org\",\"expiration\":1622932292,\"issuer_key\":\"acme-v02.api.letsencrypt.org-directory\",\"storage\":\"FileStorage:/data/caddy\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T23:31:32.830220434Z"
}
```

#### 4. Call the service through the Caddy proxy.

Call the service from Wetty using curl:   
```sh
curl https://funny-panda.devopsplayground.org:9090/healthy

ok
```

And finally, call the service from your Browser using the FQDN:   

![](../img/mtls-3-caddy-5-kuard-caddy-proxy-fqdn-ok.png)



### III. Enabling Two-way TLS (Mutual TLS authentication).

MTLS requires:   
- a client certificate (and key-pair) and be installed in the Client (Chrome or any browser) certificate store
- enable the Caddy TLS policy to require present a valid client certificate during the TLS handshake
- set the certificate chain (CA Root and Intermediate that issued the client certificate) in caddy to allow (Client Authentication) the client to establish secure communication.


#### 1. Generate a client certificate.

We are going to use the already generated client certificate and its corresponding certificate chain (root and intermediate) from previous exercise.
```sh
cd ../2-hello-go/

./openssl_gen_certs.sh cleanup

./openssl_gen_certs.sh client-lab3 secret

openssl pkcs12 -export \
    -out 4_client/certs/client-lab3.pfx \
    -inkey 4_client/private/client-lab3.key.pem \
    -in 4_client/certs/client-lab3.cert.pem \
    -passin pass:secret \
    -passout pass:secret

mkdir -p ../3-caddy-sidecar/caddy_config/custom-certs/

cp 2_intermediate/certs/ca-chain.cert.pem ../3-caddy-sidecar/caddy_config/custom-certs/.

cp 2_intermediate/certs/intermediate.cert.pem ../3-caddy-sidecar/caddy_config/custom-certs/.
```


#### 2. Update Caddyfile.

Now, let's update the Caddyfile with the right TLS policy. 

```sh
cd ../3-caddy-sidecar/

cat 1-basic/Caddyfile.mtls
```

> **Important:**   
> Change `<YOUR-PANDA>` with your assigned FQDN.  

```sh
{
    debug
}
(mTLS) {
    tls {
        client_auth {
            mode require_and_verify
            trusted_ca_cert_file /config/custom-certs/ca-chain.cert.pem
        }
    }
}

<YOUR-PANDA>.devopsplayground.org:9081 {
    reverse_proxy kuard:8080
    import mTLS
}
```


#### 3. Create a new Caddy docker instance.

We are going to create a new Caddy instance listening on `9091` port.
```sh
docker run -d -p 9091:9081 \
    -v $PWD/1-basic/Caddyfile.mtls:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy4 \
    --net lab3-net \
    caddy
```

Check the Caddy instances running:

```sh
docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}"                                                                                   
```

```sh
CONTAINER ID   NAMES         PORTS
CONTAINER ID   NAMES         PORTS
3cddf2fdcd6b   caddy4        80/tcp, 2019/tcp, 0.0.0.0:443->443/tcp, 0.0.0.0:9091->9081/tcp
97d676383330   kuard         0.0.0.0:9070->8080/tcp
7c2a9123793a   code-server   0.0.0.0:8000->8080/tcp
0cf6a764b28e   wetty         0.0.0.0:80->3000/tcp
```

#### 4. Call the service and check MTLS.

Before calling to Kuard through MTLS, curl will need to get read-only access to Kuard certificate and Root CA certificate, in order to get that, we need to grant access to curl to read these certificates. We can do it executing below command:

```sh
sudo chown -R $USER caddy_data/
```

Now, from Wetty using curl call to Kuard using this URL `https://${FQDN}:9091/`:
```sh
FQDN="funny-panda.devopsplayground.org"

curl -i --cacert caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${FQDN}/${FQDN}.crt \
       --cert ../2-hello-go/4_client/certs/client-lab3.cert.pem:secret \
       --key ../2-hello-go/4_client/private/client-lab3.key.pem \
       https://${FQDN}:9091/healthy


HTTP/2 200 
content-type: text/plain
date: Tue, 23 Mar 2021 16:57:11 GMT
server: Caddy
content-length: 2

ok
```

If you call Kuard through Caddy Proxy using a Browser you will get the below error. That is because your browser doesn't have the client certificate (and encrypted private key) and its corresponding certificate chain.

![](../img/mtls-3-caddy-6-kuard-caddy-mtls-error.png)


You can check the errors printing the logs:   
```sh
CONTAINER_ID4=$(docker inspect --format="{{.Id}}" caddy4)

sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID4}/${CONTAINER_ID4}-json.log | jq 
```

You should see these logs:
```sh
[...]
{
  "log": "{\"level\":\"info\",\"ts\":1615165875.9552908,\"msg\":\"serving initial configuration\"}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:11:15.95544693Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615166146.184904,\"logger\":\"http.stdlib\",\"msg\":\"http: TLS handshake error from 35.179.96.88:46116: EOF\"}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:15:46.185113207Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615166244.1928227,\"logger\":\"http.stdlib\",\"msg\":\"http: TLS handshake error from 83.54.18.132:39742: EOF\"}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:17:24.192993722Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615166244.2752433,\"logger\":\"http.stdlib\",\"msg\":\"http: TLS handshake error from 83.54.18.132:39744: tls: client didn't provide a certificate\"}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:17:24.275433878Z"
}
```

Then, to avoid above errors let's install the client certificate in Browser's certificate store (use Code-Server: `http://<your-panda>.devopsplayground.org:8000/`). 

![](../img/mtls-3-caddy-7-download-client-pfx.png)


Once the certificate has been installed, open from your Browser with the Kuard URL (`https://<your-panda>.devopsplayground.org:9091/`). Immediately after the server (Caddy), will ask you to select the client certificate to establish a secure communication:

![](../img/mtls-3-caddy-8-chrome-select-client-pfx.png)


![](../img/mtls-3-caddy-9-kuard-caddy-mtls-ok.png)

And finally, you should see in the `caddy4` logs the request, response and all activity over Kuard.


## References

* JSON schema generator for Caddy v2:
   - https://github.com/abiosoft/caddy-json-schema

* Caddy reverse_proxy directive:
   - https://caddyserver.com/docs/caddyfile/directives/reverse_proxy
* Using Caddy in Docker to reverse proxy to localhost apps:
   - https://caddy.community/t/using-caddy-in-docker-to-reverse-proxy-to-localhost-apps/9493
* Caddy Docker Proxy plugin:
   - https://github.com/lucaslorentz/caddy-docker-proxy