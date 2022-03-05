







bool isFalling()
{
	bool result = false;
	
	result = rBEFORE_CLOSE < rLAST_CLOSE ? true : false;

	return result;
}

bool isFallingBefore()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;
}



void BarPattern()
{
	if(rLAST_LOW > rBEFORE_LOW)
	{
		// GAP DE BAIXA
	}
}


bool Check_Close()
{
	bool result = false;
	
	result = rBEFORE_CLOSE > rLAST_CLOSE ? true : false;

	return result;
}



void EndDayBarInfsRoutine()
{


}


void StartDayBarInfsRoutine()
{


}



bool Crossed_Up(double Price_close, double price_high, double price_low, double price_ask, double price_bid, double level_ref)
{
	if (price_low < level_ref && Price_close > level_ref)
	{
		return true;
	}
	else 
		return false;
}

bool Crossed_Down(double Price_close, double price_high, double price_low, double price_ask, double price_bid, double level_ref)
{
	if (price_high > level_ref && Price_close < level_ref)
	{
		return true;
	}
	else 
		return false;
}


bool Bull_Trap_Level(double Price_close, double price_high, double price_low, double price_ask, double price_bid, double level_ref)
{
	if (price_low < level_ref && Price_close < level_ref && price_high >= level_ref)
	{
		return true;
	}
	else 
		return false;
}

bool Bear_Trap_Level(double Price_close, double price_high, double price_low, double price_ask, double price_bid, double level_ref)
{
	if (price_high > level_ref && Price_close > level_ref && price_low <= level_ref)
	{
		return true;
	}
	else 
		return false;
}



// new


bool CDP_TREND_UP()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;
}

bool CDP_TREND_DONW()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;    
}

bool CDP_RED()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;    
}


bool CDP_GREEN()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;    
}


bool CDP_INSIDE()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;    
}

bool CDP_ENGULF()
{
	bool result = false;
	
	result = rLAST_CLOSE < r_B_LastClose ? true : false;

	return result;    
}


// prior


//tipos de fechamento 

// maior máxima e maior mínima (trend up)
// menor máxima e menor mínima (trend down)
// maior máxima e menor mínima
// menor máxima e maior mínima
//  


// inclinação das médias
// cruzamento de médias
// direção de médias
// 




















void HitoricBarSize() // NOT USED
{
	IntradayBar = iBarShift(_Symbol, 0, iTime(_Symbol, PERIOD_D1, 0));



	MqlRates PriceInfo[];
	ArraySetAsSeries(PriceInfo, true);

	
	//Comment("IntradayBar ->  "+ IntradayBar);

	/*
	ArrayResize(HistoricLAST_BAR_SIZE, HistoricBarLenth);
    ArrayResize(HistoricBarTrend, HistoricBarLenth);
    ArrayResize(HistoricBarVolume_Unt, HistoricBarLenth);
    ArrayResize(HistoricBarVolume_Fin, HistoricBarLenth);
	
   
	ArraySetAsSeries(volumeFin, true);
    CopyBuffer(VolumeDefinition,0,0,HistoricBarLenth,volumeFin); 	
	*/
	
        int loopRef;
        if(IntradayBar > LEFT_BARS)
        {
            loopRef = LEFT_BARS;
        }
        else
        {
            loopRef = IntradayBar;
        }



		
	/*
      if (IntradayBar > 10)//HistoricBarLenth)
      {
        for (int i = 1; i < loopRef-1; i++)
        {  
          double bs = PriceInfo[i].high - PriceInfo[i].low;
           
          AvgBarVolume_Fin = (AvgBarVolume_Fin + volumeFin[i-1]);
          AvgLAST_BAR_SIZE = AvgLAST_BAR_SIZE + (bs) ; 
           
           
          HistoricLAST_BAR_SIZE[i-1] = bs;
           
          if(bs > BiggestLAST_BAR_SIZE)
          {                   
            BiggestLAST_BAR_SIZE = bs;
            BiggestBarPosition = i;  
          }
        } // end for
      } // end if

      LastBarVol = (int)volumeFin[1];
      AvgBarVolume_Fin = (AvgBarVolume_Fin / HistoricBarLenth);
      AvgLAST_BAR_SIZE = AvgLAST_BAR_SIZE/HistoricBarLenth;
		
	
        
    /*    
    insideBarUp = PriceInfo[1].high <= PriceInfo[2].high && PriceInfo[1].low > PriceInfo[2].low; //? true : false;
    insideBarDown = PriceInfo[1].low >= PriceInfo[2].low && PriceInfo[1].high < PriceInfo[2].high; //? true : false;
         
    giftUp = HistoricLAST_BAR_SIZE[1] > (AvgLAST_BAR_SIZE * 1) &&  HistoricLAST_BAR_SIZE[1] > (HistoricLAST_BAR_SIZE[0]*1.5) && insideBarUp;// && PriceInfo[1].close >= (TopDistance - per_050);
    giftDown = HistoricLAST_BAR_SIZE[1] > (AvgLAST_BAR_SIZE * 1) && HistoricLAST_BAR_SIZE[1] > (HistoricLAST_BAR_SIZE[0]*1.5) && insideBarUp;//  && PriceInfo[1].close <= (BottomDistance + pe
	*/
	
	/*
	Comment("insideBarUp ->  "+ insideBarUp);
	Comment("insideBarDown ->  "+ insideBarDown);
	Comment("giftUp ->  "+ giftUp);
	Comment("giftDown ->  "+ giftDown);
*/
}     




