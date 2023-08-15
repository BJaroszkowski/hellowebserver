FROM bombardier:base

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN bash ./scripts/build

CMD ["./tmp/helloworld", "-p 8000"]