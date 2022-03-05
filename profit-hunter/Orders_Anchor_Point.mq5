

bool BREAK_MODE = false;

enum enum_EN_Order_Level
{
    eOrLevel_EN_System                 = 0,
    eOrLevel_EN_Default                = 1,
    eOrLevel_EN_BidAsk                 = 2,
    eOrLevel_EN_Last_Deal              = 3,
    eOrLevel_EN_Last_Bar_HL            = 4,
    eOrLevel_EN_X_BarLevel             = 5,
    eOrLevel_EN_First_EN               = 6,
    eOrLevel_EN_PM                     = 7

};

// New
//___________

enum enum_EN_Anchor
{
    Order_EN_Anchor_01                 = 1,
    Order_EN_Anchor_02                 = 2
};



// void EN_OrderAnchor_Settings(int chosen)
// {
//     switch(chosen)
//     {
//         case 0: 
//             break;
//         case 1:
//             Set_EN_OrderAnchor_001(); 
//             break;
//         case 2:
//             Set_EN_OrderAnchor_002(); 
//             break;
//     }
// }
// void TP_OrderAnchor_Settings(int chosen)
// {
//     switch(chosen)
//     {
//         case 0: 
//             break;
//         case 1: 
//             Set_TP_OrderAnchor_001();
//             break;
//     }
// }
// void SL_OrderAnchor_Settings(int chosen)
// {
//     switch(chosen)
//     {
//         case 0: 
//             break;
//         case 1: 
//             Set_SL_OrderAnchor_001();
//             break;
//     }
// }



void Set_EN_OrderAnchor_001()
{
    Level_Buy = PriceInfo[1].low;
    Level_Sell = PriceInfo[1].high;
}
void Set_EN_OrderAnchor_002()
{
    Level_Buy = PriceInfo[1].high;
    Level_Sell = PriceInfo[1].low;
}
void Set_EN_OrderAnchor_003()
{
    double half_Level = ((PriceInfo[1].high - PriceInfo[1].low)/2); 
    Level_Buy = half_Level;
    Level_Sell = half_Level;
}


void Set_TP_OrderAnchor_001()
{
    Level_tp_long = Level_Buy;
    Level_tp_short = Level_Sell;
}
void Set_TP_OrderAnchor_002()
{
    Level_tp_long = PriceInfo[1].high;
    Level_tp_short = PriceInfo[1].low;
}
void Set_TP_OrderAnchor_003()
{

}


void Set_SL_OrderAnchor_001()
{
    Level_sl_long = Level_Buy;
    Level_sl_short = Level_Sell;
}
void Set_SL_OrderAnchor_002()
{
    Level_sl_long = PriceInfo[1].low;
    Level_sl_short = PriceInfo[1].high;
}
void Set_SL_OrderAnchor_003()
{

}

// Old
//___________

//--- Modifica a ordem para o tipo gatilho de rompimento 
void SetBreakModeOrderType()
{
    if(BREAK_MODE)
    {
        EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
        EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;
    }
}

//--- inverte a polaridade da distância definida pelo usuário 
void Set_BreakModeInverterSignal()
{
    if(BREAK_MODE)
    {
        SELECTED_EN_DISTANCE_LONG_VALUE  = SELECTED_EN_DISTANCE_LONG_VALUE * (-1);
        SELECTED_EN_DISTANCE_SHORT_VALUE  = SELECTED_EN_DISTANCE_SHORT_VALUE * (-1);
    }
}

void Set_EN_Orders_Level_Settings(int chosen)
{
    switch(chosen)
    {
        case eOrLevel_EN_System: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            break;
        case eOrLevel_EN_Default: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            Set_EN_OrdersLevel_BidAsk();
            break;
        case eOrLevel_EN_BidAsk:
            Set_EN_OrdersLevel_BidAsk();
            break;
        case eOrLevel_EN_Last_Deal: 
            Set_EN_OrdersLevel_LastDeal();
            break;                
        case eOrLevel_EN_X_BarLevel: 
            break;             
        default:
            Set_EN_OrdersLevel_BidAsk();
            break;
    }

}

void Set_EN_OrdersLevel_System()
{
    //--- Toda implementação deverá ocorrer dentro do systema e não será alterada aqui
    //Print("OrdersLevel set by System");
}



void Set_EN_OrdersLevel_BidAsk()
{
    
    TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
}


void Set_EN_OrdersLevel_LastDeal()
{
    TEMP_EN_LONG_VALUE = CURRENT_SYMBOL_DEAL;
    TEMP_EN_SHORT_VALUE = CURRENT_SYMBOL_DEAL; 
}

