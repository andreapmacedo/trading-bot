#include "Vars.mq5"
//#include "Dialog_Main.mq5"
#include "Attr_Account_Information.mq5"
#include "Attr_Order_Properties.mq5"
#include "Attr_Market_Information.mq5"
#include "Attr_Network_Functions.mq5"
#include "Attr_Positions_Properties.mq5"
#include "Attr_Hitory_DYT.mq5"
#include "Attr_Hitory_SWT.mq5"
#include "Attr_Data_Server.mq5"
#include "Time.mq5"
#include "Cookies.mq5"
#include "Orders_Assembly.mq5"
#include "Order_Asserts.mq5"
#include "SO_Settings.mq5"
#include "SO_Gradient.mq5"
#include "SO_Follow_Controller.mq5"
#include "SO_Trading_Floor_Controller.mq5"
#include "SO_Pivot.mq5"
#include "SO_MA.mq5"
#include "STR_Settings.mq5"
//#include "SO_Bar_To_Bar.mq5"
#include "SO_Range.mq5"
#include "Orders_Settings.mq5"
#include "Orders_Anchor_Point.mq5"
#include "Orders_Distance.mq5"
#include "Orders_EN_Anchor.mq5"
#include "Orders_EN_Distance.mq5"
#include "Orders_Volume.mq5"
#include "Orders_Trailing_Stop.mq5"
#include "Tech_New_Floor.mq5"
#include "Tech_Candle_Patterns.mq5"
#include "Tech_Range.mq5"
#include "Tech_Reverse.mq5"
#include "Tech_Pivot.mq5"
#include "Tech_MA.mq5"
#include "Tech_Bollinger.mq5"
#include "Tech_Trend.mq5"
#include "Tech_Moving_Status.mq5"
#include "Tech_Trading_Status.mq5"
#include "Tech_Trigger_Signal.mq5"
#include "Deal.mq5"
#include "Routines.mq5"
#include "Deals_Management.mq5"
#include "Draws.mq5"
#include "Risk_Management.mq5"
#include "Useful.mq5"
#include "Files_Gen_T.mq5"
#include "Files_Gen_C.mq5"
#include "Logs.mq5"
#include "Controller_Panels.mq5"
#include "Validations.mq5"
#include "Resumes.mq5"
//#include "w_Personal_Marcelo.mq5"
//#include "w_Personal_Jorge.mq5"
//#include "Controller_Users.mq5"
#include "w_Personal_Full_Plan.mq5"

//_______________________________________/_________________________________________
bool ACC_OK = false; // não modificar
//+================================================================================+
//| OnInit															 			   |
//+================================================================================+ 
int OnInit()
{
	int call_01 =  OnInitLoads();	
	//+------------------------------------------------------------------+
	// TEMPORIZADOR
	//+------------------------------------------------------------------+	
	//--- do OnTime()	
	//--- criamos um temporizador com um período de 1 segundo	
	EventSetTimer(1);
	//time_routine=(time_routine/86400)*86400;
	//Alert("Day start time: "+(string)time_routine);
	//---//--- 
	//+------------------------------------------------------------------+		
	//--- do OnTrade()
	/*
	if (ON_TRADE_ON)
	{
		end=TimeCurrent();
		start=end-days*PeriodSeconds(PERIOD_D1);
		PrintFormat("Limites do histórico de negociação carregado: início - %s, fim - %s",
				   TimeToString(start),TimeToString(end));
		InitCounters();
	}
	*/
	//BUSINESS_PLAN = false;
	if(BUSINESS_PLAN)	{
		ACC_OK = Business_Plan_Verification();
	}	else {
		ACC_OK = true;		
	}	
	return(0);
}

bool Business_Plan_Verification()
{
	if(Account_Validation() && Account_Symbol_Validation() && Account_Time_Validation())
	{
		Print("Business Plan - ok");
		return true;
	} 
	Print("Business Plan - err");
	return false;
}

//+================================================================================+
// OnDeinit															 			   |
//+================================================================================+
void OnDeinit(const int reason)
{

	RemoveAllPanels();
	OnDeinitLoads(reason);
	//+------------------------------------------------------------------+
	//| TEMPORIZADOR													 |
	//+------------------------------------------------------------------+	
	//--- destruímos o temporizador no final do trabalho
	EventKillTimer();
} // end func OnDeinit()

//+================================================================================+
//| OnTick															               |
//+================================================================================+  
void OnTick()
{
	if(ACC_OK)
	{
		int call_01 = OnTickLoads();
		//+------------------------------------------------------------------+
		//| Time															 |
		//+------------------------------------------------------------------+

		datetime    time             = TimeTradeServer();//TimeLocal();
		string      hoursAndMinutes  = TimeToString(time, TIME_MINUTES);
		string      time_current     = StringSubstr(hoursAndMinutes, 0, 5);
		
		//+------------------------------------------------------------------+
		// Bar                                                               |
		//+------------------------------------------------------------------+

		int Data = CopyRates(Symbol(), Period(), 0, Bars(Symbol(), Period()), PriceInfo);

		bool                isNewBar            = false;            //
		//static int          candleCounter;
		static datetime     timeStampLastCheck;                     // Horário da última vela verificada.
		datetime            timeStampCurrentCandle;                 // Horário da vela atual.
		timeStampCurrentCandle = PriceInfo[0].time;                 // Horário da vela onde houve o primeiro negócio do dia.

		if (timeStampCurrentCandle != timeStampLastCheck){           // Verifica se houve negociáção em um novo horário de vela
			timeStampLastCheck   = timeStampCurrentCandle;
			isNewBar             = true;
		}
		//+------------------------------------------------------------------+
		// Day Trade infs 													 
		//+------------------------------------------------------------------+ 
		string day_trade_time_reset_infs = TRADING_TIME_END;
		if (time_current < day_trade_time_reset_infs){//TRADING_TIME_END) // 23:59
			nUpdateEndDayInfsCounter = 0;
		}
		//--- nUpdateEndDayInfsCounter -> vai evitar uma segunda chamada deste método no dia.
		if(time_current == day_trade_time_reset_infs && nUpdateEndDayInfsCounter == 0){
			//EndDayRoutine_old();
			//-- o contador evita uma nova chamada para este método enquanto houver novos negócios no horário definido para o período de chamada do método.
			nUpdateEndDayInfsCounter += 1;// = nEndDayInfsCounter+1;
		}
		//+==================================================================+
		// OnNewBar															 |
		//+==================================================================+  
		if (isNewBar){
			OnNewTradingFloorLoads();
		}// end (isNewBar)  
		CheckOrderSend(time);
	} // end (ACC_OK) 
}// end (OnTick)




