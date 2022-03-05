


//todo 
// trap (bar, range, wave)
// break (bar, range, wave)
// bar pattern 
// médias (cross, etc) 
// bollinger
// divergencia de osciladores

double SO_FOLLOW_CURR_BOTTOM_LEVEL = 0;
double SO_FOLLOW_CURR_TOP_LEVEL = 0;
double SO_FOLLOW_LAST_BOTTOM_LEVEL = 0;
double SO_FOLLOW_LAST_TOP_LEVEL = 0;

double SO_FOLLOW_CURR_SPREAD_ORDERS = 0;
double SO_FOLLOW_LAST_POSITION_VOL_BALANCE = 0;

bool changeTop = false;
bool changeBottom = false;

double LongDist = 0;
double ShortDist = 0;

bool needEnforceBuy = true;
bool needEnforceSell = true;


void SO_Follow_EN_Essential_Lock()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
}


void SO_Follow_EN_Full_Free()
{
    SO_Follow_EN_Essential_Lock();
    SELECTED_EST_EN_DISTANCE_CHOSEN = INPUT_EN_EST_DISTANCE_CHOSEN;
    SELECTED_EST_VOLUME_CHOSEN = INPUT_EN_EST_VOLUME_CHOSEN;
}

void SO_Follow_EN_Full_Default()
{
    SO_Follow_EN_Essential_Lock();
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Default;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;
}

void SO_Follow_EN_Full_System()
{
    SO_Follow_EN_Essential_Lock();
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
}


void SO_Follow_EN_Full_Lock()
{
    SO_Follow_EN_Essential_Lock();
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Pts;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;
}


void SO_Follow_ResetVars()
{
    SO_FOLLOW_CURR_TOP_LEVEL = 0;
    SO_FOLLOW_CURR_BOTTOM_LEVEL = 0;

    SO_FOLLOW_LAST_BOTTOM_LEVEL = 0;
    SO_FOLLOW_LAST_TOP_LEVEL = 0;


    SO_FOLLOW_CURR_SPREAD_ORDERS = 0;
}

void SO_Follow_InitLevels()
{
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        //SO_FOLLOW_CURR_TOP_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        SO_FOLLOW_CURR_TOP_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
        //SO_FOLLOW_LAST_TOP_LEVEL = SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Short;

    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        //SO_FOLLOW_CURR_BOTTOM_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      //  SO_FOLLOW_LAST_BOTTOM_LEVEL = SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Long;
    }

    //SO_FOLLOW_CURR_SPREAD_ORDERS = SO_FOLLOW_CURR_TOP_LEVEL - SO_FOLLOW_CURR_BOTTOM_LEVEL;

}


void SO_Follow_BasicChangeLevel()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    changeBottom = false;
    changeBottom = false;

    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "SO_Follow_BasicChangeLevel");
        changeTop =  true;
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "SO_Follow_BasicChangeLevel");
        changeBottom = true;
    }    
}



void SO_Follow_BasicChangeLevel_ev()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SetNewTop(); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SetNewBottom(); // empurra o bottom
    }  

}



void SO_Follow_BasicChangeLevel_Pro()
{

    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    double leve_ref_top;
    double leve_ref_bottom;

    if(last_deal > 0)
    {
        leve_ref_top = last_deal;
        leve_ref_bottom = last_deal;
    }
    else
    {
       // leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
       // leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    }

    if(leve_ref_top > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
    
        SetNewTop2(leve_ref_top); // puxa o long pra cima
   
    }
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(leve_ref_bottom < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
    
        SetNewBottom2(leve_ref_bottom); // empurra o bottom
    }  
}

void SO_Follow_InitLevels_Pro()
{

    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    double leve_ref_top;
    double leve_ref_bottom;

    if(last_deal > 0)
    {
        leve_ref_top = last_deal;
        leve_ref_bottom = last_deal;
    }
    else
    {
//        leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
//        leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    }   


    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {

        SetNewBottom();
    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        SetNewTop(); 
    }
}

void SO_Follow_Enforce_Condition_Pro()
{
    Print("SO_4_Enforce_Condition_v_pr0.21x");
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    double leve_ref_top;
    double leve_ref_bottom;

    if(last_deal > 0)
    {
        leve_ref_top = last_deal;
        leve_ref_bottom = last_deal;
    }
    else
    {
       // leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
       // leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_top = SymbolInfoDouble(_Symbol, SYMBOL_BID);
        leve_ref_bottom = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    }
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            SetNewTop2(leve_ref_top);
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SetNewBottom2(leve_ref_bottom);
        } 
    }
}






