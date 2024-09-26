-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador", "Moderador", "Suporte" },
		["Service"] = {}
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Ouro", "Prata", "Bronze" },
		["Salary"] = { 10000, 5000, 2500 },
		["Service"] = {}
	},
	["Policia"] = {
		["Parent"] = {
			["Policia"] = true
		},
		["Hierarchy"] = { "Chefe", "Capitão", "Tenente", "Sargento", "Corporal", "Oficial", "Cadete" },
		["Salary"] = { 2500, 2250, 2000, 1750, 1500, 1500, 1500 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Paramedico"] = {
		["Parent"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe", "Conselheiro", "Membro" },
		["Salary"] = { 2500, 2250, 2000 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Mecanico"] = {
		["Parent"] = {
			["Mecanico"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Salary"] = { 2500, 2250, 2000, 1750, 1500 },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Burgershot"] = {
		["Parent"] = {
			["Burgershot"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe", "Sub-Chefe", "Gerente", "Conselheiro", "Membro" },
		["Service"] = {},
		["Type"] = "Work"
	},
	["Emergencia"] = {
		["Parent"] = {
			["Policia"] = true,
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Restaurantes"] = {
		["Parent"] = {
			["BurgerShot"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Gangs"] = {
		["Parent"] = {
			["Ballas"] = true,
			["Vagos"] = true,
			["Families"] = true,
			["Aztecas"] = true,
			["Bloods"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Service"] = {}
	},
	["Buff"] = {
		["Parent"] = {
			["Buff"] = true
		},
		["Hierarchy"] = { "Chefe" },
		["Salary"] = { 2250 },
		["Service"] = {}
	}
}