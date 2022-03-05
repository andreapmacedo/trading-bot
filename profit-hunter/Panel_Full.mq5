//https://www.mql5.com/pt/articles/4503#para2

/*
posição aberta (comprado / vendido / não)
volume da posição
comprando x
vendendo x
lucro aberto
lucro fechado


*/


string infos[10] = {//"Hora Servidor",
                   //"Cliente",
                   "Conta",
                   "-----------------------",
                   "R",
                   "------------------------",                   
                   "Posição",
                   "Cmpdo / Vndo",
                   //"RANGE_MID",
                   //"B sec / S sec"
                   "Trend/Stts",
                   "L-VPR",
                   "Ngc/Com",
                   "Bs/Ss"
                     };

int CreatePanel_Full()
{
   int delta_x = 10;
   int delta_y = 10;
   int x_size = 300;
   int line_size = 15;
   int y_size = line_size*ArraySize(infos)+10;
   //int y_size = 450;
   
   //--- Criar o painel
   
   // Background
   if(!ObjectCreate(0, "Background", OBJ_RECTANGLE_LABEL, 0, 0, 0))
      return(INIT_FAILED);
   
   ObjectSetInteger(0, "Background", OBJPROP_CORNER, CORNER_LEFT_LOWER);
   ObjectSetInteger(0, "Background", OBJPROP_XDISTANCE, delta_x);
   ObjectSetInteger(0, "Background", OBJPROP_YDISTANCE, y_size + delta_y);
   ObjectSetInteger(0, "Background", OBJPROP_XSIZE, x_size);
   ObjectSetInteger(0, "Background", OBJPROP_YSIZE, y_size);
   
   ObjectSetInteger(0, "Background", OBJPROP_BGCOLOR, clrBlack);
   ObjectSetInteger(0, "Background", OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(0, "Background", OBJPROP_BORDER_COLOR, clrLime);
   
   // Criar campos
   for(int i=0; i<ArraySize(infos); i++)
     {
      if(!ObjectCreate(0, infos[i], OBJ_LABEL, 0, 0, 0))
         return(INIT_FAILED);
         
      ObjectSetInteger(0, infos[i], OBJPROP_ANCHOR, ANCHOR_LEFT_UPPER);
      ObjectSetInteger(0, infos[i], OBJPROP_CORNER, CORNER_LEFT_LOWER);
      ObjectSetInteger(0, infos[i], OBJPROP_XDISTANCE, delta_x + 5);
      ObjectSetInteger(0, infos[i], OBJPROP_YDISTANCE, delta_y - 5 + y_size - i*line_size);
      
      ObjectSetInteger(0, infos[i], OBJPROP_COLOR, clrYellow);
      ObjectSetInteger(0, infos[i], OBJPROP_FONTSIZE, 9);
      ObjectSetString(0, infos[i], OBJPROP_TEXT, infos[i]);
     }
     
   // Iniciar valores
   for(int i=0; i<ArraySize(infos); i++)
     {
      string name = infos[i] + "Valor";
      if(!ObjectCreate(0, name, OBJ_LABEL, 0, 0, 0))
         return(INIT_FAILED);
         
      ObjectSetInteger(0, name, OBJPROP_ANCHOR, ANCHOR_RIGHT_UPPER);
      ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_LOWER);
      ObjectSetInteger(0, name, OBJPROP_XDISTANCE, delta_x + x_size - 5);
      ObjectSetInteger(0, name, OBJPROP_YDISTANCE, delta_y - 5 + y_size - i*line_size);
      
      ObjectSetInteger(0, name, OBJPROP_COLOR, clrAqua);
      ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 9);
      ObjectSetString(0, name, OBJPROP_TEXT, "-");
     }
   
   ChartRedraw();

	return 0;

}

void RemovePanel_Full()
{
   //--- Remover o painel do gráfico
   ObjectDelete(0, "Background");
   for(int i=0; i<ArraySize(infos); i++)
     ObjectDelete(0, infos[i]);
   for(int i=0; i<ArraySize(infos); i++)
     ObjectDelete(0, infos[i]+"Valor");
}

   double blc; 
   double saldo; 






