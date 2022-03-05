


#include <Controls\Dialog.mqh>

CAppDialog AppWindow;
//+------------------------------------------------------------------+
//| Função de inicialização do Expert                                |
//+------------------------------------------------------------------+
//int OnInit()
int OnInit_Dialog()
  {
//---Cria o diálogo do aplicativo
   if(!AppWindow.Create(0,"AppWindow",0,20,20,360,324))
      return(INIT_FAILED);
//---Execução da aplicação
   AppWindow.Run();
//--- sucesso
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Função de desinicialização do Expert                             |
//+------------------------------------------------------------------+
void OnDeinit_Dialog(const int reason)
  {
//--- destrói o diálogo
   AppWindow.Destroy(reason);
  }
//+------------------------------------------------------------------+
//| Função de evento do gráfico do Expert                            |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,         // ID do evento  
                  const long& lparam,   // parâmetro do evento do tipo long
                  const double& dparam, // parâmetro do evento do tipo double
                  const string& sparam) // parâmetro do evento do tipo string
  {
   AppWindow.ChartEvent(id,lparam,dparam,sparam);
  }
//+------------------------------------------------------------------+