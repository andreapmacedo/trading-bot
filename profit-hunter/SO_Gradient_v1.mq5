





void Sys_Gradient_01(int callFrom)
{

    SO_Follow_InitLevels();
    //SO_Follow_ChangeLevels_v2();
    SO_Follow_ChangeLevels_Vw();
    //SO_Follow_ChangeLevels_v2();
    
    /*
    if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        SO_Follow_Enforce_Condition();
    }
    */
    
    switch(SELECTED_EN_MODE) // Version
    {
        case 1:
            SO_Follow_EN_Full_Free(); 
            break;                                                          
        case 2:
            SO_Follow_EN_Full_Default(); 
            break;                               
        case 3:
            SO_Follow_EN_Full_Lock(); 
            break;                               
        default:
            SO_Follow_EN_Full_System(); 
            break;                                
    }            
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
}







void Sys_Gradient_02(int callFrom)
{
    Print("SO_Part_Make_Gradient");
    SYS_TRAILING_STOP_PERMITION = false;

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);    
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);

    //TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
    //TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
    double gspd_long = EN_Distance_Long;
    double gspd_short = EN_Distance_Short;
    CancelSellOrders(_Symbol, "SO_Part_Make_Gradient");
    CancelBuyOrders(_Symbol, "SO_Part_Make_Gradient");
    
   // TEMP_EN_LONG_VALUE = LAST_BID;
   // TEMP_EN_SHORT_VALUE = LAST_ASK;

    LONG_CONDITIONS 	= true;
    SHORT_CONDITIONS 	= true;

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;
    

    for (int i = 1; i <= GRADIENT_QTD; i++)
    {
        if(GRADIENT_LOG_MODE)
        {
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID - (EN_Distance_Long * i) * (i * GRADIENT_FAT * EN_Distance_Long);
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK + (EN_Distance_Short * i) * (i * GRADIENT_FAT * EN_Distance_Short);
            Print("GRADIENT_LOG_MODE + " + i);
        }
        else
        {
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID - (EN_Distance_Long * i);
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK + (EN_Distance_Short * i);
            Print("GRADIENT_LINEAR_MODE + " + i);
        }

        
       // SetOrdersSettings(DISTANCE_CHOSEN_TYPE, LEVEL_CHOSEN_TYPE);

	    FINAL_EN_LONG_VALUE  =  NormalizeDouble((MyRound(TEMP_EN_LONG_VALUE)), _Digits);
	    FINAL_EN_SHORT_VALUE =  NormalizeDouble((MyRound(TEMP_EN_SHORT_VALUE)), _Digits);
       
        if(SELECTED_TP_ON)
	    {
            FINAL_TP_LONG_VALUE  =  NormalizeDouble((MyRound(TEMP_EN_LONG_VALUE + SELECTED_EN_DISTANCE_LONG_VALUE)), _Digits);
            FINAL_TP_SHORT_VALUE =  NormalizeDouble((MyRound(TEMP_EN_SHORT_VALUE - SELECTED_EN_DISTANCE_SHORT_VALUE)), _Digits);
        }


        PlaceOrders(0);  
    }
}

