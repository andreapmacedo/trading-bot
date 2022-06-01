






//+-------------------------------------------------------------------+
//| Symbol Info                                                       |
//+-------------------------------------------------------------------+



	double SERVER_SYMBOL_POINT; // Valor de um ponto do ativo
	double SERVER_SYMBOL_TRADE_TICK_SIZE; // Mínima mudança de preço. (tick mínimo)
	double SERVER_SYMBOL_VOLUME_LIMIT; // //Mínimo passo de mudança de volume para execução de uma operação (deal)
	
	double SERVER_SYMBOL_VOLUME_MAX; // //Máximo volume para uma operação (deal)
	double SERVER_SYMBOL_VOLUME_MIN; // Mínimo volume para uma operação (deal)


	double SERVER_SYMBOL_ASK;  
	double SERVER_SYMBOL_BID;  
	double SERVER_SYMBOL_LAST; // Preço da último operação (deal) (ok)
	
	/* 
	(NOT WORK)
	double SERVER_SYMBOL_SESSION_CLOSE;  
	double SERVER_SYMBOL_SESSION_OPEN;   
	double SERVER_SYMBOL_VOLUME_REAL;// Volume da última operação (deal)
	double SERVER_SYMBOL_VOLUMEHIGH_REAL;  // Volume diário máximo
	double SERVER_SYMBOL_VOLUMELOW_REAL; //Volume diário mínimo
	double SERVER_SYMBOL_SESSION_VOLUME; 
    //double SERVER_SYMBOL_SESSION_AW; // Preço médio ponderado da sessão atual (not work) talvez opções 
	*/
     
    double SERVER_SYMBOL_LASTHIGH; //Máximo dos preços negociados do dia (ok) 
    double SERVER_SYMBOL_LASTLOW; //Mínimo dos preços negociados do dia (ok) 
    int SERVER_SYMBOL_SPREAD; // Valor do spread em pontos
//double SERVER_

//https://www.mql5.com/pt/docs/constants/environment_state/marketinfoconstants




void Server_Symbol_Constants_For_Init()
{
	SERVER_SYMBOL_POINT = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_POINT),_Digits);
	SERVER_SYMBOL_TRADE_TICK_SIZE = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE), _Digits);
	SERVER_SYMBOL_VOLUME_LIMIT = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_LIMIT), _Digits);
	SERVER_SYMBOL_VOLUME_MAX = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX), _Digits);
	SERVER_SYMBOL_VOLUME_MIN = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN), _Digits);

	
}


void Server_Symbol_Constants_For_OnTick()
{

	// double
	SERVER_SYMBOL_ASK = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_ASK), _Digits);
	SERVER_SYMBOL_BID = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_BID), _Digits);
    SERVER_SYMBOL_LAST = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_LAST),_Digits);
//SERVER_SYMBOL_LASTHIGH = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_LASTHIGH),_Digits);
   // SERVER_SYMBOL_LASTLOW = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_LASTLOW),_Digits);	
   	/*
	(NOT WORK)
    SERVER_SYMBOL_SESSION_VOLUME = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_SESSION_VOLUME),_Digits);	
	*/

	
	// interger
	//SERVER_SYMBOL_SPREAD = NormalizeDouble(SymbolInfoInteger(_Symbol, SYMBOL_SPREAD),_Digits);	
}


void Server_Symbol_Constants_For_OnTrade()
{
	//SERVER_SYMBOL_LAST = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_LAST),_Digits);
}

void Server_Symbol_Constants_For_OnNewTradingFloor()
{

	/*
	(NOT WORK)
	//SERVER_SYMBOL_SESSION_CLOSE = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_SESSION_CLOSE), _Digits); 
	//SERVER_SYMBOL_SESSION_OPEN = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_SESSION_OPEN), _Digits);
    //SERVER_SYMBOL_VOLUME_REAL = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_REAL),_Digits);
    //SERVER_SYMBOL_VOLUMEHIGH_REAL = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUMEHIGH_REAL),_Digits);
    //SERVER_SYMBOL_VOLUMELOW_REAL = NormalizeDouble(SymbolInfoDouble(_Symbol, SYMBOL_VOLUMELOW_REAL),_Digits);	
	*/


}





