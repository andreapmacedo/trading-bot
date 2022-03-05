//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+


#include "Tech_Trading_Status_01.mq5"
#include "Tech_Trading_Status_02.mq5"
#include "Tech_Trading_Status_03.mq5"
#include "Tech_Trading_Status_04.mq5"
#include "Tech_Trading_Status_05.mq5"




enum enum_Trading_Status
{
    eTrading_001                = 1,
    eTrading_002                = 2   
};




int Trading_Status(int chosen)
{
    switch(chosen)
    {
        case eTrading_001:
            return EST_Trading_001();
            break;            
    }
    return 0;    
}


int LAST_TRADING_STATUS = 0;
bool TRADING_STATUS_CHANGED = false;


int EST_Trading_001()
{
    int result = 0;
    if(pos_volume > 0)
    {
        if(// subindo e comprado
            CurrentTrend == 1
            && pos_status == 0 
            )
        {
            result = 1;// CurrentTradingStatus = 1;
        }
        else if(// subindo e vendido
            CurrentTrend ==  1
            && pos_status == 1 
            )
        {
            result = 2; //CurrentTradingStatus = 2;
        }
        else if(// caindo e comprado
            CurrentTrend == -1 
            && pos_status == 0
            )
        {
            result = 3; //CurrentTradingStatus = 3;

        }
        else if(// caindo e vendido
            CurrentTrend == -1 
            && pos_status == 1
            ) 
        {
            result = 4; //CurrentTradingStatus = 4;
        }
        else if(// neutro e comprado
            CurrentTrend == 0 
            && pos_status == 0
            ) 
        {
            result = 7; //CurrentTradingStatus = 7;
        }
        else if(// neutro e vendido
            CurrentTrend == 0 
            && pos_status == 1
            ) 
        {
            result = 8; //CurrentTradingStatus = 8;
        }
    }
    else if(CurrentTrend == 1) // zerado e subindo
    {
        result = 5; //return 5;
    }
    else if(CurrentTrend == -1) // zerado e caindo
    {
        result = 6;//return 6;
    }
    else // zerado e neutro
    {
        result = 9;// 
    }

    LAST_TRADING_STATUS = CurrentTradingStatus;
    CurrentTradingStatus = result;


    if(LAST_TRADING_STATUS != CurrentTradingStatus)
    {
        // Print("CurrentTradingStatus: ", CurrentTradingStatus);
        // Print("LAST_TRADING_STATUS: ", LAST_TRADING_STATUS);
        TRADING_STATUS_CHANGED = true;
    }
    else
    {
        TRADING_STATUS_CHANGED = false;
    }


    // Print("result: ", result);
    // Print("pos_status: ", pos_status);

    Basic_Status_System();
    return result;
}

int LAST_STATUS_SYSTEM = 0;
int CurrentStatusSystem = 0;
bool STATUS_SYSTEM_CHANGED = false;

