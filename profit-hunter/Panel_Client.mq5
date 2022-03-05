


string infos[3] = {"Cliente",
                   "Login",
                   "Negociação"/*
                   "último valor compra",
                   "último valor venda",
                   "último volume compra",
                   "último volume venda"*/
                     };

int CreatePanel_Client()
{

   int delta_x = 10;
   int delta_y = 10;
   int x_size = 250;
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
   
   ObjectSetInteger(0, "Background", OBJPROP_BGCOLOR, clrIndigo);
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

void RemovePanel_CLient()
{

   //--- Remover o painel do gráfico
   ObjectDelete(0, "Background");
   for(int i=0; i<ArraySize(infos); i++)
     ObjectDelete(0, infos[i]);
   for(int i=0; i<ArraySize(infos); i++)
     ObjectDelete(0, infos[i]+"Valor");
}

void UpdatePanel_01_Info()
{
   ObjectSetString(0, infos[0] + "Valor", OBJPROP_TEXT, name);
   ObjectSetString(0, infos[1] + "Valor", OBJPROP_TEXT, login);
   ObjectSetString(0, infos[2] + "Valor", OBJPROP_TEXT, trade_mode);
   
    /*
   ObjectSetString(0, infos[3] + "Valor", OBJPROP_TEXT, LAST_PLACED_FINAL_EN_LONG_VALUE);
   ObjectSetString(0, infos[4] + "Valor", OBJPROP_TEXT, LAST_PLACED_FINAL_EN_SHORT_VALUE);
   ObjectSetString(0, infos[5] + "Valor", OBJPROP_TEXT, LAST_PLACED_FINAL_EN_LONG_VOLUME);
   ObjectSetString(0, infos[6] + "Valor", OBJPROP_TEXT, LAST_PLACED_FINAL_EN_SHORT_VOLUME);
    */

}