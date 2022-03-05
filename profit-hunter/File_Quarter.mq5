

void Create_File_Quarter_CSV(string FileName)
{
   int handle = FileOpen(FileName,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);



    if(handle>0)
    {
    //write file header
    FileSeek(handle,0,SEEK_SET);
    FileWrite(handle,

            "Conta",
            "Tipo",
            "Cliente",
            "Symbol",
            "Data",
            "Ano",
            "Dia(Ano)",
            "Semana",
            "Mes",
            "Dia",
            "Dia da Semana",
            "Hora",
            "Minuto",
           
           
            "DT Acm Máx",
            "DT Acm Mín",
            "DT Acm Vol",
            "DT Acm Tax",
            "DT Acm Blc",
            "DT Acm Liq",
           
           
            "M15 Máx",
            "M15 Mín",
            "M15 Vol",
            "M15 Tax",
            "M15 Blc",
            "M15 Liq",
            "Neg/min",
            
            
            
            "SO",
            "VER",
            "Modo Exec",
            "Modo Magnet",
            "Day Trade",
            "Horário",
            "Ligar",
            "Desligar",
            "Comprar",
            "Vender",
            "Comprar antes",
            "Vender antes",
            "Lmt Perda",
            "Lmt Lucro",
            "Lmt Vol Posi",
            "Lmt Ordem",
            "Deviation",
            "Vol. Compra (lotes)",
            "Vol. Venda (lotes)",
            "Long Dst",
            "Short Dst",
            "EST MASTER",
            "EST DIST",
            "EST VOL",
            "EST TREND",
            "EST TRAILING",
            "Add Est Distancia",
            "Add Est Tolerancia",
            "Hedge A Fat",
            "Hedge R Fat",
            "Corretagem"
            // "Extreme Mode",
            // "Extreme Calls",
            // "Pausa",
            // "Sleep"
            );
    }
    FileClose(handle);
} 

//https://www.mql5.com/en/docs/constants/structures/mqldatetime
void Write_File_Quarter_CSV(string FileName)//, string &array[])
{

   
   MqlDateTime str1;
   
   datetime date1;
   
   datetime aTime = TimeCurrent();

   int      hour =(int)((aTime%86400)/3600);
   int      min =(int)((aTime%3600)/60);
   


   
   TimeToStruct(aTime,str1);
   /*
   printf("%02d.%02d.%4d, day of year = %d",str1.day,str1.mon,
          str1.year,str1.day_of_year);

      Result:
         01.03.2008, day of year = 60          
   */



	//string day = TimeToString(aTime,TIME_DATE);
	string      day     = str1.day_of_year;
	//string      hour     = (string)str1.day;
	
	string date = TimeToString(TimeCurrent(),TIME_DATE);
	//string date = TimeToString(TimeCurrent(),TIME_DATE);
	//string      l_date 	      = TimeToString(TimeLocal(),TIME_DATE);
	string      date_year     = StringSubstr(date, 0, 4);
	string      date_month     = StringSubstr(date, 5,2);
	string      date_day    = StringSubstr(date, 8, 2);

   string day_week;   

   switch(str1.day_of_week)
   {
      case 0: day_week="Domingo";
      break;
      case 1: day_week="Segunda";
      break;
      case 2: day_week="Terça";
      break;
      case 3: day_week="Quarta";
      break;
      case 4: day_week="Quinta";
      break;
      case 5: day_week="Sexta";
      break;   
      default:day_week="Sábado";
      break;
   }



   int handle = FileOpen(FileName,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);
   if(handle==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }
   


   double ngcmin = 0;
   if(SYMBOL_QUARTER_QTD > 0)
      ngcmin = NormalizeDouble((SYMBOL_QUARTER_QTD/15),2);



      string login = (string)login;
      string trade_mode = GetTradeMode();
      string sub =  StringSubstr(name, 0, 3);

   FileSeek(handle,0,SEEK_END);
   FileWrite(handle,


         login,
         trade_mode,
         sub,
         Symbol(),
         TimeCurrent(),
         date_year,
         day,
         LAST_WEEK,
         date_month,
         date_day,
         day_week,//str1.day_of_week,//DiaDaSemana(), //DayOfWeek()
         hour,
         min,

         SYMBOL_DAILY_HIGHEST_HIGH,
         SYMBOL_DAILY_LOWEST_LOW,
         DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL,

         CORRETAGEM,
         SYMBOL_DAILY_CURRENT_BALANCE,
         saldo,
        
        
        
        
        
         SYMBOL_QUARTER_MAX_RISE,
         SYMBOL_QUARTER_MAX_DRAWDOWN,
         SYMBOL_QUARTER_QTD,
         SYMBOL_QUARTER_TAX,
         SYMBOL_QUARTER_CURRENT_BALANCE,
         SYMBOL_QUARTER_LQD,
         ngcmin,
        
        
        
         SO,
         VER,
         EN_MODE,
         FOLLOW_MODE,
         DAY_TRADE_MODE,
         TIME_FILTER,
         TRADING_TIME_START,
         TRADING_TIME_END,
         LONG_POSITION_ON,
         SHORT_POSITION_ON,
         BUY_FIRST,
         SELL_FIRST,
         LIMIT_LOSS_DAY,
         LIMIT_PROFIT_DAY,
         LIMIT_POSITION_VOLUME,
         LIMIT_ORDER_VOLUME,
         DEVIATION,
         EN_Volume_Long,
         EN_Volume_Short,
         EN_Distance_Long,
         EN_Distance_Short,
         TRADE_STRATEGY_CHOSEN,
         INPUT_EN_EST_DISTANCE_CHOSEN,
         INPUT_EN_EST_VOLUME_CHOSEN,
         INPUT_TREND_EST_CHOSEN,
         //INPUT_TRAILING_STOP_EST_CHOSEN,
         ADJ_DST_SEQ_VALUE,
         ADJ_DST_SEQ_TOL_INI,
         MdlTrend_AccFactorVolume,
         MdlTrend_TprFactorVolume,
         BROKERAGE




         );


   FileClose(handle);

} 