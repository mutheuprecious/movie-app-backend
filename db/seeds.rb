require 'pry'
require 'rest-client'
require 'json'
# require 'awesome_print'
puts "🌱 Seeding spices..."

# Seed your database here
# example for the seeding database using an API
#response= RestClient.get "whatever the url is goes here"
# variable_for_the_response=JSON.parse(response)
# once we get the response in JSON we can work with our json data 
# for eg we can do variable_for_the_response["some_attribute"]
# to get the value of that attribute from the json hash
# we can also get the keys using variable_for_the_response.keys
# so our example is as follows let's say we want to get certain values of an hash
# defined by the different paths


# we would need different links for api links in our database seeding
#may be with different tables and models for each category


# let's get all the urls that we will need 
# USER SEEDS
users = [
  {username: "Hermione_Granger"},
  {username: "Jon_Snow"}
]

users.each do |u|
  User.create(u)
end

# MOVIE SEEDS
movies = [
  {
    movie_name: "Harry Potter and the Sorcerer's Stone",
    movie_poster: "https://i.etsystatic.com/14042790/r/il/4d2bd6/1472004550/il_570xN.1472004550_8he8.jpg",
    movie_year: "2001"
  }
]

movies.each do |u|
  Movie.create(u)
end
 


puts "✅ Done seeding!"