# Write your soltuion here!
require "dotenv/load"
require "http"
require "json"

pirate_key = ENV.fetch("PIRATE_WEATHER_KEY")
maps_key = ENV.fetch("GMAPS_KEY")

pp "What is your street address?"
st = gets.chomp.gsub(" ", "+")
pp st
pp "Which city are you in?"
city = gets.chomp.gsub(" ", "+")
pp "Which state are you in?"
state = gets.chomp.gsub(" ", "+")

maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + st + ",+" + city + ",+" + state + "&key=" + maps_key
raw_maps = HTTP.get(maps_url)
parsed_maps = JSON.parse(raw_maps)
pp JSON.pretty_generate(parsed_maps)
lat = parsed_maps["results"][0]["geometry"]["location"]["lat"]
lng = parsed_maps["results"][0]["geometry"]["location"]["lng"]

pirate_url = "https://api.pirateweather.net/forecast/" + pirate_key + "/" + lat.to_s + "," + lng.to_s
raw_pirate = HTTP.get(pirate_url)
parsed_pirate = JSON.parse(raw_pirate)
pp parsed_pirate
temp = parsed_pirate["currently"]["temperature"]
next_hr = parsed_pirate["hourly"]["summary"]

pp "The current temperature is " + temp.to_s
pp "The weather in the next hour will be: " + next_hr
