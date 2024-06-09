FROM ruby:3.3.0 AS rails-toolbox

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /chat-system

WORKDIR /chat-system

COPY Gemfile /chat-system/Gemfile
COPY Gemfile.lock /chat-system/Gemfile.lock

RUN gem install bundler && bundle install

COPY . /chat-system

# Run a shell
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]