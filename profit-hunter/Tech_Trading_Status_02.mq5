

// contra a tendência
void SetSisSettings_02()
{
    switch(TRADE_STATUS_SYSTEM_02_CHOSEN)
    {
        case 1:
            SisSettings_02_ch0001();
            break;
        case 2:
            SisSettings_02_ch0002();
            break;
        default:
            break;
    }

}

void SisSettings_02_ch0001()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
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
}
void SisSettings_02_ch0002()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(Current_Buy_Seq > 1) // sequência
        {
            currentSellVolume = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
        SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(Current_Sell_Seq > 1)
        {
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;
        }
    }
}
void SisSettings_02_ch0003()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        // SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(Current_Buy_Seq > 1) // sequência
        {
            currentSellVolume = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
        // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(Current_Sell_Seq > 1)
        {
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;
        }
    }
}
void SisSettings_02_ch0004()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        //SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
       // BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(Current_Buy_Seq > 1) // sequência
        {
            currentSellVolume = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
       // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
       // TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(Current_Sell_Seq > 1)
        {
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;
        }
    }
}

void SisSettings_02_ch0005()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(pos_status == 0) // comprado
    {

        // if(temp_vol == 1)
        // {

        // }
        //SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
       // BottomChange += SELECTED_EN_DISTANCE_LONG * 4;

        if(Current_Buy_Seq > 1) // sequência
        {
            currentSellVolume = SELECTED_VOLUME_SHORT * 3;
        }


    }

    if(pos_status == 1) // vendido
    {        
       // SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
       // TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        if(Current_Sell_Seq > 1)
        {
            currentBuyVolume = SELECTED_VOLUME_LONG * 3;
        }
    }
}