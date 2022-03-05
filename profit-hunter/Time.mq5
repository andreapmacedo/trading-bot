
//https://www.mql5.com/pt/articles/599#time_from_day_start

//https://www.mql5.com/pt/articles/599

//https://www.mql5.com/en/docs/constants/structures/mqldatetime

// IMPORTANTE
//https://www.mql5.com/pt/articles/599#access_bar_time

//https://www.mql5.com/pt/forum/84319
//datetime time_routine=TimeCurrent();
//datetime LAST_TIME = TimeCurrent();
//datetime NOW_TIME = TimeCurrent();


int LAST_YEAR;
int LAST_MONTH;
int LAST_WEEK;
int LAST_DAY;
int LAST_HOUR;
int LAST_MINUTE;
int LAST_QUARTER;
int LAST_SECOUND;



void OnTimer()
{
   /*
   //--- hora da primeira chamada da OnTimer()
      static datetime start_time=TimeCurrent();
   //--- hora do servidor de negociação na primeira chamada da OnTimer();
      static datetime start_tradeserver_time=0;
   //--- hora do servidor de negociação calculada
      static datetime calculated_server_time=0;
   //--- hora local no computador
      datetime local_time=TimeLocal();
   //--- hora estimada atual do servidor de negociação
      datetime trade_server_time=TimeTradeServer();
   //--- se por algum motivo a hora do servidor for desconhecida, sairemos antecipadamente
      if(trade_server_time==0)
         return;
   //--- se o valor inicial do servidor de negociação ainda não estiver definido
      if(start_tradeserver_time==0)
      {
         start_tradeserver_time=trade_server_time;
         //--- definimos a hora calculada do servidor de negociação      
         Print(trade_server_time);
         calculated_server_time=trade_server_time;
      }
      else
      {
         //--- aumentamos o tempo da primeira chamada da OnTimer()
         if(start_tradeserver_time!=0)
            calculated_server_time=calculated_server_time+1;;
      }
   //--- 
      string com=StringFormat("                  Start time: %s\r\n",TimeToString(start_time,TIME_MINUTES|TIME_SECONDS));
      com=com+StringFormat("                  Local time: %s\r\n",TimeToString(local_time,TIME_MINUTES|TIME_SECONDS));
      com=com+StringFormat("TimeTradeServer time: %s\r\n",TimeToString(trade_server_time,TIME_MINUTES|TIME_SECONDS));
      com=com+StringFormat(" EstimatedServer time: %s\r\n",TimeToString(calculated_server_time,TIME_MINUTES|TIME_SECONDS));
   //--- exibimos no gráfico os valores de todos os contadores
      Comment(com);
   */


	//time_routine=(time_routine/86400)*86400;
	//--- output result
	//Alert("Day start time: "+(string)time_routine);
   
   MqlDateTime str1; 
   
   datetime tc=TimeCurrent();

   TimeToStruct(tc,str1);

   int day_of_week = str1.day_of_week;   
   int day_of_year = str1.day_of_year;   
   int hour = str1.hour;   
   int minute = str1.min;   
   
   int secound = str1.sec;   



   //int t,h,m,s;
   //t=TimeFromDayStart(tc,h,m,s);
   //--- output result
   //Alert("Time elapsed since the day start ",t," s, which makes ",h," h, ",m," m, ",s," s ");
   //Comment("Time elapsed since the day start ",t," s, which makes ",h," h, ",m," m, ",s," s ");
   

   //if(NextHour(h) && ChangeSecond(s))



   
   if(NextSecound(secound))
   {
      NewSecoundRoutine();
      if(NextMinute(minute))
      {
         NewMinuteRoutine();
         if(NextQuarter(minute))
         {
            NewQuarterRoutine();
         }
         if(NextHour(hour))
         {
            NewHourRoutine();
            if(NextDay(day_of_year))
            {
               NewDayRoutine();
               CheckLongPer();
            }
         }
      }
   }
   


   //bool NewWeek=WeekNum(time[i])!=WeekNum(time[i-1]);
   //Comment("Time elapsed since the day start ",t," s, which makes ",h," h, ",m," m, ",s," s ",  NewDay, " new w ", NewWeek);
}


int TimeFromDayStart(datetime aTime,int &aH,int &aM,int &aS)
{
//--- Number of seconds elapsed since the day start (aTime%86400),
//--- divided by the number of seconds in an hour is the number of hours
   aH=(int)((aTime%86400)/3600);
//--- Number of seconds elapsed since the last hour (aTime%3600),
//--- divided by the number of seconds in a minute is the number of minutes 
   aM=(int)((aTime%3600)/60);
//--- Number of seconds elapsed since the last minute 
   aS=(int)(aTime%60);
//--- Number of seconds since the day start
   return(int(aTime%86400));
}
datetime BarTimeNormalize(datetime aTime,ENUM_TIMEFRAMES aTimeFrame)
  {
   int BarLength=PeriodSeconds(aTimeFrame);
   return(BarLength*(aTime/BarLength));
  }



