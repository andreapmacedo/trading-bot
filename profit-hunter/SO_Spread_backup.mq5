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

void Sys_Spread_Reset_Vars()
{
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


  Level_Sell = SERVER_SYMBOL_ASK + SELECTED_EN_DISTANCE_SHORT;
  Level_Buy = SERVER_SYMBOL_BID - SELECTED_EN_DISTANCE_LONG;
  currentBuyVolume  = SELECTED_VOLUME_LONG;
  currentSellVolume  = SELECTED_VOLUME_SHORT ;

  SELECTED_TP_ON = TP_ON;
  SELECTED_SL_ON = SL_ON;

}
bool TREND_MODE = false;

int Sys_Spread_v2(int callFrom)
{
  if(callFrom == 1)
  {
      return -1;        
  }

  double temp_vol;
  GetCurrentPositionVolume(temp_vol);

  Sys_Spread_Reset_Vars();

  CountAllOrdersForPairType();

  //if(SELECTED_TRADE_STRATEGY_CHOSEN > 0 && TRADING_STATUS_CHANGED && callFrom != 3)
  //if(TREND_CHANGED)
  //if(TREND_SIDE_CHANGED)
  //if(CurrentTradingStatus == 3 || CurrentTradingStatus == 2)
  if(TRADING_STATUS_CHANGED)
  {
    if(countListening == 1 || countListening == 4)
    //if(CurrentTradingStatus == 2 || CurrentTradingStatus == 3)
    //if(CurrentTradingStatus != 9 || CurrentTradingStatus != 7 || CurrentTradingStatus != 8)
    {
        Print("enforce x");   
        SO_FOLLOW_LOCK = 0;
    }        
    /*
    if(
        //|| CurrentTradingStatus == 5 || CurrentTradingStatus == 6
    )
    {
        if(countListening == 1 )
        {
            SO_FOLLOW_LOCK = 0;
        }
    }
    */
  }
  // Novo segundo
  if(callFrom == 5)
  {
    SO_FOLLOW_LOCK = 0;
  }
  // Ordem executada
  if(callFrom == 3)
  {
    ResetAxlesLevels();
    CountFreezeCentralLevel == 0;
    Print("call from 3");
    SO_FOLLOW_LOCK = 0;
  }
  else if(TotalSymbolOrderBuy == 0 && SELECTED_LONG_POSITION_ON && !SELECTED_SELL_FIRST && !DYT_SELL_FIRST)
  {
    //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
    if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
    {
      SO_FOLLOW_LOCK = 0;
          Print("call from 2 ENFORCE");
    }
    else if(countListening == 1)    
    {
      SO_FOLLOW_LOCK = 0;
      Print("call from 22 ENFORCE");
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
    }
  }
  else if(TotalSymbolOrderSell == 0 && SELECTED_SHORT_POSITION_ON && !SELECTED_BUY_FIRST && !DYT_BUY_FIRST)
  {
    //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
    if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
    {
      SO_FOLLOW_LOCK = 0;
      Print("call from 4 ENFORCE");
    }
    else if(countListening == 1 )
    {
      SO_FOLLOW_LOCK = 0;
      Print("call from 44 ENFORCE");
      ResetAxlesLevels();
      CountFreezeCentralLevel == 0;
    }
  }

  if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE || CurrentStatusSystem == 2)
  {
    SO_FOLLOW_LOCK = 1;
    SetCentalAxles_evo(2);

    
    if(FOLLOW_MODE || temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
    {
      SetAllFlows(); 
      Level_Sell = Lowest_Top;
      Level_Buy = Highest_Bottom;
    }
    else
    {
      Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;
      Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;            
    }
    /*
    Level_Sell = Lowest_Top;
    Level_Buy = Highest_Bottom;
    */
    currentSellVolume = SELECTED_VOLUME_SHORT;
    currentBuyVolume = SELECTED_VOLUME_LONG;

    // Print("Level_Sell -> ", Level_Sell);
    // Print("SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
    // Print("Level_Buy -> ", Level_Buy);
    // Print("SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
    
    
    // avaliar o impacto deste trecho
    // if(Level_Sell == SERVER_SYMBOL_ASK)
    // {
        
    //     Print("== SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
    //     Print("Level_Sell == -> ", Level_Sell);
    //     //return -1;
    //     //Level_Sell += SELECTED_EN_DISTANCE_SHORT;
    // }
    // if(Level_Buy == SERVER_SYMBOL_BID)
    // {
    //     Print("== SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
    //     Print("== Level_Buy -> ", Level_Buy);
    //     //return -1;
    //     //Level_Buy -= SELECTED_EN_DISTANCE_LONG;
    // }





    //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
    if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
    {
      if(pos_status == 0) // 0 = comprado
      {
          
        Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;      

        if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
        {
            SetSpdReverse3();
        }

        // if(SERVER_SYMBOL_BID > Level_Sell)
        // {
        //     Print("call from 4 ENFORCE");
        //     ResetAxlesLevels();
        //     CountFreezeCentralLevel == 0;
        //     Print("Enforce Reset Level_Sell: ", Level_Sell);                
        //     return -1;
        // }


      }
      else
      {
        Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;       

        if(TotalSymbolOrderSell == 0)
        {
            SetSpdReverse3();
        }

        // if(SERVER_SYMBOL_ASK < Level_Buy)
        // {
        //     Print("call from 4 ENFORCE");
        //     ResetAxlesLevels();
        //     CountFreezeCentralLevel == 0;
        //     Print("Enforce Reset Level_Buy: ", Level_Buy);       
        //     return -1;
        // }



      }
    }   
          

      
    // CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
    // CurrentTradingStatus = Trading_Status(1);

    int masterEstInterResponse = 0;
    if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
    {
      masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
    }
    

    if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
    {
      EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
      EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
      //Print("masterEstInterResponse == 0");
    }
    else if(masterEstInterResponse == 2)
    {
      return -1;
    }

    
    if(TopChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
      TopChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

    if(BottomChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
      BottomChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

    if(BuyVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
      BuyVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;

    if(SellVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
      SellVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;
    
    
    Level_Sell += TopChange;
    Level_Buy -= BottomChange;

    currentBuyVolume += BuyVolChange;
    currentSellVolume += SellVolChange;


    //Print("call from 4 ENFORCE");
    //Print("call from 4 ENFORCE");

    // if(LOTVOL_MODE)
    // {        
    //     if(BuyVolChange > 0)
    //     {
    //         BuyVolChange *=  (SERVER_SYMBOL_VOLUME_MIN);
    //     }

    //     if(SellVolChange > 0)
    //     {
    //         SellVolChange *= (SERVER_SYMBOL_VOLUME_MIN);
    //     }
    // }
    // if(BuyVolChange > 0)
    // {
    //     // if(LOTVOL_MODE)
    //     //     BuyVolChange *=  (SERVER_SYMBOL_VOLUME_MIN);


    // }
    // if(SellVolChange > 0)
    // {

    //     // if(LOTVOL_MODE)
    //     //     SellVolChange *= (SERVER_SYMBOL_VOLUME_MIN);

    // }

    // Print("TopChange: ", TopChange);    
    // Print("Lowest_Top: ", Lowest_Top); 

    // Print("-----------------");

    // Print("BottomChange: ", BottomChange);    
    // Print("Highest_Bottom: ", Highest_Bottom);  


    // if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME) && FOLLOW_MODE)
    // {    
    //     if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
    //     {
    //         if(MIN_ADD_DISTANCE > 0)
    //             SetAddChange_Evo();
            
    //         if(MIN_REDUCE_DISTANCE >0)
    //             SetRdcChange_Evo();
    //     }
    // }  

    //if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
    if((temp_vol < SELECTED_LIMIT_POSITION_VOLUME))
    {    
        if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
        {
            if(MIN_ADD_DISTANCE > 0)
                SetAddChange_Evo();
            
            if(MIN_REDUCE_DISTANCE >0)
                SetRdcChange_Evo();
                
        }
    }  
    //// if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
    // if((temp_vol < SELECTED_LIMIT_POSITION_VOLUME))
    // {    
    //     if(pos_volume > 0 )
    //     {
    //         if(MIN_ADD_DISTANCE > 0)
    //         {
    //             SetAddChange_Evo_CPRICE();
    //         }
            
    //         if(MIN_REDUCE_DISTANCE > 0)
    //         {
    //             SetRdcChange_Evo_CPRICE();
    //         }
    //     }
    // }  


    //if(pos_volume < SELECTED_LIMIT_POSITION_VOLUME)
    if(temp_vol < SELECTED_LIMIT_POSITION_VOLUME)
    {
        if(SERVER_SYMBOL_BID > Level_Sell)
        {
            Print("call from 100 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;

            Print("Enforce Reset Level_Sell: ", Level_Sell);                
            return -1;
        }
        if(SERVER_SYMBOL_ASK < Level_Buy)
        {
            Print("call from 100 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
            Print("Enforce Reset Level_Buy: ", Level_Buy);       
            return -1;
        }
    }
    if(SELECTED_EN_MODE == 1)
    {

        Set_Order_Limit(callFrom);
        return 2;
    }
  }
  return 0;
}



int Sys_Spread_v1(int callFrom)
{
    //SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME;

    if(callFrom == 1)
    {
        return -1;        
    }    



    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    Sys_Spread_Reset_Vars();

    CountAllOrdersForPairType();

    //if(SELECTED_TRADE_STRATEGY_CHOSEN > 0 && TRADING_STATUS_CHANGED && callFrom != 3)
    //if(TREND_CHANGED)
    //if(TREND_SIDE_CHANGED)
    //if(CurrentTradingStatus == 3 || CurrentTradingStatus == 2)
    if(TRADING_STATUS_CHANGED)
    {
        if(countListening == 1 || countListening == 4)
        //if(CurrentTradingStatus == 2 || CurrentTradingStatus == 3)
        //if(CurrentTradingStatus != 9 || CurrentTradingStatus != 7 || CurrentTradingStatus != 8)
        {
            Print("enforce x");   
            SO_FOLLOW_LOCK = 0;
        }        
        /*
        if(
            //|| CurrentTradingStatus == 5 || CurrentTradingStatus == 6
        )
        {
            if(countListening == 1 )
            {
                SO_FOLLOW_LOCK = 0;
            }
        }
        */
    }

    //ChangeTradingStatus();
    //ChangeTrend();
    //NewSignal();

    

    //if(ChangeTradingStatus() || ChangeTrend())

    // if(ChangeTrend())
    // {
    //     Print("call from 9");
    //     Set_Reverse(1);
    //     if(SELECTED_EN_MODE == 1)
    //     {
    //         Set_Order_Limit(callFrom);
    //         return 9;
    //     }
    // }

    // if(CurrentTradingStatus == 2 || CurrentTradingStatus == 3)
    // if(ChangeTrend())
    // {
    //     ResetAxlesLevels();
    //     CountFreezeCentralLevel == 0;
    //     SetCentalAxles_evo(2);
    //     SetAllFlows();

    //     Print("call from 9");
    //     Set_Reverse(2);
    //     if(SELECTED_EN_MODE == 1)
    //     {
    //         Set_Order_Limit(callFrom);
    //         return 9;
    //     }
    // }
    //if(ChangeTradingStatus())
    
    
    //if((CurrentTradingStatus == 2 || CurrentTradingStatus == 3 ||CurrentTradingStatus == 5 || CurrentTradingStatus == 6 ))
    /*
    if((CurrentTradingStatus == 2 || CurrentTradingStatus == 3 ))
    {
        
        // ResetAxlesLevels();
        // CountFreezeCentralLevel == 0;

        Print("call from 9");
        // Set_Reverse(2);
        SO_FOLLOW_LOCK = 0;
        // if(SELECTED_EN_MODE == 1)
        // {
        //     Set_Order_Limit(callFrom);
        //     return 9;
        // }
    }
    */

    //identificador de sinais e tendência
    // if(callFrom == 3)
    // {
        //  neste local, pelo monitoramento do spd, habilitaremos uma chamada para exec. de ordem a mercado de proteção/reversão
            // monitorar quanto o último negócio está afastado das ordens e do pm
            //Print("call from 9");
            //SO_FOLLOW_LOCK = 0;

    // mindstorm
        // pode realizar um procedimento que idicado um sinal de reversão, cancela as ordens e obriga o algo a refaze-las

    // }



    if(callFrom == 5)
    {
        SO_FOLLOW_LOCK = 0;
    }

    if(callFrom == 3)
    {
        ResetAxlesLevels();
        CountFreezeCentralLevel == 0;
        Print("call from 3");
        SO_FOLLOW_LOCK = 0;
    }
    else if(TotalSymbolOrderBuy == 0 && SELECTED_LONG_POSITION_ON && !SELECTED_SELL_FIRST && !DYT_SELL_FIRST)
    {
        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SO_FOLLOW_LOCK = 0;
                Print("call from 2 ENFORCE");
        }
        else if(countListening == 1)    
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 22 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
        }
    }
    else if(TotalSymbolOrderSell == 0 && SELECTED_SHORT_POSITION_ON && !SELECTED_BUY_FIRST && !DYT_BUY_FIRST)
    {
        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 4 ENFORCE");
        }
        else if(countListening == 1 )
        {
            SO_FOLLOW_LOCK = 0;
            Print("call from 44 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
        }
    }

    if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE || CurrentStatusSystem == 2)
    {
        SO_FOLLOW_LOCK = 1;
        SetCentalAxles_evo(2);

        
        if(FOLLOW_MODE || temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SetAllFlows(); 
            Level_Sell = Lowest_Top;
            Level_Buy = Highest_Bottom;
        }
        else
        {
            Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;
            Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;            
        }
        /*
        Level_Sell = Lowest_Top;
        Level_Buy = Highest_Bottom;
        */
        currentSellVolume = SELECTED_VOLUME_SHORT;
        currentBuyVolume = SELECTED_VOLUME_LONG;

        // Print("Level_Sell -> ", Level_Sell);
        // Print("SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        // Print("Level_Buy -> ", Level_Buy);
        // Print("SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
        
        
        // avaliar o impacto deste trecho
        // if(Level_Sell == SERVER_SYMBOL_ASK)
        // {
            
        //     Print("== SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        //     Print("Level_Sell == -> ", Level_Sell);
        //     //return -1;
        //     //Level_Sell += SELECTED_EN_DISTANCE_SHORT;
        // }
        // if(Level_Buy == SERVER_SYMBOL_BID)
        // {
        //     Print("== SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
        //     Print("== Level_Buy -> ", Level_Buy);
        //     //return -1;
        //     //Level_Buy -= SELECTED_EN_DISTANCE_LONG;
        // }





        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0) // 0 = comprado
            {
                
                Level_Buy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;      

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_BID > Level_Sell)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset Level_Sell: ", Level_Sell);                
                //     return -1;
                // }


            }
            else
            {
                Level_Sell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;       

                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_ASK < Level_Buy)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset Level_Buy: ", Level_Buy);       
                //     return -1;
                // }



            }
        }   
            

        
        // CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
        // CurrentTradingStatus = Trading_Status(1);

        int masterEstInterResponse = 0;
        if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
        {
            masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
        }
        

        if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
            //Print("masterEstInterResponse == 0");
        }
        else if(masterEstInterResponse == 2)
        {
            return -1;
        }

        
        if(TopChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
            TopChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

        if(BottomChange > SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
            BottomChange = SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE;

        if(BuyVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
            BuyVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;

        if(SellVolChange > SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE && SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE > 0)
            SellVolChange = SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE;
        
        
        Level_Sell += TopChange;
        Level_Buy -= BottomChange;

        currentBuyVolume += BuyVolChange;
        currentSellVolume += SellVolChange;


        //Print("call from 4 ENFORCE");
        //Print("call from 4 ENFORCE");
	
        // if(LOTVOL_MODE)
        // {        
        //     if(BuyVolChange > 0)
        //     {
        //         BuyVolChange *=  (SERVER_SYMBOL_VOLUME_MIN);
        //     }

        //     if(SellVolChange > 0)
        //     {
        //         SellVolChange *= (SERVER_SYMBOL_VOLUME_MIN);
        //     }
        // }
        // if(BuyVolChange > 0)
        // {
        //     // if(LOTVOL_MODE)
        //     //     BuyVolChange *=  (SERVER_SYMBOL_VOLUME_MIN);


        // }
        // if(SellVolChange > 0)
        // {

        //     // if(LOTVOL_MODE)
        //     //     SellVolChange *= (SERVER_SYMBOL_VOLUME_MIN);

        // }

        // Print("TopChange: ", TopChange);    
        // Print("Lowest_Top: ", Lowest_Top); 

        // Print("-----------------");

        // Print("BottomChange: ", BottomChange);    
        // Print("Highest_Bottom: ", Highest_Bottom);  


        // if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME) && FOLLOW_MODE)
        // {    
        //     if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
        //     {
        //         if(MIN_ADD_DISTANCE > 0)
        //             SetAddChange_Evo();
                
        //         if(MIN_REDUCE_DISTANCE >0)
        //             SetRdcChange_Evo();
        //     }
        // }  

        //if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
        if((temp_vol < SELECTED_LIMIT_POSITION_VOLUME))
        {    
            if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
            {
                if(MIN_ADD_DISTANCE > 0)
                    SetAddChange_Evo();
                
                if(MIN_REDUCE_DISTANCE >0)
                    SetRdcChange_Evo();
                    
            }
        }  
        //// if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
        // if((temp_vol < SELECTED_LIMIT_POSITION_VOLUME))
        // {    
        //     if(pos_volume > 0 )
        //     {
        //         if(MIN_ADD_DISTANCE > 0)
        //         {
        //             SetAddChange_Evo_CPRICE();
        //         }
                
        //         if(MIN_REDUCE_DISTANCE > 0)
        //         {
        //             SetRdcChange_Evo_CPRICE();
        //         }
        //     }
        // }  


        //if(pos_volume < SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol < SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(SERVER_SYMBOL_BID > Level_Sell)
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;

                Print("Enforce Reset Level_Sell: ", Level_Sell);                
                return -1;
            }
            if(SERVER_SYMBOL_ASK < Level_Buy)
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;
                Print("Enforce Reset Level_Buy: ", Level_Buy);       
                return -1;
            }
        }




    /*
        Set_TriggerSignal();
      */      
        if(SELECTED_EN_MODE == 1)
        {

            Set_Order_Limit(callFrom);
            return 2;
        }
    }
    return 0;
}
