

double MyRound(double value)
{
	return NormalizeDouble((Tick_Size*MathRound( value / Tick_Size)),_Digits);
}
double MyRound2(double value)
{
	//return NormalizeDouble((MathRound(value/1)),1);
	return MathRound(value);
}
int MyRound3(double value)
{
	//return NormalizeDouble((MathRound(value/1)),1);
	return (int)MathRound(value);
}
double MyNormalizeDouble(double value)
{
	return NormalizeDouble(value,2);
	//return MathRound(value);
}



void Set_Distance_Mode()
{
	if(!PTS_MODE)
	{
		if(EN_Distance_Long > 0)
			SELECTED_EN_DISTANCE_LONG = MyRound((EN_Distance_Long/100)* SERVER_SYMBOL_ASK);

		if(EN_Distance_Short > 0)
			SELECTED_EN_DISTANCE_SHORT = MyRound((EN_Distance_Short/100) * SERVER_SYMBOL_BID);	

		if(ADJ_DST_SEQ_VALUE > 0)
			SELECTED_ADJ_DST_SEQ = MyRound((ADJ_DST_SEQ_VALUE/100) * SERVER_SYMBOL_BID);	

		
		if(ADJ_DST_VOL_VALUE > 0)
			SELECTED_ADJ_DST_VOL  = MyRound((ADJ_DST_VOL_VALUE/100) * SERVER_SYMBOL_BID);


		if(MIN_ADD_DISTANCE > 0)
			SELECTED_MIN_ADD_DISTANCE  = MyRound((MIN_ADD_DISTANCE/100) * SERVER_SYMBOL_BID);

		if(MIN_REDUCE_DISTANCE > 0)
			SELECTED_MIN_REDUCE_DISTANCE  = MyRound((MIN_REDUCE_DISTANCE/100) * SERVER_SYMBOL_BID);

		//if(ADJ_DST_SEQ_VALUE_LIMIT > 0)
		//	SELECTED_ADJ_DST_SEQ_VALUE_LIMIT  = MyRound((ADJ_DST_SEQ_VALUE_LIMIT/100) * SERVER_SYMBOL_BID);

		//if(ADJ_DST_VOL_VALUE_LIMIT > 0)
		//	SELECTED_ADJ_DST_VOL_VALUE_LIMIT  = MyRound((ADJ_DST_VOL_VALUE_LIMIT/100) * SERVER_SYMBOL_BID);
		
		if(TOTAL_DST_VALUE_LIMIT_CHANGE > 0)
			SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE  = MyRound((TOTAL_DST_VALUE_LIMIT_CHANGE/100) * SERVER_SYMBOL_BID);

		if(MdlTrend_AccTargetDistance > 0 )
			SELECTED_MDL_TREND_ACC_TARGET_DISTANCE = MyRound((MdlTrend_AccTargetDistance/100) * SERVER_SYMBOL_BID);
		
		if(MdlTrend_RevValueDistance > 0 )
			SELECTED_MDL_TREND_TPR_TARGET_DISTANCE = MyRound((MdlTrend_TprTargetDistance/100) * SERVER_SYMBOL_BID);
		
		if(MdlTrend_RevFactorDistance > 0 )
			SELECTED_MDL_TREND_REV_VALUE_DISTANCE = MyRound((MdlTrend_RevValueDistance/100) * SERVER_SYMBOL_BID);
		
		if(MdlTrend_AccValueDistance > 0 )
			SELECTED_MDL_TREND_ACC_VALUE_DISTANCE = MyRound((MdlTrend_AccValueDistance/100) * SERVER_SYMBOL_BID);
		
		if(MdlTrend_TprValueDistance > 0 )
			SELECTED_MDL_TREND_TPR_VALUE_DISTANCE = MyRound((MdlTrend_TprValueDistance/100) * SERVER_SYMBOL_BID);



	

		



	}
	else
	{


		SELECTED_EN_DISTANCE_LONG = EN_Distance_Long;
		SELECTED_EN_DISTANCE_SHORT = EN_Distance_Short;


		SELECTED_ADJ_DST_SEQ = ADJ_DST_SEQ_VALUE;
		SELECTED_ADJ_DST_VOL = ADJ_DST_VOL_VALUE;
		
		
		SELECTED_MIN_ADD_DISTANCE = MIN_ADD_DISTANCE;
		SELECTED_MIN_REDUCE_DISTANCE = MIN_REDUCE_DISTANCE;

		SELECTED_TOTAL_DST_VALUE_LIMIT_CHANGE = TOTAL_DST_VALUE_LIMIT_CHANGE;


		
		SELECTED_MDL_TREND_ACC_TARGET_DISTANCE = MdlTrend_AccTargetDistance;
		
		SELECTED_MDL_TREND_TPR_TARGET_DISTANCE = MdlTrend_TprTargetDistance;
		
		SELECTED_MDL_TREND_REV_VALUE_DISTANCE = MdlTrend_RevValueDistance;
		
		SELECTED_MDL_TREND_ACC_VALUE_DISTANCE = MdlTrend_AccValueDistance;
		
		SELECTED_MDL_TREND_TPR_VALUE_DISTANCE = MdlTrend_TprValueDistance;


	}

}





