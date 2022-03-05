// separar arquivos que vão tratar apenas de dados relativos ao histório dos que vão ser agrupados e gerados em tempo de exec

double SYMBOL_ANNUALLY_MAX_DRAWDOWN = 0;
double SYMBOL_ANNUALLY_MAX_RISE = 0;	

double SYMBOL_MONTHLY_MAX_DRAWDOWN = 0;
double SYMBOL_MONTHLY_MAX_RISE = 0;	

double SYMBOL_WEEKLY_MAX_DRAWDOWN = 0;
double SYMBOL_WEEKLY_MAX_RISE = 0;	

double SYMBOL_DAILY_LOWEST_LOW = 0;
double SYMBOL_DAILY_HIGHEST_HIGH = 0;

double SYMBOL_DT_MAX_DRAWDOWN = 0;
double SYMBOL_DT_MAX_RISE = 0;

double SYMBOL_HOURLY_LOWEST_LOW = 0;
double SYMBOL_HOURLY_HIGHEST_HIGH = 0;

double SYMBOL_QUARTER_MAX_DRAWDOWN = 0;
double SYMBOL_QUARTER_MAX_RISE = 0;


double SYMBOL_ANNUALLY_CURRENT_BALANCE = 0;
double SYMBOL_MONTHLY_CURRENT_BALANCE = 0;
double SYMBOL_WEEKLY_CURRENT_BALANCE = 0;
double SYMBOL_DAILY_CURRENT_BALANCE = 0;
double SYMBOL_HOURLY_CURRENT_BALANCE = 0;
double SYMBOL_QUARTER_CURRENT_BALANCE = 0;




string File_Cookie_Name = (string)login + "_" + GetTradeMode() + "_" + StringSubstr(name, 0, 3) + "_" + Symbol() + "_Cookie.txt";
int File_Cookie_Lines = 61;
string File_Cookies_Info[61];// = {"","",""};



// no on deinit ou no tempo deperminado
void Print_Cookies()
{
    Print("LAST_WEEK = ",LAST_WEEK);
    Print("LAST_DAY = ",LAST_DAY);
    Print("SYMBOL_DAILY_HIGHEST_HIGH = ",SYMBOL_DAILY_HIGHEST_HIGH);
    Print("SYMBOL_DAILY_LOWEST_LOW = ",SYMBOL_DAILY_LOWEST_LOW);
    Print("SYMBOL_HOURLY_HIGHEST_HIGH = ",SYMBOL_HOURLY_HIGHEST_HIGH);
    Print("SYMBOL_HOURLY_LOWEST_LOW = ",SYMBOL_HOURLY_LOWEST_LOW);
    Print("SYMBOL_HOURLY_CURRENT_BALANCE = ",SYMBOL_HOURLY_CURRENT_BALANCE);
}

