
// o signal vai ser identificado por um fechamento de vela, novo tick, tempo etc( ou seja, será chamado pelo so_settings)
// a ordem ou comando de exec. ficará vigente apenas enquanto o sinal estiver válido

int SO_Signal(int callFrom)
{

    // Atribuições de todas as chamadas

    // Atribuições específicas 
    switch(callFrom) 
    {
        case 1:
            break; 
        case 2:
            break;                                          
        case 3:
            break; 
    }



    if(SELECTED_EN_MODE == 1)
    {
        Set_Place_Order_Dev();
        return 2;
    }

    if(SELECTED_EN_MODE == 2)
    {
        Set_Trigger_Order_Dev();
    }
    
    return 0;








}




/*

void SO_Trap(int callFrom)
{
    SYS_TRAILING_STOP_PERMITION = true;

    SELECTED_EST_EN_ANCHOR_CHOSEN         = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN      = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN           = INPUT_EN_EST_VOLUME_CHOSEN;


    CancelAllThisSymbolOrders();

    //SELECTED_EST_SL_ANCHOR_CHOSEN         = INPUT_SL_EST_ANCHOR_CHOSEN;
    //SELECTED_EST_SL_DISTANCE_CHOSEN      = INPUT_SL_EST_DISTANCE_CHOSEN; 

    LONG_CONDITIONS = true;
    SHORT_CONDITIONS = true;    


    switch(SELECTED_SYS)
    {
        case 1:
            Sys_TrapBar(callFrom);
            //trap_bar, trap_range, trap wave;
            break;
        default:
            Print("def");
            break;            
    }    


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN); 

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;


    PlaceOrders(0);     

}

void Sys_TrapBar(int callFrom)
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_Trap_Level;
    
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


    switch(SELECTED_SYS)
    {
        case 1:
            Sys_BreakBar(callFrom);
            break;
        default:
            Print("def");
            break;            
    }    


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN); 

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_STOP;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_STOP;

    CancelAllThisSymbolOrders();

    PlaceOrders(0);     

}

void Sys_BreakBar(int callFrom)
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_Last_Bar_HL;
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
*/