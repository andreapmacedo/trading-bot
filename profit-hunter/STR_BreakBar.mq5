
int ORD_Strategy_200()
{
    BREAK_MODE = true;
    CurrentLevelBuy = PriceInfo[1].high;
    CurrentLevelSell = PriceInfo[1].low;
    TopChange -=  50;
    BottomChange -= 50;
    
    CurrentLevelSell += TopChange;
    CurrentLevelBuy -= BottomChange;   



    if(PriceInfo[1].low < PriceInfo[2].low)
    {
        CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
        BUY_TREND_OK = false;
        Print("PriceInfo[1].low < PriceInfo[2].low");
    }
    else if(PriceInfo[1].high > PriceInfo[2].high)
    {
        CancelSellOrders(_Symbol, "CheckBuyManagemente_Evo"); 
        SELL_TREND_OK = false;
        Print("PriceInfo[1].high > PriceInfo[2].high");
    }
    
    return 1;

}


int ORD_Strategy_201()
{
    BREAK_MODE = true;
    EN_STR_Anchor_201();
    EN_STR_Distance_2();

    CurrentLevelSell += TopChange;
    CurrentLevelBuy -= BottomChange;   


    //CurrentLevelBuy = PriceInfo[1].high;
    //CurrentLevelSell = PriceInfo[1].low;
    
    // TopChange -=  50;
    // BottomChange -= 50;
    
    if(PriceInfo[1].low < PriceInfo[2].low)
    {
        CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo"); 
        BUY_TREND_OK = false;
        Print("PriceInfo[1].low < PriceInfo[2].low");
    }
    else if(PriceInfo[1].high > PriceInfo[2].high)
    {
        CancelSellOrders(_Symbol, "CheckBuyManagemente_Evo"); 
        SELL_TREND_OK = false;
        Print("PriceInfo[1].high > PriceInfo[2].high");
    }
    
    return 1;

}