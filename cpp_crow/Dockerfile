FROM bombardier:base

RUN  apt-get update && apt-get -y install libboost-dev && \
    wget -O crow.deb https://github.com/CrowCpp/Crow/releases/download/v1.0%2B5/crow-v1.0+5.deb && \
    dpkg -i crow.deb

COPY ./helloworld.cpp /helloworld/
WORKDIR /helloworld

RUN g++ -pthread helloworld.cpp -o ./helloworld

CMD ["bash", "-c", "./helloworld"]