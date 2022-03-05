double selected_ma_fast = 0;
double selected_ma_slow = 0;
double ma_spread = 0;



void SO_MA(int callFrom)
{
    switch(SELECTED_VER) // Version
    {
        case 1:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    //Sys_MA_Floor_o5_v01a_m21();
                    Sys_MA_Floor_o5_v01t_m21();
                    break;
            }
            break;            
        case 2:
            //Sys_Range_O1_Y1_v03_1(callFrom);
            break; 
        case 3:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    Sys_MA_Floor_O1_Y1_v03_21();
                    break;
                case eCallFrom_OnTick: // OnTick
                    break;
            }
            break;  
        case 4:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    Sys_MA_Floor_O1_Y1_v04_21();
                    break;
            }
            break; 
        case 5:

            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    Sys_MA_Floor_O1_Y1_v05_11();
                    break;
            }
            break;
    }   


}



void Sys_MA_Floor_ResetVars()
{
    //SYS_RANGE_CURR_TOP_LEVEL = 0;
    //SYS_RANGE_CURR_BOTTOM_LEVEL = 0;
}


//--- ORDEM NA VIRADA DA MÉDIA
void Sys_MA_Floor_O1_Y1_v03_21()
{

    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);        

       
   
    double selected_ma_fast = MyRound(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double ma_spread = selected_ma_fast - previous_selected_ma_fast;

   // ma_spread = NormalizeDouble(MyRound(ma_spread), _Digits);
  //  selected_ma_fast = NormalizeDouble(MyRound(selected_ma_fast), _Digits);
   // previous_selected_ma_fast = NormalizeDouble(MyRound(previous_selected_ma_fast), _Digits);


    //+------------------------------------------------------------------+
    //| Logic                                                            |
    //+------------------------------------------------------------------+


    if(
        PriceInfo[1].close > selected_ma_fast
        )
    {
        LONG_CONDITIONS = true;
        SHORT_CONDITIONS = false;

    }
    else if(
        PriceInfo[1].close < selected_ma_fast
        )
    {
        LONG_CONDITIONS = false;
        SHORT_CONDITIONS = true;        
    }



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+

    EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
    EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;

    SetAllSelectedOrders_Level_System();
    SetAllSelectedOrders_Distance_System();


    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;

    TEMP_EN_LONG_VALUE = PriceInfo[1].high + SELECTED_EN_DISTANCE_LONG_VALUE;
    TEMP_EN_SHORT_VALUE = PriceInfo[1].low - SELECTED_EN_DISTANCE_SHORT_VALUE ;
    
    TEMP_TP_LONG_VALUE = TEMP_EN_LONG_VALUE+TP_Distance_Long;
    TEMP_TP_SHORT_VALUE = TEMP_EN_SHORT_VALUE-TP_Distance_Short;
    
    TEMP_SL_LONG_VALUE = TEMP_EN_LONG_VALUE-SL_Distance_Long;
    TEMP_SL_SHORT_VALUE = TEMP_EN_SHORT_VALUE+SL_Distance_Short;


    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;


    //+------------------------------------------------------------------+
    //| Removing previous orders                                         |
    //+------------------------------------------------------------------+

    CancelSellOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v04_1");
    CancelBuyOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v04_1");

    //+------------------------------------------------------------------+
    //| Generic Set Orders                                                |
    //+------------------------------------------------------------------+
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = true;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
    
    //+------------------------------------------------------------------+
    //| Generic Place Order                                              |
    //+------------------------------------------------------------------+

    PlaceOrders(0);     

}


