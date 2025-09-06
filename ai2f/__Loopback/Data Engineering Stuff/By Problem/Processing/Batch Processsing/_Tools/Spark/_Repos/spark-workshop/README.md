##Prerequisites

Docker and docker-compose are used for running code samples:

      docker version 1.10
      docker-compose 1.6.0

For building the app, SBT is used      
      
      SBT 0.13

The application was created with Typesafe Activator

##Setting Dockerized Environment
### Creating docker-machine and launching containers

Depending on one's needs virtual machine memory could be adjusted to different value, but memory should be more than 2GB. Steps to create new 
docker-machine and launch docker images:  

      docker-machine create -d virtualbox --virtualbox-memory "8000" --virtualbox-cpu-count "4" workshop
      eval "$(docker-machine env workshop)"
      
      (!) Add "sandbox" to /etc/hosts with address of `docker-machine ip workshop`. This comes really handy when you navigate 
      UI of components through browser or when debugging the code from IDE (e.g. connecting to Cassandra or Mongo containers)  

      docker-compose up -d

After that dockerized Cassandra, MongoDB and single-node Hadoop cluster will launched. `docker ps` 
could be used for verification and getting ids of containers. After a short delay all UI components should be accessible via browser (except SparkUI).

Project build directory is linked to hadoop container and available at `/target` folder. Every time fatjar is rebuilt it is visible inside the container.

For shutting down with deletion of all the data use `docker-compose down`
      
### List of addresses
      
* NodeManager UI [http://sandbox:8042](http://sandbox:8042)
* NameNode UI [http://sandbox:50070](http://sandbox:50070)
* Spark UI [http://sandbox:4040](http://sandbox:4040)

* HDFS root directory to access from code as `hdfs://sandbox:9000`
      
##Running spark-shell with samples
To run and submit Spark Applications from this project the fatjar should be assembled via `sbt clean assembly` from the root of project dir.

Logging in to Docker container
      
      #container name could be used to login
      docker exec -ti sparkworkshop_hadoop_1 bash
      
      #or hadoop container id could be identified via docker ps
      docker exec -ti [hadoop container id] bash
      
      
Running Spark shell with fatjar in classpath will allow to execute applications right from spark-shell 
            
      spark-shell \
      --master yarn \
      --deploy-mode client \
      --executor-cores 1 \
      --num-executors 2 \
      --jars /target/spark-workshop.jar \
      --conf spark.cassandra.connection.host=cassandra
      
Before running all the example apps sample data should be generated and written to different data storage (Cassandra, Mongo and HDFS). From spark-shell:      
      
      import io.datastrophic.spark.workshop._
      SampleDataWriter.generateData(sc, sqlContext)
      
Progress of sample data generation could be observed via SparkUI at this moment. After the data is generated all the applications could be executed 
and analyzed via console output or SparkUI.
      
##List of applications

API examples provide implementation for the "naive lambda" application which reads aggregated data from campaigns data source and groups it with 
"raw" event data from events data source. After sample data is generated it is available in Json, Parquet and Bson files in HDFS (/workshop dir)
and in Cassandra and MongoDB. 

* __CassandraRDDExample__ - RDD based implementation using Cassandra as a data source: `CassandraRDDExample.run(sc)` 
* __CassandraSparkSQLExample__ - SparkSQL based implementation using `sqlContext.sql` API and Cassandra as a data source: 
`CassandraSparkSQLExample.run(sc, sqlContext)`
* __CassandraDataFrameExample__ - SparkSQL based implementation using DataFrame API and Cassandra as a data source: 
`CassandraDataFrameExample.run(sc, sqlContext)`
* __SampleWriter__ provides examples of how to access the data in all of these sources: `SampleDataWriter.generateData(sc, sqlContext)`, 
will fail if files are already present in HDFS, so cleanup or filenames change is needed) 
* __DataSourcesExample__ - provides examples of how to access the data in all of these sources: `DataSourcesExample.run(sc, sqlContext, entriesToDisplay = 10)`
* __ParametrizedApplicationExample__ - example of how Spark Applications could be parameterized. 

__ParametrizedApplicationExample__ could be submitted like that:
      
      spark-submit --class io.datastrophic.spark.workshop.ParametrizedApplicationExample \
      --master yarn \
      --deploy-mode cluster \
      --num-executors 2 \
      --driver-memory 1g \
      --executor-memory 1g \
      /target/spark-workshop.jar \
      --cassandra-host cassandra \
      --keyspace demo \
      --table event \
      --target-dir /workshop/dumps
      
      
## Data model

Through all the code samples the same Cassandra data model is used:

      
      CREATE TABLE IF NOT EXISTS $keyspace.event (
         id uuid,
         campaign_id uuid,
         event_type text,
         value bigint,
         time timestamp,
         PRIMARY KEY((id, event_type), campaign_id, time)
      )
            
      CREATE TABLE IF NOT EXISTS $keyspace.campaign (
         id uuid,
         event_type text,
         day timestamp,
         value bigint,
         PRIMARY KEY((id, event_type), day)
      )            
      
## Data cleanup
      
      #HDFS files
      docker exec -ti sparkworkshop_hadoop_1  bash 
      hadoop fs -rm -r /workshop/*
      
      #Cassandra tables
      docker exec -ti sparkworkshop_cassandra_1 cqlsh
      cqlsh> drop keyspace demo;
      
      #Mongo DB
      docker exec -ti sparkworkshop_mongo_1 mongo
      >use demo
      >db.dropDatabase()