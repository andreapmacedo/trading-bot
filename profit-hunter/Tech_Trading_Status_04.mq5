// não posicionado e tendência
void SetSisSettings_04()
{
    switch(TRADE_STATUS_SYSTEM_04_CHOSEN)
    {
        case 1:
            SisSettings_04_ch0001();
            break;
        case 2:
            SisSettings_04_ch0002();
            break;
        case 3:
            SisSettings_04_ch0003();
            break;
        case 4:
            SisSettings_04_ch0004();
            break;
        case 5:
            SisSettings_04_ch0005();
            break;
        case 6:
            SisSettings_04_ch0006();
            break;
        default:
            break;
    }

}
void SisSettings_04_ch0001()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
}
void SisSettings_04_ch0002()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {
        SetBottomMagneticMovie(); // (est 2x)
    }
    else if(CurrentTrend == -1)
    {
        SetTopMagneticMovie(); // (est 2x)
    }
}
void SisSettings_04_ch0003() // faz sentido
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {
        TopChange += SELECTED_EN_DISTANCE_SHORT * 10;
        SetBottomMagneticMovie(); // (est 2x)

    }
    else if(CurrentTrend == -1)
    {
        BottomChange += SELECTED_EN_DISTANCE_LONG * 10;
        SetTopMagneticMovie(); // (est 2x)
    }


}
void SisSettings_04_ch0004()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {
        TopChange += SELECTED_EN_DISTANCE_SHORT * 10;
        BuyVolChange += SELECTED_VOLUME_LONG;
        //SetBottomMagneticMovie(); // (est 2x)

    }
    else if(CurrentTrend == -1)
    {
        BottomChange += SELECTED_EN_DISTANCE_LONG * 10;
        SellVolChange += SELECTED_VOLUME_SHORT;
        //SetTopMagneticMovie(); // (est 2x)
    }
}
void SisSettings_04_ch0005()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {
        TopChange += SELECTED_EN_DISTANCE_SHORT * 10;
        BuyVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        //SetBottomMagneticMovie(); // (est 2x)

    }
    else if(CurrentTrend == -1)
    {
        BottomChange += SELECTED_EN_DISTANCE_LONG * 10;
        SellVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        //SetTopMagneticMovie(); // (est 2x)
    }
}
void SisSettings_04_ch0006()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {
        TopChange += SELECTED_EN_DISTANCE_SHORT * 10;
        BuyVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        SetBottomMagneticMovie(); // (est 2x)

    }
    else if(CurrentTrend == -1)//zerado e caindo
    {
        BottomChange += SELECTED_EN_DISTANCE_LONG * 10;
        SellVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        SetTopMagneticMovie(); // (est 2x)
    }
}
void SisSettings_04_ch0007()
{
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
    if(CurrentTrend == 1) //zerado e subindo
    {

        TopChange += SELECTED_EN_DISTANCE_SHORT * SELECTED_MDL_TREND_ACC_FACTOR_DISTANCE;
        BuyVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        SetBottomMagneticMovie(); // (est 2x)

    
    }
    else if(CurrentTrend == -1)//zerado e caindo
    {
        BottomChange += SELECTED_EN_DISTANCE_LONG * SELECTED_MDL_TREND_ACC_FACTOR_DISTANCE;
        SellVolChange += SELECTED_MDL_TREND_ACC_FACTOR_VOLUME;
        SetTopMagneticMovie(); // (est 2x)
    }
}
