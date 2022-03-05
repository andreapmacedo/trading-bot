//TODO
// remover essa var quando for possível
int SO_FOLLOW_LOCK = 0;




void SetLevelRef(double &top_level, double &bottom_level)
{


    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));

    int change = 0;
    //if(last_deal > 0)
    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;
        //Comment("Último Negócio " + last_deal);          
        change = 1;
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        
        top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        change = 2;  
    }
    else
    {
        /*
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;
         */
         
        top_level = SERVER_SYMBOL_ASK ;
        bottom_level = SERVER_SYMBOL_BID;         

                     
        change = 3;
    }

   // return change;

}

double top_level_anchor;
double bottom_level_anchor;

int CheckChangeLevel(double &top, double &bottom)
{

    int response = 0;

    if(top_level_anchor > 0)
    {
        if(top < top_level_anchor)
        {
            top_level_anchor = top;
            response = 1;
        }
        else
        {
            top = top_level_anchor;
        }
    }

    if(bottom_level_anchor > 0)
    {
        if(bottom > bottom_level_anchor)
        {
            bottom_level_anchor = bottom;
            response = 2;
        }
        else
        {
            bottom = bottom_level_anchor;
        }
    }
    return response;

}

void setLevelAnchor(double top_level, double bottom_level)
{
    top_level_anchor = top_level;
    bottom_level_anchor = bottom_level;
}

void Set_Market_Order_Trigger(double sell_vol, double buy_vol)
{

    double top_level;
    double bottom_level;

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    ////double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));

    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;

    }
    else
    {
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;         
    }

    if(CheckBuyManagemente_Evo())
    {
        
        if(bottom_level < EN_BUY_MARKET_LEVEL)
        {
            if(EN_BUY_MARKET_LEVEL > 0)
                Place_Market_Order_Evo(ORDER_TYPE_BUY, EN_BUY_MARKET_LEVEL, NULL , NULL,  buy_vol);
            else
                Print("EN_BUY_MARKET_LEVEL = 0");
        }

    }
    if(CheckSellManagemente_Evo())
    {
        if(top_level > EN_SELL_MARKET_LEVEL )
        {
            if(EN_SELL_MARKET_LEVEL > 0)
                Place_Market_Order_Evo(ORDER_TYPE_SELL, EN_SELL_MARKET_LEVEL, NULL , NULL,  sell_vol);
            else
                Print("EN_SELL_MARKET_LEVEL = 0");
        }
    }

    MarketOrder_Drawings();

}


void Set_Market_Order_Limit(double sell_vol, double buy_vol, int updated)
{

    double top_level;
    double bottom_level;

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    ////double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));

    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;

    }
    else
    {
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;         
    }
            

    if(CheckBuyManagemente_Evo())
    {
        //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP_LIMIT;
        if(bottom_level <= EN_BUY_MARKET_LEVEL)//POSITION_TYPE_BUY //POSITION_TYPE_SELL
        {
            //if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0)
            if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0)// || CountOrdersForPairType(ORDER_TYPE_BUY_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
            {

                if(EN_BUY_MARKET_LEVEL > 0)
                {
                    Place_Order_evo(EN_ORDER_TYPE_LONG, EN_BUY_MARKET_LEVEL, NULL , NULL,  buy_vol);
                    Print("Place_Order_evo");
                }
                else
                {
                    Print("EN_BUY_MARKET_LEVEL = 0");

                }
            }
        }
        if(updated == 1)
        {
            EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
            countOrdersCancel = UpdateOrderByType(EN_ORDER_TYPE_LONG, EN_BUY_MARKET_LEVEL, buy_vol);
            Print("modify buy");
        }

    }
    if(CheckSellManagemente_Evo())
    {
        //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP_LIMIT;
        if(top_level >= EN_SELL_MARKET_LEVEL )
        {
            //if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_SELL_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
            if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 ) 
            {

                    if(EN_SELL_MARKET_LEVEL > 0)
                    {
                        Place_Order_evo(EN_ORDER_TYPE_SHORT, EN_SELL_MARKET_LEVEL, NULL , NULL,  sell_vol);
                        Print("Place_Order_evo");
                    }
                    else
                    {
                        Print("EN_SELL_MARKET_LEVEL = 0");
                    }
                
            }
        }
        if(updated == 1)
        {
            countOrdersCancel = UpdateOrderByType(EN_ORDER_TYPE_SHORT, EN_SELL_MARKET_LEVEL, sell_vol);
            Print("modify sell");
        }
    }

    MarketOrder_Drawings();
}

