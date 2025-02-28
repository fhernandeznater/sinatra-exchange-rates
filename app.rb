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

get("/:first_symbol") do

  @symbol = params.fetch("first_symbol")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV.fetch("EXCHANGE_KEY")}"
  @raw_response = HTTP.get(api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @currencies = @parsed_data.fetch("currencies")

  erb(:step_one)

end

get("/:first_symbol/:second_symbol") do

  @from = params.fetch("first_symbol")
  @to = params.fetch("second_symbol")

  erb(:step_two)

  @api_url="https://api.exchangerate.host/convert?access_key=#{ENV.fetch("EXCHANGE_KEY")}&from=#{@from}&to=#{@to}&amount=1"

  @raw_response = HTTP.get(@api_url)
  @raw_string = @raw_response.to_s
  @parsed_data = JSON.parse(@raw_string)
  @amount = @parsed_data.fetch("result")


end
