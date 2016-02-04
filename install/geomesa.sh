ACCUMULO_HOME=/usr/local/accumulo

docker exec -it master1 git clone https://github.com/locationtech/geomesa.git && cd geomesa && \
                        mvn clean install -Dmaven.test.skip=true && \ 
                        cp geomesa-accumulo/geomesa-accumulo-distributed-runtime/target/geomesa-accumulo-distributed-runtime-1.2.0-SNAPSHOT.jar $ACCUMULO_HOME/lib/ext/ && \
                        cp ~/.m2/repository/joda-time/joda-time/2.3/joda-time-2.3.jar $ACCUMULO_HOME/lib/ext/ && cd ../ && \
                        git clone https://github.com/geomesa/geomesa-tutorials.git && cd geomesa-tutorials && \
                        mvn clean install -f geomesa-accumulo-quickstart/pom.xml -Dmaven.test.skip=true