void Set_Market_Order_Limit_Dev(double ori_top, double ori_bottom, double sell_vol, double buy_vol, int updated)
{

    double top_level;
    double bottom_level;

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    ////double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));

    if(last_deal > 0 && last_deal < ref_top && last_deal > ref_bottom)
    {
        top_level = last_deal;
        bottom_level = last_deal;

    }
    else
    {
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;         
    }
            

    if(CheckBuyManagemente_Evo())
    {
        //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP_LIMIT;
        if(bottom_level <= EN_BUY_MARKET_LEVEL)//POSITION_TYPE_BUY //POSITION_TYPE_SELL
        {
            //if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0)
            if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0)// || CountOrdersForPairType(ORDER_TYPE_BUY_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
            {

                if(EN_BUY_MARKET_LEVEL > 0)
                {
                    Place_Order_evo(EN_ORDER_TYPE_LONG, EN_BUY_MARKET_LEVEL, NULL , NULL,  buy_vol);
                    Print("Place_Order_evo");
                }
                else
                {
                    Print("EN_BUY_MARKET_LEVEL = 0");

                }
            }
        }
        if(updated == 1)
        {
            EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
            countOrdersCancel = UpdateOrderByType(EN_ORDER_TYPE_LONG, EN_BUY_MARKET_LEVEL, buy_vol);
            Print("modify buy");
        }

    }
    if(CheckSellManagemente_Evo())
    {
        //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP_LIMIT;
        if(top_level >= EN_SELL_MARKET_LEVEL )
        {
            //if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_SELL_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
            if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 ) 
            {

                    if(EN_SELL_MARKET_LEVEL > 0)
                    {
                        Place_Order_evo(EN_ORDER_TYPE_SHORT, EN_SELL_MARKET_LEVEL, NULL , NULL,  sell_vol);
                        Print("Place_Order_evo");
                    }
                    else
                    {
                        Print("EN_SELL_MARKET_LEVEL = 0");
                    }
                
            }
        }
        if(updated == 1)
        {
            countOrdersCancel = UpdateOrderByType(EN_ORDER_TYPE_SHORT, EN_SELL_MARKET_LEVEL, sell_vol);
            Print("modify sell");
        }
    }
}

bool CheckBuyManagemente()
{
    //bool response = true;
    if(
        pos_status == 0
        && pos_volume >= SELECTED_LIMIT_POSITION_VOLUME
        ) 
        {
            return  false;
        }
    return true;
}

bool CheckBuyManagemente_Evo()
{
    double currentPositionVolume;
    GetCurrentPositionVolume(currentPositionVolume);    
    if(
        pos_status == 0
        && currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME
        ) 
        {
            return  false;
        }
    else if(
        pos_status != 1
        && SELECTED_SELL_FIRST
        ) 
        {
            return  false;
        }    
    else if(
        pos_status != 1
        && DYT_SELL_FIRST
        ) 
        {
            return  false;
        }
    else if(
        !SELECTED_LONG_POSITION_ON
        )
        {
            return  false;
        }
    else if(
        pos_status == 0
        &&  (currentPositionVolume  + currentBuyVolume) > SELECTED_LIMIT_POSITION_VOLUME 
        )
        {
            currentBuyVolume = SELECTED_LIMIT_POSITION_VOLUME - currentPositionVolume;
        }
    
    if(
        currentBuyVolume > SELECTED_LIMIT_ORDER_VOLUME
        )
        {
            currentBuyVolume = SELECTED_LIMIT_ORDER_VOLUME;
        }    


    return true;    

}
bool CheckSellManagemente_Evo()
{

    double currentPositionVolume;
    GetCurrentPositionVolume(currentPositionVolume);
    if(
        pos_status == 1
        && currentPositionVolume >= SELECTED_LIMIT_POSITION_VOLUME
        ) 
        {
            return  false;
        }
    else if(
        pos_status != 0
        && SELECTED_BUY_FIRST
        ) 
        {
            return  false;
        }    
    else if(
        pos_status != 0
        && DYT_BUY_FIRST
        ) 
        {
            return  false;
        }
    else if(
        !SELECTED_SHORT_POSITION_ON
        )
        {
            return  false;
        }
    else if(
        pos_status == 1
        &&  (currentPositionVolume  + currentSellVolume) > SELECTED_LIMIT_POSITION_VOLUME
        )
        {
            currentSellVolume = SELECTED_LIMIT_POSITION_VOLUME - currentPositionVolume;
        }


    if(
        currentSellVolume > SELECTED_LIMIT_ORDER_VOLUME
        )
        {
            currentSellVolume = SELECTED_LIMIT_ORDER_VOLUME;
        }


    return true;    

}

