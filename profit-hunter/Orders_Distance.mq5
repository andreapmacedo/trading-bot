




double SELECTED_EN_DISTANCE_LONG_VALUE = EN_Distance_Long;
double SELECTED_EN_DISTANCE_SHORT_VALUE = EN_Distance_Short;

enum enum_EN_Order_Distance
{
    eOrDistance_EN_System                = 0,
    eOrDistance_EN_Default               = 1,
    eOrDistance_EN_Pts                   = 2,
    eOrDistance_EN_Percent       	     = 3,
    eOrDistance_EN_X_BarSize             = 4,
    eOrDistance_EN_Adaptive_Add          = 5,
    eOrDistance_EN_Pts_Distance_06          = 6,
    eOrDistance_EN_Pts_Distance_07          = 7,
    eOrDistance_EN_Pts_Distance_08          = 8,
    eOrDistance_EN_Pts_Distance_09          = 9,
    eOrDst_01          = 10,
    eOrDst_02          = 11,
    eOrDst_Volume_All          = 12,
    eOrDst_Volume_and_Sequence_All          = 13,
    eOrDst_Volume_and_SequenceX2_All          = 14,
    eOrDst_Volume_and_SequenceX2          = 15,
    eOrDistance_pts_test          = 100
    // quadrante da 25%, 50% 
    // range
    // pivo
};
void SetLevelDistance(double &top, double &bottom, int chosen)
{
    switch(chosen)
    {
        case eOrDst_01: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            EstENOrerDst_10();
            break;
        case eOrDistance_EN_System: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            EST_LevelDistance__Pts(top, bottom);
            break;
        case eOrDistance_EN_Default: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            EST_LevelDistance__Pts(top, bottom);
            break;
        case eOrDistance_EN_Pts:
            EST_LevelDistance__Pts(top, bottom);
            break;           
        case eOrDistance_EN_Pts_Distance_06:
            EST_LevelDistance__Pts_Distance_06(top, bottom);
            break;// fazer o mesmo para volume no lugar de sequence           
        case eOrDistance_EN_Pts_Distance_07:
            EST_LevelDistance__Pts_Distance_07(top, bottom);
            break;           
        case eOrDistance_EN_Pts_Distance_08:
            EST_LevelDistance__Pts_Distance_08(top, bottom);
            break;           
        case eOrDistance_EN_Pts_Distance_09:
            EST_LevelDistance__Pts_Distance_09(top, bottom);
            break;           
        case eOrDistance_pts_test:
            EST_LevelDistance__Pts_Distance_30(top, bottom);
            break;
        default:
            EST_LevelDistance__Pts(top, bottom);
            break;
    }

}



void EstOrDst_Volume_and_Sequence_Evo_2()
{
   // TopChange = 0;// = 0;
  //  BottomChange = 0;// = 0;
    // para um lado é volume e para o outro a sequencia
    
    
    if(pos_volume > SELECTED_ADJ_DST_VOL_TOL_INI)
    {
        double change = ADJ_DST_VOL_VALUE * (pos_volume - SELECTED_ADJ_DST_VOL_TOL_INI);  
        
        if(pos_status == 1)
        {
            TopChange += change;
        }
        else if(pos_status == 0)
        {
            BottomChange += change;   
        }
    }
    if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
    {
        if(pos_status == 0)
        {        
            TopChange  += ADJ_DST_SEQ_VALUE * (Current_Sell_Seq - ADJ_DST_SEQ_TOL_INI); 
        }
    }
    else if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
    {

        if(pos_status == 1)
        {
            BottomChange  += ADJ_DST_SEQ_VALUE * (Current_Buy_Seq - ADJ_DST_SEQ_TOL_INI);
        }

    }    
}



