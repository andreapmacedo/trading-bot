//--- Moving Avarage


//+------------------------------------------------------------------+
// Moving Avarages
//+------------------------------------------------------------------+
//https://www.mql5.com/pt/docs/common/periodseconds

int MA_SLOW 		        	= 200;
int MA_REF        		  	= 34;
input int MainMaPeriod            		= 17; // TÉCNICO - Média Móvel Principal - Período - (Valor)
input string MainMaTimeFrame          		= "0"; // TÉCNICO - Média Móvel Principal - "Time Frame" - (Valor)


double MA_SLOW_VALUE;
double MA_REF_VALUE;
double MA_FAST_VALUE;
double MA_TRAILING_TRIGGER_VALUE;


int MA_FAST_SHIFT                   = 0;       
int MA_SLOW_SHIFT                   = 0;       
int MA_REF_SHIFT                    = 0;       


bool EMA_MODE                        = false;   //input      

double MovingAvarageArray[]; 

//+------------------------------------------------------------------+
// Moving Average
//+------------------------------------------------------------------+

//--- plotar iMA



// Verificar se a chamada está ativa no Routines>Assigns
void MA_Asserts() // 
{
	ArraySetAsSeries(MovingAvarageArray, true);    
}


// esta funcçõa é chamada especificamente para retornar o valor da média requisitada
double Get_MA(int MA_PERIOD, int ma_shift, ENUM_MA_METHOD ma_method, int left_bar)
{
	/*
	input int                  MA_SLOW=10;                 // período da média móvel
	input int                  ma_shift=0;                   // deslocamento
	input ENUM_MA_METHOD       ma_method=MODE_SMA;           // tipo de suavização
	input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE;    // tipo de preço
	input string               symbol=" ";                   // símbolo
	input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;        // timeframe	

	*/
	
	
	double EMovingAvarageArray[]; 
	  
	//int MovingAvarageDefinition  = iMA(_Symbol, _Period, MA_PERIOD, ma_shift, ma_method, PRICE_CLOSE);
	int MovingAvarageDefinition  = iMA(_Symbol, MA_Period, MA_PERIOD, ma_shift, ma_method, PRICE_CLOSE);
	
	
	ArraySetAsSeries(EMovingAvarageArray, true);
	CopyBuffer(MovingAvarageDefinition, 0, 0, 10, EMovingAvarageArray);

	//PlotIndexSetInteger(10, PLOT_LINE_COLOR, clrBlue);
    //PlotIndexSetInteger(0,PLOT_LINE_COLOR, 0, clrBlue);
	
	//double MA_Last_Value = EMovingAvarageArray[0];
	double MA_Last_Value = EMovingAvarageArray[left_bar];
	
	return MA_Last_Value;

}
double Get_MA_TF(int MA_PERIOD, ENUM_TIMEFRAMES tf, int ma_shift, ENUM_MA_METHOD ma_method, int left_bar)
{
	/*
	input int                  MA_SLOW=10;                 // período da média móvel
	input int                  ma_shift=0;                   // deslocamento
	input ENUM_MA_METHOD       ma_method=MODE_SMA;           // tipo de suavização
	input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE;    // tipo de preço
	input string               symbol=" ";                   // símbolo
	input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;        // timeframe	

	*/
	
	double EMovingAvarageArray[]; 
	  
	int MovingAvarageDefinition  = iMA(_Symbol, tf, MA_PERIOD, ma_shift, ma_method, PRICE_CLOSE);
	
	
	ArraySetAsSeries(EMovingAvarageArray, true);
	CopyBuffer(MovingAvarageDefinition, 0, 0, 10, EMovingAvarageArray);

	//PlotIndexSetInteger(10, PLOT_LINE_COLOR, clrBlue);
    //PlotIndexSetInteger(0,PLOT_LINE_COLOR, 0, clrBlue);
	
	//double MA_Last_Value = EMovingAvarageArray[0];
	double MA_Last_Value = EMovingAvarageArray[left_bar];
	
	return MA_Last_Value;

}


