FROM ghcr.io/bjaroszkowski/hellowebserver:base

RUN apt-get update && apt-get -y install php

COPY helloworld.php /helloworld/
WORKDIR /helloworld

CMD ["bash", "-c", "php -S localhost:8000 helloworld.php"]