void Set_EN_OrdersLevel__Bar_HL()
{
	if(BREAK_MODE)
	{
        TEMP_EN_LONG_VALUE  = PriceInfo[1].high;
        TEMP_EN_SHORT_VALUE  = PriceInfo[1].low; 
	}
    else
    {
        TEMP_EN_LONG_VALUE  = PriceInfo[1].low;
        TEMP_EN_SHORT_VALUE  = PriceInfo[1].high; 
    }
}



//---Tamanho da última barra * fator
void Set_EN_OrdersLevelRef__BarLevel()
{
    double barLevel = PriceInfo[1].high - ((PriceInfo[1].high - PriceInfo[1].low) * X_SIZE);
    TEMP_EN_LONG_VALUE  = barLevel;
    TEMP_EN_SHORT_VALUE  = barLevel;
}


void Set_EN_OrdersLevelRef__MovingAvarage()
{
    TEMP_EN_LONG_VALUE = Get_MA(MA_SLOW, MA_SLOW_SHIFT,  MODE_EMA, 0); //(período, deslocamento, tipo de suavisação, tipo de preço, timeframe)       
    TEMP_EN_SHORT_VALUE = Get_MA(MA_SLOW, MA_SLOW_SHIFT,  MODE_EMA, 0);
}

void Set_EN_OrdersLevelRef__BollingerBands()
{
    Set_Bollinger_Bands(0);
    TEMP_EN_LONG_VALUE = LoweBandValue;
    TEMP_EN_SHORT_VALUE = UpperBandValue;    
}

void Set_EN_OrdersLevelRef__PriceClose()
{
    TEMP_EN_LONG_VALUE = PriceInfo[1].close;
    TEMP_EN_SHORT_VALUE = PriceInfo[1].close;    
}

//____________________________________//_____________________________________
//---
enum enum_TP_Order_Level
{
    eOrLevel_TP_System               = 0,
    eOrLevel_TP_Default                    = 1,
    eOrLevel_TP_BidAsk                     = 2,
    eOrLevel_TP_Last_Deal                  = 3,
    eOrLevel_TP_X_BarLevel                 = 4,
    eOrLevel_TP_Current_EN_Mid             = 5,
    eOrLevel_TP_Last_EN_Chosen_Ref         = 6,
    eOrLevel_TP_Last_EN_Defined_Level      = 7
};

void Chosen_TP_OrdersLevel_Settigns(int chosen)
{
    switch(chosen)
    {
        case eOrLevel_TP_System:

            break;            
        case eOrLevel_TP_Default:
            Set_TP_OrdersLevel_EN_Final();
            break;
        case eOrLevel_TP_BidAsk:

            break;           
        case eOrLevel_TP_Last_Deal:
            
            break;
        case eOrLevel_TP_X_BarLevel:
            
            break;
        case eOrLevel_TP_Current_EN_Mid:

            break;                                
        case eOrLevel_TP_Last_EN_Chosen_Ref:
            Set_TP_OrdersLevel_Current_En_Current();
            break;                                
        default:
            Set_TP_OrdersLevel_EN_Final();
            break;            
    }  
}

void Set_TP_OrdersLevel_EN_Final()
{
        TEMP_TP_LONG_VALUE  = TEMP_EN_LONG_VALUE; 
        TEMP_TP_SHORT_VALUE   = TEMP_EN_SHORT_VALUE;
}

void Set_TP_OrdersLevel_Current_En_Current()
{
    if(PositionSelect(_Symbol))
    {
        TEMP_TP_LONG_VALUE  = PositionGetDouble(POSITION_PRICE_CURRENT);
        TEMP_TP_SHORT_VALUE  = PositionGetDouble(POSITION_PRICE_CURRENT);
    }
    else
    {
        Set_TP_OrdersLevel_EN_Final();        
    }    


}

void Set_TP_OrdersLevel_Current_En_Price_Open()
{
    
    if(PositionSelect(_Symbol))
    //if(PositionGetDouble(POSITION_VOLUME) != 0)
    {    
        TEMP_TP_LONG_VALUE  = PositionGetDouble(POSITION_PRICE_OPEN);
        TEMP_TP_SHORT_VALUE  = PositionGetDouble(POSITION_PRICE_OPEN);
    }
    else
    {
        Set_TP_OrdersLevel_EN_Final();        
    }    

}


