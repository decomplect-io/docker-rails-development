FROM ubuntu:14.04

RUN  apt-get update -y \
     && apt-get install -y --no-install-recommends \
        curl \
        software-properties-common \
        libxslt-dev \
        libxml2-dev \
        build-essential \
     && apt-add-repository ppa:brightbox/ruby-ng \
     && curl -sL https://deb.nodesource.com/setup_6.x | bash - \
     && apt-get install -y --no-install-recommends \
        ruby2.2 \
        ruby2.2-dev \
        nodejs \
     && gem install bundler \
     && gem update \
	 && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash rails

USER rails

VOLUME /home/rails/app

WORKDIR /home/rails/app

CMD ["bash"]