void SetNewBottom()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   // changeBottom = false;
    //changeBottom = false;

    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
    TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow_BasicChangeLevel");
   // changeBottom = true;
}
void SetNewTop()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   // changeBottom = false;
   // changeBottom = false;

    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
    TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow_BasicChangeLevel");
   // changeTop =  true;
}


void SetNewBottom_Pro()
{
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    double leve_ref;
    if(last_deal > 0)
    {

        leve_ref = last_deal;
    }
    else
    {
        leve_ref = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    }

    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_BOTTOM_LEVEL = leve_ref;
    TEMP_EN_SHORT_VALUE = leve_ref;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow_BasicChangeLevel");
   // changeBottom = true;
}
void SetNewTop_Pro()
{
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    double leve_ref;
    if(last_deal > 0)
    {

        leve_ref = last_deal;
    }
    else
    {
        leve_ref = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    }

    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_TOP_LEVEL = leve_ref;
    TEMP_EN_LONG_VALUE = leve_ref;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow_BasicChangeLevel");
   // changeTop =  true;
}

void SO_Follow_Enforce_Condition_ev()
{
    Print("Enforce_Condition_ev");
    // não permite ficar sem ordem
  
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            SetNewTop();
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SetNewBottom();
        } 
    }
}

void SO_Follow_Enforce_Condition()
{
    Print("Enforce_Condition");
    // não permite ficar sem ordem
  
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            //SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
            Print("Enforce_Condition LONG");
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SHORT_CONDITIONS = true;
            TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            //SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
            Print("Enforce_Condition SHORT");
        } 
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



void SO_Follow_ChangeLevels_Vx()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    checkDist();

    if(!BREAK_MODE)
    {
        if(topo_puxou()) // AJUSTAR O LONG
        {
            //Print("topo_puxou");
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            //TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
        }

        if(fundo_puxou()) // AJUSTAR O SHORT
        {
           // Print("fundo_puxou");
            //TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }

        if(fundo_atualizou())
        {
            //Print("fundo_atualizou");
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
        }
        if(topo_atualizou()) 
        {
            //Print("topo_atualizou");
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }
    }
}

void SO_Follow_ChangeLevels_Vw()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    checkDist();

    if(!BREAK_MODE)
    {
        if(topo_puxou()) // AJUSTAR O LONG
        {
            //Print("topo_puxou");
            //TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
        }

        if(fundo_puxou()) // AJUSTAR O SHORT
        {
           // Print("fundo_puxou");
            //TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }
        
        if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
        {
            if(fundo_atualizou())
            {
               // Print("fundo_atualizou");
                TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
                LONG_CONDITIONS = true;
                CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
            }
            if(topo_atualizou()) 
            {
               // Print("topo_atualizou");
                TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
                SHORT_CONDITIONS = true;
                CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
            }
        }
    }
}



void SO_Follow_ChangeLevels_Vz()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    //checkDist();

    if(!BREAK_MODE)
    {
        if(topo_puxou()) // AJUSTAR O LONG
        {
            //Print("topo_puxou");
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            //TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
        }

        if(fundo_puxou()) // AJUSTAR O SHORT
        {
            //Print("fundo_puxou");
            //TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }

        if(fundo_atualizou())
        {
           // Print("fundo_atualizou");
            TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
            LONG_CONDITIONS = true;
            CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");   
        }
        if(topo_atualizou()) 
        {
           // Print("topo_atualizou");
            TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
            SHORT_CONDITIONS = true;
            CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");
        }
    }
}


