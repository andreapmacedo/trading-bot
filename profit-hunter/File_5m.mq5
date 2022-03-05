//https://www.mql5.com/pt/docs/files
//https://www.mql5.com/pt/docs/constants/io_constants/fileflags
//https://www.mql5.com/pt/articles/2720
//https://github.com/PopovMP/FSB_MQL_Code/blob/master/MQL5/Export%20Data%20to%20CSV.mq5



//string File_Name_Result_day = Symbol()+"_Resume_Day.csv";


string File_Name_Result_day = (string)login + " " + GetTradeMode() + " " + StringSubstr(name, 0, 3) + " " + Symbol() + " - Resume Daily.csv";


void File_Create_Resume_Day()
{
    //https://www.mql5.com/en/forum/152831      
   int handle = FileOpen(File_Name_Result_day,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);
   
    if(handle>0)
    {
    //write file header
    FileSeek(handle,0,SEEK_SET);
    FileWrite(handle,
            "Symbol",
            "Ano",
            "Mes",
            "Dia",
            "Dia da Semana",
            "Negócios",
            "Entradas",
            "SL/TP",
            "SL",
            "TP",
            "Reversão",
            "Fechemento pela posição oposta",
            "Loss máximo",
            "Profit máximo",
            "Resultado"
            );
    /* for(int i = 1;i<10;i++)
    { 
    
    FileWrite(handle,Symbol(),1,i+1,i+2,i+3);
    }*/
    }
    FileClose(handle);

} // end function File_Create_Resume_Day()

void File_Write_Resume_Day(//string date,
                           string date_year,
                           string date_month,
                           string date_day,
                           string day_of_week,
                           int deals_day,
                           int deals_in,
                           int deals_out,
                           int deals_sl,
                           int deals_tp,
                           int deals_inout,
                           int deals_outby,
                           double deals_max_realized_loss_day,
                           double deals_max_realized_profit_day,
                           double day_result
                           )
{
   int handle = FileOpen(File_Name_Result_day,FILE_READ|FILE_WRITE|FILE_CSV|FILE_COMMON,';',CP_ACP);
   if(handle==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }
   FileSeek(handle,0,SEEK_END);
   FileWrite(handle,
         Symbol(),
         //date,
         date_year,
         date_month,
         date_day,
         day_of_week,
         deals_day,
         deals_in,
         deals_out,
         deals_sl,
         deals_tp,
         deals_inout,
         deals_outby,
         deals_max_realized_loss_day,
         deals_max_realized_profit_day,
         day_result
         );


   FileClose(handle);
   //Alert("Added to file");
} // end function (File_Write_Resume_Day)
