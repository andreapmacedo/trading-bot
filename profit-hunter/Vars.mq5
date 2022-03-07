//+------------------------------------------------------------------+
// Declarations
//+------------------------------------------------------------------+

MqlRates PriceInfo[];

//--- Symbol Info 

//string THIS_SYMBOL = "WIN$";
string THIS_SYMBOL = "";

//string THIS_SYMBOL = "WDO$";
//string THIS_SYMBOL = "WDOV20";


//+------------------------------------------------------------------+
//| Initializations vars                                             |
//+------------------------------------------------------------------+


//---Mínima mudança de preço (5.0)

//Server_Symbol_Constants_For_Init

double Tick_Size     		= SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);         

//---Tamanho do contrato de negociação (1.0)
//double r_SYMBOL_TRADE_CONTRACT_SIZE    		= SymbolInfoDouble(_Symbol, SYMBOL_TRADE_CONTRACT_SIZE);

//--- (2000.0)
double r_SYMBOL_VOLUME_MAX           		= SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);				
//--- (1.0)
double r_SYMBOL_VOLUME_MIN		      	 	= SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN); 	


//https://www.mql5.com/pt/docs/constants/environment_state/marketinfoconstants#enum_symbol_trade_mode
//ENUM_SYMBOL_TRADE_MODE e_SYMBOL_TRADE_MODE      = (ENUM_SYMBOL_TRADE_MODE)SymbolInfoInteger(_Symbol, SYMBOL_TRADE_MODE);


//datetime dt_SYMBOL_START_TIME                   = (datetime)SymbolInfoInteger(NULL, SYMBOL_START_TIME);
//datetime dt_SYMBOL_EXPIRATION_TIME              = (datetime)SymbolInfoInteger(NULL, SYMBOL_EXPIRATION_TIME);


input int SO = 4; // SISTEMA OPERACIONAL (Nº)
input int VER = 1; // VERSÃO (Nº)
input int EN_MODE = 1; // PARÂMETRO SIS. - Modo de Execução - Ordem Limite (1)
input bool PTS_MODE = true; // PARÂMETRO SIS. - DISTÂNCIA: Pontos (true) / Percentual (false)
input bool LOTVOL_MODE = true; // PARÂMETRO SIS. - VOLUMUE: Lotes (true) / Unidades (false)


input int INPUT_TREND_EST_CHOSEN = 0; // ESTRATÉGIA - TENDÊNCIA - (Nº)
int SELECTED_EST_TREND_CHOSEN = INPUT_TREND_EST_CHOSEN;

input int HACKING_STRATEGY_CHOSEN = 0; // ESTRATÉGIA - HACKING - (Nº)
int SELECTED_HACKING_STRATEGY_CHOSEN = HACKING_STRATEGY_CHOSEN;

input int TRADE_STRATEGY_CHOSEN = 0; // ESTRATÉGIA - MASTER - (Nº)
int SELECTED_TRADE_STRATEGY_CHOSEN = TRADE_STRATEGY_CHOSEN;



input int TRADE_STATUS_SYSTEM_01_CHOSEN = 0; // ESTRATÉGIA - STATUS 01 - (Nº)
int SELECTED_TRADE_STATUS_SYSTEM_01_CHOSEN = TRADE_STATUS_SYSTEM_01_CHOSEN;
input int TRADE_STATUS_SYSTEM_02_CHOSEN = 0; // ESTRATÉGIA - STATUS 02 - (Nº)
int SELECTED_TRADE_STATUS_SYSTEM_02_CHOSEN = TRADE_STATUS_SYSTEM_02_CHOSEN;
input int TRADE_STATUS_SYSTEM_03_CHOSEN = 0; // ESTRATÉGIA - STATUS 03 - (Nº)
int SELECTED_TRADE_STATUS_SYSTEM_03_CHOSEN = TRADE_STATUS_SYSTEM_03_CHOSEN;
input int TRADE_STATUS_SYSTEM_04_CHOSEN = 0; // ESTRATÉGIA - STATUS 04 - (Nº)
int SELECTED_TRADE_STATUS_SYSTEM_04_CHOSEN = TRADE_STATUS_SYSTEM_04_CHOSEN;
input int TRADE_STATUS_SYSTEM_05_CHOSEN = 0; // ESTRATÉGIA - STATUS 05 - (Nº)
int SELECTED_TRADE_STATUS_SYSTEM_05_CHOSEN = TRADE_STATUS_SYSTEM_05_CHOSEN;