// MIN_ADD_DISTANCE
void checkDist()
{
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    
    LongDist = (SERVER_SYMBOL_BID - LAST_PLACED_FINAL_EN_LONG_VALUE);
    ShortDist = (LAST_PLACED_FINAL_EN_SHORT_VALUE - SERVER_SYMBOL_ASK);    

    

    if(MIN_ADD_DISTANCE > 0)
    {
        if(LongDist > (EN_Distance_Long + MIN_ADD_DISTANCE))
        {
                //Print("LongDist ATUALIZOU");
                TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
                LONG_CONDITIONS = true;
                CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");           
        }
        if(ShortDist > (EN_Distance_Short + MIN_ADD_DISTANCE))
        {
               // Print("ShortDist ATUALIZOU");
                TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
                SHORT_CONDITIONS = true;
                CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");      
        }       
    }
    else
    {   
        if(LongDist > (EN_Distance_Long))
        {
                //Print("LongDist ATUALIZOU");
                TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
                LONG_CONDITIONS = true;
                CancelBuyOrders(_Symbol, "SO_Follow_ChangeLevels");           
        }
        if(ShortDist > (EN_Distance_Short))
        {
                //Print("ShortDist ATUALIZOU");
                TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
                SHORT_CONDITIONS = true;
                CancelSellOrders(_Symbol, "SO_Follow_ChangeLevels");      
        }
    }
}

bool topo_puxou()
{
    bool response = false;
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) 
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        response = true;
    }
    return response;
}

bool fundo_puxou()
{

    bool response = false;
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL) 
    {
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        response = true;
    }
    return response;
}

bool fundo_atualizou()
{  
    bool response = false;
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    if(SERVER_SYMBOL_ASK < LAST_PLACED_FINAL_EN_LONG_VALUE && LAST_PLACED_FINAL_EN_LONG_VALUE > 0) 
    {
        //SO_FOLLOW_LAST_BOTTOM_LEVEL = SO_FOLLOW_CURR_BOTTOM_LEVEL - EN_Distance_Long;
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        response = true;
    }
    return response;
}

bool topo_atualizou()
{
    bool response = false;
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   
    if(SERVER_SYMBOL_BID > LAST_PLACED_FINAL_EN_SHORT_VALUE && LAST_PLACED_FINAL_EN_SHORT_VALUE > 0) 
    //if(SO_FOLLOW_CURR_TOP_LEVEL > SO_FOLLOW_LAST_TOP_LEVEL) 
    {
      //  SO_FOLLOW_LAST_TOP_LEVEL = SO_FOLLOW_CURR_TOP_LEVEL + EN_Distance_Short;
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        
        response = true;
    }
    return response;
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
            CancelSellOrders(_Symbol, "SERVER_SYMBOL_BID > x ");
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
            CancelBuyOrders(_Symbol, "SERVER_SYMBOL_ASK < x ");
        }
        else
        {
            changeBottom = false;
        }
   

        
        //if(!(PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
        //{        
            if(changeTop)
            {
                CancelBuyOrders(_Symbol, "changeTop");         
                SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
                TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
                LONG_CONDITIONS = true;
            }

            if(changeBottom)
            {
                CancelSellOrders(_Symbol, "changeBottom");            
                SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
                TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
                SHORT_CONDITIONS = true;
            }   
        //}
        
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
void SO_Follow_Enforce_Original()
{
    // não permite ficar sem ordem
  
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0)  
    {
        if(LONG_CONDITIONS == false)
        {
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
            Print("Enforce_Condition LONG");
        }
    }
  
  
    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SHORT_CONDITIONS = true;
            TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
            Print("Enforce_Condition SHORT");
        } 
    }
}






void SO_Follow_Enforce_Condition_2()
{
    // não permite ficar sem ordem


    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0)  
    {
        if(needEnforceBuy)
        {
            if(LONG_CONDITIONS == false)
            {
                LONG_CONDITIONS = true;
                TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
                SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
                Print("Enforce_Condition LONG");
            }
            needEnforceBuy = false;
        }

    }
    else
    {
        needEnforceBuy = true;
    }




    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    { 
        if(needEnforceSell)
        {
            if(SHORT_CONDITIONS == false)
            {
                SHORT_CONDITIONS = true;
                TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
                SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
                Print("Enforce_Condition SHORT");
            } 
            needEnforceSell = false;
        }       
    }
    else
    {
        needEnforceSell = true;
    }
}

