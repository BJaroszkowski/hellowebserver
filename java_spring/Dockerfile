FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install ca-certificates-java openjdk-17-jre openjdk-17-jdk

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN ./mvnw install

CMD ["bash", "-c", "./mvnw spring-boot:run"]
