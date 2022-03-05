



void AutoGenerate_DailyTradeHistoric()
{
// verifica a mudança do dia e dispara rotina de histórioco do período


}


void AutoGenerate_WeeklyTradeHistoric()
{

}


   //--- É necessário zerar as variáveis que vão ser recalculadas pelo laço
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




// verificar como evitar a chamada em todos os bots "plugados".
void SelectedSymbolHistoryDeals(datetime init, datetime end)
{
    //CRIAR UMA ROTINA NO ENCERRAMETNO DO PREGÃO COM TODAS AS ESTATISTICAS POSSÍVEIS (MAIOR SEQUENCIA DE COMPRA, VENDA, ALTERNADA, HORÁRIO EM QUE OCORREM, PONTOS ETC.)
    // CONTABILIZAR OS DIAS QUE OCORREM SEQUENCIAS APENAS PARA UM LADO E VICE VERSA
    // CONTABILIZAR A MÉDIA DE LUCRO ETC

   //--- É necessário zerar as variáveis que vão ser recalculadas pelo laço
   cache_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
   cache_TOTAL_SYMBOL_DEAL_OUT = 0;
   cache_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

   cache_SYMBOL_TOTAL_DEAL_BUY = 0;
   cache_SYMBOL_TOTAL_DEAL_SELL = 0;

    
   cache_SYMBOL_BUY_SEQUENCE = 0;
   cache_SYMBOL_SELL_SEQUENCE = 0;

   cache_SYMBOL_LAST_BUY = 0;
   cache_SYMBOL_LAST_SELL = 0;
   
   cache_SYMBOL_LAST_DEAL_PRICE = 0;
   cache_SYMBOL_TOTAL_DEAL_PROFIT = 0;



		
   HistorySelect(StringToTime(TimeToString(TimeTradeServer(), init)), end);  // Seleciona histórico do dia
   int total = HistoryDealsTotal();
   for(int i = 0; i < total; i++)
   {
      ulong Ticket = HistoryDealGetTicket(i);
      if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol)
      {
				
         //---Gets       
         //DYT_SYMBOL_LAST_DEAL_TYPE = (HistoryDealGetInteger(Ticket, DEAL_TYPE));
         //DYT_SYMBOL_LAST_DEAL_ENTRY = (HistoryDealGetInteger(Ticket, DEAL_ENTRY));
         cache_SYMBOL_LAST_DEAL_PRICE = (HistoryDealGetDouble(Ticket, DEAL_PRICE));;

         cache_TOTAL_SYMBOL_DEAL_COUNT_VOL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         
         //---Adds
         cache_SYMBOL_TOTAL_DEAL_PROFIT += (HistoryDealGetDouble(Ticket, DEAL_PROFIT));
         

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

      }
   }

    // o arquivo deve ser gerado aqui
   
}