// Permite que o sistema altere a opção escolhida pelo usuário.
int SELECTED_SO  = SO; 
int SELECTED_VER = VER; 
int SELECTED_EN_MODE = EN_MODE; 






input bool DAY_TRADE_MODE = true; //Day Trade - Encerra posição/remove as ordens na hora 'Desligar'
input bool TIME_FILTER = true; //Horário de Negociação - Remove as ordens na hora 'Desligar'

//input bool TIME_FILTER = false; // Horário para Negociar

//- Horário inicial para negociar
input string   TRADING_TIME_START  	            = "09:05";  // Ligar (hh:mm) --> Ativar Horário de Negociação
//- Horário limite para negociar
input string   TRADING_TIME_END   	            = "17:43";  // Desligar (hh:mm) --> Ativar Horário de Negociação

input bool LONG_POSITION_ON   					= true; // PERMITIR - LONG / Compra - (Ativar)
input bool SHORT_POSITION_ON               		= true; // PERMIRIR - SHORT / Venda - (Ativar)
bool SELECTED_LONG_POSITION_ON   					= LONG_POSITION_ON; 
bool SELECTED_SHORT_POSITION_ON               		= SHORT_POSITION_ON; 






//int    MAX_ORDERS_IN              			        = 200;
//double MAX_LOSS_POSITION	        		        = 200;
//double MAX_PROFIT_POSITION			                = 200;

input double LIMIT_LOSS_DAY                         = 0; // LIMITE - Perda Day Trade - (ex.: 1000) (Desligado = 0)
input double LIMIT_PROFIT_DAY                       = 0; // LIMITE - Lucro Day Trade - (ex.: 1000) (Desligado = 0)

double SELECTED_LIMIT_LOSS_DAY = LIMIT_LOSS_DAY;
double SELECTED_LIMIT_PROFIT_DAY = LIMIT_PROFIT_DAY;


//double LIMIT_FULL_LOTE_LOSS_DAY                     = (-400);
//double LIMIT_FULL_LOTE_PROFIT_DAY                   = 400; 



//=== ORDERS ===//
//- O máximo desvio de preço, especificado em pontos


//+------------------------------------------------------------------+
//| Vol
//+------------------------------------------------------------------+

input double MINIMUN_POSITION_VOLUME                = 0; // MINIMO - Volume da Posição - (Valor)
input double LIMIT_POSITION_VOLUME	                = 10; // LIMITE - Volume da Posição - (Valor)
input double LIMIT_ORDER_VOLUME		                = 2; // LIMITE - Volume Por Ordem - (Valor)

double SELECTED_MINIMUN_POSITION_VOLUME          = MINIMUN_POSITION_VOLUME;
double SELECTED_LIMIT_ORDER_VOLUME	                = LIMIT_ORDER_VOLUME;
double SELECTED_LIMIT_POSITION_VOLUME		    	= LIMIT_POSITION_VOLUME;


double FINAL_LIMIT_ORDER_VOLUME	                    = SELECTED_LIMIT_ORDER_VOLUME;
double FINAL_LIMIT_POSITION_VOLUME	    	    	= SELECTED_LIMIT_POSITION_VOLUME;
double LAST_BAR_SIZE = 0;






//-- Contadores
//double rCurrentDayResult                    = 0; // posições encerradas + abertas
double rCurrentDayBalance			        = 0; // Contabiliza apenas o resultado das posições encerradas

int nUpdateEndDayInfsCounter			    = 0;


//--- static variable, used for storage of last bar time
static datetime last_bar_time=0;

//OLD

//+------------------------------------------------------------------+
// Settings
//+------------------------------------------------------------------+







