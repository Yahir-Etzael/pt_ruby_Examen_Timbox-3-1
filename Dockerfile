# syntax=docker/dockerfile:1

FROM ubuntu:24.04

ARG RUBY_VERSION=3.3.11
ARG BUNDLER_VERSION=4.0.15

ENV DEBIAN_FRONTEND=noninteractive \
    APP_HOME=/rails \
    BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    TZ=Etc/UTC

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      autoconf \
      bison \
      build-essential \
      ca-certificates \
      curl \
      git \
      libffi-dev \
      libgdbm-dev \
      libgmp-dev \
      libncurses5-dev \
      libpq-dev \
      libreadline-dev \
      libssl-dev \
      libyaml-dev \
      pkg-config \
      postgresql-client \
      tzdata \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://cache.ruby-lang.org/pub/ruby/3.3/ruby-${RUBY_VERSION}.tar.gz" -o /tmp/ruby.tar.gz && \
    mkdir -p /tmp/ruby-src && \
    tar -xzf /tmp/ruby.tar.gz -C /tmp/ruby-src --strip-components=1 && \
    cd /tmp/ruby-src && \
    ./configure --disable-install-doc && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /tmp/ruby.tar.gz /tmp/ruby-src

RUN gem update --system && \
    gem install bundler -v "${BUNDLER_VERSION}"

WORKDIR ${APP_HOME}

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY docker/entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

COPY . .

EXPOSE 3000

ENTRYPOINT ["docker-entrypoint"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
