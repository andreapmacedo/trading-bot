
//INPUTS


int BOLLINGER_PERIOD 			= 20;



double UpperBandValue = NormalizeDouble(0.0, _Digits);// = 0;
double LoweBandValue = NormalizeDouble(0.0, _Digits);//  = 0;
double UpperBandArray[];
double LowerBandArray[];


// Verificar se a chamada está ativa no Routines>Assigns
void Bollinger_Asserts() // 
{
	ArraySetAsSeries(UpperBandArray, true);
	ArraySetAsSeries(LowerBandArray, true);
}

// esta funcçõa é chamada especificamente para retornar o valor da média requisitada
void Set_Bollinger_Bands(int shift_bar)
{


    /*
    // está recuperando dados já atualizados por rotina
    MqlRates PriceInfo[];
	ArraySetAsSeries(PriceInfo, true);
	int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);
    */  
	double UpperBandArray[];
    double LowerBandArray[];

    ArraySetAsSeries(UpperBandArray, true);
	ArraySetAsSeries(LowerBandArray, true);

	int BollingerBandsDefinition = iBands(_Symbol, _Period, BOLLINGER_PERIOD, 0 , 2, PriceInfo[1].close /*PRICE_CLOSE*/); // (ativo, timeframe, velas, shift, desvio padrão, valor de referência da vela)


	CopyBuffer(BollingerBandsDefinition, 1, 0, 3, UpperBandArray); // Buffer 1
	CopyBuffer(BollingerBandsDefinition, 2, 0, 3, LowerBandArray); // Buffer 2

	UpperBandValue = MyRound(UpperBandArray[0]);
	LoweBandValue  = MyRound(LowerBandArray[0]);

}

double Get_Upper_Bollinger_Bands(int shift_bar)
{


    /*
    // está recuperando dados já atualizados por rotina
    MqlRates PriceInfo[];
	ArraySetAsSeries(PriceInfo, true);
	int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);
    */  

    double UpperBandArray[];
	
    ArraySetAsSeries(UpperBandArray, true);
	
    int BollingerBandsDefinition = iBands(_Symbol, _Period, BOLLINGER_PERIOD, 0 , 2, PriceInfo[1].close /*PRICE_CLOSE*/); // (ativo, timeframe, velas, shift, desvio padrão, valor de referência da vela)
	
    CopyBuffer(BollingerBandsDefinition, 1, 0, 3, UpperBandArray); // Buffer 1
    
    double this_band = UpperBandArray[shift_bar];
    return this_band;
}



double Get_Lower_Bollinger_Bands(int shift_bar)
{
    /*
    // está recuperando dados já atualizados por rotina
    MqlRates PriceInfo[];
	ArraySetAsSeries(PriceInfo, true);
	int PriceData = CopyRates(Symbol(), Period(), 0, 3, PriceInfo);
    */  
	
    double LowerBandArray[];

    
    ArraySetAsSeries(LowerBandArray, true);
	
    int BollingerBandsDefinition = iBands(_Symbol, _Period, BOLLINGER_PERIOD, 0 , 2, PriceInfo[1].close /*PRICE_CLOSE*/); // (ativo, timeframe, velas, shift, desvio padrão, valor de referência da vela)
	
    CopyBuffer(BollingerBandsDefinition, 2, 0, 3, LowerBandArray); // Buffer 1
	
    double this_band = LowerBandArray[shift_bar];
    return this_band;

}




// Verificar se a chamada está ativa no Routines>OnNewTradingFloorLoads
// 
void Bollinger_Routine()
{

	//+------------------------------------------------------------------+
	//| BOLLINGER														 |
	//+------------------------------------------------------------------+

	int BollingerBandsDefinition = iBands(_Symbol, _Period, BOLLINGER_PERIOD, 0 , 2, PriceInfo[1].close /*PRICE_CLOSE*/); // (ativo, timeframe, velas, shift, desvio padrão, valor de referência da vela)
	CopyBuffer(BollingerBandsDefinition, 1, 0, 3, UpperBandArray); // Buffer 1
	CopyBuffer(BollingerBandsDefinition, 2, 0, 3, LowerBandArray); // Buffer 2

	//UpperBandValue = UpperBandArray[0];
	//LoweBandValue  = LowerBandArray[0];
	//____________________________________________________________________+



}