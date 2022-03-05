
#include <Controls\Dialog.mqh>

#include <Controls\Button.mqh>




//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
//--- recuos e gaps
#define INDENT_LEFT                         (11)      // recuo da esquerda (com permissão para a largura da borda)
#define INDENT_TOP                          (11)      // recuo da parte superior (com permissão para a largura da borda)
#define CONTROLS_GAP_X                      (5)       // gap pela coordenada X
//--- para os botões
#define BUTTON_WIDTH                        (100)     // tamanho pela coordenada X
#define BUTTON_HEIGHT                       (20)      // tamanho pela coordenada Y

//+------------------------------------------------------------------+
//| Eventos                                                          |
//+------------------------------------------------------------------+
#define ON_CLICK                (0)   // evento de clique no controle
#define ON_DBL_CLICK            (1)   // evento de clique duplo no controle
#define ON_SHOW                 (2)   // evento de exibir o controle
#define ON_HIDE                 (3)   // evento de ocultar o controle
#define ON_CHANGE               (4)   // evento de alteração do controle
#define ON_START_EDIT           (5)   // evento de início da edição
#define ON_END_EDIT             (6)   // evento do fim da edição
#define ON_SCROLL_INC           (7)   // evento de incremento da barra de rolagem
#define ON_SCROLL_DEC           (8)   // evento de decremento da barra de rolagem
#define ON_MOUSE_FOCUS_SET      (9)   // evento de "cursor do mouse entrou no controle"
#define ON_MOUSE_FOCUS_KILL     (10)  // evento de "cursor do mouse saiu do controle"
#define ON_DRAG_START           (11)  // evento de "início do arraste do controle"
#define ON_DRAG_PROCESS         (12)  // evento de "o controle está sendo arrastado"
#define ON_DRAG_END             (13)  // evento de "fim do arraste do controle"
#define ON_BRING_TO_TOP         (14)  // evento "aumento da prioridade dos eventos do mouse"
#define ON_APP_CLOSE            (100) // evento "encerramento da aplicação"

//+------------------------------------------------------------------+
//| Macro do mapa de manipulação de eventos                          |
//+------------------------------------------------------------------+
#define INTERNAL_EVENT                           (-1)
//--- início do mapa
#define EVENT_MAP_BEGIN(class_name)              bool class_name::OnEvent(const int id,const long& lparam,const double& dparam,const string& sparam) {
//--- fim do mapa
#define EVENT_MAP_END(parent_class_name)         return(parent_class_name::OnEvent(id,lparam,dparam,sparam)); }
//--- manipulação de eventos pelo ID numérico
#define ON_EVENT(event,control,handler)          if(id==(event+CHARTEVENT_CUSTOM) && lparam==control.Id()) { handler(); return(true); }
//--- manipulação de eventos pelo ID numérico pelo ponteiro de controle
#define ON_EVENT_PTR(event,control,handler)      if(control!=NULL && id==(event+CHARTEVENT_CUSTOM) && lparam==control.Id()) { handler(); return(true); }
//--- manipulação de eventos sem análise do ID
#define ON_NO_ID_EVENT(event,handler)            if(id==(event+CHARTEVENT_CUSTOM)) { return(handler()); }
//--- manipulação de eventos pelo ID da linha
#define ON_NAMED_EVENT(event,control,handler)    if(id==(event+CHARTEVENT_CUSTOM) && sparam==control.Name()) { handler(); return(true); }
//--- manipulação de evento indexado
#define ON_INDEXED_EVENT(event,controls,handler) { int total=ArraySize(controls); for(int i=0;i<total;i++) if(id==(event+CHARTEVENT_CUSTOM) && lparam==controls[i].Id()) return(handler(i)); }
//--- manipulação de evento externo
#define ON_EXTERNAL_EVENT(event,handler)         if(id==(event+CHARTEVENT_CUSTOM)) { handler(lparam,dparam,sparam); return(true); }

//+------------------------------------------------------------------+
//| Manipulação de Evento                                            |
//+------------------------------------------------------------------+

