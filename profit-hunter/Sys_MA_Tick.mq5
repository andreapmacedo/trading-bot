
//double SYS_RANGE_CURR_BOTTOM_LEVEL      = 0;
//double SYS_RANGE_CURR_TOP_LEVEL         = 0;
//Sys_Range

void SO_MA_Tick(int callFrom)
{
    //Print("SO_Range");
    switch(SELECTED_VER) // Version
    {
        case 3:
            switch(SELECTED_EST)// Est
            {
                case 1: // Limit
                    //Sys_Follow_O4_Y1_v03_1(); 
                    Sys_MA_Tick_O1_Y1_v03_1();
                    break; 
                case 2:  // Rompimento
                    //Sys_Follow_O4_Y1_v03_2(); 
                    break;                                 
            }
            break;  
        case 1:
           // Sys_Range_O1_Y1_v03_1(callFrom);
            break; 
        case 2:
            //Sys_Range_O1_Y1_v03_1(callFrom);
            break; 
    }    
            
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);     
}


void Sys_MA_Tick_ResetVars()
{
    //SYS_RANGE_CURR_TOP_LEVEL = 0;
    //SYS_RANGE_CURR_BOTTOM_LEVEL = 0;
}



void Sys_MA_Tick_O1_Y1_v03_1(int callFrom)
{
    // misto
    SYS_TRAILING_STOP_PERMITION = true;

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_System;
    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_System;

    SELECTED_EST_TP_DISTANCE_CHOSEN = eOrDistance_TP_System; // vai ser obrigatoriamente 0 ou o valor justo do level chosen
    SELECTED_EST_SL_DISTANCE_CHOSEN = eOrDistance_SL_System;
        
    CancelSellOrders(_Symbol, "Sys_Range_O1_Y1_v03_1");
    CancelBuyOrders(_Symbol, "Sys_Range_O1_Y1_v03_1");

        
    TEMP_EN_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN;
    TEMP_EN_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX;

    TEMP_TP_LONG_VALUE = LEFT_BAR_LEVEL_MID;
    TEMP_TP_SHORT_VALUE = LEFT_BAR_LEVEL_MID;
    
    TEMP_SL_LONG_VALUE = LEFT_BAR_LOWESTLOW_MIN-SL_Distance_Long;
    TEMP_SL_SHORT_VALUE = LEFT_BAR_HIGHESTHIGH_MAX+SL_Distance_Short;

   
    
    LONG_CONDITIONS = false;
    SHORT_CONDITIONS = false;    

    double previous_ma = Get_MA(MA_SLOW, MA_SLOW_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    double current_ma = Get_MA(MA_SLOW, MA_SLOW_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
    
    
    if(current_ma < previous_ma)
    {

    }
    else
    {


    }

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(SERVER_SYMBOL_ASK < previous_ma)
    {

    }
    else
    {


    }   
}