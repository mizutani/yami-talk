FROM ruby:2.2

WORKDIR /var/app

RUN apt-get -y update && \
    apt-get -y install nodejs libmp3lame-dev

COPY Gemfile ./

RUN bundle install

COPY . .

EXPOSE 3000
