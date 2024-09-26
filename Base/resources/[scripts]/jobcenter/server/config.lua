-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
Config = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOBS
-----------------------------------------------------------------------------------------------------------------------------------------
Config.Jobs = {
	{
		name = "Lixeiro",
		image = "Garbageman.png",
		rank = "Garbageman",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem e saia pela cidade de forma livre vasculhando todas as lixeiras pela sua frente.",
		paidActions = { "Coleta", "Limpeza", "Descarte", "Resíduos", "Saneamento" },
		tags = { "Salário Baixo", "Com Veículo", "Rota Curta", "Risco à Saúde" }
	}, {
		name = "Taxista",
		image = "Taxi.png",
		rank = "Taxi",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem e vá até a rota marcada no GPS, espere o passageiro embarcar e leve o mesmo até a rota final marcada no GPS.",
		paidActions = { "Transporte", "Condução", "Mobilidade", "Passageiros", "Itinerante" },
		tags = { "Salário Médio", "Com Veículo", "Rota Longa" }
	}, {
		name = "Caminhoneiro",
		image = "Trucker.png",
		rank = "Trucker",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS, escolha a sua carga e inicie o serviço, retire o veículo da garagem e engate a carga escolhida no caminhão, vá até a rota marcada no GPS, deixe a carga e depois siga a rota final.",
		paidActions = { "Transporte", "Rodovias", "Carga", "Logística", "Percursos longos" },
		tags = { "Salário Alto", "Com Veículo", "Rota Longa" }
	}, {
		name = "Motorista de Ônibus",
		image = "Bus.png",
		rank = "Bus",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem e siga em direção aos pontos de recolha marcados no GPS.",
		paidActions = { "Rota", "Itinerante", "Rodoviário", "Passageiros", "Transporte coletivo" },
		tags = { "Salário Médio", "Com Veículo", "Rota Longa" }
	}, {
		name = "Transportador de Valores",
		image = "Transporter.png",
		rank = "Transporter",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, entre dentro do cofre do banco central e recolha quantos malotes conseguir, guarde no veículo e saia para a destribuição seguindo a rota no GPS.",
		paidActions = { "Valores", "Vigilância", "Transporte", "Segurança", "Responsabilidade" },
		tags = { "Salário Alto", "Com Veículo", "Rota Curta" }
	}, {
		name = "Lenhador",
		image = "Lumberman.png",
		rank = "Lumberman",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, procure pelas árvores grandes e corte quantas conseguir, após isso guarde as madeiras no veículo e saia entregando pela rota no GPS.",
		paidActions = { "Manejo florestal", "Corte de madeira", "Trabalho ao ar livre", "Derrubada de árvores", "Equipamentos de serraria" },
		tags = { "Salário Alto", "Com Veículo", "Rota Longa" }
	}, {
		name = "Agricultor",
		image = "Fruitman.png",
		rank = "Fruitman",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, procure pelas árvores pequenas e corte quantas conseguir, após isso guarde as frutas no veículo e saia vendendo pela rota no GPS.",
		paidActions = { "Cultivo", "Terreno", "Colheita", "Agrícola", "Sustentabilidade" },
		tags = { "Salário Médio", "Com Veículo", "Rota Longa" }
	}, {
		name = "Entregador de Leite",
		image = "Milkman.png",
		rank = "Milkman",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, procure pelas vacas dentro das baias e com a garrafa vazia retire o leite de quantas conseguir, após isso saia vendendo pela rota no GPS.",
		paidActions = { "Rota", "Cliente", "Entrega", "Laticínios", "Distribuição" },
		tags = { "Salário Médio", "Com Veículo", "Rota Longa" }
	}, {
		name = "Rebocador",
		image = "Tows.png",
		rank = "Tows",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, siga a rota marcada e reboque o veículo que está no local, após isso retorne a central do rebocador e deixe o veículo rebocado no local, utilize o Entity Target(Alt) no veículo para finalizar o serviço.",
		paidActions = { "Veículos", "Resgate", "Reboque", "Assistência", "Emergência" },
		tags = { "Salário Alto", "Com Veículo", "Rota Longa" }
	}, {
		name = "Mergulhador",
		image = "Diver.png",
		rank = "Diver",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS, use a Roupa com Oxigênio e mergulhe na área demarcada no GPS com um círculo laranja, vasculhe o máximo de barril que conseguir e venda os itens após abrir todos os barril.",
		paidActions = { "Inspeção", "Exploração", "Subaquático", "Profundidade", "Equipamento" },
		tags = { "Salário Alto", "Sem Veículo", "Risco à Saúde" }
	}, {
		name = "Correios",
		image = "PostOp.png",
		rank = "PostOp",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem, pegue a caixa e leve até a van armazenando a mesma dentro do veículo, após encher o caminhão basta sair entregando pela rota marcada no GPS.",
		paidActions = { "Entregas", "Distribuição", "Encomendas", "Serviço Postal", "Correspondência" },
		tags = { "Salário Alto", "Com Veículo", "Rota Longa" }
	}, {
		name = "Jardineiro",
		image = "Cleaner.png",
		rank = "Cleaner",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, vá até alguma propriedade marcada no GPS e inicie os serviços na mesma, siga todas as etapas e faça uma manutenção completa.",
		paidActions = { "Plantio", "Paisagismo", "Jardinagem", "Manutenção", "Cuidado verde" },
		tags = { "Salário Alto", "Sem Veículo", "Rota Curta" }
	}, {
		name = "Fazendeiro",
		image = "Farmer.png",
		rank = "Farmer",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, retire o veículo da garagem e colete o máximo de milho que conseguir dentro da área da plantação, após isso você pode utilizar ou comercializar os milhos colhidos.",
		paidActions = { "Rural", "Cultivo", "Manejo", "Pecuária", "Agricultura" },
		tags = { "Salário Médio", "Com Veículo", "Rota Curta", "Risco à Saúde" }
	}, {
		name = "Minerador",
		image = "Minerman.png",
		rank = "Minerman",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e inicie o serviço, vista a Roupa com Oxigênio e colete o máximo de pedras que conseguir dentro da área da mineradora, após isso você pode ir até a Joalheria marcada no GPS, refinar e vender todas as pedras colhidas.",
		paidActions = { "Mina", "Geologia", "Extração", "Mineração", "Exploração" },
		tags = { "Salário Alto", "Sem Veículo", "Rota Curta", "Risco à Saúde" }
	}, {
		name = "Caçador",
		image = "Hunter.png",
		rank = "Hunter",
		description = "Saiba mais sobre o emprego logo a baixo.",
		instructions = "Após aceitar o emprego, vá até a marcação do mesmo no GPS e compre os materiais necessários, dentro da área de caça use a ração e vá a caça do animal marcado em seu GPS, após isso você pode ir até a cabana de caça marcada no GPS e vender todas as caixas coletadas.",
		paidActions = { "Natureza", "Exploração", "Sustentabilidade", "Sobrevivência", "Exploração" },
		tags = { "Salário Alto", "Sem Veículo", "Sem Rota", "Risco à Saúde" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAGCOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
Config.tagColors = {
	"bg-orange-200",
	"bg-green-300",
	"bg-rose-400",
	"bg-rose-400"
}