void Set_Volume_Mode()
{


	if(LOTVOL_MODE)
	{
		SELECTED_VOLUME_LONG  =  (EN_Volume_Long * SERVER_SYMBOL_VOLUME_MIN); // VOLUME LONG (por entrada)
		SELECTED_VOLUME_SHORT =  (EN_Volume_Short * SERVER_SYMBOL_VOLUME_MIN); // VOLUME SHORT (por entrada)
		
		SELECTED_MINIMUN_POSITION_VOLUME = MINIMUN_POSITION_VOLUME * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_LIMIT_ORDER_VOLUME	= LIMIT_ORDER_VOLUME * SERVER_SYMBOL_VOLUME_MIN;

		SELECTED_MDL_GRAVIT_VOL = MdlTrend_Gravit_Vol * SERVER_SYMBOL_VOLUME_MIN;
		
		SELECTED_ADJ_VOL_SEQ = ADJ_VOL_SEQ_VALUE * SERVER_SYMBOL_VOLUME_MIN;


		SELECTED_ADJ_VOL_VOL = ADJ_VOL_VOL_VALUE * SERVER_SYMBOL_VOLUME_MIN;

		SELECTED_ADJ_DST_VOL_TOL_INI = ADJ_DST_VOL_TOL_INI * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_ADJ_DST_VOL_TOL_FIM = ADJ_DST_VOL_TOL_FIM * SERVER_SYMBOL_VOLUME_MIN;



		SELECTED_ADJ_VOL_VOL_TOL_INI = ADJ_VOL_VOL_TOL_INI * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_ADJ_VOL_VOL_TOL_FIM = ADJ_VOL_VOL_TOL_FIM * SERVER_SYMBOL_VOLUME_MIN;		

		//SELECTED_ADJ_VOL_SEQ_VALUE_LIMIT = ADJ_VOL_SEQ_VALUE_LIMIT * SERVER_SYMBOL_VOLUME_MIN;
		//SELECTED_ADJ_VOL_VOL_VALUE_LIMIT = ADJ_VOL_VOL_VALUE_LIMIT * SERVER_SYMBOL_VOLUME_MIN; 
		SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE = TOTAL_VOL_VALUE_LIMIT_CHANGE * SERVER_SYMBOL_VOLUME_MIN;
		

		SELECTED_MDL_TREND_TARGET_VOL = MdlTrend_Target_Vol * SERVER_SYMBOL_VOLUME_MIN;

		SELECTED_MDL_TREND_ACC_FACTOR_VOLUME = MdlTrend_AccFactorVolume * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_MDL_TREND_REV_FACTOR_VOLUME = MdlTrend_RevFactorVolume * SERVER_SYMBOL_VOLUME_MIN;
		SELECTED_MDL_TREND_TPR_FACTOR_VOLUME = MdlTrend_TprFactorVolume * SERVER_SYMBOL_VOLUME_MIN;


		SELECTED_MDL_TREND_ACC_TARGET_VOLUME = MdlTrend_AccTargetVolume *  SERVER_SYMBOL_VOLUME_MIN; 
		SELECTED_MDL_TREND_TPR_TARGET_VOLUME = MdlTrend_TprTargetVolume *  SERVER_SYMBOL_VOLUME_MIN; 

	
	
		SELECTED_MDL_TREND_REV_FACTOR_DISTANCE = MdlTrend_RevFactorDistance * SERVER_SYMBOL_VOLUME_MIN; 

		SELECTED_MDL_TREND_ACC_FACTOR_DISTANCE = MdlTrend_AccFactorDistance * SERVER_SYMBOL_VOLUME_MIN; 

		SELECTED_MDL_TREND_TPR_FACTOR_DISTANCE = MdlTrend_TprFactorDistance * SERVER_SYMBOL_VOLUME_MIN; 
	
		SELECTED_MDL_TREND_REV_VALUE_VOLUME = MdlTrend_RevValueVolume * SERVER_SYMBOL_VOLUME_MIN; 

		SELECTED_MDL_TREND_ACC_VALUE_VOLUME = MdlTrend_AccValueVolume * SERVER_SYMBOL_VOLUME_MIN; 

		SELECTED_MDL_TREND_TPR_VALUE_VOLUME = MdlTrend_TprValueVolume * SERVER_SYMBOL_VOLUME_MIN; 
	
	
	}
	else
	{
		SELECTED_MINIMUN_POSITION_VOLUME = MINIMUN_POSITION_VOLUME;
		SELECTED_VOLUME_LONG  =  (EN_Volume_Long);
		SELECTED_VOLUME_SHORT =  (EN_Volume_Short);
		SELECTED_LIMIT_POSITION_VOLUME	= LIMIT_POSITION_VOLUME;
		SELECTED_LIMIT_ORDER_VOLUME	= LIMIT_ORDER_VOLUME;
		
		SELECTED_MDL_GRAVIT_VOL = MdlTrend_Gravit_Vol ;
		

		SELECTED_ADJ_VOL_SEQ = ADJ_VOL_SEQ_VALUE;

		SELECTED_ADJ_VOL_VOL = ADJ_VOL_VOL_VALUE;
		
		SELECTED_ADJ_DST_VOL_TOL_INI = ADJ_DST_VOL_TOL_INI;
		SELECTED_ADJ_DST_VOL_TOL_FIM = ADJ_DST_VOL_TOL_FIM;

		// SELECTED_ADJ_VOL_SEQ_TOL_INI = ADJ_VOL_SEQ_TOL_INI;
		// SELECTED_ADJ_VOL_SEQ_TOL_FIM = ADJ_VOL_SEQ_TOL_FIM;

		SELECTED_ADJ_VOL_VOL_TOL_INI = ADJ_VOL_VOL_TOL_INI;
		SELECTED_ADJ_VOL_VOL_TOL_FIM = ADJ_VOL_VOL_TOL_FIM;	

		//SELECTED_ADJ_VOL_SEQ_VALUE_LIMIT = ADJ_VOL_SEQ_VALUE_LIMIT;
		//SELECTED_ADJ_VOL_VOL_VALUE_LIMIT = ADJ_VOL_VOL_VALUE_LIMIT;

		SELECTED_TOTAL_VOL_VALUE_LIMIT_CHANGE = TOTAL_VOL_VALUE_LIMIT_CHANGE;

		SELECTED_MDL_TREND_TARGET_VOL = MdlTrend_Target_Vol ;
		SELECTED_MDL_TREND_ACC_FACTOR_VOLUME = MdlTrend_AccFactorVolume ;
		SELECTED_MDL_TREND_REV_FACTOR_VOLUME = MdlTrend_RevFactorVolume ;
		SELECTED_MDL_TREND_TPR_FACTOR_VOLUME = MdlTrend_TprFactorVolume ;

		SELECTED_MDL_TREND_ACC_TARGET_VOLUME = MdlTrend_AccTargetVolume ; 

		SELECTED_MDL_TREND_TPR_TARGET_VOLUME = MdlTrend_TprTargetVolume; 

		SELECTED_MDL_TREND_REV_FACTOR_DISTANCE = MdlTrend_RevFactorDistance ; 

		SELECTED_MDL_TREND_ACC_FACTOR_DISTANCE = MdlTrend_AccFactorDistance ; 

		SELECTED_MDL_TREND_TPR_FACTOR_DISTANCE = MdlTrend_TprFactorDistance ; 
	
		SELECTED_MDL_TREND_REV_VALUE_VOLUME = MdlTrend_RevValueVolume ; 

		SELECTED_MDL_TREND_ACC_VALUE_VOLUME = MdlTrend_AccValueVolume ; 

		SELECTED_MDL_TREND_TPR_VALUE_VOLUME = MdlTrend_TprValueVolume ;

	}

}


