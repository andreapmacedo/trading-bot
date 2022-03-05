

void SL_OrderAnchor_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 101:  
            SL_STR_Anchor_101();
            break;
        case 201:  
            SL_STR_Anchor_201();
            break;

    }
}

void SL_STR_Anchor_101()
{
    Level_sl_long = CurrentLevelBuy; 
    Level_sl_short = CurrentLevelSell;
}
void SL_STR_Anchor_201()
{
    Level_sl_long = CurrentLevelBuy; 
    Level_sl_short = CurrentLevelSell;
}

//+------------------------------------------------------------------+
// Distância por sequência
//+------------------------------------------------------------------+

// void EstENOrerDst_10() 
// {
//     double adj_end_seq;
//     SetAdjDstSeqEnd(adj_end_seq);
    
//     if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
//     {
//         double range;
//         if(Current_Buy_Seq <= adj_end_seq)
//         {
//             range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
//         }
//         else if(Current_Buy_Seq > adj_end_seq)
//         {
//             range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
//         }

//         SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
//     }
//     else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
//     {
//         double range;
//         if( Current_Sell_Seq <= adj_end_seq)
//         {
//             range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
//         }
//         else if(Current_Sell_Seq > adj_end_seq)
//         {
//             range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
//         }
//         SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
//     }
// }