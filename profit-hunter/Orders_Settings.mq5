

bool REVERSE_ORDER = false;



double LAST_PLACED_FINAL_EN_LONG_VALUE = 0;
double LAST_PLACED_FINAL_EN_SHORT_VALUE = 0;
double LAST_PLACED_FINAL_EN_ORDER_SPREAD = 0;

double LAST_SETTED_FINAL_EN_LONG_VALUE = 0;
double LAST_SETTED_FINAL_EN_SHORT_VALUE = 0;
double LAST_SETTED_FINAL_EN_ORDER_SPREAD = 0;


double LAST_PLACED_FINAL_EN_LONG_VOLUME = 0;
double LAST_PLACED_FINAL_EN_SHORT_VOLUME = 0;


double LAST_SETTED_FINAL_EN_LONG_VOLUME = 0;
double LAST_SETTED_FINAL_EN_SHORT_VOLUME = 0;





bool CHECKED_LONG_VARS = false;
bool CHECKED_SHORT_VARS = false;


void PlaceOrders(int callFrom)
{
	CheckPositionOrdersDistance();
	CheckPositionVolume();
	CheckDayForTrading();
	Check_Position_EN_First();
	Check_DYT_EN_First();


	//Check_Spread();
	//TODO
	// CAPTURAR OS DADOS DE DA ORDEM ANTES DO LONG / SHORT POSITION

	//--- Atualiza os dados que foram definidos pelos algorítimos antes do place
	
	//Setted_EN_Long();
	//Setted_EN_Short();


	if(LONG_CONDITIONS)
	{	
			Set_EN_Long(FINAL_LONG_VOLUME);
	}
	if(SHORT_CONDITIONS)
	{	
			Set_EN_Short(FINAL_SHORT_VOLUME);
	}

	Check_Placed();



	if(Orders_Place_Drawings_on)
	{
		OrdersPlace_Drawings();
	}

}




void Set_EN_Long(double vol)
{

	if (LONG_POSITION_ON && TIME_TRADE_FILTER_OK && DAY_TRADE_FILTER_OK)
	{	
		if(!BREAK_MODE)
		{
			if(FINAL_EN_LONG_VALUE <= SymbolInfoDouble(_Symbol, SYMBOL_ASK))
			{
				Place_Order_evo(EN_ORDER_TYPE_LONG, FINAL_EN_LONG_VALUE, FINAL_SL_LONG_VALUE , FINAL_TP_LONG_VALUE,  vol);
				Print("Set_EN_Long");
				LAST_PLACED_FINAL_EN_LONG_VALUE = FINAL_EN_LONG_VALUE;
				LAST_PLACED_FINAL_EN_LONG_VOLUME  = vol;


				Placed_EN_Vars();
			}
			else
			{
				Print("erro value");	
				//Set_SO(4);	
			}
		}
		else
		{
			if(FINAL_EN_LONG_VALUE >= SymbolInfoDouble(_Symbol, SYMBOL_ASK))
			{
				Place_Order_evo(EN_ORDER_TYPE_LONG, FINAL_EN_LONG_VALUE, FINAL_SL_LONG_VALUE , FINAL_TP_LONG_VALUE,  vol);
				Print("Set_EN_Long");
				LAST_PLACED_FINAL_EN_LONG_VALUE = FINAL_EN_LONG_VALUE;
				LAST_PLACED_FINAL_EN_LONG_VOLUME  = vol;


				Placed_EN_Vars();
			}
			else
			{
				Print("erro value");	
				//Set_SO(4);	
			}			
		}





		//(if simulator)
		//{

			// esta é uma alternativa. o SO simulado deve conter o codigo de execu.
			// armazenar as informações para quando em modo simulador de trade (seja para estatistica puramente ou para atuar em uma contra estratégia)
			// pelo id do so(callfrom) armazernar ou trabalhar com estes dados
		//}

	}

}