void Set_Cookies()
{
  
    File_Cookies_Info[0] = (string)LAST_HOUR;
    File_Cookies_Info[1] = (string)LAST_DAY;
    File_Cookies_Info[2] = (string)LAST_WEEK;
    File_Cookies_Info[3] = (string)LAST_MONTH;
    File_Cookies_Info[4] = (string)LAST_YEAR;
    File_Cookies_Info[5] = (string)SYMBOL_QUARTER_MAX_RISE;    
    File_Cookies_Info[6] = (string)SYMBOL_QUARTER_MAX_DRAWDOWN; 
    File_Cookies_Info[7] = (string)SYMBOL_HOURLY_HIGHEST_HIGH;    
    File_Cookies_Info[8] = (string)SYMBOL_HOURLY_LOWEST_LOW; 
    File_Cookies_Info[9] = (string)SYMBOL_DT_MAX_RISE;    
    File_Cookies_Info[10] = (string)SYMBOL_DT_MAX_DRAWDOWN; 
    File_Cookies_Info[11] = (string)SYMBOL_DAILY_HIGHEST_HIGH;    
    File_Cookies_Info[12] = (string)SYMBOL_DAILY_LOWEST_LOW; 
    File_Cookies_Info[13] = (string)SYMBOL_WEEKLY_MAX_RISE;    
    File_Cookies_Info[14] = (string)SYMBOL_WEEKLY_MAX_DRAWDOWN; 
    File_Cookies_Info[15] = (string)SYMBOL_MONTHLY_MAX_RISE;    
    File_Cookies_Info[16] = (string)SYMBOL_MONTHLY_MAX_DRAWDOWN; 
    File_Cookies_Info[17] = (string)SYMBOL_ANNUALLY_MAX_RISE;    
    File_Cookies_Info[18] = (string)SYMBOL_ANNUALLY_MAX_DRAWDOWN; 


    File_Cookies_Info[19] = (string)SYMBOL_HOURLY_CURRENT_BALANCE;


    File_Cookies_Info[20] = LAST_DEAL_VOLUME;
    File_Cookies_Info[21] = LAST_DEAL_PRICE;
    File_Cookies_Info[22] = LAST_DEAL_RESULT;
    File_Cookies_Info[23] = LAST_DEAL_TYPE;
    File_Cookies_Info[24] = LAST_SELL;
    File_Cookies_Info[25] = LAST_SELL_SEQUENCE;
    File_Cookies_Info[26] = LAST_TOTAL_DEAL_SELL;
    File_Cookies_Info[27] = LAST_BUY;
    File_Cookies_Info[28] = LAST_BUY_SEQUENCE;
    File_Cookies_Info[29] = LAST_TOTAL_DEAL_BUY;
    File_Cookies_Info[30] = LAST_TOTAL_DEAL_OUT;
    File_Cookies_Info[31] = LAST_TOTAL_DEAL_IN;


    File_Cookies_Info[32] =SYMBOL_HOURLY_QTD;
    File_Cookies_Info[33] =SYMBOL_HOURLY_TAX;
    File_Cookies_Info[34] =SYMBOL_HOURLY_LQD; 
    File_Cookies_Info[35] =SYMBOL_QUARTER_QTD;
    File_Cookies_Info[36] =SYMBOL_QUARTER_TAX;
    File_Cookies_Info[37] =SYMBOL_QUARTER_CURRENT_BALANCE;
    File_Cookies_Info[38] =SYMBOL_QUARTER_LQD;
    File_Cookies_Info[39] = (string)END_DAY_CHECK_LOCK;
     
    File_Cookies_Info[40] = countDayOrdersSend;
    File_Cookies_Info[41] = countDayOrdersCancel;
    File_Cookies_Info[42] = countDayOrdersDeals;
    File_Cookies_Info[43] = maxCountDayDeal;
    File_Cookies_Info[44] = TIME_STATUS;
    File_Cookies_Info[45] = RESUME_STATUS;
    File_Cookies_Info[46] = CurrentPositionVol;
    File_Cookies_Info[47] = CurrentPositionSide;
    File_Cookies_Info[48] = Full_Historic_Deals;
    File_Cookies_Info[49] = Current_Buy_Seq;
    File_Cookies_Info[50] = Current_Sell_Seq;
    File_Cookies_Info[51] = SYMBOL_DAILY_MAX_RISE;
    File_Cookies_Info[52] = DATETIME_SYMBOL_DAILY_MAX_RISE;
    File_Cookies_Info[53] = SYMBOL_DAILY_MAX_DRAWDOWN;
    File_Cookies_Info[54] = DATETIME_SYMBOL_DAILY_MAX_DRAWDOWN;
    File_Cookies_Info[55] = CurrentPositionStatus;
    File_Cookies_Info[56] = Current_Historic_Deal_Profit;

    File_Cookies_Info[57] = SYMBOL_HOURLY_MAX_DRAWDOWN;
    File_Cookies_Info[58] = SYMBOL_HOURLY_MAX_RISE;

    File_Cookies_Info[59] = Current_Historic_Vol;
    File_Cookies_Info[60] = Current_Historic_Last_Deal_Price;

//   string str_09 = CurrentPositionStatus;    


    //File_Cookies_Info[21] = "";//(string)END_DAY_CHECK_LOCK;
    //File_Cookies_Info[22] = "";//(string)END_DAY_CHECK_LOCK;

    /*
    Print("LAST_WEEK = ",File_Cookies_Info[0]);
    Print("LAST_DAY = ",File_Cookies_Info[1]);
    Print("SYMBOL_DAILY_HIGHEST_HIGH = ",File_Cookies_Info[2]);
    Print("SYMBOL_DAILY_LOWEST_LOW = ",File_Cookies_Info[3]);
    Print("SYMBOL_HOURLY_HIGHEST_HIGH = ",File_Cookies_Info[4]);
    Print("SYMBOL_HOURLY_LOWEST_LOW = ",File_Cookies_Info[5]);
    Print("SYMBOL_HOURLY_CURRENT_BALANCE = ",File_Cookies_Info[6]);
    */


    Gen_File_Set(File_Cookie_Name, File_Cookie_Lines, File_Cookies_Info);


}
// no on init
void Load_Cookies()
{
    
    Gen_File_Read_Array(File_Cookie_Name, File_Cookie_Lines, File_Cookies_Info);

    LAST_HOUR  = (int)File_Cookies_Info[0];
    LAST_DAY  = (int)File_Cookies_Info[1];
    LAST_WEEK = (int)File_Cookies_Info[2];
    LAST_MONTH = (int)File_Cookies_Info[3];
    LAST_YEAR = (int)File_Cookies_Info[4];
    SYMBOL_QUARTER_MAX_RISE = (double)File_Cookies_Info[5];    
    SYMBOL_QUARTER_MAX_DRAWDOWN = (double)File_Cookies_Info[6]; 
    SYMBOL_HOURLY_HIGHEST_HIGH = (double)File_Cookies_Info[7];    
    SYMBOL_HOURLY_LOWEST_LOW = (double)File_Cookies_Info[8]; 
    SYMBOL_DT_MAX_RISE = (double)File_Cookies_Info[9];    
    SYMBOL_DT_MAX_DRAWDOWN = (double)File_Cookies_Info[10]; 
    SYMBOL_DAILY_HIGHEST_HIGH = (double)File_Cookies_Info[11];   //  
    SYMBOL_DAILY_LOWEST_LOW = (double)File_Cookies_Info[12]; //
    SYMBOL_WEEKLY_MAX_RISE = (double)File_Cookies_Info[13];    
    SYMBOL_WEEKLY_MAX_DRAWDOWN = (double)File_Cookies_Info[14]; 
    SYMBOL_MONTHLY_MAX_RISE = (double)File_Cookies_Info[15];    
    SYMBOL_MONTHLY_MAX_DRAWDOWN = (double)File_Cookies_Info[16]; 
    SYMBOL_ANNUALLY_MAX_RISE = (double)File_Cookies_Info[17];    
    SYMBOL_ANNUALLY_MAX_DRAWDOWN = (double)File_Cookies_Info[18]; 
    SYMBOL_HOURLY_CURRENT_BALANCE = (double)File_Cookies_Info[19];


    LAST_DEAL_VOLUME= (double)File_Cookies_Info[20];
    LAST_DEAL_PRICE= (double)File_Cookies_Info[21];
    LAST_DEAL_RESULT= (double)File_Cookies_Info[22];
    LAST_DEAL_TYPE= (double)File_Cookies_Info[23];
    LAST_SELL= (double)File_Cookies_Info[24];
    LAST_SELL_SEQUENCE= (double)File_Cookies_Info[25];
    LAST_TOTAL_DEAL_SELL= (double)File_Cookies_Info[26];
    LAST_BUY= (double)File_Cookies_Info[27];
    LAST_BUY_SEQUENCE= (double)File_Cookies_Info[28];
    LAST_TOTAL_DEAL_BUY= (double)File_Cookies_Info[29];
    LAST_TOTAL_DEAL_OUT= (double)File_Cookies_Info[30];
    LAST_TOTAL_DEAL_IN= (double)File_Cookies_Info[31];



    SYMBOL_HOURLY_QTD =  File_Cookies_Info[32];
    SYMBOL_HOURLY_TAX =  File_Cookies_Info[33];
    SYMBOL_HOURLY_LQD =  File_Cookies_Info[34] ;  
    SYMBOL_QUARTER_QTD = File_Cookies_Info[35] ;
    SYMBOL_QUARTER_TAX = File_Cookies_Info[36] ;
    SYMBOL_QUARTER_CURRENT_BALANCE = File_Cookies_Info[37];
    SYMBOL_QUARTER_LQD = File_Cookies_Info[38];
    END_DAY_CHECK_LOCK = (int)File_Cookies_Info[39];

    countDayOrdersSend = (int)File_Cookies_Info[40];
    countDayOrdersCancel = (int)File_Cookies_Info[41];
    countDayOrdersDeals = (int)File_Cookies_Info[42];
    maxCountDayDeal = (int)File_Cookies_Info[43];
    TIME_STATUS = (int)File_Cookies_Info[44];
    RESUME_STATUS = (int)File_Cookies_Info[45];
    CurrentPositionVol = File_Cookies_Info[46];
    CurrentPositionSide = File_Cookies_Info[47];
    Full_Historic_Deals = File_Cookies_Info[48];



    Current_Buy_Seq = File_Cookies_Info[49];
    Current_Sell_Seq = File_Cookies_Info[50];
    SYMBOL_DAILY_MAX_RISE = File_Cookies_Info[51];
    DATETIME_SYMBOL_DAILY_MAX_RISE = File_Cookies_Info[52];
    SYMBOL_DAILY_MAX_DRAWDOWN = File_Cookies_Info[53];
    DATETIME_SYMBOL_DAILY_MAX_DRAWDOWN = File_Cookies_Info[54];
    CurrentPositionStatus = File_Cookies_Info[55];
    Current_Historic_Deal_Profit = File_Cookies_Info[56];


    SYMBOL_HOURLY_MAX_DRAWDOWN = File_Cookies_Info[57];
    SYMBOL_HOURLY_MAX_RISE = File_Cookies_Info[58];

    Current_Historic_Vol = File_Cookies_Info[59];
    Current_Historic_Last_Deal_Price = File_Cookies_Info[60];
       
    /*
    LAST_WEEK = (long)Gen_File_Read_Value(0,File_Cookie_Name);
    Alert("LAST_WEEK: ", LAST_WEEK);
    LAST_DAY = (int)Gen_File_Read_Value(1,File_Cookie_Name);
    Alert("LAST_DAY: ", LAST_DAY);

    */
}


