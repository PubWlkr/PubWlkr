console.log("connected!")

var $genButton = $('#generate')

// generate new PubWlk on click of generate button
$genButton.on('click', function(){
	var address = $("#start").val();
	var number_stops = $("#number_stops").val();
	var radius = (parseFloat($("#radius").val()) * 1609.34)
	geocode(address, number_stops, radius);
})

// get latitude and longitude of starting point
function geocode(address, number_stops, radius){
	var addressCall = address.replace(/ /gi, "+");
	$.ajax({
		url: '/address_search/' + addressCall,
		type: 'GET'
	}).done(function (data){
		var parsedData = JSON.parse(data)
		var lat = parsedData.results[0].geometry.location.lat
		var lng = parsedData.results[0].geometry.location.lng
		barSearch(lat, lng, radius, number_stops);
	})
};

// search lat and long for nearby bars
function barSearch(lat, lng, radius, number_stops){
	$.ajax({
		url: "/places_search/" + lat + "/" + lng + "/" + radius,
		type: "GET"
	}).done(function (data){
		var parsedData = JSON.parse(data)
		var bars = parsedData.results.slice(0, parseInt(number_stops))
		debugger
	})
};

// create trip, bars, and stops
function createTrip(bars){

}







