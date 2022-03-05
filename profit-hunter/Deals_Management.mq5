//+------------------------------------------------------------------+
//| Trade management
//+------------------------------------------------------------------+
// Orders Managemente (qtd, prace add, sl, tp, trailing)
//+------------------------------------------------------------------+
// Risk Managemente ?
//+------------------------------------------------------------------+


//--- Manipulador de ordem por evento de MUDANÇA NAS ORDENS DO ROBÔ
//+==================================================================+
//| OnTrade                                            				 |
//+==================================================================+


//+------------------------------------------------------------------+
//--- do OnTrade()
//input    int days=7;            // profundidade do histórico de negociação em dias
int          days=7;            // profundidade do histórico de negociação em dias
//--- definimos no nível global os limites do histórico de negociação
datetime     start;             // data de início do histórico de negociação em cache
datetime     end;               // data final do histórico de negociação em cache
//--- contadores globais
int          orders;            // número de ordens vigentes
int          positions;         // número de posições abertas
int          deals;             // número de transações no cache do histórico de negociação
int          history_orders;    // número de ordens no cache do histórico de negociaçãod
bool         started=false;     // sinalizador da relevância dos contadores
//---//--- 
//+------------------------------------------------------------------+


string CurrentPositionStatus = "No Position";

//+------------------------------------------------------------------+
//|  Inicializando contadores de posições, de ordens e de transações |
//+------------------------------------------------------------------+

//--- OnTrade
void InitCounters()
{
   ResetLastError();
//--- carregamos o histórico
   bool selected=HistorySelect(start,end);
   if(!selected)
     {
      PrintFormat("%s. Não foi possível carregar no cache o histórico de %s a %s. Código de erro: %d",
                  __FUNCTION__,TimeToString(start),TimeToString(end),GetLastError());
      return;
     }
//--- obtemos os valores atuais
   orders=OrdersTotal();
   positions=PositionsTotal();
   deals=HistoryDealsTotal();
   history_orders=HistoryOrdersTotal();
   started=true;
   Print("Inicialização de contadores de ordens, de posições e de transações bem-sucedida");
   
}  
  

  
//+------------------------------------------------------------------+
//| chamado quando ocorre o evento Trade                             |
//+------------------------------------------------------------------+
//| https://www.mql5.com/pt/docs/event_handlers/ontrade
//+------------------------------------------------------------------+




