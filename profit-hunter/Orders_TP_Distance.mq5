

void TP_OrderDistance_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 1:
            TP_STR_Distance_1();
            break;
        case 201:
            TP_STR_Distance_201(); 
            break;
    }

}

void TP_STR_Distance_1()
{
    Level_tp_long += TP_Distance_Long;
    Level_tp_short -= TP_Distance_Short;
}
void TP_STR_Distance_201()
{
    // Level_tp_long += TP_Distance_Long;
    // Level_tp_short -= TP_Distance_Short;
}
