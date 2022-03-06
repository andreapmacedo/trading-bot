//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+

enum enum_Trend
{
    eTrend_001                = 1,
    eTrend_002                = 2
};


int Trend_Settings(int chosen)
{
  switch(chosen)
  {
    case 1:
      return Set_Est_Trend__01();
      break;
    default:
      Print("No trend seted");
      break;
  }  
  return 0;
}

double selected_ma_ref = 0; 
input double MaSpreadActivator = 50; // PARÂMETRO TÉCNICO - Tolerância de Spread da Média - (Valor)
double madst = 0;

double top_ma_spread = 0;
double bottom_ma_spread = 0;

int LAST_TREND = 0;
int LAST_TREND_SIDE = 0;
bool TREND_CHANGED = false;
bool TREND_SIDE_CHANGED = false;
int count_tend_change = 0;
double level_increment = 0;

int Set_Est_Trend__01(){
  // Print("");

  // if(LAST_TREND != CurrentTrend)
  // {
  //     TREND_CHANGED = true;
  //     Print("TREND_CHANGED!!!");
  //     // if(CurrentTrend == 1)
  //     // {
  //     //   level_increment -= (SERVER_SYMBOL_TRADE_TICK_SIZE * 1);
  //     // }
  //     // else if(CurrentTrend == -1)
  //     // {
  //     //   level_increment += (SERVER_SYMBOL_TRADE_TICK_SIZE * 1);
  //     // }
  //     //count_tend_change = 1;
  // }
  // else
  // {
  //     TREND_CHANGED = false;
  // }

  // LAST_TREND = CurrentTrend;

  int result = 0;
  Set_MA_Period();
  //double selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double selected_ma_fast = Get_MA_TF(MainMaPeriod, MA_Period, MA_FAST_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  selected_ma_ref = selected_ma_fast;
  //double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double previous_selected_ma_fast = Get_MA_TF(MainMaPeriod, MA_Period, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  madst = selected_ma_fast - previous_selected_ma_fast;
  // Print("madst: ", madst);
  // Print("level_increment: ", level_increment );
  // if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
  // {
  //   top_ma_spread = (Freeze_Central_Top - selected_ma_ref);
  //   bottom_ma_spread = (selected_ma_ref - Freeze_Central_Bottom);
  // }
  if(
      //previous_selected_ma_fast < selected_ma_fast
      //madst > (SERVER_SYMBOL_TRADE_TICK_SIZE * 1)
      //madst > 0 
      madst > (level_increment + (SERVER_SYMBOL_TRADE_TICK_SIZE * 1))
      //&& SymbolInfoDouble(_Symbol, SYMBOL_BID) > selected_ma_fast
      //&& PriceInfo[1].close > selected_ma_fast
      )
  {
      // if(TREND_CHANGED)
      // {
      //   level_increment -= (SERVER_SYMBOL_TRADE_TICK_SIZE * 1);
      // }
      previous_selected_ma_fast = selected_ma_fast;
      result = 1;
      //return 1;
  }
  else if(
      //previous_selected_ma_fast > (selected_ma_fast 
      //madst < 0
      madst < (level_increment - (SERVER_SYMBOL_TRADE_TICK_SIZE * 1))
      //madst < (SERVER_SYMBOL_TRADE_TICK_SIZE * 1)
      //&& SymbolInfoDouble(_Symbol, SYMBOL_ASK) < selected_ma_fast
      //&& PriceInfo[1].close < selected_ma_fast
      )
  {
      // if(TREND_CHANGED)
      // {
      //   level_increment += (SERVER_SYMBOL_TRADE_TICK_SIZE * 1);
      // }
      previous_selected_ma_fast = selected_ma_fast;
      result =  -1;
      //return -1;
  }
  else
  {
    result = 0;
  }

  LAST_TREND = CurrentTrend;
  CurrentTrend = result;
  


  if(LAST_TREND != CurrentTrend)
  {

    TREND_CHANGED = true;
    //Print("TREND_CHANGED!");
    if(CurrentTrend != 0)
    {
      //Print("LAST_TREND_SIDE_changed!");
     // Print("CurrentTrend! ", CurrentTrend);
     // Print("LAST_TREND_SIDE! ", LAST_TREND_SIDE);
      
      if(LAST_TREND_SIDE == 0)
      {
        
        LAST_TREND_SIDE = CurrentTrend;
      }
      if(LAST_TREND_SIDE != CurrentTrend)
      {
        TREND_SIDE_CHANGED = true;
        LAST_TREND_SIDE = CurrentTrend;
        Print("TREND_SIDE_CHANGED!");
      }
      else
      {
        TREND_SIDE_CHANGED = false;
      }
    }
    else
    {
      TREND_SIDE_CHANGED = false;
    }
  }
  else
  {
    TREND_CHANGED = false;
    TREND_SIDE_CHANGED = false;
  } 
  previous_selected_ma_fast = selected_ma_fast;
  return result;
}

