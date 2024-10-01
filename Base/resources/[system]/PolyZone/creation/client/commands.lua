RegisterCommand("pzcreate",function(source,Message)
  local zoneType = Message[1]
  if not zoneType then
    return
  end
  if zoneType ~= 'poly' and zoneType ~= 'circle' and zoneType ~= 'box' then
    return
  end
  local name = nil
  if #Message >= 2 then name = Message[2]
  else name = GetUserInput("Enter name of zone:") end
  if not name or name == "" then
    return
  end
  TriggerEvent("polyzone:pzcreate", zoneType, name, Message)
end)

RegisterCommand("pzadd",function()
  TriggerEvent("polyzone:pzadd")
end)

RegisterCommand("pzundo",function()
  TriggerEvent("polyzone:pzundo")
end)

RegisterCommand("pzfinish",function()
  TriggerEvent("polyzone:pzfinish")
end)

RegisterCommand("pzlast",function()
  TriggerEvent("polyzone:pzlast")
end)

RegisterCommand("pzcancel",function()
  TriggerEvent("polyzone:pzcancel")
end)