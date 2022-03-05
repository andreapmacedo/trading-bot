

void TP_OrderAnchor_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 10:  // Distância por sequencia
           // TP_STR_Anchor_10();
        case 101:  
            TP_STR_Anchor_101();
            break;
        case 201:  
            TP_STR_Anchor_201();
            break;

    }
}

void TP_STR_Anchor_101()
{
    Level_tp_long = PriceInfo[1].high;
    Level_tp_short = PriceInfo[1].low;    
}
void TP_STR_Anchor_201()
{
    Level_tp_long = PriceInfo[1].low;
    Level_tp_short = PriceInfo[1].high;    
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