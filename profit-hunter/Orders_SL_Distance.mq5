
void SL_OrderDistance_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 1:
            SL_STR_Distance_1();
            break;
        case 201:
            SL_STR_Distance_201(); 
            break;
    }

}



void SL_STR_Distance_1()
{
    if(!BREAK_MODE)
    {
        Level_sl_long -= SL_Distance_Long;
        Level_sl_short += SL_Distance_Short;
    }
    else
    {
        Level_sl_long += SL_Distance_Long;
        Level_sl_short -= SL_Distance_Short;
    }
    CheckValidity_SL();
}
void SL_STR_Distance_201()
{
    Level_sl_long += SL_Distance_Long;
    Level_sl_short -= SL_Distance_Short;    
    CheckValidity_SL();
}


void CheckValidity_SL()
{
    if(!BREAK_MODE)
    {
        if(Level_sl_long > Level_Buy)
        {
            Level_sl_long = NULL; 
            
        }
        if(Level_sl_short < Level_Sell)
        {
            Level_sl_short = NULL; 
        }
    }
    else
    {
        if(Level_sl_long < Level_Buy)
        {
            Level_sl_long = NULL; 
            // Level_sl_short = NULL;
        }     
        if(Level_sl_short > Level_Sell)
        {
            Level_sl_short = NULL; 
        }           
    }
}