void Set_EN_Short(double vol)
{
	if(SHORT_POSITION_ON && TIME_TRADE_FILTER_OK && DAY_TRADE_FILTER_OK)
	{
		if(!BREAK_MODE)
		{		
			if(FINAL_EN_SHORT_VALUE >= SymbolInfoDouble(_Symbol, SYMBOL_BID))
			{		
				Place_Order_evo(EN_ORDER_TYPE_SHORT, FINAL_EN_SHORT_VALUE, FINAL_SL_SHORT_VALUE , FINAL_TP_SHORT_VALUE, vol);
				Print("Set_EN_Short");
				LAST_PLACED_FINAL_EN_SHORT_VALUE = FINAL_EN_SHORT_VALUE;
				LAST_PLACED_FINAL_EN_SHORT_VOLUME = vol;
				Placed_EN_Vars();
			}
			else
			{
				//Set_SO(4);
				Print("erro value");	
			}
		}
		else
		{
			if(FINAL_EN_SHORT_VALUE <= SymbolInfoDouble(_Symbol, SYMBOL_BID))
			{		
				Place_Order_evo(EN_ORDER_TYPE_SHORT, FINAL_EN_SHORT_VALUE, FINAL_SL_SHORT_VALUE , FINAL_TP_SHORT_VALUE, vol);
				Print("Set_EN_Short");
				LAST_PLACED_FINAL_EN_SHORT_VALUE = FINAL_EN_SHORT_VALUE;
				LAST_PLACED_FINAL_EN_SHORT_VOLUME = vol;
				Placed_EN_Vars();
			}
			else
			{
				//Set_SO(4);
				Print("erro value");	
			}			
		}
	}
}


void Setted_EN_Long()
{


	if(FINAL_EN_LONG_VALUE > SymbolInfoDouble(_Symbol, SYMBOL_ASK))
	{
		LONG_CONDITIONS = false;
		Set_SO(4);		
	}
	else
	{
		LAST_SETTED_FINAL_EN_LONG_VALUE = FINAL_EN_LONG_VALUE;
		LAST_SETTED_FINAL_EN_LONG_VOLUME = FINAL_LONG_VOLUME;
	}	
}

void Setted_EN_Short()
{


	if(FINAL_EN_SHORT_VALUE < SymbolInfoDouble(_Symbol, SYMBOL_BID))
	{
		SHORT_CONDITIONS = false;
		Set_SO(4);		
	}
	else
	{
		LAST_SETTED_FINAL_EN_SHORT_VALUE = FINAL_EN_SHORT_VALUE;
		LAST_SETTED_FINAL_EN_SHORT_VOLUME = FINAL_SHORT_VOLUME;
	}
}


void Placed_EN_Vars()
{
	if(!BREAK_MODE)
	{
		LAST_PLACED_FINAL_EN_ORDER_SPREAD = LAST_PLACED_FINAL_EN_SHORT_VALUE - LAST_PLACED_FINAL_EN_LONG_VALUE;
	}
	else
	{
		LAST_PLACED_FINAL_EN_ORDER_SPREAD = LAST_PLACED_FINAL_EN_LONG_VALUE - LAST_PLACED_FINAL_EN_SHORT_VALUE;
	}

}

//--
void Check_Placed()
{
	CHECKED_LONG_VARS = false;
	CHECKED_SHORT_VARS = false;

	if(LAST_SETTED_FINAL_EN_LONG_VALUE == LAST_PLACED_FINAL_EN_LONG_VALUE)
	{
		CHECKED_LONG_VARS = true;

	}
	if(LAST_SETTED_FINAL_EN_SHORT_VALUE == LAST_PLACED_FINAL_EN_SHORT_VALUE)
	{
		CHECKED_SHORT_VARS = true;

	}


}



//________________________________________________//_______________________________________________________//______________________________________
// EVO
//________________________________________________//_______________________________________________________//______________________________________
double EN_BUY_MARKET_LEVEL;
double EN_SELL_MARKET_LEVEL;


double Setted_Last_Level_Buy;
double Setted_Last_Level_Sell;
double Deal_Current_Level;
double Deal_Last_Level;