bool CheckSellManagemente()
{
    //response = true;
    if(
        pos_status == 1
        && MyGetVolumePosition() >= SELECTED_LIMIT_POSITION_VOLUME
    )
    {
        return  false;

    }
    return true;
}

void SetLevelPlace(double &top_level, double &bottom_level)
{
    top_level += EN_Distance_Short;
    bottom_level -= EN_Distance_Long;
}

void MarketOrder_Drawings()
{
	int extend_line = 1000;

    //DeletAllDrawings_Tech_Range();

	//--- compra
    SetObjectLine("EN_BUY_MARKET_LEVEL",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					EN_BUY_MARKET_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					EN_BUY_MARKET_LEVEL,
                    clrDarkTurquoise,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );  	



    SetObjectLine("EN_SELL_MARKET_LEVEL",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					EN_SELL_MARKET_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					EN_SELL_MARKET_LEVEL,
                    clrDarkTurquoise,
                    1,
                    STYLE_DOT//STYLE_DOT                    
                    ); 

}



//----------------------------------------    
    double currentSellVolume;// = SELECTED_VOLUME_LONG;
    double currentBuyVolume;// = SELECTED_VOLUME_LONG;
    double Last_Buy_Vol = 0;
    double Last_Sell_Vol = 0;

    double Last_Level_Buy = 0;
    double Last_Level_Sell = 0;
    double Level_Buy = 0;
    double Level_Sell = 0;


    double Freeze_Central_Top = 0;
    double Freeze_Central_Bottom = 0;

    double Last_High_Top = 0;
    double Last_Low_Bottom = 0;


//----------------------------------------   


    double Top_Spread = 0;
    double Bottom_Spread = 0;


//----------------------------------------

    double Highest_Top = 0;
    double High_Top = 0;
    double Lowest_Top = 0;

    double Highest_Central_Top = 0;
    double Central_Top = 0;
    double Lowest_Central_Top = 0;
//----------------------------------------    

//----------------------------------------    
    double Highest_Central_Bottom = 0;
    double Central_Bottom = 0;
    double Lowest_Central_Bottom = 0;

    double Highest_Bottom = 0;
    double Low_Bottom = 0;
    double Lowest_Bottom = 0;

//----------------------------------------
    //double SERVER_SYMBOL_ASK;
    ////double SERVER_SYMBOL_BID;
    //double SERVER_SYMBOL_LAST;
    int Chosen_Center_Ref;
//----------------------------------------//----------------------------------------




int CountFreezeCentralLevel = 0;

void ResetAxlesLevels()
{
    Last_High_Top = 0;
    Last_Low_Bottom = 0;

    Highest_Top = 0;
    High_Top = 0;
    Lowest_Top = 0;

    Highest_Central_Top = 0;
    //Central_Top = 0;
    Lowest_Central_Top = 0;
  
    Highest_Central_Bottom = 0;
    //Central_Bottom = 0;
    Lowest_Central_Bottom = 0;

    Highest_Bottom = 0;
    Low_Bottom = 0;
    Lowest_Bottom = 0;
    
    CountFreezeCentralLevel = 0;
        
}


