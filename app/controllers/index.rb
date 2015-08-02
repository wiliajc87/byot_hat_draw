require 'time'
require_relative "../helpers/assigner"

get '/' do
  erb :index
end

get '/form' do
  erb :form
end

post '/form' do
  @writers = params[:show][:writers].split(", ")
  @directors = params[:show][:directors].split(", ")
  @actors = params[:show][:actors].split(", ")
  @assigner = Assigner.new(@writers.count, @writers, @directors, @actors)
  @full_cast = @assigner.run
  erb :results
end
