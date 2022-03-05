//https://www.mql5.com/pt/docs/files
//https://www.mql5.com/pt/docs/constants/io_constants/fileflags
//https://www.mql5.com/pt/articles/2720
//https://github.com/PopovMP/FSB_MQL_Code/blob/master/MQL5/Export%20Data%20to%20CSV.mq5


string File_Name_txt = (string)login + "_" + GetTradeMode() + "_" + StringSubstr(name, 0, 3) + "_" + Symbol() + "_Params.txt";



//string File_Name_csv = (string)login + "_" + GetTradeMode() + "_" + StringSubstr(name, 0, 3) + "_" + Symbol() + "_Params.csv";


void Create_File_Statistics(int lines)
{

   //if(!(FileIsExist(File_Name_txt, FILE_COMMON)))
   if(!(FileIsExist(File_Name_txt)))
   {


   //int h=FileOpen("test.txt",FILE_WRITE|FILE_ANSI|FILE_TXT);
   int h=FileOpen(File_Name_txt,FILE_WRITE|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }
   
   for(int i=1;i<=10;i++){
      //FileWrite(h,"Line-"+IntegerToString(i));
      FileWrite(h,"");
   }
   

   FileClose(h);
   Alert("File created");
   }

}

/*
void Read_File_Statistics()
{
   
   int h=FileOpen(File_Name_txt,FILE_READ|FILE_ANSI|FILE_TXT);
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

//void ReadFileToAlert(string FileName)
void ReadFileToAlert()
{
   int h=FileOpen(File_Name_txt,FILE_READ|FILE_ANSI|FILE_TXT);
   
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

string Read_Value_File_Statistics(int line)
{
   string response = "File_Error";
   int h=FileOpen(File_Name_txt,FILE_READ|FILE_ANSI|FILE_TXT);
   
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


void Change_File_Statistics(int line, string value)
{
   int h=FileOpen(File_Name_txt,FILE_READ|FILE_ANSI|FILE_TXT);

   //string tmpName=TmpFileName("test","txt");
   string tmpName=TmpFileName(File_Name_txt,"txt");

   int tmph=FileOpen(tmpName,FILE_WRITE|FILE_ANSI|FILE_TXT);

   int cnt=0;
   while(!FileIsEnding(h)){
      cnt++;
      string str=FileReadString(h);
      if(cnt==line){
         // substituir a linha
         FileWrite(tmph,value);
      }
      else{
         // reescrever a linha sem alterações
         FileWrite(tmph,str);
      }
   }
   FileClose(tmph);
   FileClose(h);

   FileDelete(File_Name_txt);
   FileMove(tmpName,0,File_Name_txt,0);
}


/*
void CallReadFileArray()
{
   ReadFileToArray(File_Name_txt, 10)
}


bool ReadFileToArray(string FileName,string & Lines[])
{
   ResetLastError();
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      int ErrNum=GetLastError();
      printf("Erro ao abrir o arquivo %s # %i",FileName,ErrNum);
      return(false);
   }
   int cnt=0; // use a variável para contar o número de linhas de arquivo
   while(!FileIsEnding(h)){
      string str=FileReadString(h); // leia a próxima linha do arquivo
      // remover espaços à esquerda, e à direita para detectar e evitar o uso de linhas vazias
      StringTrimLeft(str); 
      StringTrimRight(str);
      if(str!=""){ 
         if(cnt>=ArraySize(Lines)){ // array completamente preenchido
            ArrayResize(Lines,ArraySize(Lines)+1024); // aumentar o tamanho do array em 1024 elementos
         }
         Lines[cnt]=str; // Enviar a linha de leitura para o array
         cnt++; // aumentar o contador de linhas de leitura
      }
   }
   ArrayResize(Lines,cnt);
   FileClose(h);
   return(true);
}
*/
/*
void Create_File_Statistics_Csv()
{
   int h=FileOpen(File_Name_csv,FILE_WRITE|FILE_ANSI|FILE_CSV,";");
   
   
   for(int i=1;i<=10;i++){
      string str="Line-"+IntegerToString(i)+"-";
      FileWrite(h,str+"1",str+"2",str+"3");
   }


   string str=FileReadString(h);
   Alert(str);

   FileClose(h);

}


void Read_File_Statistics_Csv()
{
   
   int h=FileOpen(File_Name_csv,FILE_READ|FILE_ANSI|FILE_CSV,";");
   
   
   ReadFileToAlertCSV2(File_Name_csv);

   //string str=FileReadString(h);
   //Alert(str);

   FileClose(h);

}

void ReadFileToAlertCSV2(string FileName){
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_CSV,";");
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }   
   Alert("=== Start ===");   
   while(!FileIsEnding(h)){
      string str=FileReadString(h);
      Alert(str);
      if(FileIsLineEnding(h)){
         Alert("---");
      }
   }
   FileClose(h);
}

*/