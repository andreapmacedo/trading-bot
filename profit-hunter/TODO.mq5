Orders settings

estabelece os pontos do trade de acordo com o definido pelos parâmetros definidos pelo usuário




Ordens assembly 

processa montagem das ordens com aplicação de filtros, seja de financeiro, tempo, sinais.


-Listening_EN_Signals_On_New_Trade_Floor
-- Escuta os sinais para o envio de atualização de ordens de entrada

-- A abertura de uma nova vela verifica os parâmetros de entrada definidos para atualização das orders
	


SO

redefine os padrões pre definidas no order settings pelo proposto por cada sistema sobrepujando assim as definições do usuario




as chamadas não deverão decorrer em camadas mas deverão obedecer a sequencia









-- CRIAR ARQUIVO COM AS PRE CONFIGURAÇÕES DE CADA PAPEL PARA SETAR COMO DEF. AO INICIAR



TradeOnCloseBar
- fechamnento da barra proximo a mínima ou máxima, não entrar
- número x de barras da mesma cor, não entrar
-barras de tamanho x, não entrar
- barras de bolume x, não entrar

rotini da inicialização na hora de negocioação do bot no lugar apenas da finalização
opera 2x a entrada e stop

stop da entrada. as demais entradas não interferem no stop


- Ajustar para funções completas que retorna o dado específico pelo parametro solicitado
- Ajustar para uma só função de Colocar orderns
- Ajustar para uma só função de remover orderns

- CALCULAR O TAMANHO DAS "SOBRAS" DAS TRAPS PARA AJUSTAR AUTOMATICAMENTO O TAMANHO DAS ENTRADAS

-Linkar o painel de sinais com a de execuçãoi de ordens
-Linkar o painel de sinais com a de execuçãoi de ordens
-Linkar o painel de sinais com a de execuçãoi de ordens


para médias.
-uma função para day trade e outra para swing para tratado do fechamento do dia e da abertura
- definir saídas e entradas também para day trade 

- LOG com todas as ordens recusadas e o motivo

- O modelo gradiente vai ser apenas um plus
- ele podera funcionar independede de qualquer outra estratégia
- ele podera seguir ou não uma tendência

+------------------------------------------------------------------+
| Organização                                                      |
+------------------------------------------------------------------+

- Separar por arquivo	
- Trabalhar com funções
- Padronizar
- Documentar
- Limpeza de código descartado.



+------------------------------------------------------------------+
| Implementação                                                    |
+------------------------------------------------------------------+
- comprar em níves de fibo das barras verders e vender nas vermelhas anteriores
- Trailing barra a barra
- Trailing EMA 9
- Trailing barra de evendo
- Trailing 123 
- Colorir barra
- Trailing de ativação percentual do alvo
- entrada considerando a retração
- stop 
- entrada de compra e venda, seja em média, suporte ou retração com um 123 do stormer
- inclinação da média pela diferencça entre o valor da média afastada de 3 barras.

+------------------------------------------------------------------+
| Ajustes                                                          |
+------------------------------------------------------------------+

+------------------------------------------------------------------+
| Testes                                                    |
+------------------------------------------------------------------+


 - estratégia contra tendencia com stop
 - estratégia contra tendencia com gradient
 - estratégia de tendência com tp
 - estratégia de rompimento de vela do 60min
 - estratégia padrões de vela
 - gradiente com media movel
 - bollinger
 




-Implementar Log com estatíscias específicas
-Ordem de agressão no lugar de um buy market (algo como um gatilho de venda/compra quando o o bid/ask atinge o ponto)




+------------------------------------------------------------------+
| EVO                                                              |
+------------------------------------------------------------------+


- adotar alteração na estrategia de valume, distáncia e ancoragem TAMBEM na estratégia 
-testar setups por horário
-implementar setup de tendência com chave de encerramenteo de trades diários
-implementar execução com ordens a mercado
-testar encerramento das diversas estratégias por gain e loss máximos
-verificar a possibibilidade de verificar a volatilidade histórica
- entrada e realização parcial com alvos de 50% etc




+------------------------------------------------------------------+
| Estratégias                                                      |
+------------------------------------------------------------------+

- 3 médias representando o 15 o 5 e o 2 min (8, 20, 50)


Aleatórios
- está proxímo a mínima na hora x(12h), compra  e realiza com x pontos


+------------------------------------------------------------------+
| prioridade                                                       |
+------------------------------------------------------------------+
registrar o lucro por horá nas contas demos em estratégias de "follow"

lucro de x, encerra o dia

estratégia da compra de 25 pts apenas acima em correções a favor da tendência
estratégia da compra de 25 pts apenas dentro de zonas de suporte e resistência

