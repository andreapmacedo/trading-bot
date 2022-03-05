//+------------------------------------------------------------------+
//| Highest and Lowest
//+------------------------------------------------------------------+


input int LEFT_BARS = 8; // TÉCNICO - Período de Barras - (Valor)



int SELECTED_LEFT_BARS = LEFT_BARS;

int LEFT_BAR_NUMBER_HIGHESTHIGH = 0;//NormalizeDouble(0.0, _Digits);
int LEFT_BAR_NUMBER_LOWESTLOW = 0;//NormalizeDouble(0.0, _Digits);

double LEFT_BAR_HIGHESTHIGH_MAX = NormalizeDouble(0.0, _Digits);
double LEFT_BAR_LOWESTLOW_MIN = NormalizeDouble(0.0, _Digits);

double CURRENT_LEFT_BAR_HIGHESTHIGH_MAX = NormalizeDouble(0.0, _Digits);
double CURRENT_LEFT_BAR_LOWESTLOW_MIN = NormalizeDouble(0.0, _Digits);

double LAST_LEFT_BAR_HIGHESTHIGH_MAX = NormalizeDouble(0.0, _Digits);
double LAST_LEFT_BAR_LOWESTLOW_MIN = NormalizeDouble(0.0, _Digits);


double LAST_SMALLER_DAY_LOW = 0;
double LAST_BIGGEST_DAY_HIGH = 0;
double LAST_MID_DAY_LEVEL = 0;


double LEFT_BAR_LEVEL_MID = 0;
double PIVOT_FIND_MID_LEVEL = 0;


double SMALLER_DAY_LOW = NormalizeDouble(0.0, _Digits);
double BIGGEST_DAY_HIGH = NormalizeDouble(0.0, _Digits);
double MID_DAY_LEVEL = NormalizeDouble(0.0, _Digits);
double QUARTER_TOP_DAY_LEVEL;
double QUARTER_BOTTOM_DAY_LEVEL;



void Tech_Range_Reset_Vars()
{
    LEFT_BAR_HIGHESTHIGH_MAX = 0;
    LEFT_BAR_LOWESTLOW_MIN = 0;

    CURRENT_LEFT_BAR_HIGHESTHIGH_MAX = 0;
    CURRENT_LEFT_BAR_LOWESTLOW_MIN = 0;

    LAST_LEFT_BAR_HIGHESTHIGH_MAX = 0;
    LAST_LEFT_BAR_LOWESTLOW_MIN = 0;


    SMALLER_DAY_LOW = 0;
    BIGGEST_DAY_HIGH = 0;
    MID_DAY_LEVEL = 0;
    QUARTER_TOP_DAY_LEVEL = 0;
    QUARTER_BOTTOM_DAY_LEVEL = 0;



    LAST_SMALLER_DAY_LOW = 0;
    LAST_BIGGEST_DAY_HIGH = 0;
    LAST_MID_DAY_LEVEL = 0;


    LEFT_BAR_LEVEL_MID = 0;
    PIVOT_FIND_MID_LEVEL = 0;
}




int TEMP_LEFT_BAR_NUMBER_HIGHESTHIGH;
int TEMP_LEFT_BAR_NUMBER_LOWESTLOW;


double Get_Day_HIGHESTHIGH_MAX()
{

    double High[];//, Low[];
	double result = 0;
    
	ArraySetAsSeries(High, true);
    //ArraySetAsSeries(Low, true);

    CopyHigh(_Symbol, _Period, 0, IntradayBar, High);
    //CopyLow(_Symbol, _Period, 0, IntradayBar, Low);

    LEFT_BAR_NUMBER_HIGHESTHIGH = ArrayMaximum(High, 0, IntradayBar);
	//LEFT_BAR_NUMBER_LOWESTLOW = ArrayMinimum(Low, 0, IntradayBar);	

	LEFT_BAR_HIGHESTHIGH_MAX = PriceInfo[IntradayBar].high;
	//LEFT_BAR_LOWESTLOW_MIN = PriceInfo[IntradayBar].low;
	result = LEFT_BAR_HIGHESTHIGH_MAX;
	
	return (result);
}

