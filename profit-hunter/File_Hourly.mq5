

void Create_File_Hourly_CSV(string FileName)
{
   int handle = FileOpen(FileName,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);



    if(handle>0)
    {
    //write file header
    FileSeek(handle,0,SEEK_SET);
    FileWrite(handle,
            
            "Conta",
            //"Tipo",
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
            //"Minuto",
            
            "DT Acm Máx",
            "DT Acm Mín",
            "DT Acm Vol",
            "DT Acm Tax",
            "DT Acm Blc",
            "DT Acm Liq",
            
            "H1 Máx",
            "H1 Mín",
            "H1 Vol",
            "H1 Tax",
            "H1 Blc",
            "H1 Liq",
            
            "Neg/min",

            "SO",
            "VER",
            //"Modo Exec",
            "EST TREND",
            "EST MASTER",
            
            "EST STATUS 01",
            "EST STATUS 02",
            "EST STATUS 03",
            "EST STATUS 04",
            "EST STATUS 05",
            // "Day Trade",
            // "Horário",
            // "Ligar",
            // "Desligar",
            // "Comprar",
            // "Vender",
            // "Comprar antes",
            // "Vender antes",
            // "Lmt Perda",
            // "Lmt Lucro",
            "Lmt Vol Posi",
            "Lmt Ordem",
            "Vol. Compra (lotes)",
            "Vol. Venda (lotes)",
            "Long Dst",
            "Short Dst",

            "Modo Magnetico",
            "Dist Mínima Adição",
            "Dist Mínima Redução",


            "EST TRAILING",
            //_________________________
            
            "EST AJ DISTANCIA",
            "Adc Dst seq Modo PG",
            "Adc Dst Seq de",
            "Adc Dst Seq ate",
            "Adc Dst Seq valor",
            
            "Adc Dst vol Modo PG",
            "Adc Dst vol de",
            "Adc Dst vol ate",
            "Adc Dst vol valor",
            
            "Adc Dst Limite",
            //_________________________
            
            "EST AJ VOLUME",
            
            "Adc Vol seq Modo PG",
            "Adc Vol seq de",
            "Adc Vol seq ate",
            "Adc Vol seq valor",
            
            "Adc Vol Vol Modo PG",
            "Adc Vol Vol de",
            "Adc Vol Vol ate",
            "Adc Vol Vol valor",
           
            "Adc Vol Limite"
            
            //"Corretagem"
            );
    }
    FileClose(handle);
} 

//https://www.mql5.com/en/docs/constants/structures/mqldatetime
void Write_File_Hourly_CSV(string FileName)//, string &array[])
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
      if(SYMBOL_HOURLY_QTD > 0)
         ngcmin = NormalizeDouble((SYMBOL_HOURLY_QTD/60),2);

      string login = (string)login;
      string trade_mode = GetTradeMode();
      string sub =  StringSubstr(name, 0, 3);


   FileSeek(handle,0,SEEK_END);
   FileWrite(handle,
         
         login,
        // trade_mode,
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
        // min,


         SYMBOL_DAILY_HIGHEST_HIGH,
         SYMBOL_DAILY_LOWEST_LOW,
         DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL,
         CORRETAGEM,
         SYMBOL_DAILY_CURRENT_BALANCE,
         saldo,
        

         SYMBOL_HOURLY_HIGHEST_HIGH,
         SYMBOL_HOURLY_LOWEST_LOW,
         SYMBOL_HOURLY_QTD,
         SYMBOL_HOURLY_TAX,
         SYMBOL_HOURLY_CURRENT_BALANCE,
         SYMBOL_HOURLY_LQD,  
         ngcmin,
         
         
         
         
         SO,
         VER,
        // EN_MODE,
         INPUT_TREND_EST_CHOSEN,
         TRADE_STRATEGY_CHOSEN,
         TRADE_STATUS_SYSTEM_01_CHOSEN,
         TRADE_STATUS_SYSTEM_02_CHOSEN,
         TRADE_STATUS_SYSTEM_03_CHOSEN,
         TRADE_STATUS_SYSTEM_04_CHOSEN,
         TRADE_STATUS_SYSTEM_05_CHOSEN,         

         
         // DAY_TRADE_MODE,
         // TIME_FILTER,
         // TRADING_TIME_START,
         // TRADING_TIME_END,
         // LONG_POSITION_ON,
         // SHORT_POSITION_ON,
         // BUY_FIRST,
         // SELL_FIRST,
         
         
         
         // LIMIT_LOSS_DAY,
         // LIMIT_PROFIT_DAY,
         LIMIT_POSITION_VOLUME,
         LIMIT_ORDER_VOLUME,

         
         
         EN_Volume_Long,
         EN_Volume_Short,
         EN_Distance_Long,
         EN_Distance_Short,
         
         
         FOLLOW_MODE,
         MIN_ADD_DISTANCE,
         MIN_REDUCE_DISTANCE,
         INPUT_TRAILING_STOP_EST_CHOSEN,
         //_________________________
         INPUT_EN_EST_DISTANCE_CHOSEN,
         
         ADJ_DST_SEQ_MODE_PG, //aqui
         ADJ_DST_SEQ_TOL_INI,
         ADJ_DST_SEQ_TOL_FIM,
         ADJ_DST_SEQ_VALUE,

         ADJ_DST_VOL_MODE_PG,
         ADJ_DST_VOL_TOL_INI,
         ADJ_DST_VOL_TOL_FIM,
         ADJ_DST_VOL_VALUE,
         
         TOTAL_DST_VALUE_LIMIT_CHANGE,
         //_________________________
         
         INPUT_EN_EST_VOLUME_CHOSEN,
         
         ADJ_VOL_SEQ_MODE_PG,
         ADJ_VOL_SEQ_TOL_INI,
         ADJ_VOL_SEQ_TOL_FIM,
         ADJ_VOL_SEQ_VALUE,
         
         ADJ_VOL_VOL_MODE_PG,
         ADJ_VOL_VOL_TOL_INI,
         ADJ_VOL_VOL_TOL_FIM,
         ADJ_VOL_VOL_VALUE,
         
         TOTAL_VOL_VALUE_LIMIT_CHANGE
         


         );


   FileClose(handle);

} // end function (File_Write_Resume_Day)