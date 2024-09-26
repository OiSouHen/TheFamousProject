var selectPage = "Teste Psicotécnico";
var reversePage = "Teste Psicotécnico";
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).ready(function () {
	functionPsico();

	window.addEventListener("message", function (event) {
		switch (event["data"]["action"]) {
			case "openSystem":
				$("#mainPage").css("display", "block");
				break;

			case "closeSystem":
				$("#mainPage").css("display", "none");
				break;

			case "reloadPsico":
				functionPsico();
				break;

			case "reloadAnnounce":
				functionAnunciar();
				break;
		};
	});

	document.onkeyup = function (data) {
		if (data["which"] == 27) {
			$.post("http://paramedic/closeSystem");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
$(document).on("click", "#mainMenu li", function () {
	if (selectPage != reversePage) {
		let isActive = $(this).hasClass('active');
		$('#mainMenu li').removeClass('active');
		if (!isActive) {
			$(this).addClass('active');
			reversePage = selectPage;

			$("#content").css("height", "414px");
			$("#content").css("margin", "76px 30px 30px 30px");
		};
	};
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionPsico = () => {
	selectPage = "Teste Psicotécnico";

	$('#content').html(`
		<div id="titleContent">TESTE PSICOTÉCNICO</div>
		<div id="pageLeft">
			<input class="inputPsico" id="psicoPassaporte" type="number" onKeyPress="if(this.value.length==5) return false;" value="" placeholder="Passaporte."></input>
			<button class="buttonPsico">Dar Teste Assinado</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar a carteira assinada verifique corretamente se todas as informações estão de acordo com o crime efetuado, você é responsável por todas as informações enviadas e salvas no sistema.
		</div>
	`);
};
/* ----------BUTTONPSICO---------- */
$(document).on("click", ".buttonPsico", function (e) {
	const passaporte = $('#psicoPassaporte').val()

	if (passaporte != "") {
		$.post("http://paramedic/GivePsico", JSON.stringify({
			passaporte: parseInt(passaporte)
		}));
	}
});
/* ---------------------------------------------------------------------------------------------------------------- */
const functionAnunciar = () => {
	selectPage = "Anunciar";

	$('#content').html(`
		<div id="titleContent">ANUNCIAR</div>
		<div id="pageLeft">
			<input class="inputAnnounce" id="AnnounceTitle" value="" placeholder="Título."></input>
			<input class="inputAnnounce2" id="AnnounceSeconds" type="number" onKeyPress="if(this.value.length==7) return false;" value="" placeholder="Segundos."></input>
			<textarea class="textareaAnnounce" id="AnnounceText" maxlength="500" value="" placeholder="Texto do anúncio:"></textarea>
			<button class="buttonAnnounce">Anunciar</button>
		</div>

		<div id="pageRight">
			<h2>OBSERVAÇÕES:</h2>
			<b>1:</b> Antes de enviar o anúncio verifique corretamente se todas as informações estão de acordo, você é responsável por todas as informações enviadas e salvas no sistema.<br><br>
		</div>
	`);
};
/* ----------BUTTONANNOUNCE---------- */
$(document).on("click", ".buttonAnnounce", function (e) {
	const Title = $('#AnnounceTitle').val()
	const Seconds = $('#AnnounceSeconds').val()
	const Text = $('#AnnounceText').val()

	if (Title != "" != "" && Seconds != "" && Text != "") {
		$.post("http://paramedic/Announce", JSON.stringify({
			Title: Title,
			Seconds: parseInt(Seconds),
			Text: Text
		}));
	}
});
/* ----------FORMATARNUMERO---------- */
const formatarNumero = (n) => {
	var n = n.toString();
	var r = '';
	var x = 0;

	for (var i = n.length; i > 0; i--) {
		r += n.substr(i - 1, 1) + (x == 2 && i != 1 ? '.' : '');
		x = x == 2 ? 0 : x + 1;
	}

	return r.split('').reverse().join('');
}