double Get_Day_LOWESTLOW_MIN()
{
		double Low[];
		double result = 0;

		//ArraySetAsSeries(High, true);
		ArraySetAsSeries(Low, true);

		//CopyHigh(_Symbol, _Period, 0, IntradayBar, High);
		CopyLow(_Symbol, _Period, 0, IntradayBar, Low);

		//LEFT_BAR_NUMBER_HIGHESTHIGH = ArrayMaximum(High, 0, IntradayBar);
		LEFT_BAR_NUMBER_LOWESTLOW = ArrayMinimum(Low, 0, IntradayBar);	

		//LEFT_BAR_HIGHESTHIGH_MAX = PriceInfo[IntradayBar].high;
		LEFT_BAR_LOWESTLOW_MIN = PriceInfo[IntradayBar].low;
		result = LEFT_BAR_LOWESTLOW_MIN;	
		return (result);
	/*
	if(checkPeriod())
	{
		double Low[];
		double result = 0;

		//ArraySetAsSeries(High, true);
		ArraySetAsSeries(Low, true);

		//CopyHigh(_Symbol, _Period, 0, IntradayBar, High);
		CopyLow(_Symbol, _Period, 0, IntradayBar, Low);

		//LEFT_BAR_NUMBER_HIGHESTHIGH = ArrayMaximum(High, 0, IntradayBar);
		LEFT_BAR_NUMBER_LOWESTLOW = ArrayMinimum(Low, 0, IntradayBar);	

		//LEFT_BAR_HIGHESTHIGH_MAX = PriceInfo[IntradayBar].high;
		LEFT_BAR_LOWESTLOW_MIN = PriceInfo[IntradayBar].low;
		result = LEFT_BAR_LOWESTLOW_MIN;		
	}


	return 1;// precisa ajustar
	*/

}


//TODO
// ao cruzar cada uma das 4 linhas, armazenar os valores de minima e e máximas para firmar as projeções


bool checkPeriod()
{
	if(_Period < PERIOD_D1)
		return true;
	else
		return false;
}


void Range_Routine()
{

	if(checkPeriod()) // deselegante
	{
		double High[], Low[];

		ArraySetAsSeries(High, true);
		ArraySetAsSeries(Low, true);

		CopyHigh(_Symbol, _Period, 0, SELECTED_LEFT_BARS, High);
		CopyLow(_Symbol, _Period, 0, SELECTED_LEFT_BARS, Low);

		LEFT_BAR_NUMBER_HIGHESTHIGH = ArrayMaximum(High, 0, SELECTED_LEFT_BARS);
		LEFT_BAR_NUMBER_LOWESTLOW = ArrayMinimum(Low, 0, SELECTED_LEFT_BARS);	

		LEFT_BAR_HIGHESTHIGH_MAX = PriceInfo[LEFT_BAR_NUMBER_HIGHESTHIGH].high;
		LEFT_BAR_LOWESTLOW_MIN = PriceInfo[LEFT_BAR_NUMBER_LOWESTLOW].low;
		


		if(LAST_LEFT_BAR_HIGHESTHIGH_MAX != LEFT_BAR_HIGHESTHIGH_MAX)
		{
			
			LAST_LEFT_BAR_HIGHESTHIGH_MAX = CURRENT_LEFT_BAR_HIGHESTHIGH_MAX;
			CURRENT_LEFT_BAR_HIGHESTHIGH_MAX = LEFT_BAR_HIGHESTHIGH_MAX;
		
			TEMP_LEFT_BAR_NUMBER_HIGHESTHIGH = LEFT_BAR_NUMBER_HIGHESTHIGH;
		}
		if(LAST_LEFT_BAR_LOWESTLOW_MIN != LEFT_BAR_LOWESTLOW_MIN)
		{
			
			LAST_LEFT_BAR_LOWESTLOW_MIN = CURRENT_LEFT_BAR_LOWESTLOW_MIN;
			CURRENT_LEFT_BAR_LOWESTLOW_MIN = LEFT_BAR_LOWESTLOW_MIN;

			TEMP_LEFT_BAR_NUMBER_LOWESTLOW = LEFT_BAR_NUMBER_LOWESTLOW;
		}	
		
		
		LEFT_BAR_LEVEL_MID = LEFT_BAR_HIGHESTHIGH_MAX - ((LEFT_BAR_HIGHESTHIGH_MAX - LEFT_BAR_LOWESTLOW_MIN)/2);
		
		
		if(IntradayBar == 1)
		{
			BIGGEST_DAY_HIGH = PriceInfo[0].high;
			SMALLER_DAY_LOW = PriceInfo[0].low;
			Set_Day_Levels();
		}
		else
		{
			if(BIGGEST_DAY_HIGH == 0)
			{
				BIGGEST_DAY_HIGH = Get_Day_HIGHESTHIGH_MAX();
			}
			if(SMALLER_DAY_LOW == 0)
			{
				SMALLER_DAY_LOW = Get_Day_LOWESTLOW_MIN();
			}
		}


		// TODO 

		// ESTUDAR ESTATISTICAMENTE O COMPORTAMENTO DA VOLATILIDADE PELOS MOVIMENTOS DE MÁXIMA MÍNIMA E MÉDIA DO DIA
		// QUANTOS DIAS VOLTA ATÉ A MÉDIA/MINIMA, TAMANHO MÉDIO DA VOLATILIDADE, DIAS DA SEMANA, ETC.
		if(LEFT_BAR_HIGHESTHIGH_MAX > BIGGEST_DAY_HIGH)
		{
			LAST_BIGGEST_DAY_HIGH = BIGGEST_DAY_HIGH;
			LAST_MID_DAY_LEVEL = MID_DAY_LEVEL;
			BIGGEST_DAY_HIGH = LEFT_BAR_HIGHESTHIGH_MAX;
			Set_Day_Levels();
		}
		if(LEFT_BAR_LOWESTLOW_MIN < SMALLER_DAY_LOW)
		{
			LAST_SMALLER_DAY_LOW = SMALLER_DAY_LOW;
			LAST_MID_DAY_LEVEL = MID_DAY_LEVEL;		
			SMALLER_DAY_LOW = LEFT_BAR_LOWESTLOW_MIN;
			Set_Day_Levels();
		}	

		if(HighestLowest_Day_Drawings_on)
		{
			HighestLowest_Day_Drawings();
		}

		if(Range_Drawings_on)
		{
			Range_Drawings();
		}
	}



}





