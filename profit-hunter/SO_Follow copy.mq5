


//todo 
// trap (bar, range, wave)
// break (bar, range, wave)
// bar pattern 
// médias (cross, etc) 
// bollinger
// divergencia de osciladores

double SO_FOLLOW_CURR_BOTTOM_LEVEL = 0;
double SO_FOLLOW_CURR_TOP_LEVEL = 0;

double SO_FOLLOW_LAST_POSITION_VOL_BALANCE = 0;


void SO_Follow_Controller(int callFrom)
{
    SYS_TRAILING_STOP_PERMITION = false;

    SELECTED_EST_EN_DISTANCE_CHOSEN     = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN       = INPUT_EN_EST_VOLUME_CHOSEN;

    LONG_CONDITIONS = false;
    SHORT_CONDITIONS = false;    
    
    switch(SELECTED_VER) // Version
    {
        case 1:
            switch(callFrom)
            {
                case eCallFrom_OnTick: // onTick
                    Sys_Follow_4_v1(); 
                    break;
                case 10: // buy
                    break;
                case 20: // sell
                    break;
                case 100: // TP
                    break;
                case 200: // SL
                    break;                                    
            }
            break;

        case 2:
            switch(callFrom)
            {
                case eCallFrom_OnTick: // onTick
                    Sys_Follow_o4_v1b_m21(); 
                    break;                                  
            }
            break;         

        case 3:
            switch(callFrom)
            {
                case eCallFrom_OnTick: // onTick
                    //CheckNewLevel(); 
                    CheckNewLevelFish(); 
                    break;                                  
            }
            break;               

    }
   

}


void SO_Follow_ResetVars()
{
    SO_FOLLOW_CURR_BOTTOM_LEVEL = 0;
    SO_FOLLOW_CURR_TOP_LEVEL = 0;
}

void SO_Follow_InitLevels()
{
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)// || SO_FOLLOW_CURR_TOP_LEVEL > ((SERVER_SYMBOL_BID + EN_Distance_Short) + MIN_ADD_DISTANCE))
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)// || SO_FOLLOW_CURR_BOTTOM_LEVEL < ((SERVER_SYMBOL_ASK - EN_Distance_Short) + MIN_ADD_DISTANCE)) 
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    }
}

void SO_Follow_ChangeLevels()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(!BREAK_MODE)
    {
        if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
        {
            // atualiza o novo nível de referência
            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            
            // cancela a ordem anterior pois uma nova deverá ser inserida
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");
        }
        
        
        //-- empurra a ordem de venda acompanhando a mínima do preço
        if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
        {
            // atualiza o novo nível de referência
            SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            
            // cancela a ordem anterior pois uma nova deverá ser inserida
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }
    }

}


void SO_Follow_Enforce_Condition()
{
    // não permite ficar sem ordem
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT,_Symbol) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
            Print("Enforce_Condition");
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    {
        if(SHORT_CONDITIONS == false)
        {
            SHORT_CONDITIONS = true;
            TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
            Print("Enforce_Condition");
        }
    }
}

