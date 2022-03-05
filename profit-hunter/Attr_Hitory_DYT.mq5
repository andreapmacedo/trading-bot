// https://www.mql5.com/en/docs/trading

// https://www.mql5.com/pt/forum/325479



//https://www.mql5.com/pt/docs/trading/historydealgetticket

double DYT_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
double DYT_TOTAL_SYMBOL_DEAL_OUT = 0;
double DYT_TOTAL_SYMBOL_BALANCE = 0;
double DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

double DYT_TOTAL_SYMBOL_DEAL_PROFIT = 0;


double DYT_SYMBOL_TOTAL_DEAL_BUY = 0;
double DYT_SYMBOL_TOTAL_DEAL_SELL = 0;

int DYT_POSITION_STATUS = 0;
int DYT_LAST_POSITION_STATUS = 0;

double DYT_LAST_POSITION_BUY_VOL = 0;
double DYT_LAST_POSITION_SELL_VOL = 0;

double DYT_SYMBOL_LAST_DEAL_ENTRY;
double DYT_SYMBOL_LAST_DEAL_TYPE;
double DYT_SYMBOL_LAST_DEAL_PRICE;

//int DYT_SYMBOL_LAST_DEAL_TRADE_PROGRESS;
int DYT_SYMBOL_BUY_SEQUENCE;
int DYT_SYMBOL_SELL_SEQUENCE;

double   DYT_SYMBOL_LAST_BUY = 0;
double   DYT_SYMBOL_LAST_SELL = 0;




//deletar posteriormente o original no Deals_Managem...
int total_deals_session_evo()
{
		int acmOrdensExecutadas=0;
		HistorySelect(StringToTime(TimeToString(TimeTradeServer(), TIME_DATE)), INT_MAX);  // Seleciona histórico do dia
		int total = HistoryDealsTotal();
		for(int i = 0; i < total; i++)
		{
			ulong Ticket = HistoryDealGetTicket(i);
			if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol
				&& HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_IN
				)
			{
				acmOrdensExecutadas++;
			}
		}
		//Comment("positionsFound " + acmOrdensExecutadas);  
		return(acmOrdensExecutadas);
}


    