void Set_Day_Levels()
{
		MID_DAY_LEVEL = BIGGEST_DAY_HIGH - ((BIGGEST_DAY_HIGH-SMALLER_DAY_LOW)/2);
        QUARTER_TOP_DAY_LEVEL = BIGGEST_DAY_HIGH - ((BIGGEST_DAY_HIGH-SMALLER_DAY_LOW)/4);
        QUARTER_BOTTOM_DAY_LEVEL = SMALLER_DAY_LOW + ((BIGGEST_DAY_HIGH-SMALLER_DAY_LOW)/4);
}

void Range_Drawings()
{
	int extend_line = 1000;

	//--- range highest
    SetObjectLine("LEFT_BAR_HIGHESTHIGH_MAX",
                    PriceInfo[TEMP_LEFT_BAR_NUMBER_LOWESTLOW].time,
					LEFT_BAR_HIGHESTHIGH_MAX,
					(PriceInfo[0].time)+(extend_line),
					LEFT_BAR_HIGHESTHIGH_MAX,
                    clrIndianRed,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );  	
	
	//DrawHorizontalLine_Evo("LEFT_BAR_HIGHESTHIGH_MAX", LEFT_BAR_HIGHESTHIGH_MAX, clrIndianRed , 1, STYLE_SOLID);
    SetObjectLine("LAST_LEFT_BAR_HIGHESTHIGH_MAX",
                    PriceInfo[TEMP_LEFT_BAR_NUMBER_LOWESTLOW].time,
					LAST_LEFT_BAR_HIGHESTHIGH_MAX,
					(PriceInfo[0].time)+(extend_line),
					LAST_LEFT_BAR_HIGHESTHIGH_MAX,
                    clrIndianRed,
                    1,
                    STYLE_DOT                    
                    );                    
	
	
	//--- range lowest
    SetObjectLine("LEFT_BAR_LOWESTLOW_MIN",
                    PriceInfo[TEMP_LEFT_BAR_NUMBER_LOWESTLOW].time,
					LEFT_BAR_LOWESTLOW_MIN,
					(PriceInfo[0].time)+(extend_line),
					LEFT_BAR_LOWESTLOW_MIN,
                    clrDeepSkyBlue,
                    1,
                    STYLE_SOLID//STYLE_DOT                    
                    );	
	
	
	//DrawHorizontalLine_Evo("LEFT_BAR_LOWESTLOW_MIN", LEFT_BAR_LOWESTLOW_MIN, clrDeepSkyBlue  , 1, STYLE_SOLID);
    SetObjectLine("LAST_LEFT_BAR_LOWESTLOW_MIN",
                    PriceInfo[TEMP_LEFT_BAR_NUMBER_LOWESTLOW].time,
					LAST_LEFT_BAR_LOWESTLOW_MIN,
					(PriceInfo[0].time)+(extend_line),
					LAST_LEFT_BAR_LOWESTLOW_MIN,
                    clrDeepSkyBlue,
                    1,
                    STYLE_DOT                    
                    );
	

	//--- range mid
    SetObjectLine("LEFT_BAR_LEVEL_MID",
                    PriceInfo[TEMP_LEFT_BAR_NUMBER_HIGHESTHIGH].time,
					LEFT_BAR_LEVEL_MID,
					(PriceInfo[0].time)+(extend_line),
					LEFT_BAR_LEVEL_MID,
                    clrWhite,//clrDeepPink,
                    1,
                    STYLE_SOLID                    
                    );

}


