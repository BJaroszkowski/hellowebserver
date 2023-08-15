FROM bombardier:base

RUN apt-get update && apt-get -y install python3-pip && python3 -m pip install django


COPY ./helloworld /helloworld
WORKDIR /helloworld

CMD ["/bin/bash", "-c",  "python3 manage.py runserver"]