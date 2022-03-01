FROM ruby:2.7-alpine
RUN gem install --no-document sinatra

RUN mkdir /app
COPY src/handler.rb /app/
ENTRYPOINT ruby /app/handler.rb

