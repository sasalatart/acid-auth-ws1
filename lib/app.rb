require 'sinatra'
require 'sinatra_more/markup_plugin'

register SinatraMore::MarkupPlugin

post '/login' do
  puts params
end

get '*' do
  erb :login
end