void SO_Follow_Enforce_Condition_Evo()
{

    if(MyGetPosition() == 1 && (PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {       
        SO_Follow_Enforce_Condition_Short();
        //SO_Follow_Enforce_Condition_Short_t();
    }
    else if(MyGetPosition() == (-1) && (PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        SO_Follow_Enforce_Condition_Long();
        //SO_Follow_Enforce_Condition_Long_t();
    }
    else
    {

        if(!SELECTED_BUY_FIRST)
        {
            SO_Follow_Enforce_Condition_Short();
            //SO_Follow_Enforce_Condition_Short_t();
        }




        if(!SELECTED_SELL_FIRST)
        {
            //SO_Follow_Enforce_Condition_Long_t();
            SO_Follow_Enforce_Condition_Long();
        }
    }
}

void SO_Follow_Enforce_Condition_Evo_2()
{

    if(MyGetPosition() == 1 && (PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {       
        //SO_Follow_Enforce_Condition_Short();
        SO_Follow_Enforce_Condition_Short_t();
    }
    else if(MyGetPosition() == (-1) && (PositionGetDouble(POSITION_VOLUME) >= FINAL_LIMIT_POSITION_VOLUME))
    {
        //SO_Follow_Enforce_Condition_Long();
        SO_Follow_Enforce_Condition_Long_t();
    }
    else
    {

        if(!SELECTED_BUY_FIRST)
        {
            //SO_Follow_Enforce_Condition_Short();
            SO_Follow_Enforce_Condition_Short_t();
        }




        if(!SELECTED_SELL_FIRST)
        {
            SO_Follow_Enforce_Condition_Long_t();
            //SO_Follow_Enforce_Condition_Long();
        }
    }
}


void SO_Follow_Enforce_Condition_Short()
{
    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    { 
        if(needEnforceSell)
        {
            if(SHORT_CONDITIONS == false)
            {
                SHORT_CONDITIONS = true;
                TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
                SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
                Print("Enforce_Condition SHORT");
            } 
            needEnforceSell = false;
        }       
    }
    else
    {
        needEnforceSell = true;
    }
}

void SO_Follow_Enforce_Condition_Long()
{
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(needEnforceBuy)
        {
            if(LONG_CONDITIONS == false)
            {
                LONG_CONDITIONS = true;
                TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
                SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
                Print("Enforce_Condition LONG");
            }
            needEnforceBuy = false;
        }

    }
    else
    {
        needEnforceBuy = true;
    }
}

void SO_Follow_Enforce_Condition_Short_t()
{
    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0)
    { 

        if(SHORT_CONDITIONS == false)
        {
            SHORT_CONDITIONS = true;
            TEMP_EN_SHORT_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            SO_FOLLOW_CURR_TOP_LEVEL = TEMP_EN_SHORT_VALUE;
            Print("Enforce_Condition SHORT");
        } 
    }

}

void SO_Follow_Enforce_Condition_Long_t()
{
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {

        if(LONG_CONDITIONS == false)
        {
            LONG_CONDITIONS = true;
            TEMP_EN_LONG_VALUE = SymbolInfoDouble(_Symbol, SYMBOL_BID);
            SO_FOLLOW_CURR_BOTTOM_LEVEL = TEMP_EN_LONG_VALUE;
            Print("Enforce_Condition LONG");
        }
    }

}




void SO_Follow_BasicChangeLevel_2()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    changeBottom = false;
    changeBottom = false;

    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "SO_Follow_BasicChangeLevel");
        changeTop =  true;
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "SO_Follow_BasicChangeLevel");
        changeBottom = true;
    }    
}



void SO_Follow_CheckVolume()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    //-- Puxa a ordem de compra acompanhando a máxima do preço
    if(SERVER_SYMBOL_BID > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "SO_Follow_BasicChangeLevel");
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(SERVER_SYMBOL_ASK < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "SO_Follow_BasicChangeLevel");
    }    
}

void SO_Follow__ChangeTop_v33()
{

    ////double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");    
    changeTop = true;
    SO_Follow__ChangeBottom_v33();
}
void SO_Follow__ChangeBottom_v33()
{
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    ////double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);    

    SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
    TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow__ChangeBottom_v33");
    changeBottom = true;
    SO_Follow__ChangeTop_v33();

}