//---Distância pela sequencia
void SetAdjDstSeqEnd(double &adj)
{
    if(ADJ_DST_SEQ_TOL_FIM > 0)
    {
        adj = ADJ_DST_SEQ_TOL_FIM; //+ ADJ_DST_SEQ_TOL_INI;
    }
    else
    {
        adj = 100; //+ ADJ_DST_SEQ_TOL_INI;
    }
}
//---Distância pelo volume
void SetAdjDstVolEnd(double &adj)
{
    if(ADJ_DST_VOL_TOL_FIM > 0)
    {
        adj = SELECTED_ADJ_DST_VOL_TOL_FIM; //+ SELECTED_ADJ_DST_VOL_TOL_INI;
    }
    else
    {
        adj = 100;// + SELECTED_ADJ_DST_VOL_TOL_INI;
    }
}



// volume pela sequencia
void SetAdjVolSeqEnd(double &adj)
{
    if(ADJ_VOL_SEQ_TOL_FIM > 0)
    {
        adj = ADJ_VOL_SEQ_TOL_FIM;
    }
    else
    {
        adj = 100;
    }
}


// volume pelo volume
void SetAdjVolVolEnd(double &adj)
{
    if(ADJ_VOL_VOL_TOL_FIM > 0)
    {
        adj = SELECTED_ADJ_VOL_VOL_TOL_FIM; 
    }
    else
    {
        adj = SELECTED_LIMIT_ORDER_VOLUME;
    }
}

