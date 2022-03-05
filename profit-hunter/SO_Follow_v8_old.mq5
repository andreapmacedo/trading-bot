



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


    CurrentLevelSell = SERVER_SYMBOL_ASK + SELECTED_EN_DISTANCE_SHORT;
    CurrentLevelBuy = SERVER_SYMBOL_BID - SELECTED_EN_DISTANCE_LONG;
    currentBuyVolume  = SELECTED_VOLUME_LONG;
    currentSellVolume  = SELECTED_VOLUME_SHORT ;

    SELECTED_TP_ON = TP_ON;
    SELECTED_SL_ON = SL_ON;

}



// int Sys_Follow_4_9_3(int callFrom)
// {

//     if(callFrom == 1)
//     {
//         // chamada de status de trade por fechamento (verifica se deu entrada ou saida por sinal de fechamento de vela)
//         return -1;        
//     }

//     TopChange = 0;
//     BottomChange = 0;
//     int masterEstInterResponse = 0;


//     switch(callFrom) 
//     {
//         // case 1:
//         //     return -1;
//         //     break; 
//         case 2:
//             break;                                          
//         case 3:
//             ResetAxlesLevels();
//             //return -1;
//             break; 
//     }

//     SetCentalAxles_evo(1);
//     //SetCentalAxles_BA();
//     SetAllFlows();
            

//     if(!FOLLOW_MODE)
//     {
//         if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
//         {
//             CurrentLevelSell = Freeze_Central_Top + EN_Distance_Short;
//             CurrentLevelBuy = Freeze_Central_Bottom - EN_Distance_Long;
//         }
//         else
//         {
//             CurrentLevelSell = Lowest_Top;
//             CurrentLevelBuy = Highest_Bottom;
//         }

//     }   
//     else
//     {
//         CurrentLevelSell = Lowest_Top;
//         CurrentLevelBuy = Highest_Bottom;
//     }
        
//     currentSellVolume = SELECTED_VOLUME_SHORT;
//     currentBuyVolume = SELECTED_VOLUME_LONG;
    
    
//     CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
//     CurrentTradingStatus = Trading_Status(1);



//     if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
//     {
//         masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
//     }
    

//     if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
//     {
//         EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
//         Set_OrderVolume(SELECTED_EST_VOLUME_CHOSEN);
//     }

//     CurrentLevelSell +=  TopChange;
//     CurrentLevelBuy -= BottomChange;
//     SetSpdReverse2();

//     // if(!(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME))
//     // {
//     //     SetAddChange(CurrentLevelSell, CurrentLevelBuy);
//     //     SetRdcChange(CurrentLevelSell, CurrentLevelBuy);
//     // }


//     // if(CurrentLevelBuy > SERVER_SYMBOL_ASK)
//     // {
//     //     ResetAxlesLevels();
//     //     Print("enforce CurrentLevelBuy 2.0");
//     // }
//     // if(CurrentLevelSell < SERVER_SYMBOL_BID)
//     // {
//     //     ResetAxlesLevels();
//     //     Print("enforce CurrentLevelSell 2.0");
//     // }
    


//     if(pos_volume < SELECTED_LIMIT_POSITION_VOLUME)
//     {    
//         if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
//         {
//             SetAddChange_Evo();
//             SetRdcChange_Evo();
//         }
//     }




//     if(SELECTED_EN_MODE == 1)
//     {
//         Set_Place_Order_Dev();
//         //Print("Retornei 2");
//         return 2;
//     }

//     if(SELECTED_EN_MODE == 2)
//     {
//         Set_Trigger_Order_Dev();
//         return 3;
//     }

//     //Print("Retornei 0");
//     return 0;
// }







bool TREND_MODE = false;

