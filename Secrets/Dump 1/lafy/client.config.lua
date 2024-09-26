Config = {
  -- Quantas vezes por segundo a localização do jogador será atualizada em relação a música
  -- Não há motivo para esse número ser maior que 10
  refreshRate = 5,
  realism = true,
  realismIgnore = {},

  -- Com o modo paranoia ativo, toda imagem de música/álbum será ocultada
  paranoia = false,

  -- Permite a busca de músicas com letras explícitas
  -- Este filtro não é infalível, algumas produtoras ignoram essa opção
  allowExplicit = true,

  -- Bloqueia certas palavras da busca
  -- Todos os bloqueios precisam ser minusculos
  blockedWords = { 'gemidao', 'gemidão' },
  
  -- Volume máximo, é bom aumentar este valor quando muitos jogadores reclamarem de som baixo
  -- Valor mínimo 0, Valor máximo 1
  baseVolume = 0.5,

  -- Tecla utilizada para deixar a caixa de som no chão, ou pegar do chão
  dropRadioKey = 'g',

  -- Valor mínimo de vida que o jogador precisa ter para abrir a NUI
  minimumHealth = 101,
  
  -- A música vai parar de tocar se o jogador morrer?
  stopOnDeath = true,

  -- Lista de coordenadas de interiores onde o som será desabilitado (precisa ser dentro do interior)
  blockedInteriors = {
    --vector3(148.95, -1039.27, 29.37), -- Banco da praça
  },

  blockedZones = {
    -- [vector3(0, 0, 0)] = 100, -- Na coordenada [0,0,0], em um raio de 0 metros, ninguém pode ouvir o lafy
  },

  isWindowsOpen = function(vehicle)
    -- Exemplo da base creative network
    -- return Entity(vehicle).state.Windows
  end,

  -- Esta notify acontece quando o jogador não tem permissão
  -- bool == nil   (Jogador sem permissão)
  -- bool == true  (O jogador digitou /som on)
  -- bool == false (O jogador digitou /som off)
  notify = function(bool)
    if type(bool) == 'number' then
      TriggerEvent('Notify', false, '<b>Volume atual:</b> '..bool..'%', "azul",5000)
    elseif bool == nil then
      TriggerEvent('Notify', false, 'Você não tem permissão', "vermelho",5000)
    elseif bool then
      TriggerEvent('Notify', false, '<b>Status do som:</b> Ligado', "verde",5000)
    else
      TriggerEvent('Notify', false, '<b>Status do som:</b> Desligado', "vermelho",5000)
    end
  end
}