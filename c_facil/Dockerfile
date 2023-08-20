FROM ghcr.io/bjaroszkowski/hellowebserver:base

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN bash ./scripts/build

CMD ["./tmp/helloworld", "-p 8000"]