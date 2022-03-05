
void SetSisSettings_05()
{
    switch(TRADE_STATUS_SYSTEM_05_CHOSEN)
    {
        case 1:
            SisSettings_05_ch0001();
            break;
        default:
            break;
    }

}

void SisSettings_05_ch0001()
{
    // double temp_vol;
    // GetCurrentPositionVolume(temp_vol);    
    EN_OrderDistance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN);
}