//int Basic_Trend_System() // criar lá no trend
int Basic_Status_System()
{
    int result;
    switch(CurrentTradingStatus)
    {
        case 1:
            result = 1; // a favor da tendência
            break;
        case 4:
            result = 1;
            break;
        case 2:
            result = 2; // contra a tendência
            break;
        case 3:
            result = 2;
            break;
        case 7:
            result = 3; // contra a tendência na zona de transição
            break;
        case 8:
            result = 3;
            break;
        case 5:
            result = 4; // não posicionado e tendência
            break;
        case 6:
            result = 4;
            break;
        default:
            result = 5; // não posicionado e zona de transição
            break;
    }


    LAST_STATUS_SYSTEM = CurrentStatusSystem;
    CurrentStatusSystem = result;


    if(LAST_STATUS_SYSTEM != CurrentStatusSystem)
    {
        // Print("CurrentTradingStatus: ", CurrentTradingStatus);
        // Print("LAST_TRADING_STATUS: ", LAST_TRADING_STATUS);
        STATUS_SYSTEM_CHANGED = true;
    }
    else
    {
        STATUS_SYSTEM_CHANGED = false;
    }

    return result;
}
/*
void SetSisSettings_01()
{
    switch(TRADE_STATUS_SYSTEM_01_CHOSEN)
    {
        case 1:
            SisSettings_01_ch0001();
            break;
        default:
            break;
    }

}
void SetSisSettings_02()
{
    switch(TRADE_STATUS_SYSTEM_02_CHOSEN)
    {
        case 1:
            SisSettings_02_ch0001();
            break;
        default:
            break;
    }

}
void SetSisSettings_03()
{
    switch(TRADE_STATUS_SYSTEM_03_CHOSEN)
    {
        case 1:
            SisSettings_03_ch0001();
            break;
        default:
            break;
    }

}
void SetSisSettings_04()
{
    switch(TRADE_STATUS_SYSTEM_04_CHOSEN)
    {
        case 1:
            SisSettings_04_ch0001();
            break;
        default:
            break;
    }

}
void SetSisSettings_05()
{
    switch(TRADE_STATUS_SYSTEM_05_CHOSEN)
    {
        case 1:
            SisSettings_05_ch0001();
            break;
        default:
            break;
    }

}



void SisSettings_01_ch0001()
{
    //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
    // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
    // if(temp_vol == 1)
    // {
    //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(pos_status == 0) // comprado
    {
        //TopChange += 200;
        //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
        // if(spd > SELECTED_EN_DISTANCE_LONG)
        // {
        //     Level_Buy = SERVER_SYMBOL_BID;
        // }
        //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        BuyVolChange += SELECTED_VOLUME_LONG ;
    }
    else // vendido
    {
        //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        SellVolChange += SELECTED_VOLUME_SHORT ;
        //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
            //Level_Sell = SERVER_SYMBOL_ASK;
        // if(spd > SELECTED_EN_DISTANCE_SHORT)
        // {
        // }                
        //BottomChange += 200;
    }

    // }
    // else if(temp_vol > 2 && temp_vol < 4)
    // {
    //     if(pos_status == 0) // comprado
    //     {

    //     }
    //     else // vendido
    //     {
    //     }

    // }
    if(temp_vol > 3)
    {
        if(pos_status == 0) // comprado
        {
            currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        }
        else // vendido
        {
            
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        }
    }        
}
void SisSettings_02_ch0001()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(pos_status == 0) // comprado
    {
        SetTopMagneticMovie(); // (est 2x)
        //if(Current_Buy_Seq > 1)
            currentSellVolume = SELECTED_VOLUME_SHORT * 3;
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        
        // stop
        // if(temp_vol > 2)
        // {
        //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
        //     {
        //         //Level_Sell = Freeze_Central_Bottom; 
                
        //         Level_Sell = SERVER_SYMBOL_ASK; 
        //         currentSellVolume = SELECTED_VOLUME_SHORT ;
        //     }
        // }

    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    }

    if(pos_status == 1) // vendido
    {
        //Level_Buy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //  if(Current_Sell_Seq > 1)
        SetBottomMagneticMovie(); // (est 2x)
        currentBuyVolume = SELECTED_VOLUME_LONG * 3;

        // stop
        // if(temp_vol > 2)
        // {
        //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
        //     {
                
        //         //Level_Buy = Freeze_Central_Top;  
                
        //         Level_Buy = SERVER_SYMBOL_BID; 
        //         currentBuyVolume = SELECTED_VOLUME_LONG ;
        //     }
        // }

        //BuyVolChange  += SELECTED_VOLUME_LONG;
        //currentBuyVolume  = temp_vol; // exemplo de possibilidade
        //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    }
}
void SisSettings_03_ch0001()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(pos_status == 0) // comprado
    {
        // if(Current_Buy_Seq > 0)
            currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        //Level_Sell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
        
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        //BottomChange = 0;

    }
    else // vendido
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    }
    if(pos_status == 1) // vendido
    {
        //  if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        
        //Level_Buy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //BuyVolChange  += SELECTED_VOLUME_LONG;
        // TopChange += 50;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    }
}
void SisSettings_04_ch0001()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
}
void SisSettings_05_ch0001()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);    
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
}
*/