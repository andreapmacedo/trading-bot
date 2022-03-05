//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+


bool SIGNAL_MA_REVERSE = true;

//void Set_TriggerSignal(int chosen)
void Set_TriggerSignal()
{

    if(SIGNAL_MA_REVERSE)
    {
        TriggerSignal_01();
        TriggerSignal_02();
    }

}



void TriggerSignal_01()
{
    if(CurrentTradingStatus == 2)// subindo e vendido
    {
        if(top_ma_spread > 10)
        {
            Set_Trigger_SPD_001();
            //SELL_TREND_OK = false;

        }
    }
    if(CurrentTradingStatus == 3) // caindo e comprado
    {
        if(top_ma_spread < 10)
        {
            Set_Trigger_SPD_001();
            //BUY_TREND_OK = false;
        }
    }


}

void TriggerSignal_02()
{
    if(CurrentTradingStatus == 5) // zerado e subindo
    {
        //CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
        SELL_TREND_OK = false;
    }
    else if(CurrentTradingStatus == 6) // zerado e caindo
    {
        //CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
        BUY_TREND_OK = false;
    }
}