void CheckLongPer()
{
   MqlDateTime str1; 
   
   datetime tc=TimeCurrent();

   TimeToStruct(tc,str1);

   int year = str1.year;             // Year
   int mon  = str1.mon;             // Month
   int day_of_year  = str1.day_of_year;             // Month
   int week = day_of_year/7;
   
   
   if(NextYear(year))
   {
      NewYearRoutine();
   }
   if(NextMonth(mon))
   {
      NewMonthRoutine();
   }
   if(NextWeek(week))
   {
      NewWeekRoutine();
   }
}

bool NextYear(int year)
{
   if(year != LAST_YEAR)
   {
      
      LAST_YEAR = year;
      return true;
   }
   else
      return false;
}
bool NextMonth(int month)
{
   if(month != LAST_MONTH)
   {
      LAST_MONTH = month;
      return true;
   }
   else
      return false;
}

bool NextWeek(int week)
{
   if(week != LAST_WEEK)
   {
      LAST_WEEK = week;
      return true;
   }
   else
      return false;
}

bool NextDay(int day)
{
   if(day != LAST_DAY)
   {
      LAST_DAY = day;
      return true;
   }
   else
      return false;
}

bool NextHour(int hour)
{
   if(hour != LAST_HOUR)
   {
      //LAST_TIME = TimeCurrent()-(60*60);
      LAST_HOUR = hour;
      return true;
   }
   else
      return false;
}





bool NextQuarter(int minute)
{
   if(minute == LAST_QUARTER)
   {
      if(minute > 0 && minute < 15)
      {
         LAST_QUARTER = 15;
      }
      else
      {
         LAST_QUARTER += 15;
      }
      return true;
   }
   else
   {
      if(minute == 59)
      {
         LAST_QUARTER = 0;
      }
   }
      return false;
}

bool NextMinute(int minute)
{
   if(minute != LAST_MINUTE)
   {
      //LAST_TIME = TimeCurrent()-60;
      LAST_MINUTE = minute;
      return true;
   }
   else
      return false;
}

bool NextSecound(int secound)
{
   if(secound != LAST_SECOUND)
   {
      LAST_SECOUND = secound;
      return true;
   }
   else
      return false;
}



int TimeTradeCheck()
{

	string      hoursAndMinutes  = TimeToString(TimeCurrent(), TIME_MINUTES);
   string      time_current     = StringSubstr(hoursAndMinutes, 0, 5);

   //Print("time_current: ", time_current );

   
   if(time_current >= TRADING_TIME_START && time_current < TRADING_TIME_END)
   {
      return 1;
   }
   if(time_current < TRADING_TIME_START)
   {
      return  2;  
   }
   return 3;

}


long WeekNum(datetime aTime,bool aStartsOnMonday=false)
{
//--- if the week starts on Sunday, add the duration of 4 days (Wednesday+Tuesday+Monday+Sunday),
//    if it starts on Monday, add 3 days (Wednesday, Tuesday, Monday)
   if(aStartsOnMonday)
     {
      aTime+=259200; // duration of three days (86400*3)
     }
   else
     {
      aTime+=345600; // duration of four days (86400*4)  
     }
   return(aTime/604800);
}

//---Essa função pode ser útil em indicadores para determinar a primeira barra da nova semana:
//bool NewWeek=WeekNum(time[i])!=WeekNum(time[i-1]);

long WeekNumFromDate(datetime aTime,datetime aStartTime,bool aStartsOnMonday=false)
  {
   long Time,StartTime,Corrector;
   MqlDateTime stm;
   Time=aTime;
   StartTime=aStartTime;
//--- determine the beginning of the reference epoch
   StartTime=(StartTime/86400)*86400;
//--- determine the time that elapsed since the beginning of the reference epoch
   Time-=StartTime;
//--- determine the day of the week of the beginning of the reference epoch
   TimeToStruct(StartTime,stm);
//--- if the week starts on Monday, numbers of days of the week are decreased by 1,
//    and the day with number 0  becomes a day with number 6
   if(aStartsOnMonday)
     {
      if(stm.day_of_week==0)
        {
         stm.day_of_week=6;
        }
      else
        {
         stm.day_of_week--;
        }
     }
//--- calculate the value of the time corrector 
   Corrector=86400*stm.day_of_week;
//--- time correction
   Time+=Corrector;
//--- calculate and return the number of the week
   return(Time/604800);
  }







