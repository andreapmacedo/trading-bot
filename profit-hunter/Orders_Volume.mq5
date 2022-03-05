int eVolumeCondition = 0;




int gravit_status = 0;


enum enum_Order_Volume
{
    eVolume_System                  = 0,
    eVolume_Default                 = 1,
    eVolume_Reverse                 = 2,
    eVolume_Relief_trend            = 3,
    eVolume_Relief_Sequence_01      = 4,
    eVolume_Relief_Sequence_02      = 5,
    eVolume_Relief_Sequence_03      = 6,
    eVolume_Relief_trend_Sequence   = 7,
    eVolume_Adaptative_ADD          = 8,
    eVolume_Adaptative_Reduce  	    = 9,
    eVol_Smart_MA_003           	= 14,
    eVol_Smart_MA_021           	= 21,
    eVol_Smart_MA_Graviton        	= 22,
    eVol_Status_001             	= 101,
    eVol_Status_002             	= 102,
    eVol_Status_003             	= 103,
    eVol_Status_004             	= 104,
    eVol_Status_005             	= 105
    
};

//void Set_OrderVolume(double &sell_vol,double &buy_vol, int chosen)
void Set_OrderVolume(int chosen)
{
    int confirm = 0;
    switch(chosen)
    {

    }  
}


void EST_Volume__Status_001()
{
    if(
        CurrentTradingStatus == 1
        )
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 3;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 3;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;             
}




void EST_Volume__Status_002()
{
    if(
        pos_status == 0
    )
    {
        currentSellVolume = 1 + DYT_SYMBOL_SELL_SEQUENCE;
    }
    else if(
        pos_status == 1
    )
    {
        currentBuyVolume = 1 + DYT_SYMBOL_BUY_SEQUENCE;
    }
    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

}

void EST_Volume__Status_003()
{

    currentBuyVolume = 1 + DYT_SYMBOL_BUY_SEQUENCE;
    currentSellVolume = 1 + DYT_SYMBOL_SELL_SEQUENCE;
    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

}

void EST_Volume__Status_004()
{
    if(
        pos_status == 0
    )
    {
        currentBuyVolume  = pos_volume;
        if(pos_volume > 0)
            currentSellVolume = MathRound(pos_volume / 2);
    }
    else if(
        pos_status == 1
    )
    {
        currentSellVolume = pos_volume;
        if(pos_volume > 0)
            currentBuyVolume  = MathRound(pos_volume / 2);
    }
    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;    

}

void EST_Volume__Status_005()
{
    if(
        CurrentTradingStatus == 1
        )
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 2
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 2;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 1;
    }
    else if(
            CurrentTradingStatus == 3
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    else if(
            CurrentTradingStatus == 4
        ) 
    {
        currentBuyVolume  = SELECTED_VOLUME_LONG * 1;
        currentSellVolume  = SELECTED_VOLUME_SHORT * 2;
    }
    FINAL_LONG_VOLUME  = currentBuyVolume;
    FINAL_SHORT_VOLUME  = currentSellVolume;        
}



void EN_OrderVolume_Settings(int chosen)
{
    switch(chosen)
    {
        case 0:
            break;            
        case 2:
            EstVol_02();
            break;           
        case 10: // Volume por sequência
            EstVol_10();
            break;           
        case 100: 
            EstVol_100();
            break;           
        case 1000://
            EstVol_1000();
            break;                    
        case 20: // Volume por sequência e tendência 
            EstVol_20();
            break;           
        case 30: // Volume por sequência e trade status
            EstVol_30();
            break;           
        case 50: // Volume por volume
            EstVol_50();
            break;                    
        case 901: // Complexas
            EstVol_901();
            break;                    
        case 902: // 
            EstVol_902();
            break;                    
           
    }  
}

//+------------------------------------------------------------------+
// Volume por sequência
//+------------------------------------------------------------------+