void OnTrade()
{
		/*
		if(started) SimpleTradeProcessor();
		else InitCounters();
		*/

	/*
	if (ON_TRADE_ON)
	{	  
		if(started) SimpleTradeProcessor();
		else InitCounters();
	  
	}
	*/
	
}
//+------------------------------------------------------------------+
//| exemplo de processamento de alterações na negociação e no histórico
//+------------------------------------------------------------------+
void SimpleTradeProcessor()
{
	end=TimeCurrent();
	ResetLastError();


	/*
	Comment("número de transações no cache do histórico de negociação foi alterado"

		);
	*/




//--- carregamos no cache do programa o histórico de negociação a partir do intervalo especificado
   bool selected=HistorySelect(start,end);
   //bool selected=HistorySelect(TIME_DATE,INT_MAX);
   if(!selected)
     {
      PrintFormat("%s. Não foi possível carregar no cache o histórico de %s a %s. Código de erro: %d",
                  __FUNCTION__,TimeToString(start),TimeToString(end),GetLastError());
      return;
     }


//--- obtemos os valores atuais
   int curr_orders=OrdersTotal();      // 
   int curr_positions=PositionsTotal();// 
   int curr_deals=HistoryDealsTotal(); // 
   int curr_history_orders=HistoryOrdersTotal();  



//_________________________________________________________________________________		  

		



//_________________________________________________________________________________	

 
   
   
//--- verificamos as alterações na quantidade de ordens vigentes
	if(curr_orders!=orders)
	{
		//--- número de ordens vigentes alterado
		PrintFormat("O número de ordens foi alterado de %d para %d",
                  orders,curr_orders);
		//--- atualizamo o valor
		orders=curr_orders;
//_________________________________________________________________________________		  
		
		
		

//_________________________________________________________________________________		  
	  
	}
//--- alteração no número de posições abertas
	if(curr_positions!=positions)
	{
		//--- o número de posições abertas foi alterado
		PrintFormat("O número de posições abertas foi alterado de %d para %d",
                  positions,curr_positions);
		//--- atualizamos o valor
		positions=curr_positions;
	  
	  
		//_________________________________________________________________________________		  



		//_________________________________________________________________________________		  
	  	  
	  
    }
//--- alterações no número de transações no cache do histórico de negociação
   if(curr_deals!=deals)
	{
      //--- número de transações no cache do histórico de negociação foi alterado
      PrintFormat("O número de transações globais foi alterado de %d para %d",
                  deals,curr_deals); 
      //--- atualizamo o valor
      deals=curr_deals;
		//_________________________________________________________________________________		  

   	
		//-- Chamadas apenas para trades executados
		//DYT_HistoryDeals();
		//SWT_HistoryDeals();

		//OnTradeLoads();
//		OnDeals_Routine();
	
		//_________________________________________________________________________________		  
	  
	  
	  
	}
//--- alterações no número de ordens históricas no cache do histórico de negociação
   if(curr_history_orders!=history_orders)
     {
      //--- número de ordens históricas no cache do histórico de negociação foi alterado
      /*PrintFormat("O número de ordens no histórico foi alterado de %d para %d",
                  history_orders,curr_history_orders);*/
     //--- atualizamos o valor
     history_orders=curr_history_orders;
	 
		//_________________________________________________________________________________		  
		

		//_________________________________________________________________________________	
	 
	 
     }
	//--- verificamos se é necessário alterar os limites do histórico de negociação para solicitação no cache
   CheckStartDateInTradeHistory();
}






//+------------------------------------------------------------------+
//|  alterações da data de início para a solicitação do histórico de negociação      
//+------------------------------------------------------------------+
void CheckStartDateInTradeHistory()
  {
//--- intervalo de início, se começarmos a trabalhar agora
   datetime curr_start=TimeCurrent()-days*PeriodSeconds(PERIOD_D1);
//--- verificamos que o limite do início do histórico de transações seja inferior
//--- a 1 dia a partir da data planejada
   if(curr_start-start>PeriodSeconds(PERIOD_D1))
     {
      //--- deve-se corrigir a data de início do histórico carregado no cache
      start=curr_start;
      PrintFormat("Novo limite de início do histórico de negociação carregado: início => %s",
                  TimeToString(start));
      //--- agora recarregamos o histórico de transações para o intervalo atualizado
      HistorySelect(start,end);
      //--- corrigimos os contadores de transações e de ordens no histórico para a próxima comparação
      history_orders=HistoryOrdersTotal();
      deals=HistoryDealsTotal();
     }
  }
//+------------------------------------------------------------------+
/* Exemplo de exibição:
  Limites do histórico de negociação carregado: início - 2018.07.16 18:11, fim - 2018.07.23 18:11
  Contadores de ordens, deposições e de transações inicializados com sucesso
  O número de ordens foi alterado. Havia 0, há 1      -> número de ordens em aberto
  O número de ordens foi alterado. Havia 1, há 0      -> 
  O número de posições foi alterado. Havia 0, há 1    -> se está posicionado 
  O número de transações foi alterado. Havia 0, há 1
  O número de ordens no histórico foi alterado. Havia 0, há 1 -> ordens executadas.
*/  





//_______________________________________/_________________________________________

//--- Manipulador de ordem por evento de novo negócio DO ROBÔ
//+==================================================================+
//| OnTradeTransaction                                               |
//+==================================================================+