void SO_Follow_Full_4_3(double last)
{
    SO_FOLLOW_CURR_TOP_LEVEL = (last + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");    

    SO_FOLLOW_CURR_BOTTOM_LEVEL = (last - EN_Distance_Long);
    TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow__ChangeBottom_v33");    
}

void SO_Follow_Set_Top_s3(double level)
{
    SO_FOLLOW_CURR_TOP_LEVEL = (level + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");   
}

void SO_Follow_Set_Bottom_s3(double level)
{
    SO_FOLLOW_CURR_TOP_LEVEL = (level + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");   
}


void SO_Follow_PlaceOrders_v35()
{
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0
     || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0
     || last_deal > SO_FOLLOW_CURR_TOP_LEVEL 
     || last_deal < SO_FOLLOW_CURR_BOTTOM_LEVEL
     || GetCountVolByOrders_BuyType() == 0
     || GetCountVolByOrders_SellType() == 0
        )     
    {
        SO_Follow_Set_Top_s3(last_deal);
        SO_Follow_Set_Bottom_s3(last_deal);
    }  




}


void SO_Follow_PlaceOrders_v36()
{
    double top_level = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double bottom_level = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0
     || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0
     || bottom_level > SO_FOLLOW_CURR_TOP_LEVEL 
     || top_level < SO_FOLLOW_CURR_BOTTOM_LEVEL
     || GetCountVolByOrders_BuyType() == 0
     || GetCountVolByOrders_SellType() == 0
        )     
    {
        SO_Follow_Set_Top_s3(top_level);
        SO_Follow_Set_Bottom_s3(bottom_level);
    }  

}



void SO_Follow_PlaceOrders_v37()
{
    double top_level = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double bottom_level = SymbolInfoDouble(_Symbol, SYMBOL_BID);



    if(
        SO_FOLLOW_CURR_TOP_LEVEL == 0
     || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0
     || bottom_level > SO_FOLLOW_CURR_TOP_LEVEL 
     || top_level < SO_FOLLOW_CURR_BOTTOM_LEVEL
     || GetCountVolByOrders_BuyType() == 0
     || GetCountVolByOrders_SellType() == 0
     )
    {
        SO_Follow_Setter_36(top_level, bottom_level);
    }  




}


void SO_Follow_GetMovies_v124()
{
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);

    double top_level;
    double bottom_level;

    if(last_deal > 0)
    {
        top_level = last_deal;
        bottom_level = last_deal;        
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE > SERVER_SYMBOL_ASK)
        {
            top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        }
        else
        {
            top_level = SERVER_SYMBOL_ASK;
        }
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE < SERVER_SYMBOL_BID)
        {
            bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        }
        else
        {
            bottom_level = SERVER_SYMBOL_BID;
        }        
        
    }
    else
    {
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;            
    }

    //--- init level
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        //SetNewBottom();
        SetNewBottom2(bottom_level); 
    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        //SetNewTop(); 
        SetNewTop2(top_level);
    }

    //--- push/pull
    if(top_level > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        //SetNewTop2(last_deal); // puxa o long pra cima
        SetNewTop2(top_level); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(bottom_level < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        //SetNewBottom2(last_deal); // empurra o bottom
        SetNewBottom2(bottom_level); // empurra o bottom
    }  

    //--- Encforce Confidion
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            //SetNewTop2(last_deal);
            SetNewTop2(top_level);
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            //SetNewBottom2(last_deal);
            SetNewBottom2(bottom_level);
        } 
    }





}


void SO_Follow_PlaceOrders_v38()
{

    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);

    double top_level;
    double bottom_level;

    if(last_deal > 0)
    {
        top_level = last_deal;
        bottom_level = last_deal;        
    }
    else if(DYT_SYMBOL_LAST_DEAL_PRICE > 0)
    {
        
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE > SERVER_SYMBOL_ASK)
        {
            top_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        }
        else
        {
            top_level = SERVER_SYMBOL_ASK;
        }
        
        if(DYT_SYMBOL_LAST_DEAL_PRICE < SERVER_SYMBOL_BID)
        {
            bottom_level = DYT_SYMBOL_LAST_DEAL_PRICE;
        }
        else
        {
            bottom_level = SERVER_SYMBOL_BID;
        }        
        
    }
    else
    {
        top_level = SERVER_SYMBOL_ASK;
        bottom_level = SERVER_SYMBOL_BID;            
    }


    if(
        SO_FOLLOW_CURR_TOP_LEVEL == 0
     || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0
     || bottom_level > SO_FOLLOW_CURR_TOP_LEVEL 
     || top_level < SO_FOLLOW_CURR_BOTTOM_LEVEL
     || GetCountVolByOrders_BuyType() == 0
     || GetCountVolByOrders_SellType() == 0
     )
    {
        SO_Follow_Setter_36(top_level, bottom_level);
    }  

}




