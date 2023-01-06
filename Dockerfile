# Define a common target that can be used as a base for all other stages.
FROM ruby:3.1.3-alpine3.16 AS base

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apk --update --no-cache add \
  --virtual build-dependencies \
  build-base \
  ;

RUN apk --update --no-cache add \
  bash \
  libc6-compat \
  libpq-dev \
  tzdata \
  ;

RUN gem update --system && \
    gem install bundler

# Define a target suitable for running a development environment. This includes
# all libraries, gems, and node packages, and makes no effort to reduce the
# size of the final docker image.
FROM base AS development

ENV PATH="/app/bin:${PATH}"
ENV RUBOCOP_DAEMON_USE_BUNDLER=true

RUN apk --update --no-cache add \
  nodejs=~16 \
  npm \
  vim \
  ;

COPY Gemfile* $APP_HOME/
RUN bundle install

COPY . $APP_HOME/

CMD ["rails" "server"]
