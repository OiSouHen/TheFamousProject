window.addEventListener("message",function(event){
	if (event["data"]["radar"] == true){
		$("#Top").css("display","block");
		$("#Botton").css("display","block");
	}

	if (event["data"]["radar"] == false){
		$("#Top").css("display","none");
		$("#Botton").css("display","none");
	}

	if (event["data"]["radar"] == "top"){
		$("#Top").html("<legend>RADAR DIANTEIRO</legend><c>PLACA:</c> "+ event["data"]["plate"] +"<br><c>MODELO:</c> <v>"+ event["data"]["Model"] +"</v><br><c>VELOCIDADE:</c> "+ parseInt(event["data"]["speed"]) +" MPH");
	}

	if (event["data"]["radar"] == "bot"){
		$("#Botton").html("<legend>RADAR TRASEIRO</legend><c>PLACA:</c> "+ event["data"]["plate"] +"<br><c>MODELO:</c> <v>"+ event["data"]["Model"] +"</v><br><c>VELOCIDADE:</c> "+ parseInt(event["data"]["speed"]) +" MPH");
	}
});