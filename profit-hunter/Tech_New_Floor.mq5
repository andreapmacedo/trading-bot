// https://www.mql5.com/en/docs/indicators






void GetBars()
{ 
	IntradayBar = iBarShift(_Symbol, 0, iTime(_Symbol, PERIOD_D1, 0));
}


void SetSelectedLeftBar()
{

	if(LEFT_BARS > IntradayBar)
	{
		SELECTED_LEFT_BARS = IntradayBar;
	}
	else
	{
		SELECTED_LEFT_BARS = LEFT_BARS;
	}
}



void Candle_Pattern_Routine()
{
	SetBarHighestLowest_Sequence();
	SetNoBreak_Sequence();
}



void SetBarHighestLowest_Sequence()
{
	if(IntradayBar > 1)
	{
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
	}
	
}

int NO_BREAKOUT_BAR_SEQUENCE = 0;
int NO_BREAKDOWN_BAR_SEQUENCE = 0;

void SetNoBreak_Sequence()
{

	if(IntradayBar > 1)
	{
		if(PriceInfo[2].high < PriceInfo[1].high)
		{
			NO_BREAKOUT_BAR_SEQUENCE += 1;
		}
		else
		{
			NO_BREAKOUT_BAR_SEQUENCE = 0;
		}

		if(PriceInfo[1].low > PriceInfo[2].low)
		{
			NO_BREAKDOWN_BAR_SEQUENCE += 1; 
		}
		else
		{
			NO_BREAKDOWN_BAR_SEQUENCE = 0;

		}			
	}


}