// https://www.mql5.com/pt/docs/trading/historydealgetticket
void DYT_HistoryDeals()
{
   //CRIAR UMA ROTINA NO ENCERRAMETNO DO PREGÃO COM TODAS AS ESTATISTICAS POSSÍVEIS (MAIOR SEQUENCIA DE COMPRA, VENDA, ALTERNADA, HORÁRIO EM QUE OCORREM, PONTOS ETC.)
   // CONTABILIZAR OS DIAS QUE OCORREM SEQUENCIAS APENAS PARA UM LADO E VICE VERSA
   // CONTABILIZAR A MÉDIA DE LUCRO ETC

   //--- É necessário zerar as variáveis que vão ser recalculadas pelo laço
   DYT_TOTAL_SYMBOL_DAY_DEAL_IN = 0;
   DYT_TOTAL_SYMBOL_DEAL_OUT = 0;
   DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL = 0;

   DYT_SYMBOL_TOTAL_DEAL_BUY = 0;
   DYT_SYMBOL_TOTAL_DEAL_SELL = 0;

    
   DYT_SYMBOL_BUY_SEQUENCE = 0;
   DYT_SYMBOL_SELL_SEQUENCE = 0;

   DYT_SYMBOL_LAST_BUY = 0;
   DYT_SYMBOL_LAST_SELL = 0;
   
   DYT_SYMBOL_LAST_DEAL_PRICE = 0;
   DYT_TOTAL_SYMBOL_DEAL_PROFIT = 0;
		
   HistorySelect(StringToTime(TimeToString(TimeTradeServer(), TIME_DATE)), INT_MAX);  // Seleciona histórico do dia
   int total = HistoryDealsTotal();
   for(int i = 0; i < total; i++)
   {
      ulong Ticket = HistoryDealGetTicket(i);
      if(HistoryDealGetString(Ticket, DEAL_SYMBOL) == _Symbol)
      {
				
         //---Gets       
         DYT_SYMBOL_LAST_DEAL_TYPE = (HistoryDealGetInteger(Ticket, DEAL_TYPE));
         DYT_SYMBOL_LAST_DEAL_ENTRY = (HistoryDealGetInteger(Ticket, DEAL_ENTRY));
         DYT_SYMBOL_LAST_DEAL_PRICE = (HistoryDealGetDouble(Ticket, DEAL_PRICE));

         DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         
         //---Adds
         DYT_TOTAL_SYMBOL_DEAL_PROFIT += (HistoryDealGetDouble(Ticket, DEAL_PROFIT));
         

         //---Calcs
         if (HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_IN)
         {
            //DYT_TOTAL_SYMBOL_DAY_DEAL_IN += 1;
            //double volume = HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            DYT_TOTAL_SYMBOL_DAY_DEAL_IN += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
         }
         if(HistoryDealGetInteger(Ticket, DEAL_ENTRY) == DEAL_ENTRY_OUT)   
         {
            //DYT_TOTAL_SYMBOL_DEAL_OUT += 1;
            DYT_TOTAL_SYMBOL_DEAL_OUT += HistoryDealGetDouble(Ticket, DEAL_VOLUME);  
         }             


         if (HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_BUY)
         {
            DYT_SYMBOL_TOTAL_DEAL_BUY += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            DYT_SYMBOL_BUY_SEQUENCE +=1;
            DYT_SYMBOL_LAST_BUY = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         
         }
         else
         {
            DYT_SYMBOL_BUY_SEQUENCE = 0;
         }
         if(HistoryDealGetInteger(Ticket, DEAL_TYPE) == DEAL_TYPE_SELL)
         {
            DYT_SYMBOL_TOTAL_DEAL_SELL += HistoryDealGetDouble(Ticket, DEAL_VOLUME);
            DYT_SYMBOL_SELL_SEQUENCE +=1;
            DYT_SYMBOL_LAST_SELL = (HistoryDealGetDouble(Ticket, DEAL_PRICE));
         }
         else
         {
            DYT_SYMBOL_SELL_SEQUENCE = 0;
         }
         // novo
      }
   }
   DYT_LAST_POSITION_STATUS = DYT_POSITION_STATUS;
    
   DYT_TOTAL_SYMBOL_BALANCE = DYT_SYMBOL_TOTAL_DEAL_BUY - DYT_SYMBOL_TOTAL_DEAL_SELL;

   if(DYT_TOTAL_SYMBOL_BALANCE < 0)
   {
      DYT_TOTAL_SYMBOL_BALANCE *= (-1);
   }

   if(DYT_SYMBOL_TOTAL_DEAL_BUY > DYT_SYMBOL_TOTAL_DEAL_SELL)
   {
      DYT_POSITION_STATUS = 1;
   }
   else if(DYT_SYMBOL_TOTAL_DEAL_BUY < DYT_SYMBOL_TOTAL_DEAL_SELL)
   {
      DYT_POSITION_STATUS = (-1);
   }
   else
   {
      DYT_POSITION_STATUS = 0;
   }

   
   if(DYT_POSITION_STATUS == 0)
   {

   }


   SetDYTStringStatus();
   
}

string DYT_STRING_STATUS = "DYT NO POSITION";

void SetDYTStringStatus()
{

        if(DYT_POSITION_STATUS == 1)// vendido
        {
            DYT_STRING_STATUS = "DYT LONG POSITION";             
        }	

        else if(DYT_POSITION_STATUS == -1)// vendido
        {
            DYT_STRING_STATUS = "DYT SHORT POSITION";            
        }
        else
        {
            DYT_STRING_STATUS = "DYT NO POSITION";             
        }

}



//https://www.mql5.com/pt/docs/trading/historyselectbyposition


