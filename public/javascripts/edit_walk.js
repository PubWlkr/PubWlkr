var ids = $('#ids').val()
var user_id = ids[0]
var trip_id = ids[2]

$checkbox = $("#checkbox")

$checkbox.on("click", function () {
	if (document.querySelector('#checkbox').checked == true) {
		var completed = true;
	}
	else {
		var completed = false;
	}
	
	$.ajax({
	url: "/users/" + user_id + "/trips/" + trip_id,
	type: "PUT",
	data: JSON.stringify({completed: completed})
	}).done(function (data) {
		displayInfo(data)
	})
});

$rateButton = $("#rate")

$rateButton.on("click", function () {
	var rating = parseInt($('select').val());
	$.ajax({
		url: "/users/" + user_id + "/trips/" + trip_id,
		type: "PUT",
		data: JSON.stringify({user_rating: rating})
	}).done(function (data) {
		displayInfo(data)
	})
});

// function to render parsedData to DOM
function displayInfo(data){
		var parsedData = JSON.parse(data);
		alert(parsedData.name + " has been edited!");
		debugger
		if (parsedData.completed == true){
			$checkbox.attr('checked', true)
		} else {
			$checkbox.attr('checked', false)
		}
		// $('select').val(parsedData.user_rating.toString())
		$("p").text("Current Rating: " + parsedData.user_rating);
}