void SetSpdReverse()
{
    if(SPD_REVERSE > 0)
    {
        if(SPD_LEVELS < 0 && pos_volume >= SELECTED_LIMIT_POSITION_VOLUME )
        {
            if(pos_status == 0)
            {
                int r = Place_Market_Order_Dev(ORDER_TYPE_SELL, Level_Sell, NULL , NULL,  currentSellVolume);
                Print("SPD_REVERSE");
                //return (-3);
            }
            if(pos_status == 1)
            {
                int r = Place_Market_Order_Dev(ORDER_TYPE_BUY, Level_Buy, NULL , NULL,  currentBuyVolume);
                Print("SPD_REVERSE");
               // return (-3);
            }
            //Set_SO(3);
        }
    }
}
void SetSpdReverse2()
{
    if(SPD_REVERSE > 0)
    {
        if(SPD_LEVELS < SPD_REVERSE_VALUE && pos_volume >= SELECTED_LIMIT_POSITION_VOLUME )
        {
            if(pos_status == 0)
            {
                //int r = Place_Market_Order_Dev(ORDER_TYPE_SELL, Level_Sell, NULL , NULL,  currentSellVolume);
                Level_Sell = SERVER_SYMBOL_BID;
                Print("SPD_REVERSE");
                //return (-3);
            }
            if(pos_status == 1)
            {
                //int r = Place_Market_Order_Dev(ORDER_TYPE_BUY, Level_Buy, NULL , NULL,  currentBuyVolume);
                Level_Buy = SERVER_SYMBOL_ASK;
                Print("SPD_REVERSE");
               // return (-3);
            }
        }
    }
}
void SetSpdReverse3()
{
    if(SPD_REVERSE > 0)
    {
        if(SPD_LEVELS <= SPD_REVERSE_VALUE)
        {
            Set_Trigger_SPD_001();
        }
    }
}


void Set_Trigger_SPD_001()
{
    if(pos_status == 0)
    {
        //int r = Place_Market_Order_Dev(ORDER_TYPE_SELL, Level_Sell, NULL , NULL,  currentSellVolume);
        Level_Sell = SERVER_SYMBOL_BID;
        Print("SPD_REVERSE");
        
    }
    if(pos_status == 1)
    {
        //int r = Place_Market_Order_Dev(ORDER_TYPE_BUY, Level_Buy, NULL , NULL,  currentBuyVolume);
        Level_Buy = SERVER_SYMBOL_ASK;
        Print("SPD_REVERSE");
        
    }
}


void Set_Trigger_Order_Dev()
{
    if(CheckSellManagemente_Evo())
    {
        if(Central_Bottom > Level_Sell )
        {
            //int r = Place_Market_Order_Dev(ORDER_TYPE_SELL, Level_Buy, NULL , NULL,  currentBuyVolume);
            int r = Place_Market_Order_Dev(ORDER_TYPE_SELL, Level_Sell, NULL , NULL,  currentSellVolume);
        }
    }
    if(CheckBuyManagemente_Evo())
    {
        
        if(Central_Top < Level_Buy)
        {
            //int r = Place_Market_Order_Dev(ORDER_TYPE_BUY, Level_Buy, NULL , NULL,  currentBuyVolume);
           int r = Place_Market_Order_Dev(ORDER_TYPE_BUY, Level_Buy, NULL , NULL,  currentBuyVolume);
        }

    }
    

    // Last_Level_Sell = Level_Sell;
    // Last_Level_Buy = Level_Buy;

    SetLastOrtderSettings();

    SO_Follow_8_TopDisplay();
    //MarketOrder_Drawings_Dev();
    MarketOrder_Buy_Drawings_Dev();
    MarketOrder_Sell_Drawings_Dev();
}


void SetOrderBuyLimit()
{
    if(CheckBuyManagemente_Evo())
    {
        if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0)
        {
            int r = Place_Order_Dev(EN_ORDER_TYPE_LONG, Level_Buy, NULL , NULL,  currentBuyVolume);
            placedOrderCheck(r, 1);
        }
    }
    Last_Level_Buy = Level_Buy;
    SO_Follow_8_TopDisplay();
}


void SetOrderSellLimit()
{
    if(CheckSellManagemente_Evo())
    {
        if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0) 
        {
            int r = Place_Order_Dev(EN_ORDER_TYPE_SHORT, Level_Sell, NULL , NULL,  currentSellVolume);
            placedOrderCheck(r, -1);
        }
    }
    Last_Level_Sell = Level_Sell;
    SO_Follow_8_TopDisplay();
}