double Get_TEMA(int MA_PERIOD, int ma_shift, int left_bar)
{
	/*
	input int                  MA_SLOW=10;                 // período da média móvel
	input int                  ma_shift=0;                   // deslocamento
	input ENUM_MA_METHOD       ma_method=MODE_SMA;           // tipo de suavização
	input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE;    // tipo de preço
	input string               symbol=" ";                   // símbolo
	input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;        // timeframe	

	*/
	
	double EMovingAvarageArray[]; 
	  
	int MovingAvarageDefinition  = iTEMA(_Symbol, _Period, MA_PERIOD, ma_shift,  PRICE_CLOSE);
	
	
	ArraySetAsSeries(EMovingAvarageArray, true);
	CopyBuffer(MovingAvarageDefinition, 0, 0, 10, EMovingAvarageArray);

	//PlotIndexSetInteger(10, PLOT_LINE_COLOR, clrBlue);
    //PlotIndexSetInteger(0,PLOT_LINE_COLOR, 0, clrBlue);
	
	//double MA_Last_Value = EMovingAvarageArray[0];
	double MA_Last_Value = EMovingAvarageArray[left_bar];
	
	return MA_Last_Value;

}

double Get_AMA(int per, int ma_fast, int ma_slow, int ma_shift, int left_bar)
{
	/*
	input int                  MA_SLOW=10;                 // período da média móvel
	input int                  ma_shift=0;                   // deslocamento
	input ENUM_MA_METHOD       ma_method=MODE_SMA;           // tipo de suavização
	input ENUM_APPLIED_PRICE   applied_price=PRICE_CLOSE;    // tipo de preço
	input string               symbol=" ";                   // símbolo
	input ENUM_TIMEFRAMES      period=PERIOD_CURRENT;        // timeframe	

	*/
	
	double EMovingAvarageArray[]; 
	  
	//int MovingAvarageDefinition  = iTEMA(_Symbol, _Period, MA_PERIOD, ma_shift,  PRICE_CLOSE);
	int MovingAvarageDefinition  = iAMA(_Symbol, _Period, per, ma_fast, ma_slow, ma_shift,  PRICE_CLOSE);
	
	
	ArraySetAsSeries(EMovingAvarageArray, true);
	CopyBuffer(MovingAvarageDefinition, 0, 0, 10, EMovingAvarageArray);

	//PlotIndexSetInteger(10, PLOT_LINE_COLOR, clrBlue);
    //PlotIndexSetInteger(0,PLOT_LINE_COLOR, 0, clrBlue);
	
	//double MA_Last_Value = EMovingAvarageArray[0];
	double MA_Last_Value = EMovingAvarageArray[left_bar];
	
	return MA_Last_Value;

}


// Verificar se a chamada está ativa no Routines>OnNewTradingFloorLoads
// Essa rotina é permanente na chamada do cod
void MA_Routine()
{

	int MovingAvarageDefinition;

	MovingAvarageDefinition  = iMA(_Symbol, _Period, MA_SLOW, MA_SLOW_SHIFT, MODE_EMA, PRICE_CLOSE);
    /*
	if(EMA_MODE)
	{
		MovingAvarageDefinition  = iMA(_Symbol, _Period, MA_SLOW, MA_SLOW_SHIFT, MODE_EMA, PRICE_CLOSE);
	}
	else
	{
		MovingAvarageDefinition  = iMA(_Symbol, _Period, MA_SLOW, MA_SLOW_SHIFT, MODE_SMA, PRICE_CLOSE);
	}
	*/

    CopyBuffer(MovingAvarageDefinition, 0, 0, 10, MovingAvarageArray);

}
	//____________________________________________________________________+








