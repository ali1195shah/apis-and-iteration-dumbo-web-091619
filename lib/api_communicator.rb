require 'rest-client'
require 'json'
require 'pry'

def get_all_the_characters
  # Fetch to all 9 pages
  all_the_characters = Array(1..9).map do |page_num|
    response_string = RestClient.get("https://www.swapi.co/api/people/?page=#{page_num}")
    response_hash = JSON.parse(response_string)
    response_hash["results"]
  end.flatten
end

def find_character_from_api(character_name)
  characters = get_all_the_characters
  characters.find do |character| 
    character["name"].downcase == character_name
  end
end

def take_film_urls_and_return_film_objects(film_urls)
  film_urls.map do |film_url|
    response_string = RestClient.get(film_url)
    response_hash = JSON.parse(response_string)
  end
end

def get_character_movies_from_api(character_name)
  #make the web request
  character_object = find_character_from_api(character_name)
  films = character_object["films"]
  film_objects = take_film_urls_and_return_film_objects(films)
  film_objects.sort_by{|film| film["episode_id"]}
  # Find luke skywalker in the list of all characters

  # Get his films from the hash as URLS

  # Do more RestClient.get actions for each of them

  # return a list of film names.
  
  # iterate over the response hash to find the collection of `films` for the given
  #   `charact er`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  films.each do |film|
    puts film["episode_id"].to_s + ": " + film["title"]
  end
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
  binding.pry
  0
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?