//  escolher através do input o fator ara cada atributo(volume / sequencia
// adotar o mesmo algorítmo para o volume)
void EstOrDst_Volume_and_SequenceX2_All()
{
   // TopChange = 0;// = 0;
  //  BottomChange = 0;// = 0;
    // para um lado é volume e para o outro a sequencia
    if(pos_volume > ADJ_DST_SEQ_TOL_INI)
    {
        if(pos_status == 0)
        {
            BottomChange = ADJ_DST_SEQ_VALUE * (pos_volume-ADJ_DST_SEQ_TOL_INI);
            if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
            {
                TopChange  = ADJ_DST_SEQ_VALUE * ((Current_Sell_Seq*2) - ADJ_DST_SEQ_TOL_INI); 
            }
        }
        if(pos_status == 1)
        {
            TopChange = ADJ_DST_SEQ_VALUE * (pos_volume-ADJ_DST_SEQ_TOL_INI); 
            if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
            {
                BottomChange  = ADJ_DST_SEQ_VALUE * ((Current_Buy_Seq*2) - ADJ_DST_SEQ_TOL_INI);
            }            
        }
    }
}
void EstOrDst_Volume_and_Sequence_Evo()
{
   // TopChange = 0;// = 0;
  //  BottomChange = 0;// = 0;
    // para um lado é volume e para o outro a sequencia
    
    
    if(pos_volume > SELECTED_ADJ_DST_VOL_TOL_INI)
    {
        double change = ADJ_DST_VOL_VALUE * (pos_volume - SELECTED_ADJ_DST_VOL_TOL_INI);  
        
        if(pos_status == 1)
            TopChange += change;
        else if(pos_status == 0)
            BottomChange += change;   
    }
    if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
    {
        TopChange  += ADJ_DST_SEQ_VALUE * (Current_Sell_Seq - ADJ_DST_SEQ_TOL_INI); 
    }
    else if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
    {
        BottomChange  += ADJ_DST_SEQ_VALUE * (Current_Buy_Seq - ADJ_DST_SEQ_TOL_INI);
    }    
}

/*
void EstOrDst_Volume_and_Sequence_AddRel_All()
{
    TopChange = 0;
    BottomChange = 0;
    min_add_modify = 0;
    min_reduce_modify = 0;


    // adicionar o topChange/bottomChange ao add e real  
    if(pos_volume > ADJ_DST_SEQ_TOL_INI)
    {
        if(pos_status == 0)
        {
            BottomChange  = ADJ_DST_SEQ_VALUE * (pos_volume-ADJ_DST_SEQ_TOL_INI);

            if(DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI)   
            {
                TopChange  = ADJ_DST_SEQ_VALUE * (DYT_SYMBOL_SELL_SEQUENCE-ADJ_DST_SEQ_TOL_INI); 
            }
        }
        if(pos_status == 1)
        {
            TopChange  = ADJ_DST_SEQ_VALUE * (pos_volume-ADJ_DST_SEQ_TOL_INI); 
            if(DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI)
            {
                BottomChange  = ADJ_DST_SEQ_VALUE * (DYT_SYMBOL_BUY_SEQUENCE-ADJ_DST_SEQ_TOL_INI);
            }            
        }
    }
    //min_add_modify = TopChange;
    //min_reduce_modify = TopChange;
}
*/
void EST_LevelDistance__Pts2(double &top, double &bottom)
{
    EST_LevelDistance__Pts(top, bottom);
}
void EST_LevelDistance__Pts(double &top, double &bottom)
{
    top += EN_Distance_Short;
    bottom -= EN_Distance_Long;
}



void EST_LevelDistance__Pts_Distance_06(double &top, double &bottom)
{
    if(DYT_SYMBOL_BUY_SEQUENCE > 0)
    {
        top  += (EN_Distance_Short);  
        bottom  -= EN_Distance_Long * (1+DYT_SYMBOL_BUY_SEQUENCE);
    }
    else if(DYT_SYMBOL_SELL_SEQUENCE > 0)   
    {
        top  += EN_Distance_Short * (1+DYT_SYMBOL_SELL_SEQUENCE); 
        bottom  -= (EN_Distance_Long);
    }
    else
    {
        top += EN_Distance_Short;
        bottom -= EN_Distance_Long;
    }
}
void EST_LevelDistance__Pts_Distance_07(double &top, double &bottom)
{
    if(
        DYT_SYMBOL_BUY_SEQUENCE > 0
        && MyGetPosition() == 1
        )
    {
            top  += EN_Distance_Short; 
            bottom  -= (EN_Distance_Long * (1+DYT_SYMBOL_BUY_SEQUENCE));
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > 0
        && MyGetPosition() == -1
        )   
    {
            top  += (EN_Distance_Short * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
            bottom  -= EN_Distance_Long;
    }
    else
    {
        top += EN_Distance_Short;
        bottom -= EN_Distance_Long;
    }
}
void EST_LevelDistance__Pts_Distance_08(double &top, double &bottom)
{
    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        //&& MyGetPosition() == 1
        )
    {
        //if(LONG_CONDITIONS)
            top  += ADJ_DST_SEQ_VALUE; 
            bottom  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
        //if(SHORT_CONDITIONS)
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
       // && MyGetPosition() == -1
        )   
    {
        //if(LONG_CONDITIONS)
            top  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
            bottom  -= ADJ_DST_SEQ_VALUE;
        //if(SHORT_CONDITIONS)
    }
    else
    {
        top += EN_Distance_Short;
        bottom -= EN_Distance_Long;
    }
}
void EST_LevelDistance__Pts_Distance_09(double &top, double &bottom)
{

    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == 1
        )
    {
        top  += ADJ_DST_SEQ_VALUE; 
        bottom  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == -1
        )   
    {
        bottom  -= ADJ_DST_SEQ_VALUE;
        top  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        top += EN_Distance_Short;
        bottom -= EN_Distance_Long;
    }
}