/*
EVENT_MAP_BEGIN(CControlsDialog)
ON_EVENT(ON_CLICK,m_bmpbutton1,OnClickBmpButton1)
//ON_EVENT(ON_CLICK,m_bmpbutton2,OnClickBmpButton2)
EVENT_MAP_END(CAppDialog)
*/
/*
bool CControlsDialog::OnEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   if(id==(ON_CLICK+CHARTEVENT_CUSTOM) && lparam==m_bmpbutton1.Id())
     {
      OnClickBmpButton1();
      return(true);
     }
   if(id==(ON_CLICK+CHARTEVENT_CUSTOM) && lparam==m_bmpbutton2.Id())
     {
      OnClickBmpButton2();
      return(true);
     }
   return(CAppDialog::OnEvent(id,lparam,dparam,sparam));
  }
*/
/*
bool CControlsDialog::OnEvent(const int id,const long& lparam,const double& dparam,const string& sparam) {
if(id==(ON_CLICK+CHARTEVENT_CUSTOM) && lparam==m_bmpbutton1.Id()) { OnClickBmpButton1(); return(true); }
if(id==(ON_CLICK+CHARTEVENT_CUSTOM) && lparam==m_bmpbutton2.Id()) { OnClickBmpButton2(); return(true); }
return(CAppDialog::OnEvent(id,lparam,dparam,sparam)); }
*/



CAppDialog AppWindow;

CButton              m_button1;                       // o objeto botão
CButton              m_button2;                       // o objeto botão










//+------------------------------------------------------------------+
//| Função de inicialização do Expert                                |
//+------------------------------------------------------------------+
//int OnInit()
int OnInit_Dialog()
  {
//---Cria o diálogo do aplicativo
   //if(!AppWindow.Create(0,"AppWindow",0,20,20,360,324))
   if(!AppWindow.Create(0,"AppWindow with Two Buttons",0,40,40,380,344))
      return(INIT_FAILED);

//--- cria os controles dependentes
   if(!CreateButton1())
      return(false);
   //if(!CreateButton2())
     // return(false);


//---
   /*
   int total=AppWindow.ControlsTotal();
   CWndClient*myclient;
   for(int i=0;i<total;i++)
     {
      CWnd*obj=AppWindow.Control(i);
      string name=obj.Name();
      PrintFormat("%d is %s",i,name);
      //--- cor 
      if(StringFind(name,"Client")>0)
        {
         CWndClient *client=(CWndClient*)obj;
         client.ColorBackground(clrRed);
         myclient=client;
         Print("client.ColorBackground(clrRed);");
         ChartRedraw();
        }
      //---
      if(StringFind(name,"Back")>0)
        {
         CPanel *panel=(CPanel*) obj;
         panel.ColorBackground(clrGreen);
         Print("panel.ColorBackground(clrGreen);");
         ChartRedraw();
        }
     }
   Sleep(5000);
   myclient.Destroy();

   */
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
//| Cria o botão "Button1"                                           |
//+------------------------------------------------------------------+
bool CreateButton1(void)
  {
//--- coordenadas
   int x1=INDENT_LEFT;        // x1            = 11  pixels
   int y1=INDENT_TOP;         // y1            = 11  pixels
   int x2=x1+BUTTON_WIDTH;    // x2 = 11 + 100 = 111 pixels
   int y2=y1+BUTTON_HEIGHT;   // y2 = 11 + 20  = 32  pixels
//--- create
   if(!m_button1.Create(0,"Button1",0,x1,y1,x2,y2))
      return(false);
   if(!m_button1.Text("Button1"))
      return(false);
   if(!AppWindow.Add(m_button1))
      return(false);
//--- sucesso
   return(true);
  }




//+------------------------------------------------------------------+

/*
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
//---
   int total=AppWindow.ControlsTotal();
   CWndClient*myclient;
   for(int i=0;i<total;i++)
     {
      CWnd*obj=AppWindow.Control(i);
      string name=obj.Name();
      PrintFormat("%d is %s",i,name);
      //--- cor 
      if(StringFind(name,"Client")>0)
        {
         CWndClient *client=(CWndClient*)obj;
         client.ColorBackground(clrRed);
         myclient=client;
         Print("client.ColorBackground(clrRed);");
         ChartRedraw();
        }
      //---
      if(StringFind(name,"Back")>0)
        {
         CPanel *panel=(CPanel*) obj;
         panel.ColorBackground(clrGreen);
         Print("panel.ColorBackground(clrGreen);");
         ChartRedraw();
        }
     }
   Sleep(5000);
   myclient.Destroy();
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

*/