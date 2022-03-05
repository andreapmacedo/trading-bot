



void AutoGenerate_DailyTradeHistoric()
{
// verifica a mudança do dia e dispara rotina de histórioco do período


}


void AutoGenerate_WeeklyTradeHistoric()
{

}

void SelectedSymbolHistoryDeals(datetime start, datetime end, int &total_symbol_deal_count_vol, double &total_symbol_deal_profit)
{
		


   HistorySelect(StringToTime(TimeToString(TimeTradeServer(), start)), end);  // Seleciona histórico do dia
   int total = HistoryDealsTotal();
   for(int i = 0; i < total; i++)
   {
      ulong Ticket = HistoryDealGetTicket(i);
      if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol)
      {
				
         //---Gets       
         //DYT_SYMBOL_LAST_DEAL_TYPE = (HistoryDealGetInteger(Ticket, DEAL_TYPE));
         //DYT_SYMBOL_LAST_DEAL_ENTRY = (HistoryDealGetInteger(Ticket, DEAL_ENTRY));
         //cache_SYMBOL_LAST_DEAL_PRICE = (HistoryDealGetDouble(Ticket, DEAL_PRICE));

         total_symbol_deal_count_vol += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         //total_symbol_deal_count_vol = HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         
         //---Adds
         total_symbol_deal_profit += (HistoryDealGetDouble(Ticket, DEAL_PROFIT));
         //total_symbol_deal_profit += (HistoryDealGetDouble(Ticket, DEAL_PROFIT));
         
/*
         //---Calcs
         if (HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_IN)
         {
            //cache_TOTAL_SYMBOL_DAY_DEAL_IN += 1;
            //double volume = HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            cache_TOTAL_SYMBOL_DAY_DEAL_IN += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         }
         if(HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_OUT)   
         {
            //cache_TOTAL_SYMBOL_DEAL_OUT += 1;
            cache_TOTAL_SYMBOL_DEAL_OUT += HistoryDealGetDouble(Ticket, DEAL_VOLUME);  
         }             


         if (HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_BUY)
         {
            cache_SYMBOL_TOTAL_DEAL_BUY += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            cache_SYMBOL_BUY_SEQUENCE +=1;
            cache_SYMBOL_LAST_BUY = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         
         }
         else
         {
            cache_SYMBOL_BUY_SEQUENCE = 0;
         }
         if(HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_SELL)
         {
            cache_SYMBOL_TOTAL_DEAL_SELL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            cache_SYMBOL_SELL_SEQUENCE +=1;
            cache_SYMBOL_LAST_SELL = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         }
         else
         {
            cache_SYMBOL_SELL_SEQUENCE = 0;
         }

   */
      }
   }
        Comment("start ->  "+ start,
                "\n end ->  " + end,
                "\n ------------------------------------",
                "\n total_symbol_deal_count_vol ->  " + total_symbol_deal_count_vol,
                "\n total_symbol_deal_profit ->  " + total_symbol_deal_profit
                //"\n SPD ->  " + spd
                );
    // o arquivo deve ser gerado aqui
   
}