datetime LAST_ENTRY = 0;
datetime LAST_TIME_TRADE_INTERVAL = 0;
datetime LAST_TIME_TRADE_INTERVAL_AVARAGE = 0;
datetime SUM_TIME_TRADE_INTERVAL = 0;


int Full_Historic_Deals = 0;


double LAST_DEAL_VOLUME;
double LAST_DEAL_PRICE;
double LAST_DEAL_RESULT;
double LAST_DEAL_TYPE;

double LAST_SELL;
int LAST_SELL_SEQUENCE;
double LAST_TOTAL_DEAL_SELL;


double LAST_BUY;
int LAST_BUY_SEQUENCE;
double LAST_TOTAL_DEAL_BUY;


double LAST_TOTAL_DEAL_OUT;
double LAST_TOTAL_DEAL_IN;





double CURRENT_DEAL_VOLUME;
double CURRENT_DEAL_PRICE;
double CURRENT_DEAL_RESULT;
double CURRENT_DEAL_TYPE;

double CURRENT_SYMBOL_SELL;
int CURRENT_SYMBOL_SELL_SEQUENCE;
double CURRENT_SYMBOL_TOTAL_DEAL_SELL;


double CURRENT_SYMBOL_BUY;
int CURRENT_SYMBOL_BUY_SEQUENCE;
double CURRENT_SYMBOL_TOTAL_DEAL_BUY;


double CURRENT_TOTAL_SYMBOL_DEAL_OUT;
double CURRENT_TOTAL_SYMBOL_DEAL_IN;



string LAST_DEAL_TYPE_STATUS;

        

/*
double CURRENT_LONG_POSITION_VALUE;
double CURRENT_SHORT_POSITION_VALUE;

// tem uma outra var com essa função (not used)
double CURRENT_LONG_POSITION_VOLUME;
double CURRENT_SHORT_POSITION_VOLUME;


int n_DEAL_TICKET;
int n_DEAL_ORDER;
int n_DEAL_MAGIC;
int n_DEAL_POSITION_ID;


/*
string s_CURRENT_DEAL_TYPE;
string s_LAST_DEAL_TYPE_STATUS;


double r_CURRENT_ADD;
double r_CURRENT_TP;
double r_CURRENT_LEVEL_UPDATE;

/*
double r_CURRENT_SHORT_ADD;
double r_CURRENT_LONG_ADD;

double r_CURRENT_SELL_TP;
double r_CURRENT_BUY_TP;
 
double r_CURRENT_SHORT_LEVEL_UPDATE;
double r_CURRENT_LONG_LEVEL_UPDATE;
					
/*

double smt_add = DEF_INCREMENT_PTS;
double smt_tp  = DEF_TP_INCREMENT_PTS;
double smt_upd = DEF_UPDATE_INCREMENT_PTS;

*/

// https://www.mql5.com/pt/articles/1111
// https://www.mql5.com/pt/docs/constants/structures/mqltradetransaction

int Current_Buy_Seq;
int Current_Sell_Seq;
double Current_Historic_Vol;
double Current_Historic_Last_Deal_Price;
double Current_Historic_Deal_Profit;

void SetTradingMode()
{
	// if(!DAY_TRADE_MODE)
	// {
	// 	SWT_HistoryDeals();
	// 	Current_Buy_Seq  = SWT_SYMBOL_BUY_SEQUENCE;
	// 	Current_Sell_Seq  = SWT_SYMBOL_SELL_SEQUENCE;
	// 	Current_Historic_Vol = SWT_TOTAL_SYMBOL_DEAL_COUNT_VOL;
	// 	Current_Historic_Deal_Profit = SWT_TOTAL_SYMBOL_DEAL_PROFIT;
	// 	Current_Historic_Last_Deal_Price = DYT_SYMBOL_LAST_DEAL_PRICE;
	// }
	// else
	// {
		DYT_HistoryDeals();
		Current_Buy_Seq  = DYT_SYMBOL_BUY_SEQUENCE;
		Current_Sell_Seq  = DYT_SYMBOL_SELL_SEQUENCE;
		Current_Historic_Vol = DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL;
		Current_Historic_Deal_Profit = DYT_TOTAL_SYMBOL_DEAL_PROFIT;
		Current_Historic_Last_Deal_Price = DYT_SYMBOL_LAST_DEAL_PRICE;
	// }
}