/*

bool DayTradeResultManagemant          	    = false;

//- Gestão de ordens por ocasião de novo tick
bool ON_TICK_ORDER_HANDLER_ON               = false;
//- Gestão de ordens por ocasião de nova barra
bool ON_BAR_ORDER_HANDLER_ON                = false; 
int SIGNAL = 0;
 
double DEF_INCREMENT_PTS               = 10;
double DEF_TP_INCREMENT_PTS            = 6;
double DEF_UPDATE_INCREMENT_PTS        = 5; 
 
 */



//+------------------------------------------------------------------+
// Enums
//+------------------------------------------------------------------+



//---  enumeration of named constants




//---  enumeration of named constants



//+------------------------------------------------------------------+
// Funcionos
//+------------------------------------------------------------------+

//--- do OnTradeTransaction (2)
//ulong order_ticket;
//bool ON_TRADE_ON = false;

//=== GRADIENTE





//--- Total de incremento na posição na estratégia gradiente

//+------------------------------------------------------------------+
// Trade on close bar
//+------------------------------------------------------------------+

//input bool PARTIAL_ON       = false;




//input bool ACCUMULATE_ORDER = false;




//+------------------------------------------------------------------+
// Hitoric Bar Size
//+------------------------------------------------------------------+

int TOTAL_CANDLES_UP        = 0;
int TOTAL_CANDLES_DOW       = 0;


int BREAKOUT_SEQUENCE               = 0;
int BREAKDOWN_SEQUENCE              = 0;
int LONGEST_DAY_BREAKOUT_STREAK     = 0;    
int LONGEST_DAY_BREAKDOWN_STREAK    = 0;



double Historic_BarSize[];
double Historic_Day_BarSize[];


input double      EN_Volume_Long                 = 1; // VOLUME - LONG - por Ordem  - (Valor)
input double      EN_Volume_Short                = 1; // VOLUME - SHORT - por Ordem - (Valor)

// double SELECTED_VOLUME_LONG                 =  (EN_Volume_Long * r_SYMBOL_VOLUME_MIN); 
// double SELECTED_VOLUME_SHORT                =  (EN_Volume_Short * r_SYMBOL_VOLUME_MIN);
double SELECTED_VOLUME_LONG                 =  (EN_Volume_Long); 
double SELECTED_VOLUME_SHORT                =  (EN_Volume_Short);



double FINAL_LONG_VOLUME = SELECTED_VOLUME_LONG;
double FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;


input double   DEVIATION        	                   = 25; // OFFSET - Tolerância - (Valor)
double SELECTED_DEVIATION = DEVIATION;



double Level_tp_long = NULL; 
double Level_tp_short = NULL; 
double Level_sl_long = NULL; 
double Level_sl_short = NULL; 



input int INPUT_EN_EST_ANCHOR_CHOSEN = 0; // EN - ESTRATÉGIA - Ancoragem - (Nº)


input double      EN_Distance_Long     = 25; // EN - DISTÂNCIA - LONG - (Valor)
input double      EN_Distance_Short    = 25; // EN - DISTÂNCIA - SHORT - (Valor)

double SELECTED_EN_DISTANCE_LONG = EN_Distance_Long; 
double SELECTED_EN_DISTANCE_SHORT = EN_Distance_Short;

double      TRAILING_Distance     = 100; // DISTÂNCIA - TS - (Valor)


double      TP_Pts_Adjustment          = 100;
double      SL_Pts_Adjustment          = 100;

double      EN_Percentage_Adjustment          = 0; // input
double      TP_Percentage_Adjustment          = 100; // input
double      SL_Percentage_Adjustment          = 100; // input


input bool TP_ON                     		=  false; // TP - (Ativar)
input int INPUT_TP_EST_ANCHOR_CHOSEN = 0; // TP - ESTRATÉGIA - Ancoragem - (Nº) 
input int INPUT_TP_EST_DISTANCE_CHOSEN = 0; // TP - ESTRATÉGIA - Distäncia - (Nº)
input double      TP_Distance_Long     = 100; // TP - DISTÂNCIA - LONG - (Valor)
input double      TP_Distance_Short    = 100; // TP - DISTÂNCIA - SHORT - (Valor) 