int Set_Est_Trend__02()
{

  // ESTRATÉGIA COM DUAS médias e várias situações de retorno


  // retorno para região de afastamento da média e de afastamento de médias
  // inclinação de média
  // reversão
  // cruzamento 

  LAST_TREND = CurrentTrend;
  Set_MA_Period();

  //double selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double selected_ma_fast = Get_MA_TF(MainMaPeriod, MA_Period, MA_FAST_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  
  
  selected_ma_ref = selected_ma_fast;
  //double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double previous_selected_ma_fast = Get_MA_TF(MainMaPeriod, MA_Period, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  

  
  if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
  {
  top_ma_spread = (Freeze_Central_Top - selected_ma_ref);
  bottom_ma_spread = (selected_ma_ref - Freeze_Central_Bottom);
  }
 
  if(
      previous_selected_ma_fast < selected_ma_fast
      //&& SymbolInfoDouble(_Symbol, SYMBOL_BID) > selected_ma_fast
      //&& PriceInfo[1].close > selected_ma_fast
      )
  {
      previous_selected_ma_fast = selected_ma_fast;
      return 1;
  }
  else if(
      previous_selected_ma_fast > selected_ma_fast
      //&& SymbolInfoDouble(_Symbol, SYMBOL_ASK) < selected_ma_fast
      //&& PriceInfo[1].close < selected_ma_fast
      )
  {
      previous_selected_ma_fast = selected_ma_fast;
      return -1;
  }
  previous_selected_ma_fast = selected_ma_fast;
  return 0;
}

void Set_Est_Trend__Cross_MA_02(int &trend)
{
  double selected_ma_fast = MyRound2(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double previous_selected_ma_fast = MyRound2(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double ma_spread = selected_ma_fast - previous_selected_ma_fast;


  //--- Identificador de tendência
  if(
      previous_selected_ma_fast < selected_ma_fast
      && SymbolInfoDouble(_Symbol, SYMBOL_BID) > selected_ma_fast
      //&& PriceInfo[1].close > selected_ma_fast
      )
  {
      trend = 1;
  }
  else if(
      previous_selected_ma_fast > selected_ma_fast
      && SymbolInfoDouble(_Symbol, SYMBOL_ASK) < selected_ma_fast
      //&& PriceInfo[1].close < selected_ma_fast
      )
  {
      trend = -1;
  }
  TREND = trend;
}

void Set_Est_Trend__Cross_MA(int &trend)
{
  double selected_ma_fast = MyRound2(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  double previous_selected_ma_fast = MyRound2(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double ma_spread = selected_ma_fast - previous_selected_ma_fast;


  //--- Identificador de tendência
  if(
      previous_selected_ma_fast < selected_ma_fast
      //&& SymbolInfoDouble(_Symbol, SYMBOL_BID) > selected_ma_fast
      //&& PriceInfo[1].close > selected_ma_fast
      )
  {
      trend = 1;
  }
  else if(
      previous_selected_ma_fast > selected_ma_fast
      //&& SymbolInfoDouble(_Symbol, SYMBOL_ASK) < selected_ma_fast
      //&& PriceInfo[1].close < selected_ma_fast
      )
  {
      trend = -1;
  }

  TREND = trend;
    
}

void Set_Est_Trend__MidLevel(int &trend)
{
  double midLevel = GetMidLevelRange();
  if(
    SymbolInfoDouble(_Symbol, SYMBOL_BID) > midLevel
    )
  {
    trend = 1;
  }
  else if(
    SymbolInfoDouble(_Symbol, SYMBOL_ASK) < midLevel
    )
  {
    trend = -1;
  }
  TREND = trend;
    
}