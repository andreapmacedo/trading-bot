
double MANUAL_TP = 0;
double MANUAL_SL = 0;


//bool EN_DIST_BAR_SIZE 		=  false; //input
bool TP_DIST_BAR_SIZE  		=  false; //input
bool SL_DIST_BAR_SIZE 	 	=  false; //input
//bool EN_DIST_PERCENTAGE 		=  false; //input
bool TP_DIST_PERCENTAGE 		=  false; //input
bool SL_DIST_PERCENTAGE 		=  false; //input


//--- Vars que vão para o place orders
double FINAL_EN_LONG_VALUE;
double FINAL_EN_SHORT_VALUE;

double FINAL_TP_LONG_VALUE;
double FINAL_TP_SHORT_VALUE;

double FINAL_SL_LONG_VALUE;
double FINAL_SL_SHORT_VALUE;
//____________________________//_________________________

double TEMP_EN_LONG_VALUE = 0;
double TEMP_EN_SHORT_VALUE = 0;

double TEMP_TP_LONG_VALUE = 0;
double TEMP_TP_SHORT_VALUE = 0;


double TEMP_SL_LONG_VALUE = 0;
double TEMP_SL_SHORT_VALUE = 0;


double PREVIOUS_EN_LONG_VALUE;
double PREVIOUS_EN_SHORT_VALUE;

double PREVIOUS_TP_LONG_VALUE;
double PREVIOUS_TP_SHORT_VALUE;

double PREVIOUS_LONG_SL_VALUE;
double PREVIOUS_SHORT_SL_VALUE;



//--- Possibilita modificar o valor do input
int SELECTED_EST_EN_ANCHOR_CHOSEN = 0;
int SELECTED_EST_EN_DISTANCE_CHOSEN = 0;
int SELECTED_EST_VOLUME_CHOSEN = 0;



int SELECTED_EST_TP_ANCHOR_CHOSEN = 0;
int SELECTED_EST_TP_DISTANCE_CHOSEN = 0;


int SELECTED_EST_SL_ANCHOR_CHOSEN = 0;
int SELECTED_EST_SL_DISTANCE_CHOSEN = 0;


input 

void SetOrdersSettings(int chosenDistance, int chosenLevel)
{
    
    Set_EN_orders(chosenDistance, chosenLevel);
    Set_TP_orders();
    Set_SL_orders();



}

//______________________________//__________________

void Set_EN_orders(int chosenDistance, int chosenLevel)
{
    Set_EN_Parameter();
    Set_Final_EN_Orders_Value();
}

void Set_TP_orders()
{
    Set_TP_Parameter();
    Set_Final_TP_Orders_Value();
}

void Set_SL_orders()
{
    Set_SL_Parameter();
    Set_Final_SL_Orders_Value();
}

//______________________________//__________________

void Set_EN_Parameter()
{
    EN_OrderVolume_Settings(SELECTED_EST_VOLUME_CHOSEN);
    Set_EN_Orders_Level_Settings(SELECTED_EST_EN_ANCHOR_CHOSEN);
    Set_EN_Orders_Distance_Settings(SELECTED_EST_EN_DISTANCE_CHOSEN); 
}

void Set_TP_Parameter()
{
    Chosen_TP_OrdersLevel_Settigns(SELECTED_EST_TP_ANCHOR_CHOSEN); 
    Set_TP_OrderDistance_Settings(SELECTED_EST_TP_DISTANCE_CHOSEN);
}

void Set_SL_Parameter()
{
    
    Chosen_SL_OrdersLevel_Settigns(SELECTED_EST_SL_ANCHOR_CHOSEN); 
    Set_SL_OrderDistance_Settings(SELECTED_EST_SL_DISTANCE_CHOSEN);
}

//______________________________//__________________

void Set_Final_Orders()
{
    Set_Final_EN_Orders_Value();
    Set_Final_TP_Orders_Value();
    Set_Final_SL_Orders_Value();
}

void Set_Final_EN_Orders_Value()
{
    // O CORRETO É TRABALHAR COM O FINAL_EN_LONG_VALUE NO ORDER DISTANCE 
	//FINAL_EN_LONG_VALUE  =  NormalizeDouble((MyRound(FINAL_EN_LONG_VALUE)), _Digits);
    PREVIOUS_EN_LONG_VALUE = FINAL_EN_LONG_VALUE;
    PREVIOUS_EN_SHORT_VALUE = FINAL_EN_SHORT_VALUE;
	
    FINAL_EN_LONG_VALUE  =  NormalizeDouble((MyRound(TEMP_EN_LONG_VALUE)), _Digits);
	FINAL_EN_SHORT_VALUE =  NormalizeDouble((MyRound(TEMP_EN_SHORT_VALUE)), _Digits);

    //LAST_PLACED_FINAL_EN_SHORT_VALUE = FINAL_EN_SHORT_VALUE;
    //LAST_PLACED_FINAL_EN_LONG_VALUE = FINAL_EN_LONG_VALUE;
    
}

