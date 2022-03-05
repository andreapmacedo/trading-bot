
bool BUSINESS_PLAN = true; // para modificar 



bool Account_Validation = true;
string accAuth_live = "2324841"; // live xp
string accAuth_demo = "72324841"; // demo xp




bool Account_Time_Validation = true;
string TimeLimit = "2021.12.31"; //"yyyy.mm.dd", 


bool Account_Symbol_Validation = true;
bool Check_Account_Symbol_Validation()
{
	if((_Symbol == "WDOQ21") || (_Symbol == "WINQ21"))
	{
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


