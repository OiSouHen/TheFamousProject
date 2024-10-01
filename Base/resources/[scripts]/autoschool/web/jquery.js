// -------------------------------------------------------------------------------------------
window.addEventListener("message", function (event) {
	switch (event["data"]["Action"]) {
		case "Display":
			$("#Autoschool").css("display", event["data"]["Mode"]);
			break;

		case "Message":
			$("#Autoschool").html(event["data"]["Message"]);
			break;
	}
});