void HighestLowest_Day_Drawings()
{

	int extend_line = 1000;
	//DeletAllDrawings_Tech_Range();
	
	//TODO
	// projetar uma alvo que só vai ser alterado caso seja atingido

	
	/*
	DrawHorizontalLine_Evo("LAST_LEFT_BAR_LOWESTLOW_MIN", LAST_LEFT_BAR_LOWESTLOW_MIN, clrDeepSkyBlue, 1, STYLE_DOT);
	DrawHorizontalLine_Evo("LAST_LEFT_BAR_HIGHESTHIGH_MAX", LAST_LEFT_BAR_HIGHESTHIGH_MAX, clrIndianRed, 1, STYLE_DOT);
	*/
	
	



	//DrawHorizontalLine_Evo("SMALLER_DAY_LOW", SMALLER_DAY_LOW, clrBlue , 1, STYLE_DOT);
    SetObjectLine("SMALLER_DAY_LOW",
                    PriceInfo[IntradayBar].time,
					SMALLER_DAY_LOW,
					(PriceInfo[0].time)+(extend_line),
					SMALLER_DAY_LOW,
                    clrBlue,
                    1,
                    STYLE_SOLID                    
                    );


	//DrawHorizontalLine_Evo("BIGGEST_DAY_HIGH", BIGGEST_DAY_HIGH, clrRed, 1, STYLE_DOT);
    SetObjectLine("BIGGEST_DAY_HIGH",
                    PriceInfo[IntradayBar].time,
					BIGGEST_DAY_HIGH,
					(PriceInfo[0].time)+(extend_line),
					BIGGEST_DAY_HIGH,
                    clrRed,
                    1,
                    STYLE_SOLID                    
                    );	
	
	
	//DrawHorizontalLine_Evo("MID_DAY_LEVEL", MID_DAY_LEVEL,  clrYellow, 1, STYLE_DOT);
    SetObjectLine("MID_DAY_LEVEL",
                    PriceInfo[IntradayBar].time,
					MID_DAY_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					MID_DAY_LEVEL,
                    clrYellow,
                    1,
                    STYLE_SOLID                    
                    );	


	//DrawHorizontalLine_Evo("QUARTER_TOP_DAY_LEVEL", QUARTER_TOP_DAY_LEVEL, clrLime, 3, STYLE_SOLID);
    //ObjectDelete(_Symbol, "QUARTER_TOP_DAY_LEVEL");
	
	SetObjectLine("QUARTER_TOP_DAY_LEVEL",
                    PriceInfo[IntradayBar].time,
					QUARTER_TOP_DAY_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					QUARTER_TOP_DAY_LEVEL,
                    clrLime,
                    1,
                    STYLE_SOLID                    
                    );    

	//DrawHorizontalLine_Evo("QUARTER_BOTTOM_DAY_LEVEL", QUARTER_BOTTOM_DAY_LEVEL, clrLime, 3, STYLE_SOLID);
    SetObjectLine("QUARTER_BOTTOM_DAY_LEVEL",
                    PriceInfo[IntradayBar].time,
					QUARTER_BOTTOM_DAY_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					QUARTER_BOTTOM_DAY_LEVEL,
                    clrLime,
                    1,
                    STYLE_SOLID                    
                    );


	//DrawHorizontalLine_Evo("LAST_SMALLER_DAY_LOW", LAST_SMALLER_DAY_LOW, clrBlue, 3, STYLE_SOLID);
	//DrawHorizontalLine_Evo("LAST_BIGGEST_DAY_HIGH", LAST_BIGGEST_DAY_HIGH, clrRed, 3, STYLE_SOLID);
	//DrawHorizontalLine_Evo("LAST_MID_DAY_LEVEL", LAST_MID_DAY_LEVEL, clrYellow, 3, STYLE_SOLID);

}







int RANGE_TOP_BAR;
double RANGE_TOP_LEVEL;
double LAST_RANGE_TOP_LEVEL;
double CURRENT_RANGE_TOP_LEVEL;


int RANGE_BOTTOM_BAR;
double RANGE_BOTTOM_LEVEL;
double LAST_RANGE_BOTTOM_LEVEL;
double CURRENT_RANGE_BOTTOM_LEVEL;

double RANGE_MID;