int Sys_Follow_4_9_5_atual(int callFrom)
{
    //SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME;

    if(callFrom == 1)
    {
        return -1;        
    }    

    SELL_TREND_OK = true;
    BUY_TREND_OK = true;

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    
    //SO_Follow_8_TopDisplay();
    Sys_Spread_Reset_Vars();


    if(TREND_MODE)
    {
        if(CurrentTrend == 1)
        {
            //SELECTED_BUY_FIRST = true;
            //SELECTED_SELL_FIRST = false;
            if(pos_status == 1)
            {
                SELECTED_LIMIT_POSITION_VOLUME = 3;
            }
        }
        else if(CurrentTrend == -1)
        {
            //SELECTED_SELL_FIRST = true;
           // SELECTED_BUY_FIRST = false;
            if(pos_status == 0)
            {
                SELECTED_LIMIT_POSITION_VOLUME = 3;

            }
        }
        // else
        // {
        //     SELECTED_SELL_FIRST = false;
        //     SELECTED_BUY_FIRST = false;            
        // }        
    }

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
        //else if(countListening == 1 || countListening == 3)
        else    
        {
            // if(CurrentTradingStatus != 5 && CurrentTradingStatus != 6)
            // {
                SO_FOLLOW_LOCK = 0;
                Print("call from 22 ENFORCE");
                //ResetTopAxlesLevels();
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;
                
           // }
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
        //else if(countListening == 1 || countListening == 3)
        else    
        {
           // if(CurrentTradingStatus != 5 && CurrentTradingStatus != 6)
           // {
                SO_FOLLOW_LOCK = 0;
                Print("call from 44 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;
              //ResetBottomAxlesLevels();

                
          //  }
        }
    }

    if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE)
    {
        SO_FOLLOW_LOCK = 1;
        SetCentalAxles_evo(2);
        /*
        SetAllFlows();            
        */
        
        
  

        if(FOLLOW_MODE)
        {
            SetAllFlows(); 
            CurrentLevelSell = Lowest_Top;
            CurrentLevelBuy = Highest_Bottom;
        }
        else
        {
            CurrentLevelSell = Central_Top + SELECTED_EN_DISTANCE_SHORT;
            CurrentLevelBuy = Central_Bottom - SELECTED_EN_DISTANCE_LONG;            
        }
        /*
        CurrentLevelSell = Lowest_Top;
        CurrentLevelBuy = Highest_Bottom;
        */
        currentSellVolume = SELECTED_VOLUME_SHORT;
        currentBuyVolume = SELECTED_VOLUME_LONG;

        // Print("CurrentLevelSell -> ", CurrentLevelSell);
        // Print("SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        // Print("CurrentLevelBuy -> ", CurrentLevelBuy);
        // Print("SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);


        if(CurrentLevelSell == SERVER_SYMBOL_ASK)
        {
            
            Print("CurrentLevelSell == SERVER_SYMBOL_ASK -> ", SELECTED_EN_DISTANCE_SHORT);
            //return -1;
            //CurrentLevelSell += SELECTED_EN_DISTANCE_SHORT;
        }
        if(CurrentLevelBuy == SERVER_SYMBOL_BID)
        {
            Print("CurrentLevelBuy == SERVER_SYMBOL_BID -> ", SELECTED_EN_DISTANCE_LONG);
            //return -1;
            //CurrentLevelBuy -= SELECTED_EN_DISTANCE_LONG;
        }





        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0) // 0 = comprado
            {
                
                CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG; //(changed)       

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_BID > CurrentLevelSell)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
                //     return -1;
                // }


            }
            else
            {
                CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT; //(changed)       

                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
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
        if(SERVER_SYMBOL_BID > CurrentLevelSell)
        {
            Print("call from 4 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;

            Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
            return -1;
        }
        if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
        {
            Print("call from 4 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
            Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
            return -1;
        }
    }


    // deve ser levado para dentro da estratégia 
    // if((CurrentTradingStatus == 2 || CurrentTradingStatus == 3))
    // {
    //     if(pos_status == 0)
    //     {
    //         //currentSellVolume += SELECTED_VOLUME_SHORT;
    //         //CurrentLevelSell = SERVER_SYMBOL_BID;
    //         CurrentLevelSell = SERVER_SYMBOL_ASK;
    //     }
    //     if(pos_status == 1)
    //     {
    //         //currentBuyVolume +=  SELECTED_VOLUME_LONG;
    //         CurrentLevelBuy = SERVER_SYMBOL_BID;
    //         //CurrentLevelBuy = SERVER_SYMBOL_ASK;
    //     }        
    // }
    // else if(CurrentTradingStatus == 5)
    // {
    //     CurrentLevelBuy = SERVER_SYMBOL_BID;
    //     CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
    //     SELL_TREND_OK = false;
    // }
    // else if(CurrentTradingStatus == 6)
    // {
    //     CurrentLevelSell = SERVER_SYMBOL_ASK;
    //     CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     BUY_TREND_OK = false;
    // }

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


// Este

int Sys_Spread(int callFrom)
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
            CurrentLevelSell = Lowest_Top;
            CurrentLevelBuy = Highest_Bottom;
        }
        else
        {
            CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;
            CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;            
        }
        /*
        CurrentLevelSell = Lowest_Top;
        CurrentLevelBuy = Highest_Bottom;
        */
        currentSellVolume = SELECTED_VOLUME_SHORT;
        currentBuyVolume = SELECTED_VOLUME_LONG;

        // Print("CurrentLevelSell -> ", CurrentLevelSell);
        // Print("SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        // Print("CurrentLevelBuy -> ", CurrentLevelBuy);
        // Print("SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
        
        
        // avaliar o impacto deste trecho
        // if(CurrentLevelSell == SERVER_SYMBOL_ASK)
        // {
            
        //     Print("== SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        //     Print("CurrentLevelSell == -> ", CurrentLevelSell);
        //     //return -1;
        //     //CurrentLevelSell += SELECTED_EN_DISTANCE_SHORT;
        // }
        // if(CurrentLevelBuy == SERVER_SYMBOL_BID)
        // {
        //     Print("== SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
        //     Print("== CurrentLevelBuy -> ", CurrentLevelBuy);
        //     //return -1;
        //     //CurrentLevelBuy -= SELECTED_EN_DISTANCE_LONG;
        // }





        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0) // 0 = comprado
            {
                
                CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG;      

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_BID > CurrentLevelSell)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
                //     return -1;
                // }


            }
            else
            {
                CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT;       

                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
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
        
        
        CurrentLevelSell += TopChange;
        CurrentLevelBuy -= BottomChange;

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
            if(SERVER_SYMBOL_BID > CurrentLevelSell)
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;

                Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
                return -1;
            }
            if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
            {
                Print("call from 100 ENFORCE");
                ResetAxlesLevels();
                CountFreezeCentralLevel == 0;
                Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
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

int Sys_Follow_4_9_5_BACKUP_last(int callFrom)
{
    //SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME;


    if(callFrom == 1)
    {
        return -1;        
    }    

    SELL_TREND_OK = true;
    BUY_TREND_OK = true;

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    
    //SO_Follow_8_TopDisplay();
    Sys_Spread_Reset_Vars();


    if(TREND_MODE)
    {
        if(CurrentTrend == 1)
        {
            //SELECTED_BUY_FIRST = true;
            //SELECTED_SELL_FIRST = false;
            if(pos_status == 1)
            {
                SELECTED_LIMIT_POSITION_VOLUME = 3;
            }
        }
        else if(CurrentTrend == -1)
        {
            //SELECTED_SELL_FIRST = true;
           // SELECTED_BUY_FIRST = false;
            if(pos_status == 0)
            {
                SELECTED_LIMIT_POSITION_VOLUME = 3;

            }
        }
        // else
        // {
        //     SELECTED_SELL_FIRST = false;
        //     SELECTED_BUY_FIRST = false;            
        // }        
    }

    CountAllOrdersForPairType();

    //if(SELECTED_TRADE_STRATEGY_CHOSEN > 0 && TRADING_STATUS_CHANGED && callFrom != 3)
    //if(TREND_CHANGED)
    //if(TREND_SIDE_CHANGED)
    //if(CurrentTradingStatus == 3 || CurrentTradingStatus == 2)
    if(TRADING_STATUS_CHANGED)
    {
        SO_FOLLOW_LOCK = 0;
        Print("enforce x");   
        /*
        if(
            CurrentTradingStatus == 3 || CurrentTradingStatus == 2
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
        //else if(countListening == 1 || countListening == 3)
        else    
        {
            // if(CurrentTradingStatus != 5 && CurrentTradingStatus != 6)
            // {
                SO_FOLLOW_LOCK = 0;
                Print("call from 22 ENFORCE");
                //ResetAxlesLevels();
                //CountFreezeCentralLevel == 0;
                
           // }
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
        //else if(countListening == 1 || countListening == 3)
        else    
        {
           // if(CurrentTradingStatus != 5 && CurrentTradingStatus != 6)
           // {
                SO_FOLLOW_LOCK = 0;
                Print("call from 44 ENFORCE");
                //ResetAxlesLevels();
               // CountFreezeCentralLevel == 0;
                
          //  }
        }
    }

    if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE)
    {
        SetCentalAxles_evo(2);
        SetAllFlows();            
        SO_FOLLOW_LOCK = 1;
        
  

        CurrentLevelSell = Lowest_Top;
        CurrentLevelBuy = Highest_Bottom;

        currentSellVolume = SELECTED_VOLUME_SHORT;
        currentBuyVolume = SELECTED_VOLUME_LONG;

        // Print("CurrentLevelSell -> ", CurrentLevelSell);
        // Print("SERVER_SYMBOL_ASK -> ", SERVER_SYMBOL_ASK);
        // Print("CurrentLevelBuy -> ", CurrentLevelBuy);
        // Print("SERVER_SYMBOL_BID -> ", SERVER_SYMBOL_BID);
        if(CurrentLevelSell == SERVER_SYMBOL_ASK)
        {
            
            Print("SELECTED_EN_DISTANCE_SHORT -> ", SELECTED_EN_DISTANCE_SHORT);
            return -1;
            //CurrentLevelSell += SELECTED_EN_DISTANCE_SHORT;
        }
        if(CurrentLevelBuy == SERVER_SYMBOL_BID)
        {
            Print("SELECTED_EN_DISTANCE_LONG -> ", SELECTED_EN_DISTANCE_LONG);
            return -1;
            //CurrentLevelBuy -= SELECTED_EN_DISTANCE_LONG;
        }





        //if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        if(temp_vol >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0) // 0 = comprado
            {
                //CurrentLevelBuy = Freeze_Central_Bottom - EN_Distance_Long;
                CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG; //(var_changed)       

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_BID > CurrentLevelSell)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
                //     return -1;
                // }


            }
            else
            {
                //CurrentLevelSell = Freeze_Central_Top + EN_Distance_Short;       
                CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT; //(var_changed)       

                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }

                // if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
                // {
                //     Print("call from 4 ENFORCE");
                //     ResetAxlesLevels();
                //     CountFreezeCentralLevel == 0;
                //     Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
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
        if(SERVER_SYMBOL_BID > CurrentLevelSell)
        {
            Print("call from 4 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;

            Print("Enforce Reset CurrentLevelSell: ", CurrentLevelSell);                
            return -1;
        }
        if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
        {
            Print("call from 4 ENFORCE");
            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
            Print("Enforce Reset CurrentLevelBuy: ", CurrentLevelBuy);       
            return -1;
        }
    }


    // deve ser levado para dentro da estratégia 
    // if((CurrentTradingStatus == 2 || CurrentTradingStatus == 3))
    // {
    //     if(pos_status == 0)
    //     {
    //         //currentSellVolume += SELECTED_VOLUME_SHORT;
    //         //CurrentLevelSell = SERVER_SYMBOL_BID;
    //         CurrentLevelSell = SERVER_SYMBOL_ASK;
    //     }
    //     if(pos_status == 1)
    //     {
    //         //currentBuyVolume +=  SELECTED_VOLUME_LONG;
    //         CurrentLevelBuy = SERVER_SYMBOL_BID;
    //         //CurrentLevelBuy = SERVER_SYMBOL_ASK;
    //     }        
    // }
    // else if(CurrentTradingStatus == 5)
    // {
    //     CurrentLevelBuy = SERVER_SYMBOL_BID;
    //     CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
    //     SELL_TREND_OK = false;
    // }
    // else if(CurrentTradingStatus == 6)
    // {
    //     CurrentLevelSell = SERVER_SYMBOL_ASK;
    //     CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     BUY_TREND_OK = false;
    // }

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

int Sys_Follow_4_9_5_funcionando(int callFrom)
{
    // EnforceBuy = false;
    // EnforceSell = false;

    if(callFrom == 1)
    {
        // chamada de status de trade por fechamento (verifica se deu entrada ou saida por sinal de fechamento de vela)
        return -1;        
    }    

    TopChange = 0;
    BottomChange = 0;


    int masterEstInterResponse = 0;
    CountAllOrdersForPairType();



    if(callFrom == 3)
    {
        ResetAxlesLevels();
        CountFreezeCentralLevel == 0;
        //SetCentalAxles_evo(3);
        Print("call from 3");
        //return -1;
        SO_FOLLOW_LOCK = 0;
    }

    else if(TotalSymbolOrderBuy == 0 || TotalSymbolOrderSell == 0)
    {
        if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            SO_FOLLOW_LOCK = 0;
        }
        else if(countListening == 0 || countListening == 3)
        {
            SO_FOLLOW_LOCK = 0;
        }
    }
    //Print("Área 1 from, ", callFrom);

    if(SO_FOLLOW_LOCK == 0 || FOLLOW_MODE)
    {

        //DYT_HistoryDeals();
        


        SetCentalAxles_evo(2);
        SetAllFlows();            
        SO_FOLLOW_LOCK = 1;
        
        // Print("level sell: ", CurrentLevelSell);    
        // Print("level buy: ", CurrentLevelBuy);    

        CurrentLevelSell = Lowest_Top;
        CurrentLevelBuy = Highest_Bottom;



        if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
        {
            if(pos_status == 0)
            {
                //CurrentLevelBuy = Freeze_Central_Bottom - EN_Distance_Long;
                CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG; //(var_changed)       

                if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
                {
                    SetSpdReverse3();
                }
            }
            else
            {
                //CurrentLevelSell = Freeze_Central_Top + EN_Distance_Short;       
                CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT; //(var_changed)       

                if(TotalSymbolOrderSell == 0)
                {
                    SetSpdReverse3();
                }
            }
        }
        else
        {

        }
        // else
        // {
        //     if(SERVER_SYMBOL_BID > CurrentLevelSell)
        //     {
        //         Print("enforceeeeeeeee: ", CurrentLevelSell);                    
        //         //CurrentLevelSell = SERVER_SYMBOL_BID + EN_Distance_Short; //(var_changed)  
        //         CurrentLevelSell = SERVER_SYMBOL_BID + SELECTED_EN_DISTANCE_SHORT; //(var_changed)  
        //     }
        //     if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
        //     {
        //         Print("enforceeeeeeeee: ", CurrentLevelBuy);                    
        //         //CurrentLevelBuy = SERVER_SYMBOL_ASK - EN_Distance_Long; //(var_changed)  
        //         CurrentLevelBuy = SERVER_SYMBOL_ASK - SELECTED_EN_DISTANCE_LONG; //(var_changed)  
        //     }

        // }
    
            
        currentSellVolume = SELECTED_VOLUME_SHORT;
        currentBuyVolume = SELECTED_VOLUME_LONG;
        
        // CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
        // CurrentTradingStatus = Trading_Status(1);


        if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
        {
            masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
        }
        

        if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            Set_OrderVolume(SELECTED_EST_VOLUME_CHOSEN);
            //Print("masterEstInterResponse == 0");
        }

        CurrentLevelSell += TopChange;
        CurrentLevelBuy -= BottomChange;


        // Print("Lowest_Top:  ", Lowest_Top);
        // Print("Highest_Bottom:  ", Highest_Bottom);
        // Print("CurrentLevelSell pós:  ", CurrentLevelSell);
        // Print("CurrentLevelBuy pré:  ", CurrentLevelBuy);


    // if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
    // {    
    //     if(Freeze_Central_Top > 0 && Freeze_Central_Bottom > 0)
    //     {
    //         SetAddChange_Evo();
    //         SetRdcChange_Evo();
    //     }
    // }  
    if(pos_volume < SELECTED_LIMIT_POSITION_VOLUME)
    {
        if(SERVER_SYMBOL_BID > CurrentLevelSell)
        {
            Print("enforceeeeeeeee CurrentLevelSell: ", CurrentLevelSell);          


            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
            SetCentalAxles_evo(3);            
            return -1;
            // //CurrentLevelSell = SERVER_SYMBOL_BID + EN_Distance_Short; //(var_changed)  
            // CurrentLevelSell = SERVER_SYMBOL_BID + SELECTED_EN_DISTANCE_SHORT; //(var_changed)  
        }
        if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
        {
            Print("enforceeeeeeeee CurrentLevelBuy: ", CurrentLevelBuy);       

            ResetAxlesLevels();
            CountFreezeCentralLevel == 0;
            SetCentalAxles_evo(3);
            return -1;


            // //CurrentLevelBuy = SERVER_SYMBOL_ASK - EN_Distance_Long; //(var_changed)  
            // CurrentLevelBuy = SERVER_SYMBOL_ASK - SELECTED_EN_DISTANCE_LONG; //(var_changed)  
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






























// int Sys_Follow_4_9_5_Backup(int callFrom)
// {
//     // EnforceBuy = false;
//     // EnforceSell = false;

//     if(callFrom == 1)
//     {
//         // chamada de status de trade por fechamento (verifica se deu entrada ou saida por sinal de fechamento de vela)
//         return -1;        
//     }    

//     TopChange = 0;
//     BottomChange = 0;


//     int masterEstInterResponse = 0;
//     CountAllOrdersForPairType();



//         if(callFrom == 3)
//         {
//             ResetAxlesLevels();
//             CountFreezeCentralLevel == 0;
//             SetCentalAxles_evo(3);
//             return -1;
//         }

//     //if((CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0))
//     if(TotalSymbolOrderBuy == 0 || TotalSymbolOrderSell == 0 || FOLLOW_MODE)
//     {
//         SO_FOLLOW_LOCK = 0;
//     }
//     //Print("Área 1 from, ", callFrom);

//     if(SO_FOLLOW_LOCK == 0)
//     {

//         //DYT_HistoryDeals();
//         SetTradingMode();


//         SetCentalAxles_evo(2);
//         SetAllFlows();            
//         SO_FOLLOW_LOCK = 1;
        
//         // Print("level sell: ", CurrentLevelSell);    
//         // Print("level buy: ", CurrentLevelBuy);    

//         CurrentLevelSell = Lowest_Top;
//         CurrentLevelBuy = Highest_Bottom;



//         if(pos_volume >= SELECTED_LIMIT_POSITION_VOLUME)
//         {
//             if(pos_status == 0)
//             {
//                 //CurrentLevelBuy = Freeze_Central_Bottom - EN_Distance_Long;
//                 CurrentLevelBuy = Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG; //(var_changed)       

//                 if(TotalSymbolOrderBuy == 0) // só chama o spd se não tiver mais ordem a ser exec. do lado que vai sofrer o stop
//                 {
//                     SetSpdReverse3();
//                 }
//             }
//             else
//             {
//                 //CurrentLevelSell = Freeze_Central_Top + EN_Distance_Short;       
//                 CurrentLevelSell = Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT; //(var_changed)       

//                 if(TotalSymbolOrderSell == 0)
//                 {
//                     SetSpdReverse3();
//                 }
//             }
//         }
//         else
//         {
//             if(SERVER_SYMBOL_BID > CurrentLevelSell)
//             {
//                 Print("enforceeeeeeeee: ", CurrentLevelSell);                    
//                 //CurrentLevelSell = SERVER_SYMBOL_BID + EN_Distance_Short; //(var_changed)  
//                 CurrentLevelSell = SERVER_SYMBOL_BID + SELECTED_EN_DISTANCE_SHORT; //(var_changed)  
//             }
//             if(SERVER_SYMBOL_ASK < CurrentLevelBuy)
//             {
//                 Print("enforceeeeeeeee: ", CurrentLevelBuy);                    
//                 //CurrentLevelBuy = SERVER_SYMBOL_ASK - EN_Distance_Long; //(var_changed)  
//                 CurrentLevelBuy = SERVER_SYMBOL_ASK - SELECTED_EN_DISTANCE_LONG; //(var_changed)  
//             }

//         }
    
            
//         currentSellVolume = SELECTED_VOLUME_SHORT;
//         currentBuyVolume = SELECTED_VOLUME_LONG;
        
//         CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
//         CurrentTradingStatus = Trading_Status(1);


//         if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
//         {
//             masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
//         }
        

//         if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
//         {
//             EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
//             Set_OrderVolume(SELECTED_EST_VOLUME_CHOSEN);
//             //Print("masterEstInterResponse == 0");
//         }

//         CurrentLevelSell += TopChange;
//         CurrentLevelBuy -= BottomChange;


//         // if((pos_volume < SELECTED_LIMIT_POSITION_VOLUME))
//         // {


//         //     SetAddChange_Evo();
//         //     SetRdcChange_Evo();
//         //     // SetAddChange(CurrentLevelSell, CurrentLevelBuy);
//         //     // SetRdcChange(CurrentLevelSell, CurrentLevelBuy);
//         // }        





//         if(SELECTED_EN_MODE == 1)
//         {
//             Set_Order_Limit(callFrom);
//             return 2;
//         }
//     }
//     return 0;

// }
