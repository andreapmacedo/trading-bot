
int ORD_Strategy_100()
{
    Print("ORD_Strategy_100");
    // if(CurrentStatusSystem == 1) // a favor da tendência
    // {        
    //     SetSisSettings_01();
    // }
    // else if(CurrentStatusSystem == 2) // contra a tendência
    // {
    //     SetSisSettings_02();
    // }
    
    // else if(CurrentStatusSystem == 3) // contra a tendência na zona de transição
    // {
    //     SetSisSettings_03();
    // }
    // else if(CurrentStatusSystem == 4) // não posicionado na zona de transição 
    // {
    //     SetSisSettings_04();
    // }
    // else if(CurrentStatusSystem == 5) // não posicionado e sem tendência
    // {
    //     SetSisSettings_05();
    // }

    //BREAK_MODE = true;
    Level_Buy = PriceInfo[1].low;
    Level_Sell = PriceInfo[1].high;
    TopChange +=  5;
    BottomChange += 5;
    Level_Sell += TopChange;
    Level_Buy -= BottomChange;   


    SELECTED_TP_ON = true;
    // Level_tp_long = NULL;
    // Level_tp_short = NULL;


    // Level_tp_long = Level_Buy - 150;
    // Level_tp_short = Level_Sell + 150;

    Level_tp_long = PriceInfo[1].high + 5;
    Level_tp_short = PriceInfo[1].low - 5;



    // SELECTED_SL_ON  = true;
    // // Level_sl_long = NULL; 
    // // Level_sl_short = NULL;
    Level_sl_long = Level_Buy - 25; 
    Level_sl_short = Level_Sell + 25;
    // Level_sl_long = PriceInfo[1].low - 30; 
    // Level_sl_short = PriceInfo[1].high + 30;

    // TopChange +=  EN_Distance_Short;
    // BottomChange += EN_Distance_Long;
    
    // if(PriceInfo[1].low < PriceInfo[2].low)
    // {
    //     CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     BUY_TREND_OK = false;
    //     Print("PriceInfo[1].low < PriceInfo[2].low");
    // }
    // else if(PriceInfo[1].high > PriceInfo[2].high)
    // {
    //     CancelSellOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     SELL_TREND_OK = false;
    //     Print("PriceInfo[1].high > PriceInfo[2].high");
    // }
    
    
    
    return 1;

}
int ORD_Strategy_101()
{
    //Print("ORD_Strategy_101");

    // Level_Buy = PriceInfo[1].low;
    // Level_Sell = PriceInfo[1].high;
    EN_STR_Anchor_101();
    EN_STR_Distance_1();
    Level_Sell += TopChange;
    Level_Buy -= BottomChange;    
    
    // TopChange +=  5;
    // BottomChange += 5;



    // Level_tp_long = NULL;
    // Level_tp_short = NULL;


    // Level_tp_long = Level_Buy - 150;
    // Level_tp_short = Level_Sell + 150;

    SELECTED_TP_ON = true;
    // Level_tp_long = PriceInfo[1].high + 5;
    // Level_tp_short = PriceInfo[1].low - 5;
    TP_STR_Anchor_101();
    TP_STR_Distance_1();



    SELECTED_SL_ON  = true;
    // Level_sl_long = NULL; 
    // Level_sl_short = NULL;
    // Level_sl_long = Level_Buy - 25; 
    // Level_sl_short = Level_Sell + 25;

    SL_STR_Anchor_101();
    SL_STR_Distance_1();

    // Level_sl_long = PriceInfo[1].low - 30; 
    // Level_sl_short = PriceInfo[1].high + 30;

    // TopChange +=  EN_Distance_Short;
    // BottomChange += EN_Distance_Long;
    
    // if(PriceInfo[1].low < PriceInfo[2].low)
    // {
    //     CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     BUY_TREND_OK = false;
    //     Print("PriceInfo[1].low < PriceInfo[2].low");
    // }
    // else if(PriceInfo[1].high > PriceInfo[2].high)
    // {
    //     CancelSellOrders(_Symbol, "CheckBuyManagemente_Evo"); 
    //     SELL_TREND_OK = false;
    //     Print("PriceInfo[1].high > PriceInfo[2].high");
    // }
    
    
    
    return 1;

}
