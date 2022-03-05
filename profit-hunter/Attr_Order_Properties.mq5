// https://www.mql5.com/en/docs/constants/tradingconstants/orderproperties

// orders








int CURRENT_BUY_LIMIT_ORDERS;
int CURRENT_SELL_LIMIT_ORDERS;
int CURRENT_BUY_STOP_ORDERS;
int CURRENT_SELL_STOP_ORDERS;

int THIS_SYMBOL_TOTAL_ORDERS = 0;

double ThisOrdersVolume = 0; 
int ThisOrdersTotal = 0; 
int ThisOrdersTotal_Buy = 0; 
int ThisOrdersTotal_Buy_Limit = 0; 
int ThisOrdersTotal_Buy_Stop = 0; 
int ThisOrdersTotal_Sell = 0; 
int ThisOrdersTotal_Sell_Limit = 0; 
int ThisOrdersTotal_Sell_Stop = 0; 



int GetThisOrderInfo()
{
    int result = 0;
	//string   type;
	ThisOrdersTotal = 0; 
	

	for(int i = OrdersTotal() - 1; i >= 0; i--)
	{
		if(OrderGetTicket(i) > 0)
		{
			//if((OrderGetString(ORDER_SYMBOL) == THIS_SYMBOL))
			if((OrderGetString(ORDER_SYMBOL) == _Symbol))
			{				
				result  +=1 ; 

				//type = EnumToString(ENUM_ORDER_TYPE(OrderGetInteger(ORDER_TYPE)));		

                CURRENT_BUY_LIMIT_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT);
                CURRENT_SELL_LIMIT_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT);
                CURRENT_BUY_STOP_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_BUY_STOP);
                CURRENT_SELL_STOP_ORDERS 			= CountOrdersForPairType(ORDER_TYPE_SELL_STOP);



				/*
                Comment(" result ->  "+ result,
                        "\n CURRENT_BUY_LIMIT_ORDERS ->  " + CURRENT_BUY_LIMIT_ORDERS,
                        "\n CURRENT_BUY_STOP_ORDERS ->  " + CURRENT_BUY_STOP_ORDERS,
                        "\n CURRENT_SELL_LIMIT_ORDERS ->  " + CURRENT_SELL_LIMIT_ORDERS,
                        "\n CURRENT_SELL_STOP_ORDERS ->  " + CURRENT_SELL_STOP_ORDERS
                        
                        );					
				
                */

			}
		}
	}



    THIS_SYMBOL_TOTAL_ORDERS = result;
    return result;

    



}