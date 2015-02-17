console.log("connected!")

var $genButton = $('#generate')
var allDemBars;
var address_array = []
var $iframe;
var map_url;
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
	
	
	for (var i = 0; i < bars.length; i++) {

		var address = bars[i].vicinity;
		address_array.push(address);
		var name = bars[i].name;
		var price_level = bars[i].price_level;
		var rating = bars[i].rating;
		if (bars[i].photos){
			var photo_reference = bars[i].photos[0].photo_reference;
			var pic_url = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=" + photo_reference + "&key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q";
		} else {
			var pic_url = "http://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/300px-No_image_available.svg.png"
		}
		
		var place_id = bars[i].place_id;

		domLoad(name, pic_url, address, price_level, rating, place_id)
	}
	// grab the name of the walk
	var walkName = $('#name').val();
	var $title = $("<h1>" + walkName + "</h1>")
	// empty the container div
	$("#container").empty()
	// prepend title and map
	setTimeout(function(){
		$("#container").prepend($iframe);
		$("#container").prepend($title);	
	}, 1000)
	
	buttonCreate(bars, walkName);
}


function domLoad(name, pic_url, address, price_level, rating, place_id) {
	$.ajax({ 
		url: "/details_search/" + place_id,
		type: "GET"
	}).done(function (data) {
		// append the map
		var mapStrings = address_array.map(function(address){
			return address.replace(/ /gi, "+");
		})
		var origin = mapStrings.shift();
		var destination = mapStrings.pop()
		var waypoints = mapStrings.join("|")
		map_url = "https://www.google.com/maps/embed/v1/directions?key=AIzaSyDKBnu8JwKe6sSLCuT6RK5PiCGUQbmbm_Q&origin=" + origin + "&destination=" + destination + "&waypoints=" + waypoints

    $iframe = $("<iframe width=400 height=400 frameborder='0' style='border:0' src='" + map_url + "'></iframe>")


		// append all the bars
		var parsedData = JSON.parse(data);
		var website = parsedData.result.website;
		var barDiv = $("<div id ='" + place_id + "'><h2>Name: " + name + "</h2><img width=100 height=100 src=" + pic_url + "><ul><li>" + address + "</li><li><a href='" + website + "'>" + website + "</a></li><li>Price Level: " + price_level + "</li><li>Average Rating: " + rating + "</li></ul></div>");

		$("#container").append(barDiv);
	})

}

function buttonCreate(bars, walkName){
	var $regenButton = $("<button>Regenerate PubWlk</button>")
	var $trashButton = $("<button>Trash</button>")
	var $confirmButton = $("<button>Confirm PubWlk</button>")

	// $regenButton.on('click', function(){

	// })

	$trashButton.on('click', function(){
		window.location.reload();
	})

	$confirmButton.on('click', function(){
		createTrip(bars, walkName);
	})
setTimeout(function () {
	$("#container").prepend($regenButton);
	$("#container").prepend($trashButton);
	$("#container").prepend($confirmButton);
}, 1000)

}


// create trip, bars, and stops; persist to database

function createTrip(bars, walkName){

	//create trip data
	var time = new Date();
	var tripData = {user_rating: null, completed: false, time_created: time, name: walkName, map_url: map_url}

	//create bars data
	var barsData = []
	var $barDivs = $('div')
	
	for (var i = 1; i < bars.length + 1; i++){
		var name = $barDivs[i].children[0].innerText.replace(/Name: /, "")
		var address = $barDivs[i].children[2].children[0].innerText
		var website = $barDivs[i].children[2].children[1].innerText
		var pic_url = $barDivs[i].children[1].src
		var rating = $barDivs[i].children[2].children[3].innerText.replace(/Average Rating: /, "")
		var price_level = $barDivs[i].children[2].children[2].innerText.replace(/Price Level: /, "")
		var place_id = $barDivs[i].id
		var oneBar = {name: name, address: address, website: website, pic_url: pic_url, rating: rating, price_level: price_level, place_id: place_id}
		barsData.push(oneBar);
	}

	var dbData = JSON.stringify([tripData, barsData])
	
	//ajax call with all data
	$.ajax({	
		url: '/trips',
		type: 'POST',
		data: dbData
	}).done(function (data){
		var parsedData = JSON.parse(data);
		alert(parsedData.name + " has been made!");
		$('button').remove();
	})
}



