//+------------------------------------------------------------------+
//|                                                        Trend.mq5 |
//|                        Copyright 2018, MetaQuotes Software Corp. |
//|                                                 https://mql5.com |
//+------------------------------------------------------------------+


// enum enum_Moving_Status
// {
//     eMoving_001                = 1,
//     eMoving_002                = 2   
// };




// int Set_Moving_Status_Settings(int chosen)
// {
//     switch(chosen)
//     {
//         case eMoving_001:
//             return EST_Moving_001();
//             break;            
//     }
//     return 0;    
// }



// int EST_Moving_001()
// {
    
//     // neutro.
    
//     if(// subindo e comprado
//         CurrentTrend == 1
//         && pos_status == 0 
//         )
//     {
//        return 1;// CurrentTradingStatus = 1;
//     }
//     else if(// subindo e vendido
//         CurrentTrend ==  1
//         && pos_status == 1 
//         )
//     {
//         return 2; //CurrentTradingStatus = 2;
//     }
//     else if(// caindo e comprado
//         CurrentTrend == -1
//         && pos_status == 0
//         )
//     {
//         return 3; //CurrentTradingStatus = 3;

//     }
//     else if(// caindo e vendido
//         CurrentTrend == -1
//         && pos_status == 1
//         ) 
//     {
//         return 4; //CurrentTradingStatus = 4;
//     }

//     return 0;
// }
