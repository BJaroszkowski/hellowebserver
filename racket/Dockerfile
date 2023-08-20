FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN cd / && wget https://download.racket-lang.org/installers/8.9/racket-8.9-src-builtpkgs.tgz && \
    tar xzfv racket-8.9-src-builtpkgs.tgz && \
    cd racket-8.9/src && ./configure && make && make install

ENV PATH=$PATH:/racket-8.9/bin
RUN raco pkg install --auto --no-docs --batch --fail-fast koyo

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN raco pkg install --auto --no-docs --batch --fail-fast helloworld/ && raco koyo dist

CMD ["bash", "-c", "./dist/bin/helloworld"]