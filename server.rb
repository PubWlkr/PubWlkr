require 'sinatra'
require 'active_record'
require 'mustache'
require 'json'
require 'httparty'
require_relative "./db/connection.rb"
require_relative './lib/trip.rb'
require_relative './lib/user.rb'
require_relative './lib/bar.rb'
require_relative './lib/stop.rb'

configure do
	enable :sessions
	set :session_secret, 'secret'
end

after do
	ActiveRecord::Base.connection.close
end

# SPLASH
get '/' do
	File.read("./views/index.html")
end

# DESTROY SESSION
get '/session' do
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
	User.create({f_name: params["f_name"], l_name: params["l_name"], email: params["email"], password: params["password"]})
	redirect "/"
end

# UPDATE USER INFORMATION (INCOMPLETE)
put '/users/:id' do
	user = User.find(params[:id])
	authorize_user(user)
end

# DELETE USER (INCOMPLETE)
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
post '/trips' do
	user = User.find(session[:user_id])
	authorize_user(user)
	user_id = user.id
	attrs = JSON.parse(request.body.read)

	# TripCreator.new([trip_attrs, bars]).create

	attrs[0]["user_id"] = user_id
	trip_attrs = attrs[0]
	trip = Trip.create(trip_attrs)
	trip_id = trip.id
	attrs[1].each do |bar|
		new_bar = Bar.create(bar)
		bar_id = new_bar.id
		Stop.create({bar_id: bar_id, trip_id: trip_id, completed: false, stop_number: attrs[1].index(bar)})
	end
	trip.to_json
end

# USERS DELETE A TRIP
delete '/trips/:id' do
	trip = Trip.find(params[:id])
	trip.destroy

	redirect "/users/#{session[:user_id]}"
end

# USERS EDIT A TRIP COMPLETED BOOLEAN
put '/users/:user_id/trips/:id' do
	user = User.find(params[:user_id])
	authorize_user(user)
	trip = Trip.find(params[:id])

	attrs = JSON.parse(request.body.read)
	if attrs["completed"] != nil
		completed = attrs["completed"]
		trip.completed = completed
		trip.save
	elsif attrs["user_rating"]
		user_rating = attrs["user_rating"]
		trip.user_rating = user_rating
		trip.save
	end
	
	trip.to_json
end



# /api_calls : SEARCH FOR ADDRESS
# GET LAT LONG AS GEOCODE CALL
get '/address_search/:address' do
	address = params[:address]
	url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{address}&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q"
	response = HTTParty.get(url)
	json_response = JSON.generate(response)
end

# GET PLACES FROM GOOGLE PLACES API
get '/places_search/:lat/:lng/:radius' do
	lat = params[:lat]
	lng = params[:lng]
	radius = params[:radius]
	response = HTTParty.get("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{radius}&types=bar&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q")
	json_response = JSON.generate(response)
end

# GET WEBSITE AND MAYBE OTHER DETAILS
get '/details_search/:place_id' do
	place_id = params[:place_id]
	response = HTTParty.get("https://maps.googleapis.com/maps/api/place/details/json?placeid=#{place_id}&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q")
	json_response = JSON.generate(response)
end



# /trips
# GET ALL TRIPS FROM DATABASE
get '/trips' do
	if session[:user_id]
		user_id = User.find(session[:user_id]).id
		trips = Trip.all.to_a
		Mustache.render(File.read("./views/trips/trips_index.html"), trips: trips, user_id: user_id)
	else
		redirect "/"
	end
end

# GET SPECIFIC TRIP FROM DATABASE
get '/trips/:id' do
	if session[:user_id]
		user_id = User.find(session[:user_id]).id
		trip = Trip.find(params[:id])
		bars = trip.bars.to_a
		Mustache.render(File.read("./views/trips/trip_show.html"), trip: trip, bars: bars, user_id: user_id)
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