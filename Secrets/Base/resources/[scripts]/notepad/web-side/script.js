window.addEventListener("message",function(event){
	switch (event["data"]["Action"]){
		case "Open":
			$(".notepad textarea").val(event["data"]["Text"]);
			$(".notepad").css("display","block");
		break;
	}
});
/* ------------------------------------------------------------------------------------------------- */
$(document).ready(function(){
	document.onkeyup = data => {
		if (data["key"] === "Escape"){
			$.post("http://notepad/Save",JSON.stringify({ text: $(".notepad textarea").val() }));
			$(".notepad").css("display","none");
		}
	};
});