infractionsConfig = {
	maxFineReduction = 50, -- (em porcentagem) Máxima redução do valor da multa que poderá ser selecionada no tablet
	maxArrestReduction = 50, -- (em porcentagem) Máxima redução do tempo de prisão que poderá ser selecionada no tablet

	maxFinesValue = 200000, -- Valor máximo da multa
	maxArrestTime = 300, -- Pena máxima

	bailToOfficer = false, -- Se, ao pagar a fiança, o valor pago será (ou não) destinado ao oficial que realizou a prisão
	bailPercentage = 50.0, -- Porcentagem da fiança que será destinada ao oficial que realizou a prisão (utilizado apenas se a opção acima estiver definida como TRUE)
	bailRemoveFine = true, -- TRUE = PRISÃO + MULTAS ignoradas / FALSE = Apenas PRISÃO ignorada

	list = {
		{
			name = "Artigo 101 - Exemplo de artigo (c/ fiança)", -- nome do artigo que será exibido no tablet
			fine = 1000, -- valor da multa
			arrest = 10, -- quantidade de meses
			bail = 2000, -- valor da fiança (defina como "false" se quiser desativar a opção de fiança para algum artigo)
		},
		{
			name = "Artigo 102 - Exemplo de artigo 2 (s/ fiança)", -- nome do artigo que será exibido no tablet
			fine = 0, -- valor da multa
			arrest = 15, -- quantidade de meses
		},
		{
			name = "Artigo 103 - Exemplo de artigo 3", -- nome do artigo que será exibido no tablet
			fine = 1500, -- valor da multa
			arrest = 0, -- quantidade de meses
		},
	}
}
