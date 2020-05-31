FROM ruby:2.7.1-alpine

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle config set without "test development" && \
  bundle config --global frozen 1 && \
  bundle install

EXPOSE 9761:9761/udp

COPY . .

CMD ["ruby", "./main.rb"]
