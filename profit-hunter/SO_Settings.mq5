//TODO
/*
IMPLEMENTAR UM ALGO QUE VERIFICA A ÚLTIMA EXECUÇÃO (COMPRA OU VENDA)
E APARTIR DO RESULTADO, INCREMENTAR COM A FORMULA X = pts * fator * segquencia ( o fator pode ser fixo ou variável tb)

*/


enum enum_CallFrom
{
    eCallFrom_OnInit                = 0,
    eCallFrom_NewTradingFloor       = 1,
    eCallFrom_OnTick                = 2,

};

enum enum_Order_Side
{
    eSide_Trend                                = 1,
    eSide_AgainstTrend                         = 2
    
};

bool SELECTED_SIDE = eSide_Trend;


bool LONG_CONDITIONS 	= false;
bool SHORT_CONDITIONS 	= false;




void Set_SO(int callFrom)
{
    
    //Set_OrderTrailingStop_Settings_By_Tick(SELECTED_TRAILING_STOP_CHOSEN, SELECTED_SIDE);
    

    if(CheckTradeFilters())
    {    
        switch(SELECTED_SO)
        {
            case 4:
                SO_Follow_Controller(callFrom); 
                break;
            case 1:
                //SO_NewTradingFloor(callFrom);
                SO_Trading_Floor(callFrom);
                break;
            // case 2:
            //     SO_Bar_To_Bar(callFrom);
            //     break;	
            case 3:
                SO_Gradient(callFrom);
                break;		
        } 
    }   
}

int RESUME_STATUS = 0;
int TIME_STATUS = 0;

bool CheckTradeFilters()
{
    if(TIME_STATUS != 1)
    {
        int r = TimeFilterFail();
        return false;
    }
    if(FINANCIAL_RISK)
    {
        RESUME_STATUS = 1;
        return false;
    }
    else
    {
        RESUME_STATUS = 0;
    }
    return true;
}