double SYMBOL_QUARTER_QTD = 0;
int SYMBOL_QUARTER_TAX = 0;
double SYMBOL_QUARTER_LQD = 0;

double SYMBOL_HOURLY_QTD = 0;
int SYMBOL_HOURLY_TAX = 0;
double SYMBOL_HOURLY_LQD = 0;

void Reset_Quarter_Resume()
{
    SYMBOL_QUARTER_CURRENT_BALANCE = 0;
	SYMBOL_QUARTER_MAX_DRAWDOWN = 0;
	SYMBOL_QUARTER_MAX_RISE = 0;
    SYMBOL_QUARTER_QTD = 0;
    SYMBOL_QUARTER_TAX = 0;
    SYMBOL_QUARTER_LQD = 0;
}

void Reset_Hourly_Resume()
{

SYMBOL_HOURLY_MAX_DRAWDOWN = 0;
SYMBOL_HOURLY_MAX_RISE = 0;

 	SYMBOL_HOURLY_CURRENT_BALANCE = 0;
	SYMBOL_HOURLY_LOWEST_LOW = 0;
	SYMBOL_HOURLY_HIGHEST_HIGH = 0;	
    SYMBOL_HOURLY_QTD = 0;
    SYMBOL_HOURLY_TAX = 0;
    SYMBOL_HOURLY_LQD = 0;    
}


