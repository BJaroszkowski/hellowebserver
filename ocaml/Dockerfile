FROM bombardier:base

RUN apt-get update && apt-get -y install opam && opam init --disable-sandboxing && eval $(opam env) && \
    opam install dune

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN eval $(opam env) && opam install -y . --deps-only && dune build && dune install

CMD ["bash", "-c", "eval $(opam env) && dune exec -- helloworld -port 8000"]