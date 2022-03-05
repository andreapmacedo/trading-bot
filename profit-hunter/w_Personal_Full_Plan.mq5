
bool BUSINESS_PLAN = false; // para modificar 

bool Account_Validation = false;
string accAuth_live = "10458680"; // live
string accAuth_demo = "123"; // 











bool Account_Time_Validation = false;
string TimeLimit = "2020.06.06"; //"yyyy.mm.dd", 







bool Account_Symbol_Validation = false;
bool Check_Account_Symbol_Validation()
{
	if((_Symbol == "WDOM21") || (_Symbol == "WINM22")|| (_Symbol == "WDON21"))
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