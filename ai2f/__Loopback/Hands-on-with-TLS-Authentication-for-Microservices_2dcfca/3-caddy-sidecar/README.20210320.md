# Example 3. Using Caddy as Sidecar/Proxy for Microservices

Caddy as sidecar proxy for any kind of microservices to manage MTLS and Certificates

![](../img/mtls-caddy-sidecar-microservices-arch.png)


## Tools used

* Go
* [Caddy v2 ](https://caddyserver.com/v2)
* [SmallStep Certificates (libraries already embeded in Caddy v2)](https://github.com/smallstep/certificates)
* Docker


## Preparation

Caddy can be installed as a Linux service, the [binary can be downloaded](https://caddyserver.com/download) and embedded in applications or use it in a [Docker Container](https://hub.docker.com/_/caddy). This latest option is the way we are going to use along this Lab.

#### Install Docker

If your workstation **doesn't have Docker installed and running**, please, follow these commands.

```sh
curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt -y install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker $USER
sudo systemctl enable docker
```

#### Caddy in Docker 

Once installed Docker we are ready to use Caddy. Then, lets download the Caddy docker image:  

```sh
docker pull caddy
```

Checking the downloaded Caddy docker image.
```sh
docker images
```
You will see this:
```sh
REPOSITORY             TAG       IMAGE ID       CREATED        SIZE
caddy                  latest    88588539bb90   3 hours ago    39.5MB
codercom/code-server   latest    681a48e7bf50   3 weeks ago    838MB
wettyoss/wetty         latest    06a426b25e16   4 months ago   148MB
```

## Steps

First of all, open 3 Browser tabs, in 2 of them open a [Wetty Terminal](https://github.com/chilcano/mtls-apps-examples/) and in both go to the working directory for this example. 

```sh
cd $HOME/workdir/mtls-apps-examples/3-caddy-sidecar
```

In the 3rd Browser tab open the [Code-Server](https://github.com/chilcano/mtls-apps-examples/).

Also make sure the owner of all files and directories under `workdir` is `$USER`, if the owner is `root` the labs will not work.  
You can set up a owner using this command: `sudo chown -R $USER $HOME/workdir/`


### I. Basic usage with Caddy in Docker.


#### 1. Serving static files with Caddy on HTTP.

Caddy is able to server static files and work as proxy at the same time. Lets check if Caddy using this feature: 
```sh
docker run -d -p 8001:80 \
    -v $PWD/1-basic/hola.html:/usr/share/caddy/hola.html \
    --name caddy1 \
    caddy
```

#### 2. Checking if Caddy is serving static web page.


```sh
curl -i http://localhost:8001/hola.html

HTTP/1.1 200 OK
Accept-Ranges: bytes
Content-Length: 12
Content-Type: text/html; charset=utf-8
Etag: "qpjzl3c"
Last-Modified: Sat, 06 Mar 2021 15:12:39 GMT
Server: Caddy
Date: Sat, 06 Mar 2021 15:19:21 GMT

Hola amigo!
```

And from a browser:

![](../img/mtls-3-caddy-1-chrome.png)


### II. Advanced Caddy configuration.


#### 1. Overwriting the Caddy config file

Check the Caddy configuration. 

```sh
cat 1-basic/Caddyfile.example1
```
You should see:
```sh
:80

# Set this path to your site's directory.
root * /usr/share/caddy

# Enable the static file server.
file_server
```
Above config means we are going to run a Caddy instance over the `8002` port, overwriting the Caddy config file (`/etc/caddy/Caddyfile`) and mounting `/data` and `/config` folders.

> **Recommendation:**   
> You can use the [Code-Server](https://github.com/chilcano/mtls-apps-examples/) that you opened in the 3rd Browser tab.

```sh
docker run -d -p 8002:80 \
    -v $PWD/1-basic/hola.html:/usr/share/caddy/hola.html \
    -v $PWD/1-basic/Caddyfile.example1:/etc/caddy/Caddyfile \
    --name caddy2 \
    caddy
```sh

```sh
curl http://localhost:8002/hola.html

Hola amigo!
```

#### 2. Exploring Caddy docker process.

```sh
docker exec -it caddy2 ls -la /config/caddy/

docker exec -it caddy2 ls -la /data/caddy/

docker exec -it caddy2 ls -la /usr/share/caddy/
```

* `/config/caddy/` - It is the directory where the Caddy configuration is saved.
* `/data/caddy/` - It is the directory where the Caddy data (certificates, CA, etc.) is saved.
* `/usr/share/caddy/` - It is the directory where the static web page is saved.
All above directories can be mounted.  

Caddy can [generate formated logs](https://caddyserver.com/docs/caddyfile/directives/log), but in this lab the Docker' stdout is enough:
```sh
docker logs -f caddy2
```
  
Or tail the log file is stored in the Docker engine directory.
```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy2)
sudo tail -f  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq '.'
```

#### 3. Checking the running Caddy docker instances.

```sh
docker ps
```

Remove recently created container instances:  
```sh
docker rm -f caddy1 caddy2
```

### III. Caddy as HTTP Proxy or Sidecar Proxy.

We are going to configure Caddy as a Proxy (no as `file_server`) listening on `9080` to expose Kuard ([Demo application for "Kubernetes Up and Running"](https://github.com/kubernetes-up-and-running/kuard)) running `9070` port.

#### 1. Running Kuard

```sh
docker run -d -p 9070:8080 \
    --name kuard \
    gcr.io/kuar-demo/kuard-amd64:1
```

Now, check if Kuard is running:
```sh
curl http://localhost:9070/healthy
```

And from your browser, you need to use your assigned FQDN (`http://<your-panda>.devopsplayground.org`) in your browser, you should see this:

![](../img/mtls-3-caddy-2-kuard.png)


#### 2. Update Caddyfile to run Caddy as reverse proxy

```sh
cat 1-basic/Caddyfile.example2
```

```sh
localhost:9080

reverse_proxy localhost:9070
```

#### 3. Running Caddy as Proxy

Create these directories.
```sh
mkdir caddy_data caddy_config
```

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

#### 4. Calling Kuard through Proxy.

 From your 2nd Wetty terminal execute this:
```sh
curl -ik https://localhost:9090/healthy

HTTP/2 502 
server: Caddy
content-length: 0
date: Sun, 07 Mar 2021 16:45:15 GMT
```

From your local computer using a browser:  

![](../img/mtls-3-caddy-3-kuard-caddy-proxy.png)

Open other Wetty terminal in your remote workstation and tail the caddy logs to check what is happening:

```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
sudo tail -f  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq
```

You should see below events:
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
* The Caddy container is trying to route the traffic from `localhost:9080` to `reverse_proxy localhost:9070`.
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

After creating a Docker network, we will need to do make a slight change to `1-basic/Caddyfile.example2`.
```sh
{
    debug
}
localhost:9080

## kuard is the docker name
## 8080 is the standard port that kuard use (it isn't a docker port)
reverse_proxy kuard:8080
```

With these changes, redeploy the `caddy3` container. Before, we have to remove it:

```sh
docker rm -f caddy3
```

Now, run an updated Caddy instance:
```sh
docker run -d -p 9090:9080 \
    -v $PWD/1-basic/Caddyfile.example2:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy3 \
    --net lab3-net \
    caddy
```

You will note the above command will create `caddy3` container and will add it into the `lab3-net` docker network.  

Check the `caddy3` docker logs:   
```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
```

```sh
sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq 
```

```sh
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.6446476,\"msg\":\"using provided configuration\",\"config_file\":\"/etc/caddy/Caddyfile\",\"config_adapter\":\"caddyfile\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.644814428Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.646472,\"logger\":\"admin\",\"msg\":\"admin endpoint started\",\"address\":\"tcp/localhost:2019\",\"enforce_origin\":false,\"origins\":[\"localhost:2019\",\"[::1]:2019\",\"127.0.0.1:2019\"]}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.646537544Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.6476705,\"logger\":\"http\",\"msg\":\"enabling automatic HTTP->HTTPS redirects\",\"server_name\":\"srv0\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.64790584Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.6498604,\"logger\":\"tls.cache.maintenance\",\"msg\":\"started background certificate maintenance\",\"cache\":\"0xc0002ce310\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.649920521Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.6611228,\"logger\":\"tls\",\"msg\":\"cleaned up storage units\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.661210905Z"
}
{
  "log": "{\"level\":\"warn\",\"ts\":1615153359.7193143,\"logger\":\"pki.ca.local\",\"msg\":\"installing root certificate (you might be prompted for password)\",\"path\":\"storage:pki/authorities/local/root.crt\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.719438806Z"
}
{
  "log": "2021/03/07 21:42:39 define JAVA_HOME environment variable to use the Java trust\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.71999834Z"
}
{
  "log": "2021/03/07 21:42:39 Warning: \"certutil\" is not available, install \"certutil\" with \"apt install libnss3-tools\" or \"yum install nss-tools\" and try again\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.720045566Z"
}
{
  "log": "2021/03/07 21:42:39 certificate installed properly in linux trusts\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.751433802Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615153359.751695,\"logger\":\"http\",\"msg\":\"starting server loop\",\"address\":\"[::]:9080\",\"http3\":false,\"tls\":true}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.751762832Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615153359.7517471,\"logger\":\"http\",\"msg\":\"starting server loop\",\"address\":\"[::]:80\",\"http3\":false,\"tls\":false}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.75184962Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.7517562,\"logger\":\"http\",\"msg\":\"enabling automatic TLS certificate management\",\"domains\":[\"localhost\"]}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.751859786Z"
}
{
  "log": "{\"level\":\"warn\",\"ts\":1615153359.7523851,\"logger\":\"tls\",\"msg\":\"stapling OCSP\",\"error\":\"no OCSP stapling for [localhost]: no OCSP server specified in certificate\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.752447258Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.7525363,\"msg\":\"autosaved config\",\"file\":\"/config/caddy/autosave.json\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.752581438Z"
}
{
  "log": "{\"level\":\"info\",\"ts\":1615153359.752552,\"msg\":\"serving initial configuration\"}\n",
  "stream": "stderr",
  "time": "2021-03-07T21:42:39.752591238Z"
}
```
According the logs, Caddy has generated a TLS certificate (and key-pair) for `caddy3` running on `localhost`, then we are ready to call the service over HTTPS.   

Let's call to `kuard` container over HTTPS through Caddy Proxy but bypassing the validation of server certificate.   
```sh
curl -ivk https://localhost:9090/healthy
```

You should see this:
```sh

*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to localhost (127.0.0.1) port 9090 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Unknown (8):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Certificate (11):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, CERT verify (15):
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Finished (20):
* TLSv1.3 (OUT), TLS change cipher, Client hello (1):
* TLSv1.3 (OUT), TLS Unknown, Certificate Status (22):
* TLSv1.3 (OUT), TLS handshake, Finished (20):
* SSL connection using TLSv1.3 / TLS_AES_128_GCM_SHA256
* ALPN, server accepted to use h2
* Server certificate:
*  subject: [NONE]
*  start date: Mar  7 17:33:31 2021 GMT
*  expire date: Mar  8 05:33:31 2021 GMT
*  issuer: CN=Caddy Local Authority - ECC Intermediate
*  SSL certificate verify result: unable to get local issuer certificate (20), continuing anyway.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* Using Stream ID: 1 (easy handle 0x556b4a537600)
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
> GET /healthy HTTP/2
> Host: localhost:9090
> User-Agent: curl/7.58.0
> Accept: */*
> 
* TLSv1.3 (IN), TLS Unknown, Certificate Status (22):
* TLSv1.3 (IN), TLS handshake, Newsession Ticket (4):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection state changed (MAX_CONCURRENT_STREAMS updated)!
* TLSv1.3 (OUT), TLS Unknown, Unknown (23):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
< HTTP/2 200 
HTTP/2 200 
< content-type: text/plain
content-type: text/plain
< date: Sun, 07 Mar 2021 22:14:34 GMT
date: Sun, 07 Mar 2021 22:14:34 GMT
< server: Caddy
server: Caddy
< content-length: 2
content-length: 2

< 
* TLSv1.3 (IN), TLS Unknown, Unknown (23):
* Connection #0 to host localhost left intact

ok
```

#### 7. Call Kuard through Proxy from a browser.

You will see the same error message you got when both containers are not part of the same Docker network.   
![](../img/mtls-3-caddy-4-kuard-caddy-err-ssl-protocol-error.png)

And if you check the `caddy3` docker logs, you will see the error:   
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
It means the Chrome can not load the page because the certificate that Caddy generated doesn't match the FQDN used to call the `kuard` service.
Caddy embeds an [internal PKI only to generate internal certificates](https://github.com/smallstep/certificates) (i.e. certificate for `localhost`) and it can not establish TLS connection because that certificate was issued to `localhost`, not to your assigned FQDN (`<your-panda>.devopsplayground.org`).  
   
Then, let's update `caddy3` and get a proper certificate for your assigned FQDN. 


### IV. One-way TLS.

#### 1. Update Caddyfile to use the FQDN.

Add a slight change to `1-basic/Caddyfile.example2`. Make sure you get the right FQDN, if not, it will fail. In my case, mine is `funny-panda.devopsplayground.org`.

```sh
{
    debug
}
## replace localhost for the fqdn
funny-panda.devopsplayground.org:9080

reverse_proxy kuard:8080
```

#### 2. Redeploy Caddy.

Once updated, redeploy the `caddy3` container.
```sh
docker rm -f caddy3

docker run -d -p 9090:9080 \
    -v $PWD/1-basic/Caddyfile.example2:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy3 \
    --net lab3-net \
    caddy
```

#### 3. Check the Caddy logs.

```sh
CONTAINER_ID=$(docker inspect --format="{{.Id}}" caddy3)
```

```sh
sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID}/${CONTAINER_ID}-json.log | jq 
```

You should see this:
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

And finally, call the service from Chrome using the FQDN:   

![](../img/mtls-3-caddy-5-kuard-caddy-proxy-fqdn-ok.png)

You will see the `caddy3` is running with the IP `172.19.0.2` and `kuard` with the IP `172.19.0.3`. You can check it with this command:

```sh
docker network ls

NETWORK ID     NAME             DRIVER    SCOPE
a6d11919ae92   bridge           bridge    local
ca5966db93ae   host             host      local
d4dc72571f42   lab3-net         bridge    local
b564bb82a281   none             null      local
b52f92249fab   playground-net   bridge    local
```

```sh
docker network inspect lab3-net | jq
```

```sh
[
  {
    "Name": "lab3-net",
    "Id": "d4dc72571f42b9352fbf9161026071613e55b171e8f267341fc5966f8758ab78",
    "Created": "2021-03-07T18:53:25.85471742Z",
    "Scope": "local",
    "Driver": "bridge",
    "EnableIPv6": false,
    "IPAM": {
      "Driver": "default",
      "Options": {},
      "Config": [
        {
          "Subnet": "172.19.0.0/16",
          "Gateway": "172.19.0.1"
        }
      ]
    },
    "Internal": false,
    "Attachable": false,
    "Ingress": false,
    "ConfigFrom": {
      "Network": ""
    },
    "ConfigOnly": false,
    "Containers": {
      "8b28b69d43e9de7601a1dc54329bc483e7d83bedbc7daf61205829a328563143": {
        "Name": "kuard",
        "EndpointID": "8e8cc31f37978bf26e099aa1eeabf2ad830e2e50e7d7b26272adbdd7bb839f97",
        "MacAddress": "02:42:ac:13:00:03",
        "IPv4Address": "172.19.0.3/16",
        "IPv6Address": ""
      },
      "da9ebfad457e735443db184df79b577f94109d12fa764232fede2a17f6d1c981": {
        "Name": "caddy3",
        "EndpointID": "378c937c6064b48c72bd7de4a67cab95482aee696f025d2a7beb19ad8945c24d",
        "MacAddress": "02:42:ac:13:00:02",
        "IPv4Address": "172.19.0.2/16",
        "IPv6Address": ""
      }
    },
    "Options": {},
    "Labels": {}
  }
]
```


### V. Two-way TLS (Mutual TLS authentication).

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


#### 2. Update Caddyfile

Now, let's update the Caddyfile with the right TLS policy. 

```sh
cd ../3-caddy-sidecar/

nano 1-basic/Caddyfile.mtls
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


#### 3. Create a new Caddy docker instance

```sh
docker rm -f caddy4

docker run -d -p 9091:9081 \
    -v $PWD/1-basic/Caddyfile.mtls:/etc/caddy/Caddyfile \
    -v $PWD/caddy_data:/data \
    -v $PWD/caddy_config:/config \
    --name caddy4 \
    --net lab3-net \
    caddy
```


#### 4. Call the service and check MTLS


From Wetty using curl:
```sh
FQDN="funny-panda.devopsplayground.org"

curl --cacert caddy_data/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${FQDN}/${FQDN}.crt \
       --cert ../2-hello-go/4_client/certs/client-lab3.cert.pem:secret \
       --key ../2-hello-go/4_client/private/client-lab3.key.pem \
       https://${FQDN}:9091/healthy

```


If you call Kuard through Caddy Proxy using a Browser you will get the next error. That is because your browser doesn't have the client certificate (and encrypted private key) and its corresponding certificate chain.

![](../img/mtls-3-caddy-6-kuard-caddy-mtls-error.png)


Checking errors:   
```sh
CONTAINER_ID4=$(docker inspect --format="{{.Id}}" caddy4)

sudo tail -fn 1000  /var/lib/docker/containers/${CONTAINER_ID4}/${CONTAINER_ID4}-json.log | jq 
```

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

Then, to avoid above errors let's install the client certificate in Browser's certificate store. 

![](../img/mtls-3-caddy-7-download-client-pfx.png)


Once certificate installed, open from your Browser the Kuard URL. Immediately after the server (Caddy), will ask you to select the client certificate to establish a secure communication:

![](../img/mtls-3-caddy-8-chrome-select-client-pfx.png)


![](../img/mtls-3-caddy-9-kuard-caddy-mtls-ok.png)

And finally, you should see the `caddy4` logs:

```sh
[...]
{
  "log": "{\"level\":\"debug\",\"ts\":1615167728.540429,\"logger\":\"http.stdlib\",\"msg\":\"http: TLS handshake error from 83.54.18.132:40016: EOF\"}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:08.54063686Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615167733.9479635,\"logger\":\"http.handlers.reverse_proxy\",\"msg\":\"upstream roundtrip\",\"upstream\":\"kuard:8080\",\"request\":{\"remote_addr\":\"83.54.18.132:40018\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"funny-panda.devopsplayground.org:9091\",\"uri\":\"/\",\"headers\":{\"Sec-Fetch-User\":[\"?1\"],\"Sec-Ch-Ua\":[\"\\\"Google Chrome\\\";v=\\\"89\\\", \\\"Chromium\\\";v=\\\"89\\\", \\\";Not A Brand\\\";v=\\\"99\\\"\"],\"Sec-Ch-Ua-Mobile\":[\"?0\"],\"Accept\":[\"text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\"],\"Sec-Fetch-Mode\":[\"navigate\"],\"Dnt\":[\"1\"],\"Sec-Fetch-Site\":[\"none\"],\"Cookie\":[\"io=6hGzCUltLNnS-WsKAAAO\"],\"X-Forwarded-For\":[\"83.54.18.132\"],\"X-Forwarded-Proto\":[\"https\"],\"Cache-Control\":[\"max-age=0\"],\"Sec-Fetch-Dest\":[\"document\"],\"Accept-Encoding\":[\"gzip, deflate, br\"],\"Accept-Language\":[\"en-GB,en;q=0.9,ca;q=0.8,es;q=0.7,it;q=0.6\"],\"Upgrade-Insecure-Requests\":[\"1\"],\"User-Agent\":[\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"funny-panda.devopsplayground.org\",\"client_common_name\":\"client-lab3\",\"client_serial\":\"1049107\"}},\"duration\":0.001654184,\"headers\":{\"Date\":[\"Mon, 08 Mar 2021 01:42:13 GMT\"],\"Content-Length\":[\"2186\"],\"Content-Type\":[\"text/html\"]},\"status\":200}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:13.948090056Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615167734.0763571,\"logger\":\"http.handlers.reverse_proxy\",\"msg\":\"upstream roundtrip\",\"upstream\":\"kuard:8080\",\"request\":{\"remote_addr\":\"83.54.18.132:40018\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"funny-panda.devopsplayground.org:9091\",\"uri\":\"/static/css/bootstrap.min.css\",\"headers\":{\"User-Agent\":[\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36\"],\"Sec-Fetch-Site\":[\"same-origin\"],\"Sec-Fetch-Dest\":[\"style\"],\"X-Forwarded-For\":[\"83.54.18.132\"],\"Sec-Ch-Ua\":[\"\\\"Google Chrome\\\";v=\\\"89\\\", \\\"Chromium\\\";v=\\\"89\\\", \\\";Not A Brand\\\";v=\\\"99\\\"\"],\"Sec-Ch-Ua-Mobile\":[\"?0\"],\"Cookie\":[\"io=6hGzCUltLNnS-WsKAAAO\"],\"Referer\":[\"https://funny-panda.devopsplayground.org:9091/\"],\"Accept-Encoding\":[\"gzip, deflate, br\"],\"Accept-Language\":[\"en-GB,en;q=0.9,ca;q=0.8,es;q=0.7,it;q=0.6\"],\"X-Forwarded-Proto\":[\"https\"],\"Dnt\":[\"1\"],\"Accept\":[\"text/css,*/*;q=0.1\"],\"Sec-Fetch-Mode\":[\"no-cors\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"funny-panda.devopsplayground.org\",\"client_common_name\":\"client-lab3\",\"client_serial\":\"1049107\"}},\"duration\":0.003203312,\"headers\":{\"Accept-Ranges\":[\"bytes\"],\"Content-Length\":[\"144292\"],\"Content-Type\":[\"text/css; charset=utf-8\"],\"Last-Modified\":[\"Thu, 16 Nov 2017 22:09:48 GMT\"],\"Date\":[\"Mon, 08 Mar 2021 01:42:14 GMT\"]},\"status\":200}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:14.076453038Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615167734.0786808,\"logger\":\"http.handlers.reverse_proxy\",\"msg\":\"upstream roundtrip\",\"upstream\":\"kuard:8080\",\"request\":{\"remote_addr\":\"83.54.18.132:40018\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"funny-panda.devopsplayground.org:9091\",\"uri\":\"/static/css/styles.css\",\"headers\":{\"Sec-Fetch-Mode\":[\"no-cors\"],\"Dnt\":[\"1\"],\"Accept\":[\"text/css,*/*;q=0.1\"],\"Sec-Fetch-Site\":[\"same-origin\"],\"User-Agent\":[\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36\"],\"Accept-Language\":[\"en-GB,en;q=0.9,ca;q=0.8,es;q=0.7,it;q=0.6\"],\"Cookie\":[\"io=6hGzCUltLNnS-WsKAAAO\"],\"X-Forwarded-For\":[\"83.54.18.132\"],\"X-Forwarded-Proto\":[\"https\"],\"Sec-Ch-Ua\":[\"\\\"Google Chrome\\\";v=\\\"89\\\", \\\"Chromium\\\";v=\\\"89\\\", \\\";Not A Brand\\\";v=\\\"99\\\"\"],\"Sec-Fetch-Dest\":[\"style\"],\"Accept-Encoding\":[\"gzip, deflate, br\"],\"Sec-Ch-Ua-Mobile\":[\"?0\"],\"Referer\":[\"https://funny-panda.devopsplayground.org:9091/\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"funny-panda.devopsplayground.org\",\"client_common_name\":\"client-lab3\",\"client_serial\":\"1049107\"}},\"duration\":0.00268869,\"headers\":{\"Accept-Ranges\":[\"bytes\"],\"Content-Length\":[\"1585\"],\"Content-Type\":[\"text/css; charset=utf-8\"],\"Last-Modified\":[\"Thu, 16 Nov 2017 22:09:48 GMT\"],\"Date\":[\"Mon, 08 Mar 2021 01:42:14 GMT\"]},\"status\":200}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:14.078749455Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615167734.0877504,\"logger\":\"http.handlers.reverse_proxy\",\"msg\":\"upstream roundtrip\",\"upstream\":\"kuard:8080\",\"request\":{\"remote_addr\":\"83.54.18.132:40018\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"funny-panda.devopsplayground.org:9091\",\"uri\":\"/built/bundle.js\",\"headers\":{\"Sec-Fetch-Dest\":[\"script\"],\"Accept\":[\"*/*\"],\"Sec-Fetch-Site\":[\"same-origin\"],\"User-Agent\":[\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36\"],\"Accept-Language\":[\"en-GB,en;q=0.9,ca;q=0.8,es;q=0.7,it;q=0.6\"],\"Referer\":[\"https://funny-panda.devopsplayground.org:9091/\"],\"Accept-Encoding\":[\"gzip, deflate, br\"],\"Cookie\":[\"io=6hGzCUltLNnS-WsKAAAO\"],\"X-Forwarded-Proto\":[\"https\"],\"Sec-Ch-Ua\":[\"\\\"Google Chrome\\\";v=\\\"89\\\", \\\"Chromium\\\";v=\\\"89\\\", \\\";Not A Brand\\\";v=\\\"99\\\"\"],\"Dnt\":[\"1\"],\"X-Forwarded-For\":[\"83.54.18.132\"],\"Sec-Ch-Ua-Mobile\":[\"?0\"],\"Sec-Fetch-Mode\":[\"no-cors\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"funny-panda.devopsplayground.org\",\"client_common_name\":\"client-lab3\",\"client_serial\":\"1049107\"}},\"duration\":0.009939724,\"headers\":{\"Date\":[\"Mon, 08 Mar 2021 01:42:14 GMT\"],\"Accept-Ranges\":[\"bytes\"],\"Content-Length\":[\"340634\"],\"Content-Type\":[\"application/javascript\"],\"Last-Modified\":[\"Sun, 13 Jan 2019 00:54:37 GMT\"]},\"status\":200}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:14.087853233Z"
}
{
  "log": "{\"level\":\"debug\",\"ts\":1615167734.5236733,\"logger\":\"http.handlers.reverse_proxy\",\"msg\":\"upstream roundtrip\",\"upstream\":\"kuard:8080\",\"request\":{\"remote_addr\":\"83.54.18.132:40018\",\"proto\":\"HTTP/2.0\",\"method\":\"GET\",\"host\":\"funny-panda.devopsplayground.org:9091\",\"uri\":\"/favicon.ico\",\"headers\":{\"Dnt\":[\"1\"],\"Sec-Fetch-Site\":[\"same-origin\"],\"Cookie\":[\"io=6hGzCUltLNnS-WsKAAAO\"],\"X-Forwarded-Proto\":[\"https\"],\"X-Forwarded-For\":[\"83.54.18.132\"],\"Cache-Control\":[\"no-cache\"],\"Sec-Ch-Ua\":[\"\\\"Google Chrome\\\";v=\\\"89\\\", \\\"Chromium\\\";v=\\\"89\\\", \\\";Not A Brand\\\";v=\\\"99\\\"\"],\"Sec-Ch-Ua-Mobile\":[\"?0\"],\"Sec-Fetch-Mode\":[\"no-cors\"],\"Accept-Encoding\":[\"gzip, deflate, br\"],\"Accept-Language\":[\"en-GB,en;q=0.9,ca;q=0.8,es;q=0.7,it;q=0.6\"],\"Sec-Fetch-Dest\":[\"image\"],\"Referer\":[\"https://funny-panda.devopsplayground.org:9091/\"],\"Pragma\":[\"no-cache\"],\"User-Agent\":[\"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/89.0.4389.72 Safari/537.36\"],\"Accept\":[\"image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8\"]},\"tls\":{\"resumed\":false,\"version\":772,\"cipher_suite\":4865,\"proto\":\"h2\",\"proto_mutual\":true,\"server_name\":\"funny-panda.devopsplayground.org\",\"client_common_name\":\"client-lab3\",\"client_serial\":\"1049107\"}},\"duration\":0.00058539,\"headers\":{\"Content-Length\":[\"19\"],\"Content-Type\":[\"text/plain; charset=utf-8\"],\"X-Content-Type-Options\":[\"nosniff\"],\"Date\":[\"Mon, 08 Mar 2021 01:42:14 GMT\"]},\"status\":404}\n",
  "stream": "stderr",
  "time": "2021-03-08T01:42:14.523801552Z"
}
```


## References

* JSON schema generator for Caddy v2:
   - https://github.com/abiosoft/caddy-json-schema

* Caddy reverse_proxy directive:
   - https://caddyserver.com/docs/caddyfile/directives/reverse_proxy
* Using Caddy in Docker to reverse proxy to localhost apps:
   - https://caddy.community/t/using-caddy-in-docker-to-reverse-proxy-to-localhost-apps/9493
* Caddy Docker Proxy plugin:
   - https://github.com/lucaslorentz/caddy-docker-proxy