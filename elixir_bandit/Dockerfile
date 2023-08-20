FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install unzip libncurses5 libwxbase3.0-0v5 libwxgtk3.0-gtk3-0v5 libsctp1 && \
    wget https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_25.3-1~debian~bullseye_amd64.deb && \
    dpkg -i esl-erlang_25.3-1~debian~bullseye_amd64.deb && \
    cd / && git clone --depth 1 --branch v1.15.4 https://github.com/elixir-lang/elixir.git && \
    cd elixir && make

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN export PATH=$PATH:/elixir/bin && mix deps.get

CMD ["bash", "-c", "export PATH=$PATH:/elixir/bin && mix run --no-halt lib/hello_world.ex"]