//+------------------------------------------------------------------+
//| Prior                                                            |
//+------------------------------------------------------------------+

void UpdateData_Prior()
{
	//LAST_CLOSE_DAY = iClose(_Symbol, PERIOD_D1, 1);
	//LAST_HIGH_DAY = iHigh(_Symbol, PERIOD_D1, 1);
	//LAST_LOW_DAY = iLow(_Symbol, PERIOD_D1, 1);
	//LAST_HIGHEST_DAY = iHighest(_Symbol, PERIOD_D1, 1);
	//LAST_LOWEST_DAY = iLowest(_Symbol, PERIOD_D1, 1);
	
}




//+------------------------------------------------------------------+
// Ajuste
//+------------------------------------------------------------------+
void AdjustmentF()
{
	/*
	IntradayBar = iBarShift(_Symbol, 0, iTime(_Symbol, PERIOD_D1, 0));
	double aux_high  = 0.0;
	double aux_low   = 0.0;
	double aux_med   = 0.0;
	double aux_vol   = 0.0;
 
	double aux_sum = 0.0;
	double sum_qtd = 0.0;
	double sum_qtd_price = 0.0;
	
	if (IntradayBar == 1)
	{
		for (int i = 0; i < 10; i++)
        {  

			aux_high   = iHigh(_Symbol, PERIOD_M1, 130+i);
			aux_low    = iLow(_Symbol,  PERIOD_M1, 130+i);
			aux_med    = (aux_high + aux_low)/2;
			//aux_med   = iClose(_Symbol,  PERIOD_M1, 130+i);
			aux_vol    = iVolume(_Symbol, PERIOD_M1, 130+i);
			aux_sum    = aux_sum + ( aux_med * aux_vol);
			sum_qtd    = sum_qtd + aux_vol;

          
        } // end for
		if (sum_qtd >0)
		ADJUSTMENT = aux_sum / sum_qtd;
	}
	*/
	/*
	ObjectDelete(_Symbol, "Ajuste");
	DrawObjectRectangle("Ajuste", PriceInfo[IntradayBar].time, ADJUSTMENT-0.5, PriceInfo[0].time, ADJUSTMENT+0.5, clrYellow);
	
	ObjectDelete(_Symbol, "LH");
	DrawObjectRectangle("LH", PriceInfo[IntradayBar].time, LAST_HIGH_DAY, PriceInfo[0].time, LAST_HIGH_DAY+0.5, clrRed);
	
	ObjectDelete(_Symbol, "LL");	
	DrawObjectRectangle("LL", PriceInfo[IntradayBar].time, LAST_LOW_DAY, PriceInfo[0].time, LAST_LOW_DAY+0.5, clrBlue);
*/
	
}




// bagunça

void History_DB_info()
{

	OCHLArgs();
	DayArgs();
	Infs_UpdateData_OLHC(); // avaliar quem está utilizando estas variáveis e chamar esta função apenas por quem for utiliza-se dela
	//bagunca(); //techinical_indicator
	
	


}





void OCHLArgs()
{
	//-RESET VARS
	Avg_Day_BreakOut = 0;
	Biggest_BarSize = 0;

	if (IntradayBar > 1)// começa da barra 2
	{
		// por período
		if(IntradayBar > LEFT_BARS)
		{
			//int startRun = IntradayBar-Historic_Lenght;
			for (int i = LEFT_BARS; i > 0; i--) // vai 8x
			{
				double barSize = PriceInfo[i].high - PriceInfo[i].low;
				//Volume desabilitdo	
				//Avg_FinVol = (Avg_FinVol + FinVol[i]);
				
				// AVGs
				Avg_OCHL_BarSize = Avg_OCHL_BarSize + (barSize); 	
				
				
				// Média de distância de rompimento de vela.
				if(PriceInfo[i-1].high > PriceInfo[i].high)
				{
					Avg_Day_BreakOut = Avg_Day_BreakOut + (PriceInfo[i-1].high - PriceInfo[i].high); 
				}
				// Maior barra	
				if(barSize > Biggest_BarSize)
				{                   
					Biggest_BarSize = barSize;
					Biggest_OCHL_BarPosition = IntradayBar-i; 
				}
			} 
		}

		//Avg_FinVol = (Avg_FinVol / LEFT_BARS);

		//AVGs por OCHL
		Avg_OCHL_BarSize = MyRound(Avg_OCHL_BarSize / LEFT_BARS);
		Avg_Day_BreakOut = (Avg_Day_BreakOut/LEFT_BARS);
		//Avg_OCHL_BreakDown	
	}

}




