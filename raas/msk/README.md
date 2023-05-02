# EC2 provisioning documentation

Welcome to EC2 Provisioning documentation. This repo will deploy EC2 with VPC, SG, Subnet, ebs volume on top of your Amazon Web Services. Please follow the steps to deploy your EC2 to multiple accounts


## Deployment
First you will need to  clone the repo
```
git clone https://code.caesars-dev.com/Infra-as-a-service/share_tools.git
```


After you have cloned you can create your own configuration or apply changes to existing configuration. All configurations are stored `configurations` folder see example `configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars`
```
vim configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars
```


After you have the configuration you need to get access to EC2
```
export AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID"
export AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
```

Verify the access by running 
```
aws sts get-caller-identity
```


After you see the command is successfully finished you can go ahead and deploy it
```
source set-env.sh  configurations/TOOLS/sandbox_us-west-2_core_ec2.tfvars
terraform apply --var-file=$DATAFILE
```

Confluent Tibco EMS Source Connector Configuration refer confluent page (https://caesarsdevelopment.atlassian.net/wiki/spaces/RaaS/pages/1608417443/Confluent+Tibco+EMS+Source+Connector)
---------------------------------------------------
Introduction – Purpose of Document
The purpose of this document is to outline the procedure to configure and setup Confluent Kafka TIBCO EMS Source Connector. This Connector is used to move messages from Tibco Enterprise Messaging Service (EMS) to Confluent Cloud Kafka.


1. Install Java
      - You need to install the JAVA with version 11
            
            ```
            sudo yum install java-11
            sudo alternatives --config java
            ```    

   After executing the 'sudo alternatives --config java' command, a prompt will appear, and then select the option which has “version 11”

2. Install Confluent Kafka (Only connector package and confluent hub will be used)

            ```
            curl -O http://packages.confluent.io/archive/6.2/confluent-6.2.1.zip
            unzip confluent-6.2.1.zip
            ```

3. Install Confluent Hub Client
    - The Confluent Hub client is installed as a part of the Confluent Kafka Platform installation above, and it is located in the '/bin directory'.
    - Verify the installation by typing confluent-hub in the terminal 
            
            ```
            confluent-hub
            ```
4. Configure Connector Server
   - Add the following properties in the below /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties file.
   - Add the confluent cloud bootstrap server and port in property: bootstrap.servers
   - Add API key and secret in property: username, password
   - Add the component and connector directory in property: plugin.path

``````````````````````````````````````````````````````
####################### connect-distributed.properties ##################
bootstrap.servers=pkc-pgq85.us-west-2.aws.confluent.cloud:9092

group.id=connect-cluster
key.converter=org.apache.kafka.connect.json.JsonConverter
value.converter=org.apache.kafka.connect.json.JsonConverter
key.converter.schemas.enable=false
value.converter.schemas.enable=false

internal.key.converter=org.apache.kafka.connect.json.JsonConverter
internal.value.converter=org.apache.kafka.connect.json.JsonConverter
internal.key.converter.schemas.enable=false
internal.value.converter.schemas.enable=false

# Connect clusters create three topics to manage offsets, configs, and status
# information. Note that these contribute towards the total partition limit quota.
offset.storage.topic=connect-offsets
offset.storage.replication.factor=3
offset.storage.partitions=3

config.storage.topic=connect-configs
config.storage.replication.factor=3

status.storage.topic=connect-status
status.storage.replication.factor=3

offset.flush.interval.ms=10000

ssl.endpoint.identification.algorithm=https
sasl.mechanism=PLAIN
request.timeout.ms=20000
retry.backoff.ms=500
sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="5WPSRP6QYPMUN3NB" password="/FTgujNfYsCk56yDHFMPw3grSqmtbKi4St4cqTcT+8MBKa7/W5JSXvcBpLHLNKXd";
security.protocol=SASL_SSL

consumer.ssl.endpoint.identification.algorithm=https
consumer.sasl.mechanism=PLAIN
consumer.request.timeout.ms=20000
consumer.retry.backoff.ms=500
consumer.sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="5WPSRP6QYPMUN3NB" password="/FTgujNfYsCk56yDHFMPw3grSqmtbKi4St4cqTcT+8MBKa7/W5JSXvcBpLHLNKXd";
consumer.security.protocol=SASL_SSL

producer.ssl.endpoint.identification.algorithm=https
producer.sasl.mechanism=PLAIN
producer.request.timeout.ms=20000
producer.retry.backoff.ms=500
producer.sasl.jaas.config=org.apache.kafka.common.security.plain.PlainLoginModule required username="5WPSRP6QYPMUN3NB" password="/FTgujNfYsCk56yDHFMPw3grSqmtbKi4St4cqTcT+8MBKa7/W5JSXvcBpLHLNKXd";
producer.security.protocol=SASL_SSL

plugin.path=/home/ec2-user/confluent-6.2.1/share/java
#added to accomodate source adaptor configuration changes March 18th 2022
connector.client.config.override.policy=All

#confluent.topic=foo_confluent-command

confluent.license=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJjb250cm9sLWNlbnRlciIsIm5iNCI6IjE2Mjk5MDE5ODAiLCJtb25pdG9yaW5nIjp0cnVlLCJsaWNlbnNlVHlwZSI6IkVudGVycHJpc2UiLCJpc3MiOiJDb25mbHVlbnQiLCJpYXQiOjE2Mjk0NDI4MDAsImV4cCI6MTY2MzY1NzIwMCwiYXVkIjoiMDA2M2EwMDAwMGloZDhlQUFBIn0=.M1hRHtOlhYms_xb19Yjiu63dlLier6e7ckUKWd4T2Cj9jYRA6hSVf0a4aA16ixISlKw69Z78PKiIJQzih6mGhyztuOnFUSWTEVBHP8LxByKg6oAN561mP87Yzu-Wx0aCSbjH1S1ViB_tB248BuSav2nX2BCyK91QhTh6aKjRJDCvnfkwA5QxFXyDDD-xHQASrV8MLyEPA05W_CluGRDeD7QYnbZcUMFWyoXV1HGCNzO8_MXoJorEbuyIdYlDL4WEUWkf8x-wb8QW8vqp6gr1bT5R8VACvucwdsxJA_y_Obl4UAroeuZJekHMwTpLU_yBgWjF8ZcvxTq6-TfEooxeBA
 ``````````````````````````````````````````````````````

5. Install Tibco EMS Source Connector
     - Prerequisites - We must install the connector on every machine where the Connector will run.
     - Install the latest connector version, specify the component directory and worker config file. The worker config file will be used to connect the Connector with the Confluent Cloud.

     ```````
     confluent-hub install confluentinc/kafka-connect-tibco-source:latest --component-dir /home/ec2-user/confluent-6.2.1/share/java --worker-configs /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
    ```````
6. Install XML Transform Connector
     - Prerequisites - We must install the connector on every machine where the Connector will run.

     ```````
     confluent-hub install jcustenborder/kafka-connect-transform-xml:latest --component-dir /home/ec2-user/confluent-6.2.1/share/java --worker-configs /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
     ```````
7. Installing TIBCO JMS Client Library
   - This connector relies on a provided tibjms client JAR that is included in the TIBCO EMS installation. The connector will fail to create a connection to TIBCO EMS if we have not installed the JAR on each Connect worker node.
   
   The installation steps are:
   ---------------------------
        i. Download TIBCO Enterprise Message Service (Linux) and Unzip. 
        ii. Copy the tibco/ems/{version}/lib/tibjms.jar file into the share/java/kafka-connect-tibco-source/lib directory of our Confluent Platform installation on each worker node.

        ```````
        cp /home/ec2-user/TIB_ems-ce_10.1.0/tar/opt/tibco/ems/10.1/lib/tibjms.jar /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/lib/
       ```````
8. Installing newer versions of xjc-kafka-connect-plugin-x.x.xx.jar and kafka-connect-xml-x.x.xx.jar
   - The versions of xjc-kafka-connect-plugin-x.x.xx.jar and kafka-connect-xml-x.x.xx.jar present in at the location: /home/ec2-user/confluent-6.2.1/share/java/jcustenborder-kafka-connect-transform-xml/lib/ are old. You need to update these two jar files by downloading the xjc-kafka-connect-plugin-0.2.13.jar and kafka-connect-xml-0.2.13.jar. and replace the older version jar files with these downloaded jar files, at location: /home/ec2-user/confluent-6.2.1/share/java/jcustenborder-kafka-connect-transform-xml/lib/

9. Start Connector Server
   - Start the connector by providing the distributed properties which will connect the Connector to the Confluent cloud Kafka.

   ```````
   /home/ec2-user/confluent-6.2.1/bin/connect-distributed  /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
   ```````
 10. EMS Source Connector Configuration
     - Create a connector configuration file: tibco-source.json, and add the following configuration.

 ``````````````````````````````````````````````````````
 {
  "name": "TibcoSourceConnector",
  "config": {
    "connector.class": "io.confluent.connect.tibco.TibcoSourceConnector",
    "tasks.max": "2",
    "producer.override.batch.size": "100000",
    "producer.override.linger.ms": "10",
    "producer.override.compression.type": "lz4",
    "kafka.topic": "pdb_to_kafka",
    "tibco.url": "tcp://stgwems01g2.harrahs.org:57241,tcp://stgwems01g2.harrahs.org:57241",
    "tibco.username": "lclkafkaconn",
    "tibco.password": "raas12#",
    "jms.destination.type": "queue",
    "jms.destination.name": "HET.TEST.HAR.RAAS.PDBSYNC.SUB",
    "key.converter": "org.apache.kafka.connect.json.JsonConverter",
    "value.converter": "org.apache.kafka.connect.json.JsonConverter",
    "transforms":"extractText,xml_value",
    "transforms.extractText.type":"org.apache.kafka.connect.transforms.ExtractField$Value",
    "transforms.extractText.field":"text",
    "transforms.xml_value.type": "com.github.jcustenborder.kafka.connect.transform.xml.FromXml$Value",
    "transforms.xml_value.schema.path":"file:/home/ec2-user/schema2.xsd",
    "confluent.topic.bootstrap.servers": "pkc-pgq85.us-west-2.aws.confluent.cloud:9092",
    "confluent.topic.replication.factor": "3",
    "confluent.topic.sasl.jaas.config": "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"5WPSRP6QYPMUN3NB\" password=\"/FTgujNfYsCk56yDHFMPw3grSqmtbKi4St4cqTcT+8MBKa7/W5JSXvcBpLHLNKXd\";",
    "confluent.topic.security.protocol":"SASL_SSL",
    "confluent.topic.sasl.mechanism":"PLAIN",
    "confluent.license":"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJjb250cm9sLWNlbnRlciIsIm5iNCI6IjE2Mjk5MDE5ODAiLCJtb25pdG9yaW5nIjp0cnVlLCJsaWNlbnNlVHlwZSI6IkVudGVycHJpc2UiLCJpc3MiOiJDb25mbHVlbnQiLCJpYXQiOjE2Mjk0NDI4MDAsImV4cCI6MTY2MzY1NzIwMCwiYXVkIjoiMDA2M2EwMDAwMGloZDhlQUFBIn0=.M1hRHtOlhYms_xb19Yjiu63dlLier6e7ckUKWd4T2Cj9jYRA6hSVf0a4aA16ixISlKw69Z78PKiIJQzih6mGhyztuOnFUSWTEVBHP8LxByKg6oAN561mP87Yzu-Wx0aCSbjH1S1ViB_tB248BuSav2nX2BCyK91QhTh6aKjRJDCvnfkwA5QxFXyDDD-xHQASrV8MLyEPA05W_CluGRDeD7QYnbZcUMFWyoXV1HGCNzO8_MXoJorEbuyIdYlDL4WEUWkf8x-wb8QW8vqp6gr1bT5R8VACvucwdsxJA_y_Obl4UAroeuZJekHMwTpLU_yBgWjF8ZcvxTq6-TfEooxeBA"
  }
}  
``````````````````````````````````````````````````````
11. The below code (schema2.xsd) being referenced by tibco-source.json must be added to /home/ec2-user/. 


<?xml version="1.0" encoding="UTF-8"?>
<xsd:schema targetNamespace="" elementFormDefault="qualified" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
    <xsd:element name="PAMS_MSG">
        <xsd:complexType>
            <xsd:sequence>
                <xsd:element name="rgsx513" minOccurs="0">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="STAT" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="ACCT" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="SERN" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="RPDN" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="RQID" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="RPID" minOccurs="0" type="xsd:string"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="xref2" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="ACCT" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="XREF" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="XLAB" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="XCUR" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="DTIM" minOccurs="0" type="xsd:string"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
                <xsd:element name="gaffl" minOccurs="0" maxOccurs="unbounded">
                    <xsd:complexType>
                        <xsd:sequence>
                            <xsd:element name="AFFL" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="AAID" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="ALID" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="LINK" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="LCHN" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="PRCD" minOccurs="0" type="xsd:string"/>
                            <xsd:element name="LDAT" minOccurs="0" type="xsd:string"/>
                        </xsd:sequence>
                    </xsd:complexType>
                </xsd:element>
            </xsd:sequence>
        </xsd:complexType>
    </xsd:element>
</xsd:schema>

12. Post the connector configuration using the connector REST endpoint:

        ```````````````
        cd /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/etc
        curl -s -H "Content-Type: application/json" -X POST -d @tibco-source.json http://localhost:8083/connectors/ | jq .
        ````````````````
13. Making Connector Server a Background Service
    - To make it into a service you need drop the file confluent-kafka-connect.service attached as part of this document into /usr/lib/systemd/system as root.
    
    ```````````````
    sudo systemctl enable confluent-kafka-connect
    sudo systemctl status confluent-kafka-connect
    ```````````````
Now the adapter is fully functional.

Deleting and Reprovisioning the Source Adapter (Trouble Shooting) 
-----------------------------------------------------------------

    ```````````````
    cd /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/etc
    curl -X DELETE http://localhost:8083/connectors/TibcoSourceConnector
    curl -s -H "Content-Type: application/json" -X POST -d @TibcoSourceConnector.json http://localhost:8083/connectors/ | jq .
    ```````````````

We already configured some steps as part of user data Remaining steps for configuring Confluent Tibco EMS Source Connector
--------------------------------------------------------------------------------------------------------
1. Install Tibco EMS Source Connector

    ```````````````
    sudo su
    confluent-hub install confluentinc/kafka-connect-tibco-source:latest --component-dir /home/ec2-user/confluent-6.2.1/share/java --worker-configs /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
    ```````````````

2. Install XML Transform Connector

    ```````````````
    sudo su
    confluent-hub install jcustenborder/kafka-connect-transform-xml:latest --component-dir /home/ec2-user/confluent-6.2.1/share/java --worker-configs /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
    ```````````````

3. copy tibjms.jar to home/ec2-user/confluent-6.2.1/share/java confluentinc-kafka-connect-tibco-source/ lib/

    ```````````````
    cp /home/ec2-user/tibjms.jar /home/ec2-user/confluent-6.2.1/share/java confluentinc-kafka-connect-tibco-source/lib/
    ```````````````

4. copy jars to /home/ec2-user/confluent-6.2.1/share/java/jcustenborder-kafka-connect-transform-xml/lib/

  ```````````````
  cp /home/ec2-user/kafka-connect-xml-0.2.13.jar /home/ec2-user/confluent-6.2.1/share/java/jcustenborder-kafka-connect-transform-xml/lib/
  cp /home/ec2-user/xjc-kafka-connect-plugin-0.2.13.jar /home/ec2-user/confluent-6.2.1/share/java/jcustenborder-kafka-connect-transform-xml/lib/
  ```````````````

5. Start Connector Server

    ```````````````
    /home/ec2-user/confluent-6.2.1/bin/connect-distributed  /home/ec2-user/confluent-6.2.1/etc/kafka/connect-distributed.properties
    ```````````````

6. copy tibco-source.json file to  /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/etc/

    ```````````````
    cp tibco-source.json /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/etc/
    ```````````````
7. Post the connector configuration using the connector REST endpoint:

    ```````````````
    cd /home/ec2-user/confluent-6.2.1/share/java/confluentinc-kafka-connect-tibco-source/etc
    curl -s -H "Content-Type: application/json" -X POST -d @tibco-source.json http://localhost:8083/connectors/ | jq .
    ```````````````
8. enable services 

    ```````````````
    sudo systemctl enable confluent-kafka-connect
    sudo systemctl start confluent-kafka-connect
    sudo systemctl status confluent-kafka-connect
    ```````````````