



// trailing activator
// media móvel
// x barras
// x pontos
// trailing de gestão de volume ao no lugar da ordem SL

// setup de trap no range

// os setups de trap serão 


bool SYS_TRAILING_STOP_PERMITION = true;



bool TRAILING_STOP_ON                       = false;


double TRAILING_PTS_TRIGGER                 = 0;
int MA_TRAILING_TRIGGER              = 9;      
int TRAILING_BAR_SEQUENCE_TRIGGER           = 1;      



double SELECTED_TRAILING_STOP_DISTANCE = TRAILING_Distance;
double SELECTED_TRAILING_STOP_CHOSEN = INPUT_TRAILING_STOP_EST_CHOSEN;


double SELECTED_TRAILING_STOP_LONG_LEVEL;
double SELECTED_TRAILING_STOP_SHORT_LEVEL;

double TEMP_TRAILING_STOP_LONG_LEVEL;
double TEMP_TRAILING_STOP_SHORT_LEVEL;

double PREVIOUS_TRAILING_LONG_VALUE = 0;
double PREVIOUS_TRAILING_SHORT_VALUE = 0;


enum enum_EN_Order_Trailing_Stop
{
    eOrTrailing_Stop_System                = 0,
    eOrTrailing_Stop_Default               = 1,
    eOrTrailing_Stop_Bar_To_Bar            = 2,
    eOrTrailing_Stop_MA                    = 3,
    eOrTrailing_Stop_Range                 = 4
};

//bool trl_stp_BAR_TO_BAR_BIGGEST_TWO = false;

void Set_OrderTrailingStop_Settings(int chosen, int side)
{
    //Print("Set_OrderTrailingStop_Settings buy");


    if(TRAILING_STOP_ON && SYS_TRAILING_STOP_PERMITION)
    {
        //Print("Set_OrderTrailingStop_Settings buy");
        switch(chosen)
        {
            case eOrTrailing_Stop_System: 
                break;
            case eOrTrailing_Stop_Default:
                Set_Trailing_Stop_MA(side);
                break;
            case eOrTrailing_Stop_Bar_To_Bar:
                Set_Trailing_Stop_Bar(side);
                break;                  
            case eOrTrailing_Stop_MA:
                Set_Trailing_Stop_MA(side);
                break;                  
            default:
                Set_Trailing_Stop_Bar(side);
                break;
        }
    }
}


void SIMULATED_Set_OrderTrailingStop_Settings(int chosen, int side)
{

    if(TRAILING_STOP_ON && SYS_TRAILING_STOP_PERMITION)
    {
        switch(chosen)
        {
            case eOrTrailing_Stop_System: 
                break;
            case eOrTrailing_Stop_Default:
                Set_Trailing_Stop_MA(side);
                break;
            case eOrTrailing_Stop_Bar_To_Bar:
                Set_Trailing_Stop_Bar(side);
                break;                  
            case eOrTrailing_Stop_MA:
                Set_Trailing_Stop_MA(side);
                break;                  
            default:
                Set_Trailing_Stop_Bar(side);
                break;
        }
    }
}




void Set_OrderTrailingStop_Settings_By_Tick(int chosen, int side)
{

}



void Set_Trailing_Stop_Bar(int side)
{

    double SL;
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    
    TEMP_TRAILING_STOP_LONG_LEVEL = PriceInfo[1].low;
    TEMP_TRAILING_STOP_SHORT_LEVEL = PriceInfo[1].high;


    if(pos_status == 1) // comprado
    {
        Print("trailing buy");
        if(
            //PriceInfo[1].high > pos_price + TRAILING_PTS_TRIGGER
            PriceInfo[1].high > pos_price 
            //&& NO_BREAKDOWN_BAR_SEQUENCE > TRAILING_BAR_SEQUENCE_TRIGGER
            && pos_price < (SERVER_SYMBOL_BID + TRAILING_PTS_TRIGGER)
            )
        {

            if(side == eSide_Trend)
            {
                SL = NormalizeDouble((MyRound(TEMP_TRAILING_STOP_LONG_LEVEL - SELECTED_TRAILING_STOP_DISTANCE)), _Digits);                
            }
            else
            {
                SL = NormalizeDouble((MyRound(TEMP_TRAILING_STOP_SHORT_LEVEL - SELECTED_TRAILING_STOP_DISTANCE)), _Digits);                
            }

        }        
        if(SL < SERVER_SYMBOL_BID)
        {
            Modify_SL(SL); 
            PREVIOUS_TRAILING_LONG_VALUE = SL;
        }
        else
        {
            if(PREVIOUS_TRAILING_LONG_VALUE != 0)
            {
                Modify_SL(PREVIOUS_TRAILING_LONG_VALUE); 
            }
            else 
            {
                Modify_SL(TEMP_SL_LONG_VALUE); 
            }
        }
    }
    else if(pos_status == -1) // vendido
    {
        Print("trailing sell");
        if(
            PriceInfo[1].low < pos_price 
            && pos_price > (SERVER_SYMBOL_ASK - TRAILING_PTS_TRIGGER)           
            //&& NO_BREAKOUT_BAR_SEQUENCE > TRAILING_BAR_SEQUENCE_TRIGGER          
            )
        {
            //double SL = NormalizeDouble((MyRound(PriceInfo[0].low + TRAILING_Distance)), _Digits);
            if(side == eSide_Trend)
            {

                SL = NormalizeDouble((MyRound(TEMP_TRAILING_STOP_SHORT_LEVEL + SELECTED_TRAILING_STOP_DISTANCE)), _Digits);
            }
            else
            {
                SL = NormalizeDouble((MyRound(TEMP_TRAILING_STOP_LONG_LEVEL + SELECTED_TRAILING_STOP_DISTANCE)), _Digits);
            }

        }
        if(SL > SERVER_SYMBOL_ASK)
        {
            Modify_SL(SL); 
            PREVIOUS_TRAILING_SHORT_VALUE = SL;
        }
        else
        {
            if(PREVIOUS_TRAILING_SHORT_VALUE != 0)
            {
                Modify_SL(PREVIOUS_TRAILING_SHORT_VALUE); 
            }
            else 
            {
                Modify_SL(TEMP_SL_SHORT_VALUE); 
            }
        }
    }
}