// Volume da posição (lotes/unds)
// O volume pode ser configurado para trabalhar em lotes ou unidades.
void GetCurrentPositionVolume(double &adj)
{
    if(LOTVOL_MODE)
    {
        adj = pos_volume / SERVER_SYMBOL_VOLUME_MIN;
    }
    else
    {
        adj = pos_volume;
    }
}


void MyGetPositionData()
{
	CurrentPositionVol = 0;
	CurrentPositionSide = 0;
	CurrentPositionStatus = "Zerado";
	if(PositionSelect(_Symbol))
	{
		CurrentPositionVol = PositionGetDouble(POSITION_VOLUME);
		if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
		{
			CurrentPositionSide = (1);
			CurrentPositionStatus = "Comprado";
		}
		else
		{
			CurrentPositionSide = (-1);
			CurrentPositionStatus = "Vendido";	
		}
	}
}



int MyGetPosition()
{
	int posicao = 0;
	if(PositionSelect(_Symbol))
	{
		if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
			posicao = (1);
		else
			posicao = (-1);
	}
	
	return 	posicao;
}

string MyGetPositionStatus()
{
	string posicao = "No Position";
	if(PositionSelect(_Symbol))
	{
	if(PositionGetInteger(POSITION_TYPE)==POSITION_TYPE_BUY)
		posicao = "Long";
	else
		posicao = "Short";
	}
	
	return 	posicao;
}



double MyGetVolumePosition()
{
	double volume = 0; 
   if(PositionSelect(_Symbol))
	{
		volume = PositionGetDouble(POSITION_VOLUME);
	}
	return volume;
}

