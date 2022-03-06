// callFrom = 1 (nova barra)
// callFrom = 2 (novo negócio)
// callFrom = 3 (ordem executada)
// callFrom = 4 (nova barra)
// callFrom = 5 (novo segundo)



#include "SO_Follow_Settings.mq5" // mudar para o main para que suas funções possam ser aproveitadas
#include "SO_Follow_Settings_Evo.mq5"

double CurrentPositionVol;// = MyGetVolumePosition();
int CurrentPositionSide;// = MyGetPosition();
//int CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN);
int CurrentTrend;// = Trend_Settings(eTrend_001);

int CurrentTradingStatus = 0;

double TopChange = 0;
double BottomChange = 0;

double BuyVolChange = 0;
double SellVolChange = 0;

bool BUY_TREND_OK = true;
bool SELL_TREND_OK = true;

bool TREND_MODE = false;

void SoSpreadResetVars(){
  min_add_buy_modify = 0;
  min_add_sell_modify = 0;
  min_reduce_buy_modify = 0;
  min_reduce_sell_modify = 0;

  BUY_TREND_OK = true;
  SELL_TREND_OK = true;


  BREAK_MODE = false;

  TopChange = 0;
  BottomChange = 0;
  BuyVolChange = 0;
  SellVolChange = 0;


  CurrentLevelSell = SERVER_SYMBOL_ASK + SELECTED_EN_DISTANCE_SHORT;
  CurrentLevelBuy = SERVER_SYMBOL_BID - SELECTED_EN_DISTANCE_LONG;
  currentBuyVolume  = SELECTED_VOLUME_LONG;
  currentSellVolume  = SELECTED_VOLUME_SHORT ;

  SELECTED_TP_ON = TP_ON;
  SELECTED_SL_ON = SL_ON;

}

int Sys_Spread_v1(int callFrom){
  
  // Caso a chamada venha por uma nova barra
  if(callFrom == 1){
    return -1;        
  }

  //-- Volume da estratégia.  
  double currentPositionVolume;
  GetCurrentPositionVolume(currentPositionVolume);
  
  //-- Reseta os parâmetros da estratégia.  
  SoSpreadResetVars();

  //-- Atualiza a contagem de ordens do par negociado.
  CountAllOrdersForPairType();

  //-- Verifica se classificação sofreu alguma mudança de status (tendencia mudou, etc...)
  if(TRADING_STATUS_CHANGED)
  {
    if(countListening == 1 || countListening == 4) {
      Print("callFrom TRADING_STATUS_CHANGED");
      SysSpreadBuild(callFrom);
      return -10;   
    }        
  }

  //-- A cada novo segundo há uma necessidade de atualização. necessário para o caso de um ativo com baixa liquidez que fica muito tempo sem negócios.
  if(callFrom == 5) {
    // Print("call from 5");
    SysSpreadBuild(callFrom);
    return -10;  
  }

  //-- A cada operação há uma necessidade de atualização.
  if(callFrom == 3) {
    ResetAxlesLevels();
    CountFreezeCentralLevel == 0;
    // Print("call from 3");
    SysSpreadBuild(callFrom);
    return -10;  
  } else if (TotalSymbolOrderBuy == 0 && SELECTED_LONG_POSITION_ON && !SELECTED_SELL_FIRST && !DYT_SELL_FIRST) {
    if(currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME) {
      // Print("call from 2 ENFORCE currentPositionVolume: " + currentPositionVolume);
      SysSpreadBuild(callFrom);
      return -10;
    } else if(countListening == 1) {
      // Print("call from 22 ENFORCE");
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
      SysSpreadBuild(callFrom);
      return -10;
    }
  } else if(TotalSymbolOrderSell == 0 && SELECTED_SHORT_POSITION_ON && !SELECTED_BUY_FIRST && !DYT_BUY_FIRST) {
    if(currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME) {
      // Print("call from 4 ENFORCE");
      SysSpreadBuild(callFrom);
      return -10;
    } else if(countListening == 1 ) {
      // Print("call from 44 ENFORCE");
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
      SysSpreadBuild(callFrom);
      return -10;
    }
  }
  if(FOLLOW_MODE) {
    // Print("FOLLOW_MODE");
    SysSpreadBuild(callFrom);
    return -10;
  }
  if(CurrentStatusSystem == 2) {
    // Print("CurrentStatusSystem == 2");
    SysSpreadBuild(callFrom);
    return -10;
  }
  return 0;
}