void EstVol_10() 
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    */
    double adj_end_seq;
    SetAdjVolSeqEnd(adj_end_seq);

    if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetBuyVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);
  
    }
    else if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI )   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetSellVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);  
    }
}
void EstVol_20() 
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    */
    double adj_end_seq;
    SetAdjVolSeqEnd(adj_end_seq);

    if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentTrend == 1)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetBuyVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);
  
    }
    else if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentTrend == -1)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetSellVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);  
    }
}
void EstVol_30() 
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    */
    double adj_end_seq;
    SetAdjVolSeqEnd(adj_end_seq);

    if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentStatusSystem == 2 )
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetBuyVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);
  
    }
    else if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentStatusSystem == 2 )   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetSellVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);  
    }
}

void EstVol_100() 
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    */

    double adj_end_seq;
    SetAdjVolSeqEnd(adj_end_seq);

    if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI && pos_status == 0)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetBuyVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);
  
    }
    else if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI  && pos_status == 1)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetSellVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);  
    }
}



void EstVol_1000() 
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    */
    
    double adj_end_seq;
    SetAdjVolSeqEnd(adj_end_seq);

    if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentTrend == -1)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetBuyVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI && CurrentTrend == 1)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_VOL_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_VOL_SEQ_TOL_INI;
        }
        SetSellVolChange(ADJ_VOL_SEQ_MODE_PG, SELECTED_ADJ_VOL_SEQ, range);  
    }
}

//+------------------------------------------------------------------+
// Volume por volume
//+------------------------------------------------------------------+

void EstVol_50()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com os lotes de volume incrementado.
    */

    //double adj_end_seq;
    double adj_end_vol;
    double ref_vol;
    //SetAdjDstSeqEnd(adj_end_seq);
    SetAdjVolVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);
    //double range = ref_vol-ADJ_VOL_VOL_TOL_INI;

    //if(ref_vol > ADJ_VOL_VOL_TOL_INI && ref_vol <= adj_end_vol)
    if(ref_vol > ADJ_VOL_VOL_TOL_INI )
    {

        double range;
        if(ref_vol <= adj_end_vol)
        {
            range = ref_vol-SELECTED_ADJ_VOL_VOL_TOL_INI;
        }
        else if(ref_vol > adj_end_vol)
        {
            range = adj_end_vol-SELECTED_ADJ_VOL_VOL_TOL_INI;
        }



        if(pos_status == 0)
        {
        
            SetBuyVolChange(ADJ_VOL_VOL_MODE_PG, SELECTED_ADJ_VOL_VOL,range);
            
        
        }
        if(pos_status == 1)
        {
            SetSellVolChange(ADJ_VOL_VOL_MODE_PG, SELECTED_ADJ_VOL_VOL,range);
        
        
        }
    }
  
}


void SetBuyVolChange(double mode_pg, double selected_adj, double range)
{
    if(mode_pg)
    {
        BuyVolChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        BuyVolChange  += selected_adj * range;
    }
}
void SetSellVolChange(double mode_pg, double selected_adj, double range)
{
    if(mode_pg)
    {
        SellVolChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        SellVolChange  += selected_adj * range;
    }
}

void EstVol_02()
{

    double adj_end_seq;
    double adj_end_vol;
    double ref_vol;
    GetCurrentPositionVolume(ref_vol);
    SetAdjDstSeqEnd(adj_end_seq);
    SetAdjVolVolEnd(adj_end_vol);


    if(ref_vol > ADJ_VOL_SEQ_TOL_INI && ref_vol <= adj_end_vol)
    {
        if(pos_status == 0)
        {
            BuyVolChange = SELECTED_ADJ_VOL_VOL * (ref_vol - ADJ_VOL_SEQ_TOL_INI);
            if(Current_Sell_Seq > ADJ_VOL_SEQ_TOL_INI && Current_Sell_Seq <= adj_end_seq)   
            {
                SellVolChange = SELECTED_ADJ_VOL_SEQ * (Current_Sell_Seq - ADJ_VOL_SEQ_TOL_INI); 
            }
        }
        if(pos_status == 1)
        {
            SellVolChange = SELECTED_ADJ_VOL_VOL * (ref_vol - ADJ_VOL_SEQ_TOL_INI); 
            if(Current_Buy_Seq > ADJ_VOL_SEQ_TOL_INI && Current_Buy_Seq <= adj_end_seq)
            {
                BuyVolChange = SELECTED_ADJ_VOL_SEQ * (Current_Buy_Seq - ADJ_VOL_SEQ_TOL_INI);
            }            
        }
    }    
}





