console.log("LINKED DAWG");

$("#sign_in").on("click", function () {
	$("#login_form").attr("class", "hidden")
	$("#new_user_form").attr("class", "visible")
})




$("#log_in").on("click", function () {
	$("#new_user_form").attr("class", "hidden")
	$("#login_form").attr("class", "visible")
})