void OnTradeTransaction(const MqlTradeTransaction & trans,
                        const MqlTradeRequest & request,
                        const MqlTradeResult & result)
{
	if (HistoryDealSelect(trans.deal))
	{	
		//-- Este if(_Symbol) apenas impede que o código adiante seja chamado para cada robô em funcionamento
		if(HistoryDealGetString(trans.deal, DEAL_SYMBOL) == _Symbol)
		{
			if(started) 
			{
				end=TimeCurrent();
				ResetLastError();				
				/*
				Comment("número de transações no cache do histórico de negociação foi alterado"

					);
				*/

				//--- carregamos no cache do programa o histórico de negociação a partir do intervalo especificado
				bool selected=HistorySelect(start,end);
				//bool selected=HistorySelect(TIME_DATE,INT_MAX);
				if(!selected)
					{
					PrintFormat("%s. Não foi possível carregar no cache o histórico de %s a %s. Código de erro: %d",
								__FUNCTION__,TimeToString(start),TimeToString(end),GetLastError());
					return;
					}


				//--- obtemos os valores atuais
				int curr_orders=OrdersTotal();      // 
				int curr_positions=PositionsTotal();// 
				int curr_deals=HistoryDealsTotal(); // 
				int curr_history_orders=HistoryOrdersTotal();  


				//_________________________________________________________________________________		  
						
	

				//_________________________________________________________________________________	

				
				
				
				//--- verificamos as alterações na quantidade de ordens vigentes
				if(curr_orders!=orders)
				{
					//--- número de ordens vigentes alterado
					// PrintFormat("O número de ordens foi alterado de %d para %d",
					//           orders,curr_orders);
					//--- atualizamo o valor
					orders=curr_orders;
				//_________________________________________________________________________________		  

					
					

				//_________________________________________________________________________________		  
				
				}
				//--- alteração no número de posições abertas
				if(curr_positions!=positions)
				{
					//--- o número de posições abertas foi alterado
					//PrintFormat("O número de posições abertas foi alterado de %d para %d",
					//          positions,curr_positions);
					positions=curr_positions;
					//_________________________________________________________________________________		  



					//_________________________________________________________________________________		  
					
				
				}
				//--- alterações no número de transações no cache do histórico de negociação
				if(curr_deals!=deals)
				{
					//--- número de transações no cache do histórico de negociação foi alterado
					PrintFormat("O número de transações globais foi alterado de %d para %d",
								deals,curr_deals); 
					//--- atualizamo o valor
					deals=curr_deals;
					//_________________________________________________________________________________		  
					Full_Historic_Deals += 1;

					SetTradingMode();



					ENUM_DEAL_ENTRY deal_entry = (ENUM_DEAL_ENTRY) HistoryDealGetInteger(trans.deal, DEAL_ENTRY);
					ENUM_DEAL_REASON deal_reason = (ENUM_DEAL_REASON) HistoryDealGetInteger(trans.deal, DEAL_REASON);
					ENUM_ORDER_STATE 				lastOrderState  	 = trans.order_state;
					ENUM_TRADE_TRANSACTION_TYPE  	trans_type 			 = trans.type;

					LAST_DEAL_VOLUME           = CURRENT_DEAL_VOLUME; 
					LAST_DEAL_PRICE            = CURRENT_DEAL_PRICE;
					LAST_DEAL_RESULT           = CURRENT_DEAL_RESULT;
					LAST_DEAL_TYPE 			   = CURRENT_DEAL_TYPE;

					
					CURRENT_DEAL_VOLUME           = HistoryDealGetDouble(trans.deal, DEAL_VOLUME); 
					CURRENT_DEAL_PRICE            = HistoryDealGetDouble(trans.deal, DEAL_PRICE);
					CURRENT_DEAL_RESULT           = NormalizeDouble(HistoryDealGetDouble(trans.deal, DEAL_PROFIT),1);
					CURRENT_DEAL_TYPE			  = HistoryDealGetInteger(trans.deal, DEAL_TYPE);


					

					//int MyGetPosition()
					//MyGetVolumePosition()
					// aqui vamos acumulando as estatísticas o uso delas pelo tempo será individualizado 

					LAST_TIME_TRADE_INTERVAL =  TimeCurrent() - LAST_ENTRY;
					SUM_TIME_TRADE_INTERVAL += LAST_TIME_TRADE_INTERVAL;
					LAST_ENTRY = TimeCurrent();

				

					//media de intervalo de trade por período
/*
					if(CURRENT_DEAL_TYPE == LAST_DEAL_TYPE)
					{
						// houve uma adição
						// média de spread entre as adiçoes

					}
					else
					{

						// houve uma realização
						// média de spread entre as realizações
					}

*/

					/*
					if(MyGetPosition() == 1)
					{
						if()
					}
					*/



					//---Calcs

					if (CURRENT_DEAL_TYPE == DEAL_TYPE_BUY)
					{
						LAST_TOTAL_DEAL_BUY += CURRENT_DEAL_VOLUME;
						LAST_BUY_SEQUENCE +=1;
						LAST_BUY = CURRENT_DEAL_PRICE;
					}
					else
					{
						LAST_BUY_SEQUENCE = 0;
					}
					if(CURRENT_DEAL_TYPE == DEAL_TYPE_SELL)
					{
						LAST_TOTAL_DEAL_SELL += CURRENT_DEAL_VOLUME;
						LAST_SELL_SEQUENCE +=1;
						LAST_SELL = CURRENT_DEAL_PRICE;
					}
					else
					{
						LAST_SELL_SEQUENCE = 0;
					}



					if (CURRENT_DEAL_TYPE == DEAL_ENTRY_IN)
					{
						LAST_TOTAL_DEAL_IN += CURRENT_DEAL_VOLUME;
					}
					if(CURRENT_DEAL_TYPE == DEAL_ENTRY_OUT)   
					{
						LAST_TOTAL_DEAL_OUT += CURRENT_DEAL_VOLUME;  
					}   


	




					
					
					
					// dados
					// lucro
					// preço
					// volume
					// lado




					// estatística
				
					// tempo de um trade para o outro (comparar com a conta demo)
				
				
					// estava comprado / vendido
					// volume negociado
					// volume que estava
					// sequência de entrada para o lado
					// sequencia de entrada para o lado oposto
					// poder de acumulação de entrada para o mesmo lado
					// virada de mão
					

					// comparar a última entrada com a atual e verificar
					// foi adição ou realização?
					//se foi realização, foi no lucro ou no preju?
					// qual foi a distância para a entrada
					// qual é a distância média


					// tempo entre um negócio e outro
			
					// negócios por minuto
					// lucro por minuto
					// custo por minuto






					//DYT_SYMBOL_LAST_DEAL_TYPE e SWT_SYMBOL_LAST_DEAL_TYPE são melhores que esta solução abaixo, TALVEZ

					if(CURRENT_DEAL_TYPE == DEAL_TYPE_BUY)
					{
						LAST_DEAL_TYPE_STATUS = "c";
						//Deal_Current_Level = Last_CurrentLevelBuy;
						//Deal_Current_Level = Deal_Current_CurrentLevelBuy;
						//Deal_Current_Level = Setted_Last_CurrentLevelBuy;
					}
					else if(CURRENT_DEAL_TYPE == DEAL_TYPE_SELL)
					{
						LAST_DEAL_TYPE_STATUS = "v";
						//Deal_Current_Level = Last_CurrentLevelSell;
						//Deal_Current_Level = Deal_Current_CurrentLevelSell;
						//Deal_Current_Level = Setted_Last_CurrentLevelSell;
					}
					else
					{
						LAST_DEAL_TYPE_STATUS = "";
					}



					// aqui vamos chamar o white file do dile deal management
					if(GENERATE_DEAL_RESUME)
					{
						Write_File_Deals_CSV(File_Resume_Deals_CSV);
					}

					Set_Quarter_Resume();
					Set_Hourly_Resume();
					

					// Print("LAST_DEAL_TYPE_STATUS -> ", LAST_DEAL_TYPE_STATUS); 
					// Print("--------------------------------------");
					// Print("HistoryDealSelect -> ", _Symbol);
					// Print("--------------------------------------");
					// Print("Setted_Last_CurrentLevelBuy -> ", Setted_Last_CurrentLevelBuy);
					// Print("Setted_Last_CurrentLevelSell -> ", Setted_Last_CurrentLevelSell);
					// Print("--------------------------------------");
					// Print("--------------------------------------");
					// Print("CURRENT_DEAL_PRICE -> ", CURRENT_DEAL_PRICE);
					// Print("Deal_Current_Level -> ", Deal_Current_Level);
					// Print("my_current_deal -> ", my_current_deal);
					// Print("my_last_deal -> ", my_last_deal);
					// Print("--------------------------------------");
					// Print("Last_CurrentLevelBuy -> ", Last_CurrentLevelBuy);
					// Print("Last_CurrentLevelSell -> ", Last_CurrentLevelSell);
					// Print("--------------------------------------");
					
					//MyGetPositionData();
					
					// CurrentPositionVol = MyGetVolumePosition();
    				// CurrentPositionSide = MyGetPosition();
					// CurrentPositionStatus = MyGetPositionStatus();

					
					//Print("LAST_DEAL_TYPE_STATUS -> ", LAST_DEAL_TYPE_STATUS);

				
					//-- Chamadas apenas para trades executados

					
					OnDeals_Routine();
					
					//SO_FOLLOW_LOCK = 0;
					Sleep(Sleep);	


					Set_SO(3);
					//_________________________________________________________________________________		  
				
				
				
				}
				//--- alterações no número de ordens históricas no cache do histórico de negociação
				if(curr_history_orders!=history_orders)
				{
					//--- número de ordens históricas no cache do histórico de negociação foi alterado
					/*PrintFormat("O número de ordens no histórico foi alterado de %d para %d",
								history_orders,curr_history_orders);*/
					history_orders=curr_history_orders;
				
					//_________________________________________________________________________________		  


					//_________________________________________________________________________________	
				
				
				}
				//--- verificamos se é necessário alterar os limites do histórico de negociação para solicitação no cache
				CheckStartDateInTradeHistory();
			}
			else
			{
				InitCounters();	
			} 
			//--- A chamada a parter deste local faz com que apenas uma chamada seja (a do símbolo que a originou) ao invés de cada robô funcionando.
			// Chamada para o processador original
			/*
			if(started) SimpleTradeProcessor();
			else InitCounters();
			*/



			//ulong          lastOrderID   = trans.order;
			//ulong          lastDealID   = trans.deal;
			

			//+------------------+
			//my
			//+------------------+
			//https://www.mql5.com/pt/docs/constants/tradingconstants/dealproperties
			//+------------------+
			
			//n_DEAL_TICKET 			= HistoryDealGetInteger(trans.deal, DEAL_TICKET);
			//n_DEAL_ORDER 			= HistoryDealGetInteger(trans.deal, DEAL_ORDER); 
			//n_DEAL_MAGIC 			= HistoryDealGetInteger(trans.deal, DEAL_MAGIC); 
			//n_DEAL_POSITION_ID 		= HistoryDealGetInteger(trans.deal, DEAL_POSITION_ID); 
			


			//+------------------------------------------------------------------+
			

		}
	} //end HistoryDealSelect
} // end OnTradeTransaction
