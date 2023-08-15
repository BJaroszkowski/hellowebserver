FROM bombardier:base

RUN cd / && git clone --depth=1 --branch=v1.6.14 https://github.com/nim-lang/Nim.git && \
    cd Nim && . ./build_all.sh

ENV PATH=${PATH}:/Nim/bin

COPY helloworld.nim /helloworld/
WORKDIR /helloworld

RUN nim compile helloworld.nim

CMD ["bash", "-c", "./helloworld"]