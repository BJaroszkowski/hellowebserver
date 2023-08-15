FROM bombardier:base

RUN apt-get update && \
    apt-get install apt-transport-https && \
    wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-7.0

COPY ./helloworld /helloworld
WORKDIR /helloworld

CMD ["bash", "-c", "dotnet run ."]