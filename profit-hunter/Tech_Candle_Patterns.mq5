// https://www.mql5.com/en/docs/indicators




void bagunca()
{

	double LEVEL_REF;
	LAST_BAR_SIZE = (PriceInfo[1].high - PriceInfo[1].low);
	

	CandlePattern_hammer =  PriceInfo[1].open > (PriceInfo[1].high - ((Historic_BarSize[1])/2)) && PriceInfo[1].close > (PriceInfo[1].high - ((Historic_BarSize[1])/2)); 
	CandlePattern_shooting_star = PriceInfo[1].open < (PriceInfo[1].high - ((Historic_BarSize[1])/2)) && PriceInfo[1].close < (PriceInfo[1].high - ((Historic_BarSize[1])/2));


	Crossed_Level_Ref = LEVEL_REF;

	Crossed_Price_Up = PriceInfo[1].open < Crossed_Level_Ref && PriceInfo[1].close > Crossed_Level_Ref;
	Crossed_Price_Down = PriceInfo[1].open > Crossed_Level_Ref && PriceInfo[1].close < Crossed_Level_Ref;

	Bull_Trap = PriceInfo[1].high > Crossed_Level_Ref && PriceInfo[1].close < Crossed_Level_Ref && CandlePattern_shooting_star; 
	//Bull_Trap = PriceInfo[1].high > Crossed_Level_Ref && PriceInfo[1].close < Crossed_Level_Ref && PriceInfo[1].open < Crossed_Level_Ref; // melhor
	//Bull_Trap = PriceInfo[1].high > Crossed_Level_Ref && PriceInfo[1].close < Crossed_Level_Ref;
	Bear_Trap = PriceInfo[1].low < Crossed_Level_Ref &&  PriceInfo[1].close > Crossed_Level_Ref && CandlePattern_hammer;
	//Bear_Trap = PriceInfo[1].low < Crossed_Level_Ref && PriceInfo[1].close > Crossed_Level_Ref && PriceInfo[1].open > Crossed_Level_Ref; //melhor
	//Bear_Trap = PriceInfo[1].low < Crossed_Level_Ref && PriceInfo[1].close > Crossed_Level_Ref;

	GreenCandle = PriceInfo[1].close > PriceInfo[1].open;

	closed_above_level_ref = PriceInfo[1].close > LEVEL_REF;


	if(PriceInfo[1].high > PriceInfo[2].high)
	{
		Before_BreakOut = MyRound(PriceInfo[1].high - PriceInfo[2].high);
		BREAKOUT_SEQUENCE += 1;
	}
	else
	{
		BREAKOUT_SEQUENCE = 0;

	}

	if(PriceInfo[1].low < PriceInfo[2].low)
	{
		Before_BreakDown = MyRound(PriceInfo[1].low - PriceInfo[2].low)*(-1);
		BREAKDOWN_SEQUENCE += 1; 

	}
	else
	{
		BREAKDOWN_SEQUENCE = 0;

	}


	// Before_FinVol = (int)FinVol[1];
	


	
	//+------------------------------------------------------------------+
	// verifica a sequencia de velas subindo
	if(PriceInfo[1].high > PriceInfo[2].high && PriceInfo[1].low > PriceInfo[2].low)
	{
		TOTAL_CANDLES_UP +=1;
		//Print("TOTAL_CANDLES_UP: ", TOTAL_CANDLES_UP);
	}
	else
	{
		TOTAL_CANDLES_UP = 0;
		//Print("TOTAL_CANDLES_UP: ", TOTAL_CANDLES_UP);
	}

	if(PriceInfo[1].high < PriceInfo[2].high && PriceInfo[1].low < PriceInfo[2].low)
	{
		
		TOTAL_CANDLES_DOW +=1;
		//Print("TOTAL_CANDLES_DOW: ", TOTAL_CANDLES_DOW);
	}
	else
	{

		TOTAL_CANDLES_DOW = 0;
		//Print("TOTAL_CANDLES_DOW: ", TOTAL_CANDLES_DOW);
	}
	//+------------------------------------------------------------------+
}