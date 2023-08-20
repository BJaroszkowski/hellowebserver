FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install python3-pip && python3 -m pip install fastapi uvicorn


COPY ./helloworld /helloworld
WORKDIR /helloworld

CMD ["/bin/bash", "-c",  "python3 -m uvicorn main:app --port 8000 --host 0.0.0.0"]