void Set_TP_OrdersLevel_BarHighLow()
{
    //double barLevel = PriceInfo[1].high - ((PriceInfo[1].high - PriceInfo[1].low) * X_SIZE);
    TEMP_TP_LONG_VALUE  = PriceInfo[1].high;
    TEMP_TP_SHORT_VALUE  = PriceInfo[1].low;
}



void Set_TP_OrdersLevel_BarLevel()
{
    //double barLevel = PriceInfo[1].high - ((PriceInfo[1].high - PriceInfo[1].low) * X_SIZE);
    //TEMP_TP_LONG_VALUE  = barLevel;
    //TEMP_TP_SHORT_VALUE  = barLevel;
}


void Set_TP_OrdersLevel_MovingAvarage()
{
    //TEMP_TP_LONG_VALUE = MovingAvarageArray[0];
    //TEMP_TP_SHORT_VALUE = MovingAvarageArray[0];       
}

void Set_TP_OrdersLevel_BollingerBands()
{
   // TEMP_TP_LONG_VALUE = LowerBandArray[0];
   // TEMP_TP_SHORT_VALUE = UpperBandArray[0];    
}

void Set_TP_OrdersLevel_PriceClose()
{
    //TEMP_TP_LONG_VALUE = PriceInfo[1].close;
    //TEMP_TP_SHORT_VALUE = PriceInfo[1].close;    
}
//_______________________________________//__________________________________
//---
enum enum_SL_Order_Level
{
    eOrLevel_SL_System                = 0,
    eOrLevel_SL_Default                      = 1,
    eOrLevel_SL_BidAsk                      = 2,
    eOrLevel_SL_Last_Deal                   = 3,
    eOrLevel_SL_X_BarLevel                  = 4,
    eOrLevel_SL_Current_EN_Mid              = 5,
    eOrLevel_SL_Last_EN_Chosen_Ref         = 6,
    eOrLevel_SL_Last_EN_Defined_Level      = 7
    //preço médio eOrLevel_TPSL_Current_EN_Level            = 5,
    //preço de entrada eOrLevel_TPSL_Current_EN_Level            = 5,
    //calcular tp e sl pelo lucro calculado eOrLevel_TPSL_Current_EN_Level            = 5,
    //calcular tp e sl por pontos por volume calculado eOrLevel_TPSL_Current_EN_Level            = 5,
    // media móvel
    // bollinger
    // high low
    // pivo
};


void Chosen_SL_OrdersLevel_Settigns(int chosen)
{
    switch(chosen)
    {
        case eOrLevel_SL_System:

            break;            
        case eOrLevel_SL_Default:
            Set_SL_OrdersLevel_EN_Final();
            break;
        case eOrLevel_SL_BidAsk:

            break;           
        case eOrLevel_SL_Last_Deal:
            
            break;
        case eOrLevel_SL_X_BarLevel:
            
            break;
        case eOrLevel_SL_Current_EN_Mid:

            break;                                
        case eOrLevel_SL_Last_EN_Chosen_Ref:
            Set_SL_OrdersLevel_EN_Final();
            break;                                
        default:
            Set_SL_OrdersLevel_EN_Final();
            break;            
    }  
}

void Set_SL_OrdersLevel_EN_Final()
{
   
   
   TEMP_SL_LONG_VALUE    = TEMP_EN_LONG_VALUE;
   TEMP_SL_SHORT_VALUE   = TEMP_EN_SHORT_VALUE;



}


void Set_SL_OrdersLevel_BarHighLow()
{
   // double barLevel = PriceInfo[1].high - ((PriceInfo[1].high - PriceInfo[1].low) * X_SIZE);
    TEMP_SL_LONG_VALUE  = PriceInfo[1].low;
    TEMP_SL_SHORT_VALUE  = PriceInfo[1].high;
}

void Set_SL_OrdersLevel_BarLevel()
{
    //TEMP_SL_LONG_VALUE  = barLevel;
    //TEMP_SL_SHORT_VALUE  = barLevel;
}


void Set_SL_OrdersLevel_MovingAvarage()
{
    //TEMP_SL_LONG_VALUE = MovingAvarageArray[0];
    //TEMP_SL_SHORT_VALUE = MovingAvarageArray[0];       
}

void Set_SL_OrdersLevel_BollingerBands()
{
    //TEMP_SL_LONG_VALUE = LowerBandArray[0];
    //TEMP_SL_SHORT_VALUE = UpperBandArray[0];    
}

void Set_SL_OrdersLevel_PriceClose()
{
    //TEMP_SL_LONG_VALUE = PriceInfo[1].close;
    //TEMP_SL_SHORT_VALUE = PriceInfo[1].close;    
}


