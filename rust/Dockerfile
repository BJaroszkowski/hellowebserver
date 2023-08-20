FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN wget -qO - https://sh.rustup.rs | RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/rust sh -s -- --no-modify-path -y
ENV PATH=$PATH:/opt/rust/bin
RUN rustup default stable

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN cargo build

CMD ["bash", "-c", "cargo run"]