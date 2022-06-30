require 'pry'
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  
  get "/tvseries" do
    Tvseries.all.to_json
  end
  get "/tvseries/:id" do
    movie = Tvseries.find(params[:id])
    movie.to_json
  end

  get "/top_rated" do 
    TopRated.all.to_json
  end
  get "/top_rated/:id" do
    movie = TopRated.find(params[:id])
    movie.to_json
  end

  get "/movie" do
    Movie.all.to_json
  end
  get "/movie/:id" do
    movie = Movie.find(params[:id])
    movie.to_json
  end
end