void Set_Final_TP_Orders_Value()
{
    // da para trabalhar com emulador
    if(SELECTED_TP_ON)
    {
	    FINAL_TP_LONG_VALUE  =  NormalizeDouble((MyRound(TEMP_TP_LONG_VALUE)), _Digits);
	    FINAL_TP_SHORT_VALUE =  NormalizeDouble((MyRound(TEMP_TP_SHORT_VALUE)), _Digits);
        Manual_TP();
    }
    else
    {
		FINAL_TP_LONG_VALUE  =  NULL;
		FINAL_TP_SHORT_VALUE =  NULL;        
    }    
        
    PREVIOUS_TP_LONG_VALUE = FINAL_TP_LONG_VALUE;
    PREVIOUS_TP_SHORT_VALUE = FINAL_TP_SHORT_VALUE;

}

void Set_Final_SL_Orders_Value()
{

    if(SELECTED_SL_ON)
    {
	    FINAL_SL_LONG_VALUE  =  NormalizeDouble((MyRound(TEMP_SL_LONG_VALUE)), _Digits);
	    FINAL_SL_SHORT_VALUE =  NormalizeDouble((MyRound(TEMP_SL_SHORT_VALUE)), _Digits);
        Manual_SL();
    }
    else
    {
		FINAL_SL_LONG_VALUE  =  NULL;
		FINAL_SL_SHORT_VALUE =  NULL;        
    }
        PREVIOUS_LONG_SL_VALUE = FINAL_SL_LONG_VALUE;
        PREVIOUS_SHORT_SL_VALUE = FINAL_SL_SHORT_VALUE;

}

//______________________________//__________________

// TRAILINGO DE ENTRADA NA DIREÇÃO OPOSTA...
bool trl_stp_NEW_IN_PARAMS = false;
bool trl_stp_BAR_TO_BAR = false;
bool trl_stp_BAR_TO_BAR_BIGGEST_TWO = false;
bool trl_stp_MA_REF = false;


//double DY_TP_LEVEL_CHOSEN


void Dynamic_EN()
{

    //TODO
    //- AJUSTAR VELA A VELA A ENTRADA CASO O NÃO DÊ MAIS SINAL MAS A ENTRADA AINDA SEJA DESEJADA

}

void Dynamic_SL()
{



}




void Manual_TP()
{
	if(MANUAL_TP != 0)
	{
		if(MANUAL_TP > SymbolInfoDouble(_Symbol, SYMBOL_ASK))
		{
			FINAL_TP_LONG_VALUE = MANUAL_TP;
		}
		else
		{
			FINAL_TP_SHORT_VALUE = MANUAL_TP;
		}
	}
}

void Manual_SL()
{
	if(MANUAL_SL != 0)
	{
		if(MANUAL_SL < SymbolInfoDouble(THIS_SYMBOL, SYMBOL_BID))
		{
			FINAL_SL_LONG_VALUE = MANUAL_SL;
		}
		else
		{
			FINAL_SL_SHORT_VALUE = MANUAL_SL;
		}
	}
}






void SetAllSelectedOrders_System()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;

    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_System;
    SELECTED_EST_TP_DISTANCE_CHOSEN = eOrDistance_TP_System;

    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_System;
    SELECTED_EST_SL_DISTANCE_CHOSEN = eOrDistance_SL_System;


    SELECTED_TRAILING_STOP_DISTANCE = eOrTrailing_Stop_System;
    SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_System;

}

void SetAllSelectedOrders_Default()
{

    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_Default;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_Default;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_Default;

    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_Default;
    SELECTED_EST_TP_DISTANCE_CHOSEN = eOrDistance_TP_Default;


    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_Default;
    SELECTED_EST_SL_DISTANCE_CHOSEN = eOrDistance_SL_Default;

}

void SetAllSelectedOrders_Input()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN = INPUT_EN_EST_DISTANCE_CHOSEN;
    SELECTED_EST_VOLUME_CHOSEN = INPUT_EN_EST_VOLUME_CHOSEN;

    SELECTED_EST_TP_ANCHOR_CHOSEN = INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_TP_DISTANCE_CHOSEN = INPUT_TP_EST_DISTANCE_CHOSEN;

    SELECTED_EST_SL_ANCHOR_CHOSEN = INPUT_SL_EST_ANCHOR_CHOSEN;
    SELECTED_EST_SL_DISTANCE_CHOSEN = INPUT_SL_EST_DISTANCE_CHOSEN;  
}