void Set_Quarter_Resume()
{

    // maior volume
    // maior seq
    // média de volume
    // media de seq

    // media de profit

    // relação profit volume
    // qtd operações
    // relção media de operações vc profit
    // atingiu limite 
    // tempo com limite atingido
    // vitória vs derrota (tades acertados vs errados)



    SYMBOL_QUARTER_QTD += LAST_DEAL_VOLUME;
	SYMBOL_QUARTER_CURRENT_BALANCE += MyRound2(LAST_DEAL_RESULT);

    SYMBOL_QUARTER_TAX = (int)(-1 * SYMBOL_QUARTER_QTD * BROKERAGE);
    SYMBOL_QUARTER_LQD = MyRound2(SYMBOL_QUARTER_CURRENT_BALANCE + SYMBOL_QUARTER_TAX);
    
    if(SYMBOL_QUARTER_CURRENT_BALANCE < SYMBOL_QUARTER_MAX_DRAWDOWN)
    {
        SYMBOL_QUARTER_MAX_DRAWDOWN = SYMBOL_QUARTER_CURRENT_BALANCE;
    }

    if(SYMBOL_QUARTER_CURRENT_BALANCE > SYMBOL_QUARTER_MAX_RISE)
    {
        SYMBOL_QUARTER_MAX_RISE = SYMBOL_QUARTER_CURRENT_BALANCE;
    }
    
}


