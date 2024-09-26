Config = {}

Config.Main = {
    cmd = 'painelfac', -- Comando para abrir Painel
    createAutomaticOrganizations = true,
    storeUrl = 'https://loja.connecthype.gg/categories/329454', -- Link da Sua Loja
    serverLogo = "https://cdn.discordapp.com/attachments/847597301278179379/1271311168798986322/SDv5mbP.png?ex=66b6e04a&is=66b58eca&hm=8d4659f4cc7275208ee3d300934a15ec2a17dd6fe9753bfd1178e9cde35ef639&",
    blackList = 7, -- Tempo de black em dias (7 Dia(s))
    clearChestLogs = 15, -- Logs do Bau limpar automaticamente de 15 em 15 dias. ( Evitar consumo da tabela )
}

Config.defaultPermissions = { 
    invite = { -- Permissao Para Convidar
        name = "Convidar",
        description = "Esta permissao permite vc convidar as pessoas para sua facção."
    },
    demote = { -- Permissao Para Rebaixar
        name = "Rebaixar",
        description = "Essa permissão permite que o cargo selecionado rebaixe um cargo inferior."
    }, 
    promote = { -- Permissao Para Promover
        name = "Promover",
        description = "Essa permissão permite que o cargo selecionado promova um cargo."
    }, 
    dismiss = { -- Permissao Para Rebaixar
        name = "Demitir",
        description = "Essa permissão permite que o cargo selecionado demita um cargo inferior."
    }, 
    withdraw = { -- Permissao Para Sacar Dinheiro
        name = "Sacar dinheiro",
        description = "Permite que esse cargo selecionado possa sacar dinheiro do banco da facção."
    }, 
    deposit = { -- Permissao Para Depositar Dinheiro
        name = "Depositar dinheiro",
        description = "Permite que esse cargo selecionado possa depositar dinheiro no banco da facção."
    }, 
    message = { -- Permissao para Escrever nas anotaçoes
        name = "Escrever anotações",
        description = "Permite que esse cargo selecionado possa escrever anotações."
    },
    alerts = { -- Permissao para enviar alertas
        name = "Escrever Alertas",
        description = "Permite que esse cargo selecionado possa enviar alertas para todos jogadores."
    },
    chat = { -- Permissao para Falar no chat
        name = "Escrever no chat",
        description = "Permite que esse cargo selecionado possa se comunicar no chat da facção"
    },
}

