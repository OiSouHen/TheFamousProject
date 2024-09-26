window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Open":
			$(".Text").html("");
			$(".Target").css("display","flex");
		break;

		case "Close":
			$(".Text").html("");
			$(".Target").css("display","none");
		break;

		case "Left":
			$(".Text").html("");
		break;

		case "Valid":
			$(".Text").html("");

			$.each(event["data"]["data"],function(index,item){
				$(".Text").append("<div id='Target-" + index + "'<li>" + item["label"] + "</li></div>");

				$("#Target-" + index).data("Target",item["event"]);
				$("#Target-" + index).data("Tunnel",item["tunnel"]);
				$("#Target-" + index).data("Service",item["service"]);
			});
		break;
	}
});
/* ------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://target/Close");
		}
	};
});
/* ------------------------------------------------------------------------------------------------- */
$(document).on("mousedown",(event) => {
	if (event["target"]["id"].split("-")[0] === "Target"){
		let Target = $("#" + event["target"]["id"]).data("Target");
		let Tunnel = $("#" + event["target"]["id"]).data("Tunnel");
		let Service = $("#" + event["target"]["id"]).data("Service");

		$.post("http://target/Select",JSON.stringify({ event: Target, tunnel: Tunnel, service: Service }));
	}
});