double SYMBOL_HOURLY_MAX_DRAWDOWN = 0;
double SYMBOL_HOURLY_MAX_RISE = 0;

void Set_Hourly_Resume()
{

    SYMBOL_HOURLY_QTD += LAST_DEAL_VOLUME;
	SYMBOL_HOURLY_CURRENT_BALANCE += MyRound2(LAST_DEAL_RESULT);

    SYMBOL_HOURLY_TAX = (int)(-1 * SYMBOL_HOURLY_QTD * BROKERAGE);
    SYMBOL_HOURLY_LQD = MyRound2(SYMBOL_HOURLY_CURRENT_BALANCE + SYMBOL_HOURLY_TAX);

    
    if(SYMBOL_HOURLY_CURRENT_BALANCE < SYMBOL_HOURLY_LOWEST_LOW)
    {
        SYMBOL_HOURLY_LOWEST_LOW = SYMBOL_HOURLY_CURRENT_BALANCE;
    }

    if(SYMBOL_HOURLY_CURRENT_BALANCE > SYMBOL_HOURLY_HIGHEST_HIGH)
    {
        SYMBOL_HOURLY_HIGHEST_HIGH = SYMBOL_HOURLY_CURRENT_BALANCE;
    }

    double current_deep = SYMBOL_HOURLY_CURRENT_BALANCE - SYMBOL_DAILY_HIGHEST_HIGH;
    
    if(current_deep < SYMBOL_HOURLY_MAX_DRAWDOWN)
    {
        SYMBOL_HOURLY_MAX_DRAWDOWN = current_deep;
    }

    //double current_rise = SYMBOL_DAILY_LOWEST_LOW + saldo;
    double current_rise = SYMBOL_DAILY_LOWEST_LOW + SYMBOL_HOURLY_CURRENT_BALANCE;
    
    if(current_rise > SYMBOL_HOURLY_MAX_RISE)
    {
        SYMBOL_HOURLY_MAX_RISE = current_rise;
    }


}

double SYMBOL_DAILY_MAX_DRAWDOWN = 0;
double SYMBOL_DAILY_MAX_RISE = 0;

datetime DATETIME_SYMBOL_DAILY_MAX_DRAWDOWN; 
datetime DATETIME_SYMBOL_DAILY_MAX_RISE; 


