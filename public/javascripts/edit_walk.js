var ids = $('#ids').val();
var user_id = ids.split(" ")[0];
var trip_id = ids.split(" ")[1];

// disables append to URL upon AJAX call
$.ajaxSetup({'cache':true});

// Complete a trip
$checkbox = $("#checkbox")
$checkbox.on("click", function () {
	if ($("#checkbox").attr("checked") == undefined) {
		completed = false;
	}
	else {
		completed = true;
	}
	
	$.ajax({
	url: "/users/" + user_id + "/trips/" + trip_id,
	type: "PUT",
	data: JSON.stringify({completed: completed})
	}).done(function (data) {
		displayInfo(data)
	})
});

// Rate a trip
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
		// alert(parsedData.name + " has been edited!");
		if (parsedData.completed == true){
			$checkbox.attr('checked', true)
		} else {
			$checkbox.attr('checked', false)
		}
		$("p").text("Current Rating: " + parsedData.user_rating);
}




