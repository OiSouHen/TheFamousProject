window.addEventListener("message", function (event) {
	switch (event["data"]["Action"]) {
		case "Open":
			$("#Body").css("display", "block");
			break;
	}
})

$(function () {
	$("#resume").click(function () {
		Close();
	});

	$("#map").click(function () {
		$.post("https://pause/Action", JSON.stringify({ action: "ActiveMap" }))
		Close();
	});

	$("#settings").click(function () {
		$.post("https://pause/Action", JSON.stringify({ action: "Settings" }));
		Close();
	});

	$("#disconnect").click(function () {
		$.post("https://pause/Action", JSON.stringify({ action: "Disconnect" }));
		Close();
	});

	$("#link").click(function () {
		window.invokeNative("openUrl", "https://discord.gg/95mzD4v5Sg");
	});
})

function Close() {
	$("#Body").css("display", "none");
	$.post("https://pause/Close");
}

document.addEventListener("keydown", event => {
	if (event["key"] === "Escape") {
		$("#Body").css("display", "none");
		$.post("https://pause/Close");
	}
});