int SysSpreadBuild(int callFrom){

  //-- Volume da estratégia.  
  double currentPositionVolume;
  GetCurrentPositionVolume(currentPositionVolume);

  //-- Define o volume inicial da ordem de acordo com o estabelecido pelo usuário.
  currentSellVolume = SELECTED_VOLUME_SHORT;
  currentBuyVolume = SELECTED_VOLUME_LONG;


  //-- Estabelece o eixo central com distância entre o nível de compra e venda estabelecidos pelo usuário.
  SetCentalAxles_evo(2);
  
  //-- Caso o modelo escolhido pelo usuário seja o de acompanhamento de máximas/mínimas ou caso o volume da posição tenha
  // alcançado o limite estabelecido pelo usuário, as ordens precisam ser atualizadas
  if(
    FOLLOW_MODE
    || FOLLOW_ME_BY_T1
    || currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME
    || currentPositionVolume == 0
    // || callFrom == 5
    ) {
    // Print("Estamos dentro!!!");
    SetAllFlows(); 
    CurrentLevelSell = Lowest_Top;
    CurrentLevelBuy = Highest_Bottom;
  } else {
    // Print("Estamos fora!!!");
    CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;
    CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;            
  }
  /*
  CurrentLevelSell = Lowest_Top;
  CurrentLevelBuy = Highest_Bottom;
  */


  //-- Verifica se o volume da posição é maior ou igual ao estabelecido pelo usuário.
  if(currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME)
  {
    if(pos_status == 0) { // (0) Comprado
      CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;      
      if(TotalSymbolOrderBuy == 0) {// só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
        SetSpdReverse3();
      }
    } else { // Vendido
      CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;       
      if(TotalSymbolOrderSell == 0) {
        SetSpdReverse3();
      }
    }
  } 
  // Já está sendo chamada do routine    
  // CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
  // CurrentTradingStatus = Trading_Status(1);
  Print("CurrentTrend: " + CurrentTrend);
  // Chamada para estratégias mestras
  

  
  
  int masterEstInterResponse = 0;
  if(SELECTED_TRADE_STRATEGY_CHOSEN > 0) {
    masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
  }
  
  // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
  if(masterEstInterResponse == 0) {
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
  } else if (masterEstInterResponse == 2) {
    return -1;
  }

  // verifica foi escolhida uma estratégia de tendência 
  if(SELECTED_EST_TREND_CHOSEN > 0){
    // pode ser ajustado o tamanho mínimo e máximo da posição
    // temp // estrategia
    if(CurrentTrend > 0)
      SELECTED_MINIMUN_POSITION_VOLUME = 1;
    else if (CurrentTrend < 0)
    SELECTED_MINIMUN_POSITION_VOLUME = 0;
    SELECTED_BUY_FIRST = false;
  }

  //-- Verifica se após as modificações dos ajustes da distancia e volume pelos fatores de tendência e estratégias os parâmetros retornados atendem aos limites de segurança
  // estabelecidos pelo usuário.
  if(TopChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
    TopChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

  if(BottomChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
    BottomChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

  if(BuyVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
    BuyVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;

  if(SellVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
    SellVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;
  
  
  CurrentLevelSell += TopChange;
  CurrentLevelBuy -= BottomChange;

  currentBuyVolume += BuyVolChange;
  currentSellVolume += SellVolChange;

  if(currentPositionVolume < SELECTED_LIMIT_POSITION_VOLUME){    
    if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0){
      if(MIN_ADD_DISTANCE > 0)
        SetAddChange_Evo();
      if(MIN_REDUCE_DISTANCE >0)
        SetRdcChange_Evo();
    }
  }  
  // Verifica 
  if(currentPositionVolume < SELECTED_LIMIT_POSITION_VOLUME){
    if(SERVER_SYMBOL_BID > CurrentLevelSell) {
      Print("call from 100 ENFORCE"); // chamada aqui
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
      Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
      return -1;
    }
    if(SERVER_SYMBOL_ASK < CurrentLevelBuy) {
      Print("call from 100 ENFORCE");
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
      Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
      return -1;
    }
  }
  if(SELECTED_EN_MODE == 1) {
    Set_Order_Limit(callFrom);
    return 2;
  }
  
  return 0;

}

