addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Show":
			var html = `<span id=${event["data"]["id"]} class="message" style="left: 0; top: 0;"></span>`;
			$(html).fadeIn("normal").appendTo("#webPostIt");
		break;

		case "Update":
			$(`#${event["data"]["id"]}`).css("left",event["data"]["x"] * 87 + "%").css("top",event["data"]["y"] * 100 + "%");
			$(`#${event["data"]["id"]}`).text(event["data"]["text"]);
		break;

		case "Remove":
			$(`#${event["data"]["id"]}`).fadeOut("normal",function(){ $(this).remove(); });
		break;
	}
});