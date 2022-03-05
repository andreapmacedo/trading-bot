//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+




void Set_Reverse(int chosen)
{
    switch(chosen)
    {
        case 1:
            EST_Reverse_01();
            break;            
        case 2:
            EST_Reverse_02();
            break;            
    }  
}



void EST_Reverse_01()
{
// trabalhar com volume e distância

    
    Level_Sell = Lowest_Top;
    Level_Buy = Highest_Bottom;

    currentSellVolume = SELECTED_VOLUME_SHORT ;
    currentBuyVolume = SELECTED_VOLUME_LONG ;
    if(pos_status == 0)
    {
        currentSellVolume += pos_volume + SELECTED_VOLUME_SHORT;
        //Level_Sell = SERVER_SYMBOL_BID;
        Level_Sell = SERVER_SYMBOL_ASK;
    }
    if(pos_status == 1)
    {
        currentBuyVolume += pos_volume + SELECTED_VOLUME_LONG;
        Level_Buy = SERVER_SYMBOL_BID;
        //Level_Buy = SERVER_SYMBOL_ASK;
    }

}
void EST_Reverse_02()
{
// trabalhar com volume e distância

    
    Level_Sell = Lowest_Top;
    Level_Buy = Highest_Bottom;

    currentSellVolume = SELECTED_VOLUME_SHORT ;
    currentBuyVolume = SELECTED_VOLUME_LONG ;
    if(pos_status == 0)
    {
        currentSellVolume += SELECTED_VOLUME_SHORT;
        //Level_Sell = SERVER_SYMBOL_BID;
        Level_Sell = SERVER_SYMBOL_ASK;
    }
    if(pos_status == 1)
    {
        currentBuyVolume +=  SELECTED_VOLUME_LONG;
        Level_Buy = SERVER_SYMBOL_BID;
        //Level_Buy = SERVER_SYMBOL_ASK;
    }

}
