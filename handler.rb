#!/usr/bin/env ruby

require 'sinatra'

set :port, 8080
set :bind, '0.0.0.0'

get '/' do
  "BASIC STUFF"
end

get '/healthcheck' do
  'OK'
end
