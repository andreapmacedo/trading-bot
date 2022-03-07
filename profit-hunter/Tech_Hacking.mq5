//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+


// #include "Tech_Trading_Status_01.mq5"
// #include "Tech_Trading_Status_02.mq5"
// #include "Tech_Trading_Status_03.mq5"
// #include "Tech_Trading_Status_04.mq5"
// #include "Tech_Trading_Status_05.mq5"

// enum enum_Trading_Status
// {
//   eTrading_001                = 1,
//   eTrading_002                = 2   
// };


int setHacking(int chosen)
{
  switch(chosen)
  {
    case 1:
      return hacking_0_0_1();
      break;            
    case 2:
      return hacking_0_0_2();
      break;            
    case 3:
      return hacking_0_0_3();
      break;            
    case 4:
      return hacking_0_0_4();
      break;            
  }
  return 0;    
}


int hacking_0_0_1(){
  if(CurrentTrend > 0){
    SELECTED_BUY_FIRST = true;
    SELECTED_SELL_FIRST = false;
  } else if (CurrentTrend < 0){
    SELECTED_BUY_FIRST = false;
    SELECTED_SELL_FIRST = true;
  }
  return 0;
}

int hacking_0_0_2(){
  if(CurrentTrend > 0){
    SELECTED_MINIMUN_POSITION_VOLUME = 1;
    SELECTED_BUY_FIRST = true;
    SELECTED_SELL_FIRST = false;
  } else if (CurrentTrend < 0){
    SELECTED_BUY_FIRST = false;
    SELECTED_SELL_FIRST = true;
    SELECTED_MINIMUN_POSITION_VOLUME = 0;
  }
  return 0;
}

int hacking_0_0_3(){
  if(CurrentTrend > 0){
    SELECTED_MINIMUN_POSITION_VOLUME = 1;
    SELECTED_BUY_FIRST = true;
    SELECTED_SELL_FIRST = false;
  } else if (CurrentTrend < 0){
    SELECTED_BUY_FIRST = false;
    SELECTED_SELL_FIRST = true;
    SELECTED_MINIMUN_POSITION_VOLUME = 0;
    SELECTED_LIMIT_POSITION_VOLUME = 1;
  }
  return 0;
}

int hacking_0_0_4(){
  if(CurrentTrend > 0){
    SELECTED_MINIMUN_POSITION_VOLUME = 2;
    SELECTED_BUY_FIRST = true;
    SELECTED_SELL_FIRST = false;
  } else if (CurrentTrend < 0){
    SELECTED_BUY_FIRST = false;
    SELECTED_SELL_FIRST = true;
    SELECTED_MINIMUN_POSITION_VOLUME = 0;
    SELECTED_LIMIT_POSITION_VOLUME = 1;
  }
  return 0;
}