/*

uint                 InpPeriod         =  50;            // Period
ENUM_APPLIED_PRICE   InpAppliedPrice   =  PRICE_CLOSE;   // Applied price
//--- indicator buffers
double         BufferTMA[];
double         BufferMA[];
//--- global variables
int            period_ma;
int            handle_ma;
int            N;


int OnInitRoutine_Tech_Trima()
{
	//--- set global variables
   period_ma=int(InpPeriod<1 ? 1 : InpPeriod);
   N=(int)ceil(double(period_ma+1)/2.0);
//--- indicator buffers mapping
   SetIndexBuffer(0,BufferTMA,INDICATOR_DATA);
   SetIndexBuffer(1,BufferMA,INDICATOR_CALCULATIONS);
//--- setting indicator parameters
   IndicatorSetString(INDICATOR_SHORTNAME,"TriMA("+(string)period_ma+")");
   IndicatorSetInteger(INDICATOR_DIGITS,Digits());
//--- setting buffer arrays as timeseries
   ArraySetAsSeries(BufferTMA,true);
   ArraySetAsSeries(BufferMA,true);
//--- create MA's handle
   ResetLastError();
   handle_ma=iMA(NULL,PERIOD_CURRENT,N,0,MODE_SMA,InpAppliedPrice);
   if(handle_ma==INVALID_HANDLE)
     {
      Print("The iMA(",(string)N,") object was not created: Error ",GetLastError());
      return INIT_FAILED;
     }
//---
   return(INIT_SUCCEEDED);
} 
/*
double OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
{
//--- Verificando o número mínimo de barras para cálculo
	if(rates_total<N+1) return 0;
	//--- Verificando e calculando o número de barras calculadas
	int limit=rates_total-prev_calculated;
	if(limit>1)
		{
		limit=rates_total-N-1;
		ArrayInitialize(BufferTMA,EMPTY_VALUE);
		ArrayInitialize(BufferMA,0);
		}
	//--- Preparação de dados
	int copied=0,count=(limit==0 ? 1 : rates_total);
	copied=CopyBuffer(handle_ma,0,0,count,BufferMA);
	if(copied!=count) return 0;
	//--- Cálculo do indicador
	for(int i=limit; i>=0 && !IsStopped(); i--)
		BufferTMA[i]=MAOnArray(BufferMA,0,N,0,MODE_SMA,i);

	//--- return value of prev_calculated for next call
	//return(rates_total);
	return(BufferTMA[0]);
  }


double GetTrima()
{
		for(int i=InpPeriod; i>=0 ; i--)
			BufferTMA[i]=MAOnArray(BufferMA,0,N,0,MODE_SMA,i);

	return(BufferTMA[0]);

}





double MAOnArray(double &array[],int total,int period,int ma_shift,int ma_method,int shift)
{







double buf[],arr[];
if(total==0) total=ArraySize(array);
if(total>0 && total<=period) return(0);
if(shift>total-period-ma_shift) return(0);
//---
switch(ma_method)
	{
	case MODE_SMA :
	{
		total=ArrayCopy(arr,array,0,shift+ma_shift,period);
		if(ArrayResize(buf,total)<0) return(0);
		double sum=0;
		int    i,pos=total-1;
		for(i=1;i<period;i++,pos--)
		sum+=arr[pos];
		while(pos>=0)
		{
		sum+=arr[pos];
		buf[pos]=sum/period;
		sum-=arr[pos+period-1];
		pos--;
		}
		return(buf[0]);
	}
	case MODE_EMA :
	{
		if(ArrayResize(buf,total)<0) return(0);
		double pr=2.0/(period+1);
		int    pos=total-2;
		while(pos>=0)
		{
		if(pos==total-2) buf[pos+1]=array[pos+1];
		buf[pos]=array[pos]*pr+buf[pos+1]*(1-pr);
		pos--;
		}
		return(buf[shift+ma_shift]);
	}
	case MODE_SMMA :
	{
		if(ArrayResize(buf,total)<0) return(0);
		double sum=0;
		int    i,k,pos;
		pos=total-period;
		while(pos>=0)
		{
		if(pos==total-period)
			{
			for(i=0,k=pos;i<period;i++,k++)
				{
				sum+=array[k];
				buf[k]=0;
				}
			}
		else sum=buf[pos+1]*(period-1)+array[pos];
		buf[pos]=sum/period;
		pos--;
		}
		return(buf[shift+ma_shift]);
	}
	case MODE_LWMA :
	{
		if(ArrayResize(buf,total)<0) return(0);
		double sum=0.0,lsum=0.0;
		double price;
		int    i,weight=0,pos=total-1;
		for(i=1;i<=period;i++,pos--)
		{
		price=array[pos];
		sum+=price*i;
		lsum+=price;
		weight+=i;
		}
		pos++;
		i=pos+period;
		while(pos>=0)
		{
		buf[pos]=sum/weight;
		if(pos==0) break;
		pos--;
		i--;
		price=array[pos];
		sum=sum-lsum+price*period;
		lsum-=array[i];
		lsum+=price;
		}
		return(buf[shift+ma_shift]);
	}
	default: return(0);
	}
return(0);
}
*/




