FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get install -y default-jdk && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian all main" | tee /etc/apt/sources.list.d/sbt.list && \
    echo "deb https://repo.scala-sbt.org/scalasbt/debian /" | tee /etc/apt/sources.list.d/sbt_old.list && \
    curl -sL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x2EE0EA64E40A89B84B2DF73499E82A75642AC823" | apt-key add && \
    apt-get update && apt-get -y install sbt


COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN sbt clean compile

CMD ["bash", "-c", "sbt run"]