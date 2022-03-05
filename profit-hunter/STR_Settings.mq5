

#include "STR_TrapBar.mq5"
#include "STR_BreakBar.mq5"

int SetOrderStrategy(int chosen)
{

    switch(chosen)
    {
        case 0:
            return 0;
            break;
        case 1:
            return ORD_Strategy_001();
            break;
        case 2:
            return ORD_Strategy_002();
            break;
        case 3:
            return ORD_Strategy_003();
            break;
        case 4:
            return ORD_Strategy_004();
            break;
        case 5:
            return ORD_Strategy_005();
            break;
        case 6:
            return ORD_Strategy_006();
            break;
        case 7:
            return ORD_Strategy_007();
            break;
        case 8:
            return ORD_Strategy_008();
            break;
        case 9:
            return ORD_Strategy_009();
            break;
        case 10:
            return ORD_Strategy_010();
            break;
        case 11:
            return ORD_Strategy_011();
            break;
        case 12:
            return ORD_Strategy_012();
            break;
        case 13:
            return ORD_Strategy_013();
            break;
        case 14:
            return ORD_Strategy_014();
            break;
        case 15:
            return ORD_Strategy_015();
            break;
        case 16:
            return ORD_Strategy_016();
            break;
        case 17:
            return ORD_Strategy_017();
            break;
        case 18:
            return ORD_Strategy_018();
            break;
        case 27:
            return ORD_Strategy_027();
            break;
        case 100:
            return ORD_Strategy_100();
            break;
        case 101:
            return ORD_Strategy_101();
            break;
        case 200:
            return ORD_Strategy_200();
        case 201:
            return ORD_Strategy_201();
            break;
    }
    return (0);
}


// 1 - subindo e comprado 
// 2 - subindo e vendido (revert)
// 3 - caindo e comprado (revert)
// 4 - caindo e vendido

//input double      EN_Distance_Long     = 25; // Valor - Distância - ENTRADA LONG
//input double      EN_Distance_Short    = 25; // Valor - Distância - ENTRADA SHORT

