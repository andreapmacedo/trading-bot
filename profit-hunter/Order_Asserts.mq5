
//+------------------------------------------------------------------+
//| Orders Info                                                      |
//+------------------------------------------------------------------+


int COUNT_BUY_ORDER = 0;
int COUNT_SELL_ORDER = 0;


void CountOrders(string symbol)
{

	string   type;
   COUNT_BUY_ORDER = 0;
   COUNT_SELL_ORDER = 0;
	

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			{					

				type = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));
				
				if(type == "ORDER_TYPE_SELL_STOP" || type == "ORDER_TYPE_SELL_LIMIT")
				{
               COUNT_SELL_ORDER += 1;

            }
				if(type == "ORDER_TYPE_BUY_STOP" || type == "ORDER_TYPE_BUY_LIMIT")
				{
               COUNT_BUY_ORDER += 1 ;
            }

			}
		}
	}
}



// mockup
/*
void OrdersLoop(string symbol)
{

	string   type;

	

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			{					



			}
		}
	}
}

*/