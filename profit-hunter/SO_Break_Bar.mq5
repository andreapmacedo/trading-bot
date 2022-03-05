


int SO_Break_Bar(int callFrom)
{

    // Atribuições de todas as chamadas

    // Atribuições específicas 
    switch(callFrom) 
    {
        // case 0:
        //     // EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;
        //     // EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
        //     return 0;
        //     break; 
        case 1:
            break; 
        case 2:
            return 0;
            break;                                          
        case 3:
            return 0;
            break; 
    }

    // os parâmetros atualizados
    TopChange = 0;
    BottomChange = 0;
    
    CurrentLevelBuy = PriceInfo[1].high;
    CurrentLevelSell = PriceInfo[1].low;

    TopChange +=  EN_Distance_Long;
    BottomChange += EN_Distance_Short;

    currentSellVolume = SELECTED_VOLUME_SHORT;
    currentBuyVolume = SELECTED_VOLUME_LONG;


    // pegar a ancoragem 
    // determinar a distância da ancoragem
    // determinar o volume
    // determinar a execução da ordem

    CurrentLevelSell -=  BottomChange;
    CurrentLevelBuy += TopChange;

    

    if(SL_Distance_Long > 0)
    {
        Level_sl_long = PriceInfo[1].high - SL_Distance_Long; 
    }
    else
    {
        Level_sl_long = NULL;
    }
    if(Level_sl_short > 0)
    {
        Level_sl_short = PriceInfo[1].low + SL_Distance_Short;
    }
    else
    {
        Level_sl_short = NULL;
    }
    if(Level_tp_long > 0)
    {
        Level_tp_long = PriceInfo[1].high + TP_Distance_Long;
    }
    else
    {
        Level_tp_long = NULL;
    }
    if(Level_tp_short > 0)
    {
        Level_tp_short = PriceInfo[1].low - TP_Distance_Short; 
    }
    else
    {
        Level_tp_short = NULL;
    }







    // tp anchor
    // sl anchor
    // neste caso usarei topo/fundo da vela anterior
    // poderia tb utilizar o valor do level e somar o valor da barra caso quisesse utilizala como ref.
    // pode ser utilizado tb o valor médio como ref.


    // CurrentLevelSell +=  TopChange;
    // CurrentLevelBuy -= BottomChange;

    if(SELECTED_EN_MODE == 1)
    {
        EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;
        EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
        // remover as ordens antes de chamar o exec.
        Set_Order_Limit(callFrom);
        //Set_Order_Limit();
        return 2;
    }

    if(SELECTED_EN_MODE == 2)
    {
        Set_Trigger_Order_Dev();
    }
    
    return 0;








}
