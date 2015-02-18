var ids = $('#ids').val()
var user_id = ids[0]
var trip_id = ids[2]

$checkbox = $("#checkbox")

$checkbox.on("change", function () {

	if ($checkbox.is(":checked")) {
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
		var parsedData = JSON.parse(data)
		alert(parsedData.name + " has been edited!")
		debugger
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
		var parsedData = JSON.parse(data)
		alert(parsedData.name + " has been edited!")
		debugger
	})
});

// function to render parsedData to DOM