void EstVol_901()
{

    //Print("EST_Volume__SmartMA_002 :", trend);
    gravit_status = 0;
    //double midLevel = GetMidLevelRange();



    double ref_vol;
    GetCurrentPositionVolume(ref_vol);


    if(CurrentTradingStatus == 1)// subindo e comprado
    {
        if(ref_vol < SELECTED_MDL_GRAVIT_VOL)
        {
            BuyVolChange  += SELECTED_VOLUME_LONG;
        }
        else if(ref_vol > SELECTED_MDL_GRAVIT_VOL) 
        {
            SellVolChange  += SELECTED_VOLUME_SHORT;
        }
        gravit_status = 1;
    }
    else if(CurrentTradingStatus == 2) // subindo e vendido
    {
        BuyVolChange  += SELECTED_VOLUME_LONG * 2;
        gravit_status = 2;
    }
    else if(CurrentTradingStatus == 3) // caindo e comprado
    {
        SellVolChange  += SELECTED_VOLUME_SHORT * 2;
        gravit_status = 3;
    }
    else if(CurrentTradingStatus == 4) // caindo e vendido
    {
        if(ref_vol > SELECTED_MDL_GRAVIT_VOL)
        {
            BuyVolChange  += SELECTED_VOLUME_LONG * 1;
        }
        else if(ref_vol < SELECTED_MDL_GRAVIT_VOL) 
        {
            SellVolChange  += SELECTED_VOLUME_SHORT * 1;
        }
        gravit_status = 4;
    }
    


    // //--- Trabalhando a venda
    // if(
    //     CurrentTrend == -1 // Caindo
    //     && pos_status == 1 // Vendido
    //     )
    // {
        
    //     if(ref_vol > SELECTED_MDL_GRAVIT_VOL)
    //     {
    //         BuyVolChange  += SELECTED_VOLUME_LONG * 2;
    //     }
    //     else if(ref_vol < SELECTED_MDL_GRAVIT_VOL) 
    //     {
    //         SellVolChange  = SELECTED_VOLUME_SHORT * 2;
    //     }
    //     gravit_status = 1;

    // }
    // else if(
    //     CurrentTrend == 1
    //     && pos_status == 1
    //     ) 
    // {
    //     if(ref_vol > SELECTED_MDL_GRAVIT_VOL)
    //     {
    //         SellVolChange  = SELECTED_VOLUME_SHORT * 2;
    //     }
    //     else if(ref_vol < SELECTED_MDL_GRAVIT_VOL) 
    //     {
    //         BuyVolChange  = SELECTED_VOLUME_LONG * 2;
    //     }
    
    //     gravit_status = 2;
    // }
    // else if(
    //     CurrentTrend == -1
    //     && pos_status == 1 
    //     ) 
    // {
    //     SellVolChange  = SELECTED_VOLUME_SHORT * 3;
    //     gravit_status = 3;  
    // }
    // else if(
    //     CurrentTrend == 1
    //     && pos_status == -1 
    //     ) 
    // {

    //     BuyVolChange  = SELECTED_VOLUME_LONG * 3;
    //     //SellVolChange  = SELECTED_VOLUME_SHORT * 1;
    //     gravit_status = 4;
    // }

    Print("gravit_status: ", gravit_status );

}
void EstVol_902()
{

    //Print("EST_Volume__SmartMA_002 :", trend);
    gravit_status = 0;
    //double midLevel = GetMidLevelRange();



    double ref_vol;
    GetCurrentPositionVolume(ref_vol);


    if(CurrentTradingStatus == 1)// subindo e comprado
    {
        if(ref_vol < SELECTED_MDL_GRAVIT_VOL)
        {
            BuyVolChange  += SELECTED_VOLUME_LONG;
        }
        else if(ref_vol > SELECTED_MDL_GRAVIT_VOL) 
        {
            SellVolChange  += SELECTED_VOLUME_SHORT;
        }
        gravit_status = 1;
    }
    else if(CurrentTradingStatus == 2) // subindo e vendido
    {
        BuyVolChange  += SELECTED_VOLUME_LONG;
        gravit_status = 2;
    }
    else if(CurrentTradingStatus == 3) // caindo e comprado
    {
        SellVolChange  += SELECTED_VOLUME_SHORT;
        gravit_status = 3;
    }
    else if(CurrentTradingStatus == 4) // caindo e vendido
    {
        if(ref_vol > SELECTED_MDL_GRAVIT_VOL)
        {
            BuyVolChange  += SELECTED_VOLUME_LONG;
        }
        else if(ref_vol < SELECTED_MDL_GRAVIT_VOL) 
        {
            SellVolChange  += SELECTED_VOLUME_SHORT;
        }
        gravit_status = 4;
    }

    Print("gravit_status: ", gravit_status );
}