cada parte de código funciona como se fosse um (signal)
o SO é montado com vários cod signal (cod_sig)

risk management


contra tendência com trailing stop
range de barras
médias


distanciamento da mínima e máxima do dia
gap
distanciamento de abertura em relaão a máxima e mínima do dia anterior (abertura acima, abaixo ou no meio(percentuais))

distanciamento das médias por pontos
alinhamento de média
cruzamento de médias


perdeu fundo da barra e subiu acima do (close) compra com stop na mínima e trailing e tp


gradiente 
mm

gestão de preços médio no contra tendência


conta a tendência a distancia da compra é x e a da venda é y


fazer uma limpeza

padrões gráficos
padrões gráficos em regiões estratégicas
padrão de gradiante de longo spectro
avaliar melhor local para aplicação da tecnica da estratégia contra tendência (trap zone)


+------------------------------------------------------------------+
| Crítico                                                     |
+------------------------------------------------------------------+


em variáveis duplicatas e/ou INPUT_EN_EST_DISTANCE_CHOSEN
CURRENT_LONG_POSITION_VALUE
CURRENT_LONG_POSITION_VOLUME





trap de pesca
trap de confirmação

break "pesca"
break de confirmação





Hoje


-especificar teste de estratégias 
4.1
4.1 horário
4.1 add
4.1 add horário
4.2
4.2 horario
4.2 add
4.2 add horário

-atualização de input em tempo realiza

-Organização

-Bugs
volume máximo permitido

-canvas


-
setup follow a favor da tendência com o uso das faixas percentuais estabelecendo volume e entrada
entradas apenas em pb a favor da tendencia


setup martingale
legitiomo 
falso


setup gradiente com outra logica de atualização de ordens
consertar o algo do 4.3 com add

implementar um tp a partir do valor médio



next

acumula para um lado só e realiza num TP todo o acumudado no cotnra tendência (bom para redge de tendência)

se está abaixo da média, vende 2 e compra 1/ a lógica tb serve para o sistema de máximas e mínimas


modificar as rotinas por horário (identificar a mudança de data) 

criar um menu que gera submenus  
o menu tem botoes que miniminiza e maximiza outros menus



routine
horário para novo routine
corrigir a confecção de arquivos


fazer o so_follow 4 12 com o buy e o sell separado
estratégia
se abriu o dia com gap de alta e acima da última compra, só vender e o contrário tb



estratégia de realização baseada em preço médio

doiong

ok - trabalhar os filtros no modo day trade
ok - trabalhar o canvas para encerrar as ordens
ok - trabalhar a proteção do 4.3 pra evitar envio de ordens fora da faixa de preço razoável
trabalhar o aprimoramento do 4.3 e tambem ele em relação aos filtros
ok - trabalhar o 4.3 para a tendência


trabalhar o modo day trade no risk management

aprimorar o uso automático do level (ask/bid ou last trade)

trabalhar com uma consulta de ordem de swing (relatório de ultimos negócios por datas mais longas)

trabalhar com log e interface
contabilizar ordens executadas e mostra-las no painel


estratégia de tendência com reversão imediata


tp = preço médio + (spread * (entradas/2))
tp = de entrada + alvo em pontos





meta de contrato para tendência

toda vez que bate a meta o objetivo do codigo é equilibrar a equalização de compra e venda para tentar manter a posição estável no valor estabeleciada.





19/6
fazer o relatório de performance por hora
ao ser finalizado, um arquivo é gerado com os dados de interesse que serão zerados a cada evento
na rotina do horário, um evento vai deletar o arquivo anterior e inicilizar um novo
ao ser inicializado, uma rotina vai ler os valores armazenados no arquivo



fazer o relatório de performance por período

criar o modo trand agressivo (metodo para chegar ao valor do gravit mais rapido em caso de reversão)
criar uma versão que a distancia das ordens se ajusta pelo tamanho das ultimas velas ()
ajustar o tamanho da fonte


Operação 
operar as estratégias de contra tendência com limite de 4 ou 6 contratos (range curto)


variáveis de conservação que serão gravadas no init e no deinit


quantos trades, quantos deram certo/ errado
média de lucro
maior lucro
relação lucro taxa
opção de marcar no input a frequencia de atualização do relatório

pior trade, melhor trade, maior sequencia de compra/venda
reversão de lado

disparo de ordem a mercado
criar a estratégia de trend
tem como marcar máxima e mínima do dia anterior
explorar padrões gráficos de reversão para o robô
contabilizar as operações e o volume


testar o 21 vs o v3 (add on/off) e o 22 vs o 21

identificaçação na atualização da data


datas por período (hora, 15m, 1m , 5m, até as 10, até as 11, até as 12...)


