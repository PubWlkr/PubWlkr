require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require_relative './lib/trip.rb'
require_relative './lib/user.rb'
require_relative './lib/bar.rb'
require_relative './lib/stop.rb'

configure do
	enable :sessions
	set :session_secret, 'secret'
end

# SPLASH
get '/' do
	File.read("./views/index.html")
end

# LOG IN WITH USER INFO AND VERIFY
post '/session' do

redirect '/users/:id'
end

# CREATE USER AND PERSIST IN DATABASE
post '/users' do
end

# UPDATE USER INFORMATION
put '/users/:id' do
end

# DELETE USER
delete '/users/:id' do
end

# SHOW ALL TRIPS FOR ONE USER
get '/users/:id' do
end

# "FORM" FOR CREATING NEW TRIP
get '/users/:id/trips/new' do
end

# SHOW SPECIFIC TRIP
get '/users/:user_id/trips/:id' do
end

# CREATE NEW TRIP AND PERSIST IN DATABASE
post '/users/:id/trips' do
end

# USERS DELETE A TRIP
delete '/users/:user_id/trips/:id' do
end

# USERS EDIT A TRIP COMPLETED BOOLEAN
put '/users/:user_id/trips/:id/edit' do

end



# /api_calls : SEARCH FOR ADDRESS
# GET LAT LONG AS GEOCODE CALL
get '/address_search/:address' do
end

# GET PLACES FROM GOOGLE PLACES API
get '/places_search/:lat_long' do
end

# GET WEBSITE AND MAYBE OTHER DETAILS
get '/details_search/:place_id' do
end



# /trips
# GET ALL TRIPS FROM DATABASE
get '/trips' do
end

# GET SPECIFIC TRIP FROM DATABASE
get '/trips/:id' do
end
