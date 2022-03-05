#include "SO_Trading_Floor_Settings.mq5"

#include "SO_Trading_Floor.mq5"
#include "SO_Signal.mq5"
#include "SO_Break_Bar.mq5"
#include "SO_Trap_Bar.mq5"


void SO_NewTradingFloor(int callFrom)
{


    int response = 0;

    //Sys_Spread_Reset_Vars();
    
    switch(SELECTED_VER) // Version
    {                                                                                                                                                                                                                                                       
        case 0:
            SO_Signal(callFrom);                               
        case 1:
            SO_Signal(callFrom);                               
            break;                                                                
        case 2:
            SO_Range(callFrom);                                
            break;                                                                
        case 3:
            SO_Break_Bar(callFrom);                                
            break;                                                                
        case 4:
            SO_Trap_Bar(callFrom);                                
            break;                                                                
        // case 62:
        //     Sys_Follow_6_2(callFrom);                                
        //     break;                                                                                                                               
    }
}



// // o simples fato de uma nova vela já é um signal
// void SO_NewTradingFloor(int callFrom)
// {
  
//     switch(callFrom)
//     {
//         case 1: // NewBar   
//             //Print("callFrom ->", callFrom);
//             switch(SELECTED_SYS)
//             {
//                 case 1:
//                     Print("SO_Range");
//                     SO_Range(callFrom);
//                     break;        
//                 case 2:
//                     Print("SO_MA_Floor");
//                     //SO_MA_Floor(callFrom);
//                     break;        
//                 case 3:
//                     //Print("SO_Bar_To_Bar");
//                     SO_Bar_To_Bar(callFrom);
//                     break;
//                 case 4:
//                     SO_Break(callFrom);
//                     break;                    
//             }     
//             break;

//         case eCallFrom_OnTick: // OnTick
//             //Print("SO_NewTradingFloor");
//             break;
//         case 10: // buy
//             break;
//         case 20: // sell
//             break;
//         case 100: // TP
//             break;
//         case 200: // SL
//             break;
//         default:
//             Print("def");
//             break;                                                 
//     }      
// }



void SO_Trap(int callFrom)
{
    SYS_TRAILING_STOP_PERMITION = true;

    SELECTED_EST_EN_ANCHOR_CHOSEN            = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN         = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN           = INPUT_EN_EST_VOLUME_CHOSEN;


    CancelAllThisSymbolOrders();

    //SELECTED_EST_SL_ANCHOR_CHOSEN         = INPUT_SL_EST_ANCHOR_CHOSEN;
    //SELECTED_EST_SL_DISTANCE_CHOSEN      = INPUT_SL_EST_DISTANCE_CHOSEN; 

    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    


    // switch(SELECTED_SYS)
    // {
    //     case 1:
    //         Sys_TrapBar(callFrom);
    //         //trap_bar, trap_range, trap wave;
    //         break;
    //     default:
    //         Print("def");
    //         break;            
    // }    


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN); 

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;


    PlaceOrders(0);     

}

void Sys_TrapBar(int callFrom)
{
   // SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_Trap_Level;
    
    SELECTED_EST_TP_ANCHOR_CHOSEN         = eOrLevel_TP_X_BarLevel;//INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_TP_DISTANCE_CHOSEN      = eOrDistance_EN_Pts;//INPUT_TP_EST_DISTANCE_CHOSEN;     
    
    
    SELECTED_EST_SL_ANCHOR_CHOSEN         = eOrLevel_TP_X_BarLevel;//INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_SL_DISTANCE_CHOSEN      = eOrDistance_EN_Pts;//INPUT_TP_EST_DISTANCE_CHOSEN;     

    Print("Sys_TrapBar");
}

void Sys_TrapRange(int callFrom)
{

}

void Sys_TrapWave(int callFrom)
{

}

// montar sistema de confirmação de sinal (trap confirmado)


void SO_Break(int callFrom)
{
    SYS_TRAILING_STOP_PERMITION = true;

    SELECTED_EST_EN_ANCHOR_CHOSEN        = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN     = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN       = INPUT_EN_EST_VOLUME_CHOSEN;
    
    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    


    // switch(SELECTED_SYS)
    // {
    //     case 1:
    //         Sys_BreakBar(callFrom);
    //         break;
    //     default:
    //         Print("def");
    //         break;            
    // }    


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN); 

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;

    CancelAllThisSymbolOrders();

    PlaceOrders(0);     

}

void Sys_BreakBar(int callFrom)
{
    //SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_Last_Bar_HL;
}

void Sys_BreakRange(int callFrom)
{

}

void Sys_BreakWave(int callFrom)
{

}





//---------------------------------------------------------------//-------------------------------------------------






void SO_CandlePattern_001(int callFrom)
{
    SYS_TRAILING_STOP_PERMITION = true;
    Print("call from ->", callFrom);
    
    // Variáveis de entrada (INPUT) não podem ser alteradas via código portanto devem ser atribuidas a novas varíaveis
    // passíveis de manipulação pelo SO que terá prioridade hieraquica 
    SELECTED_EST_EN_ANCHOR_CHOSEN        = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN     = INPUT_EN_EST_DISTANCE_CHOSEN; //(4)
    SELECTED_EST_VOLUME_CHOSEN       = INPUT_EN_EST_VOLUME_CHOSEN;
    
    LONG_CONDITIONS = false;
    SHORT_CONDITIONS = false;    
    
    if(callFrom == 1) // onTick
    {


    }

    if(callFrom == 2) // onTick
    {
        // verificações de condução do trade (trailing stop...)


    }


    else if(callFrom == 10 ) // buy
    {

    }
    else if(callFrom == 20 ) // sell
    {
        
       
    }
    else if(callFrom == 100) // tp
    {

    }
    else if(callFrom == 200)
    {
        
    }
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);     

}




void InsideBar()
{

}
