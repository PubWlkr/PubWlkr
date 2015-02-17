console.log("connected!")

var $genButton = $('#generate')
var allDemBars;
// generate new PubWlk on click of generate button
$genButton.on('click', function(){
	var address = $("#start").val();
	var number_stops = $("#number_stops").val();
	var radius = (parseFloat($("#radius_input").val()) * 1609.34)
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
		allDemBars = JSON.parse(data)
		var bars = allDemBars.results.slice(0, parseInt(number_stops))
		showTrip(bars)
	})
};

// show trip, bars, and stops (confirmation page)
function showTrip(bars) {
	$("#container").empty()
	var address_array = []
	
	for (var i = 0; i < bars.length; i++) {

		var address = bars[i].vicinity;
		address_array.push(address);
		var name = bars[i].name;
		var price_level = bars[i].price_level;
		var rating = bars[i].rating;
		var photo_reference = bars[i].photos[0].photo_reference;
		var pic_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + photo_reference + "&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q";
		var place_id = bars[i].place_id;

		cb(name, pic_url, address, price_level, rating, place_id)
		// $.ajax({
		// 	url: "/details_search/" + place_id,
		// 	type: "GET"
		// }).done(function (data) {
		// 	var parsedData = JSON.parse(data);
		// 	var website = parsedData.result.website;
		// 	var barDiv = $("<div><h2>Name: " + name + "</h2><img src=" + pic_url + "><ul><li>" + address + "</li><li>" + website + "</li><li>Price Level: " + price_level + "</li><li>Average Rating: " + rating + "</li></ul></div>");

		// 	$("#container").append(barDiv);
		// })

	}
}


function cb(name, pic_url, address, price_level, rating, place_id) {
			$.ajax({ 
			url: "/details_search/" + place_id,
			type: "GET"
		}).done(function (data) {
			var parsedData = JSON.parse(data);
			var website = parsedData.result.website;
			var barDiv = $("<div><h2>Name: " + name + "</h2><img src=" + pic_url + "><ul><li>" + address + "</li><li>" + website + "</li><li>Price Level: " + price_level + "</li><li>Average Rating: " + rating + "</li></ul></div>");

			$("#container").append(barDiv);
		})
}

		// <div>
		// 	<img src="{{pic_url}}">
		// 	<h2>{{name}}</h2>
		// 	<ul>
		// 		<li>{{address}}</li>
		// 		<li>{{website}}</li>
		// 		<li>Price Level: {{price_level}}</li>
		// 		<li>Average Rating: {{rating}}</li>
		// 	</ul>
		// </div>




// create trip, bars, and stops; persist to database
// function createTrip(bars){
// }