void SetAllSelectedOrders_Level_System()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_System;
    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_System;
}


void SetAllSelectedOrders_Level_Input()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_TP_ANCHOR_CHOSEN = INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_SL_ANCHOR_CHOSEN = INPUT_SL_EST_ANCHOR_CHOSEN;
}

void SetAllSelectedOrders_Distance_System()
{
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_TP_DISTANCE_CHOSEN = eOrDistance_TP_System;
    SELECTED_EST_SL_DISTANCE_CHOSEN = eOrDistance_SL_System;
}

void SetAllSelectedOrders_Distance_Input()
{
    SELECTED_EST_EN_DISTANCE_CHOSEN = INPUT_EN_EST_DISTANCE_CHOSEN;
    SELECTED_EST_TP_DISTANCE_CHOSEN = INPUT_TP_EST_DISTANCE_CHOSEN;
    SELECTED_EST_SL_DISTANCE_CHOSEN = INPUT_SL_EST_DISTANCE_CHOSEN;
}


void SetAllSelectedOrders_EN_System()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = eOrLevel_EN_System;
    SELECTED_EST_EN_DISTANCE_CHOSEN = eOrDistance_EN_System;
    SELECTED_EST_VOLUME_CHOSEN = eVolume_System;
}

void SetAllSelectedOrders_TP_System()
{
    SELECTED_EST_TP_ANCHOR_CHOSEN = eOrLevel_TP_System;
    SELECTED_EST_TP_DISTANCE_CHOSEN = eOrDistance_TP_System;
}

void SetAllSelectedOrders_SL_System()
{
    SELECTED_EST_SL_ANCHOR_CHOSEN = eOrLevel_SL_System;
    SELECTED_EST_SL_DISTANCE_CHOSEN = eOrDistance_SL_System;
}

void SetAllSelectedOrders_EN_Input()
{
    SELECTED_EST_EN_ANCHOR_CHOSEN = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN = INPUT_EN_EST_DISTANCE_CHOSEN;
    SELECTED_EST_VOLUME_CHOSEN = INPUT_EN_EST_VOLUME_CHOSEN;
}

void SetAllSelectedOrders_TP_Input()
{
    SELECTED_EST_TP_ANCHOR_CHOSEN = INPUT_TP_EST_ANCHOR_CHOSEN;
    SELECTED_EST_TP_DISTANCE_CHOSEN = INPUT_TP_EST_DISTANCE_CHOSEN;
}

void SetAllSelectedOrders_SL_Input()
{
    SELECTED_EST_SL_ANCHOR_CHOSEN = INPUT_SL_EST_ANCHOR_CHOSEN;
    SELECTED_EST_SL_DISTANCE_CHOSEN = INPUT_SL_EST_DISTANCE_CHOSEN;
}


void OrdersPlace_Drawings()
{
	int extend_line = 1000;

    //DeletAllDrawings_Tech_Range();

	//--- compra
    SetObjectLine("FINAL_EN_LONG_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_EN_LONG_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_EN_LONG_VALUE,
                    clrDarkTurquoise,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );  	



    SetObjectLine("FINAL_EN_SHORT_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_EN_SHORT_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_EN_SHORT_VALUE,
                    clrDarkTurquoise,
                    1,
                    STYLE_DOT//STYLE_DOT                    
                    ); 


    SetObjectLine("FINAL_TP_LONG_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_TP_LONG_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_TP_LONG_VALUE,
                    clrChartreuse,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );                                         

    SetObjectLine("FINAL_TP_SHORT_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_TP_SHORT_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_TP_SHORT_VALUE,
                    clrChartreuse,
                    1,
                    STYLE_DOT//STYLE_DOT                    
                    );   
    
    SetObjectLine("FINAL_SL_LONG_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_SL_LONG_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_SL_LONG_VALUE,
                    clrRed,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );

    SetObjectLine("FINAL_SL_SHORT_VALUE",
                    PriceInfo[SELECTED_LEFT_BARS].time,
					FINAL_SL_SHORT_VALUE,
					(PriceInfo[0].time)+(extend_line),
					FINAL_SL_SHORT_VALUE,
                    clrRed,
                    1,
                    STYLE_DOT//STYLE_DOT                    
                    );  

                    
                                          

}