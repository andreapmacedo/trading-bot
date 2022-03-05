// https://www.mql5.com/en/docs/marketinformation

double LAST_SYMBOL_DEAL;
double CURRENT_SYMBOL_DEAL;

double CURRENT_ASK;
double CURRENT_BID;
double LAST_ASK;
double LAST_BID;


/*
double r_SYMBOL_SESSION_OPEN				= SymbolInfoDouble(_Symbol, SYMBOL_SESSION_OPEN);
double r_SYMBOL_SESSION_CLOSE				= SymbolInfoDouble(_Symbol, SYMBOL_SESSION_CLOSE);
*/


//
void load_initial_deals_args()
{
/*
	r_SYMBOL_SESSION_OPEN				= SymbolInfoDouble(_Symbol, SYMBOL_SESSION_OPEN);
	r_SYMBOL_SESSION_CLOSE				= SymbolInfoDouble(_Symbol, SYMBOL_SESSION_CLOSE);
	Tick_Size     		= SymbolInfoDouble(_Symbol, SYMBOL_TRADE_TICK_SIZE);         
	r_SYMBOL_VOLUME_MAX           		= SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);				
    r_SYMBOL_VOLUME_MIN		       	 	= SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
    */ 			
}	


void reload_session_deals_args()
{


}	

void update_deals_args_by_trade()
{
	if(PositionSelect(_Symbol))
	{


	}	

}	

void update_deals_args_by_time()
{


}

	
void update_deals_args_by_bar()
{


}	
	