FROM ruby:2.2-slim

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get upgrade -y \
	&& apt-get install -y --no-install-recommends \
		nodejs \
		build-essential \
	&& rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash rails

USER rails

VOLUME /home/rails/app

WORKDIR /home/rails/app