void SO_Follow_Setter_36(double top_level, double bottom_level)
{

    SO_FOLLOW_CURR_TOP_LEVEL = (top_level + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow_Setter_36");    

    SO_FOLLOW_CURR_BOTTOM_LEVEL = (bottom_level - EN_Distance_Long);
    TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow_Setter_36");    
}




void SO_Follow_PlaceOrders_v127()
{
    //double top_level = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   // double bottom_level = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);


    if(
        SO_FOLLOW_CURR_TOP_LEVEL == 0
     || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0
     //|| bottom_level > SO_FOLLOW_CURR_TOP_LEVEL 
     //|| top_level < SO_FOLLOW_CURR_BOTTOM_LEVEL
     || GetCountVolByOrders_BuyType() == 0
     || GetCountVolByOrders_SellType() == 0
     )
    {
        SetNewTop2(last_deal); // puxa o long pra cima
        SetNewBottom2(last_deal); // empurra o bottom
    }  
}





void SO_Follow_Update_v127()
{

    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
    if(last_deal > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SetNewTop2(last_deal); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(last_deal < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SetNewBottom2(last_deal); // empurra o bottom
    }  

}



void SO_Follow_InitLevels_V33()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(SO_FOLLOW_CURR_TOP_LEVEL == 0 || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
    SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");    

    SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
    TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow__ChangeBottom_v33");

    }  
}


void SO_Follow_ChangeLevels_v34()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL) || SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL)) //vendeu (nova ordem de venda)
    {
    
    SO_FOLLOW_CURR_TOP_LEVEL = (SERVER_SYMBOL_ASK + EN_Distance_Short);
    TEMP_EN_SHORT_VALUE = SO_FOLLOW_CURR_TOP_LEVEL;
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SO_Follow__ChangeTop_v33");    

    SO_FOLLOW_CURR_BOTTOM_LEVEL = (SERVER_SYMBOL_BID - EN_Distance_Long);
    TEMP_EN_LONG_VALUE = SO_FOLLOW_CURR_BOTTOM_LEVEL;
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SO_Follow__ChangeBottom_v33");
    
    }
}


void SO_Follow_ChangeLevels_v33()
{

    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);

    if(SERVER_SYMBOL_BID > (SO_FOLLOW_CURR_TOP_LEVEL)) //vendeu (nova ordem de venda)
    {

        SO_Follow__ChangeTop_v33();
    }
    else
    {
       // changeTop =  false;
    }

    if(SERVER_SYMBOL_ASK < (SO_FOLLOW_CURR_BOTTOM_LEVEL)) //comprou (nova ordem de compra)
    {
        SO_Follow__ChangeBottom_v33();
    }
    else
    {
       // changeBottom = false;
    }
}

void SO_Follow_ChangeLevels_v3()
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



void SO_Follow_New_Level()
{
    
    //double //SERVER_SYMBOL_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    //double //SERVER_SYMBOL_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    
    if(SERVER_SYMBOL_ASK < LAST_PLACED_FINAL_EN_LONG_VALUE && LAST_PLACED_FINAL_EN_LONG_VALUE > 0)
    {
        SO_FOLLOW_CURR_TOP_LEVEL = SERVER_SYMBOL_BID;
        TEMP_EN_LONG_VALUE = SERVER_SYMBOL_BID;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        LONG_CONDITIONS = true;
        CancelBuyOrders(_Symbol, "SO_Follow_New_Level");
    }
    
    if(SERVER_SYMBOL_BID > LAST_PLACED_FINAL_EN_SHORT_VALUE && LAST_PLACED_FINAL_EN_SHORT_VALUE > 0) 
    {
        // atualiza o novo nível de referência
        SO_FOLLOW_CURR_BOTTOM_LEVEL = SERVER_SYMBOL_ASK;
        TEMP_EN_SHORT_VALUE = SERVER_SYMBOL_ASK;
        
        // cancela a ordem anterior pois uma nova deverá ser inserida
        SHORT_CONDITIONS = true;
        CancelSellOrders(_Symbol, "SO_Follow_New_Level");
    }

}



