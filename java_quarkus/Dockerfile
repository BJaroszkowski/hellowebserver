FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && \
    curl -Ls https://sh.jbang.dev | bash -s - trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/ && \
    curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio

COPY ./helloworld /helloworld
WORKDIR /helloworld
ENV PATH=${PATH}:/root/.jbang/bin

RUN quarkus build

CMD ["bash", "-c", "quarkus run -Ddebug=false"]
