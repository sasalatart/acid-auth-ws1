require 'sinatra'
require 'sinatra/json'
require 'sinatra_more/markup_plugin'

register SinatraMore::MarkupPlugin

post '/login' do
  puts params
  status 200
  json message: 'Success'
end

get '*' do
  erb :login
end
