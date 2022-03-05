// a favor da tendência
void SetSisSettings_01()
{
    switch(TRADE_STATUS_SYSTEM_01_CHOSEN)
    {
        case 1:
            SisSettings_01_ch0001();
            break;
        case 2:
            SisSettings_01_ch0002();
            break;
        case 3:
            SisSettings_01_ch0003();
            break;
        case 4:
            SisSettings_01_ch0004();
            break;
        case 5:
            SisSettings_01_ch0005();
            break;
        case 6:
            SisSettings_01_ch0006();
            break;
        default:
            break;
    }

}
void SisSettings_01_ch0001()
{
    //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
    // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
    // if(temp_vol == 1)
    // {
    //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1

    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro

    if(pos_status == 0) // comprado
    {
        //TopChange += 200;
        //if(SERVER_SYMBOL_BID > (Freeze_Central_Top + SELECTED_EN_DISTANCE_LONG))
        // if(spd > SELECTED_EN_DISTANCE_LONG)
        // {
        //     Level_Buy = SERVER_SYMBOL_BID;
        // }
        //currentBuyVolume = SELECTED_VOLUME_LONG * 2;
        BuyVolChange += SELECTED_VOLUME_LONG ;
    }
    else // vendido
    {
        //currentSellVolume = SELECTED_VOLUME_SHORT * 2;
        SellVolChange += SELECTED_VOLUME_SHORT ;
        //if(SERVER_SYMBOL_ASK < ( Freeze_Central_Bottom- SELECTED_EN_DISTANCE_SHORT))
            //Level_Sell = SERVER_SYMBOL_ASK;
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
void SisSettings_01_ch0002()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    
    //min_add_buy_modify = SELECTED_EN_DISTANCE_LONG;
    // min_reduce_sell_modify = SELECTED_EN_DISTANCE_SHORT;
    // if(temp_vol == 1)
    // {
    //         // em uma estratégia que visa a tendência, o ideal é increementar a distância para o lado oposto da posição quando o volume for 1



    if(temp_vol == 1)
    {


        if(pos_status == 0) // comprado
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
            BuyVolChange += SELECTED_VOLUME_LONG ;
        }
        else // vendido
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 4;
            SellVolChange += SELECTED_VOLUME_SHORT ;

        }

    }
    else if(temp_vol > 2 && temp_vol < 4)
    {
    //     if(pos_status == 0) // comprado
    //     {

    //     }
    //     else // vendido
    //     {
    //     }

    }
    else if(temp_vol > 3)
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
void SisSettings_01_ch0003()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(temp_vol <= SELECTED_MDL_TREND_ACC_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro

        if(pos_status == 0) // comprado
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
            BuyVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }
        else // vendido
        {
            //EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
            BottomChange += SELECTED_EN_DISTANCE_LONG * 4;
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }

    }
    else if(temp_vol > SELECTED_MDL_TREND_ACC_TARGET_VOLUME && temp_vol <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
    //     if(pos_status == 0) // comprado
    //     {
    //     }
    //     else // vendido
    //     {
    //     }

    }
    else if(temp_vol > SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME;
        }
        else // vendido
        {
            BuyVolChange += SELECTED_MDL_TREND_TPR_FACTOR_VOLUME ;
        }
    }        
}
void SisSettings_01_ch0004()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(temp_vol <= SELECTED_MDL_TREND_ACC_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            TopChange += SELECTED_EN_DISTANCE_SHORT * 4;
        }
        else // vendido
        {
            BottomChange += SELECTED_EN_DISTANCE_LONG * 4;   
        }

    }
    else if(temp_vol > SELECTED_MDL_TREND_ACC_TARGET_VOLUME && temp_vol <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            BuyVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }
        else // vendido
        {
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }

    }
    else if(temp_vol > SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME;
        }
        else // vendido
        {
            BuyVolChange += SELECTED_MDL_TREND_TPR_FACTOR_VOLUME ;
        }
    }        
}
void SisSettings_01_ch0005()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);

    if(temp_vol <= SELECTED_MDL_TREND_ACC_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        // if(pos_status == 0) // comprado
        // {
        //     TopChange += SELECTED_EN_DISTANCE_SHORT * 2;
            
            
        // }
        // else // vendido
        // {
        //     BottomChange += SELECTED_EN_DISTANCE_LONG * 2;   
            
        // }

    }
    else if(temp_vol > SELECTED_MDL_TREND_ACC_TARGET_VOLUME && temp_vol <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            BuyVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }
        else // vendido
        {
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME ;
        }

    }
    else if(temp_vol > SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro
        if(pos_status == 0) // comprado
        {
            SellVolChange += SELECTED_MDL_TREND_REV_FACTOR_VOLUME;
        }
        else // vendido
        {
            BuyVolChange += SELECTED_MDL_TREND_TPR_FACTOR_VOLUME ;
        }
    }        
}
void SisSettings_01_ch0006()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); // tem que vir primeiro

    if(temp_vol <= SELECTED_MDL_TREND_ACC_TARGET_VOLUME)
    {
        if(pos_status == 0) // comprado
        {
            //TopChange += SELECTED_EN_DISTANCE_SHORT * SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
            TopChange += SELECTED_EN_DISTANCE_SHORT * 10;
            // TopChange += SELECTED_MDL_TREND_ACC_VALUE_VOLUME;   
            // BottomChange -= SELECTED_MDL_TREND_ACC_VALUE_VOLUME;
            // TopChange += SELECTED_MDL_TREND_ACC_VALUE_VOLUME;   
            //BottomChange -= SELECTED_MDL_TREND_ACC_VALUE_VOLUME;
        }
        else // vendido
        {
            //BottomChange += SELECTED_EN_DISTANCE_LONG * SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;   
            BottomChange += SELECTED_EN_DISTANCE_LONG * 10;   
            //BottomChange += SELECTED_MDL_TREND_ACC_VALUE_VOLUME;   
            
        }

    }
    else if(temp_vol > SELECTED_MDL_TREND_ACC_TARGET_VOLUME && temp_vol <= SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {
        if(pos_status == 0) // comprado
        {
            BuyVolChange += SELECTED_MDL_TREND_REV_VALUE_VOLUME ;
        }
        else // vendido
        {
            SellVolChange += SELECTED_MDL_TREND_REV_VALUE_VOLUME ;
        }
    }
    else if(temp_vol > SELECTED_MDL_TREND_TPR_TARGET_VOLUME)
    {   
        if(pos_status == 0) // comprado
        {
            SellVolChange += SELECTED_MDL_TREND_REV_VALUE_VOLUME;
        }
        else // vendido
        {
            BuyVolChange += SELECTED_MDL_TREND_TPR_VALUE_VOLUME ;
        }
    }




}