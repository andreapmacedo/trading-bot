


string TmpFileName(string Name,string Ext){
   string fn=Name+"."+Ext; // formando nome
   int n=0;
   while(FileIsExist(fn)){ // se o arquivo existir
      n++;
      fn=Name+IntegerToString(n)+"."+Ext; // adicionar um número ao nome
   }
   return(fn);
}


void Gen_File_Create(string FileName,int lines)
{

   //if(!(FileIsExist(File_Name_txt, FILE_COMMON)))
   if(!(FileIsExist(FileName)))
   {
      //int h=FileOpen("test.txt",FILE_WRITE|FILE_ANSI|FILE_TXT);
      int h=FileOpen(FileName,FILE_WRITE|FILE_ANSI|FILE_TXT);
      if(h==INVALID_HANDLE){
         Alert("Error opening file");
         return;
      }
      
      for(int i=0;i<lines;i++){
         //FileWrite(h,"Line-"+IntegerToString(i));
         FileWrite(h,"");
      }
      
      FileClose(h);
      Alert("File created");
   }

}
void Gen_File_Set(string FileName,int lines, string &array[])
//void Gen_File_Set(string FileName,int line)
{
   //if(FileIsExist(FileName))
   //int h=FileOpen("test.txt",FILE_WRITE|FILE_ANSI|FILE_TXT);
   int h=FileOpen(FileName,FILE_WRITE|FILE_ANSI|FILE_TXT);
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return;
   }
   
   for(int i=0;i<lines;i++){
      //FileWrite(h,"Line-"+IntegerToString(i));
      FileWrite(h,array[i]);
      PrintFormat("FileWrite %i = %s",i,array[i]);
      //Alert("File", array[i]);
   }
   FileClose(h);
   //Alert("File created");

}


void Gen_File_ReadFileToAlert(string FileName)
{
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   
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

string Gen_File_Read_Value(int line, string FileName)
{
   string response = "File_Error";
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   //int h=FileOpen(FileName,FILE_WRITE|FILE_READ|FILE_ANSI|FILE_TXT);
   
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


string Gen_File_Read_Array(string FileName,int lines, string &array[])
{
   string response = "File_Error";
   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   //int h=FileOpen(FileName,FILE_WRITE|FILE_READ|FILE_ANSI|FILE_TXT);
   
   if(h==INVALID_HANDLE){
      Alert("Error opening file");
      return response;
   }   
/*
   int cnt=0;
   while(!FileIsEnding(h)){
      string str=FileReadString(h);
      array[cnt] = str;
      cnt++;
   }
*/
   for(int i=0;i<lines;i++)
   {
      string str=FileReadString(h);
      array[i] = str;
      PrintFormat("FileWrite %i = %s",i,array[i]);
      //Alert("File", array[i]);
   }


   FileClose(h);

   return response;
}


void Gen_File_Change(int line, string value, string FileName)
{

   int h=FileOpen(FileName,FILE_READ|FILE_ANSI|FILE_TXT);
   //int h=FileOpen(FileName,FILE_WRITE|FILE_READ|FILE_ANSI|FILE_TXT);

   //string tmpName=TmpFileName("test","txt");
   string tmpName=TmpFileName(FileName,"txt");

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

   FileDelete(FileName);
   FileMove(tmpName,0,FileName,0);
}