void ResetBottomAxlesLevels()
{
    Last_Low_Bottom = 0;
    Highest_Central_Bottom = 0;
    //Central_Bottom = 0;
    Lowest_Central_Bottom = 0;

    Highest_Bottom = 0;
    Low_Bottom = 0;
    Lowest_Bottom = 0;



}
void ResetTopAxlesLevels()
{
    Last_High_Top = 0;
    Highest_Top = 0;
    High_Top = 0;
    Lowest_Top = 0;

    Highest_Central_Top = 0;
    //Central_Top = 0;
    Lowest_Central_Top = 0;
}


double Last_Central_Level_Ref = 0;
// double Last_Central_Bottom_Level_Ref = 0;
// double Last_Central_Top_Level_Ref = 0;

int SetCentalAxles_evo(int callfrom)
{
    int response = 0;
    double currentPositionVolume;
    GetCurrentPositionVolume(currentPositionVolume);
    
    SetTradingMode();

    if(Current_Historic_Last_Deal_Price > 0 
        && !FOLLOW_MODE 
        && !FOLLOW_ME_BY_T1 
        && currentPositionVolume < SELECTED_LIMIT_POSITION_VOLUME
        && currentPositionVolume != 0
     )
    {
        if((Current_Historic_Last_Deal_Price + SELECTED_EN_DISTANCE_SHORT) > SERVER_SYMBOL_BID)
        {
            Central_Top = Current_Historic_Last_Deal_Price;
        }  
        else
        {
            Central_Top = SERVER_SYMBOL_ASK; 
        }
        if((Current_Historic_Last_Deal_Price - SELECTED_EN_DISTANCE_LONG)  < SERVER_SYMBOL_ASK)
        {
            Central_Bottom = Current_Historic_Last_Deal_Price;
        }
        else
        {
            Central_Bottom = SERVER_SYMBOL_BID;
        }
            response = 1; 
    }

    else if(SERVER_SYMBOL_LAST > 0
        && (SERVER_SYMBOL_LAST + SELECTED_EN_DISTANCE_SHORT)  > SERVER_SYMBOL_BID    
        && (SERVER_SYMBOL_LAST - SELECTED_EN_DISTANCE_LONG) < SERVER_SYMBOL_ASK 
    )
    {


        Central_Top = SERVER_SYMBOL_LAST;
        Central_Bottom = SERVER_SYMBOL_LAST;
        response = 2;     
    }
    else
    {
        Central_Top = SERVER_SYMBOL_ASK;
        Central_Bottom = SERVER_SYMBOL_BID;        
        response = 3;                          
    }

    if(CountFreezeCentralLevel == 0)
    {
        Freeze_Central_Top = Central_Top;
        Freeze_Central_Bottom = Central_Bottom;        
        Print("Freeze_Central_Top: ", Freeze_Central_Top);
        Print("Freeze_Central_Bottom: ", Freeze_Central_Bottom);
    
    }    


    CountFreezeCentralLevel = 1;
    //Print("SetCentalAxles_evo - > return: ", response);
    return response;

}


int SetCentalAxles_BA()
{
    //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   // //SERVER_SYMBOL_LAST = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

   // double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
   // double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));
    int response = 0;

    // if(SERVER_SYMBOL_LAST > 0 && SERVER_SYMBOL_LAST < ref_top && SERVER_SYMBOL_LAST > ref_bottom)
    // {
    //     Central_Top = SERVER_SYMBOL_LAST;
    //     Central_Bottom = SERVER_SYMBOL_LAST;
    //     response = 1;
    // }
    // else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    // {
    //     Central_Top = DYT_SYMBOL_LAST_DEAL_PRICE;
    //     Central_Bottom = DYT_SYMBOL_LAST_DEAL_PRICE;
    //     response = 2;     
    // }
   // else
   // {
        Central_Top = SERVER_SYMBOL_ASK;
        Central_Bottom = SERVER_SYMBOL_BID;         
        response = 3;                          
   // }

    if(CountFreezeCentralLevel == 0)
    {
        Freeze_Central_Top = Central_Top;
        Freeze_Central_Bottom = Central_Bottom;        
    }    

    CountFreezeCentralLevel = 1;

    return response;

}

void SetAllFlows()
{
    //SetCentralFlows();
    SetLowLevels();
    SetHighLevels();
}

