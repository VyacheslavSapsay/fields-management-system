FROM ruby:3.3.4-slim-bullseye

ENV BUNDLER_VERSION=2.5.11

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  file \
  gnupg2 \
  curl \
  git \
  vim \
  libgeos-dev \
  proj-bin \
  libproj-dev \
  libpq-dev \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log


# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=.bundle

# Upgrade RubyGems
# RUN gem update --system

# Install the specified Bundler version
RUN gem install bundler -v "$BUNDLER_VERSION"

RUN mkdir -p /app

WORKDIR /app

COPY Gemfile* ./

# Use the specified version of Bundler for installing gems
RUN bundle _"$BUNDLER_VERSION"_ install --quiet

COPY . ./

# Ensure `rails` command is in the PATH
ENV PATH /app/bin:$PATH

# Default command to start Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
