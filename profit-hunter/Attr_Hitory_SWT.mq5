double SWT_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
double SWT_TOTAL_SYMBOL_DEAL_OUT = 0;
double SWT_TOTAL_SYMBOL_BALANCE = 0;
double SWT_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

double SWT_TOTAL_SYMBOL_DEAL_PROFIT = 0;


double SWT_SYMBOL_TOTAL_DEAL_BUY = 0;
double SWT_SYMBOL_TOTAL_DEAL_SELL = 0;

int SWT_POSITION_STATUS = 0;
int SWT_LAST_POSITION_STATUS = 0;

double SWT_LAST_POSITION_BUY_VOL = 0;
double SWT_LAST_POSITION_SELL_VOL = 0;

double SWT_SYMBOL_LAST_DEAL_ENTRY;
double SWT_SYMBOL_LAST_DEAL_TYPE;
double SWT_SYMBOL_LAST_DEAL_PRICE;

//int SWT_SYMBOL_LAST_DEAL_TRADE_PROGRESS;
int SWT_SYMBOL_BUY_SEQUENCE;
int SWT_SYMBOL_SELL_SEQUENCE;

double   SWT_SYMBOL_LAST_BUY = 0;
double   SWT_SYMBOL_LAST_SELL = 0;


//datetime StartWeakData;
//datetime EndWeakData;


// https://www.mql5.com/pt/docs/trading/historydealgetticket
void SWT_HistoryDeals()
{   
   //datetime end = TimeCurrent(); 
   //datetime start = end - HistoricDays * PeriodSeconds(PERIOD_D1);

   SWT_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
   SWT_TOTAL_SYMBOL_DEAL_OUT = 0;
   SWT_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

   SWT_SYMBOL_TOTAL_DEAL_BUY = 0;
   SWT_SYMBOL_TOTAL_DEAL_SELL = 0;
    
   SWT_SYMBOL_BUY_SEQUENCE = 0;
   SWT_SYMBOL_SELL_SEQUENCE = 0;

   SWT_SYMBOL_LAST_BUY = 0;
   SWT_SYMBOL_LAST_SELL = 0;
   
   SWT_SYMBOL_LAST_DEAL_PRICE = 0;
   SWT_TOTAL_SYMBOL_DEAL_PROFIT = 0;
		
   HistorySelect(StringToTime(TimeToString(TimeTradeServer(), start)), end);  // Seleciona histórico do período
   int total = HistoryDealsTotal();
   for(int i = 0; i < total; i++)
   {
      ulong Ticket = HistoryDealGetTicket(i);
      if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol)
      {
				
         //---Gets       
         SWT_SYMBOL_LAST_DEAL_TYPE = (HistoryDealGetInteger(Ticket, DEAL_TYPE));
         SWT_SYMBOL_LAST_DEAL_ENTRY = (HistoryDealGetInteger(Ticket, DEAL_ENTRY));
         SWT_SYMBOL_LAST_DEAL_PRICE = (HistoryDealGetDouble(Ticket, DEAL_PRICE));

         SWT_TOTAL_SYMBOL_DEAL_COUNT_VOL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         
         //---Adds
         SWT_TOTAL_SYMBOL_DEAL_PROFIT += (HistoryDealGetDouble(Ticket, DEAL_PROFIT));
         

         //---Calcs
         if (HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_IN)
         {
            //SWT_TOTAL_SYMBOL_DAY_DEAL_IN += 1;
            //double volume = HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            SWT_TOTAL_SYMBOL_DAY_DEAL_IN += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         }
         if(HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_OUT)   
         {
            //SWT_TOTAL_SYMBOL_DEAL_OUT += 1;
            SWT_TOTAL_SYMBOL_DEAL_OUT += HistoryDealGetDouble(Ticket, DEAL_VOLUME);  
         }             


         if (HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_BUY)
         {
            SWT_SYMBOL_TOTAL_DEAL_BUY += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            SWT_SYMBOL_BUY_SEQUENCE +=1;
            SWT_SYMBOL_LAST_BUY = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         
         }
         else
         {
            SWT_SYMBOL_BUY_SEQUENCE = 0;
         }
         if(HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_SELL)
         {
            SWT_SYMBOL_TOTAL_DEAL_SELL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            SWT_SYMBOL_SELL_SEQUENCE +=1;
            SWT_SYMBOL_LAST_SELL = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         }
         else
         {
            SWT_SYMBOL_SELL_SEQUENCE = 0;
         }
         // novo
      }
   }
   SWT_LAST_POSITION_STATUS = SWT_POSITION_STATUS;
    
   SWT_TOTAL_SYMBOL_BALANCE = SWT_SYMBOL_TOTAL_DEAL_BUY - SWT_SYMBOL_TOTAL_DEAL_SELL;

   if(SWT_TOTAL_SYMBOL_BALANCE < 0)
   {
      SWT_TOTAL_SYMBOL_BALANCE *= (-1);
   }

   if(SWT_SYMBOL_TOTAL_DEAL_BUY > SWT_SYMBOL_TOTAL_DEAL_SELL)
   {
      SWT_POSITION_STATUS = 1;
   }
   else if(SWT_SYMBOL_TOTAL_DEAL_BUY < SWT_SYMBOL_TOTAL_DEAL_SELL)
   {
      SWT_POSITION_STATUS = (-1);
   }
   else
   {
      SWT_POSITION_STATUS = 0;
   }

   
   if(SWT_POSITION_STATUS == 0)
   {

   }


   SetSWTStringStatus();
   
}

string SWT_STRING_STATUS = "SWT NO POSITION";

void SetSWTStringStatus()
{

        if(SWT_POSITION_STATUS == 1)// vendido
        {
            SWT_STRING_STATUS = "SWT LONG POSITION";             
        }	

        else if(SWT_POSITION_STATUS == -1)// vendido
        {
            SWT_STRING_STATUS = "SWT SHORT POSITION";            
        }
        else
        {
            SWT_STRING_STATUS = "SWT NO POSITION";             
        }

}