//--- ORDEM NA VELA DO CRUZAMENTO DA MÉDIA!
void Sys_MA_Floor_O1_Y1_v04_21()
{

    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);        

       
    double selected_ma_fast = MyRound(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    double selected_ma_slow = MyRound(Get_MA(MA_SLOW, MA_SLOW_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double ma_spread = selected_ma_fast - previous_selected_ma_fast;

    double ma_spread = selected_ma_fast - selected_ma_slow;
  //  selected_ma_fast = NormalizeDouble(MyRound(selected_ma_fast), _Digits);
   // previous_selected_ma_fast = NormalizeDouble(MyRound(previous_selected_ma_fast), _Digits);


    //+------------------------------------------------------------------+
    //| Logic                                                            |
    //+------------------------------------------------------------------+

    if(
        PriceInfo[1].close > selected_ma_fast
        && PriceInfo[1].close > selected_ma_slow

        //ma_spread > 0
        //PriceInfo[1].close > selected_ma_fast
        //&& PriceInfo[1].low < selected_ma_fast
        )
    {
        LONG_CONDITIONS = true;
        SHORT_CONDITIONS = false;
    }
    else if(

        PriceInfo[1].close < selected_ma_fast
        && PriceInfo[1].close < selected_ma_slow
        //ma_spread < 0 // media rapida abaixo da lenta
        //PriceInfo[1].close < selected_ma_fast
        //&& PriceInfo[1].high > selected_ma_fast
        )
    {
        LONG_CONDITIONS = false;
        SHORT_CONDITIONS = true;
    }



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;

    BREAK_MODE =  true;


    SetAllSelectedOrders_Level_System();
    SetAllSelectedOrders_Distance_System();

    //FINAL_SHORT_VOLUME = 

    //SELECTED_VOLUME_LONG = SELECTED_LIMIT_POSITION_VOLUME;
    //SELECTED_VOLUME_SHORT = SELECTED_LIMIT_POSITION_VOLUME;
    
    //SELECTED_VOLUME_LONG = SELECTED_LIMIT_POSITION_VOLUME;
    //SELECTED_VOLUME_SHORT = SELECTED_LIMIT_POSITION_VOLUME;
    
    SELECTED_LIMIT_POSITION_VOLUME = 1;
    
    SELECTED_EST_VOLUME_CHOSEN = eVolume_Reverse;
    //SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;

    TEMP_EN_LONG_VALUE = PriceInfo[1].high + SELECTED_EN_DISTANCE_LONG_VALUE;
    TEMP_EN_SHORT_VALUE = PriceInfo[1].low - SELECTED_EN_DISTANCE_SHORT_VALUE ;
    

    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    SELECTED_TP_ON = false;
    SELECTED_SL_ON = false;




    //+------------------------------------------------------------------+
    //| Removing previous orders                                         |
    //+------------------------------------------------------------------+

    CancelSellOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v04_1");
    CancelBuyOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v04_1");

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = true;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
    
    
    //+------------------------------------------------------------------+
    //| Generic Set Orders                                                |
    //+------------------------------------------------------------------+
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    
    //+------------------------------------------------------------------+
    //| Generic Place Order                                              |
    //+------------------------------------------------------------------+

    PlaceOrders(0);  

}




//--- ORDEM DE ENTRADA NA MÉDIA!
void Sys_MA_Floor_O1_Y1_v05_11()
{

    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);        

       
    double selected_ma_fast = MyRound(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    double previous_selected_ma_fast = MyRound(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    double ma_spread = selected_ma_fast - previous_selected_ma_fast;



    //+------------------------------------------------------------------+
    //| Logic                                                            |
    //+------------------------------------------------------------------+


    if(
        selected_ma_fast < SERVER_SYMBOL_BID
        && ma_spread > 0
        )
    {
        LONG_CONDITIONS = true;
        SHORT_CONDITIONS = false;

    }
    else if(
        selected_ma_fast > SERVER_SYMBOL_ASK
        && ma_spread < 0
        )
    {
        LONG_CONDITIONS = false;
        SHORT_CONDITIONS = true;        
    }



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;

    SetAllSelectedOrders_Level_System();
    SetAllSelectedOrders_Distance_System();


    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    SELECTED_LIMIT_POSITION_VOLUME = 1;


    TEMP_EN_LONG_VALUE = selected_ma_fast - SELECTED_EN_DISTANCE_LONG_VALUE;
    TEMP_EN_SHORT_VALUE = selected_ma_fast + SELECTED_EN_DISTANCE_SHORT_VALUE ;
    
    TEMP_TP_LONG_VALUE = TEMP_EN_LONG_VALUE + TP_Distance_Long;
    TEMP_TP_SHORT_VALUE = TEMP_EN_SHORT_VALUE - TP_Distance_Short;
    
    TEMP_SL_LONG_VALUE = TEMP_EN_LONG_VALUE - SL_Distance_Long ;
    TEMP_SL_SHORT_VALUE = TEMP_EN_SHORT_VALUE + SL_Distance_Short;
    

    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;




    //+------------------------------------------------------------------+
    //| Removing previous orders                                         |
    //+------------------------------------------------------------------+

    CancelSellOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v05_11");
    CancelBuyOrders(_Symbol, "Sys_MA_Floor_O1_Y1_v05_11");

    //+------------------------------------------------------------------+
    //| Generic Set Orders                                               |
    //+------------------------------------------------------------------+
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = true;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_Bar_To_Bar;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
    
    //+------------------------------------------------------------------+
    //| Generic Place Order                                              |
    //+------------------------------------------------------------------+

    PlaceOrders(0);  
}


void Sys_MA_Floor_o5_v01a_m21()
{

    
    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);        

       
   // selected_ma_fast = MyRound(Get_MA(20, 0,  MODE_SMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //selected_ma_slow = MyRound(Get_MA(MA_SLOW, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    MA_TRAILING_TRIGGER_VALUE = MyRound(Get_MA(MA_TRAILING_TRIGGER, 0,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //ma_spread = selected_ma_fast - selected_ma_slow;

    

    //double trima = MyRound(Get_TMA(34, 0,  0, selected_ma_fast));

    // filtro para evitar entrada longe da média

    //double trima = Get_TEMA(MA_SLOW, 0, 0);
    MA_REF_VALUE = Get_AMA(1, MainMaPeriod, MA_SLOW, 0, 0);

    //+------------------------------------------------------------------+
    //| Removing previous orders                                         |
    //+------------------------------------------------------------------+

    //CancelSellOrders(_Symbol, "Sys_Bar_To_Bar_O1_Y3_v03_11");
    //CancelBuyOrders(_Symbol, "Sys_Bar_To_Bar_O1_Y3_v03_11");
    //CancelAllThisSymbolOrders();
    CancelAllOrdersByExchange_v1();
    


    //+------------------------------------------------------------------+
    //| Logic                                                            |
    //+------------------------------------------------------------------+
   
    if(
        PriceInfo[1].close > MA_REF_VALUE
        && PriceInfo[1].close > MA_TRAILING_TRIGGER_VALUE
        )
    {
        LONG_CONDITIONS = true;
        SHORT_CONDITIONS = false;

    }
    else if(
        PriceInfo[1].close < MA_REF_VALUE
        && PriceInfo[1].close < MA_TRAILING_TRIGGER_VALUE
        )
    {
        LONG_CONDITIONS = false;
        SHORT_CONDITIONS = true;        
    }



    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+

    //old    
    /* // tradicional        
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrLevel_EN_System;
    //Set_EN_Orders_Distance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); 
    */
    
    BREAK_MODE = true;
    //--- EN

    //SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_Reverse;
    SELECTED_LIMIT_POSITION_VOLUME = 1;


    TEMP_EN_LONG_VALUE = PriceInfo[1].high + SELECTED_EN_DISTANCE_LONG_VALUE;
    TEMP_EN_SHORT_VALUE = PriceInfo[1].low - SELECTED_EN_DISTANCE_SHORT_VALUE ;


    SELECTED_TP_ON = false;
    SELECTED_SL_ON = false;



    Set_EN_OrdersDistance__Pts();
    /*    
    //--- TP
    Set_TP_OrdersDistance__Pts();
    Set_TP_OrdersLevel_EN_Final();
    
    //--- SL
    Set_SL_OrdersDistance__Pts();
    Set_SL_OrdersLevel_EN_Final();
    */
    //--- Assemble
    Set_Final_Orders();

    //--- Exec.
    PlaceOrders(0);     

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = true;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
}


void Sys_MA_Floor_o5_v01t_m21()
{



    
    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);        
       
    //MA_REF_VALUE = MyRound(Get_MA(IntradayBar, 0,  MODE_SMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //MA_REF_VALUE = MyRound(Get_MA(MA_REF, 0,  MODE_SMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    MA_TRAILING_TRIGGER_VALUE = Get_TEMA(MA_REF, 0, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    MA_REF_VALUE = Get_AMA(1, MainMaPeriod, MA_REF, 0, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //selected_ma_slow = MyRound(Get_MA(MA_SLOW, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //MA_TRAILING_TRIGGER_VALUE = MyRound(Get_MA(MA_TRAILING_TRIGGER, 0,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    //ma_spread = selected_ma_fast - selected_ma_slow;

    

    //double trima = MyRound(Get_TMA(34, 0,  0, selected_ma_fast));

    // filtro para evitar entrada longe da média

    //double trima = Get_TEMA(MA_SLOW, 0, 0);
    
    
    //double trima = Get_AMA(1, MainMaPeriod, MA_SLOW, 0, 0);

    //+------------------------------------------------------------------+
    //| Removing previous orders                                         |
    //+------------------------------------------------------------------+

    //CancelSellOrders(_Symbol, "Sys_Bar_To_Bar_O1_Y3_v03_11");
    //CancelBuyOrders(_Symbol, "Sys_Bar_To_Bar_O1_Y3_v03_11");
    //CancelAllThisSymbolOrders();
    CancelAllOrdersByExchange_v1();
    


    //+------------------------------------------------------------------+
    //| Logic Buy/Sell                                                   |
    //+------------------------------------------------------------------+
   
    if(
        //PriceInfo[1].close > MA_REF_VALUE
        PriceInfo[1].close > MA_TRAILING_TRIGGER_VALUE
        //&& PriceInfo[1].close > MA_TRAILING_TRIGGER_VALUE
        )
    {
        LONG_CONDITIONS = true;
        SHORT_CONDITIONS = false;

    }
    else if(
        //PriceInfo[1].close < MA_REF_VALUE
        PriceInfo[1].close < MA_TRAILING_TRIGGER_VALUE
        //&& PriceInfo[1].close < MA_TRAILING_TRIGGER_VALUE
        )
    {
        LONG_CONDITIONS = false;
        SHORT_CONDITIONS = true;        
    }
    //+------------------------------------------------------------------+
    //| Logic Volume                                                     |
    //+------------------------------------------------------------------+
/*
   if(
        PriceInfo[1].close > MA_REF_VALUE
        && PriceInfo[1].close > MA_TRAILING_TRIGGER_VALUE
        )
    {
        eVolumeCondition = 1;
    }
    else
    {
        eVolumeCondition = 2;
    }
    
    if(
        PriceInfo[1].close < MA_REF_VALUE
        && PriceInfo[1].close < MA_TRAILING_TRIGGER_VALUE
        )
    {
        eVolumeCondition = 1;
    }
    else
    {
        eVolumeCondition = 2;
    }

*/
    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+

    //old    
    /* // tradicional        
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrLevel_EN_System;
    //Set_EN_Orders_Distance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); 
    */
    
    BREAK_MODE = true;
    //--- EN

    //SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;
    //SELECTED_EST_VOLUME_CHOSEN = eVolume_Reverse;
    Set_EN_OrdersVolume__Reverse();
    SELECTED_LIMIT_POSITION_VOLUME = 4;
    //Set_EN_OrdersVolume__Conditions_01();


    //TEMP_EN_LONG_VALUE = PriceInfo[1].high + SELECTED_EN_DISTANCE_LONG_VALUE;
    //TEMP_EN_SHORT_VALUE = PriceInfo[1].low - SELECTED_EN_DISTANCE_SHORT_VALUE ;



    SELECTED_TP_ON = false;
    SELECTED_SL_ON = false;



    
    Set_EN_OrdersLevel__Bar_HL();
    Set_EN_OrdersDistance__Pts();
    /*    
    //--- TP
    Set_TP_OrdersDistance__Pts();
    Set_TP_OrdersLevel_EN_Final();
    
    //--- SL
    Set_SL_OrdersDistance__Pts();
    Set_SL_OrdersLevel_EN_Final();
    */
    //--- Assemble
    Set_Final_Orders();

    //--- Exec.
    PlaceOrders(0);     

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = true;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
}