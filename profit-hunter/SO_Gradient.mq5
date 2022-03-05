

#include "SO_Gradient_Settings.mq5"
#include "SO_Gradient_v1.mq5"

/*
input int GRADIENT_QTD = 10;
input double GRADIENT_FAT = 2; 
input bool GRADIENT_RAPLACE_MODE = false;
input bool GRADIENT_LOG_MODE = false;
*/

int GRADIENT_QTD = 10;
double GRADIENT_FAT = 2; 
bool GRADIENT_RAPLACE_MODE = false;
bool GRADIENT_LOG_MODE = false;


void SO_Gradient_ResetVars()
{
    /*
    SO_FOLLOW_CURR_TOP_LEVEL = 0;
    SO_FOLLOW_CURR_BOTTOM_LEVEL = 0;

    SO_FOLLOW_LAST_BOTTOM_LEVEL = 0;
    SO_FOLLOW_LAST_TOP_LEVEL = 0;


    SO_FOLLOW_CURR_SPREAD_ORDERS = 0;
    */

}

void SO_Gradient_InitLevels()
{
    /*
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
        SO_FOLLOW_LAST_TOP_LEVEL = SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Short;

    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        SO_FOLLOW_LAST_BOTTOM_LEVEL = SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Long;
    }

    SO_FOLLOW_CURR_SPREAD_ORDERS = SO_FOLLOW_CURR_TOP_LEVEL - SO_FOLLOW_CURR_BOTTOM_LEVEL;
    */
}

void SO_Gradient_Enforce_Condition()
{
    // não permite ficar sem ordem
    //if(FINAL_SHORT_VOLUME < SELECTED_LIMIT_POSITION_VOLUME)
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        /*
        if(LONG_CONDITIONS == false)
        {
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
            Print("Enforce_Condition LONG");
        }
        */
    }
    //if(FINAL_LONG_VOLUME < SELECTED_LIMIT_POSITION_VOLUME)
    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    {   
        /*     
        if(SHORT_CONDITIONS == false)
        {
            SHORT_CONDITIONS = true;
            TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
            Print("Enforce_Condition SHORT");
        }
        */
    }
}


void Sys_Gradient_x(int callFrom)
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