int ORD_Strategy_001()
{
    if(CurrentStatusSystem == 1) // a favor da tendência
    {        
        SetSisSettings_01();
    }
    else if(CurrentStatusSystem == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    
    else if(CurrentStatusSystem == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(CurrentStatusSystem == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(CurrentStatusSystem == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;

}
int ORD_Strategy_002()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    //        EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        // if(temp_vol <= 2 && pos_status == 1)
        // {
        //     CurrentLevelBuy = SERVER_SYMBOL_BID;
        //     currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        //     currentSellVolume  = SELECTED_VOLUME_SHORT ;
        // }
        // if(pos_status == -1)
        // {
        // }
            
            if(TREND_CHANGED)
            {
                CurrentLevelBuy = SERVER_SYMBOL_BID;
            }
            else
            {
               EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            }
            
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
            currentSellVolume  = SELECTED_VOLUME_SHORT ;

            


    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {


            if(TREND_CHANGED)
            {
                CurrentLevelSell = SERVER_SYMBOL_ASK;
            }
            else
            {

                EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            }
            
            currentBuyVolume  = SELECTED_VOLUME_LONG ;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;


        // if(temp_vol <= 2 && pos_status == -1)
        // {        
        // }
        // if( pos_status == 1)
        // {        
        //     CurrentLevelSell = SERVER_SYMBOL_ASK;
        //     currentBuyVolume  = SELECTED_VOLUME_LONG ;
        //     currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        // }
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        //EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;



        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    return 1;
}

int ORD_Strategy_003()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
    switch(CurrentStatusSystem)
    {
        case 1: // a favor da tendência
            SetSisSettings_01();
            break;
        case 2: // contra a tendência
            SetSisSettings_02();
            break;
        case 3: // contra a tendência na zona de transição
            SetSisSettings_03();
            break;
        case 4: // não posicionado na zona de transição 
            SetSisSettings_04();
            break;
        case 5: // não posicionado e sem tendência
            SetSisSettings_05();
            break;
        default:
            break;
    }
    return 1;
}
int ORD_Strategy_004()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    //        EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        if(TREND_SIDE_CHANGED)
        {
            //CurrentLevelBuy = SERVER_SYMBOL_BID;
            CurrentLevelBuy = SERVER_SYMBOL_ASK;
            currentBuyVolume  = (SELECTED_VOLUME_LONG * temp_vol);
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            currentBuyVolume  = (SELECTED_VOLUME_LONG * 1);
        }
        
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
        if(TREND_SIDE_CHANGED)
        {
            //CurrentLevelSell = SERVER_SYMBOL_ASK;
            CurrentLevelSell = SERVER_SYMBOL_BID;
            currentSellVolume  = (SELECTED_VOLUME_SHORT * temp_vol);
        }
        else
        {

            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
            currentSellVolume  = (SELECTED_VOLUME_SHORT * 1);
        }
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        //EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;



        if(temp_vol > 0 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
       // CancelSellOrders(_Symbol, "trend down"); 
       // SELL_TREND_OK = false;
       // CurrentLevelBuy = SERVER_SYMBOL_BID;
        TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       // BUY_TREND_OK = false;
       // CurrentLevelSell = SERVER_SYMBOL_ASK;
       BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    return 1;
}
int ORD_Strategy_005()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);



    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    //        EstENOrerDst_10();
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        if(temp_vol == 1)
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT *2;
        }
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        //TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
        CurrentLevelBuy = SERVER_SYMBOL_ASK;
        currentBuyVolume  = (SELECTED_VOLUME_LONG * temp_vol);
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
        SELL_TREND_OK = false;
        // if(TREND_SIDE_CHANGED)
        // {
        //     //CurrentLevelBuy = SERVER_SYMBOL_BID;
        // }
        // else
        // {
        //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //     currentBuyVolume  = (SELECTED_VOLUME_LONG * 1);
        // }
        
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
 //            CurrentLevelBuy = SERVER_SYMBOL_ASK;
        //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
        CurrentLevelSell = SERVER_SYMBOL_BID;
        currentSellVolume  = (SELECTED_VOLUME_SHORT * temp_vol);
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        BUY_TREND_OK = false;

        // if(TREND_SIDE_CHANGED)
        // {
        //     //CurrentLevelSell = SERVER_SYMBOL_ASK;
        // }
        // else
        // {

        //     //EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //    // currentSellVolume  = (SELECTED_VOLUME_SHORT * 1);
        // }
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        //EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol == 1)
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 2;
        }


        if(temp_vol > 0 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
       
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
       // CancelSellOrders(_Symbol, "trend down"); 
        SELL_TREND_OK = false;
       // CurrentLevelBuy = SERVER_SYMBOL_BID;
        //TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       
        BUY_TREND_OK = false;
       // CurrentLevelSell = SERVER_SYMBOL_ASK;
       currentBuyVolume  = SELECTED_VOLUME_LONG;
       //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 7 // neutro e comprado
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    else if(
            CurrentTradingStatus == 8 // zerado e caindo
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    else if(
            CurrentTradingStatus == 9 // zerado e neutro
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_006()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    //        EstENOrerDst_10();
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        if(temp_vol == 1)
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT *2;
        }
        
        if(temp_vol > 0 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
       // TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
        CurrentLevelBuy = SERVER_SYMBOL_ASK;
        currentBuyVolume  = (SELECTED_VOLUME_LONG * temp_vol);
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
        //SELL_TREND_OK = false;
        // if(TREND_SIDE_CHANGED)
        // {
        //     //CurrentLevelBuy = SERVER_SYMBOL_BID;
        // }
        // else
        // {
        //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //     currentBuyVolume  = (SELECTED_VOLUME_LONG * 1);
        // }
        
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
 //            CurrentLevelBuy = SERVER_SYMBOL_ASK;
       // BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
        CurrentLevelSell = SERVER_SYMBOL_BID;
        currentSellVolume  = (SELECTED_VOLUME_SHORT * temp_vol);
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        //BUY_TREND_OK = false;

        // if(TREND_SIDE_CHANGED)
        // {
        //     //CurrentLevelSell = SERVER_SYMBOL_ASK;
        // }
        // else
        // {

        //     //EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //    // currentSellVolume  = (SELECTED_VOLUME_SHORT * 1);
        // }
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        //EstENOrerDst_10();
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        // min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol == 1)
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 2;
        }


        if(temp_vol > 0 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
       
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
       // CancelSellOrders(_Symbol, "trend down"); 
        //SELL_TREND_OK = false;
        //CurrentLevelBuy = SERVER_SYMBOL_BID;
        CurrentLevelBuy = SERVER_SYMBOL_ASK;
       // TopChange = SELECTED_EN_DISTANCE_SHORT * 4;
       
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       // CancelBuyOrders(_Symbol, "trend up"); 
       
       // BUY_TREND_OK = false;
       //CurrentLevelSell = SERVER_SYMBOL_ASK;
       CurrentLevelSell = SERVER_SYMBOL_BID;
       currentBuyVolume  = SELECTED_VOLUME_LONG;
       //BottomChange = SELECTED_EN_DISTANCE_LONG * 4;
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 7 // neutro e comprado
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    else if(
            CurrentTradingStatus == 8 // zerado e caindo
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    else if(
            CurrentTradingStatus == 9 // zerado e neutro
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_007()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            CurrentLevelBuy = SERVER_SYMBOL_BID;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            CurrentLevelSell = SERVER_SYMBOL_ASK;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_008()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        
        if(TREND_SIDE_CHANGED)
        {
            CurrentLevelBuy = SERVER_SYMBOL_BID;
            //ResetAxlesLevels();
            //CountFreezeCentralLevel == 0;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
        //if(TREND_CHANGED)
        if(TREND_SIDE_CHANGED)
        {
            CurrentLevelSell = SERVER_SYMBOL_ASK;
            //ResetAxlesLevels();
            //CountFreezeCentralLevel == 0;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        }
        
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_009()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)

	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
    
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        
        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        CurrentLevelBuy = SERVER_SYMBOL_BID;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        BottomChange = 0;
        
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {

        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        CurrentLevelSell = SERVER_SYMBOL_ASK;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        TopChange = 0;
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
        min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_010()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        
        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        CurrentLevelBuy = SERVER_SYMBOL_BID;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //BottomChange = 0;
        
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {

        // if(TREND_SIDE_CHANGED)
        // {
        //     //ResetAxlesLevels();
        //     //CountFreezeCentralLevel == 0;
        // }
        // else
        // {
        // }
        CurrentLevelSell = SERVER_SYMBOL_ASK;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //TopChange = 0;
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
       currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}

int ORD_Strategy_011()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
      
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        
        

        if(pos_status == 0) // comprado
        {
                //Central_Top = SERVER_SYMBOL_LAST;
            
            //SetTopMagneticMovie();

            if(Current_Buy_Seq > 0)
            {
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;

            }
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {

            //SetBottomMagneticMovie();
            if(Current_Sell_Seq > 0)
            {
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            }

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_021()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
      
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        
        
        if(pos_status == 0) // comprado
        {
                //Central_Top = SERVER_SYMBOL_LAST;
            
            SetTopMagneticMovie(); // (est 2x)

            if(Current_Buy_Seq > 0)
            {
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;

            }
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {

            SetBottomMagneticMovie(); // (est 2x)
            if(Current_Sell_Seq > 0)
            {
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            }

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}


int ORD_Strategy_012()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
           // if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
           // if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_022()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
           // if(Current_Buy_Seq > 0)
            SetTopMagneticMovie(); // (est 21)
            currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
           // if(Current_Sell_Seq > 0)
            SetBottomMagneticMovie(); // (est 21)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_013()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_023()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            SetBottomMagneticMovie(); // (est 2x)
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_014()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_024()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
            //         currentSellVolume = SELECTED_VOLUME_SHORT ;
            //     }
            // }

        }
        else // vendido
        {
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);

            SetBottomMagneticMovie(); // (est 2x)
            if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
            //         currentBuyVolume = SELECTED_VOLUME_LONG ;
            //     }
            // }

            //BuyVolChange  += SELECTED_VOLUME_LONG;
            //currentBuyVolume  = temp_vol; // exemplo de possibilidade
            //currentBuyVolume  = temp_vol/2; // exemplo de possibilidade
        }
    }
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_015()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_025()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        SetTopMagneticMovie(); // (est 2x)
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            SetBottomMagneticMovie(); // (est 2x)
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}

int ORD_Strategy_016()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 1)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 1)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_026()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            SetTopMagneticMovie(); // (est 2x)
            if(Current_Buy_Seq > 1)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            SetBottomMagneticMovie(); // (est 2x)
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            if(Current_Sell_Seq > 1)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
            if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            //BottomChange = 0;

        }
        else // vendido
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
        if(pos_status == 1) // vendido
        {
            if(Current_Sell_Seq > 0)
                currentBuyVolume = SELECTED_VOLUME_LONG * 2;
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_017()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
        if(pos_status == 0) // comprado
        {
            //if(Current_Buy_Seq > 1)
                currentSellVolume = SELECTED_VOLUME_SHORT * 3;
            //SellVolChange  += SELECTED_VOLUME_SHORT;
            
            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_ASK <  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG))
            //     {
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
          //  if(Current_Sell_Seq > 1)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
           // if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
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
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_027()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    if(
        CurrentStatusSystem == 1 // a favor da tendência
        )
    {        
       // elaborar uma estratégia de diatância que altera a distancia de acordo com o CurrentStatusSystem
       // elaborar uma estratégia de volume que altera a distancia de acordo com o CurrentStatusSystem
       
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
       // if(temp_vol == 1)
        // {
        //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

            if(pos_status == 0) // comprado
            {
                //TopChange += 200;
                //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
                // if(spd > SELECTED_EN_DISTANCE_LONG)
                // {
                //     CurrentLevelBuy = SERVER_SYMBOL_BID;
                // }
                //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
                BuyVolChange += SELECTED_VOLUME_LONG ;
             

            }
            else // vendido
            {

                //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
                SellVolChange += SELECTED_VOLUME_SHORT ;
                //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
                    //CurrentLevelSell = SERVER_SYMBOL_ASK;
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
    else if(
            CurrentStatusSystem == 2 // contra a tendência
        ) 
    {
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
            //         //CurrentLevelSell = Freeze_Central_Bottom; 
                    
            //         CurrentLevelSell = SERVER_SYMBOL_ASK; 
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
            //CurrentLevelBuy = (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
          //  if(Current_Sell_Seq > 1)
            SetBottomMagneticMovie(); // (est 2x)
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;

            // stop
            // if(temp_vol > 2)
            // {
            //     if(SERVER_SYMBOL_BID >  (Freeze_Central_Top + SELECTED_EN_DISTANCE_SHORT))
            //     {
                    
            //         //CurrentLevelBuy = Freeze_Central_Top;  
                    
            //         CurrentLevelBuy = SERVER_SYMBOL_BID; 
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
    else if(
            CurrentStatusSystem == 3 // contra a tendência na zona de transição
        ) 
    {
        if(pos_status == 0) // comprado
        {
           // if(Current_Buy_Seq > 0)
                currentSellVolume = SELECTED_VOLUME_SHORT * 2;
            //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
            
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
            
            //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
            //BuyVolChange  += SELECTED_VOLUME_LONG;
           // TopChange += 50;
        }
        else
        {
            EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        }
    }
    else if(
            CurrentStatusSystem == 4 // não posicionado na zona de transição
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else // não posicionado e sem tendência
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    return 1;
}
int ORD_Strategy_018()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    if(CurrentStatusSystem == 1) // a favor da tendência
    {        
        SetSisSettings_01();
    }
    else if(CurrentStatusSystem == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    
    else if(CurrentStatusSystem == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(CurrentStatusSystem == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(CurrentStatusSystem == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;
}
int ORD_Strategy_019()
{
    
    if(CurrentStatusSystem == 1) // a favor da tendência
    {
        //exemplo        
        //EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        SetSisSettings_01();
    }
    else if(CurrentStatusSystem == 2) // contra a tendência
    {
        SetSisSettings_02();
    }
    else if(CurrentStatusSystem == 3) // contra a tendência na zona de transição
    {
        SetSisSettings_03();
    }
    else if(CurrentStatusSystem == 4) // não posicionado na zona de transição 
    {
        SetSisSettings_04();
    }
    else if(CurrentStatusSystem == 5) // não posicionado e sem tendência
    {
        SetSisSettings_05();
    }
    return 1;
}

int ORD_Strategy_012_old()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(
        CurrentTradingStatus == 1 // subindo e comprado
        )
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
        if(temp_vol > 2 && temp_vol < 4)
        {
            //currentBuyVolume  = SELECTED_VOLUME_LONG * 2; // é mais agressivo para tendência
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        else 
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
        if(temp_vol > 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }

    }
    else if(
            CurrentTradingStatus == 2 // subindo e vendido
        ) 
    {
        CurrentLevelBuy = SERVER_SYMBOL_BID;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //BottomChange = 0;
        
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT ;
    }
    else if(
            CurrentTradingStatus == 3 // caindo e comprado
        ) 
    {
        CurrentLevelSell = SERVER_SYMBOL_ASK;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //TopChange = 0;
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4 // caindo e vendido
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
       // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;

        if(temp_vol > 2 && temp_vol < 4)
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
            //currentSellVolume  = SELECTED_VOLUME_SHORT ; //mais agressivo para tendência
        }
        else 
        {
            currentSellVolume  = SELECTED_VOLUME_SHORT ;
        }
        if(temp_vol > 4)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG;
        }
    }
    else if(
            CurrentTradingStatus == 5 // zerado e subindo
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG ;
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    }
    else if(
            CurrentTradingStatus == 6 // zerado e caindo
        ) 
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    else
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
        currentBuyVolume  = SELECTED_VOLUME_LONG;
        currentSellVolume  = SELECTED_VOLUME_SHORT;
    }
    return 1;
}
int ORD_Strategy_001_backuop()
{
    // da pra mexer no min add e real pela estratégia quando for contra por exemplo
    // trabalhar o afastamento da média como parâmetro de entrada e saída de trade
    // so vender acima do PM (Ações)
    Print("ORD_Strategy_001");
    if(
        CurrentTradingStatus == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }


    //EstENOrerDst_10();

    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

    return 1;

}
int ORD_Strategy_002_old()
{
    
    
    if(
        CurrentTradingStatus == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
       // min_reduce_sell_modify = EN_Distance_Short;
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
       // min_reduce_buy_modify = EN_Distance_Long;
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }


    //EstENOrerDst_10();

    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

    return 1;
}
int ORD_Strategy_003_OLD()
{
    Print("ORD_Strategy_003");
    
    if(
        CurrentTradingStatus == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }

    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
       
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
        }
       
       
    }


    //EstENOrerDst_10();

    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

    return 1;
}
int ORD_Strategy_004_old()
{
    Print("ORD_Strategy_004");
    
    if(
        CurrentTradingStatus == 1
        )
    {
        min_add_buy_modify = EN_Distance_Long;
        min_reduce_sell_modify = EN_Distance_Short;
        if(pos_volume < MdlTrend_Gravit_Vol)
        {
            
            if(madst > MaSpreadActivator ) // uso do distanciamento da média de ref.
            {
                currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
            }
            else
            {
                currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
            }
            
            
            currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
        }

    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; // add não variável
        currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        min_add_buy_modify = EN_Distance_Long; // add não variável 
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        min_add_sell_modify = EN_Distance_Short; 
        min_reduce_buy_modify = EN_Distance_Long;
       
        if(pos_volume < MdlTrend_Gravit_Vol)
        {


            currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
            
            if(madst > MaSpreadActivator ) // uso do distanciamento da média de ref.
            {
                currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
            }
            else
            {
                currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
            }
        }
        else
        {
            currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
            currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
        }
       
       
    }

    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);

    //EstENOrerDst_10();

    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

    return 1;
}
int ORD_Strategy_005_old()
{
    Print("ORD_Strategy_005");
    
   SELECTED_BUY_FIRST = true;

    currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
    currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    return 1;
}
int ORD_Strategy_007_old()
{

    

    if(
        CurrentTradingStatus == 1
        )
    {

        SELECTED_BUY_FIRST = true;
    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        SELECTED_BUY_FIRST = true;
       // currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
       // currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        SELECTED_SELL_FIRST = true;
       // min_add_buy_modify = EN_Distance_Long; // add não variável 
      //  currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
       // currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        SELECTED_SELL_FIRST = true;
      //  min_add_sell_modify = EN_Distance_Short; 
     //   min_reduce_buy_modify = EN_Distance_Long;
    //    currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
     //   currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }


    return 0;
}
