// https://www.mql5.com/en/docs/constants/tradingconstants/positionproperties


double from_PositionAsserts = 0;
double from_positionInf = 0;
//double THIS_POSITION_PTS;

double THIS_POSITION_BUY_VOLUME;
double THIS_POSITION_SELL_VOLUME;

double TOTAL_SYMBOL_DAY_DEAL_BALANCE = 0;







 //PositionGetDouble()
//double THIS_POSITION_VOLUME = 0; 
/*
double THIS_POSITION_SL = 0; 
double THIS_POSITION_TP = 0; 
double THIS_POSITION_SWAP = 0; 
*/
//double THIS_POSITION_VOLUME = 0;
//double THIS_POSITION_PRICE_OPEN = 0; 
//double THIS_POSITION_PRICE_CURRENT = 0; // MÉDIO 
//double CURRENT_DAY_TRADE_POSITION_PROFIT = 0; 
//double CURRENT_SWING_TRADE_POSITION_PROFIT = 0; 
//PositionGetInteger() 
//string THIS_POSITION_TYPE; 
//ENUM_POSITION_TYPE THIS_POSITION_TYPE;

//PositionGetString() 
//string THIS_POSITION_COMMENT;





void PositionAsserts()
{


	if(PositionSelect(_Symbol))
	{


		// referente ao histori DB
		LAST_ASK = CURRENT_ASK;
		LAST_BID = CURRENT_BID;
		LAST_SYMBOL_DEAL = CURRENT_SYMBOL_DEAL;

		CURRENT_ASK = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
		CURRENT_BID = SymbolInfoDouble(_Symbol, SYMBOL_BID);
		CURRENT_SYMBOL_DEAL = SymbolInfoDouble(_Symbol, SYMBOL_LAST);


		

		// referente ao position
		CURRENT_DAY_TRADE_POSITION_PROFIT				= PositionGetDouble(POSITION_PROFIT);

		THIS_POSITION_PRICE_CURRENT			= PositionGetDouble(POSITION_PRICE_CURRENT);
		THIS_POSITION_PRICE_OPEN			= PositionGetDouble(POSITION_PRICE_OPEN);
		THIS_POSITION_VOLUME 				= PositionGetDouble(POSITION_VOLUME); // não atualiza

		from_PositionAsserts = THIS_POSITION_VOLUME;
						
		THIS_POSITION_COMMENT 				= PositionGetString(POSITION_COMMENT);
		THIS_POSITION_TYPE					= (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
			
			/*
		if (THIS_POSITION_TYPE == POSITION_TYPE_BUY)
		{
			
			THIS_POSITION_PTS					= THIS_POSITION_PRICE_CURRENT - THIS_POSITION_PRICE_OPEN;
			THIS_POSITION_BUY_VOLUME            = THIS_POSITION_VOLUME;

		}
		else if (THIS_POSITION_TYPE == POSITION_TYPE_SELL)
		{
			THIS_POSITION_PTS					= THIS_POSITION_PRICE_OPEN - THIS_POSITION_PRICE_CURRENT;
			THIS_POSITION_SELL_VOLUME           = THIS_POSITION_VOLUME;
		}
		else
		{
			THIS_POSITION_PTS					= 0;
			THIS_POSITION_BUY_VOLUME            = 0;
			THIS_POSITION_SELL_VOLUME           = 0;
			THIS_POSITION_VOLUME				= 0; 
			THIS_POSITION_PRICE_OPEN 			= 0;
		}
	*/

		ENUM_POSITION_TYPE posType = PositionGetInteger(POSITION_TYPE);


		CURRENT_BUY_LIMIT_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT);
		CURRENT_SELL_LIMIT_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT);
		CURRENT_BUY_STOP_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_BUY_STOP);
		CURRENT_SELL_STOP_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_SELL_STOP);


		//TOTAL_SYMBOL_DAY_DEAL_BALANCE = MyRound(CURRENT_DAY_TRADE_POSITION_PROFIT + DYT_TOTAL_SYMBOL_DEAL_PROFIT);
		

	}


}







//_______________________________________________//__________________________________________





//_______________________________________//___________________________________________
// NOT USED

/*
bool THIS_POSITION = false;
void CheckPositionByTicket()
{
	THIS_POSITION = false;
	for(int i = PositionsTotal() - 1; i >= 0; i--)
	{
		ulong ticket = PositionGetTicket(i);
		if(ticket>0)
		{
			PositionSelectByTicket(ticket);
			THIS_POSITION = PositionSelectByTicket(ticket);
			ENUM_POSITION_TYPE posType = PositionGetInteger(POSITION_TYPE);
			//Print(EnumToString(posType) + " : " + (string)ticket);
		}
	}
}
*/




//transferir para o ontick
//https://www.mql5.com/pt/docs/constants/tradingconstants/positionproperties
double OnTickGetPositionInfs()
{
   double Total_Profit=0;
	for(int i = PositionsTotal() - 1; i >= 0; i--) {
		ulong ticket = PositionGetTicket(i);
		if(ticket>0){
			PositionSelectByTicket(ticket);
			ENUM_POSITION_TYPE posType = PositionGetInteger(POSITION_TYPE);
			Total_Profit = PositionGetDouble(POSITION_PROFIT);
			//Print(EnumToString(posType) + " : " + (string)ticket);

	/*
    Comment(" (string)ticket) ->  "+ (EnumToString(posType) + " : " + (string)ticket)
            //"\n from_PositionAsserts ->  " + from_PositionAsserts1
            );
*/
		}
	}
   return(Total_Profit);
}






//_______________________________________________//__________________________________________


// chamado pelo OnTickLoads
// funciona mas parece ser menos eficiênte que o PositionAsserts
void PositionsInfs()
{
	int countAllPositions = 0;
	int countThisPosition = 0;
		
	for (int i = PositionsTotal() - 1; i >= 0; i--)
	{
		countAllPositions += 1;
		if(PositionSelect(_Symbol))// == _Symbol)
		{
			
			//int PositionTicket = PositionGetTicket(i);
			CURRENT_DAY_TRADE_POSITION_PROFIT = PositionGetDouble(POSITION_PROFIT);
			//from_positionInf = CURRENT_DAY_TRADE_POSITION_PROFIT;
			//trade.PositionClose(PositionTicket);
			countThisPosition += 1;
			//break;
		}
	}
}





void GetThisPositionIfo()
{

	for(int i = PositionsTotal() - 1; i >= 0; i--)
	{
		string symbol = PositionGetSymbol(i);

		if(Symbol() == symbol)
		{
			

		}
	}
}



