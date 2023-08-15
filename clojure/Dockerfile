FROM bombardier:base

RUN apt-get update && apt-get -y install leiningen

COPY ./helloworld /helloworld
WORKDIR /helloworld

CMD ["bash", "-c", "lein run"]