input bool SL_ON    						=  false; // SL - (Ativar)
input int INPUT_SL_EST_ANCHOR_CHOSEN = 0; // SL - ESTRATÉGIA - Ancoragem - (Nº)
input int INPUT_SL_EST_DISTANCE_CHOSEN = 0; // SL - ESTRATÉGIA - Distäncia - (Nº)
input double      SL_Distance_Long     = 100; // SL - DISTÂNCIA -LONG - (Valor)
input double      SL_Distance_Short    = 100; // SL - DISTÂNCIA -SHORT - (Valor)


input int INPUT_TRAILING_STOP_EST_CHOSEN = 0; // TS - ESTRATÉGIA - (Nº)
input int SPD_REVERSE = 0; // TS - ESTRATÉGIA - Redução SPD - (Nº)


bool SELECTED_TP_ON                         = TP_ON;
bool SELECTED_SL_ON                         = SL_ON;


input bool FOLLOW_MODE = true; // FUNÇÃO - Modo Magnético p/ ticket - (Ativar)
input bool FOLLOW_ME_BY_T1 = true; // FUNÇÃO - Modo Magnético p/ segundo  - (Ativar)


double SPD_LEVELS = 0;
string spd;


input double MIN_ADD_DISTANCE		                = 0; // FUNÇÃO - Distância Mínima - Próxima Adição - (Valor)
double SELECTED_MIN_ADD_DISTANCE = MIN_ADD_DISTANCE;

input double MIN_REDUCE_DISTANCE		                    = 0; // FUNÇÃO - Distância Mínima - Próxima Realização - (Valor)
double SELECTED_MIN_REDUCE_DISTANCE = MIN_REDUCE_DISTANCE;

//input double SPD_REVERSE_VOL = ; // valor - volume de reversão SPD

input bool BUY_FIRST = false; // FUNÇÃO - Sempre na Compra - Swing Trade - (Ativar) 
bool SELECTED_BUY_FIRST = BUY_FIRST;
input bool SELL_FIRST = false; // FUNÇÃO - Sempre na Venda - Swing Trade - (Ativar)
bool SELECTED_SELL_FIRST = SELL_FIRST;


input bool DYT_BUY_FIRST = false; // FUNÇÃO - Sempre na Compra - Day Trade - (Ativar) 
//bool DYT_BUY_FIRST = DYT_BUY_FIRST; 
input bool DYT_SELL_FIRST = false; // FUNÇÃO - Sempre na Venda - Day Trade - (Ativar) 
//bool SELECTED_DYT_SELL_FIRST = DYT_SELL_FIRST;

input double SPD_REVERSE_VALUE = 0; // PRM - Gatilho de execução SPD - (Valor)


// Distância
input int INPUT_EN_EST_DISTANCE_CHOSEN = 0; // ESTRATÉGIA - Ajuste de DISTÂNCIA - (Nº)
input bool        ADJ_DST_SEQ_MODE_PG        = false; // PRM - Ajustar DISTÂNCIA - por sequência - Modo PG - (Ativar)
input double      ADJ_DST_SEQ_TOL_INI        = 0; // PRM - Ajustar DISTÂNCIA - por sequência - Dê - (Valor)
input double      ADJ_DST_SEQ_TOL_FIM        = 0; // PRM - Ajustar DISTÂNCIA - por sequência - Até - (Valor)
input double      ADJ_DST_SEQ_VALUE        = 0; // PRM - Ajustar DISTÂNCIA - por sequência - (Valor) 
double      SELECTED_ADJ_DST_SEQ        = ADJ_DST_SEQ_VALUE; 