void HistoriSelect_test()
  {
   color BuyColor =clrBlue;
   color SellColor=clrRed;
//--- request trade history
   HistorySelect(0,TimeCurrent());
//--- create objects
   string   name;
   uint     total=HistoryDealsTotal();
   ulong    ticket=0;
   double   price;
   double   profit;
   datetime time;
   string   symbol;
   long     type;
   long     entry;
//--- for all deals
   for(uint i=0;i<total;i++)
     {
      //--- try to get deals ticket
      if((ticket=HistoryDealGetTicket(i))>0)
        {
         //--- get deals properties
         price =HistoryDealGetDouble(ticket,DEAL_PRICE);
         time  =(datetime)HistoryDealGetInteger(ticket,DEAL_TIME);
         symbol=HistoryDealGetString(ticket,DEAL_SYMBOL);
         type  =HistoryDealGetInteger(ticket,DEAL_TYPE);
         entry =HistoryDealGetInteger(ticket,DEAL_ENTRY);
         profit=HistoryDealGetDouble(ticket,DEAL_PROFIT);
         //--- only for current symbol
         if(price && time && symbol==Symbol())
           {
            //--- create price object
            name="TradeHistory_Deal_"+string(ticket);
            if(entry) ObjectCreate(0,name,OBJ_ARROW_RIGHT_PRICE,0,time,price,0,0);
            else      ObjectCreate(0,name,OBJ_ARROW_LEFT_PRICE,0,time,price,0,0);
            //--- set object properties
            ObjectSetInteger(0,name,OBJPROP_SELECTABLE,0);
            ObjectSetInteger(0,name,OBJPROP_BACK,0);
            ObjectSetInteger(0,name,OBJPROP_COLOR,type?BuyColor:SellColor);
            if(profit!=0) ObjectSetString(0,name,OBJPROP_TEXT,"Profit: "+string(profit));
           }
        }
     }
//--- apply on chart
   ChartRedraw();
  }



void HistoryOrderGetTicket_test()
  {
   datetime from=0;
   datetime to=TimeCurrent();
//--- solicitar todo o histórico
   HistorySelect(from,to);
//--- variáveis ​​para retornar valores das propriedades de ordem
   ulong    ticket;
   double   open_price;
   double   initial_volume;
   datetime time_setup;
   datetime time_done;
   string   symbol;
   string   type;
   long     order_magic;
   long     positionID;
//--- Numero de ordens atuais pendentes
   uint     total=HistoryOrdersTotal();
//--- passar por ordens em um loop
   for(uint i=0;i<total;i++)
     {
      //--- voltar ticket ordem por sua posição na lista
      if((ticket=HistoryOrderGetTicket(i))>0)
        {
         //--- retorna propriedades de uma Ordem
         open_price=       HistoryOrderGetDouble(ticket,ORDER_PRICE_OPEN);
         time_setup=       (datetime)HistoryOrderGetInteger(ticket,ORDER_TIME_SETUP);
         time_done=        (datetime)HistoryOrderGetInteger(ticket,ORDER_TIME_DONE);
         symbol=           HistoryOrderGetString(ticket,ORDER_SYMBOL);
         order_magic=      HistoryOrderGetInteger(ticket,ORDER_MAGIC);
         positionID =      HistoryOrderGetInteger(ticket,ORDER_POSITION_ID);
         initial_volume=   HistoryOrderGetDouble(ticket,ORDER_VOLUME_INITIAL);
         type=GetOrderType(HistoryOrderGetInteger(ticket,ORDER_TYPE));
         //--- preparar e apresentar informações sobre a ordem
        
        /*
         printf("#ticket %d %s %G %s at %G foi criado em %s => feito em %s, pos ID=%d",
                ticket,                  // ticket de ordem
                type,                    // tipo
                initial_volume,          // volume colocado
                symbol,                  // simbolo
                open_price,              // preço de abertura especificado
                TimeToString(time_setup),// tempo de colocar ordem
                TimeToString(time_done), // tempo de deletar ou executar a ordem
                positionID               // ID de uma posição, ao qual a quantidade de ordem de negócio está incluído
                );
        */


        	
    Comment(" ticket ->  "+ ticket,
            "\n type ->  " + type,
            "\n initial_volume ->  " + initial_volume,
            "\n symbol ->  " + symbol,
            "\n open_price ->  " + open_price,
            "\n positionID ->  " + positionID
            
            );
	
	
        
        
        
        }
     }
//---
  }
//+------------------------------------------------------------------+
//| Retorna o nome string do tipo de ordem                           |
//+------------------------------------------------------------------+
string GetOrderType(long type)
  {
   string str_type="unknown operation";
   switch(type)
     {
      case (ORDER_TYPE_BUY):            return("compra");
      case (ORDER_TYPE_SELL):           return("vender");
      case (ORDER_TYPE_BUY_LIMIT):      return("buy limit");
      case (ORDER_TYPE_SELL_LIMIT):     return("sell limit");
      case (ORDER_TYPE_BUY_STOP):       return("buy stop");
      case (ORDER_TYPE_SELL_STOP):      return("sell stop");
      case (ORDER_TYPE_BUY_STOP_LIMIT): return("buy stop limit");
      case (ORDER_TYPE_SELL_STOP_LIMIT):return("sell stop limit");
     }
   return(str_type);
  }

