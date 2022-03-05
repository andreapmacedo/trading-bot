

#include "File_Hourly.mq5"
#include "File_Quarter.mq5"
#include "File_Daily.mq5"
#include "File_Deals.mq5"


//https://www.mql5.com/pt/docs/files
//https://www.mql5.com/pt/docs/constants/io_constants/fileflags
//https://www.mql5.com/pt/articles/2720
//https://github.com/PopovMP/FSB_MQL_Code/blob/master/MQL5/Export%20Data%20to%20CSV.mq5




//string File_Name_CSV = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - Resume Hourly.csv";

    //https://www.mql5.com/en/forum/152831      


void Create_File_CSV(string FileName)
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


            "Vol neg.",
            "Corretagem",
            "Dia BLC",
            "Dia BLC Liq.",
            "Dia Máx",
            "Dia Mín",
            "Hora BLC",
            "Hora Máx",
            "Hora Mín",
            "SO",
            "VER",
            "EN Mode",
            "Long Dst",
            "Short Dst",
            "EST DIST",
            "EST VOL",
            "Add",
            "Hedge A Fat",
            "Hedge R Fat"
            );
    }
    FileClose(handle);
} 

//https://www.mql5.com/en/docs/constants/structures/mqldatetime
void Write_File_CSV(string FileName)//, string &array[])
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


         DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL,
         CORRETAGEM,
         SYMBOL_DAILY_CURRENT_BALANCE,
         saldo,
         SYMBOL_DAILY_HIGHEST_HIGH,
         SYMBOL_DAILY_LOWEST_LOW,
         SYMBOL_HOURLY_CURRENT_BALANCE,
         SYMBOL_HOURLY_HIGHEST_HIGH,
         SYMBOL_HOURLY_LOWEST_LOW,
         SELECTED_SO,
         SELECTED_VER,
         SELECTED_EN_MODE,
         EN_Distance_Long,
         EN_Distance_Short,
         SELECTED_EST_EN_ANCHOR_CHOSEN,
         SELECTED_EST_VOLUME_CHOSEN,//INPUT_EN_EST_VOLUME_CHOSEN,
         MIN_ADD_DISTANCE,
         MdlTrend_AccFactorVolume,
         MdlTrend_TprFactorVolume
         );


   FileClose(handle);

} 

void Create_File_h_CSV(string FileName)
{
   int handle = FileOpen(FileName,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);



    if(handle>0)
    {
    //write file header
    FileSeek(handle,0,SEEK_SET);
    FileWrite(handle,
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
            "Vol neg.",
            "Corretagem",
            "Dia BLC",
            "Dia BLC Liq.",
            "Dia Máx",
            "Dia Mín",
            "Hora BLC",
            "Hora Máx",
            "Hora Mín",


            "SO",
            "VER",
            "EN Mode",
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
            "Offset",
            "Deviation",
            "Vol. Compra (lotes)",
            "Vol. Venda (lotes)",
            "Long Dst",
            "Short Dst",
            "EST DIST",
            "EST VOL",
            "EST TREND",
            "EST TRAILING",
            "Add Est Distancia",
            "Add Est Tolerancia",
            "Hedge A Fat",
            "Hedge R Fat",
            "Corretagem",
            "Extreme Mode",
            "Extreme Calls",
            "Pausa",
            "Sleep"
            );
    }
    FileClose(handle);
} 


void Write_File_h_CSV(string FileName)//, string &array[])
{

   
         int total_symbol_deal_count_vol = 0;
         
         //---Adds
        double total_symbol_deal_profit = 0;
   /*
   int cache_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
   int cache_TOTAL_SYMBOL_DEAL_OUT = 0;
   int cache_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

   int cache_SYMBOL_TOTAL_DEAL_BUY = 0;
   int cache_SYMBOL_TOTAL_DEAL_SELL = 0;

    
   int cache_SYMBOL_BUY_SEQUENCE = 0;
   int cache_SYMBOL_SELL_SEQUENCE = 0;

   int cache_SYMBOL_LAST_BUY = 0;
   int cache_SYMBOL_LAST_SELL = 0;
   
   int cache_SYMBOL_LAST_DEAL_PRICE = 0;
   int cache_SYMBOL_TOTAL_DEAL_PROFIT = 0;
*/
   //SelectedSymbolHistoryDeals((TimeCurrent()-(60*60)),TimeCurrent(),total_symbol_deal_count_vol , total_symbol_deal_profit);



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
   

   FileSeek(handle,0,SEEK_END);
   FileWrite(handle,
         Symbol(),
         date,
         date_year,
         day,
         LAST_WEEK,
         date_month,
         date_day,
         day_week,//str1.day_of_week,//DiaDaSemana(), //DayOfWeek()
         hour,
         min,
         total_symbol_deal_count_vol,
         CORRETAGEM,
         SYMBOL_DAILY_CURRENT_BALANCE,
         saldo,
         SYMBOL_DAILY_HIGHEST_HIGH,
         SYMBOL_DAILY_LOWEST_LOW,
         total_symbol_deal_profit,
         SYMBOL_HOURLY_HIGHEST_HIGH,
         SYMBOL_HOURLY_LOWEST_LOW,
         

         SO,
         VER,
         EN_MODE,
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
         "0",
         DEVIATION,
         EN_Volume_Long,
         EN_Volume_Short,
         EN_Distance_Long,
         EN_Distance_Short,
         INPUT_EN_EST_DISTANCE_CHOSEN,
         INPUT_EN_EST_VOLUME_CHOSEN,
         INPUT_TREND_EST_CHOSEN,
         INPUT_TRAILING_STOP_EST_CHOSEN,
         ADJ_DST_SEQ_VALUE,
         ADJ_DST_SEQ_TOL_INI,
         MdlTrend_AccFactorVolume,
         MdlTrend_TprFactorVolume,
         BROKERAGE,
         ExtremeMode_ON,
         ExtremeModeLimitCalls,
         Seconds,
         Sleep


         );


   FileClose(handle);

} 