void Sys_Follow_O4_Y1_v03_11_original()
{
    //Print("Sys_Follow_O4_Y1_v03_1");
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
    }
    
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0) 
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
    }
	
    
    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }

    SO_Follow_Enforce_Condition();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void Sys_Follow_4_v1()
{
    //Print("Sys_Follow_O4_Y1_v03_1");
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    

    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)// || SO_FOLLOW_CURR_TOP_LEVEL > ((SERVER_SYMBOL_BID + EN_Distance_Short) + MIN_ADD_DISTANCE))
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
    }
    
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)// || SO_FOLLOW_CURR_BOTTOM_LEVEL < ((SERVER_SYMBOL_ASK - EN_Distance_Short) + MIN_ADD_DISTANCE)) 
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
    }



    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }

    SO_Follow_Enforce_Condition();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Adaptive_Add;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void Sys_Follow_4_v2()
{

    SO_Follow_InitLevels();
    SO_Follow_ChangeLevels();

    SO_Follow_Enforce_Condition();

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Adaptive_Add;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    //SELECTED_EST_VOLUME_CHOSEN = INPUT_EN_EST_VOLUME_CHOSEN;
    Set_EN_OrdersVolume__Relief();
    
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    
    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void Sys_Follow_o4_v1b_m21_old()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    BREAK_MODE = true;

    //Print("Sys_Follow_O4_Y1_v03_1");

    
    SO_Follow_InitLevels();
    
    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        //TEMP_EN_SHORT_VALUE  -= SELECTED_EN_DISTANCE_SHORT_VALUE; 
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }
    else
    {
        TEMP_EN_SHORT_VALUE  = LAST_PLACED_FINAL_EN_SHORT_VALUE; 
    }
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_ASK;
        LONG_CONDITIONS = true;
        //TEMP_EN_LONG_VALUE  += SELECTED_EN_DISTANCE_LONG_VALUE;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
    }
    else
    {
        TEMP_EN_LONG_VALUE  = LAST_PLACED_FINAL_EN_LONG_VALUE;
    }

    SO_Follow_Enforce_Condition_Break();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    Set_EN_OrdersVolume__Reverse();


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void Sys_Follow_o4_v1b_m21()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    BREAK_MODE = true;

    SO_Follow_InitLevels();
    
    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        TEMP_EN_SHORT_VALUE  -= SELECTED_EN_DISTANCE_SHORT_VALUE; 
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }
    else
    {
        TEMP_EN_SHORT_VALUE  = LAST_PLACED_FINAL_EN_SHORT_VALUE; 
    }
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_ASK;
        LONG_CONDITIONS = true;
        TEMP_EN_LONG_VALUE  += SELECTED_EN_DISTANCE_LONG_VALUE;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
    }
    else
    {
        TEMP_EN_LONG_VALUE  = LAST_PLACED_FINAL_EN_LONG_VALUE;
    }

    SO_Follow_Enforce_Condition_Break();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    Set_EN_OrdersVolume__Reverse();


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  
      
}

void SO_Follow_Enforce_Condition_Break_Bug()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT,_Symbol) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        //if(LONG_CONDITIONS == false && pos_status != 1)
        if(SHORT_CONDITIONS == false)
        {

            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_BID;
            
            // cancela a ordem anterior pois uma nova deverá ser inserida
            TEMP_EN_SHORT_VALUE  -= SELECTED_EN_DISTANCE_SHORT_VALUE; 
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            Print("Enforce_Condition");
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    {
        if(LONG_CONDITIONS == false )
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_ASK;
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE  += SELECTED_EN_DISTANCE_LONG_VALUE;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            Print("Enforce_Condition");
        }
    }    

}

void SO_Follow_Enforce_Condition_Break()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT,_Symbol) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        //if(LONG_CONDITIONS == false && pos_status != 1)
        if(SHORT_CONDITIONS == false)
        {
            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;

            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_BID;
            
            // cancela a ordem anterior pois uma nova deverá ser inserida
            TEMP_EN_SHORT_VALUE  -= SELECTED_EN_DISTANCE_SHORT_VALUE; 
            //SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            Print("Enforce_Condition");
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    {
        if(LONG_CONDITIONS == false )
        //if(LONG_CONDITIONS == false && pos_status != 1)
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_ASK;
            //LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE  += SELECTED_EN_DISTANCE_LONG_VALUE;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            Print("Enforce_Condition");
        }
    }    

}
void Flip()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    SO_Follow_InitLevels();
    
    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        TEMP_EN_SHORT_VALUE  -= SELECTED_EN_DISTANCE_SHORT_VALUE; 
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
    }
    else
    {
        TEMP_EN_SHORT_VALUE  = LAST_PLACED_FINAL_EN_SHORT_VALUE; 
    }
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_ASK;
        LONG_CONDITIONS = true;
        TEMP_EN_LONG_VALUE  += SELECTED_EN_DISTANCE_LONG_VALUE;
        CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
    }
    else
    {
        TEMP_EN_LONG_VALUE  = LAST_PLACED_FINAL_EN_LONG_VALUE;
    }
}





