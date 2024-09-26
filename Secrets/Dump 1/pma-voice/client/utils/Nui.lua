local uiReady = promise.new()
function sendUIMessage(message)
	Citizen.Await(uiReady)
	SendNUIMessage(message)
end

RegisterNUICallback("uiReady",function(Data,Callback)
	uiReady:resolve(true)

	Callback("Ok")
end)