void Set_EN_OrdersVolume__Reverse()
{
    if(pos_status == -1)// Vendido
    {
        FINAL_LONG_VOLUME  = PositionGetDouble(POSITION_VOLUME) + SELECTED_VOLUME_LONG ;              
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(pos_status == 1) // Comprado
    {
        
        FINAL_SHORT_VOLUME  = PositionGetDouble(POSITION_VOLUME) + SELECTED_VOLUME_SHORT ;              
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
}

void Set_EN_OrdersVolume__Relief_trend()
{
    if(pos_status == -1)// Vendido
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(pos_status == 1) // Comprado
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
}

void Set_EN_OrdersVolume__Relief_Sequence_01()
{
    if(DYT_SYMBOL_SELL_SEQUENCE > 0)
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(DYT_SYMBOL_BUY_SEQUENCE > 0)
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
}

void Set_EN_OrdersVolume__Relief_Sequence_02()
{
    if(DYT_SYMBOL_SELL_SEQUENCE > 1)
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(DYT_SYMBOL_BUY_SEQUENCE > 1)
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
}

void Set_EN_OrdersVolume__Relief_Sequence_03()
{
    if(DYT_SYMBOL_SELL_SEQUENCE > 2)
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(DYT_SYMBOL_BUY_SEQUENCE > 2)
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
}

void Set_EN_OrdersVolume__Relief_trend_Sequence()
{
    if(pos_status == -1)// Vendido
    {
        if(DYT_SYMBOL_SELL_SEQUENCE > 1)
        {
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
        }
        else
        {
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;            
        }
    }
    else if(pos_status == 1) // Comprado
    {
        
        if(DYT_SYMBOL_BUY_SEQUENCE > 1)
        {
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        }
        else
        {
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
        }
    }
    else
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }

}






void Set_EN_OrdersVolume__Conditions_01()
{
    if(eVolumeCondition == 1)
    {
        SELECTED_LIMIT_POSITION_VOLUME = 3;
    }
    else if(eVolumeCondition == 2)
    {
        SELECTED_LIMIT_POSITION_VOLUME = 2;

    }
}

void Set_EN_OrdersVolume__Increment()
{
    if(pos_status == 0) // zerado
    {
        
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = FINAL_LONG_VOLUME;           
    }
    else if(pos_status == 1) // comprado
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT * 2;
        FINAL_LONG_VOLUME  = FINAL_LONG_VOLUME; 
    }
    else if(pos_status == -1) // vendido
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = FINAL_LONG_VOLUME * 2;
    }       
}







void Set_EN_OrdersVolume__SmartMA_001()
{

    double selected_ma_fast = MyRound(Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 0)); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double previous_selected_ma_fast = Get_MA(MainMaPeriod, MA_FAST_SHIFT,  MODE_EMA, 1); //(período, deslocamento, tipo de suavisação, tipo de preço, "barra")       
  //  double ma_spread = selected_ma_fast - previous_selected_ma_fast;

   // ma_spread = NormalizeDouble(MyRound(ma_spread), _Digits);
  //  selected_ma_fast = NormalizeDouble(MyRound(selected_ma_fast), _Digits);
   // previous_selected_ma_fast = NormalizeDouble(MyRound(previous_selected_ma_fast), _Digits);


    //+------------------------------------------------------------------+
    //| Logic                                                            |
    //+------------------------------------------------------------------+


    if(
        PriceInfo[1].close > selected_ma_fast
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_AccFactorVolume;

    }
    else if(
        PriceInfo[1].close < selected_ma_fast
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT * MdlTrend_AccFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;
    }
 
}