void CheckNewLevel()
{
    BREAK_MODE = true;
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);


    SO_Follow_InitLevels();


    if(BREAK_MODE)
    {
        if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL  + EN_Distance_Long)) //SELECTED_EN_DISTANCE_LONG_VALUE
        {
            SO_FOLLOW_CURR_TOP_LEVEL = (SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop = true;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeTop =  false;
        }
    
        if(SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL  - EN_Distance_Short)) //SELECTED_EN_DISTANCE_LONG_VALUE
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            changeBottom = true;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeBottom = false;
        }
   
        if(changeTop)
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SO_FOLLOW_CURR_TOP_LEVEL - EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            changeBottom = true;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");            
        }

        if(changeBottom)
        {
            SO_FOLLOW_CURR_TOP_LEVEL = (SO_FOLLOW_CURR_BOTTOM_LEVEL + EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop =  true;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");         
        }   
   
   
    }

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    //Set_EN_OrdersVolume__Reverse();


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  




}


void CheckNewLevelFish()
{
    BREAK_MODE = false;
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);


    SO_Follow_InitLevels();


    if(!BREAK_MODE)
    {
        if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Short)) //SELECTED_EN_DISTANCE_LONG_VALUE
        {
            SO_FOLLOW_CURR_TOP_LEVEL = (SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop = true;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeTop =  false;
        }
    
        if(SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Long)) //SELECTED_EN_DISTANCE_LONG_VALUE
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeBottom = true;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeBottom = false;
        }
   
        if(changeTop)
        {
            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SO_FOLLOW_CURR_TOP_LEVEL - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            changeBottom = true;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");         
        }

        if(changeBottom)
        {
            SO_FOLLOW_CURR_TOP_LEVEL = (SO_FOLLOW_CURR_BOTTOM_LEVEL + EN_Distance_Long);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop =  true;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");            
        }   
   
   
    }

    SO_Follow_Enforce_Condition();


    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    //SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
    //Set_EN_OrdersVolume__Reverse();


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  

}


void Sys_Follow_4_v3_m11()
{

    BREAK_MODE = false;
    SO_Follow_InitLevels();


    SO_Follow_ChangeLevels_v2();
    //SO_Follow_Enforce_Condition();

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    
    
    Set_EN_OrdersVolume__Relief();
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;


    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN);
    PlaceOrders(0);  




}


void SO_Follow_ChangeLevels_v2()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);



    if(!BREAK_MODE)
    {
        if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL)) //vendeu (nova ordem de venda)
        {
            SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop = true;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeTop =  false;
        }
    
        if(SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL)) //comprou (nova ordem de compra)
        {

            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            changeBottom = true;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
        }
        else
        {
            changeBottom = false;
        }
   
        if(changeTop)
        {
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");         
            SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            LONG_CONDITIONS = true;
        }

        if(changeBottom)
        {
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");            
            SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            SHORT_CONDITIONS = true;
        }   
    }

   



/*
    if(!BREAK_MODE)
    {
        if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL)) //vendeu (nova ordem de venda)
        {
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID; //(SERVER_SYMBOL_ASK + EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            changeTop = true;
            SHORT_CONDITIONS = true;
        }
        else
        {
            changeTop =  false;
        }
    
        if(SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL)) //comprou (nova ordem de compra)
        {

            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");
            SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;// (SERVER_SYMBOL_BID - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            changeBottom = true;
            LONG_CONDITIONS = true;
        }
        else
        {
            changeBottom = false;
        }
   
        if(changeTop)
        {
            CancelBuyOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");         
            SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK; //SERVER_SYMBOL_BID;// (SERVER_SYMBOL_BID - EN_Distance_Long);
            TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            LONG_CONDITIONS = true;
        }

        if(changeBottom)
        {
            CancelSellOrders(_Symbol, "Sys_Follow_O4_Y1_v03_1");            
            SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;// SERVER_SYMBOL_ASK;// (SERVER_SYMBOL_ASK + EN_Distance_Short);
            TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            SHORT_CONDITIONS = true;
        }   
    }
*/




}