void ModifyOrderBuyLimit()
{
    int r = UpdateOrderByType(EN_ORDER_TYPE_LONG, Level_Buy, currentBuyVolume);
    modifiedOrderCheck(r, 1);
    Last_Level_Buy = Level_Buy;
    SO_Follow_8_TopDisplay();
}
void ModifyOrderSellLimit()
{
    int r = UpdateOrderByType(EN_ORDER_TYPE_SHORT, Level_Sell, currentSellVolume);
    modifiedOrderCheck(r, -1);
    Last_Level_Sell = Level_Sell;
    SO_Follow_8_TopDisplay();
}


void Set_Order_Sell_Limit()
{
    if(CheckSellManagemente_Evo())
    {
        CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
        if(BREAK_MODE)
        {
            int r = Place_Order_Dev(ORDER_TYPE_SELL_STOP, Level_Sell, Level_sl_short , Level_tp_short,  currentSellVolume);

        }
        else
        {
            int r = Place_Order_Dev(EN_ORDER_TYPE_SHORT, Level_Sell, Level_sl_short , Level_tp_short,  currentSellVolume);
        }
        //placedOrderCheck(r, -1);
        
        FINAL_SHORT_VOLUME = currentSellVolume;
    }
}
void Set_Order_Buy_Limit()
{
    if(CheckBuyManagemente_Evo())
    {
        CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo");
        if(BREAK_MODE)
        {
            int r = Place_Order_Dev(ORDER_TYPE_BUY_STOP, Level_Buy, Level_sl_long , Level_tp_long,  currentBuyVolume);
        }
        else
        {
            int r = Place_Order_Dev(EN_ORDER_TYPE_LONG, Level_Buy, Level_sl_long , Level_tp_long,  currentBuyVolume);
        }

        
       // placedOrderCheck(r, 1);
        FINAL_LONG_VOLUME = currentBuyVolume;
    }
}

void Set_Order_Limit(int callFrom)
{    
  int place_sell = 0;
  int place_buy = 0;

  double currentPositionVolume;
  GetCurrentPositionVolume(currentPositionVolume);


  if(currentPositionVolume > SELECTED_MINIMUN_POSITION_VOLUME){
    if(Level_Sell != Last_Level_Sell && SELL_TREND_OK)
    {
      Set_Order_Sell_Limit();
      place_sell += 1;
    }
    else if(TotalSymbolOrderSell == 0 && place_sell == 0 && SELL_TREND_OK)
    {
      if(currentPositionVolume < SELECTED_LIMIT_POSITION_VOLUME)
      {
          Set_Order_Sell_Limit();
          place_sell += 2;
      }
      else
      {
          if(pos_status == 0)
          {
              Set_Order_Sell_Limit();
              place_sell += 3;
          }
      }
    }
  }

  //if(Level_Buy != Last_Level_Buy || Last_Buy_Vol != currentBuyVolume)
  if(Level_Buy != Last_Level_Buy && BUY_TREND_OK)
  {
    {
      Set_Order_Buy_Limit();
      place_buy += 1;
    }
  }
  else if(TotalSymbolOrderBuy == 0 && place_buy == 0 && BUY_TREND_OK)
  {
    if(currentPositionVolume < SELECTED_LIMIT_POSITION_VOLUME)
    {
      Set_Order_Buy_Limit();
      place_buy += 2;
    }
    else
    {
      if(pos_status == 1)
      {
        Set_Order_Buy_Limit();
        place_buy += 3;
      }
    }
  }   
  
  // Print("CurrentPositionSide :", CurrentPositionSide);
  // Print("place_sell :", place_sell);
  // Print("place_buy :", place_buy);
  // Print("TotalSymbolOrderSell :", TotalSymbolOrderSell); 
  // Print("TotalSymbolOrderBuy :", TotalSymbolOrderBuy); 

  SO_Follow_8_TopDisplay();
  //MarketOrder_Drawings_Dev();
  MarketOrder_Buy_Drawings_Dev();
  MarketOrder_Sell_Drawings_Dev();
  SetLastOrtderSettings();

  // if(Last_Level_Sell != Level_Sell)
  // {

  //     Print("Last_Level_Sell :", Last_Level_Sell);
  //     Print("Level_Sell :", Level_Sell);

  // }
  // if(Last_Level_Buy != Level_Buy)
  // {
  //     Print("Last_Level_Buy :", Last_Level_Buy);
  //     Print("Level_Buy :", Level_Buy); 
  // }
}
void SetLastOrtderSettings(){
  Last_Level_Sell = Level_Sell;
  Last_Level_Buy = Level_Buy;
  Last_Buy_Vol = currentBuyVolume;
  Last_Sell_Vol = currentSellVolume;
}