//input double HEDGE_VOL_EST_REAL = 20;

void Set_EN_OrdersVolume__SmartMA_002()
{



    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);
    //int trend = Trend_Settings(3);
    //Print("trnd :", trend);
    
    FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
    FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;     
    if(
        //PriceInfo[1].close > selected_ma_fast
        //previous_selected_ma_fast < selected_ma_fast
        trend == 1
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        //&& DYT_TOTAL_SYMBOL_BALANCE < SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_AccFactorVolume;

    }
    else if(
        //PriceInfo[1].close < selected_ma_fast
        //previous_selected_ma_fast > selected_ma_fast
        trend == -1
        //&& DYT_TOTAL_SYMBOL_BALANCE < SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT * MdlTrend_AccFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;
    }



 
    if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == -1
        )// Vendido
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_TprFactorVolume;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == 1
        ) // Comprado
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * MdlTrend_TprFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }

}



//--


void Set_EN_OrdersVolume__SmartMA_003()
{

    FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
    FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;  

    if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == -1
        )// Vendido
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_TprFactorVolume;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == 1
        ) // Comprado
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * MdlTrend_TprFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }
    
}


// Dá pra fazer um adptive volume composto com uma função que chama duas lógicas(funções distintas)
// ex. adpitive add e reduce
/*
void Set_OrdersVolume__Adaptative_ADD()
{
    

	
    double Check_EN_Long_Distance = 0;
	double Check_EN_Short_Distance = 0;


	//Check_EN_Long_Distance = DYT_SYMBOL_LAST_BUY - MIN_ADD_DISTANCE;
	//Check_EN_Short_Distance = DYT_SYMBOL_LAST_SELL + MIN_ADD_DISTANCE; 

	if(BREAK_MODE)
	{
		Check_EN_Long_Distance = DYT_SYMBOL_LAST_BUY + MIN_ADD_DISTANCE;
		Check_EN_Short_Distance = DYT_SYMBOL_LAST_SELL - MIN_ADD_DISTANCE; 		
	}
	else
	{
		Check_EN_Long_Distance = DYT_SYMBOL_LAST_BUY - MIN_ADD_DISTANCE;
		Check_EN_Short_Distance = DYT_SYMBOL_LAST_SELL + MIN_ADD_DISTANCE; 		
	}

	
	if (PositionGetDouble(POSITION_VOLUME) > 0) //--- Está posicionado?
	{
		if(DYT_SYMBOL_BUY_SEQUENCE > 0)
		{
			if(FINAL_EN_LONG_VALUE >= Check_EN_Long_Distance)
			{

				if(MIN_ADD_DISTANCE > 0)
				{
					//LONG_CONDITIONS = false;
					FINAL_EN_LONG_VALUE = Check_EN_Long_Distance;
				}				
				
			}

			// Reduce Filter 
			if(REDUCE_FILTER)
			{
				if (FINAL_EN_SHORT_VALUE < (DYT_SYMBOL_LAST_BUY ))
				{
					FINAL_EN_SHORT_VALUE = DYT_SYMBOL_LAST_BUY + (EN_Distance_Short);
				}
			}


		}
		else if(DYT_SYMBOL_SELL_SEQUENCE > 0)
		{
			if(FINAL_EN_SHORT_VALUE <= Check_EN_Short_Distance)
			{

				if(MIN_ADD_DISTANCE > 0)
				{
					//SHORT_CONDITIONS = false;
					FINAL_EN_SHORT_VALUE = Check_EN_Short_Distance;
				}



			}
			// Reduce Filter 
			if(SELECTED_REDUCE_FILTER)
			{
				if (FINAL_EN_LONG_VALUE > (DYT_SYMBOL_LAST_SELL))
				{
					FINAL_EN_LONG_VALUE = DYT_SYMBOL_LAST_SELL - (EN_Distance_Long);
				}
			}

		}
	}
}

*/

