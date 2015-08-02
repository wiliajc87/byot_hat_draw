require 'sinatra'
require 'erb'

get '/' do
  "Never tell me the odds!"
end

get '/results' do
  "Results page."
end

get '/form' do
  erb :form
end

post '/form' do
  params[:director].each do |i|
    i
  end
end