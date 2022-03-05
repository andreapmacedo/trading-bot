// contra a tendência na zona de transição
void SetSisSettings_03()
{
    switch(TRADE_STATUS_SYSTEM_03_CHOSEN)
    {
        case 1:
            SisSettings_03_ch0001();
            break;
        case 2:
            SisSettings_03_ch0002();
            break;
        default:
            break;
    }

}
void SisSettings_03_ch0001()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    
    if(pos_status == 0) // comprado
    {
        // if(Current_Buy_Seq > 0)
            currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
        
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        //BottomChange = 0;

    }
    // else // vendido
    // {
    //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }

    if(pos_status == 1) // vendido
    {
        //  if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        
        //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //BuyVolChange  += SELECTED_VOLUME_LONG;
        // TopChange += 50;
    }
    // else
    // {
    //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
}
void SisSettings_03_ch0002()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro

    if(pos_status == 0) // comprado
    {
        SetTopMagneticMovie(); // (est 2x)
        //SetTopMagneticMovie_Pro(); // (est 2x)
        // if(Current_Buy_Seq > 0)
            currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        //CurrentLevelSell = (Freeze_Central_Top - SELECTED_EN_DISTANCE_SHORT);
        
        //SellVolChange  += SELECTED_VOLUME_SHORT;
        //BottomChange = 0;

    }
    // else // vendido
    // {
    //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
    if(pos_status == 1) // vendido
    {
        SetBottomMagneticMovie(); // (est 2x)
        //SetBottomMagneticMovie_Pro();
        //  if(Current_Sell_Seq > 0)
            currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        
        //CurrentLevelBuy =  (Freeze_Central_Bottom - SELECTED_EN_DISTANCE_LONG);
        //BuyVolChange  += SELECTED_VOLUME_LONG;
        // TopChange += 50;
    }
    // else
    // {
    //     EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    // }
}