void SetCentralFlows() //not usde 
{
    if(Highest_Central_Bottom > 0)
    {
        if(Central_Bottom > Highest_Central_Bottom)
        {
            Highest_Central_Bottom = Central_Bottom;   
        }
    }
    else
    {
        Highest_Central_Bottom = Central_Bottom; // inicial ou zerado
    }

    if(Lowest_Central_Bottom > 0)
    {
        if(Central_Bottom < Lowest_Central_Bottom)
        {
            Lowest_Central_Bottom = Central_Bottom;   
        }
    }
    else
    {
        Lowest_Central_Bottom = Central_Bottom; // inicial ou zerado
    }
    
    if(Highest_Central_Top > 0)
    {
        if(Central_Top > Highest_Central_Top)
        {
            Highest_Central_Top = Central_Top;   
        }
    }
    else
    {
        Highest_Central_Top = Central_Top; // inicial ou zerado
    }

    if(Lowest_Central_Top > 0)
    {
        if(Central_Top < Lowest_Central_Top)
        {
            Lowest_Central_Top = Central_Top;   
        }
    }
    else
    {
        Lowest_Central_Top = Central_Top; // inicial ou zerado
    }
}



void SetBottomMagneticMovie()
{
    if(SERVER_SYMBOL_LAST > 0)
    {
        Central_Bottom = SERVER_SYMBOL_LAST;
    }
    else
    {
        Central_Bottom = SERVER_SYMBOL_BID;
    }
    
    SetLowLevels();
    Level_Buy = Highest_Bottom;
}
void SetTopMagneticMovie()
{
    if(SERVER_SYMBOL_LAST > 0)
    {
        Central_Top = SERVER_SYMBOL_LAST;
    }
    else
    {
        Central_Top = SERVER_SYMBOL_ASK;
    }

    SetHighLevels();
    Level_Sell = Lowest_Top;
}

double LAST_SPD = 0;
double MAX_SPD = 0;
double FREEZE_SPD = 0;

void SetTopMagneticMovie_Pro()
{
        

    if(SERVER_SYMBOL_LAST > 0)
    {
        Central_Top = SERVER_SYMBOL_LAST;
    }
    else
    {
        Central_Top = SERVER_SYMBOL_ASK;
    }

    SetHighLevels();
    Level_Sell = Lowest_Top;
    
    if(SPD_LEVELS > LAST_SPD)
    {
        LAST_SPD = SPD_LEVELS; // vai resetar o limite de spd
        FREEZE_SPD = SPD_LEVELS;
        if(LAST_SPD > MAX_SPD)
        {
            MAX_SPD = LAST_SPD;
        }
    } 
    if(spd < LAST_SPD)
    {
        double temp;
        //temp = (FREEZE_SPD - SPD_LEVELS);
        temp = (SPD_LEVELS -FREEZE_SPD );
        Print("FREEZE_SPD - spd high level  -> ", temp);
        TopChange += temp;
        
    }
    

}
void SetBottomMagneticMovie_Pro()
{
    if(SERVER_SYMBOL_LAST > 0)
    {
        Central_Bottom = SERVER_SYMBOL_LAST;
    }
    else
    {
        Central_Bottom = SERVER_SYMBOL_BID;
    }
    
    SetLowLevels();
    Level_Buy = Highest_Bottom;

    if(SPD_LEVELS > LAST_SPD)
    {
        LAST_SPD = SPD_LEVELS; // vai resetar o limite de spd
        FREEZE_SPD = SPD_LEVELS;
        if(LAST_SPD > MAX_SPD)
        {
            MAX_SPD = LAST_SPD;
        }
    } 
    if(SPD_LEVELS < LAST_SPD)
    {
        double temp;
        //temp = (FREEZE_SPD - SPD_LEVELS);
        temp = (SPD_LEVELS -FREEZE_SPD ) ;
        Print("FREEZE_SPD - spd - low level -> ", temp);
        BottomChange += temp;
    }
}