void Set_EN_OrdersVolume__SmartMA_021()
{

    
    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);
    //Print("trnd :", trend);

    FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
    FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;  

    if(
        //SymbolInfoDouble(_Symbol, SYMBOL_ASK) > midLevel
        trend == 1
        //PriceInfo[1].close > midLevel
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_AccFactorVolume;

    }
    else if(
        //SymbolInfoDouble(_Symbol, SYMBOL_BID) < midLevel
        //PriceInfo[1].close < midLevel
        trend == -1
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT * MdlTrend_AccFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;
    }
    else
    {
        FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;        
    }

 
    if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == -1
        )// Vendido
    {
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * MdlTrend_TprFactorVolume;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT ;
    }
    else if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == 1
        ) // Comprado
    {
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * MdlTrend_TprFactorVolume;
        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG ;
    }

}



void Set_EN_OrdersVolume__Graviton()
{


    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);
    
    //int trend = Trend_Settings(2);
    //Print("Set_EN_OrdersVolume__Graviton trend :", trend);
    gravit_status = 0;
    //double midLevel = GetMidLevelRange();

    double fator_a = 1;
    double fator_r = 1;


    FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
    FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;   


        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME

    //--- Trabalhando a venda
    if(
        trend == -1
        && MyGetPosition() == -1 // Vendido
        )
    {
        
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
            //fator_r *= 1;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        }
        // implementar fator para valores distantes (necessidade) 
        gravit_status = 1;

    }
    else if(
        trend == 1
        && MyGetPosition() == 1 
        ) 
    {
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
           // fator_r *= 1;
            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;
        }
    
        gravit_status = 2;
    }
    else if(
        trend == -1
        && MyGetPosition() == 1 
        ) 
    {

        //fator_a *= 1;
        //fator_r *= 3;

        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 3;
        gravit_status = 3;  
    }
    else if(
        trend == 1
        && MyGetPosition() == -1 
        ) 
    {
       // fator_a *= 2;
       // fator_r *= 1;

        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 3;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;
        gravit_status = 4;
    }

}


//--- trabalhar com fator de acumulação de realização manipulável pelo sistema
void Set_EN_OrdersVolume__Graviton_02()
{
    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);
    //Print("trnd :", trend);
    gravit_status = 0;
    //double midLevel = GetMidLevelRange();





    double fator_a = 1;
    double fator_r = 1;


    FINAL_SHORT_VOLUME = SELECTED_VOLUME_SHORT;
    FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG;   

    // utilizar um fator de adição e outro de realização
    // caso acima do valor alvo, o fator de realização vai estar 2 enquanto o de adição 1
    // caso abaixo do valor alvo, o fator de realização vai estar 1 enquanto o de adição 2



 

        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME

    //--- Trabalhando a venda
    if(
        trend == -1
        && MyGetPosition() == -1 // Vendido
        )
    {
        
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
            //fator_r *= 1;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;
        }


        // implementar fator para valores distantes (necessidade) 

        gravit_status = 1;

    }
    else if(
        trend == 1
        && MyGetPosition() == 1 
        ) 
    {
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 2;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
           // fator_r *= 1;

            FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 2;
            FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;
        }
    
        gravit_status = 2;
    }
    else if(
        trend == -1
        && MyGetPosition() == 1 
        ) 
    {

        //fator_a *= 1;
        //fator_r *= 3;

        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 1;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 3;
        gravit_status = 3;  
    }
    else if(
        trend == 1
        && MyGetPosition() == -1 
        ) 
    {
       // fator_a *= 2;
       // fator_r *= 1;

        FINAL_LONG_VOLUME  = SELECTED_VOLUME_LONG * 3;
        FINAL_SHORT_VOLUME  = SELECTED_VOLUME_SHORT * 1;
        gravit_status = 4;
    }

}







