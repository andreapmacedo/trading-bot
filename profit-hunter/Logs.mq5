	
    
void GenericShow(string str)
{

    Comment(str);

}   


         /*
         
         Comment("HistoricLAST_BAR_SIZE[2]->  "+ HistoricLAST_BAR_SIZE[2],
                  "\n HistoricLAST_BAR_SIZE[1] ->  " + HistoricLAST_BAR_SIZE[1],
                  "\n HistoricLAST_BAR_SIZE[0] ->  " + HistoricLAST_BAR_SIZE[0], 
                  "\n AvgLAST_BAR_SIZE ->  " + AvgLAST_BAR_SIZE
                  );
         
         */

void NewBarLogRotine()
{


    
}



void MsgLog_OnInitLoad()
{


//--- Show all the information available from the function AccountInfoString()
   Print("The name of the broker = ",AccountInfoString(ACCOUNT_COMPANY));
   Print("Deposit currency = ",AccountInfoString(ACCOUNT_CURRENCY));
   Print("Client name = ",AccountInfoString(ACCOUNT_NAME));
   Print("The name of the trade server = ",AccountInfoString(ACCOUNT_SERVER));

}





		
		//if(hhmm == "23:h46" || hhmm == "04:57" ){}
		
		//string TimeInput = "2020.05.04"; //"yyyy.mm.dd", 
		//datetime dia = StringToTime(TimeInput);

		/*


		//end=TimeCurrent();
		Comment(" ----------------------------------------------------------------------------",
				"\n " + name,
				"  >  " + login + "  >  " + trade_mode,
				"\n ---------------------------------------------------------------------------",
				"\n Closed R$ " + MyRound(DYT_TOTAL_SYMBOL_DEAL_PROFIT),
				"  >  Opened R$ " + MyRound(CURRENT_DAY_TRADE_POSITION_PROFIT),
				"  >  Blc R$  " + MyRound(SYMBOL_DAILY_CURRENT_BALANCE),
				"\n ---------------------------------------------------------------------------",
				//"\n Buy        >   " + DYT_SYMBOL_TOTAL_DEAL_BUY,
				//"\n Sell         >   " + DYT_SYMBOL_TOTAL_DEAL_SELL,
				"\n " + DYT_STRING_STATUS + "   "  + DYT_TOTAL_SYMBOL_BALANCE,
				"\n " + pos_status_string + "   "  + PositionGetDouble(POSITION_VOLUME),
				//"\n IntradayBar   >   " + IntradayBar,
				"\n plc_SPREAD  > " + LAST_PLACED_FINAL_EN_ORDER_SPREAD,
				"\n stt_SPREAD  > " + LAST_SETTED_FINAL_EN_ORDER_SPREAD,
				
				//"  >  buy seq  >   " + DYT_SYMBOL_BUY_SEQUENCE,
				//"  >  sell seq    >   " + DYT_SYMBOL_SELL_SEQUENCE,
				//"\n LAST_PLACED_FINAL_EN_LONG_VALUE   >   " + LAST_PLACED_FINAL_EN_LONG_VALUE,
				//"\n LAST_PLACED_FINAL_EN_SHORT_VALUE   >   " + LAST_PLACED_FINAL_EN_SHORT_VALUE,
				//"\n Long O. Dist.   >   " + LongDist,
				//"\n Short O. Dist.   >   " + ShortDist,
				//"\n SO_FOLLOW_CURR_BOTTOM_LEVEL   >   " + SO_FOLLOW_CURR_BOTTOM_LEVEL,
				//"\n SO_FOLLOW_CURR_TOP_LEVEL   >   " + SO_FOLLOW_CURR_TOP_LEVEL,
				//"\n SO_FOLLOW_CURR_SPREAD_ORDERS   >   " + SO_FOLLOW_CURR_SPREAD_ORDERS,
				//"\n BREAK_MODE   >   " + BREAK_MODE
				//"\n DYT_TOTAL_SYMBOL_BALANCE   >   " + DYT_TOTAL_SYMBOL_BALANCE
				
				
				
				);
		*/