

// comercializar apenas a estratégia
// cobrar percentual sobre desempenho
// fornecer o robô gratuito para fins de teste

//double PIVOT_HIGH = NormalizeDouble(0.0, _Digits);
//double PIVOT_LOW = NormalizeDouble(0.0, _Digits);


double 	LAST_PIVOT_HIGH         = 0.0;
//double 	LAST_PIVOT_HIGH         = PIVOT_HIGH;
double	LAST_PIVOT_HIGH_index   = 0.0;//PIVOT_HIGH_index;
datetime	LAST_PIVOT_HIGH_time;//    = PIVOT_HIGH_time;
	
double	PIVOT_HIGH;//              = pH;
double	PIVOT_HIGH_index;
datetime	PIVOT_HIGH_time;//         = PriceInfo[(pivo_lenth/2)+1].time;

//double	LAST_PIVOT_LOW        = PIVOT_LOW;
double	LAST_PIVOT_LOW        = 0.0;
double	LAST_PIVOT_LOW_index;//  = PIVOT_LOW_index;
double	LAST_PIVOT_LOW_time;//   = PIVOT_LOW_time;

double	PIVOT_LOW;// = pL;
double	PIVOT_LOW_index;
datetime	PIVOT_LOW_time;// = PriceInfo[(pivo_lenth/2)+1].time;

void SO_Pivot(int callFrom)
{
    //SYS_TRAILING_STOP_PERMITION = true;
    //Print("call from ->", callFrom);
    
    // Variáveis de entrada (INPUT) não podem ser alteradas via código portanto devem ser atribuidas a novas varíaveis
    // passíveis de manipulação pelo SO que terá prioridade hieraquica 
    SELECTED_EST_EN_ANCHOR_CHOSEN        = INPUT_EN_EST_ANCHOR_CHOSEN;
    SELECTED_EST_EN_DISTANCE_CHOSEN     = INPUT_EN_EST_DISTANCE_CHOSEN; 
    SELECTED_EST_VOLUME_CHOSEN          = INPUT_EN_EST_VOLUME_CHOSEN;
    
    LONG_CONDITIONS = false;
    SHORT_CONDITIONS = false;    
    

    switch(SELECTED_VER) // Version
    {
        case 1:
            switch(callFrom)
            {
                case 1: // OnTick
                    PivotManagment();
                    //Sys_Pivot_02(callFrom);
                    break;
            }
            break;            
    }   

    SetOrdersSettings(SELECTED_EST_EN_DISTANCE_CHOSEN, SELECTED_EST_EN_ANCHOR_CHOSEN); //(4,x)

    //EN_ORDER_TYPE_LONG = ORDER_TYPE_BUY_LIMIT;
    //EN_ORDER_TYPE_SHORT = ORDER_TYPE_SELL_LIMIT;

    //PlaceOrders(0);     

}

    double PIVOT_HIGH_01 = NormalizeDouble(0.0, _Digits);
    double PIVOT_LOW_01 = NormalizeDouble(0.0, _Digits);
    double PIVOT_MID_01 = NormalizeDouble(0.0, _Digits);
    
    
    double PIVOT_HIGH_02 = NormalizeDouble(0.0, _Digits);
    double PIVOT_LOW_02 = NormalizeDouble(0.0, _Digits);
    double PIVOT_MID_02 = NormalizeDouble(0.0, _Digits);
    
    double PIVOT_HIGH_03 = NormalizeDouble(0.0, _Digits);
    double PIVOT_LOW_03 = NormalizeDouble(0.0, _Digits);
    double PIVOT_MID_03 = NormalizeDouble(0.0, _Digits);    
    
    int LEFT_BARS_PIVOT_01 = 9;
    int LEFT_BARS_PIVOT_02 = 14;
    int LEFT_BARS_PIVOT_03 = 21;
    
    double Last_PIVOT_HIGH_01 = NormalizeDouble(0.0, _Digits);
    double Last_PIVOT_LOW_01 = NormalizeDouble(0.0, _Digits);
    int Count_High_01 = 0;
    int Count_Low_01 = 0;
    int PIVOT_01_LEFT_BARS = 3;
    int PIVOT_02_LEFT_BARS = 5;





void Sys_Pivot_02(int callFrom)
{


    //PivotFind_Select(LEFT_BARS_PIVOT_01, 1);
    PivotFind_Select(LEFT_BARS_PIVOT_02, 2);
   // PivotFind_Select(LEFT_BARS_PIVOT_03, 3);

/*
    DrawHorizontalLine_Evo(1, PIVOT_HIGH_01, clrRed, 1, STYLE_SOLID);
    DrawHorizontalLine_Evo(2, PIVOT_LOW_01, clrBlue, 1, STYLE_SOLID);
    DrawHorizontalLine_Evo(3, PIVOT_MID_01, clrYellow, 1, STYLE_SOLID);
*/
    DrawHorizontalLine_Evo(4, PIVOT_HIGH_02, clrLightCoral, 1, STYLE_DASH);
    DrawHorizontalLine_Evo(5, PIVOT_LOW_02, clrLightCyan, 1, STYLE_DASH);
    //DrawHorizontalLine_Evo(6, PIVOT_MID_02, clrYellow, 1, STYLE_DASH);
/*
    DrawHorizontalLine_Evo(7, PIVOT_HIGH_03, clrRed, 3, STYLE_DASHDOT);
    DrawHorizontalLine_Evo(8, PIVOT_LOW_03, clrBlue, 3, STYLE_DASHDOT);
    DrawHorizontalLine_Evo(9, PIVOT_MID_03, clrYellow, 3, STYLE_DASHDOT);

*/


}