adicionar o fator acumulação para add

regra para o add
regra para realização


guardar nas estatísticas
amplitude de movimento do dia/hora (max. min) bem como a frequencia da oscilação
mudança de polaridade das médias por horários
tamanho das velas
tamanho das sombras
imprlementar a realização/acumulação por rsi
implementar a virada de mão 








//+------------------------------------------------------------------+
// Mindstorm
//+------------------------------------------------------------------+
SETLETS
LETSSET
LETSET
pymbee

primeira entrada, 1 compra, segunda 2, terceira, 3 e realiza 2 e volta a vernder 1

-distancia inicial igual e de acordo com volume vai auemntando a distancia da entrada
-acima de x entradasd adicionar 1 lote a cada entrada

checar o ponteiro do tradingview para ver as classificações


CRIAR UMA ESTRATÉGIA NO BRAK_BAR onde vai ser operado para apenas um lado comprando/vendendo topo de fundo da barra como estratégia de hedge pra ser ligado após x entradas consecutivas em outra conta
esta mesma estratégia pode ser usada com a tendência para um trade de tendência mesmo
ou comprar a metade da barra em tendências

modo follow que só é magnético para o lado que não está posicionado

desenvolver as estratégias 10, 11, 12 e 13 com aplicaçãod e tendência e trade status (20 21 22 e 23 / 30 31 32 e 33) e misturando tudo tb

volume mínimo de uma posição (útil para estratégias de tendencia tb)
estratégia de só realizar quando o valor do ativo ultrapassar o PM 

ESTRATEGIA DE CRIAR UM GRAVIT ALVO DE ACORDO COM A O DESLOCAMENTO DO PREÇO.
EX. DESLOCOU 100 PTS A MÉTA É MANTER 1 COMPRADO DENTRO DA REGIÃO DOS DA QUEDA
CAIU MAIS 100 PTS, A META É MANTER 2 COMPRADOS E ASSIM SUCESSIVAMENTE.
O OBJETIVO É NÃO REALIZAR NA BAIXA

FOCAR NO 123 DE COMPRA OU VENDA
estratégias que variam de acordo com o range de volume e de sequência

fusão de sinais (ifr divergente ou acima dos níveis somado a padrão de reversão de vela ou média móvel. )
//+------------------------------------------------------------------+
// Fazendo
//+------------------------------------------------------------------+
CRIAR UM ENFORCE PARA O CASO DE NÁO TER HAVIDO MUDANÇA NO PREÇO MAS O BOT ESTÁ SEM ORDEM (ENFORCE)




modificação dos atributos da média de tendência em tempo de exec.
estrategia que a distancia de entrada para as situações 1 e 4 seja mínima para virar a mãe e a realização seja longa

o painel está apresentando a posição do dia e não do swing

//+------------------------------------------------------------------+
// FAÇA AGORA
//+------------------------------------------------------------------+


// Possibilidades
variações na estratégia de tendência (cruzamento de média, diatância, inclinações de média)
soma com ifr, divergência de ifr, sobrecompra, sobrevenda




mudou de lado, a distancia é mínima e o volume é maximo.
administrar pela distância da média



estratégia de tendência com a follow 
estratégia de vela com a ancoragem

swing modo vai ser implementado nas tomadas de decisões das estratégias
armazenar o valor das variáveis para o swing modo


//+------------------------------------------------------------------+
// Corrigir
//+------------------------------------------------------------------+



regra de trade.


//+------------------------------------------------------------------+
// AGENDE
//+------------------------------------------------------------------+

drandawn do intraday (rebaixamento absoluto)(algoritmo semelhante ao do trade. trabalhar com bordas )
DE ACORDO COM A TENDêNCIA(SINAIS DE ENTRADA POR VELA, ALINHAMENTO DE MÉDIAS, E RANGE), ALGO CAPAZ DE SISTEMAZAR AUTOMATICAMENTE A ESCOLHA DAS ESTRATÉGIAS DE VOLUME E DISTÂNCIA
estatísticas dos sinais (vela, retrações, média moveis, oscilação do dia, etc) o resultado pode se obtido via backtest
um arquivo no commom para todos os bots(a principio com dados de vwap)
um arquivo no commom para todos os bots(com dados obtidos com api ou outros meios )
Pelas estatísticas dos últimos dias (max, mini amplitude de mov... o algo calculara o spread de entrada)


//+------------------------------------------------------------------+
// DELEGUE
//+------------------------------------------------------------------+




//+------------------------------------------------------------------+
// ELIMINE
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
// CONCLUIDO
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
// Estratégias
//+------------------------------------------------------------------+
// Contra
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
// Afastamento de compra com aumento de lote apartir de x entradas 






