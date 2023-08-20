FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install nodejs npm

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN npm install .

CMD ["bash", "-c", "npm run start"]