
double SYS_RANGE_CURR_BOTTOM_LEVEL      = 0;
double SYS_RANGE_CURR_TOP_LEVEL         = 0;
//Sys_Range

void SO_Range(int callFrom)
{

    //--- Este SO não permite alteração na escolha do level
    //SO_Follow_SET_EN_LEVEL_CHOSEN();
    //SO_Follow_SET_EN_DISTANCE_CHOSEN();
    //SO_Follow_SET_EN_VOLUME_CHOSEN();
    
    SELECTED_EST_EN_ANCHOR_CHOSEN        = INPUT_EN_EST_ANCHOR_CHOSEN; 
    SELECTED_EST_EN_DISTANCE_CHOSEN     = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN       = INPUT_EN_EST_VOLUME_CHOSEN;

    //--- Já está definido na criação da variável.
    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    

    switch(callFrom)
    {
        case eCallFrom_NewTradingFloor: // NewBar   
            switch(SELECTED_SYS)
            {
                case 1:
                    Sys_Range_001v00(callFrom);
                    break;        
                case 2:
                    break;
                case 3:
                    break;                    
            }     
            break;
        case eCallFrom_OnTick: // OnTick
            break;
        case 10: // buy
            break;
        case 20: // sell
            break;
        case 100: // TP
            break;
        case 200: // SL
            break;
        default:
            Print("def");
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


void Sys_Range_001v00(int callFrom)
{

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    
    //SELECTED_EST_TP_ANCHOR_CHOSEN         = eOrLevel_TP_X_BarLevel;//INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_TP_DISTANCE_CHOSEN      = eOrDistance_EN_Pts;//INPUT_TP_EST_DISTANCE_CHOSEN;     
    
    
    //SELECTED_EST_SL_ANCHOR_CHOSEN         = eOrLevel_TP_X_BarLevel;//INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_SL_DISTANCE_CHOSEN      = eOrDistance_EN_Pts;//INPUT_TP_EST_DISTANCE_CHOSEN;   
        
        CancelSellOrders(_Symbol, "Sys_Range_001v00");
        CancelBuyOrders(_Symbol, "Sys_Range_001v00");

        SYS_RANGE_CURR_TOP_LEVEL = LAST_LEFT_BAR_HIGHESTHIGH_MAX;
        SYS_RANGE_CURR_BOTTOM_LEVEL = LAST_LEFT_BAR_LOWESTLOW_MIN;
        
        TEMP_EN_SHORT_VALUE = LAST_LEFT_BAR_HIGHESTHIGH_MAX;
        TEMP_EN_LONG_VALUE = LAST_LEFT_BAR_LOWESTLOW_MIN;
        

}