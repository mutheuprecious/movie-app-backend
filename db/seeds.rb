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
API_KEY = "692adbc495abd05feeb8e0d517f9aa9c"
baseURL = "https://api.themoviedb.org/3"
base_image_Url = "https://image.tmdb.org/t/p/original/"
requests = {
    fetchNetflixOriginal: "/discover/tv?api_key=#{API_KEY}&with_network=213",
    fetchTrending: "/trending/all/week?api_key=#{API_KEY}&language=en-us",
    fetchTopRated: "/movie/top_rated?api_key=#{API_KEY}&language=en-US&page=1",
    fetchAction: "/discover/movie?api_key=#{API_KEY}&with_genres=28",
    fetchComedy: "/discover/movie?api_key=#{API_KEY}&with_genres=35",
    fetchHorror: "/discover/movie?api_key=#{API_KEY}&with_genres=27",
    fetchRomance: "/discover/movie?api_key=#{API_KEY}&with_genres=10749",
    fetchDocumentary: "/discover/movie?api_key=#{API_KEY}&with_genres=99",
}

requests.each do |key,value|
 response=RestClient.get "#{baseURL}#{value}"
 response_hash=JSON.parse(response)
#  binding.pry
    results=response_hash.map do |key2,value2|
    if(key2=="results")
        value2
    end
    end
 get_data=results[1]
 get_data.each do |mov|
    class_name_array=[NetflixOriginal,Trending,TopRated,Action,Comedy,Horror,Romance,Documentary]
    class_name_array.map do |c|
        if(c==Kernel.const_get(key.slice(5,16)))
        # binding.pry
        c.create(
        poster_path:mov["poster_path"],
        backdrop_path:mov["backdrop_path"],
        overview:mov["overview"],
        original_name:mov["original_name"],
        name:mov["name"],
        original_title:mov["original_title"],
        title:mov["title"]
        )
        end
    end
 end
end
 


puts "✅ Done seeding!"