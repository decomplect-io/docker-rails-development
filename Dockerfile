FROM ruby:2.2-slim

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
	&& apt-get install -y --no-install-recommends \
		nodejs \
		libxslt-dev \
		libxml2-dev \
		curl \
		build-essential \
	&& gem update \
	&& rm -rf /var/lib/apt/lists/*


VOLUME /home/rails/app

WORKDIR /home/rails/app

RUN useradd -ms /bin/bash rails

RUN chown -R rails /usr/local/bundle && chown -R rails /home/rails

USER rails

CMD ["bash"]