console.log("LINKED DAWG");

$("#sign_in").on("click", function () {
	$(this).css("background-color", "#f79727");
	$("#log_in").css("background-color", "#c0c0c0")
	$("#login_form").attr("class", "hidden")
	$("#new_user_form").attr("class", "visible")
})




$("#log_in").on("click", function () {
	$(this).css("background-color", "#f79727");
	$("#sign_in").css("background-color", "#c0c0c0")
	$("#new_user_form").attr("class", "hidden")
	$("#login_form").attr("class", "visible")
})