input bool        ADJ_DST_VOL_MODE_PG        = false; // PRM - Ajustar DISTÂNCIA - por volume - Modo PG - (Ativar)
input double      ADJ_DST_VOL_TOL_INI        = 0; // PRM - Ajustar DISTÂNCIA - por volume - Dê - (Valor)
input double      ADJ_DST_VOL_TOL_FIM        = 0; // PRM - Ajustar DISTÂNCIA - por volume - Até - (Valor)
input double      ADJ_DST_VOL_VALUE        = 0; // PRM - Ajustar DISTÂNCIA - por volume - (Valor)
double      SELECTED_ADJ_DST_VOL        = ADJ_DST_VOL_VALUE; 
input double      TOTAL_DST_VALUE_LIMIT_CHANGE        = 0; // PRM - DISTÂNCIA - Ajuste Limite - (Valor)
double     SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE      = 0;   
double SELECTED_ADJ_DST_VOL_TOL_INI = ADJ_DST_VOL_TOL_INI;
double SELECTED_ADJ_DST_VOL_TOL_FIM = ADJ_DST_VOL_TOL_FIM;


// Volume
input int INPUT_EN_EST_VOLUME_CHOSEN = 0; // ESTRATÉGIA - Ajuste de VOLUME - (Nº)
input bool        ADJ_VOL_SEQ_MODE_PG        = false; // PRM - Ajustar VOLUME - por sequência - Modo PG - (Ativar)
input double      ADJ_VOL_SEQ_TOL_INI        = 0; // PRM - Ajustar VOLUME - por sequência - Dê - (Valor)
input double      ADJ_VOL_SEQ_TOL_FIM        = 0; // PRM - Ajustar VOLUME - por sequência - Até - (Valor)
input double      ADJ_VOL_SEQ_VALUE                = 0; // PRM - Ajustar VOLUEM - por sequência - (Valor) 
double      SELECTED_ADJ_VOL_SEQ          = ADJ_VOL_SEQ_VALUE;

input bool        ADJ_VOL_VOL_MODE_PG        = false; // PRM - Ajustar VOLUME - por volume - Modo PG - (Ativar)
input double      ADJ_VOL_VOL_TOL_INI        = 0; // PRM - Ajustar VOLUEM - por volume - Dê - (Valor)
input double      ADJ_VOL_VOL_TOL_FIM        = 0; // PRM - Ajustar VOLUEM - por volume - Até - (Valor)
input double      ADJ_VOL_VOL_VALUE        = 0; // PRM - Ajustar VOLUEM - por volume - (Valor)
double      SELECTED_ADJ_VOL_VOL          = ADJ_VOL_VOL_VALUE;

input double      TOTAL_VOL_VALUE_LIMIT_CHANGE        = 0; // PRM - VOLUME -  Ajuste Limite - (Valor)
double     SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE      = 0;
double SELECTED_ADJ_VOL_VOL_TOL_INI = ADJ_VOL_VOL_TOL_INI;
double SELECTED_ADJ_VOL_VOL_TOL_FIM = ADJ_VOL_VOL_TOL_FIM;



input double MdlTrend_Gravit_Vol = 5; // PARÂMETRO - Mdl Tendência - Volume Gravitacional - (Valor) 
double SELECTED_MDL_GRAVIT_VOL = MdlTrend_Gravit_Vol;

//input double Mdl_Start_Range_ACP_Vol = 10; // PARÂMETRO - Mdl Balance Vol - Gatilho de Realização - (Valor)


input double MdlTrend_Target_Vol = 5; // PARÂMETRO - Mdl Tendência - Volume Alvo - (Valor) 
double SELECTED_MDL_TREND_TARGET_VOL;





input double MdlTrend_AccTargetDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Gatilho de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_TARGET_DISTANCE; 
input double MdlTrend_TprTargetDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Gatilho de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_TARGET_DISTANCE; 
input double MdlTrend_RevFactorDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Fator de Reversão - (Valor)
double SELECTED_MDL_TREND_REV_FACTOR_DISTANCE; 
input double MdlTrend_AccFactorDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Fator de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_FACTOR_DISTANCE; 
input double MdlTrend_TprFactorDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Fator de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_FACTOR_DISTANCE; 
input double MdlTrend_RevValueDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Valor de Reversão - (Valor)
double SELECTED_MDL_TREND_REV_VALUE_DISTANCE; 
input double MdlTrend_AccValueDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Valor de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_VALUE_DISTANCE; 
input double MdlTrend_TprValueDistance = 1; // PARÂMETRO - Mdl Tendência - DISTANCIA - Valor de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_VALUE_DISTANCE; 


