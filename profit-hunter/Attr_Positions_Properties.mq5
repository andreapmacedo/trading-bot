

// GLOBAL VARIABLES
long                 pos_magic=0;         // Magic number
string               pos_symbol="";       // Symbol
string               pos_comment="";      // Comment
double               pos_swap=0.0;        // Swap
double               pos_commission=0.0;  // Commission
double               pos_price=0.0;       // Current price of the position
double               pos_cprice=0.0;      // Current price of the position
double               pos_profit=0.0;      // Profit/Loss of the position
double               pos_volume;          // Position volume
double               pos_sl=0.0;          // Stop Loss of the position
double               pos_tp=0.0;          // Take Profit of the position
datetime             pos_time=NULL;       // Position opening time
long                 pos_id=0;            // Position identifier
ENUM_POSITION_TYPE   pos_type=NULL;       // Position type



int pos_status = -1;

string pos_status_string;




void Position_Symbol_Loads()
{
  if(PositionSelect(_Symbol))
  {
      Positions_Symbol_Asserts();
  }
  else
  {
    Positions_Symbol_Reset();
  }
}

void Positions_Symbol_Asserts()
{
  pos_symbol     =PositionGetString(POSITION_SYMBOL);
  pos_comment    =PositionGetString(POSITION_COMMENT);
  pos_magic      =PositionGetInteger(POSITION_MAGIC);
  pos_price      = MyRound(PositionGetDouble(POSITION_PRICE_OPEN));
  pos_cprice     = MyRound(PositionGetDouble(POSITION_PRICE_CURRENT));
  // pos_price      = NormalizeDouble(PositionGetDouble(POSITION_PRICE_OPEN),_Digits);
  // pos_cprice     = NormalizeDouble(PositionGetDouble(POSITION_PRICE_CURRENT),_Digits);
  pos_sl         =PositionGetDouble(POSITION_SL);
  pos_tp         =PositionGetDouble(POSITION_TP);
  pos_type       =(ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
  pos_volume     =PositionGetDouble(POSITION_VOLUME);
  pos_commission =PositionGetDouble(POSITION_COMMISSION);
  pos_swap       =PositionGetDouble(POSITION_SWAP);
  pos_profit     =PositionGetDouble(POSITION_PROFIT);
  pos_time       =(datetime)PositionGetInteger(POSITION_TIME);
  pos_id         =PositionGetInteger(POSITION_IDENTIFIER);

  pos_status = PositionGetInteger(POSITION_TYPE);

  CURRENT_SYMBOL_DEAL = SymbolInfoDouble(_Symbol, SYMBOL_LAST);
  
  Set_Pos_String();
}

void Set_Pos_String()
{
  if(pos_status == 0)
  {
    pos_status_string = "Comprado";
  }
  else if(pos_status == 1)
  {
    pos_status_string = "Vendido";
  }
  else
  {
    pos_status_string = "Não Posicionado";
  }
}


void Positions_Symbol_Reset()
{

  pos_status_string = "No Position";
  pos_status = 0; 
  pos_magic=0;         // Magic number
  pos_symbol="";       // Symbol
  pos_comment="";      // Comment
  pos_swap=NULL;//0.0;        // Swap
  pos_commission=NULL;//0.0;  // Commission
  pos_price=NULL;//0.0;       // Current price of the position
  pos_cprice=NULL;//0.0;      // Current price of the position
  pos_profit=NULL;//0.0;      // Profit/Loss of the position
  pos_volume = 0;          // Position volume
  pos_sl=NULL;//0.0;          // Stop Loss of the position
  pos_tp=NULL;//0.0;          // Take Profit of the position
  pos_time=NULL;       // Position opening time
  pos_id=0;            // Position identifier
  pos_type=NULL;       // Position type

  pos_status = -1;

  CURRENT_SYMBOL_DEAL = 0.0;//
  Set_Pos_String();

}






string GetPositionStatus()
{
  string posicao = "Nenhuma";
  if(PositionSelect(_Symbol))
  {
  if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
    posicao = "Comprado";
  else
    posicao = "Vendido";
  }

  return posicao;       
}



void Refresh_Position_Vars()
{

}