//_____________________________________________________//_________________________________________


//---

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void HistoryPosition_test()
{
ulong deal_ticket;            // bilhetagem da operação (deal)
   ulong order_ticket;           // ticket da ordem que o negócio foi executado em
   datetime transaction_time;    // tempo de execução de um negócio
   long deal_type ;              // tipo de operação comercial
   long position_ID;             // ID posição
   string deal_description;      // descrição da operação
   double volume;                // volume da operação
   string symbol;                // ativo da negociação
//--- definir a data inicial e final para solicitar o histórico dos negócios
   datetime from_date=0;         // desde o princípio
   datetime to_date=TimeCurrent();//até o momento atual
//--- solicita o histórico das negociações no período especificado
   HistorySelect(from_date,to_date);
//--- número total na lista das negócios
   int deals=HistoryDealsTotal();
//--- agora processar cada trade (negócio)
   for(int i=0;i<deals;i++)
     {
      deal_ticket=               HistoryDealGetTicket(i);
      volume=                    HistoryDealGetDouble(deal_ticket,DEAL_VOLUME);
      transaction_time=(datetime)HistoryDealGetInteger(deal_ticket,DEAL_TIME);
      order_ticket=              HistoryDealGetInteger(deal_ticket,DEAL_ORDER);
      deal_type=                 HistoryDealGetInteger(deal_ticket,DEAL_TYPE);
      symbol=                    HistoryDealGetString(deal_ticket,DEAL_SYMBOL);
      position_ID=               HistoryDealGetInteger(deal_ticket,DEAL_POSITION_ID);
      deal_description=          GetDealDescription(deal_type,volume,symbol,order_ticket,position_ID);
      //--- realizar uma boa formatação para o número de negócio
      string print_index=StringFormat("% 3d",i);
      //--- mostrar informações sobre o negócio
      Print(print_index+": deal #",deal_ticket," em ",transaction_time,deal_description);
     }
  }
//+------------------------------------------------------------------+
//| Retorna a descrição string da operação                           |
//+------------------------------------------------------------------+
string GetDealDescription(long deal_type,double volume,string symbol,long ticket,long pos_ID)
  {
   string descr;
//---
   switch(deal_type)
     {
      case DEAL_TYPE_BALANCE:                  return ("balance");
      case DEAL_TYPE_CREDIT:                   return ("credit");
      case DEAL_TYPE_CHARGE:                   return ("charge");
      case DEAL_TYPE_CORRECTION:               return ("correção");
      case DEAL_TYPE_BUY:                      descr="compra"; break;
      case DEAL_TYPE_SELL:                     descr="vender"; break;
      case DEAL_TYPE_BONUS:                    return ("bonus");
      case DEAL_TYPE_COMMISSION:               return ("comissão adicional");
      case DEAL_TYPE_COMMISSION_DAILY:         return ("comissão diária");
      case DEAL_TYPE_COMMISSION_MONTHLY:       return ("comissão mensal");
      case DEAL_TYPE_COMMISSION_AGENT_DAILY:   return ("comissão de agente diário");
      case DEAL_TYPE_COMMISSION_AGENT_MONTHLY: return ("comissão de agente mensal");
      case DEAL_TYPE_INTEREST:                 return ("taxa de juros");
      case DEAL_TYPE_BUY_CANCELED:             descr="cancelado comprar negócio"; break;
      case DEAL_TYPE_SELL_CANCELED:            descr="cancelado vender negócio"; break;
     }
   descr=StringFormat("%s %G %s (ordem #%d, a posição ID %d)",
                      descr,  // descrição atual
                      volume, // volume de negócio
                      symbol, // ativo de negócio
                      ticket, // ticket da ordem que provocou o negócio
                      pos_ID  // ID de uma posição, na qual a negócio é incluído
                      );
   return(descr);
//---

}