double MA_Trailing_selected;
void Set_Trailing_Stop_MA(int side)
{

    double SL;
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    

    
    //double MA_Trailing_selected =  MyRound(Get_MA(MA_TRAILING_TRIGGER, 0,  MODE_EMA, 0));
    double MA_Trailing_selected = MA_TRAILING_TRIGGER_VALUE;
    TEMP_TRAILING_STOP_LONG_LEVEL = MA_TRAILING_TRIGGER_VALUE;
    TEMP_TRAILING_STOP_SHORT_LEVEL = MA_TRAILING_TRIGGER_VALUE;


    if(pos_status == 1) // comprado
    {
        Print("trailing buy");
        if(
            SERVER_SYMBOL_BID > pos_price + TRAILING_PTS_TRIGGER
            //PriceInfo[1].high > pos_price
            && PriceInfo[1].close < MA_Trailing_selected
            )
        {

            if(side == eSide_Trend)
            {
                SL = NormalizeDouble((MyRound(PriceInfo[1].low - SELECTED_TRAILING_STOP_DISTANCE)), _Digits);                
            }
            else
            {
                SL = NormalizeDouble((MyRound(PriceInfo[1].low - SELECTED_TRAILING_STOP_DISTANCE)), _Digits);                
            }

        }        
        if(SL < SERVER_SYMBOL_BID)
        {
            Modify_SL(SL); 
            PREVIOUS_TRAILING_LONG_VALUE = SL;
        }
        else
        {
            if(PREVIOUS_TRAILING_LONG_VALUE != 0)
            {
                Modify_SL(PREVIOUS_TRAILING_LONG_VALUE); 
            }
            else 
            {
                Modify_SL(TEMP_SL_LONG_VALUE); 
            }
        }
    }
    else if(pos_status == -1) // vendido
    {
        Print("trailing sell");
        if(
            SERVER_SYMBOL_ASK < pos_price - TRAILING_PTS_TRIGGER
            && PriceInfo[1].close > MA_Trailing_selected 
            //&& pos_price > (SERVER_SYMBOL_ASK - TRAILING_PTS_TRIGGER)              
            )
        {
            //double SL = NormalizeDouble((MyRound(PriceInfo[0].low + TRAILING_Distance)), _Digits);
            if(side == eSide_Trend)
            {

                SL = NormalizeDouble((MyRound(PriceInfo[1].high + SELECTED_TRAILING_STOP_DISTANCE)), _Digits);
            }
            else
            {
                SL = NormalizeDouble((MyRound(PriceInfo[1].high + SELECTED_TRAILING_STOP_DISTANCE)), _Digits);
            }

        }
        if(SL > SERVER_SYMBOL_ASK)
        {
            Modify_SL(SL); 
            PREVIOUS_TRAILING_SHORT_VALUE = SL;
        }
        else
        {
            if(PREVIOUS_TRAILING_SHORT_VALUE != 0)
            {
                Modify_SL(PREVIOUS_TRAILING_SHORT_VALUE); 
            }
            else 
            {
                Modify_SL(TEMP_SL_SHORT_VALUE); 
            }
        }
    }
}









void TrailingStop()
{
    if(TRAILING_STOP_ON && SYS_TRAILING_STOP_PERMITION)
    {
        if(pos_status == 1) // comprado
        {
            if(PriceInfo[0].high > pos_price + TRAILING_PTS_TRIGGER)
            {
                double SL = NormalizeDouble((MyRound(PriceInfo[0].high - TRAILING_Distance)), _Digits);
                Modify_SL_TP(SL, NULL);
            }
            
            
            Print("trailing buy");
        }
        else if(pos_status == -1) // vendido
        {
            if(PriceInfo[0].low < pos_price - TRAILING_PTS_TRIGGER)
            {
                double SL = NormalizeDouble((MyRound(PriceInfo[0].low + TRAILING_Distance)), _Digits);
                Modify_SL_TP(SL, NULL);
            }
            Print("trailing sell");
        }
    }

}