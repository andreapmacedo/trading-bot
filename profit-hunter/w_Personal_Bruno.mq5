
bool BUSINESS_PLAN = true; // para modificar 



bool Account_Validation = true;
string accAuth_live = "2077332"; // live xp
string accAuth_demo = "12121212"; // live xp




bool Account_Time_Validation = true;
string TimeLimit = "2021.06.06"; //"yyyy.mm.dd", 


bool Account_Symbol_Validation = true;
bool Check_Account_Symbol_Validation()
{
	if((_Symbol == "WDOM21") || (_Symbol == "WINM21")|| (_Symbol == "WDON21"))
	{
        Print("Verificação de símbolo - ok.");
		return true;
	}
	else
	{
        Print("Symbolo não autorizado.");
		return false;	
	}
}


double PERSONA_LOCK_LIMIT_ORDER_VOLUME	                    = 200;
double PERSONA_LOCK_LIMIT_POSITION_VOLUME		    	    = 500;