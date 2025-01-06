FROM ruby:3.4.1-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential \
      git \
      libmariadb-dev-compat \
      libmariadb-dev && \
    apt-get clean

WORKDIR /src

COPY ./Gemfile ./Gemfile.lock .

RUN bundle install -j4

COPY . .

EXPOSE 3000
