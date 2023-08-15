FROM bombardier:base

RUN apt-get update && apt-get -y install julia && julia -e 'using Pkg; Pkg.add("Genie", preserve=PRESERVE_DIRECT);'

COPY helloworld.jl /helloworld/
WORKDIR /helloworld

CMD ["bash", "-c", "julia helloworld.jl"]