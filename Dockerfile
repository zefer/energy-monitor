FROM ruby:2.7.1-alpine

# Throw errors if Gemfile has been modified since Gemfile.lock.
RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle config set without "test development"
RUN bundle install

EXPOSE 9761:9761/udp

COPY . .

CMD ["ruby", "./main.rb"]
