FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install python3-pip && python3 -m pip install flask


COPY ./helloworld /helloworld
WORKDIR /helloworld

CMD ["/bin/bash", "-c",  "python3 main.py"]