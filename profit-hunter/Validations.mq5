


void Validations()
{
	Symbol_Validation();
	Account_Validation();
	Account_Symbol_Validation();
}


//--- Verifica se o simbolo está definido. Caso não esteja o código ficará condicionado à qualquer ativo para
void Symbol_Validation()
{
	if(THIS_SYMBOL == "")
	{
		THIS_SYMBOL = _Symbol;
	}
}

bool Account_Validation()
{

	bool response = false;
	if(Account_Validation )
	{
		if(accAuth_live == login || accAuth_demo == login)
		{
			Print("Verificação de conta - ok. - ", login);
			response = true;
		}
		else
		{
			Print("Conta não autorizada.");
			response = false;
		}
	}
	else
	{
		Print("Verificação de conta - ok.");
		response = true;
	}

	return  response;		
}

bool Account_Symbol_Validation()
{
    if(Account_Symbol_Validation)
    {

        return Check_Account_Symbol_Validation();
    }
    else
    {
		Print("Verificação de símbolo - ok. - Account Symbol Validation = false");
        return true;
    }    	

}

bool Account_Time_Validation()
{
	datetime dia = StringToTime(TimeLimit);

    if(Account_Time_Validation)
    {
		if(TimeLocal() > dia)
		{
			Print("Período exedido.");
			return false;
		}
		else
		{
			Print("Verificação de data - ok.");
			return true;
		}

    }
    else
    {
		Print("Verificação de data - ok - Account Time Validation = false.");
        return true;
    }    	

}


//_______________________________________/_________________________________________