//+------------------------------------------------------------------+
//| TrendCondition                                                   |
//+------------------------------------------------------------------+



bool 		 l_LONG_TREND_CONDITIONS			= false;
bool 		 l_SHORT_TREND_CONDITIONS 			= false;




bool is_SO_MA_Crosed_Up   = false;
bool is_SO_MA_Crosed_Down = false;

void SO_Generic()
{
	LONG_CONDITIONS  = PriceInfo[0].close > LowerBandArray[0] && PriceInfo[1].close < LowerBandArray[1]; 
	SHORT_CONDITIONS = PriceInfo[0].close < LowerBandArray[0] && PriceInfo[1].close > LowerBandArray[1]; 
}

void SO_MA_Crosed()
{
	is_SO_MA_Crosed_Up = GenericLevelCrossedUp(MovingAvarageArray[0]);
	is_SO_MA_Crosed_Down = GenericLevelCrossedDown(MovingAvarageArray[0]);
}

void BB_SO()
{
	LONG_CONDITIONS = PriceInfo[2].close <= LowerBandArray[1] && PriceInfo[1].close >= LowerBandArray[1];
	SHORT_CONDITIONS = PriceInfo[2].close >= LowerBandArray[1] && PriceInfo[1].close <= LowerBandArray[1]; 
	//LONG_CONDITIONS = GenericLevelCrossedUp(LowerBandArray[1]);
	//SHORT_CONDITIONS = GenericLevelCrossedDown(UpperBandArray[1]);

	/*
    Print("PriceInfo[2].close -> ", PriceInfo[2].close);
    Print("PriceInfo[1].close -> ", PriceInfo[1].close);
    Print("LowerBandArray[1] -> ", LowerBandArray[1]);
	*/
}


bool A_Crossed_B_Up(double level_A,  double level_B)
{
	bool isCrossedUp = false;
	isCrossedUp = level_A <= level_B && level_A >= level_B;
	return isCrossedUp;

}

bool A_Crossed_B_Down(double level_A,  double level_B)
{
	bool isCrossedDown = false;
	isCrossedDown = level_A > level_B && level_A < level_B;
	return isCrossedDown;
}

bool GenericLevelCrossedUp(double level)
{
	bool isCrossedUp = false;
	isCrossedUp = PriceInfo[2].close < level && PriceInfo[1].close > level;
	return isCrossedUp;
}


bool GenericLevelCrossedDown(double level)
{
	bool isCrossedDown = false;
	isCrossedDown = PriceInfo[2].close > level && PriceInfo[1].close < level;
	return isCrossedDown;
}


bool Is_Bull_Trap(double level)
{
	bool Bull_Trap = PriceInfo[1].high > level && PriceInfo[1].close < level && Is_CandlePattern_Shooting_Star(); 
	return Bull_Trap;
}

bool Is_CandlePattern_Shooting_Star()
{
	bool CandlePattern_Shooting_Star = PriceInfo[1].open < (PriceInfo[1].high - ((Historic_BarSize[1])/2)) && PriceInfo[1].close < (PriceInfo[1].high - ((Historic_BarSize[1])/2));
	return CandlePattern_Shooting_Star;
}






/*TODO
estudo de estatística de média móvel (mudança de polaridade, topos e vales, média de inclinação por horário, distânciamento médio do preço)
realização parcial na tendência 
bollinger bands
vwap
prior
suportes e resistências pelo modelo do algorítimo do tradingview
cruzamento de médias
cruzamento de médias considereando a inclinação destas
*/


//TODO
// tratar cada estratégia já bem definida
// definir uma choice para long in e shor in e criar o modo trap, at ou break para estes levels