void SO_Follow_InitLevels_ev()
{
    
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0)
    {
        SetNewBottom();
    }
    if(SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        SetNewTop(); 
    }
}






void SO_Follow_Enforce_Condition_ev2()
{
    //Print("Enforce_Condition_ev");
    // não permite ficar sem ordem
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            SetNewTop2(last_deal);
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            SetNewBottom2(last_deal);
        } 
    }
}



void SO_Follow_BasicChangeLevel_ev2()
{

    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);

    if(last_deal > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SetNewTop2(last_deal); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(last_deal < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SetNewBottom2(last_deal); // empurra o bottom
    }  

}
void SO_Follow_BasicChangeLevel_ev3()
{

    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);

    if(last_deal > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        SetNewTop2(last_deal); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    if(last_deal < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        SetNewBottom2(last_deal); // empurra o bottom
    }  

}



void SetNewBottom2(double last)
{
    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_BOTTOM_LEVEL = last;
    TEMP_EN_SHORT_VALUE = last;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    SHORT_CONDITIONS = true;
    CancelSellOrders(_Symbol, "SetNewBottom2");
   // changeBottom = true;
}
void SetNewTop2(double last)
{


    // atualiza o novo nível de referência
    SO_FOLLOW_CURR_TOP_LEVEL = last;
    TEMP_EN_LONG_VALUE = last;
    
    // cancela a ordem anterior pois uma nova deverá ser inserida
    LONG_CONDITIONS = true;
    CancelBuyOrders(_Symbol, "SetNewTop2");
   // changeTop =  true;
}

void SO_Follow_Setter()
{
    Print("SO_Follow_Setter");
    // não permite ficar sem ordem
    double last_deal = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST), 0);
  

    SetNewTop2(last_deal);
    SetNewBottom2(last_deal);
}


void SO_Follow_Setter_Forex()
{
    Print("SO_Follow_Setter_Forex");

    SetNewTop2(SymbolInfoDouble(_Symbol, SYMBOL_ASK));
    SetNewBottom2(SymbolInfoDouble(_Symbol, SYMBOL_BID));
}




void SO_Follow_InitLevels_Forex()
{
    if(SO_FOLLOW_CURR_TOP_LEVEL == 0 || SO_FOLLOW_CURR_BOTTOM_LEVEL == 0)
    {
        Print("SO_Follow_InitLevels_Forex");
        SO_Follow_Setter_Forex();
    }
}


void SO_Follow_BasicChangeLevel_Forex()
{

    if(SymbolInfoDouble(_Symbol, SYMBOL_ASK) > SO_FOLLOW_CURR_TOP_LEVEL) //SERVER_SYMBOL_BID
    {
        Print("SO_Follow_BasicChangeLevel_Forex -> SetNewTop2");
        SetNewTop2(SymbolInfoDouble(_Symbol, SYMBOL_ASK)); // puxa o long pra cima
    }
    
    
    //-- empurra a ordem de venda acompanhando a mínima do preço
    
    if(SymbolInfoDouble(_Symbol, SYMBOL_BID) < SO_FOLLOW_CURR_BOTTOM_LEVEL)
    {
        Print("SO_Follow_BasicChangeLevel_Forex -> SetNewBottom2");
        SetNewBottom2(SymbolInfoDouble(_Symbol, SYMBOL_BID  )); // empurra o bottom
    }  

}


void SO_Follow_Enforce_Condition_Forex()
{
    // não permite ficar sem ordem
  
  
    if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
    {
        if(LONG_CONDITIONS == false)
        {
            Print("SO_Follow_Enforce_Condition_Forex -> (LONG_CONDITIONS == false");
            SetNewBottom2(SymbolInfoDouble(_Symbol, SYMBOL_ASK));
        }
    }


    if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
    {    
        if(SHORT_CONDITIONS == false)
        {
            Print("SO_Follow_Enforce_Condition_Forex -> (SHORT_CONDITIONS == false");
            SetNewTop2(SymbolInfoDouble(_Symbol, SYMBOL_BID));
        } 
    }
}