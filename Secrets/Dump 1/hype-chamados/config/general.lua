AppConfig = {
    identifier = "hype-chamados",
    name = "Chamados",
    description = "Um aplicativo para realizar chamados.",
    developer = "Hype",
    defaultApp = true,
    size = 59800
}

Services = {
    {
        name = "PMERJ",
        description = "Chame quando estiver em perigo.",
        icon = "police.png",
        job = "PMERJ"
    },{
        name = "PCERJ",
        description = "Chame quando estiver em perigo.",
        icon = "police.png",
        job = "PCERJ"
    },{
        name = "PRF",
        description = "Chame quando estiver em perigo.",
        icon = "police.png",
        job = "PRF"
    },{
        name = "UPA",
        description = "Chame quando estiver se sentido mal.",
        icon = "hospital.png",
        job = "Paramedico"
    },{
        name = "SRT",
        description = "Chame quando precisar de um mecânico.",
        icon = "mechanic.png",
        job = "Mecanico"
    }
}

Companies = {
    ["PMERJ"] = "PMERJ",
    ["PCERJ"] = "PCERJ",
    ["PRF"] = "PRF",
    ["Paramedico"] = "Paramedico",
    ["Mecanico"] = "Mecanico"
}

General = {
    auto_delete = 30
}

Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

getCharactersByPermission = function(perm)
    return vRP.NumPermission(perm)
end

getCharacterId = function(src)
    if src == 0 then return end
    return vRP.Passport(src)
end

-- MUDAR DE ACORDO COM A ESTRUTURA DE PRIMEIRO E SEGUNDO NOME.
characterName = function(characterId)
    local Identity = vRP.Identity(characterId)

    return Identity["Name"].." "..Identity["Lastname"]
end

getFormatedPhoneNumber = function(characterId)
    return exports["lb-phone"]:FormatNumber(getPhoneNumber(characterId))
end

getPhoneNumber = function(characterId)
    return vRP.CleanPhone(characterId)
end

hasPermission = function(characterId, perm)
    return vRP.HasService(characterId,perm)
end