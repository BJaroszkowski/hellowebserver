FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get install -y swi-prolog tmux

COPY helloworld.pl /helloworld/
WORKDIR /helloworld/

CMD ["bash", "-c", "tmux new -d 'swipl -s helloworld.pl' && sleep infinity"]