
//double SYS_RANGE_CURR_BOTTOM_LEVEL      = 0;
//double SYS_RANGE_CURR_TOP_LEVEL         = 0;
//Sys_Range

void SO_Bar_To_Bar(int callFrom)
{
    Print("SO_Bar_To_Bar");
    switch(SELECTED_VER) // Version
    {
        case 1:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    Sys_Bar_To_Bar_O1_Y3_v03_11();
                    Print("Sys_Bar_To_Bar_O1_Y3_v03_11");
                    break;
            }
            break;    
        case 2:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // OnTick
                    Sys_Bar_To_Bar_O1_Y3_v03_12();
                    Print("Sys_Bar_To_Bar_O1_Y3_v03_12");
                    break;
            }
            break;  
    }   
}


void Sys_Bar_To_Bar_ResetVars()
{


}


//--- TRAP BAR
void Sys_Bar_To_Bar_O1_Y3_v03_11()
{

    BREAK_MODE = false;
    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+


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
    // fazer a gestão do volume e dos filtros aqui
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    




    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;


    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+


    //old    
    //SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);

    //--- EN
    Set_EN_OrdersLevel__Bar_HL();
    Set_EN_OrdersDistance__Pts();
    
    //--- TP
    Set_TP_OrdersLevel_EN_Final();
    Set_TP_OrdersDistance__Pts();
    
    //--- SL
    Set_SL_OrdersLevel_EN_Final();
    Set_SL_OrdersDistance__Pts();
    
    //--- Assemble
    Set_Final_Orders();

    //--- Exec.
    PlaceOrders(0);     

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = false;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
}


//--- BREAK BAR
void Sys_Bar_To_Bar_O1_Y3_v03_12()
{

    BREAK_MODE = true;
    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+


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
    // fazer a gestão do volume e dos filtros aqui
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    




    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;



    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+


    //old    
    //SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);

    //--- EN
    Set_EN_OrdersLevel__Bar_HL();
    Set_EN_OrdersDistance__Pts();
    
    //--- TP
    Set_TP_OrdersLevel_EN_Final();
    Set_TP_OrdersDistance__Pts();
    
    //--- SL
    Set_SL_OrdersLevel_EN_Final();
    Set_SL_OrdersDistance__Pts();
    
    //--- Assemble
    Set_Final_Orders();

    //--- Exec.
    PlaceOrders(0);     

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = false;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
}



//--- TRAP BAR
void Sys_Bar_To_Bar_O1_Y3_v02_11()
{

    BREAK_MODE = false;
    //+------------------------------------------------------------------+
    //| Assigns                                                          |
    //+------------------------------------------------------------------+


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
    // fazer a gestão do volume e dos filtros aqui
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    




    //+------------------------------------------------------------------+
    //| Compulsory                                                       |
    //+------------------------------------------------------------------+
    //SELECTED_TP_ON = false;
    //SELECTED_SL_ON = false;


    //+------------------------------------------------------------------+
    //| Orders Definition                                                |
    //+------------------------------------------------------------------+
    //Set_EN_Orders_Level_Settings(SELECTED_EST_EN_ANCHOR_CHOSEN);
    //Set_EN_OrdersLevel__Bar_HL();
    //EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
    
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;

    //old    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);

    //--- EN

    //Set_EN_Orders_Distance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); 
    

    //--- TP
    Set_TP_OrdersLevel_EN_Final();
    Set_TP_OrdersDistance__Pts();
    
    //--- SL
    Set_SL_OrdersLevel_EN_Final();
    Set_SL_OrdersDistance__Pts();
    
    //--- Assemble
    Set_Final_Orders();

    //--- Exec.
    PlaceOrders(0);     

    //+------------------------------------------------------------------+
    //| Trailing Stop                                                    |
    //+------------------------------------------------------------------+
    
    SYS_TRAILING_STOP_PERMITION = false;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_MA;
    Set_OrderTrailingStop_Settings(SELECTED_TRAILING_STOP_CHOSEN, eSide_Trend);
}