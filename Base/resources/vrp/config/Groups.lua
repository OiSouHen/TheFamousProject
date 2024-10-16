-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
Groups = {
	["Admin"] = {
		["Parent"] = {
			["Admin"] = true
		},
		["Hierarchy"] = { "Administrador", "Moderador", "Suporte" },
		["Service"] = {},
		["Client"] = true,
		["Chat"] = true
	},
	["Premium"] = {
		["Parent"] = {
			["Premium"] = true
		},
		["Hierarchy"] = { "Ouro", "Prata", "Bronze" },
		["Salary"] = { 10000, 5000, 2500 },
		["Service"] = {},
		["Client"] = true,
		["Chat"] = true
	},
	["Policia"] = {
		["Parent"] = {
			["Policia"] = true
		},
		["Hierarchy"] = { "Chefe", "Capitão", "Tenente", "Sargento", "Corporal", "Oficial", "Cadete" },
		["Salary"] = { 2500, 2250, 2000, 1750, 1500, 1500, 1500 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Paramedico"] = {
		["Parent"] = {
			["Paramedico"] = true
		},
		["Hierarchy"] = { "Chefe", "Médico", "Enfermeiro", "Residente" },
		["Salary"] = { 6050, 6050, 4000, 4000 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Mecanico"] = {
		["Parent"] = {
			["Mecanico"] = true
		},
		["Hierarchy"] = { "Chefe", "Mecânico", "Borracheiro", "Estagiário" },
		["Salary"] = { 2500, 2250, 2000, 1750 },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Restaurante"] = {
		["Parent"] = {
			["Restaurante"] = true
		},
		["Hierarchy"] = { "Chefe", "Supervisor", "Funcionário" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true
	},
	["Ballas"] = {
		["Parent"] = {
			["Ballas"] = true
		},
		["Hierarchy"] = { "Líder", "Sub-Líder", "Membro", "Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Vagos"] = {
		["Parent"] = {
			["Vagos"] = true
		},
		["Hierarchy"] = { "Líder", "Sub-Líder", "Membro", "Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Families"] = {
		["Parent"] = {
			["Families"] = true
		},
		["Hierarchy"] = { "Líder", "Sub-Líder", "Membro", "Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Aztecas"] = {
		["Parent"] = {
			["Aztecas"] = true
		},
		["Hierarchy"] = { "Líder", "Sub-Líder", "Membro", "Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Bloods"] = {
		["Parent"] = {
			["Bloods"] = true
		},
		["Hierarchy"] = { "Líder", "Sub-Líder", "Membro", "Recruta" },
		["Service"] = {},
		["Type"] = "Work",
		["Client"] = true,
		["Chat"] = true
	},
	["Emergencia"] = {
		["Parent"] = {
			["Policia"] = true,
			["Paramedico"] = true
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