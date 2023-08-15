FROM bombardier:base

RUN apt-get update && apt-get -y install ghc ghc-prof cabal-install libghc-zlib-dev && cabal update

COPY . /helloworld
WORKDIR /helloworld

RUN cabal build --ghc-options=-dynamic

CMD ["bash", "-c", "cabal run --ghc-options=-dynamic"]