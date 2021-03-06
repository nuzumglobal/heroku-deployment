FROM debian:jessie
LABEL maintainer='Codeship Inc., <maintainers@codeship.com>'

ENV CACHE_BUST='2018-08-24' \
    PATH="/usr/local/heroku/bin:${PATH}"

RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    git \
    bash \
    ca-certificates \
    sudo \
    curl \
    wget && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

# Install the Heroku Toolbelt and and add it to the PATH
RUN \
  wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh && \
  heroku --version && \
  apt-get clean -y && \
  heroku plugins:install heroku-builds && \
  rm -rf /var/lib/apt/lists/*

COPY deployment/scripts/ /usr/bin/
