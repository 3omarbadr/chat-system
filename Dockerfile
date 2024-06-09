## Dockerfile
#
#FROM ruby:3.1.2
#RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
#
#WORKDIR /chat-system
#
#COPY Gemfile /chat-system/Gemfile
#COPY Gemfile.lock /chat-system/Gemfile.lock
#
#RUN gem install bundler && bundle install
#
#COPY . /chat-system
#
#CMD ["rails", "server", "-b", "0.0.0.0"]

FROM ruby:3.1.2 AS rails-toolbox

# Default directory
ENV INSTALL_PATH /opt/chat-system
RUN mkdir -p $INSTALL_PATH

# Install rails
RUN gem install rails bundler
#RUN chown -R user:user /opt/app
WORKDIR /opt/chat-system

# Run a shell
CMD ["/bin/sh"]