void UpdatePanel_Full_Info()
{
    double temp_vol;
    GetCurrentPositionVolume(temp_vol);   
   
   if(BROKERAGE_TYPE == 1)
   {
      CORRETAGEM = MyRound2(Current_Historic_Vol * BROKERAGE);
   }else if(BROKERAGE_TYPE == 2)
   {
      CORRETAGEM = MyRound2(Full_Historic_Deals * BROKERAGE);
   }
   
   
   blc = MyRound2(Current_Historic_Deal_Profit + pos_profit);
   saldo =  MyRound2(blc - CORRETAGEM);

   //string str_01 = TimeToString(TimeCurrent(),TIME_MINUTES);
   //string str_02 = name;    
   string str_03 = " " + login + " (" + trade_mode + ")";    
   string str_04 = "------------------------";    
   string str_05 = MyRound3(Current_Historic_Deal_Profit);    
   string str_06 = MyRound3(pos_profit);    
   //string str_07 = MyRound(NormalizeDouble(DYT_TOTAL_SYMBOL_BALANCE,2));    
   string str_20 = CORRETAGEM;    
   string str_21 = (int)saldo;    
   string str_07 = (int)blc;    
   string str_07c = str_05 + " / " + str_06 + " / " + str_07 + /*" / " str_20 +*/ " / " + str_21;    
   string str_08 = "-----------------------";    
   string str_09 = pos_status_string;
   string str_10 = pos_volume;
   string str_10c = str_09 + ":  " + str_10;    
   string str_11 = FINAL_LONG_VOLUME;//FINAL_LONG_VOLUME;    
   string str_12 = FINAL_SHORT_VOLUME;//FINAL_SHORT_VOLUME;    
   //string str_11 = GetCountVolByOrders_BuyType();    
   //string str_12 = GetCountVolByOrders_SellType();    
   string str_12c = str_11 + " / " + str_12;    
//   string str_13 = MyRound(LAST_PLACED_FINAL_EN_ORDER_SPREAD);    
 //  string str_14 = MyRound(LAST_SETTED_FINAL_EN_ORDER_SPREAD);    
 //  string str_14c = str_13 + " / " + str_14;    
//   string str_13 = DYT_SYMBOL_BUY_SEQUENCE;    
  // string str_14 = DYT_SYMBOL_SELL_SEQUENCE;    
   string str_13 = CurrentTrend;//gravit_status;    
   string str_14 = CurrentTradingStatus;//TREND;        
   string str_14a = CurrentStatusSystem;//CurrentStatusSystem;        
   string str_14c = str_13 + " / " + str_14 + " / " + str_14a;    
   string str_15 = LAST_DEAL_VOLUME;    
   string str_16 = LAST_DEAL_PRICE;    
   string str_17 = LAST_DEAL_RESULT;    
   string str_18 = LAST_DEAL_TYPE_STATUS;    
   string str_18c = str_18 + ":  " + str_15 + " / " + str_16 + " / " + str_17;    
   string str_19 = Current_Historic_Vol;//SWT_TOTAL_SYMBOL_DEAL_COUNT_VOL;    //DYT_TOTAL_SYMBOL_DEAL_COUNT_VOL;    
   
   string str_21c = str_19 + " / " + str_20;    
   //string str_14c = DYT_SYMBOL_LAST_DEAL_TYPE; // ultimo negócio   
   string str_22 = Current_Buy_Seq;// DYT_SYMBOL_BUY_SEQUENCE;    
   string str_23 = Current_Sell_Seq;// DYT_SYMBOL_SELL_SEQUENCE;    
   string str_23c = str_22 + " / " + str_23;    
    
    
    
    //ObjectSetString(0, infos[0] + "Valor", OBJPROP_TEXT, str_01);
    //ObjectSetString(0, infos[1] + "Valor", OBJPROP_TEXT, str_02);
    ObjectSetString(0, infos[0] + "Valor", OBJPROP_TEXT, str_03);
    ObjectSetString(0, infos[1] + "Valor", OBJPROP_TEXT, str_04);
    ObjectSetString(0, infos[2] + "Valor", OBJPROP_TEXT, str_07c);
    
    ObjectSetString(0, infos[3] + "Valor", OBJPROP_TEXT, str_08);
    ObjectSetString(0, infos[4] + "Valor", OBJPROP_TEXT, str_10c);
    ObjectSetString(0, infos[5] + "Valor", OBJPROP_TEXT, str_12c);
    
    ObjectSetString(0, infos[6] + "Valor", OBJPROP_TEXT, str_14c);
    ObjectSetString(0, infos[7] + "Valor", OBJPROP_TEXT, str_18c);
    ObjectSetString(0, infos[8] + "Valor", OBJPROP_TEXT, str_21c);
    ObjectSetString(0, infos[9] + "Valor", OBJPROP_TEXT, str_23c);
    //ObjectSetString(0, infos[8] + "Valor", OBJPROP_TEXT, str_22);
    

}