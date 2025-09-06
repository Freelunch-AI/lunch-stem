/// Montar a imagem

//  nao esquecer de levantar o servidor do docker e deixar rodando

>> docker build -t [nome da imagem] [diretorio do Dockerfile]
ex:
>> docker build -t bruno/dockernode .

//Rodar 

// qando eu acessar a porta 3000 eu quero chamar a porta 3000 do virtual container
>> docker run -p 3000:3000 -d [nome da imagem]
ex:
>> docker run -p 3000:3000 -d bruno/dockernode

// pra ver os containers que estao rodando
>> docker ps


//docker comose é um orquestrador de containers: ele define como cada container deve se compartar dentro da nossa
aplicação

// a gente define nosso docker-compose yml que vai refletir as alteracoes que foram feitaspara o container

>> docker-compose up // pra subir essas alteracoes no container

// mas se a gente fizer isso vai dar erro pq jah tem um servidor rodando na mesma porta, o de antes
// entao temos que pusar ou remover aquele container que tava rodando:

// pra ver o ID do container
>> docker ps 

>> docker stop [ID do container]

>> docker rm [ID do container]

// agor sim a gente roda:

>>>> docker-compose up // pra subir essas alteracoes no container

// ai basicamente vai ficar  o servidor node rodando, entao pra pausar eh soh dar cntrl + c normal, que ai ele fica
soh rodando em background no container, se a gente quiser pausar esse ei da um >> docker stop [ID do container]

# pra gente connectar outro servcios( tipo banco de dados)
#  é só adicionar outros servicos no docker-compose 
#  ai agente vai ter um DockerFile pra cada serivço

# nesse exemplo só fizemos um serviço chamado app que ta levantado o node

--------------------------------------

comandos importantes:

https://medium.com/xp-inc/principais-comandos-docker-f9b02e6944cd

----------------------------------------


docker com mongodb:

https://medium.com/dockerbr/mongodb-no-docker-dd3b72c7efb7



docker ru e docker start diferenca:

This is a very important question and the answer is very simple, but fundamental:

Run: create a new container of an image, and execute the container. You can create N clones of the same image. The command is: docker run IMAGE_ID and not docker run CONTAINER_ID
enter image description here

Start: Launch a container previously stopped. For example, if you had stopped a database with the command docker stop CONTAINER_ID, you can relaunch the same container with the command docker start CONTAINER_ID, and the data and settings will be the same.

##### muito importante:

conexao mongodb com docker:

baixar imagem
>> docker pull tutum/mongodb
rodar container
>> docker run -d -p 27017:27017 -p 28017:28017 -e MONGODB_PASS="mypass" tutum/mongodb

listar containers
docker ps -a

startar container, se ele foi exitado antes
>> docker start [container id]


>> mongod
>> mongo


