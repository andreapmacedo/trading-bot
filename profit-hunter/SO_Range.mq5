
double SYS_RANGE_CURR_BOTTOM_LEVEL      = 0;
double SYS_RANGE_CURR_TOP_LEVEL         = 0;
//Sys_Range

void SO_Range(int callFrom)
{
    //Print("SO_Range");
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    


    switch(SELECTED_VER) // Version
    {
        case 1:
            switch(callFrom)
            {
                case eCallFrom_NewTradingFloor: // 
                    Sys_Range_O1_Y1_v03_1(callFrom);
                    break;
            }
            break;            
    }   
            
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);     
}


void Sys_Range_SET_EN_LEVEL_CHOSEN()
{
    //--- teria de modificar a estratégia para trabalhar com esta abordagem 
    switch(INPUT_EN_EST_ANCHOR_CHOSEN)
    {
        case eOrLevel_EN_BidAsk:
            SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_BidAsk;
            break;
        case eOrLevel_EN_Last_Deal:
            SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_BidAsk;
            break;                                    
        default:
            SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_Default;
            break;    
    }
}

void Sys_Range_Follow_SET_EN_DISTANCE_CHOSEN()
{
    //--- teria de modificar a estratégia para trabalhar com esta abordagem 
    switch(INPUT_EN_EST_DISTANCE_CHOSEN)
    {
        case 1:
            SELECTED_EST_EN_DISTANCE_CHOSEN = 0;
            break;
        case 2:
            SELECTED_EST_EN_DISTANCE_CHOSEN = 0;
            break;                                    
        default:
            SELECTED_EST_EN_DISTANCE_CHOSEN = 0;
            break;    
    }
}

void Sys_Range_SET_EN_VOLUME_CHOSEN()
{
    //--- teria de modificar a estratégia para trabalhar com esta abordagem 
    switch(INPUT_EN_EST_VOLUME_CHOSEN)
    {
        case 1:
            SELECTED_EST_VOLUME_CHOSEN = 0;
            break;
        case 2:
            SELECTED_EST_VOLUME_CHOSEN = 0;
            break;                                    
        default:
            SELECTED_EST_VOLUME_CHOSEN = 0;
            break;    
    }
}

void Sys_Range_ResetVars()
{
    SYS_RANGE_CURR_TOP_LEVEL = 0;
    SYS_RANGE_CURR_BOTTOM_LEVEL = 0;
}


void Sys_Range_000v00(int callFrom)
{

    SYS_TRAILING_STOP_PERMITION = false;

    SetAllSelectedOrders_System(); // all system
        
    CancelSellOrders(_Symbol, "Sys_Range_001v00");
    CancelBuyOrders(_Symbol, "Sys_Range_001v00");

    SYS_RANGE_CURR_TOP_LEVEL = LEFT_BAR_HIGHESTHIGH_MAX;
    SYS_RANGE_CURR_BOTTOM_LEVEL = LEFT_BAR_LOWESTLOW_MIN;
        
    TEMP_EN_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;
    TEMP_EN_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    
}




void Sys_Range_000v01(int callFrom)
{

    SYS_TRAILING_STOP_PERMITION = false;

    SetAllSelectedOrders_Default(); // all default.

    // verificar se o sys é compativel com o def. e fazer a readequação

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
        
    CancelSellOrders(_Symbol, "Sys_Range_001v01");
    CancelBuyOrders(_Symbol, "Sys_Range_001v01");

        
    if(SERVER_SYMBOL_BID > LEFT_BAR_LEVEL_MID)
    {
        TEMP_EN_LONG_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_TP_LONG_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_SL_LONG_VALUE = LEFT_BAR_LEVEL_MID;
    }
    else if(SERVER_SYMBOL_ASK < LEFT_BAR_LEVEL_MID)
    {
        
        TEMP_EN_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_TP_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_SL_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
    }
}

void Sys_Range_000v02(int callFrom)
{
    
    SYS_TRAILING_STOP_PERMITION = false;    
    
    SetAllSelectedOrders_Input(); // all input.
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);


    CancelSellOrders(_Symbol, "Sys_Range_002v02");
    CancelBuyOrders(_Symbol, "Sys_Range_002v02");

        
    if(SERVER_SYMBOL_BID > LEFT_BAR_LEVEL_MID)
    {
        TEMP_EN_LONG_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_TP_LONG_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;
        TEMP_SL_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    }
    else if(SERVER_SYMBOL_ASK < LEFT_BAR_LEVEL_MID)
    {
        
        TEMP_EN_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
        TEMP_TP_SHORT_VALUE = LEFT_BAR_LOWESTLOW_MIN;
        TEMP_SL_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;
    }
}


void Sys_Range_O1_Y1_v03_1(int callFrom)
{
    // misto
    SYS_TRAILING_STOP_PERMITION = false;
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_System;
    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_System;

    SELECTED_EST_TP_DISTANCE_CHOSEN      = eOrDistance_TP_System; // vai ser obrigatoriamente 0 ou o valor justo do level chosen
    SELECTED_EST_SL_DISTANCE_CHOSEN      = eOrDistance_SL_System;
        
    CancelSellOrders(_Symbol, "Sys_Range_O1_Y1_v03_1");
    CancelBuyOrders(_Symbol, "Sys_Range_O1_Y1_v03_1");

        
    TEMP_EN_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    TEMP_EN_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;

    TEMP_TP_LONG_VALUE = LEFT_BAR_LEVEL_MID;
    TEMP_TP_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
    
    TEMP_SL_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN-SL_Distance_Long;
    TEMP_SL_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX+SL_Distance_Short;
    
}

void Sys_Range_100v03(int callFrom)
{
    // misto
    SYS_TRAILING_STOP_PERMITION = false;
   // //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   // //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    SetAllSelectedOrders_Level_System();
    //SetAllSelectedOrders_Distance_Input();
    SetAllSelectedOrders_Distance_System();


    CancelSellOrders(_Symbol, "Sys_Range_100v03");
    CancelBuyOrders(_Symbol, "Sys_Range_100v03");

        

    TEMP_EN_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    TEMP_EN_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;

//    TEMP_TP_LONG_VALUE = LEFT_BAR_LEVEL_MID;
//    TEMP_TP_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
    TEMP_TP_LONG_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;
    TEMP_TP_SHORT_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    
    TEMP_SL_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN-SL_Distance_Long;
    TEMP_SL_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX+SL_Distance_Short;
    
}