double MyGetLastENPosition()
{
	double volume = 0; 
   if(PositionSelect(_Symbol))
	{
		volume = PositionGetDouble(POSITION_VOLUME);
	}
	return volume;
}


/*
M1    1
M5    5
M15  15
M30  30
H1    16385
H4    16388
D1    16408
W1   32769
MN1  49153
*/

int LastDayBars()
{
//TODO tentar um tipo de try cath para verificar se as barras do dia anterior existem e trabalhar com elas
// ex lastdaybars = se intradaybar == 1, d1_period - 16408
	return 0;	
}

ENUM_TIMEFRAMES      MA_Period = PERIOD_CURRENT;



int SELECTED_MAIN_MA_PERIOD = 0;

void MaSelected()
{
	if(MainMaTimeFrame == "d" || MainMaTimeFrame == "D")
	{
		SELECTED_MAIN_MA_PERIOD = 100;
	}
	else if(MainMaTimeFrame == "s" || MainMaTimeFrame == "S") 
	{
		SELECTED_MAIN_MA_PERIOD = 200;
	}
	else if(MainMaTimeFrame == "m" || MainMaTimeFrame == "M") 
	{
		SELECTED_MAIN_MA_PERIOD = 300;
	}
	else
	{
		SELECTED_MAIN_MA_PERIOD = (int)MainMaTimeFrame;
	}

}


void Set_MA_Period()
{

	MaSelected();

    switch(SELECTED_MAIN_MA_PERIOD)
    {
        case 0:
            MA_Period = PERIOD_CURRENT;
            break;
        case 1:
            MA_Period = PERIOD_M1;
            break;
        case 2:
            MA_Period = PERIOD_M2;
            break;
        case 5:
            MA_Period = PERIOD_M5;
            break;
        case 10:
            MA_Period = PERIOD_M10;
            break;
        case 15:
            MA_Period = PERIOD_M15;
            break;
        case 20:
            MA_Period = PERIOD_M20;
            break;
        case 30:
            MA_Period = PERIOD_M30;
            break;
        case 60:
            MA_Period = PERIOD_H1;
            break;
        case 240:
            MA_Period = PERIOD_M4;
            break;
        case 100:
            MA_Period = PERIOD_D1;
			//Print("MA_Period: ", MA_Period);
            break;
        case 200:
            MA_Period = PERIOD_W1;
			//Print("MA_Period: ", MA_Period);
            break;
        case 300:
            MA_Period = PERIOD_MN1;
			//Print("MA_Period: ", MA_Period);
            break;
    }  
}


double SetModePG(double a1, double n, double q)
{

    return pow(a1, n) * pow(q, (n*(n-1))/2);

}
double SetFiboMode(double a1, double n)
{
	double atual = 0;
	double anterior = 0;

    double result = 0;

    // for(int i=1 ; i<=n ;i++)
    // {
    //     result += (a1*i);
    //     //Print("result ->", result);
    // }
    for(int i=1 ; i<=n ;i++)
    {
		if(i ==1)
		{
			atual = a1;
			anterior = 0;
		}
		else
		{
			atual += anterior;
			anterior = atual - anterior;

		}
		
        //Print("result ->", result);
    }
	result = atual;

    return result;

}
double SetSimplePGMode(double a1, double n)
{
	Print("SetSimplePGMode");
	double atual = 0;
	double anterior = 0;

    double result = 0;

    for(int i=1 ; i<=n ;i++)
    {
		atual = anterior + (a1*i);
		anterior = atual;
        Print("result ->", result);
    }

	result = atual;

    return result;

}
    bool ChangeTradingStatus()
	{
		if(LAST_TRADING_STATUS != CurrentTradingStatus)
		{
			if(CurrentTradingStatus == 2 || CurrentTradingStatus == 3)
			{

				return true;
			}
			else
			{
				return false;
			}
		}
		else
		{
			return false;
		}
	}
    bool ChangeTrend()
	{
		if(LAST_TREND != CurrentTrend)
		{

			return true;

		}
		else
		{
			return false;
		}
	}
    bool NewSignal()
	{
		return false;
	}