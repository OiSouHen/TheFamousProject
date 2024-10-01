-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADROUTE
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local TimeDistance = 1000

		if OnRoad then
			TimeDistance = 5
		end

		if Route == 1 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 214.75, 363.58, 106.23, true) > 4.0001 then
				DrawMarker(21, 214.75, 363.58, 106.23, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(237.44, 346.18, 105.56)

				FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
				TriggerEvent("Notify", "amarelo", "Verifique os dois lados da via, garanta que está livre e prossiga.", "Atenção", 5000)
				Wait(5000)
				FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)

				Area = 2
				Route = 2
				SendNUIMessage({ Action = "Message", Message = "LIMITE DE VELOCIDADE: <b>80 MPH</b>." })
			end
		end

		if Route == 2 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 237.44, 346.18, 105.56, true) > 4.0001 then
				DrawMarker(21, 237.44, 346.18, 105.56, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(549.12, 247.5, 103.11)

				FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
				TriggerEvent("Notify", "amarelo", "Não é obrigatório esperar os semafaros, porém você deve parar em todos e garantir que a via está livre para seguir.", "Atenção", 10000)
				Wait(10000)
				FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)

				Route = 3
			end
		end

		if Route == 3 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 549.12, 247.5, 103.11, true) > 4.0001 then
				DrawMarker(21, 549.12, 247.5, 103.11, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(913.36, 520.65, 120.55)
				TriggerEvent("Notify", "amarelo", "Atenção e cuidado ao atravessar esquinas.", "Atenção", 5000)
				Route = 4
			end
		end

		if Route == 4 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 913.36, 520.65, 120.55, true) > 4.0001 then
				DrawMarker(21, 913.36, 520.65, 120.55, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(1064.49, 407.65, 91.1)
				TriggerEvent("Notify", "amarelo", "Dirigir embriagado é crime.", "Atenção", 5000)
				Route = 5
			end
		end

		if Route == 5 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 1064.49, 407.65, 91.1, true) > 4.0001 then
				DrawMarker(21, 1064.49, 407.65, 91.1, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(532.59, -323.64, 43.58)
				TriggerEvent("Notify", "amarelo", "Novo limite de velocidade.", "Atenção", 5000)
				Area = 3
				Route = 7
				SendNUIMessage({ Action = "Message", Message = "LIMITE DE VELOCIDADE: <b>120 MPH</b>." })
			end
		end

		if Route == 7 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 532.59, -323.64, 43.58, true) > 4.0001 then
				DrawMarker(21, 532.59, -323.64, 43.58, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(246.92, -221.15, 54.04)
				TriggerEvent("Notify", "amarelo", "Novo limite de velocidade.", "Atenção", 5000)
				Area = 2
				Route = 8
				SendNUIMessage({ Action = "Message", Message = "LIMITE DE VELOCIDADE: <b>80 MPH</b>." })
			end
		end

		if Route == 8 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 246.92, -221.15, 54.04, true) > 4.0001 then
				DrawMarker(21, 246.92, -221.15, 54.04, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(-57.2, -103.0, 57.8)
				TriggerEvent("Notify", "amarelo", "É proíbido estacionar em áreas cuja uma faixa vermelha está pintada na calçada.", "Atenção", 5000)
				Route = 9
			end
		end

		if Route == 9 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -57.2, -103.0, 57.8, true) > 4.0001 then
				DrawMarker(21, -57.2, -103.0, 57.8, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(-40.29, 18.62, 72.01)
				TriggerEvent("Notify", "amarelo", "Novo limite de velocidade.", "Atenção", 5000)
				Area = 1
				Route = 10
				SendNUIMessage({ Action = "Message", Message = "LIMITE DE VELOCIDADE: <b>60 MPH</b>." })
			end
		end

		if Route == 10 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -40.29, 18.62, 72.01, true) > 4.0001 then
				DrawMarker(21, -40.29, 18.62, 72.01, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(30.87, 233.73, 109.55)
				TriggerEvent("Notify", "amarelo", "Transitar com veículos danificados é crime.", "Atenção", 5000)
				Route = 11
			end
		end

		if Route == 11 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 30.87, 233.73, 109.55, true) > 4.0001 then
				DrawMarker(21, 30.87, 233.73, 109.55, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(201.65, 358.25, 106.4)
				TriggerEvent("Notify", "amarelo", "Todos os veículos de emergência possuem prioridade de passagem.", "Atenção", 5000)
				Route = 12
			end
		end

		if Route == 12 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 201.65, 358.25, 106.4, true) > 4.0001 then
				DrawMarker(21, 201.65, 358.25, 106.4, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(220.14, 377.39, 106.46)
				TriggerEvent("Notify", "amarelo", "Você terminou o seu teste, agora estacione na <b>auto-escola</b> para finalizar o percurso.", "Atenção", 5000)
				Route = 13
			end
		end

		if Route == 13 then
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 220.14, 377.39, 106.46, true) > 4.0001 then
				DrawMarker(21, 220.14, 377.39, 106.46, 0, 0, 0, 0, 180.0, 130.0, 0.6, 0.8, 0.5, 136, 96, 240, 180, 1, 0, 0, 1)
			else
				MakeBlips(220.14, 377.39, 106.46)
				Route = 0

				FreezeEntityPosition(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
				DoScreenFadeOut(1000)

				Wait(1500)

				TriggerEvent("autoschool:finish")
				DoScreenFadeIn(1000)
			end
		end

		Wait(TimeDistance)
	end
end)