//+------------------------------------------------------------------+
//| Retorna o nome do dia da semana                                   |
//+------------------------------------------------------------------+




void checkDayOfWeek()
{
   MqlDateTime STime;
   //Print(DayOfWeek(STime.day_of_week));
   Print(DayOfWeek());
   /*
   datetime time_current=TimeCurrent();
   datetime time_local=TimeLocal();
   
   TimeToStruct(time_current,STime);
   Print("Time Current ",TimeToString(time_current,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeek(STime.day_of_week));
   
   TimeToStruct(time_local,STime);
   Print("Time Local ",TimeToString(time_local,TIME_DATE|TIME_SECONDS)," day of week ",DayOfWeek(STime.day_of_week));

   */
}




//string DayOfWeek(const datetime time)
string DayOfWeek()
{
   MqlDateTime dt, STime;
   

   string day="";
   TimeToStruct(STime.day_of_week,dt);
   switch(dt.day_of_week)
   {
      case 0: day=EnumToString(SUNDAY);
      break;
      case 1: day=EnumToString(MONDAY);
      break;
      case 2: day=EnumToString(TUESDAY);
      break;
      case 3: day=EnumToString(WEDNESDAY);
      break;
      case 4: day=EnumToString(THURSDAY);
      break;
      case 5: day=EnumToString(FRIDAY);
      break;   
      default:day=EnumToString(SATURDAY);
      break;
   }
//--- 
   return day;
}

string DiaDaSemana()
{
   MqlDateTime dt, STime;
   

   string day="";
   TimeToStruct(STime.day_of_week,dt);
   switch(dt.day_of_week)
   {
      case 0: day="Domingo";
      break;
      case 1: day="Segunda";
      break;
      case 2: day="Terça";
      break;
      case 3: day="Quarta";
      break;
      case 4: day="Quinta";
      break;
      case 5: day="Sexta";
      break;   
      default:day="Sábado";
      break;
   }
//--- 
   return day;
}

int Seconds( void )
{
   //return((int)TimeCurrent() % 60) ;
   return((int)TimeCurrent() % 1) ;
}


datetime dtSTART_TIME;
datetime dtLOCAL_TIME;
datetime dtSERVER_TIME;


/*

  //+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- data é no domingo
   datetime time=D'2018.06.10 12:00';
   string symbol="GBPUSD";
   ENUM_TIMEFRAMES tf=PERIOD_H1;
   bool exact=false;
//--- se não houver barra para o tempo especificado, iBarShift retornará o índice da barra mais próxima
   int bar_index=iBarShift(symbol,tf,time,exact);
   PrintFormat("1. %s %s %s(%s): bar index is %d (exact=%s)",
               symbol,EnumToString(tf),TimeToString(time),DayOfWeek(time),bar_index,string(exact));
   datetime bar_time=iTime(symbol,tf,bar_index);
   PrintFormat("Time of bar #%d is %s (%s)",
               bar_index,TimeToString(bar_time),DayOfWeek(bar_time));
//PrintFormat(iTime(symbol,tf,bar_index));
//--- precisamos encontrar o índice da barra para o tempo especificado, se ele não existir, retornaremos -1
   exact=true;
   bar_index=iBarShift(symbol,tf,time,exact);
   PrintFormat("2. %s %s %s (%s):bar index is %d (exact=%s)",
               symbol,EnumToString(tf),TimeToString(time),DayOfWeek(time),bar_index,string(exact));
  }
//+------------------------------------------------------------------+
//| Retorna o nome do dia da semana                                   |
//+------------------------------------------------------------------+
string DayOfWeek(const datetime time)
  {
   MqlDateTime dt;
   string day="";
   TimeToStruct(time,dt);
   switch(dt.day_of_week)
     {
      case 0: day=EnumToString(SUNDAY);
      break;
      case 1: day=EnumToString(MONDAY);
      break;
      case 2: day=EnumToString(TUESDAY);
      break;
      case 3: day=EnumToString(WEDNESDAY);
      break;
      case 4: day=EnumToString(THURSDAY);
      break;
      case 5: day=EnumToString(FRIDAY);
      break;   
      default:day=EnumToString(SATURDAY);
      break;
     }
//---
   return day;
  }
/* Resultado:
   1. GBPUSD PERIOD_H1 2018.06.10 12:00(SUNDAY): bar index is 64 (exact=false)
   Time of bar #64 is 2018.06.08 23:00 (FRIDAY)
   2. GBPUSD PERIOD_H1 2018.06.10 12:00 (SUNDAY):bar index is -1 (exact=true)
*/  




//double TimeUpdadeInfo = 0; // Pausa (segundos)




/*
void  EventSetTimer(
   int  seconds      // número de segundos
   )
   {
	Alert("Day start time: "+(string)time_routine);


   }

   */