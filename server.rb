require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require_relative './lib/trip.rb'
require_relative './lib/user.rb'

configure do
	enable :sessions
	set :session_secret, 'secret'
end

# SPLASH
get '/' do
end

# LOG IN WITH USER INFO AND VERIFY
get '/users' do

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
get '/users/:id/trips' do
end

# SHOW SPECIFIC TRIP
get '/users/:id/trips/:id' do
end

# CREATE NEW TRIP AND PERSIST IN DATABASE
post '/users/:id/trips' do
end

put '/users/:id/trips/:id' do
end

delete '/users' do
end


# /trips
# GET ALL TRIPS FROM DATABASE
get '/trips' do
end

# GET SPECIFIC TRIP FROM DATABASE
get '/trips/:id' do
end