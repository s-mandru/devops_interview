#!/usr/bin/env ruby

require 'sinatra'

set :port, 8080
set :bind, '0.0.0.0'

get '/' do
  s = Time.new.to_f
  while(Time.new.to_f - s < 0.2)
    true
  end
  "BASIC SLOW STUFF"
end

get '/healthcheck' do
  'OK'
end
