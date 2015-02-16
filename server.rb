require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'active_record'
require 'mustache'
require_relative "./db/connection.rb"
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

get '/session' do
	binding.pry
	session.destroy
	redirect "/"
end

# LOG IN WITH USER INFO AND VERIFY
post '/session' do
	user = User.find_by(email: params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/users/#{user.id}"
		else
			redirect "/"
		end
end

# CREATE USER AND PERSIST IN DATABASE
post '/users' do
end

# UPDATE USER INFORMATION
put '/users/:id' do
	user = User.find(params[:id])
	authorize_user(user)
end

# DELETE USER
delete '/users/:id' do
	user = User.find(params[:id])
	authorize_user(user)
end

# SHOW ALL TRIPS FOR ONE USER
get '/users/:id' do

	user = User.find(params[:id])
	authorize_user(user)

	user_id = user.id
	trips = Trip.where(user_id: user_id).to_a
	Mustache.render(File.read("./views/users/user_trips_show.html"), user_id: user_id, trips: trips)
end

# "FORM" FOR CREATING NEW TRIP
get '/users/:id/trips/new' do
	user = User.find(params[:id])
	authorize_user(user)

	Mustache.render(File.read("./views/users/user_trip_create.html"), user_id: user.id)
end

# SHOW SPECIFIC TRIP
get '/users/:user_id/trips/:id' do
	trip = Trip.find(params[:id])
	bars = trip.bars.to_a
	user = User.find(params[:user_id])
	user_id = user.id
	authorize_user(user)

	Mustache.render(File.read("./views/users/user_trip_show.html"), user_id: user_id, trip: trip, bars: bars)
end

# EDIT FORM FOR A TRIP
get '/users/:user_id/trips/:id/edit' do
	user = User.find(params[:user_id])
	authorize_user(user)

end

# CREATE NEW TRIP AND PERSIST IN DATABASE
post '/users/:id/trips' do
	user = User.find(params[:id])
	authorize_user(user)
end

# USERS DELETE A TRIP
delete '/users/:user_id/trips/:id' do
	user = User.find(params[:user_id])
	authorize_user(user)
end

# USERS EDIT A TRIP COMPLETED BOOLEAN
put '/users/:user_id/trips/:id' do
	user = User.find(params[:user_id])
	authorize_user(user)

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
	if session[:user_id]
		trips = Trip.all.to_a
		Mustache.render(File.read("./views/trips/trips_index.html"), trips: trips, user_id: params[:session_id])
	else
		redirect "/"
	end
end

# GET SPECIFIC TRIP FROM DATABASE
get '/trips/:id' do
	if session[:user_id]
		trip = Trip.find(params[:id])
		Mustache.render(File.read("./views/trips/trip_show.html"), trip: trip)
	else
		redirect "/"
	end
end


private

def authorize_user(user)
	unless user.id == session[:user_id]
		redirect "/" and return true
	end
	return false
end