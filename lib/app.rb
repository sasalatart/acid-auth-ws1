require 'sinatra'
require 'sinatra/json'
require 'sinatra_more/markup_plugin'

require_relative './services/ws2_connection'

register SinatraMore::MarkupPlugin

post '/login' do
  response = WS2Connection.authenticate(params[:email], params[:image])
  status response[:status]
  json message: response[:message]
end

get '*' do
  erb :login
end
