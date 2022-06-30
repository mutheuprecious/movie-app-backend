require 'rest-client'
require "sinatra/base"
require "sinatra/cookies"
require "json"
require "mysql2"
require 'sinatra/activerecord'

require "./models/user.rb"
require "./models/movie.rb"

ActiveRecord::Base.establish_connection adapter: 'mysql2', database: 'sinatra_db', host: 'localhost', username: 'root', password: 'Indeed@123'

class HiSinatra < Sinatra::Base
    # Lets us read and write cookies
    helpers Sinatra::Cookies
    
    # Let's us see errors
    configure :production, :development do
    enable :logging
    end
    
    get "/" do
        erb :index
    end

    post "/api/signin/:username" do
        # Check to see if username exists. If it does, log them in. If not, sign them up.
        check_user = User.where({"username": params[:username]})
        # Check to see if the user exists in the database
        if check_user[0]
            # Send the user back as a response
            check_user[0]
            # Store the existing user's id as a cookie
            cookies[:userid] = check_user[0].id         
            puts cookies
        # If no one is found with the given username
        else   
            puts params[:username]
            # Create new user
            new_user = User.create({username: params[:username]})
            # Send the new user's data as json to client
            new_user
            # Set the new user's id as a cookie
            cookies[:userid] = new_user.id
            puts cookies
        end
    end

        # Render the home page
    get "/home" do
        # Identify the logged in user
        logged_in_user = User.find(cookies[:userid])
        # Initialize the word movies to point to all the movies associated to the logged in user so we have a keyword to use in our .erb files. 
        @movies = logged_in_user.movies
        # Send the home page
        erb :home
    end

            #  Get a user's info (in this case, just their username).
    get "/api/user" do
        # Informs the server that we'd like to return json
        content_type :json
        # Send back the cookies as json
        # cookies.to_json
        logged_in_user = User.find(cookies[:userid])
        if (logged_in_user)
            # Send a JSON response with the user's info.
            logged_in_user.to_json
        else 
            # Send this json back if the user is not logged in
            {"error": "Please sign in first"}  
        end 
    end  

        # Query OMDBs API for a single movie. Return the results to the client as JSON.
    get "/api/movies/:movie" do 
        # Informs the server that we'd like to return json
        content_type :json
        # Query the omdb API with whatever movie the user searched for. 
        data = RestClient.get("https://www.omdbapi.com/?t=#{params[:movie]}&y=&plot=short&apikey=trilogy")
        puts data
        # Send the results of our query to the client
        data
    end  

    post "/api/movies/save" do 
        # Identify the logged in user
        logged_in_user = User.find(cookies[:userid])
        # Create a new movie in our db associated to the logged in user
        logged_in_user.movies << Movie.create({
            movie_name: params[:name],
            movie_poster: params[:poster],
            movie_year: params[:year]
        })
        # For our own purposes only, just so we can see the movies coming back from our db. 
        logged_in_user.movies.each do | movie |
            puts movie.id
        end
        puts "Movie saved"
    end

    get "/api/movies/user/all" do 
        # Informs the server that we'd like to return json
        content_type :json
        # The user currently logged in
        logged_in_user = User.find(cookies[:userid])
        puts logged_in_user.movies
        # Send back all their movies as JSON
        logged_in_user.movies.to_json
    end
end