void EST_Volume__SmartMA_002(double &sell_vol, double &buy_vol)
{


    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);
    //int trend = Trend_Settings(3);
    //Print("EST_Volume__SmartMA_002 :", trend);
      
    if(
        //PriceInfo[1].close > selected_ma_fast
        //previous_selected_ma_fast < selected_ma_fast
        trend == 1
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        //&& DYT_TOTAL_SYMBOL_BALANCE < SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        sell_vol = SELECTED_VOLUME_SHORT;
        buy_vol  = SELECTED_VOLUME_LONG * MdlTrend_AccFactorVolume;

    }
    else if(
        //PriceInfo[1].close < selected_ma_fast
        //previous_selected_ma_fast > selected_ma_fast
        trend == -1
        //&& DYT_TOTAL_SYMBOL_BALANCE < SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetVolumePosition() <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        )
    {
        sell_vol = SELECTED_VOLUME_SHORT * MdlTrend_AccFactorVolume;
        buy_vol  = SELECTED_VOLUME_LONG;
    }



 
    if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == -1
        )// Vendido
    {
        buy_vol  = SELECTED_VOLUME_LONG * MdlTrend_TprFactorVolume;
        sell_vol  = SELECTED_VOLUME_SHORT ;
    }
    else if(
        //DYT_TOTAL_SYMBOL_BALANCE > SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        && MyGetPosition() == 1
        ) // Comprado
    {
        sell_vol  = SELECTED_VOLUME_SHORT * MdlTrend_TprFactorVolume;
        buy_vol  = SELECTED_VOLUME_LONG ;
    }


    FINAL_LONG_VOLUME  = buy_vol;
    FINAL_SHORT_VOLUME  = sell_vol;

}

void EST_Volume__SmartMA_001(double &sell_vol, double &buy_vol)
{
    int trend = Trend_Settings(INPUT_TREND_EST_CHOSEN);

    //Print("EST_Volume__SmartMA_002 :", trend);
    gravit_status = 0;
    //double midLevel = GetMidLevelRange();





    double fator_a = 1;
    double fator_r = 1;


    // utilizar um fator de adição e outro de realização
    // caso acima do valor alvo, o fator de realização vai estar 2 enquanto o de adição 1
    // caso abaixo do valor alvo, o fator de realização vai estar 1 enquanto o de adição 2



 

        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME
        //MyGetVolumePosition() >= SELECTED_MDL_TREND_TPR_TARGET_VOLUME

    //--- Trabalhando a venda
    if(
        trend == -1
        && MyGetPosition() == -1 // Vendido
        )
    {
        
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;

            buy_vol  = SELECTED_VOLUME_LONG * 2;
            sell_vol  = SELECTED_VOLUME_SHORT * 1;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
            //fator_r *= 1;

            buy_vol  = SELECTED_VOLUME_LONG * 1;
            sell_vol  = SELECTED_VOLUME_SHORT * 2;
        }


        // implementar fator para valores distantes (necessidade) 

        gravit_status = 1;

    }
    else if(
        trend == 1
        && MyGetPosition() == 1 
        ) 
    {
        if(MyGetVolumePosition() > MdlTrend_Gravit_Vol)
        {
            //fator_a *= 1;
            //fator_r *= 2;

            buy_vol  = SELECTED_VOLUME_LONG * 1;
            sell_vol  = SELECTED_VOLUME_SHORT * 2;


        }
        else if(MyGetVolumePosition() < MdlTrend_Gravit_Vol) 
        {
            //fator_a *= 2;
           // fator_r *= 1;

            buy_vol  = SELECTED_VOLUME_LONG * 2;
            sell_vol  = SELECTED_VOLUME_SHORT * 1;
        }
    
        gravit_status = 2;
    }
    else if(
        trend == -1
        && MyGetPosition() == 1 
        ) 
    {

        //fator_a *= 1;
        //fator_r *= 3;

        buy_vol  = SELECTED_VOLUME_LONG * 1;
        sell_vol  = SELECTED_VOLUME_SHORT * 3;
        gravit_status = 3;  
    }
    else if(
        trend == 1
        && MyGetPosition() == -1 
        ) 
    {
       // fator_a *= 2;
       // fator_r *= 1;

        buy_vol  = SELECTED_VOLUME_LONG * 3;
        sell_vol  = SELECTED_VOLUME_SHORT * 1;
        gravit_status = 4;
    }


    FINAL_LONG_VOLUME  = buy_vol;
    FINAL_SHORT_VOLUME  = sell_vol;    

}