input double MdlTrend_AccTargetVolume = 2; // PARÂMETRO - Mdl Tendência - VOLUME - Gatilho de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_TARGET_VOLUME; 
input double MdlTrend_TprTargetVolume = 4; // PARÂMETRO - Mdl Tendência - VOLUME - Gatilho de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_TARGET_VOLUME; 
input double MdlTrend_RevFactorVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Fator de Reversão - (Valor)
double SELECTED_MDL_TREND_REV_FACTOR_VOLUME; 
input double MdlTrend_AccFactorVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Fator de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_FACTOR_VOLUME; 
input double MdlTrend_TprFactorVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Fator de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_FACTOR_VOLUME; 
input double MdlTrend_RevValueVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Valor de Reversão - (Valor)
double SELECTED_MDL_TREND_REV_VALUE_VOLUME; 
input double MdlTrend_AccValueVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Valor de Acumulação - (Valor)
double SELECTED_MDL_TREND_ACC_VALUE_VOLUME; 
input double MdlTrend_TprValueVolume = 1; // PARÂMETRO - Mdl Tendência - VOLUME - Valor de Realização - (Valor)
double SELECTED_MDL_TREND_TPR_VALUE_VOLUME; 



double min_add_buy_modify = 0;
double min_add_sell_modify = 0;
double min_reduce_buy_modify = 0;
double min_reduce_sell_modify = 0;



double CORRETAGEM = 0;

int TREND = 0;


//double HistoricBarTrend[];
//int HistoricBarVolume_Unt[];
double HistoricBar_FinVol[];

int Biggest_OCHL_BarPosition = 0;
int Biggest_Day_BarPosition = 0;


double Before_BreakOut = 0;
double Before_BreakDown = 0;


double Avg_OCHL_Break = 0;
double Avg_OCHL_BreakOut = 0;
double Avg_OCHL_BreakDown = 0;

double Avg_Day_Break = 0;
double Avg_Day_BreakOut = 0;
double Avg_Day_breakDown = 0;


double Biggest_BarSize = 0;
double Biggest_Day_BarSize = 0;

double Avg_OCHL_BarSize = 0;


int Avg_BarVolume_Unt = 0;


int IntradayBar = 0;



bool insideBar = false;
bool insideBarUp = false;
bool insideBarDown = false;

bool Engulf = false;
bool highEngulf = false;
bool downFall = false;

         
bool giftUp = false;
bool giftDown = false;

bool GreenCandle = false;


double Crossed_Level_Ref = 0;

bool Crossed_Price_Up = false;
bool Crossed_Price_Down = false;

bool Bull_Trap = false;
bool Bear_Trap = false;


double current_IN_LONG_LEVEL_REF = 0;
double current_IN_SHORT_LEVEL_REF = 0;


bool CandlePattern_hammer = false;
bool CandlePattern_shooting_star = false;

bool closed_above_level_ref = false;



//TODO
//-média do tamanho por período
//-enclinação das médias
//-posição das médias relativo ao preço e a outras médias
//-sequencia de barraas
//-tamanho das sombras para cima
//-tamanho das sombras para baixo
//-média das sombras
//-média da sobreposição das velas
//-se é trap (sombra grande com fechamento dentro da anterior)
//- fechou acima/abaixo da maior barra




//-intervalHigh
//-intervalHighOpen
//-intervalHighClose
//-intervalLow
//-intervalLowOpen
//-intervalLowClose
//-intervalOpenAVG
//-intervalCloseAVG
//-intervalHighClose
//-intervalCloseAVG
//-intervalBreakCloseAVG
//-intervalBreakHighAVG
//-intervalRetractionAVG
//- contar sequencias de barras e com quantas barras foi a sequência (verificar horários)





