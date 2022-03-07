



//string File_Name_Minute_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - Minute Resume.csv";





string File_Resume_CSV = Symbol() +  " - Resume" + " " + (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) +  ".csv";
string File_Resume_Deals_CSV = Symbol() +  " - Trade Resume" + " " + (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + ".csv";
string File_Resume_Hourly_CSV = Symbol() +  " - H1 Resume" + " " + (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3)+ ".csv";
string File_Resume_Quarter_CSV = Symbol() +  " - M15 Resume" + " " + (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3)+ ".csv";
string File_Resume_Daily_CSV = Symbol() +  " - Daily Resume" + " " + (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3)+ ".csv";



/*
string File_Resume_Deals_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - Resume_Deals.csv";
string File_Resume_Hourly_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - H1 Resume.csv";
string File_Resume_Quarter_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - M15 Resume.csv";
string File_Resume_Daily_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - Day Trade Resume.csv";
*/


bool TIME_TRADE_FILTER_OK                          = true;
bool DAY_TRADE_FILTER_OK                           = true;


input bool GENERATE_DEAL_RESUME = true; // Gerar Relatório - por Trade
input bool GENERATE_M1_RESUME = false; // Gerar Relatório - M1
input bool GENERATE_M15_RESUME = true; // Gerar Relatório - M15
input bool GENERATE_H1_RESUME = true; // Gerar Relatório - H1


// Não pode ser modificado em tempo de execução
void InitInputsAssign()
{
    SELECTED_SO = SO;
    SELECTED_VER = VER;
	SELECTED_EN_MODE = EN_MODE;
}


void ResetInputs()
{

	SELECTED_SO = SO;
  SELECTED_VER = VER;
	SELECTED_EN_MODE = EN_MODE;


	
	SELECTED_TP_ON = TP_ON;
	SELECTED_SL_ON = SL_ON;


	SELECTED_LONG_POSITION_ON = LONG_POSITION_ON; 
	SELECTED_SHORT_POSITION_ON  = SHORT_POSITION_ON; 


	SELECTED_DEVIATION = DEVIATION;

	SELECTED_LIMIT_LOSS_DAY = LIMIT_LOSS_DAY;
	SELECTED_LIMIT_PROFIT_DAY =LIMIT_PROFIT_DAY;


	SELECTED_TRADE_STRATEGY_CHOSEN = TRADE_STRATEGY_CHOSEN;



	SELECTED_EST_EN_ANCHOR_CHOSEN = INPUT_EN_EST_ANCHOR_CHOSEN;
	SELECTED_EST_EN_DISTANCE_CHOSEN = INPUT_EN_EST_DISTANCE_CHOSEN;
	SELECTED_EST_VOLUME_CHOSEN = INPUT_EN_EST_VOLUME_CHOSEN;
	SELECTED_EST_TP_ANCHOR_CHOSEN = INPUT_TP_EST_ANCHOR_CHOSEN;
	SELECTED_EST_TP_DISTANCE_CHOSEN = INPUT_TP_EST_DISTANCE_CHOSEN;
	SELECTED_EST_SL_ANCHOR_CHOSEN = INPUT_SL_EST_ANCHOR_CHOSEN;
	SELECTED_EST_SL_DISTANCE_CHOSEN = INPUT_SL_EST_DISTANCE_CHOSEN;  


	SELECTED_EST_TREND_CHOSEN = INPUT_TREND_EST_CHOSEN;
	SELECTED_HACKING_STRATEGY_CHOSEN = HACKING_STRATEGY_CHOSEN;
	//SELECTED_TRAILING_STOP_DISTANCE = eOrTrailing_Stop_System;
	//SELECTED_TRAILING_STOP_CHOSEN = eOrTrailing_Stop_System;
	
	
	// SELECTED_VOLUME_LONG  =  (EN_Volume_Long * r_SYMBOL_VOLUME_MIN); // VOLUME LONG (por entrada)
	// SELECTED_VOLUME_SHORT =  (EN_Volume_Short * r_SYMBOL_VOLUME_MIN); // VOLUME SHORT (por entrada)
	
	//SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME;
	// SELECTED_LIMIT_ORDER_VOLUME	= LIMIT_ORDER_VOLUME;


	//MIN_REDUCE_DISTANCE = MIN_REDUCE_DISTANCE;
	//MIN_ADD_DISTANCE = MIN_ADD_DISTANCE;
	
	SELECTED_BUY_FIRST = BUY_FIRST;
	SELECTED_SELL_FIRST = SELL_FIRST;

	SELECTED_MINIMUN_POSITION_VOLUME = MINIMUN_POSITION_VOLUME;

}


//chado do OnInitLoads
void Assigns()
{
    ArraySetAsSeries(PriceInfo, true);
	ArrayResize(Historic_BarSize, 1440);
    ArrayResize(Historic_Day_BarSize, 1440);
}



void SO_RestartArgs()
{
	OnInit_RestartVars();
}


void StartHistoricLoad()
{
	end=TimeCurrent();
	//start=end-days*PeriodSeconds(PERIOD_D1);
	start=end-HistoricDays*PeriodSeconds(PERIOD_D1); // suspeito 1
	PrintFormat("Limites do histórico de negociação carregado: início - %s, fim - %s",
				TimeToString(start),TimeToString(end));
	InitCounters();

}

void NewYearRoutine()
{
//	Write_File_CSV(File_Name_Year_CSV);
	SYMBOL_ANNUALLY_MAX_DRAWDOWN = 0;
	SYMBOL_ANNUALLY_MAX_RISE = 0;	
}
void NewMonthRoutine()
{
//	Write_File_CSV(File_Name_Month_CSV);
	SYMBOL_MONTHLY_MAX_DRAWDOWN = 0;
	SYMBOL_MONTHLY_MAX_RISE = 0;	
}
void NewWeekRoutine()
{
	//Write_File_CSV(File_Name_Weak_CSV);
	SYMBOL_WEEKLY_MAX_DRAWDOWN = 0;
	SYMBOL_WEEKLY_MAX_RISE = 0;	
}

void NewDayRoutine()
{
	//StartDayManagement();
	StartDayRoutine();
	SYMBOL_DAILY_CURRENT_BALANCE = 0;
	SYMBOL_DAILY_LOWEST_LOW = 0;
	SYMBOL_DAILY_HIGHEST_HIGH = 0;


	SYMBOL_DAILY_MAX_DRAWDOWN = 0;
	SYMBOL_DAILY_MAX_RISE = 0;

}


void NewHourRoutine()
{
	if(GENERATE_H1_RESUME && TIME_STATUS == 1)
	{
		Write_File_Hourly_CSV(File_Resume_Hourly_CSV);
	}
	Reset_Hourly_Resume();

}

void NewQuarterRoutine()
{ 
	if(GENERATE_M15_RESUME && TIME_STATUS == 1)
	{
		Write_File_Quarter_CSV(File_Resume_Quarter_CSV);
	}
	Reset_Quarter_Resume();
}
	
void NewMinuteRoutine()
{
	Position_Symbol_Loads();
	// CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
	// CurrentTradingStatus = Trading_Status(1);
	
	Set_Daily_Resume();  
	if(GENERATE_M1_RESUME && TIME_STATUS == 1)
	{
		Write_File_CSV(File_Resume_CSV);
	}
	EndDayManagement();
}

bool FINANCIAL_RISK = false;
void NewSecoundRoutine()
{
	ResetInputs();
	FINANCIAL_RISK = Trade_Balance_Management();
	Set_SO(5);
}



int END_DAY_CHECK_LOCK = 0;
void EndDayManagement()
{
	TIME_STATUS = TimeTradeCheck();

	if(TIME_STATUS == 3 || RESUME_STATUS == 1 )
	{
		if(END_DAY_CHECK_LOCK == 0)
		{
			EndDayRoutine();
			END_DAY_CHECK_LOCK = 1; 
		}
	}
	else
	{
		END_DAY_CHECK_LOCK = 0;
	}
}



//+==================================================================+
//| OnInit 															 
//+==================================================================+


int OnInitLoads()
{
	Load_Cookies();
	Server_Symbol_Constants_For_Init();
	StartHistoricLoad();
	AccountInfo();
	Validations(); 
	ServerInfs(); 

	last_tm_dt =  TimeTradeServer();
	// Precisa verifiar se o dia é outro ao iniciar
	MqlDateTime str1; 
   	datetime tc=TimeCurrent();
	TimeToStruct(tc,str1);
	int day_of_year = str1.day_of_year;
	
	if(NextDay(day_of_year))
	{
		NewDayRoutine();
		CheckLongPer();
	}



	//--- Inicialização de variáveis 

	
	Set_Distance_Mode();
	Set_Volume_Mode();
	SetTradingMode();


	//End_Day_Reset_Args();

	
	
	//DYT_HistoryDeals();
	//Position_Symbol_Loads();

	//MyGetPositionData();


	Assigns(); 
	InitInputsAssign();
	
	
	SO_RestartArgs();
	
	MsgLog_OnInitLoad(); //log
	//int rTrima = OnInitRoutine_Tech_Trima();
	SO_Follow_ResetVars();


	PanelController();
	UpdatePanel_Full_Info();

	CreateFiles(); 
	CountAllOrdersForPairType();

	//OnInit_Dialog();

	return (0);


}



void OnDeinitLoads(const int reason)
{
	Set_Cookies();
	Set_Quarter_Resume();
	Set_Hourly_Resume();
	//UpdateFile();
	//OnDeinit_Dialog(reason);
	ResetAllDrawings();
}

int  OnTickLoads() //(nativo)
{
	// A prioridade nas chamadas é essencial! 
	Server_Symbol_Constants_For_OnTick();
	ResetInputs();

	Set_Distance_Mode();
	Set_Volume_Mode();
	
	Trade_Balance_Management();

	Position_Symbol_Loads();

	//if(countListening == 1 )
   // {
		CurrentTrend = Trend_Settings(SELECTED_EST_TREND_CHOSEN); // pode ser chamado do "time" routine para poupar recursos
		CurrentTradingStatus = Trading_Status(1);
	//}
	

	
	StartDayCheck(); //??? verificar se ainda tem utilidade
	CheckDrawingOn();
	
	//DYT_HistoryDeals();

	UpdatePanel_Full_Info();

	return (0);	
}

void  OnNewTradingFloorLoads()
{
	GetBars();
	SetSelectedLeftBar();
	
	
	Server_Symbol_Constants_For_OnNewTradingFloor();
	History_DB_info();
	Set_SO(1);
	
	//Range_Routine();
	//Candle_Pattern_Routine();
	
}

// call from OnTrade (nativo)
//-- Chamadas para qualquer modificação em oredem, posições e negócios
int OnTradeLoads()
{
	return (0);			
}	

//-- Chamadas apenas para negócios
void OnDeals_Routine()
{
	ResetInputs();
	Position_Symbol_Loads();
	UpdatePanel_Full_Info();
	//Set_SO(3);
	//DYT_HistoryDeals();
		
}	


//_______________________________________/_________________________________________


int StartDayRoutine_Counter = 0;
void StartDayCheck()
{
	if(IntradayBar == 1 && StartDayRoutine_Counter == 0)
	{ 
		StartDayRoutine_Counter += 1;
		StartDayRoutine_BarOne();
		//Print("First day on current month is: ",TimeDayOfWeek(datetime(TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+".1"))," Remember: (0 means Sunday,1,2,3,4,5,6)");
	}
	else if(StartDayRoutine_Counter > 1)
	{
		if(IntradayBar > 1)
		{
			StartDayRoutine_Counter = 0;
		}		
	}
}


void StartDayRoutine_BarOne()
{
//	StartDay_ResetVars(); 


}


void EndDayRoutine()
{
	Write_File_Daily_CSV(File_Resume_Daily_CSV);
	Write_File_Quarter_CSV(File_Resume_Quarter_CSV);
	Write_File_Hourly_CSV(File_Resume_Hourly_CSV);
	EndDay_ResetVars();
}

void StartDayRoutine()
{
	StartDay_ResetVars();
}
//--- Contabiliza os parâmetros do day trade.
void EndDayRoutine_old()
{

	//Print("First day on current month is: ",TimeDayOfWeek(datetime(TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+".1"))," Remember: (0 means Sunday,1,2,3,4,5,6)");
	
	//adicionar trades realizados e calcular as taxas.
	//criar arquivo txt com leitura em excel
	//em um arquivo de texto do excel, implementar estatiísticas diversas tal como tamanho médio das sombras, em geral, em determinados dias e em determinados horários. 
	

	//string File_Name = Symbol()+"_Deal_day.csv";
	//string day = TimeToString(TimeCurrent(),TIME_DATE|TIME_SECONDS);
	string day = TimeToString(TimeCurrent(),TIME_DATE);
	//string      l_date 	      = TimeToString(TimeLocal(),TIME_DATE);
	string      date_year     = StringSubstr(day, 0, 4);
	string      date_month     = StringSubstr(day, 5,2);
	string      date_day    = StringSubstr(day, 8, 2);

/*
	File_Write_Resume_Day(//day,
						date_year,
						date_month,
						date_day,
						//DayOfWeek(TimeLocal()),
						DayOfWeek(),
						TOTAL_DEALS_DAY,
						TOTAL_DEAL_ENTRY_IN,
						TOTAL_DEAL_ENTRY_OUT,
						TOTAL_DEAL_REASON_SL,
						TOTAL_DEAL_REASON_TP,
						TOTAL_DEAL_ENTRY_INOUT,
						TOTAL_DEAL_ENTRY_OUT_BY,
						round(MAX_REALIZED_LOSS_DAY),
						round(MAX_REALIZED_PROFIT_DAY),
						round(rCurrentDayBalance)
						);
	*/	
	//Comment("time " + time);
	//UpdateData_Prior()	;
}

void StartDay_ResetVars()
{
	SYMBOL_DAILY_LOWEST_LOW = 0;
	SYMBOL_DAILY_HIGHEST_HIGH = 0;

	SYMBOL_DAILY_MAX_DRAWDOWN = 0;
	SYMBOL_DAILY_MAX_RISE = 0;

	//RESUME_STATUS = 0;
	//TIME_STATUS = 0;

}

void EndDay_ResetVars()
{
	//TOTAL_SYMBOL_DAY_DEAL_BALANCE		 = 0;
	DAY_TRADE_FILTER_OK                  = true;
	//rCurrentDayResult                    = 0; 
	rCurrentDayBalance 					 = 0;
	

	countDayOrdersSend = 0;
	countDayOrdersCancel = 0;
	countDayOrdersDeals = 0;
	maxCountDayDeal = 0;

	
	//Tech_Range_Reset_Vars();
	
	//SO_Follow_ResetVars();
	//Sys_Range_ResetVars();
	
	//Print("RestartArgs");
	//ResetAllDrawings();

}

void OnInit_RestartVars()
{
	SO_Follow_ResetVars();
	Sys_Range_ResetVars();
	ResetAllDrawings();
}





//--- Zera os parâmetros do day trade.

int nUpdateStartDayInfsCounter 			    = 0;
void StartDayInfs()
{
	nUpdateStartDayInfsCounter += 1;
}




//_______________________________________/_________________________________________
//+------------------------------------------------------------------+
//| Files															 |
//+------------------------------------------------------------------+	


void CreateFiles()
{

	//Gen_File_Read_Array(File_Cookie_Name, File_Cookie_Lines, File_Cookies_Info);


	//Create_File_CSV(File_Resume_CSV);
	Create_File_Deals_CSV(File_Resume_Deals_CSV);
	Create_File_Daily_CSV(File_Resume_Daily_CSV);
	Create_File_Quarter_CSV(File_Resume_Quarter_CSV);
	Create_File_Hourly_CSV(File_Resume_Hourly_CSV);
	

}



void UpdateFile()
{
		//Load_Cookies();


        //Change_File_Statistics(1, (string)SYMBOL_DAILY_LOWEST_LOW);
        //Change_File_Statistics(2, (string)SYMBOL_DAILY_HIGHEST_HIGH);	
        //Change_File_Statistics(3, (string)SYMBOL_DAILY_CURRENT_BALANCE);	
        //Change_File_Statistics(4, (string)LAST_DEAL_RESULT);	
		//ReadFileToAlert();
}


