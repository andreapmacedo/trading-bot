

bool filter_conditions = false;


//-- opcional
bool intraday_blc_management = false;



int TimeFilterFail()
{
	if(DAY_TRADE_MODE)
	{
		CloseAllThisSymbolPosition();
		CancelAllThisSymbolOrders();
		//Print("TimeFilterFail");
		return 1;
	}
	if(TIME_FILTER)
	{
		CancelAllThisSymbolOrders();
		return 2;
	}
	return 0;
}

input bool SUNDAY_ON = true; //Domingo
input bool MONDAY_ON = true; //Segunda
input bool TUESDAY_ON = true; //Terça
input bool WEDNESDAY_ON = true; //Quarta
input bool THURSDAY_ON = true; //Quinta
input bool FRIDAY_ON = true; //Sexta
input bool SATURDAY_ON = true; //Sábado


void CheckDayForTrading()
{
	MqlDateTime STime;
   
	//int day = DayOfWeek(STime.day_of_week);
	int day = DayOfWeek();

   	switch(day)
	{
      case 0: 
		if(!SUNDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 1: 
		if(!MONDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 2: 
		if(!TUESDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 3: 
		if(!WEDNESDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 4: 
		if(!THURSDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 5: 
		if(!FRIDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
      case 6: 
		if(!SATURDAY_ON)
			SetTradingConditionOff("dia da semana bloqueado! -> ");
     	break;
	}

}

void SetTradingConditionOff(string str)
{
	LONG_CONDITIONS = false;
	SHORT_CONDITIONS = false;

	Print(str);
}


void CheckPositionVolume()
{
	int position = MyGetPosition();		

	//--- Verificando o limite do usuário
	//--- Não permite que o sistema atribua um valor acima do definido pelo usuário
	if(SELECTED_LIMIT_ORDER_VOLUME > LIMIT_ORDER_VOLUME)
	{
		SELECTED_LIMIT_ORDER_VOLUME = LIMIT_ORDER_VOLUME;
		FINAL_LIMIT_ORDER_VOLUME = SELECTED_LIMIT_ORDER_VOLUME;
		//Print("Limite de volume de ordem imposto pelo usuário prevalece");
	}

	//--- Não permite que o sistema atribua um valor acima do definido pelo usuário
	if(SELECTED_LIMIT_POSITION_VOLUME > LIMIT_POSITION_VOLUME)
	{
		SELECTED_LIMIT_POSITION_VOLUME = LIMIT_POSITION_VOLUME;
		FINAL_LIMIT_POSITION_VOLUME = SELECTED_LIMIT_POSITION_VOLUME;
		//Print("Limite de volume imposto pelo usuário prevalece");
	}

	//--- Verificando o limite do comercial
	if(BUSINESS_PLAN)
	{
		if(SELECTED_LIMIT_ORDER_VOLUME > PERSONA_LOCK_LIMIT_ORDER_VOLUME)
		{
			SELECTED_LIMIT_ORDER_VOLUME = PERSONA_LOCK_LIMIT_ORDER_VOLUME;
			FINAL_LIMIT_ORDER_VOLUME = SELECTED_LIMIT_ORDER_VOLUME;
		}

		if(SELECTED_LIMIT_POSITION_VOLUME > PERSONA_LOCK_LIMIT_POSITION_VOLUME)
		{
			SELECTED_LIMIT_POSITION_VOLUME = PERSONA_LOCK_LIMIT_POSITION_VOLUME;
			FINAL_LIMIT_POSITION_VOLUME = SELECTED_LIMIT_POSITION_VOLUME;
		}
	}


	if(FINAL_LONG_VOLUME > LIMIT_ORDER_VOLUME)
	{
		FINAL_LONG_VOLUME = LIMIT_ORDER_VOLUME;
		//Print("Limite de volume de ordem imposto pelo usuário prevalece");
	}
	if(FINAL_SHORT_VOLUME > LIMIT_ORDER_VOLUME)
	{
		FINAL_SHORT_VOLUME = LIMIT_ORDER_VOLUME;
		//Print("Limite de volume de ordem imposto pelo usuário prevalece");
	}

	

	//--- Apenas verifica se o volume já está estourado 
	if (PositionGetDouble(POSITION_VOLUME) >= SELECTED_LIMIT_POSITION_VOLUME)
	{
		if(position == 1)
		{
			LONG_CONDITIONS = false;
		}
		else if(position == (-1))
		{
			SHORT_CONDITIONS = false;
		}
		else
		{
			Print("Máximo volume atingigo");
		}
	}
	


	if(pos_status == 1)
	{	
		
		if ((PositionGetDouble(POSITION_VOLUME) + FINAL_LONG_VOLUME) > SELECTED_LIMIT_POSITION_VOLUME)
		{
			if((SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
			FINAL_LONG_VOLUME = SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME);
			//LONG_CONDITIONS = false;
		}
		else if ((FINAL_SHORT_VOLUME - PositionGetDouble(POSITION_VOLUME)) > SELECTED_LIMIT_POSITION_VOLUME)
		{			
			////FINAL_SHORT_VOLUME =  PositionGetDouble(POSITION_VOLUME) + SELECTED_LIMIT_POSITION_VOLUME;
			////SHORT_CONDITIONS = false;
		}	
		
	}		
	else if(pos_status == (-1))
	{
		
		if ((PositionGetDouble(POSITION_VOLUME) + FINAL_SHORT_VOLUME) > (SELECTED_LIMIT_POSITION_VOLUME))
		{
			if((SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
				FINAL_SHORT_VOLUME = SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME);
			//SHORT_CONDITIONS = false;
		}
		else if ((FINAL_LONG_VOLUME - PositionGetDouble(POSITION_VOLUME)) > SELECTED_LIMIT_POSITION_VOLUME)
		{			
			////FINAL_LONG_VOLUME =  PositionGetDouble(POSITION_VOLUME) + SELECTED_LIMIT_POSITION_VOLUME;
			////LONG_CONDITIONS = false;
		}
	}
	else
	{
		if ((PositionGetDouble(POSITION_VOLUME) + FINAL_SHORT_VOLUME) > (SELECTED_LIMIT_POSITION_VOLUME))
		{
			if((SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
			FINAL_SHORT_VOLUME = SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME);
			//SHORT_CONDITIONS = false;
		}

		if ((PositionGetDouble(POSITION_VOLUME) + FINAL_LONG_VOLUME) > (SELECTED_LIMIT_POSITION_VOLUME))
		{
			if((SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
			FINAL_LONG_VOLUME = SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME);
			//LONG_CONDITIONS = false;
		}
	}
}

void Check_Position_EN_First()
{
	if(SELECTED_BUY_FIRST)
	{
		if(MyGetPosition() != 1)
		{
			SHORT_CONDITIONS = false;
		}
	}
	if(SELECTED_SELL_FIRST)
	{
		if(MyGetPosition() != -1)
		{
			LONG_CONDITIONS = false;
		}
	}

}

void Check_DYT_EN_First()
{
	if(SELECTED_BUY_FIRST)
	{
		if(DYT_POSITION_STATUS != 1)
		{
			SHORT_CONDITIONS = false;
		}
	}
	if(SELECTED_SELL_FIRST)
	{
		if(DYT_POSITION_STATUS != -1)
		{
			LONG_CONDITIONS = false;
		}
	}

}
	//LAST_PLACED_FINAL_EN_ORDER_SPREAD

double fator_spread_limit = 0.1;
void Check_Spread()
{
	if(FINAL_EN_LONG_VALUE < (LAST_PLACED_FINAL_EN_LONG_VALUE - (LAST_PLACED_FINAL_EN_LONG_VALUE * fator_spread_limit))
	 || FINAL_EN_LONG_VALUE > (LAST_PLACED_FINAL_EN_LONG_VALUE + (LAST_PLACED_FINAL_EN_LONG_VALUE * fator_spread_limit)))
	{
		LONG_CONDITIONS = false;
	}
	if(FINAL_EN_SHORT_VALUE > (LAST_PLACED_FINAL_EN_SHORT_VALUE - (LAST_PLACED_FINAL_EN_SHORT_VALUE * fator_spread_limit))
	 || FINAL_EN_SHORT_VALUE < ((LAST_PLACED_FINAL_EN_SHORT_VALUE - LAST_PLACED_FINAL_EN_SHORT_VALUE * fator_spread_limit)))
	{
		SHORT_CONDITIONS = false;
	}
}


void CheckPositionOrdersDistance2()
{

	if(MIN_ADD_DISTANCE > 0)
	{
		if(DYT_SYMBOL_BUY_SEQUENCE > 0)
		{
            FINAL_EN_LONG_VALUE  = MIN_ADD_DISTANCE;
        }
        else if(DYT_SYMBOL_SELL_SEQUENCE > 0)   
        {
            FINAL_EN_SHORT_VALUE  =  MIN_ADD_DISTANCE;
        }
	}

}
void CheckPositionOrdersDistance()
{
	if(MIN_ADD_DISTANCE > 0)
	{

		double Check_EN_Long_Distance = 0;
		double Check_EN_Short_Distance = 0;


		Check_EN_Long_Distance = DYT_SYMBOL_LAST_BUY - MIN_ADD_DISTANCE;
		Check_EN_Short_Distance = DYT_SYMBOL_LAST_SELL + MIN_ADD_DISTANCE;
		
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 0 && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{
			if(FINAL_EN_LONG_VALUE > Check_EN_Long_Distance && DYT_SYMBOL_LAST_BUY > 0)
			{
				FINAL_EN_LONG_VALUE = Check_EN_Long_Distance;
			}	
		}
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 1  && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{
			if(FINAL_EN_SHORT_VALUE < Check_EN_Short_Distance && DYT_SYMBOL_LAST_SELL > 0)
			{
				FINAL_EN_SHORT_VALUE = Check_EN_Short_Distance;
			}			
		}
	}
	
}
void SetAddChange(double &top, double &bottom)
{
	if(MIN_ADD_DISTANCE > 0)
	{

		double Check_EN_Long_Distance = 0;
		double Check_EN_Short_Distance = 0;


		Check_EN_Long_Distance = DYT_SYMBOL_LAST_BUY - MIN_ADD_DISTANCE - min_add_buy_modify;
		Check_EN_Short_Distance = DYT_SYMBOL_LAST_SELL + MIN_ADD_DISTANCE + min_add_sell_modify;
		
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 0 && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{
			if(bottom > Check_EN_Long_Distance && DYT_SYMBOL_LAST_BUY > 0)
			{
				bottom = Check_EN_Long_Distance;
			}	
		}
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 1  && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{
			if(top < Check_EN_Short_Distance && DYT_SYMBOL_LAST_SELL > 0)
			{
				top = Check_EN_Short_Distance;
			}			
		}
	}
}
void SetAddChange_Evo()
{

	double Check_EN_Long_Distance = 0;
	double Check_EN_Short_Distance = 0;


	// Check_EN_Long_Distance = Freeze_Central_Bottom - SELECTED_MIN_ADD_DISTANCE;
	// Check_EN_Short_Distance = Freeze_Central_Top + SELECTED_MIN_ADD_DISTANCE;
	Check_EN_Long_Distance = Freeze_Central_Bottom - SELECTED_MIN_ADD_DISTANCE - min_add_buy_modify;
	Check_EN_Short_Distance = Freeze_Central_Top + SELECTED_MIN_ADD_DISTANCE + min_add_sell_modify;


	int last_deal_ref;
	if(DAY_TRADE_MODE)
	{
		last_deal_ref = DYT_SYMBOL_LAST_DEAL_TYPE;
	}
	else
	{
		last_deal_ref = SWT_SYMBOL_LAST_DEAL_TYPE;
	}

	
	if(last_deal_ref == 0/* && (SELECTED_LIMIT_POSITION_VOLUME - pos_volume) > 0*/)
	{
		Print("Add Level_Buy before = ", Level_Buy);
		if(Level_Buy > Check_EN_Long_Distance /*&& DYT_SYMBOL_LAST_BUY > 0*/)
		{
			Level_Buy = Check_EN_Long_Distance;
			Print("Add Level_Buy changed = ", Level_Buy);
		}	
	}

	if(last_deal_ref == 1/*  && (SELECTED_LIMIT_POSITION_VOLUME - pos_volume) > 0*/)
	{
		Print("Add Level_Sell before = ", Level_Sell);
		if(Level_Sell < Check_EN_Short_Distance /*&& DYT_SYMBOL_LAST_SELL > 0*/)
		{
			Level_Sell = Check_EN_Short_Distance;
			Print("Add Level_Sell changed = ", Level_Sell);
		}			
	}
	
}
void SetAddChange_Evo_CPRICE()
{

	double Check_EN_Long_Distance = 0;
	double Check_EN_Short_Distance = 0;


	Check_EN_Short_Distance = pos_cprice + SELECTED_MIN_ADD_DISTANCE ;
	Check_EN_Long_Distance = pos_cprice - SELECTED_MIN_ADD_DISTANCE;


	int last_deal_ref;
	if(DAY_TRADE_MODE)
	{
		last_deal_ref = DYT_SYMBOL_LAST_DEAL_TYPE;
	}
	else
	{
		last_deal_ref = SWT_SYMBOL_LAST_DEAL_TYPE;
	}

	
	if(last_deal_ref == 0/* && (SELECTED_LIMIT_POSITION_VOLUME - pos_volume) > 0*/)
	{
		Print("Add Level_Buy before = ", Level_Buy);
		if(Level_Buy > Check_EN_Long_Distance /*&& DYT_SYMBOL_LAST_BUY > 0*/)
		{
			Level_Buy = Check_EN_Long_Distance;
			Print("Add Level_Buy changed = ", Level_Buy);
		}	
	}

	if(last_deal_ref == 1/*  && (SELECTED_LIMIT_POSITION_VOLUME - pos_volume) > 0*/)
	{
		Print("Add Level_Sell before = ", Level_Sell);
		if(Level_Sell < Check_EN_Short_Distance /*&& DYT_SYMBOL_LAST_SELL > 0*/)
		{
			Level_Sell = Check_EN_Short_Distance;
			Print("Add Level_Sell changed = ", Level_Sell);
		}			
	}
	
}

void SetRdcChange_Evo()
{
	double Check_EN_Long_Distance = 0;
	double Check_EN_Short_Distance = 0;


	// Check_EN_Long_Distance = Freeze_Central_Top - SELECTED_MIN_REDUCE_DISTANCE;
	// Check_EN_Short_Distance = Freeze_Central_Bottom + SELECTED_MIN_REDUCE_DISTANCE;
	Check_EN_Long_Distance = Freeze_Central_Top - MIN_REDUCE_DISTANCE - min_reduce_buy_modify;
	Check_EN_Short_Distance = Freeze_Central_Bottom + MIN_REDUCE_DISTANCE + min_reduce_sell_modify;


	int last_deal_ref;
	if(DAY_TRADE_MODE)
	{
		last_deal_ref = DYT_SYMBOL_LAST_DEAL_TYPE;
	}
	else
	{
		last_deal_ref = SWT_SYMBOL_LAST_DEAL_TYPE;
	}

	
	if(last_deal_ref == 0 /*&& (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0*/)
	{

			//comprei a proxima venda tem que ser x acima da ultima compra
		Print("Rdc Level_Sell before = ", Level_Sell);
		if(Level_Sell < Check_EN_Short_Distance && DYT_SYMBOL_LAST_BUY > 0)
		{
			Level_Sell = Check_EN_Short_Distance;
			Print("Rdc Level_Sell changed = ", Level_Sell);
		}	
	}
	if(last_deal_ref == 1  /*&& (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0*/)
	{
		Print("Rdc Level_Buy before = ", Level_Buy);
		if(Level_Buy > Check_EN_Long_Distance /*&& DYT_SYMBOL_LAST_SELL > 0*/)
		{
			Level_Buy = Check_EN_Long_Distance;
			Print("Rdc Level_Buy changed = ", Level_Buy);
		}			
	}
}
void SetRdcChange_Evo_CPRICE()
{
	double Check_EN_Long_Distance = 0;
	double Check_EN_Short_Distance = 0;


	Check_EN_Long_Distance = pos_price - SELECTED_MIN_REDUCE_DISTANCE;
	Check_EN_Short_Distance = pos_price + SELECTED_MIN_REDUCE_DISTANCE;
	// Check_EN_Long_Distance = Freeze_Central_Top - MIN_REDUCE_DISTANCE - min_reduce_buy_modify;
	// Check_EN_Short_Distance = Freeze_Central_Bottom + MIN_REDUCE_DISTANCE + min_reduce_sell_modify;
	Print("pos_cprice = ", pos_cprice);
	Print("pos_cprice = ", pos_price);
	Print("SELECTED_MIN_REDUCE_DISTANCE = ", SELECTED_MIN_REDUCE_DISTANCE);
	Print("Check_EN_Long_Distance = ", Check_EN_Long_Distance);
	Print("Check_EN_Short_Distance = ", Check_EN_Short_Distance);
	

	int last_deal_ref;
	// if(DAY_TRADE_MODE)
	// {
	// }
	// else
	// {
	// 	last_deal_ref = SWT_SYMBOL_LAST_DEAL_TYPE;
	// }
		last_deal_ref = DYT_SYMBOL_LAST_DEAL_TYPE;

	
	//if(last_deal_ref == 0 )
	if(last_deal_ref == 0 )
	//if(pos_status == 0)
	{

			//comprei a proxima venda tem que ser x acima da ultima compra
		Print("Rdc Level_Sell before = ", Level_Sell);
		if(Level_Sell < Check_EN_Short_Distance && DYT_SYMBOL_LAST_BUY > 0)
		{
			Level_Sell = Check_EN_Short_Distance;
			Print("Rdc Level_Sell changed = ", Level_Sell);
		}	
	}
	if(last_deal_ref == 1)
	//if(pos_status == 1)
	{
		Print("Rdc Level_Buy before = ", Level_Buy);
		if(Level_Buy > Check_EN_Long_Distance /*&& DYT_SYMBOL_LAST_SELL > 0*/)
		{
			Level_Buy = Check_EN_Long_Distance;
			Print("Rdc Level_Buy changed = ", Level_Buy);
		}			
	}
}


void SetRdcChange(double &top, double &bottom)
{
	if(MIN_REDUCE_DISTANCE > 0)
	{

		double Check_EN_Long_Distance = 0;
		double Check_EN_Short_Distance = 0;


		Check_EN_Long_Distance = DYT_SYMBOL_LAST_SELL - MIN_REDUCE_DISTANCE - min_reduce_buy_modify;
		Check_EN_Short_Distance = DYT_SYMBOL_LAST_BUY + MIN_REDUCE_DISTANCE + min_reduce_sell_modify;
		
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 0 && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{

				//comprei a proxima venda tem que ser x acima da ultima compra

			if(top < Check_EN_Short_Distance && DYT_SYMBOL_LAST_BUY > 0)
			{
				top = Check_EN_Short_Distance;
			}	
		}
		if(DYT_SYMBOL_LAST_DEAL_TYPE == 1  && (SELECTED_LIMIT_POSITION_VOLUME - PositionGetDouble(POSITION_VOLUME)) > 0)
		{
			if(bottom > Check_EN_Long_Distance && DYT_SYMBOL_LAST_SELL > 0)
			{
				bottom = Check_EN_Long_Distance;
			}			
		}
	}
}



input int BROKERAGE_TYPE = 1; // Corretagem - Volume = 1 / Execução = 2 (Nº)


input double BROKERAGE = 0.25; //Corretagem - (Valor)


datetime last_tm_dt;
bool ExtremeMode_ON = true;
input int ExtremeModeLimitCalls = 10; // Máximo Ticks por Segundo - (Valor)
input int oderPerSec = 10; // Máximo Envios por Segundo - (Valor)

int countListening = 0;
input double Seconds = 0; // f+ HZ - (s)
input long Sleep = 0; // Latência - (ms)
input int HistoricDays = 7; // Período do Histórico - (Dias)

int countOrdersSend = 0;
int countOrdersCancel = 0;
int countOrdersDeals = 0;

int countDayOrdersSend = 0;
int countDayOrdersCancel = 0;
int countDayOrdersDeals = 0;

int maxCountDayDeal = 0;
//int AvgCountDayOrdersDeals = 0;
// contar os milisegundos das distâncias entre as ordens
// contar a slipagge

void CheckOrderSend(datetime time)
{

	if(ExtremeMode_ON)
	{            
		if(countListening < ExtremeModeLimitCalls || time > (last_tm_dt + Seconds) || countOrdersDeals <= oderPerSec)
        {    
            if(time > (last_tm_dt + Seconds))
            {

				countOrdersSend = 0;
				countOrdersCancel = 0;
				countOrdersDeals = 0;

                countListening = 0;
                last_tm_dt = time;
            }
            else
            {
                countListening += 1;

				if(countOrdersDeals > maxCountDayDeal)
				{
					maxCountDayDeal = countOrdersDeals;
				}
				// Print("countOrdersSend -> ", countOrdersSend);
				// Print("countOrdersCancel -> ", countOrdersCancel);
				// Print("countOrdersDeals -> ", countOrdersDeals);
				// Print("maxCountDayDeal -> ", maxCountDayDeal);
				
            }       
			Set_SO(2);
    }
	}


    // caso o modo de envio por limites de ordem por segundo seja atingido, será utilizado o envio de ordens por segundo.
    // Seconds = 0 para que seja enviado uma ordem por segundo.  
	else if(time > (last_tm_dt + Seconds) )
	{

		if(countOrdersDeals > maxCountDayDeal)
		{
			maxCountDayDeal = countOrdersDeals;
		}		
		countOrdersSend = 0;
		countOrdersCancel = 0;
		countOrdersDeals = 0;


		Set_SO(2);
		last_tm_dt = time;
	}
}


// void CheckOrderSend(datetime time)
// {
// 	if(ExtremeMode_ON)
// 	{            
// 		if(countListening < ExtremeModeLimitCalls || time > (last_tm_dt + Seconds) )
//         {    
//             if(time > (last_tm_dt + Seconds) )
//             {
//                 countListening = 0;
//                 last_tm_dt = time;
//                // Print("time > last_tm_dt  - countListening ->  ", countListening);
//             }
//             else
//             {
//                 countListening += 1;
//             }       
// 			Set_SO(2);
//            // Print("countListening < ExtremeModeLimitCalls ->  ", countListening);
//         }
// 	}


//     // caso o modo de envio por limites de ordem por segundo seja atingido, será utilizado o envio de ordens por segundo.
//     // Seconds = 0 para que seja enviado uma ordem por segundo.  
// 	else if(time > (last_tm_dt + Seconds) )
// 	{
// 		Set_SO(2);
// 		last_tm_dt = time;
//         //Print("ExtremeMode_off - last_tm_dt ->  ", last_tm_dt);
// 	}
// }


//+------------------------------------------------------------------+
// max loss
//+------------------------------------------------------------------+
// fazer um algo para o trade e outro para o período



//+------------------------------------------------------------------+
// max gain
//+------------------------------------------------------------------+
// lucro máximo por período


//input bool MAX_LOSS_FILTER = false;
//input bool MAX_GAIN_FILTER = false;

void Financial_Limit_Target()
{
	// Implementar o modo day trade e position

	Print("Financial_Limit_Target");

		CloseAllThisSymbolPosition();
		CancelAllThisSymbolOrders();
	/*
	if(DAY_TRADE_MODE)
	{
		CloseAllThisSymbolPosition();
		CancelAllThisSymbolOrders();
	}
	*/
}


bool Trade_Balance_Management()
{
	
	if(SELECTED_LIMIT_LOSS_DAY != 0)
	{
		//Print("SELECTED_LIMIT_LOSS_DAY != 0");
		if (saldo < (SELECTED_LIMIT_LOSS_DAY*(-1))) 
		{	
			DAY_TRADE_FILTER_OK = false;
		//	Print("SELECTED_LIMIT_LOSS_DAY");
			Financial_Limit_Target();
			return true;
		}
	}
	if(SELECTED_LIMIT_PROFIT_DAY != 0)
	{	
		if (saldo > SELECTED_LIMIT_PROFIT_DAY ) 
		{	
			DAY_TRADE_FILTER_OK = false;
		//	Print("SELECTED_LIMIT_PROFIT_DAY");
			Financial_Limit_Target();
			return true;	
		}
	}
	//Print("retornei true");
	return false;
} 


//+------------------------------------------------------------------+
// max profit
//+------------------------------------------------------------------+
// lucro máximo por trade





//+------------------------------------------------------------------+
// trade zone
//+------------------------------------------------------------------+




// acima da média

// entre um range (manual ou dinâmico)
// PONTOS DO PREÇO MEDIO
//PONTOS DA ENTRADA
// ()