bool ChangeHighest_Bottom = false;
void SetLowLevels()
{
    //Low_Bottom = (Central_Bottom - EN_Distance_Long); //(var_changed)  
    Low_Bottom = (Central_Bottom - SELECTED_EN_DISTANCE_LONG); //(var_changed)  
   // ChangeHighest_Bottom = false;
    if(Highest_Bottom > 0)
    {
        if(Low_Bottom > Highest_Bottom)
        {
            Highest_Bottom = Low_Bottom;   
          // ChangeHighest_Bottom = true;
        }
    }
    else
    {
        Highest_Bottom = Low_Bottom;
       // ChangeHighest_Bottom = true;
    }

    if(Lowest_Bottom > 0)
    {
        if(Low_Bottom < Lowest_Bottom)
        {
            Lowest_Bottom = Low_Bottom;   
        }
    }
    else
    {
        Lowest_Bottom = Low_Bottom;
    }
}

bool ChangeLowestTop = false;
void SetHighLevels()
{
    //High_Top = (Central_Top + EN_Distance_Short);
    High_Top = (Central_Top + SELECTED_EN_DISTANCE_SHORT); //(var_changed) 
    //ChangeLowestTop = false;
    if(Highest_Top > 0)
    {
        if(High_Top > Highest_Top)
        {
            Highest_Top = High_Top;   
        }
    }
    else
    {
        Highest_Top = High_Top;
    }

    if(Lowest_Top > 0)
    {
        if(High_Top < Lowest_Top)
        {
            Lowest_Top = High_Top;
           // ChangeLowestTop = true; 
        }
    }
    else
    {
        Lowest_Top = High_Top;
        //ChangeLowestTop = true;          
    }
}



/*
int SetCentalAxles()
{
    //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //SERVER_SYMBOL_LAST = SymbolInfoDouble(_Symbol, SYMBOL_LAST);

    double ref_top = (SERVER_SYMBOL_ASK +  (SERVER_SYMBOL_ASK*0.2));
    double ref_bottom = (SERVER_SYMBOL_BID -  (SERVER_SYMBOL_BID*0.2));

    if(SERVER_SYMBOL_LAST > 0 && SERVER_SYMBOL_LAST < ref_top && SERVER_SYMBOL_LAST > ref_bottom)
    {
        Central_Top = SERVER_SYMBOL_LAST;
        Central_Bottom = SERVER_SYMBOL_LAST;
        return 1;
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        Central_Top = DYT_SYMBOL_LAST_DEAL_PRICE;
        Central_Bottom = DYT_SYMBOL_LAST_DEAL_PRICE;
        return 2;     
    }
    else
    {
        Central_Top = SERVER_SYMBOL_ASK;
        Central_Bottom = SERVER_SYMBOL_BID;         
        return 3;                          
    }
}


void SetCentralFlows()
{
    if(Highest_Central_Bottom > 0)
    {
        if(Central_Bottom > Highest_Central_Bottom)
        {
            Highest_Central_Bottom = Central_Bottom;   
        }
    }
    else
    {
        Highest_Central_Bottom = Central_Bottom;
    }

    if(Lowest_Central_Bottom > 0)
    {
        if(Central_Bottom < Lowest_Central_Bottom)
        {
            Lowest_Central_Bottom = Central_Bottom;   
        }
    }
    else
    {
        Lowest_Central_Bottom = Central_Bottom;
    }
}




void SetLowLevels(double &top_level, double &bottom_level)
{
    Low_Bottom = (Central_Bottom - EN_Distance_Long);

    if(Highest_Bottom > 0)
    {
        if(Low_Bottom > Highest_Bottom)
        {
            Highest_Bottom = Low_Bottom;   
        }
    }
    else
    {
        Highest_Bottom = Low_Bottom;
    }

    if(Lowest_Bottom > 0)
    {
        if(Low_Bottom < Lowest_Bottom)
        {
            Lowest_Bottom = Low_Bottom;   
        }
    }
    else
    {
        Lowest_Bottom = Low_Bottom;
    }
}

void SetHighLevels(double &top_level, double &bottom_level)
{
    High_Top = (Central_Top + EN_Distance_Short);
    
    if(Highest_Top > 0)
    {
        if(High_Top > Highest_Top)
        {
            Highest_Top = High_Top;   
        }
    }
    else
    {
        Highest_Top = High_Top;
    }

    if(Lowest_Top > 0)
    {
        if(High_Top < Lowest_Top)
        {
            Lowest_Top = High_Top;   
        }
    }
    else
    {
        Lowest_Top = High_Top;
    }
}

*/