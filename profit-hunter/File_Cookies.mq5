//https://www.mql5.com/pt/docs/files
//https://www.mql5.com/pt/docs/constants/io_constants/fileflags
//https://www.mql5.com/pt/articles/2720
//https://github.com/PopovMP/FSB_MQL_Code/blob/master/MQL5/Export%20Data%20to%20CSV.mq5


string File_Cookie_Name = (string)login + "_" + GetTradeMode() + "_" + StringSubstr(name, 0, 3) + "_" + Symbol() + "_Params.txt";
//string File_Name_csv = (string)login + "_" + GetTradeMode() + "_" + StringSubstr(name, 0, 3) + "_" + Symbol() + "_Params.csv";


void File_Cookies_Create(int lines)
{

   //if(!(FileIsExist(File_Cookie_Name, FILE_COMMON)))
   if(!(FileIsExist(File_Cookie_Name)))
   {


   //int h=FileOpen("test.txt",FILE_WRITE|FILE_ANSI|FILE_TXT);
   int h=FileOpen(File_Cookie_Name,FILE_WRITE|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }
   
   for(int i=1;i<=10;i++){
      //FileWrite(h,"Line-"+IntegerToString(i));
      FileWrite(h,"");
   }
   

   FileClose(h);
   Alert("File %s created", File_Cookie_Name);
   }

}


void File_Cookies_ReadFileToAlert()
{
   int h=FileOpen(File_Cookie_Name,FILE_READ|FILE_ANSI|FILE_TXT);
   
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }   
   Alert("=== Start ===");   
   while(!FileIsEnding(h)){
      string str=FileReadString(h);
      Alert(str);   
   }
   FileClose(h);
}

string File_Cookies_Read_Value(int line)
{
   string response = "File_Error";
   int h=FileOpen(File_Cookie_Name,FILE_READ|FILE_ANSI|FILE_TXT);
   
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return response;
   }   

   int cnt=0;
   while(!FileIsEnding(h)){
      cnt++;
      string str=FileReadString(h);
      if(cnt==line){
         // substituir a linha
         response = str;
      }
   }
   FileClose(h);

   
   return response;
}


void File_Cookies_Change(int line, string value)
{
   int h=FileOpen(File_Cookie_Name,FILE_READ|FILE_ANSI|FILE_TXT);

   //string tmpName=TmpFileName("test","txt");
   string tmpName=TmpFileName(File_Cookie_Name,"txt");

   int tmph=FileOpen(tmpName,FILE_WRITE|FILE_ANSI|FILE_TXT);

   int cnt=0;
   while(!FileIsEnding(h)){
      cnt++;
      string str=FileReadString(h);
      if(cnt==line){
         // substituir a linha
         FileWrite(tmph,value);
      }
      else
      {
         // reescrever a linha sem alterações
         FileWrite(tmph,str);
      }
   }
   FileClose(tmph);
   FileClose(h);

   FileDelete(File_Cookie_Name);
   FileMove(tmpName,0,File_Cookie_Name,0);
}






/*
void Read_File()
{
   
   int h=FileOpen(File_Cookie_Name,FILE_READ|FILE_ANSI|FILE_TXT);
   //--- Abre o arquivo


   //O erro de abertura do arquivo é bastante comum. Se o arquivo já estiver aberto, ele não poderá ser aberto pela segunda vez. O arquivo pode ser aberto em alguns aplicativo de terceiros. Por exemplo, o arquivo pode ser aberto no Bloco de notas do Windows e no MQL5 simultaneamente. Mas se ele é aberto no Microsoft Excel, então ele pode ser aberto em qualquer outro lugar.  
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return; 
   }


   string str=FileReadString(h);
   Alert(str);

   FileClose(h);

}
*/