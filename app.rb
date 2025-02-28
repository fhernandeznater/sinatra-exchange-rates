require "sinatra"
require "sinatra/reloader"
require 'dotenv/load'
require "http"

get("/") do
 
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currencies = @parsed_data.fetch("currencies")
  erb(:homepage)
end