// double SYMBOL_DAILY_LAST_BALANCE = 0;
void Set_Daily_Resume()
{
	
    SYMBOL_DAILY_CURRENT_BALANCE = MyRound2(DYT_TOTAL_SYMBOL_DEAL_PROFIT + pos_profit);

    
    if(SYMBOL_DAILY_CURRENT_BALANCE < SYMBOL_DAILY_LOWEST_LOW)
    {
        SYMBOL_DAILY_LOWEST_LOW = SYMBOL_DAILY_CURRENT_BALANCE;
        Set_Weekly_Resume();
    }

    if(SYMBOL_DAILY_CURRENT_BALANCE > SYMBOL_DAILY_HIGHEST_HIGH)
    {
        SYMBOL_DAILY_HIGHEST_HIGH = SYMBOL_DAILY_CURRENT_BALANCE;
        Set_Weekly_Resume();
    }

       // double temp = SYMBOL_DAILY_CURRENT_BALANCE - SYMBOL_DAILY_HIGHEST_HIGH;
    //double current_deep = saldo - SYMBOL_DAILY_HIGHEST_HIGH;
    double current_deep = SYMBOL_DAILY_CURRENT_BALANCE - SYMBOL_DAILY_HIGHEST_HIGH;
    
    if(current_deep < SYMBOL_DAILY_MAX_DRAWDOWN)
    {
        SYMBOL_DAILY_MAX_DRAWDOWN = current_deep;
        DATETIME_SYMBOL_DAILY_MAX_DRAWDOWN = TimeCurrent(); 
    }

    //double current_rise = SYMBOL_DAILY_LOWEST_LOW + saldo;
    double current_rise = SYMBOL_DAILY_LOWEST_LOW + SYMBOL_DAILY_CURRENT_BALANCE;
    
    if(current_rise > SYMBOL_DAILY_MAX_RISE)
    {
        SYMBOL_DAILY_MAX_RISE = current_rise;
        DATETIME_SYMBOL_DAILY_MAX_RISE = TimeCurrent();
    }



    
    // if(SYMBOL_DAILY_LAST_BALANCE < SYMBOL_DAILY_CURRENT_BALANCE)
    // {
    // }

    // SYMBOL_DAILY_LAST_BALANCE = SYMBOL_DAILY_CURRENT_BALANCE;




}



void Set_Weekly_Resume()
{
	SYMBOL_WEEKLY_CURRENT_BALANCE = MyRound2(SYMBOL_WEEKLY_CURRENT_BALANCE + DYT_TOTAL_SYMBOL_DEAL_PROFIT + pos_profit);
    
    if(SYMBOL_WEEKLY_CURRENT_BALANCE < SYMBOL_WEEKLY_MAX_DRAWDOWN)
    {
        SYMBOL_WEEKLY_MAX_DRAWDOWN = SYMBOL_WEEKLY_CURRENT_BALANCE;
        Set_Monthly_Resume();
    }

    if(SYMBOL_WEEKLY_CURRENT_BALANCE > SYMBOL_WEEKLY_MAX_RISE)
    {
        SYMBOL_WEEKLY_MAX_RISE = SYMBOL_WEEKLY_CURRENT_BALANCE;
        Set_Monthly_Resume();
    }

}


void Set_Monthly_Resume()
{
	SYMBOL_MONTHLY_CURRENT_BALANCE = MyRound2(SYMBOL_MONTHLY_CURRENT_BALANCE + DYT_TOTAL_SYMBOL_DEAL_PROFIT + pos_profit);
    
    if(SYMBOL_MONTHLY_CURRENT_BALANCE < SYMBOL_MONTHLY_MAX_DRAWDOWN)
    {
        SYMBOL_MONTHLY_MAX_DRAWDOWN = SYMBOL_MONTHLY_CURRENT_BALANCE;
        Set_Annually_Resume();  
    }

    if(SYMBOL_MONTHLY_CURRENT_BALANCE > SYMBOL_MONTHLY_MAX_RISE)
    {
        SYMBOL_MONTHLY_MAX_RISE = SYMBOL_MONTHLY_CURRENT_BALANCE;
        Set_Annually_Resume();  
    }

}


void Set_Annually_Resume()
{
	SYMBOL_ANNUALLY_CURRENT_BALANCE = MyRound2(SYMBOL_ANNUALLY_CURRENT_BALANCE + DYT_TOTAL_SYMBOL_DEAL_PROFIT + pos_profit);
    
    if(SYMBOL_ANNUALLY_CURRENT_BALANCE < SYMBOL_ANNUALLY_MAX_DRAWDOWN)
    {
        SYMBOL_ANNUALLY_MAX_DRAWDOWN = SYMBOL_ANNUALLY_CURRENT_BALANCE; 
    }

    if(SYMBOL_ANNUALLY_CURRENT_BALANCE > SYMBOL_ANNUALLY_MAX_RISE)
    {
        SYMBOL_ANNUALLY_MAX_RISE = SYMBOL_ANNUALLY_CURRENT_BALANCE;
    }

}