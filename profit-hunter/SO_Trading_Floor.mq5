  
void SO_Trading_Floor_Reset_Vars()
{
    SELL_TREND_OK = true;
    BUY_TREND_OK = true;
    BREAK_MODE = false;
    //-- os parâmetros mutáveis
    TopChange = 0; // Pode ser dispensável seu uso e manipular diretamente a variável CurrentLevelBuy/CurrentLevelSell como acontece com o TP/SL mas esta opção permite acompanhar no painel a variação da mudança 
    BottomChange = 0;

    //-- Parâmetros Naturais do SO
    CurrentLevelBuy = PriceInfo[1].low;
    CurrentLevelSell = PriceInfo[1].high;
    // TopChange +=  EN_Distance_Short;
    // BottomChange += EN_Distance_Long;

    currentSellVolume = SELECTED_VOLUME_SHORT;
    currentBuyVolume = SELECTED_VOLUME_LONG;


    SELECTED_TP_ON = TP_ON;
    SELECTED_SL_ON = SL_ON;

}



  int SO_Trading_Floor(int callFrom)
{

    if(callFrom == 1)
    {
        SO_FOLLOW_LOCK = 0;        
    } 

    if(SO_FOLLOW_LOCK == 0)
    {
        SO_FOLLOW_LOCK = 1;    
        SO_Trading_Floor_Reset_Vars();
    


        int masterEstInterResponse = 0;
        if(SELECTED_TRADE_STRATEGY_CHOSEN > 0)
        {
            masterEstInterResponse = SetOrderStrategy(SELECTED_TRADE_STRATEGY_CHOSEN);
        }
        

        if(masterEstInterResponse == 0) // ou o master strategy está inoperante ou a estratégia não implicou a mudança de level ou volume
        {
            
            
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
            //Print("masterEstInterResponse == 0");


            // TP
            //_____________________________
    
            if(SELECTED_TP_ON)
            {
                Level_tp_long = CurrentLevelBuy;// PriceInfo[1].low // será atribuído pelo anchor
                Level_tp_short = CurrentLevelSell;
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
            if(SELECTED_SL_ON)
            {
                Level_sl_long = CurrentLevelBuy;// PriceInfo[1].low // será atribuído pelo anchor
                Level_sl_short = CurrentLevelSell;
                SL_OrderAnchor_Settings(INPUT_SL_EST_ANCHOR_CHOSEN);
                SL_OrderDistance_Settings(INPUT_SL_EST_DISTANCE_CHOSEN);
            }
            else
            {
                Level_sl_long = NULL; 
                Level_sl_short = NULL;
            }


            }
            else if(masterEstInterResponse == 2)
            {
                return -1;
            }



        currentBuyVolume += BuyVolChange;
        currentSellVolume += SellVolChange;
        
        // Execução
        //_____________________________
        if(SELECTED_EN_MODE == 1)
        {
            Set_Order_Limit(callFrom);
            return 2;
        }

        // if(SELECTED_EN_MODE == 2)
        // {
        //     Set_Trigger_Order_Dev();
        // }
        
        return 0;
    }
    return 0;
}



  int SO_Trading_Floor_original(int callFrom)
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



    // EN
    //_____________________________
    
    //-- os parâmetros mutáveis
    TopChange = 0; // Pode ser dispensável seu uso e manipular diretamente a variável CurrentLevelBuy/CurrentLevelSell como acontece com o TP/SL mas esta opção permite acompanhar no painel a variação da mudança 
    BottomChange = 0;

    //-- Parâmetros Naturais do SO
    CurrentLevelBuy = PriceInfo[1].low;
    CurrentLevelSell = PriceInfo[1].high;
    TopChange +=  EN_Distance_Short;
    BottomChange += EN_Distance_Long;
   
    // criar uma estratégia central que fará a configuração de tudo que eu preciso
    // a estratégia central não é capaz de absorver mudança de atributo do usuário por isso aina será necessário a criação de so que mistura atributos imutaveis com a possibilidade de aplicação de aplicação de atributo do usuário

    //if(INPUT_EN_EST_DISTANCE_CHOSEN == 1)// exemplo (elencar as estratégias possíveis para este SO)
    EN_OrderAnchor_Settings(INPUT_EN_EST_ANCHOR_CHOSEN); 
    EN_OrderDistance_Settings(INPUT_EN_EST_DISTANCE_CHOSEN); 
  
    CurrentLevelSell += TopChange;
    CurrentLevelBuy -= BottomChange;
    
    // TP
    //_____________________________
   
    if(SELECTED_TP_ON)
    {
        Level_tp_long = CurrentLevelBuy;// PriceInfo[1].low // será atribuído pelo anchor
        Level_tp_short = CurrentLevelSell;
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
    if(SELECTED_SL_ON)
    {
        Level_sl_long = CurrentLevelBuy;// PriceInfo[1].low // será atribuído pelo anchor
        Level_sl_short = CurrentLevelSell;
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
    


    // Execução
    //_____________________________
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





