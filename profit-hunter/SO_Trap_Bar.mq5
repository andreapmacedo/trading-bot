


int SO_Trap_Bar(int callFrom)
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

    //-- os parâmetros mutáveis
    TopChange = 0; // Pode ser dispensável seu uso e manipular diretamente a variável Level_Buy/Level_Sell como acontece com o TP/SL mas esta opção permite acompanhar no painel a variação da mudança 
    BottomChange = 0;

    //-- Parâmetros Naturais do SO
    Level_Buy = PriceInfo[1].low;
    Level_Sell = PriceInfo[1].high;
   
   
   // EN_OrderAnchor_Settings(0); // Imutável para esta estratégia

    if(INPUT_EN_EST_DISTANCE_CHOSEN == 1)// exemplo (elencar as estratégias possíveis para este SO)
        EN_OrderDistance_Settings(INPUT_EN_EST_DISTANCE_CHOSEN); // Imutável para esta estratégia

    TopChange +=  EN_Distance_Short;
    BottomChange += EN_Distance_Long;
  
    Level_Sell += TopChange;
    Level_Buy -= BottomChange;
    
    
    
    // TP
    //_____________________________
   
    if(TP_ON)
    {
        Level_tp_long = Level_Buy;// PriceInfo[1].low // será atribuído pelo anchor
        Level_tp_short = Level_Sell;
        TP_OrderAnchor_Settings(INPUT_TP_EST_ANCHOR_CHOSEN);
        TP_OrderDistance_Settings(INPUT_TP_EST_DISTANCE_CHOSEN);
    }
    else
    {
        Level_tp_long = NULL; 
        Level_tp_short = NULL;
    }
    
    // SL
    //_____________________________
    if(SL_ON)
    {
        Level_sl_long = Level_Buy;// PriceInfo[1].low // será atribuído pelo anchor
        Level_sl_short = Level_Sell;
        SL_OrderAnchor_Settings(INPUT_SL_EST_ANCHOR_CHOSEN);
        SL_OrderDistance_Settings(INPUT_SL_EST_DISTANCE_CHOSEN);
    }
    else
    {
        Level_sl_long = NULL; 
        Level_sl_short = NULL;
    }
    
    // Volume
    //_____________________________
    currentSellVolume = SELECTED_VOLUME_SHORT;
    currentBuyVolume = SELECTED_VOLUME_LONG;
    Set_OrderVolume(0);
    


    if(SELECTED_EN_MODE == 1)
    {
        //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;
        //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
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