void DayArgs()
{
	// por dia
	for (int i = 0; i < IntradayBar; i++)
	{  
		double barSize = PriceInfo[i].high - PriceInfo[i].low;
		Historic_BarSize[i] = barSize;

		if(barSize > Biggest_Day_BarSize)
		{                   
			Biggest_Day_BarSize = barSize;
			Biggest_Day_BarPosition = IntradayBar-1; 
		} 		
	}

}








//+------------------------------------------------------------------+
//| OLHC
//+------------------------------------------------------------------+


double rLAST_HIGH         		= 0.0;
double rLAST_LOW     	   		= 0.0;
double rLAST_CLOSE  	   		= 0.0;
double r_LAST_BAR_SIZE     		= 0.0;
double r_LAST_BAR_30       		= 0.0;
double r_LAST_BAR_50       	    = 0.0;
double r_LAST_BAR_90     	    = 0.0;

double rBEFORE_HIGH         	= 0.0;
double rBEFORE_LOW     	  		= 0.0;
double rBEFORE_CLOSE  	  		= 0.0;
double rBEFORE_BAR_SIZE			= 0.0;
double rBEFORE_BAR_50_SIZE		= 0.0;
double rBEFORE_BAR_61_SIZE		= 0.0;
double rBEFORE_BAR_50			= 0.0;
double rBEFORE_BAR_61			= 0.0;
double rBEFORE_BAR_X_SIZE	    = 0.0;
double rBEFORE_BAR_X_SIZE_TP    = 0.0;
double rBEFORE_BAR_X_SIZE_SL    = 0.0;


//--- distância do fechamento em relação a máxima
double rLAST_CLOSE_HIGH_DST    = 0.0;
//--- distância do fechamento em relação a máxima
double rLAST_CLOSE_LOW_DST     = 0.0;

double X_SIZE                  = 1 ;
double X_SIZE_TP  	                 = 1 ; //input
double X_SIZE_SL                     = 1 ; //input
double X_SIZE_IN                     = 1 ; //input



double r_B_LastClose;



//MYV
void Infs_UpdateData_OLHC()
{
	
	r_B_LastClose       = rBEFORE_CLOSE;	
	
	
	rLAST_HIGH 			= rBEFORE_HIGH;
	rLAST_LOW 			= rBEFORE_LOW;
	rLAST_CLOSE 		= rBEFORE_CLOSE;
	r_LAST_BAR_SIZE 	= NormalizeDouble(rLAST_HIGH - rLAST_LOW, _Digits);
	r_LAST_BAR_50       = NormalizeDouble((r_LAST_BAR_SIZE/2), _Digits);	

	rBEFORE_HIGH 		= NormalizeDouble(PriceInfo[1].high, _Digits);
	rBEFORE_LOW 		= NormalizeDouble(PriceInfo[1].low, _Digits);
	rBEFORE_CLOSE 		= NormalizeDouble(PriceInfo[1].close, _Digits);
	
	rBEFORE_BAR_SIZE    = MyRound(rBEFORE_HIGH - rBEFORE_LOW);
	
	rBEFORE_BAR_50_SIZE = MyRound(rBEFORE_BAR_SIZE/2);
	rBEFORE_BAR_61_SIZE = MyRound(rBEFORE_BAR_SIZE*0.61);
	rBEFORE_BAR_X_SIZE  = MyRound(rBEFORE_BAR_SIZE*X_SIZE);
	rBEFORE_BAR_50    	= MyRound(rBEFORE_HIGH - rBEFORE_BAR_50_SIZE);
	rBEFORE_BAR_61    	= MyRound(rBEFORE_HIGH - rBEFORE_BAR_61_SIZE);

	//BarPattern();
	if(rLAST_LOW > rBEFORE_LOW)
	{
		// GAP DE BAIXA
	}
}

