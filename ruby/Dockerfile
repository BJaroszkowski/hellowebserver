FROM bombardier:base

RUN apt-get update && apt-get install -y dh-autoreconf zlib1g-dev libyaml-dev libssl-dev && \
    wget https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.2.tar.gz && tar -xzf ruby-3.2.2.tar.gz && \
    cd ruby-3.2.2 && ./autogen.sh && mkdir build && cd build && mkdir ~/.rubies && \
    ../configure --prefix="${HOME}/.rubies/ruby-master" --disable-install-doc && make install

ENV PATH=$PATH:/root/.rubies/ruby-master/bin
RUN gem update && gem install rails

COPY ./helloworld /helloworld
WORKDIR /helloworld

RUN bundle install

CMD ["bash", "-c", "bin/rails server -p 8000"]