void Set_Range(int left_bars)
{

    double High[], Low[];

    ArraySetAsSeries(High, true);
    ArraySetAsSeries(Low, true);

	if(left_bars > IntradayBar)
	{
		left_bars = IntradayBar;
	}
	else
	{
		left_bars = left_bars;
	}


    CopyHigh(_Symbol, _Period, 0, left_bars, High);
    CopyLow(_Symbol, _Period, 0, left_bars, Low);

    RANGE_TOP_BAR = ArrayMaximum(High, 0, left_bars);
	RANGE_BOTTOM_BAR = ArrayMinimum(Low, 0, left_bars);	

	RANGE_TOP_LEVEL = PriceInfo[RANGE_TOP_BAR].high;
	RANGE_BOTTOM_LEVEL = PriceInfo[RANGE_BOTTOM_BAR].low;
	
	RANGE_MID = RANGE_TOP_LEVEL - ((RANGE_TOP_LEVEL - RANGE_BOTTOM_LEVEL)/2);


	if(LAST_RANGE_TOP_LEVEL != RANGE_TOP_LEVEL)
	{
		//DrawHorizontalLine_Evo("LAST_LEFT_BAR_HIGHESTHIGH_MAX", LAST_LEFT_BAR_HIGHESTHIGH_MAX, clrIndianRed, 1, STYLE_DOT);
		LAST_RANGE_TOP_LEVEL = CURRENT_RANGE_TOP_LEVEL;
		CURRENT_RANGE_TOP_LEVEL = RANGE_TOP_LEVEL;
	}
	if(LAST_RANGE_BOTTOM_LEVEL != RANGE_BOTTOM_LEVEL)
	{
		//DrawHorizontalLine_Evo("LAST_LEFT_BAR_LOWESTLOW_MIN", LAST_LEFT_BAR_LOWESTLOW_MIN, clrDeepSkyBlue, 1, STYLE_DOT);
		LAST_RANGE_BOTTOM_LEVEL = CURRENT_RANGE_BOTTOM_LEVEL;
		CURRENT_RANGE_BOTTOM_LEVEL = RANGE_BOTTOM_LEVEL;
	}	
	
	 
	//Set_Range_Drows();
}

double GetMidLevelRange()
{
	int left_bars = 1;
    double High[], Low[];
	//double mid;
    ArraySetAsSeries(High, true);
    ArraySetAsSeries(Low, true);

	if(IntradayBar > SELECTED_LEFT_BARS)
	{
		left_bars = IntradayBar;
	}
	else
	{
		left_bars = left_bars;
	}
	//Print("left_bars ->  ", left_bars);
	//Print("SELECTED_LEFT_BARS ->  ", SELECTED_LEFT_BARS);
	//Print("IntradayBar ->  ", IntradayBar);

    CopyHigh(_Symbol, _Period, 0, left_bars, High);
    CopyLow(_Symbol, _Period, 0, left_bars, Low);

    RANGE_TOP_BAR = ArrayMaximum(High, 0, left_bars);
	RANGE_BOTTOM_BAR = ArrayMinimum(Low, 0, left_bars);	

	RANGE_TOP_LEVEL = PriceInfo[RANGE_TOP_BAR].high;
	RANGE_BOTTOM_LEVEL = PriceInfo[RANGE_BOTTOM_BAR].low;
	
	RANGE_MID = RANGE_TOP_LEVEL - ((RANGE_TOP_LEVEL - RANGE_BOTTOM_LEVEL)/2);

	return RANGE_MID;

}


void Set_Range_Drows(string objName)
{
    int extend_line = 500;

	ObjectDelete(_Symbol, "RANGE_TOP_LEVEL"+objName);
	DrawObjectLine("RANGE_TOP_LEVEL"+objName,
					(PriceInfo[RANGE_TOP_BAR].time),
					RANGE_TOP_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					RANGE_TOP_LEVEL, clrIndianRed// clrLime
					);


	ObjectDelete(_Symbol, "RANGE_BOTTOM_LEVEL"+objName);
	DrawObjectLine("RANGE_BOTTOM_LEVEL"+objName,
					(PriceInfo[RANGE_BOTTOM_BAR].time),
					RANGE_BOTTOM_LEVEL,
					(PriceInfo[0].time)+(extend_line),
					RANGE_BOTTOM_LEVEL, clrDeepSkyBlue// clrLime
					);

	ObjectDelete(_Symbol, "RANGE_MID"+objName);
	DrawObjectLine("RANGE_MID"+objName,
					(PriceInfo[RANGE_TOP_BAR].time),
					RANGE_MID,
					(PriceInfo[0].time)+(extend_line),
					RANGE_MID, clrWhite// clrLime
					);                    




}