void Set_Place_Order_Dev()
{    
    if(ChangeLowestTop)
    {
        if(CheckSellManagemente_Evo())
        {
            if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
            {
                int r = Place_Order_Dev(EN_ORDER_TYPE_SHORT, Level_Sell, NULL , NULL,  currentSellVolume);
                placedOrderCheck(r, -1);
            }
            else 
            {
                if(Level_Sell != Last_Level_Sell)
                {
                    
                    CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
                    int r = Place_Order_Dev(EN_ORDER_TYPE_SHORT, Level_Sell, NULL , NULL,  currentSellVolume);
                    
                    //int r = UpdateOrderByType(EN_ORDER_TYPE_SHORT, Level_Sell, currentSellVolume);
                    modifiedOrderCheck(r, -1);
                }
            }
        }
    }

    if(ChangeHighest_Bottom)
    {
        if(CheckBuyManagemente_Evo())
        {

            
            if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0)// || CountOrdersForPairType(ORDER_TYPE_BUY_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
            {
                int r = Place_Order_Dev(EN_ORDER_TYPE_LONG, Level_Buy, NULL , NULL,  currentBuyVolume);
                placedOrderCheck(r, 1);
            }
            else
            {
                if(Level_Buy != Last_Level_Buy)
                {
                    CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo");   
                    int r = Place_Order_Dev(EN_ORDER_TYPE_LONG, Level_Buy, NULL , NULL,  currentBuyVolume);
                    //int r = UpdateOrderByType(EN_ORDER_TYPE_LONG, Level_Buy, currentBuyVolume);
                    modifiedOrderCheck(r, 1);
                }
            }
        }
    }

    // Last_Level_Sell = Level_Sell;
    // Last_Level_Buy = Level_Buy;
    // Last_Buy_Vol = currentBuyVolume;
    // Last_Sell_Vol = currentSellVolume;
    SetLastOrtderSettings();
    
    SO_Follow_8_TopDisplay();
    //MarketOrder_Drawings_Dev();
    MarketOrder_Buy_Drawings_Dev();
    MarketOrder_Sell_Drawings_Dev();

}
void Set_Place_Order_Dev_F()
{    
   // if(ChangeLowestTop)
    //{
        if(CheckSellManagemente_Evo())
        {
            if(CountOrdersForPairType(ORDER_TYPE_SELL_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_SELL_STOP) == 0) 
            {
                int r = Place_Order_Dev(ORDER_TYPE_SELL_STOP, Level_Sell, NULL , NULL,  currentSellVolume);
                placedOrderCheck(r, -1);
            }
            else 
            {
                if(Level_Sell != Last_Level_Sell)
                {
                    
                    CancelSellOrders(_Symbol, "CheckSellManagemente_Evo"); 
                    int r = Place_Order_Dev(ORDER_TYPE_SELL_STOP, Level_Sell, NULL , NULL,  currentSellVolume);
                    
                    //int r = UpdateOrderByType(EN_ORDER_TYPE_SHORT, Level_Sell, currentSellVolume);
                    modifiedOrderCheck(r, -1);
                }
            }
        }
    //}

   // if(ChangeHighest_Bottom)
   // {
        if(CheckBuyManagemente_Evo())
        {

            
            if(CountOrdersForPairType(ORDER_TYPE_BUY_LIMIT) == 0 && CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0)// || CountOrdersForPairType(ORDER_TYPE_BUY_STOP_LIMIT) == 0 || CountOrdersForPairType(ORDER_TYPE_BUY_STOP) == 0) 
            {
                int r = Place_Order_Dev(ORDER_TYPE_BUY_STOP, Level_Buy, NULL , NULL,  currentBuyVolume);
                placedOrderCheck(r, 1);
            }
            else
            {
                if(Level_Buy != Last_Level_Buy)
                {
                    CancelBuyOrders(_Symbol, "CheckBuyManagemente_Evo");   
                    int r = Place_Order_Dev(ORDER_TYPE_BUY_STOP, Level_Buy, NULL , NULL,  currentBuyVolume);
                    //int r = UpdateOrderByType(EN_ORDER_TYPE_LONG, Level_Buy, currentBuyVolume);
                    modifiedOrderCheck(r, 1);
                }
            }
        }
  //  }

    // Last_Level_Sell = Level_Sell;
    // Last_Level_Buy = Level_Buy;
    // Last_Buy_Vol = currentBuyVolume;
    // Last_Sell_Vol = currentSellVolume;
    SetLastOrtderSettings();
    
    SO_Follow_8_TopDisplay();
    //MarketOrder_Drawings_Dev();
    MarketOrder_Buy_Drawings_Dev();
    MarketOrder_Sell_Drawings_Dev();

}




