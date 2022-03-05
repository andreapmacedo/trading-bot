
#include "Orders_TP_Anchor.mq5"
#include "Orders_SL_Anchor.mq5"


void EN_OrderAnchor_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 101:
            EN_STR_Anchor_101();
            break;
        case 201:
            EN_STR_Anchor_201();
            break;

    }
}

void EN_STR_Anchor_101()
{
    Level_Buy = PriceInfo[1].low;
    Level_Sell = PriceInfo[1].high;
}
void EN_STR_Anchor_201()
{
    Level_Buy = PriceInfo[1].high;
    Level_Sell = PriceInfo[1].low;
}