void EST_LevelDistance__Pts_Distance_30(double &top, double &bottom)
{
    int trend = Set_Est_Trend__01();
    Print("trend: ", trend);

    if(trend > 0)
    {
        top  += (EN_Distance_Short);  
        bottom  -= EN_Distance_Long * (1+DYT_SYMBOL_BUY_SEQUENCE);
    }
    else if(trend < 0)   
    {
        top  += EN_Distance_Short * (1+DYT_SYMBOL_SELL_SEQUENCE); 
        bottom  -= (EN_Distance_Long);
    }
    else
    {
        top += EN_Distance_Short;
        bottom -= EN_Distance_Long;
    }
}


void Set_EN_Orders_Distance_Settings(int chosen)
{
    switch(chosen)
    {
        case eOrDistance_EN_System: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            break;
        case eOrDistance_EN_Default: //--- Não vai chamar função pois o EN_X_CHOSEN foi definido no SYS
            Set_EN_OrdersDistance__Pts();
            break;
        case eOrDistance_EN_Pts:
            Set_EN_OrdersDistance__Pts();
            break;
        case eOrDistance_EN_Pts_Distance_06:
            Set_EN_OrdersDistance__Pts_Distance_06();
            break;
        case 7:
            Set_EN_OrdersDistance__Pts_Distance_07();
            break;
        case eOrDistance_EN_Pts_Distance_08:
            Set_EN_OrdersDistance__Pts_Distance_08();
            break;
        case eOrDistance_EN_Pts_Distance_09:
            Set_EN_OrdersDistance__Pts_Distance_09();
            break;
        case eOrDistance_EN_Percent: 
            Set_EN_OrdersDistance__Percent();
            break;
        case eOrDistance_EN_X_BarSize:
            Set_EN_OrdersDistance__BarSize();
            break;                  
        default:
            Set_EN_OrdersDistance__Pts();
            break;
    }

}