void modifiedOrderCheck(int r, int side)
{
    if(r == 1 && side ==1)
    {
        Setted_Last_Level_Buy = Level_Buy;
        Deal_Last_Level = Deal_Current_Level;
        Deal_Current_Level = Level_Buy;
       // Print("modify buy - ok");
    }
    else
    {
      //  Print("modify buy - erro");
    }
    if(r == 1 && side == -1)
    {
        Setted_Last_Level_Sell = Level_Sell;
        Deal_Last_Level = Deal_Current_Level;
        Deal_Current_Level = Level_Sell;
       // Print("modify sell - ok");
    }
    else
    {
       // Print("modify sell - erro");
    }
}

void placedOrderCheck(int r, int side)
{
    if(r == 1 && side ==1)
    {
        Setted_Last_Level_Buy = Level_Buy;
        Deal_Last_Level = Deal_Current_Level;
        Deal_Current_Level = Level_Buy;
       // Print("modify buy - ok");
    }
    else
    {
       // Print("modify buy - erro");
    }
    if(r == 1 && side == -1)
    {
        Setted_Last_Level_Sell = Level_Sell;
        Deal_Last_Level = Deal_Current_Level;
        Deal_Current_Level = Level_Sell;
       // Print("modify sell - ok");
    }
    else
    {
       // Print("modify sell - erro");
    }
}



void SO_Follow_8_TopDisplay()
{
    SPD_LEVELS = (Level_Sell - Level_Buy);
    spd = NormalizeDouble(SPD_LEVELS,_Digits);
    double spd_buy = Last_Level_Buy - Level_Buy;
    double spd_sell = Last_Level_Sell - Level_Sell;


       
    Comment("TopChange ->  "+ TopChange,
    "\n SellVolChange ->  " + SellVolChange,
    "\n Level_Sell ->  " + Level_Sell,
    "\n ------------------------------------",
    "\n BottomChange ->  " + BottomChange,
    "\n BuyVolChange ->  " + BuyVolChange,
    "\n Level_Buy ->  " + Level_Buy,
    "\n SPD ->  " + spd,
    "\n madst ->  " + madst
    
    //"\n spd_buy ->  " + spd_buy,
    //"\n spd_sell ->  " + spd_sell
    //"\n top_ma_spread ->  " + top_ma_spread,
    //"\n bottom_ma_spread ->  " + bottom_ma_spread
    //"\n _DRAWDOWN ->  " + SYMBOL_DAILY_MAX_DRAWDOWN,
    //"\n LOWEST_LOW ->  " + SYMBOL_DAILY_LOWEST_LOW,//SYMBOL_DAILY_MAX_DRAWDOWN
    //"\n _MAX_RISE ->  " + SYMBOL_DAILY_MAX_RISE//SYMBOL_DAILY_MAX_DRAWDOWN
   // "\n CurrentTradingStatus ->  " + CurrentTradingStatus
    );

}
void SO_Follow_6_TopDisplay(double top_level, double bottom_level)
{

    SPD_LEVELS = (EN_SELL_MARKET_LEVEL - EN_BUY_MARKET_LEVEL);
    spd = (string)SPD_LEVELS;
    
       
    Comment("top_level ->  "+ top_level,
            "\n EN_SELL_MARKET_LEVEL ->  " + EN_SELL_MARKET_LEVEL,
            "\n ------------------------------------",
            "\n bottom_level ->  " + bottom_level,
            "\n EN_BUY_MARKET_LEVEL ->  " + EN_BUY_MARKET_LEVEL,
            "\n SPD ->  " + spd
            );

}