Config.Groups = {
    ['Ballas'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = true, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-malha'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['c-cobre'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 3
            }
        }
    },
    ['Armas01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['weapontrigger'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['weaponbody'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolsighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolmagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['smgsighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['smgmagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['riflesighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['riflemagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Armas02'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['weapontrigger'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['weaponbody'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolsighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolmagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['smgsighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['smgmagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['riflesighthandle'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['riflemagazine'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Municao01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['gunpowder'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolprojectile'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['fuze'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Municao02'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['gunpowder'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['pistolprojectile'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['fuze'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Drogas01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['coke'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['sulfuric'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Drogas02'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['weed'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['silk'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Drogas03'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['mdma'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['sulfuric'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Drogas04'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['mushroom'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['sulfuric'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Desmanche01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['threadscrews'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['forgedaluminum'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Desmanche02'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['threadscrews'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['forgedaluminum'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Roubos01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['steelplate'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['forgedaluminum'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['couchepaper'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['printerpaint'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['threadscrews'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['twistedwire'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['tarp'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['syntheticrubber'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['forgedcopper'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['silvertape'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['temperedglass'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Lavagem01'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['cleaner'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Lavagem02'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = false, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['cleaner'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 4
            }
        }
    },
    ['Vagos'] = {
        Config = {
            Salary = { -- SALARIO FAC
                active = true, -- Se vai esta ativo ou nao
                amount = 50000, -- Valor que vai receber
                time = 10, -- tempo em tempo que vai receber salario em minuto(s)
            },
            Goals = { -- METAS
                defaultReward = 300, -- Valor Padrão da recompensa ( obs Lider consegue alterar in-game )
                itens = {
                    ['m-malha'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                    ['c-cobre'] = 10, -- Quantidade Padrão da recompensa ( obs Lider consegue alterar in-game )
                }
            }
        },
        List = {
            ['Líder'] = {
                prefix = 'Chefe',
                tier = 1
            },
            ['Sub-Líder'] = {
                prefix = 'Sub-Líder',
                tier = 2
            },
            ['Membro'] = {
                prefix = 'Membro',
                tier = 3
            },
             ['Recruta'] = {
                prefix = 'Recruta',
                tier = 3
            }
        }
    }
}


Config.Langs = {
    ['offlinePlayer'] = function(source) TriggerClientEvent("Notify", source,false,"Este jogador não está online.","vermelho",5000) end,
    ['alreadyFaction'] = function(source) TriggerClientEvent("Notify", source,false,"Este jogador já esta em uma organização.","vermelho",5000) end,
    ['alreadyBlacklist'] = function(source) TriggerClientEvent("Notify", source,false,"Você está na black-list, não pode receber convites.","vermelho",5000) end,
    ['alreadyUserBlacklist'] = function(source) TriggerClientEvent("Notify",source,false,"Este jogador está em black-list.","vermelho",5000) end,
    ['sendInvite'] = function(source) TriggerClientEvent("Notify",source,false,"Você enviou o convite.","verde",5000) end,
    ['acceptInvite'] = function(source) TriggerClientEvent("Notify",source,false,"Você aceitou o convite.","verde",5000) end,
    ['acceptedInvite'] = function(source,ply_id) TriggerClientEvent("Notify",source,false,"O "..ply_id.." aceitou o convite.","verde",5000) end,
    ['bestTier'] = function(source) TriggerClientEvent("Notify",source,false,"Você não pode fazer isso com alguem com um cargo igual ou maior que o seu.","vermelho",5000) end,
    ['youPromoved'] = function(source) TriggerClientEvent("Notify",source,false,"Você foi promovido.","verde",5000) end,
    ['youPromovedUser'] = function(source,ply_id,group) TriggerClientEvent("Notify",source,false,"Você promoveu o ID: "..ply_id.." para "..group..".","verde",5000) end,
    ['youDemote'] = function(source) TriggerClientEvent("Notify",source,false,"Você foi rebaixado.","verde",5000) end,
    ['youDemoteUser'] = function(source,ply_id) TriggerClientEvent("Notify",source,false,"Você rebaixou o ID: "..ply_id..".","verde",5000) end,
    ['youDismiss'] = function(source) TriggerClientEvent("Notify",source,false,"Você foi demitido de sua organização.","verde",5000) end,
    ['youDismissUser'] = function(source,ply_id) TriggerClientEvent("Notify",source,false,"Você demitiu o ID "..ply_id.." .","verde",5000) end,
    ['waitCooldown'] = function(source) TriggerClientEvent("Notify",source,false,"Aguarde para fazer isso..","vermelho",5000) end,
    ['bankNotMoney'] = function(source) TriggerClientEvent("Notify",source,false,"O Banco da organização não possui essa quantia.","vermelho",5000) end,
    ['rewardedGoal'] = function(source,amount) TriggerClientEvent("Notify",source,false,"Você resgatou sua meta diaria e recebeu <b>R$ "..amount.."</b> por isso.","verde",5000) end,
    ['notPermission'] = function(source) TriggerClientEvent("Notify",source,false,"Você não possui permissão.","vermelho",5000) end,
    ['notMoneyDeposit'] = function(source) TriggerClientEvent("Notify",source,false,"Você não possui dinheiro para depositar.","vermelho",5000) end
}

if SERVER then
    -- CUSTOM QUERYS
    vRP.Prepare('mirtin_orgs_v2/GetUsersGroup', "SELECT * FROM entitydata WHERE Information LIKE '%Permissions:%'")
    vRP.Prepare('mirtin_orgs_v2/GetUsersGroup2', "SELECT * FROM entitydata WHERE Name LIKE '%Permissions:%'")
    --vRP.Prepare("mirtin_orgs_v2/getUserGroup", "SELECT user_id,dvalue FROM vrp_user_data WHERE Information = 'vRP:datatable' and user_id = @user_id")
    --vRP.Prepare("mirtin_orgs_v2/updateUserGroup", "UPDATE vrp_user_data SET dvalue = @dvalue WHERE user_id = @user_id and Information = 'vRP:datatable'")

    -- CAPTURAR GRUPOS COM JOGADOR OFFLINE
    function getUserGroups(user_id)
		local groups = {}
		for _, v in pairs(Config.Groups) do
            for gName in ipairs(v.List) do
				local splitted = splitString(gName, "@")
				local name = splitted[1]
				local tier = splitted[2]
				if vRP.HasGroup(user_id, name, tier) then
					groups[gName] = true
					break
				end
			end
		end
		return groups
    end

    -- SETAR GRUPO COM JOGADOR OFFLINE
    function updateUserGroups(user_id,groups)
		local list = {}
		for _, v in pairs(Config.Groups) do
			for gName in ipairs(v.List) do
				local splitted = splitString(gName,"@")
				local name = splitted[1]
				local tier = splitted[2]
                if groups[gName] then
					vRP.SetPermission(user_id,name,tier)
					list[name] = true
				elseif not list[name] then
					vRP.RemovePermission(user_id,gName)
				end
			end
		end
	end

    -- IDENTIDADE
    function getUserIdentity(user_id)
        local Return = {}
        local Identity = vRP.Identity(user_id)

        Return.name = Identity["Name"]
        Return.firstname = Identity["Lastname"]

        return Return
    end

    function getUserSource(user_id)
        return vRP.Source(user_id)
    end

    function getUserId(source)
        return vRP.Passport(source)
    end

    function getUsers()
        return vRP.Players()
    end

    function getUserMyGroups(user_id)
        return vRP.UserGroups(user_id)
    end

    function hasGroup(user_id, group)
        return vRP.HasPermission(user_id, group)
    end

    function addUserGroup(user_id, group)
        return vRP.SetPermission(user_id, group)
    end

    function tryFullPayment(user_id, amount)
        return vRP.PaymentFull(user_id, amount)
    end

    function giveBankMoney(user_id, amount)
        return vRP.GiveBank(user_id, amount)
    end

	-- PEGAR DINHEIRO DO BANCO DO JOGADOR
	function getBankMoney(user_id)
		return vRP.GetBank(user_id)
	end

    function getItemName(item)
        return ItemName(item) or item
    end

    function request(source, text, time)
        return vRP.Request(source, text)
    end

    function removeUserGroup(user_id, group)
        return vRP.RemovePermission(user_id, group)
    end

    -- REMOVER BLACKLIST
    RegisterCommand('removerbl', function(source,args)
        local user_id = getUserId(source)
        if not user_id then return end

        local ply_id = tonumber(args[1])
        if not ply_id then return end

        if vRP.HasGroup(user_id,"Admin",1) then
            TriggerClientEvent("Notify", source, "sucesso","Você removeu a blacklist do ID: "..ply_id..".",5000) 
            BLACKLIST:remUser(ply_id)
        end
    end)

    AddEventHandler('Connect', function(user_id, source)
        TriggerEvent('mirtin_orgs_v2:playerSpawn', user_id, source)
    end)

    AddEventHandler('Disconnect', function(user_id)
        TriggerEvent('mirtin_orgs_v2:playerLeave', user_id)
    end)
end


--[[ 
    Como Utilizar EXPORT de Guardar / Retirar Item no Bau:
    ( Colocar Esse EXPORT na função de retirar/guardar item de seu inventario)
    
    user_id: user_id, -- ID Do Jogador,
    action: withdraw or deposit, -- Ação que foi feita Retirou/Depositou
    item: item, -- Spawn do item que foi retirado/guardado.
    amount: quantidade, -- Quantidade do item que foi depositada/retirada

    EXPORT: 
    exports.mirtin_orgs_v2:addLogChest(user_id, action, item, amount)
]]

-- t kd seu inv e serparado o bau

--[[ 
    Como Utilizar EXPORT De METAS DIARIAS:
    ( Colocar esse EXPORT na função de Guardar Itens no Armazem ou Coletar Itens no Farm )

    user_id: user_id, -- ID Do Jogador,
    item: item, -- Spawn do item que foi guardado/farmado.
    amount: quantidade, -- Quantidade do item que foi guardada/farmada.

    EXPORT: 
    exports.mirtin_orgs_v2:addGoal(user_id, item, amount)
]]