void Set_EN_OrdersDistance__Pts_Distance_06()
{

    if(DYT_SYMBOL_BUY_SEQUENCE > 0)
    {
            if(LONG_CONDITIONS)
                TEMP_EN_LONG_VALUE  -= (SELECTED_EN_DISTANCE_LONG_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
                TEMP_EN_SHORT_VALUE  += SELECTED_EN_DISTANCE_SHORT_VALUE; 
    }
    else if(DYT_SYMBOL_SELL_SEQUENCE > 0)   
    {
            if(LONG_CONDITIONS)
                TEMP_EN_LONG_VALUE  -= SELECTED_EN_DISTANCE_LONG_VALUE;
            if(SHORT_CONDITIONS)
                TEMP_EN_SHORT_VALUE  += (SELECTED_EN_DISTANCE_SHORT_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}


void Set_EN_OrdersDistance__Pts_Distance_07()
{

    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == 1
        )
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= (SELECTED_EN_DISTANCE_LONG_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += SELECTED_EN_DISTANCE_SHORT_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == -1
        )   
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= SELECTED_EN_DISTANCE_LONG_VALUE;
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += (SELECTED_EN_DISTANCE_SHORT_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}




void Set_EN_OrdersDistance__Pts_Distance_08()
{
    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        //&& MyGetPosition() == 1
        )
    {
        if(LONG_CONDITIONS)
            TEMP_EN_LONG_VALUE  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
        if(SHORT_CONDITIONS)
            TEMP_EN_SHORT_VALUE  += ADJ_DST_SEQ_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        //&& MyGetPosition() == -1
        )   
    {
        if(LONG_CONDITIONS)
            TEMP_EN_LONG_VALUE  -= ADJ_DST_SEQ_VALUE;
        if(SHORT_CONDITIONS)
            TEMP_EN_SHORT_VALUE  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}
void Set_EN_OrdersDistance__Pts_Distance_09()
{

    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == 1
        )
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += ADJ_DST_SEQ_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == -1
        )   
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= ADJ_DST_SEQ_VALUE;
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}

void Set_EN_OrdersDistance__Pts_Distance_10()
{

    if(DYT_SYMBOL_BUY_SEQUENCE > 0)
    {
            if(LONG_CONDITIONS)
                TEMP_EN_LONG_VALUE  -= (SELECTED_EN_DISTANCE_LONG_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
                TEMP_EN_SHORT_VALUE  += SELECTED_EN_DISTANCE_SHORT_VALUE; 
    }
    else if(DYT_SYMBOL_SELL_SEQUENCE > 0)   
    {
            if(LONG_CONDITIONS)
                TEMP_EN_LONG_VALUE  -= SELECTED_EN_DISTANCE_LONG_VALUE;
            if(SHORT_CONDITIONS)
                TEMP_EN_SHORT_VALUE  += (SELECTED_EN_DISTANCE_SHORT_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}


void Set_EN_OrdersDistance__Pts_Distance_11()
{

    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == 1
        )
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= (SELECTED_EN_DISTANCE_LONG_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += SELECTED_EN_DISTANCE_SHORT_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == -1
        )   
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= SELECTED_EN_DISTANCE_LONG_VALUE;
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += (SELECTED_EN_DISTANCE_SHORT_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}




void Set_EN_OrdersDistance__Pts_Distance_12()
{
    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        //&& MyGetPosition() == 1
        )
    {
        if(LONG_CONDITIONS)
            TEMP_EN_LONG_VALUE  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
        if(SHORT_CONDITIONS)
            TEMP_EN_SHORT_VALUE  += ADJ_DST_SEQ_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        //&& MyGetPosition() == -1
        )   
    {
        if(LONG_CONDITIONS)
            TEMP_EN_LONG_VALUE  -= ADJ_DST_SEQ_VALUE;
        if(SHORT_CONDITIONS)
            TEMP_EN_SHORT_VALUE  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}
void Set_EN_OrdersDistance__Pts_Distance_13()
{

    if(
        DYT_SYMBOL_BUY_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == 1
        )
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_BUY_SEQUENCE));
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += ADJ_DST_SEQ_VALUE; 
    }
    else if(
        DYT_SYMBOL_SELL_SEQUENCE > ADJ_DST_SEQ_TOL_INI
        && MyGetPosition() == -1
        )   
    {
            if(LONG_CONDITIONS)
        TEMP_EN_LONG_VALUE  -= ADJ_DST_SEQ_VALUE;
            if(SHORT_CONDITIONS)
        TEMP_EN_SHORT_VALUE  += (ADJ_DST_SEQ_VALUE * (1+DYT_SYMBOL_SELL_SEQUENCE)); 
    }
    else
    {
        Set_EN_OrdersDistance__Pts();
    }
}



void Set_EN_OrdersDistance__Pts()
{

    if(LONG_CONDITIONS)
    TEMP_EN_LONG_VALUE  -= SELECTED_EN_DISTANCE_LONG_VALUE;

    if(SHORT_CONDITIONS)
    TEMP_EN_SHORT_VALUE  += SELECTED_EN_DISTANCE_SHORT_VALUE; 

}

void Set_EN_OrdersDistance__BarSize()
{

	TEMP_EN_LONG_VALUE  =  (TEMP_EN_LONG_VALUE - ((LAST_BAR_SIZE * X_SIZE_IN) + SELECTED_EN_DISTANCE_LONG_VALUE));
	TEMP_EN_SHORT_VALUE =  (TEMP_EN_SHORT_VALUE + ((LAST_BAR_SIZE * X_SIZE_IN) + SELECTED_EN_DISTANCE_SHORT_VALUE));
}


void Set_EN_OrdersDistance__Percent()
{
    double last = DoubleToString(SymbolInfoDouble(_Symbol, SYMBOL_LAST));

    

	//TEMP_EN_LONG_VALUE  =  (TEMP_EN_LONG_VALUE - (PriceInfo[1].close * SELECTED_EN_DISTANCE_LONG_VALUE));
	//TEMP_EN_SHORT_VALUE =  (TEMP_EN_SHORT_VALUE + (PriceInfo[1].close * SELECTED_EN_DISTANCE_SHORT_VALUE));

	//TEMP_EN_LONG_VALUE  =  (TEMP_EN_LONG_VALUE - (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));
	//TEMP_EN_SHORT_VALUE =  (TEMP_EN_SHORT_VALUE + (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));

	//TEMP_EN_LONG_VALUE  =  (TEMP_EN_LONG_VALUE - (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));
	//TEMP_EN_SHORT_VALUE =  (TEMP_EN_SHORT_VALUE + (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));


	if(BREAK_MODE)
	{
        TEMP_EN_LONG_VALUE  += last*SELECTED_EN_DISTANCE_LONG_VALUE;
        TEMP_EN_SHORT_VALUE  -= last*SELECTED_EN_DISTANCE_SHORT_VALUE; 
	}
    else
    {
        TEMP_EN_LONG_VALUE  -= last*SELECTED_EN_DISTANCE_LONG_VALUE;
        TEMP_EN_SHORT_VALUE  += last*SELECTED_EN_DISTANCE_SHORT_VALUE; 
    }






}




// encurtar a distancia das realizações a cada ordem em sequencia
// pode dobrar o volume da realização tb caso atinga x sequencia



void Set_EN_Adaptive_pts_003()
{


    if(DYT_SYMBOL_TOTAL_DEAL_BUY >= (SELECTED_LIMIT_POSITION_VOLUME/2))
    {
        SELECTED_EN_DISTANCE_LONG_VALUE = (DYT_SYMBOL_BUY_SEQUENCE * SELECTED_EN_DISTANCE_LONG_VALUE);         
    }
    else
    {
        SELECTED_EN_DISTANCE_LONG_VALUE = 0;
    }

    if(DYT_SYMBOL_TOTAL_DEAL_SELL >= (SELECTED_LIMIT_POSITION_VOLUME/2))
    {
        SELECTED_EN_DISTANCE_SHORT_VALUE = (DYT_SYMBOL_SELL_SEQUENCE * SELECTED_EN_DISTANCE_SHORT_VALUE);         
    }
    else
    {   
        SELECTED_EN_DISTANCE_SHORT_VALUE = 0;
    }

	TEMP_EN_LONG_VALUE  =  (TEMP_EN_LONG_VALUE - (EN_Distance_Long + SELECTED_EN_DISTANCE_LONG_VALUE));
	TEMP_EN_SHORT_VALUE =  (TEMP_EN_SHORT_VALUE + (EN_Distance_Short + SELECTED_EN_DISTANCE_SHORT_VALUE));



}

enum enum_TP_Order_Distance
{
    eOrDistance_TP_System                = 0,
    eOrDistance_TP_Default               = 1,
    eOrDistance_TP_Pts                   = 2,
    eOrDistance_TP_Percent       	     = 3,
    eOrDistance_TP_X_BarSize             = 4
    // quadrante da 25%, 50% 
    // range
    // pivo
};

void Set_TP_OrderDistance_Settings(int chosen)
{
    switch(chosen)
    {
        case eOrDistance_TP_System:
            break;
        case eOrDistance_TP_Default:
            Set_TP_OrdersDistance__Pts();
            break;            
        case eOrDistance_TP_Pts:
            Set_TP_OrdersDistance__Pts();
            break;           
        case eOrDistance_TP_Percent:
            Set_TP_OrdersDistance__Percent();
            break;    
        case eOrDistance_TP_X_BarSize:
            Set_TP_OrdersDistance__BarSize();
            break;                     
        default:
            Set_TP_OrdersDistance__Pts();   
            break;            
    }  
}

void Set_TP_OrdersDistance__Pts()
{
    TEMP_TP_LONG_VALUE  += TP_Distance_Long;
    TEMP_TP_SHORT_VALUE   -= TP_Distance_Short; 
    /*
	if(BREAK_MODE)
	{
        TEMP_TP_LONG_VALUE  += TP_Distance_Long;
        TEMP_TP_SHORT_VALUE   -= TP_Distance_Short; 
	}
    else 
    {
        TEMP_TP_LONG_VALUE  += TP_Distance_Long;
        TEMP_TP_SHORT_VALUE   -= TP_Distance_Short;
    }
    */

}

void Set_TP_OrdersDistance__BarSize()
{

	TEMP_TP_LONG_VALUE  =  (TEMP_TP_LONG_VALUE + ((LAST_BAR_SIZE * X_SIZE_IN) + TP_Distance_Long));
	TEMP_TP_SHORT_VALUE =  (TEMP_TP_SHORT_VALUE - ((LAST_BAR_SIZE * X_SIZE_IN) + TP_Distance_Short));
}


void Set_TP_OrdersDistance__Percent()
{

	//TEMP_TP_LONG_VALUE  =  (TEMP_TP_LONG_VALUE - (PriceInfo[1].close * TP_Distance_Long));
	//TEMP_TP_SHORT_VALUE =  (TEMP_TP_SHORT_VALUE + (PriceInfo[1].close * TP_Distance_Short));

	//TEMP_TP_LONG_VALUE  =  (TEMP_TP_LONG_VALUE - (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));
	//TEMP_TP_SHORT_VALUE =  (TEMP_TP_SHORT_VALUE + (CURRENT_SYMBOL_DEAL * EN_Percentage_Adjustment));
}

enum enum_SL_Order_Distance
{
    eOrDistance_SL_System          = 0,
    eOrDistance_SL_Default               = 1,
    eOrDistance_SL_Pts                   = 2,
    eOrDistance_SL_Percent       	       = 3,
    eOrDistance_SL_X_BarSize             = 4
    //eOrDistance_SL_X_BarSize             = 5
    // quadrante da 25%, 50% 
    // range
    // pivo
};


void Set_SL_OrderDistance_Settings(int chosen)
{
    switch(chosen)
    {
        case eOrDistance_SL_System:
            break;
        case eOrDistance_SL_Default:
            Set_SL_OrdersDistance__Pts();
            break;            
        case eOrDistance_SL_Pts:
            Set_SL_OrdersDistance__Pts();
            break;           
        case eOrDistance_SL_Percent:
            Set_SL_OrdersDistance__Percent();
            break;    
        case eOrDistance_SL_X_BarSize:
            Set_SL_OrdersDistance__BarSize();
            break;                     
        default:
            Set_SL_OrdersDistance__Pts();
            break;            
    }  
}




void Set_SL_OrdersDistance__Pts()
{


    TEMP_SL_LONG_VALUE  -= SL_Distance_Long;
    TEMP_SL_SHORT_VALUE   += SL_Distance_Short; 
    /*
	if(BREAK_MODE)
	{
        TEMP_SL_LONG_VALUE  -= SL_Distance_Long;
        TEMP_SL_SHORT_VALUE   += SL_Distance_Short; 
	}
    else 
    {
        TEMP_SL_LONG_VALUE  -= SL_Distance_Long;
        TEMP_SL_SHORT_VALUE   += SL_Distance_Short;
    }
    */
}

void Set_SL_OrdersDistance__BarSize()
{
	TEMP_SL_LONG_VALUE  =  (TEMP_SL_LONG_VALUE - ((LAST_BAR_SIZE * X_SIZE_IN) + SL_Distance_Long));
	TEMP_SL_SHORT_VALUE =  (TEMP_SL_SHORT_VALUE + ((LAST_BAR_SIZE * X_SIZE_IN) + SL_Distance_Short));
}


void Set_SL_OrdersDistance__Percent()
{
	//TEMP_SL_LONG_VALUE  =  (TEMP_SL_LONG_VALUE - (PriceInfo[1].close * SL_Distance_Long));
	//TEMP_SL_SHORT_VALUE =  (TEMP_SL_SHORT_VALUE + (PriceInfo[1].close * SL_Distance_Short));
}


//+------------------------------------------------------------------+
// Estratégias de Distância
//+------------------------------------------------------------------+

// 10 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com a SEQUÊNCIA de entradas consecutivas.
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */
// 11 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com a SEQUÊNCIA de entradas consecutivas.
    -- O incremento é aplicado em ambos os lados (long e short)
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */

// 100 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com a SEQUÊNCIA de entradas consecutivas.
    -- O incremento é aplicado apenas para o lado da posição
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */

// Variações
    /*
    -- Modo magnético ativado com DISTÂNCIA mínima de pontos e com afastamento mais robusto
    -- Ajuste no modolo de tendência 
    */


// 20 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com a SEQUÊNCIA de entradas consecutivas.
    -- O incremento é aplicado apnas contra a tendência
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */


// 50 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com o VOLUME da posição.
    -- O incremento do volume é aplicado para o lado da posição
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */

// 51 - ____________________________
    /*
    -- Aplica o incremento de DISTÂNCIA na próxima entrada de acordo com o VOLUME da posição.
    -- O incremento é aplicado em ambos os lados (long e short)
    -- Modo de afastamento por pg ou pa
    -- Range de ativação e desativação
    */

// Aplicação da Linha
    /*
    -- Modo magnético ativado com distância mínima de pontos e com afastamento mais robusto
    */