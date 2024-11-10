lastCreatedZoneType = nil
lastCreatedZone = nil
createdZoneType = nil
createdZone = nil
drawZone = false

RegisterNetEvent("polyzone:pzcreate")
AddEventHandler("polyzone:pzcreate", function(zoneType, name, Message)
  if createdZone then
    return
  end

  if zoneType == 'poly' then
    polyStart(name)
  elseif zoneType == "circle" then
    local radius = nil
    if #Message >= 3 then radius = tonumber(Message[3])
    else radius = tonumber(GetUserInput("Enter radius:")) end
    if not radius then
      return
    end
    circleStart(name, radius)
  elseif zoneType == "box" then
    local length = nil
    if #Message >= 3 then length = tonumber(Message[3])
    else length = tonumber(GetUserInput("Enter length:")) end
    if not length or length < 0.0 then
      return
    end
    local width = nil
    if #Message >= 4 then width = tonumber(Message[4])
    else width = tonumber(GetUserInput("Enter width:")) end
    if not width or width < 0.0 then
      return
    end
    boxStart(name, 0, length, width)
  else
    return
  end
  createdZoneType = zoneType
  drawZone = true
  disableControlKeyInput()
  drawThread()
end)

RegisterNetEvent("polyzone:pzfinish")
AddEventHandler("polyzone:pzfinish", function()
  if not createdZone then
    return
  end

  if createdZoneType == 'poly' then
    polyFinish()
  elseif createdZoneType == "circle" then
    circleFinish()
  elseif createdZoneType == "box" then
    boxFinish()
  end

  lastCreatedZoneType = createdZoneType
  lastCreatedZone = createdZone

  drawZone = false
  createdZone = nil
  createdZoneType = nil
end)

RegisterNetEvent("polyzone:pzlast")
AddEventHandler("polyzone:pzlast", function()
  if createdZone or not lastCreatedZone then
    return
  end

  local name = GetUserInput("Enter name (or leave empty to reuse last zone's name):")
  if not name then
    return
  elseif name == "" then
    name = lastCreatedZone.name
  end
  createdZoneType = lastCreatedZoneType
  if createdZoneType == 'box' then
    local minHeight, maxHeight
    if lastCreatedZone.minZ then
      minHeight = lastCreatedZone.center.z - lastCreatedZone.minZ
    end
    if lastCreatedZone.maxZ then
      maxHeight = lastCreatedZone.maxZ - lastCreatedZone.center.z
    end
    boxStart(name, lastCreatedZone.offsetRot, lastCreatedZone.length, lastCreatedZone.width, minHeight, maxHeight)
  elseif createdZoneType == 'circle' then
    circleStart(name, lastCreatedZone.radius, lastCreatedZone.useZ)
  end
  drawZone = true
  disableControlKeyInput()
  drawThread()
end)

RegisterNetEvent("polyzone:pzcancel")
AddEventHandler("polyzone:pzcancel", function()
  if not createdZone then
    return
  end

  drawZone = false
  createdZone = nil
  createdZoneType = nil
end)

-- Drawing
function drawThread()
  CreateThread(function()
    while drawZone do
      if createdZone then
        createdZone:draw()
      end
      Wait(0)
    end
  end)
end