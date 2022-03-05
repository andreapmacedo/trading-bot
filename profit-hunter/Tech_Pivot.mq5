
void PivotFind_Draw(double lenght, color low_color_line, color high_color_line, color mid_color_line, int line_width, int high_objNumber, int low_OgjNumber, int mid_OgjNumber)
{
     
	int pivo_lenth = lenght;
	bool isHigh = true;
	bool isLow = true;
	bool isFound_H = true;
	bool isFound_L = true;
	int length_half_point = (int)(pivo_lenth/2);
	double pH = PriceInfo[(length_half_point+1)].high; 
	double pL = PriceInfo[(length_half_point+1)].low;  



	if (IntradayBar > (pivo_lenth+2))
	{
		for (int i = 1; i < (length_half_point+1) ; i++) //1 to 2
		{    
			if (isHigh && PriceInfo[i].high > pH)
			{
				isFound_H = false;
			}
					
			if (isLow && PriceInfo[i].low < pL)
			{
				isFound_L = false;
			}  
		}
		for (int i = (length_half_point)+2 ; i < (length_half_point*2)+2; i++) //4 to 5
		{
			if (isHigh && PriceInfo[i].high >= pH)
			{
				isFound_H = false;         
			}
			if  (isLow && PriceInfo[i].low <= pL)
			{
				isFound_L = false;
			}
		} 
        if (isFound_H) 
        {
			LAST_PIVOT_HIGH         = PIVOT_HIGH;
			LAST_PIVOT_HIGH_index   = PIVOT_HIGH_index;
			LAST_PIVOT_HIGH_time    = PIVOT_HIGH_time;
		  
			PIVOT_HIGH              = pH;
			PIVOT_HIGH_index        = IntradayBar;
			PIVOT_HIGH_time         = PriceInfo[(pivo_lenth/2)+1].time;
        }    
        if (isFound_L)
        {
			LAST_PIVOT_LOW        = PIVOT_LOW;
			LAST_PIVOT_LOW_index  = PIVOT_LOW_index;
			LAST_PIVOT_LOW_time   = PIVOT_LOW_time;

			PIVOT_LOW = pL;
			PIVOT_LOW_index = IntradayBar;
			PIVOT_LOW_time = PriceInfo[(pivo_lenth/2)+1].time;
		}           
                
	} // end if

	PIVOT_FIND_MID_LEVEL = PIVOT_HIGH - ((PIVOT_HIGH - PIVOT_LOW)/2);
	
      
      //int printTrend = start();
	string objectNameA = "LineA"+lenght;	
	string objectNameB = "LineB"+lenght;
	
	// old
	//ObjectDelete(_Symbol, "LineB");
	//DrawObjectRectangle("LineB", PriceInfo[30].time, LAST_PIVOT_LOW+0.5, PriceInfo[1].time, LAST_PIVOT_LOW, color_line);
	//ObjectDelete(_Symbol, "LineD");
	//DrawObjectRectangle("LineD", PriceInfo[30].time, LAST_PIVOT_HIGH-0.5, PriceInfo[1].time, LAST_PIVOT_HIGH, color_line);

	// new
	
	ObjectDelete(_Symbol, objectNameA);
	DrawObjectRectangle(objectNameA, PIVOT_LOW_time, PIVOT_LOW+0.5, PriceInfo[0].time, PIVOT_LOW, clrRed);
	
	
	ObjectDelete(_Symbol, objectNameB);
	DrawObjectRectangle(objectNameB, PIVOT_HIGH_time, PIVOT_HIGH-0.5, PriceInfo[0].time, PIVOT_HIGH, clrBlue);
	
	
	/*
	DrawHorizontalLine_Evo(high_objNumber, PIVOT_HIGH, high_color_line, line_width);
	DrawHorizontalLine_Evo(mid_OgjNumber, PIVOT_LOW, low_color_line, line_width);
	DrawHorizontalLine_Evo(low_OgjNumber, PIVOT_FIND_MID_LEVEL, mid_color_line, line_width);
	*/


}









void PivotFind_Select(double lenght, int select)
{
     
	int pivo_lenth = lenght;

	bool isHigh = true;
	bool isLow = true;

	bool isFound_H = true;
	bool isFound_L = true;
				
	int length_half_point = (int)(pivo_lenth/2);
		
	double pH = PriceInfo[(length_half_point+1)].high;
	double pL = PriceInfo[(length_half_point+1)].low;  



	if (IntradayBar > (pivo_lenth+2))
	{
		for (int i = 1; i < (length_half_point+1) ; i++) //1 to 2
		{    
			if (isHigh && PriceInfo[i].high > pH)
			{
				isFound_H = false;
			}
					
			if (isLow && PriceInfo[i].low < pL)
			{
				isFound_L = false;
			}  
		}
		for (int i = (length_half_point)+2 ; i < (length_half_point*2)+2; i++) //4 to 5
		{
			if (isHigh && PriceInfo[i].high >= pH)
			{
				isFound_H = false;         
			}
			if  (isLow && PriceInfo[i].low <= pL)
			{
				isFound_L = false;
			}
		} 
        if (isFound_H)
        {      		
			LAST_PIVOT_HIGH         = PIVOT_HIGH;
			LAST_PIVOT_HIGH_index   = PIVOT_HIGH_index;
			LAST_PIVOT_HIGH_time    = PIVOT_HIGH_time;
		  
			PIVOT_HIGH              = pH;
			PIVOT_HIGH_index        = IntradayBar;
			PIVOT_HIGH_time         = PriceInfo[(pivo_lenth/2)+1].time;

			switch(select)
			{
				case 1:
					PIVOT_HIGH_01 = PIVOT_HIGH;      
					break;
				case 2:
					PIVOT_HIGH_02 = PIVOT_HIGH;		
					break;                                   
				case 3:
					PIVOT_HIGH_03 = PIVOT_HIGH;	
					break; 
			}
        }    
        if (isFound_L)
        {  
			LAST_PIVOT_LOW        = PIVOT_LOW;
			LAST_PIVOT_LOW_index  = PIVOT_LOW_index;
			LAST_PIVOT_LOW_time   = PIVOT_LOW_time;

			PIVOT_LOW = pL;
			PIVOT_LOW_index = IntradayBar;
			PIVOT_LOW_time = PriceInfo[(pivo_lenth/2)+1].time;
			
			switch(select)
			{
				case 1:
					PIVOT_LOW_01 = PIVOT_LOW;      
					break;
				case 2:
					PIVOT_LOW_02 = PIVOT_LOW;		
					break;                                   
				case 3:
					PIVOT_LOW_03 = PIVOT_LOW;	
					break; 
			}
		}           
                
	} // end if

	PIVOT_FIND_MID_LEVEL = PIVOT_HIGH - ((PIVOT_HIGH - PIVOT_LOW)/2);

	/*
    PIVOT_HIGH_01 = PIVOT_HIGH;
    PIVOT_LOW_01 = PIVOT_LOW;
	PIVOT_MID_01 = PIVOT_FIND_MID_LEVEL;
	*/
    switch(select)
    {
        case 1:
			PIVOT_MID_01 = PIVOT_HIGH_01 - ((PIVOT_HIGH_01 - PIVOT_LOW_01)/2);         
            break;
        case 2:
			PIVOT_MID_02 = PIVOT_HIGH_02 - ((PIVOT_HIGH_02 - PIVOT_LOW_02)/2);	
            break;                                   
        case 3:
			PIVOT_MID_03 = PIVOT_HIGH_03 - ((PIVOT_HIGH_03 - PIVOT_LOW_03)/2);		
            break; 
    }
}




double PivotHigh(double lenght)
{

	int pivo_lenth = lenght;
    bool isHigh = true;
    bool isFound_H = true;
    int length_half_point = (int)(pivo_lenth/2);
    double pH = PriceInfo[(length_half_point+1)].high; 
      
	if (IntradayBar > (pivo_lenth+2))
	{
        for (int i = 1; i < (length_half_point+1) ; i++) //1 to 2
        {    
          if (isHigh && PriceInfo[i].high > pH)
          {
            isFound_H = false;
          } 
        }
        for (int i = (length_half_point)+2 ; i < (length_half_point*2)+2; i++) //4 to 5
        {
          if (isHigh && PriceInfo[i].high >= pH)
          {
            isFound_H = false;         
          }
        } 
        if (isFound_H) 
        {
			return pH; 
		} 
		else
		{
			return 0.0;
		}			          
	} 
	return 0.0;
}


double PivotLow(double lenght)
{

      int pivo_lenth = lenght;
      bool isLow = true;
      bool isFound_L = true;
      int length_half_point = (int)(pivo_lenth/2);
      double pL = PriceInfo[(length_half_point+1)].low;  
      
	  if (IntradayBar > (pivo_lenth+2))
      {
		for (int i = 1; i < (length_half_point+1) ; i++) //1 to 2
        {                 
			if (isLow && PriceInfo[i].low < pL)
			{
				isFound_L = false;
			}  
        }
        for (int i = (length_half_point)+2 ; i < (length_half_point*2)+2; i++) //4 to 5
        {
			if  (isLow && PriceInfo[i].low <= pL)
			{
				isFound_L = false;
			}
        }   
        if (isFound_L)
        {      
			return pL;
        }
		else           
        {
			return 0;
		}			
    } 
	return 0;
      
}




//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// Pivot management
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// set true
/*
double PivotManagment = false;
if(PivotManagment)
{
*/	

double LastTop = NormalizeDouble(0.0, _Digits);
double LastBottom = NormalizeDouble(0.0, _Digits);

double HighestHigh = NormalizeDouble(0.0, _Digits);
double LowestLow = NormalizeDouble(0.0, _Digits);

//double    PIVOT_HIGH = NormalizeDouble(0.0, _Digits);
//double    PIVOT_LOW = NormalizeDouble(0.0, _Digits);
//int       PIVOT_HIGH_index = 0;
//int       PIVOT_LOW_index = 0;


datetime ddt_CURRENT_0 = 0;
datetime ddt_CURRENT_1 = 0;
datetime ddt_CURRENT_2 = 0;
datetime ddt_CURRENT_3 = 0;
datetime ddt_CURRENT_4 = 0;
datetime ddt_CURRENT_5 = 0;
datetime ddt_CURRENT_A = 0;
datetime ddt_CURRENT_B = 0;
datetime ddt_CURRENT_C = 0;
datetime ddt_CURRENT_D = 0;



double PV_A_High[2], PV_A_Low[2];
/*
	ArraySetAsSeries(PV_A_High, true);
    ArraySetAsSeries(PV_A_Low, true);

    CopyHigh(_Symbol, _Period, 0, LEFT_BARS, PV_A_High);
    CopyLow(_Symbol, _Period, 0, LEFT_BARS, PV_A_Low);

    HighestHigh = ArrayMaximum(PV_A_High, 0, LEFT_BARS);
    LowestLow = ArrayMinimum(PV_A_Low, 0, LEFT_BARS);	

*/

double REC_PV_1 		= NormalizeDouble(0.0, _Digits);
double LAST_PV_1 		= NormalizeDouble(0.0, _Digits);
double OLD_PV_1 		= NormalizeDouble(0.0, _Digits);

enum PV1_STATUS  // enumeration of named constants
{
  NONE 		            = 0,
  r_NEW_LOW_PIVOT   		= 1,
  r_NEW_HIGH_PIVOT  		= 2,
  HIGH_ENGULF			= 3,
  r_NEW_LOW_ENGULF		= 4,
  TRIANGLE         		= 5
  //r_NEW_LOW_TRIANGLE     = 6,
  
};





enum ENUM_LAST_DEAL_TYPE_STATUS
{
	NONE         = 0,
	FIRST        = 1,
	REVERSE      = 2,
	ADD          = 3,
	PROFIT       = 4,
	STOP_GAIN    = 5,
	STOP_LOSS    = 6,
	END_DAY      = 7
	
	
};

int n_LAST_DEAL_TYPE	= 0;

enum ENUM_LEVEL  // enumeration of named constants
{
	NONE		  	       = 0,
	enum_LEVEL_0   		   = 1,
	enum_LEVEL_1           = 2,
	enum_LEVEL_2           = 3,
	enum_LEVEL_3           = 4, 
	enum_LEVEL_4           = 5, 
	enum_LEVEL_5           = 6,
	enum_LEVEL_A           = 7,
	enum_LEVEL_B           = 8,
	enum_LEVEL_C           = 9,
	enum_LEVEL_D           = 10
  
};

enum ENUM_WAVE  // enumeration of named constants
{
	NONE	  			  	   	= 0,
	enum_WAVE_1     		    = 1,
	enum_WAVE_2     		    = 2,
	enum_WAVE_3     		  	= 3,
	enum_WAVE_4     		    = 4,
	enum_WAVE_5     		    = 5,
	enum_WAVE_A     		    = 6,
	enum_WAVE_B     		    = 7,
	enum_WAVE_C     		    = 8,
	enum_WAVE_D     		    = 9
	
	

};



enum ENUM_HIGH_OR_LOW_LEVEL  // enumeration of named constants
{
  NONE   		         = 0,
  enum_LEVEL_TOP    	  	   = 1,
  enum_LEVEL_BOTTOM   	      = 2
  
};



enum ENUM_STATUS_LEVEL  // enumeration of named constants
{
  NONE   		       		= 0,
  enum_START_LEVEL          = 1,
  enum_REVERSE_LEVEL        = 2,
  enum_r_NEW_HIGHEST_HIGH    = 3,
  enum_FAIL_HIGHEST_HIGH   = 4,
  enum_r_NEW_LOWEST_LOW      = 5,
  enum_FAIL_LOWEST_LOW     = 6,
  enum_r_NEW_HIGH_LEVEL      = 7,
  enum_r_NEW_LOW_LEVEL       = 8
   
};

enum ENUM_TREND  // enumeration of named constants
{
  NONE   		      		 = 0,
  enum_TREND_UP              = 1,
  enum_TREND_DOWN            = 2

  
};


enum ENUM_WAVE_TYPE  // enumeration of named constants
{
  NONE   		      = 0,
  IMPULSIVE           = 1,
  CORRECTIVE          = 2

};

int n_ORDER_TYPE                    = 0 ; 
int ndt_CURRENT_WAVE_TYPE   		= 0;
int CURRENT_IMPULSIVE_LEVEL 		= 0;
int CURRENT_IMPULSIVE_WAVE 	   		= 0;
int ndt_CURRENT_CORRECTIVE_LEVEL    = 0;
int ndt_CURRENT_CORRECTIVE_WAVE 	= 0;
int ndt_CURRENT_LEVEL_STATUS  	 	= 0;



int ndt_CURRENT_LEVEL 		   			= 0;
int ndt_CURRENT_TREND             		= 0;
int ndt_CURRENT_WAVE              		= 0;

int ndt_CURRENT_LEVEL_TOP_BOTTOM  		= 0;

int n_NEW_LOWAST_STATUS   			= 0;
int n_NEW_LOWAST_WAVE     			= 0;

int n_NEW_LOWAST_HIGHEST_LEVEL 		= 0;
int CURRENT_LOW_LEVEL_FAIL_NNEW 	= 0;




double rdt_CURRENT_WAVE_1 = 0.0;
double rdt_CURRENT_WAVE_2 = 0.0;
double rdt_CURRENT_WAVE_3 = 0.0;
double rdt_CURRENT_WAVE_4 = 0.0;
double rdt_CURRENT_WAVE_5 = 0.0;
double rdt_CURRENT_WAVE_A = 0.0;
double rdt_CURRENT_WAVE_B = 0.0;
double rdt_CURRENT_WAVE_C = 0.0;
double rdt_CURRENT_WAVE_D = 0.0;


double rdt_CURRENT_0 = 0.0;
double rdt_CURRENT_1 = 0.0;
double rdt_CURRENT_2 = 0.0;
double rdt_CURRENT_3 = 0.0;
double rdt_CURRENT_4 = 0.0;
double rdt_CURRENT_5 = 0.0;
double rdt_CURRENT_A = 0.0;
double rdt_CURRENT_B = 0.0;
double rdt_CURRENT_C = 0.0;
double rdt_CURRENT_D = 0.0;




double rdt_R38  = 0.0;
double rdt_R50  = 0.0;
double rdt_R61  = 0.0;
double rdt_E127 = 0.0;
double rdt_E161 = 0.0;
double rdt_E200 = 0.0;
double rdt_E261 = 0.0;

double rdt_T027  = 0.0;
double rdt_T061  = 0.0;
double rdt_T100 = 0.0;
double rdt_T161 = 0.0;







double LAST_IMPULSIVE_0 = 0.0;
double LAST_IMPULSIVE_1 = 0.0;
double LAST_IMPULSIVE_2 = 0.0;
double LAST_IMPULSIVE_3 = 0.0;
double LAST_IMPULSIVE_4 = 0.0;
double LAST_IMPULSIVE_5 = 0.0;
double LAST_A = 0.0;
double LAST_B = 0.0;
double LAST_C = 0.0;
double LAST_D = 0.0;

double OLDEST_IMPULSIVE_0 = 0.0;
double OLDEST_IMPULSIVE_1 = 0.0;
double OLDEST_IMPULSIVE_2 = 0.0;
double OLDEST_IMPULSIVE_3 = 0.0;
double OLDEST_IMPULSIVE_4 = 0.0;
double OLDEST_IMPULSIVE_5 = 0.0;
double OLDEST_CORRECTIVE_A = 0.0;
double OLDEST_CORRECTIVE_B = 0.0;
double OLDEST_CORRECTIVE_C = 0.0;
double OLDEST_CORRECTIVE_D = 0.0;


double rdt_CURRENT_LEVEL_HIGH = 0.0;
double PV2_H_REC = 0.0;
double PV3_H_REC = 0.0;
double rdt_CURRENT_LEVEL_LOW = 0.0;
double PV2_L_REC = 0.0;
double PV3_L_REC = 0.0;


double LAST_LEVEL_HIGH = 0.0;
double PV2_H_LAST = 0.0;
double PV3_H_LAST = 0.0;
double LAST_LEVEL_LOW = 0.0;
double PV2_L_LAST = 0.0;
double PV3_L_LAST = 0.0;

double OLDEST_LEVEL_HIGH = 0.0;
double PV2_H_OLD = 0.0;
double PV3_H_OLD = 0.0;

double OLDEST_LEVEL_LOW = 0.0;
double PV2_L_OLD = 0.0;
double PV3_L_OLD = 0.0;


double PV_1_ret_50 = 0.0;
double PV_1_ret_61 = 0.0;
double PV_1_ret_38 = 0.0;

double PV_1_H_fib_127 = 0.0;
double PV_1_L_fib_127 = 0.0;
double PV_1_H_fib_161 = 0.0;
double PV_1_L_fib_161 = 0.0;
double PV_1_H_fib_200 = 0.0;
double PV_1_L_fib_200 = 0.0;
double PV_1_H_fib_261 = 0.0;
double PV_1_L_fib_261 = 0.0;


void PivotManagment()
{			
	//MqlRates PriceInfo[];
	//ArraySetAsSeries(PriceInfo, true);

	int    size_PV_1 = 3;
	int    size_PV_2 = 5;
	int    size_PV_3 = 7;
	int    ext_PV = (3*60*60);
	 
	double r_NEW_HIGH = PivotHigh(size_PV_1);
	double r_NEW_LOW = PivotLow(size_PV_1);
	
	double PV_H_2 = PivotHigh(size_PV_2);
	double PV_L_2 = PivotLow(size_PV_2);
	double PV_L_3 = PivotLow(size_PV_3);
	

	bool for_intraday = true;	
	if (for_intraday)
	{
		if(IntradayBar == 3) 	// || IntradayBar == 25 ) //if(LAST_BAR_SIZE < 10)
		{
			rdt_CURRENT_0 								= 0;
			rdt_CURRENT_1 								= 0;
			rdt_CURRENT_2 								= 0;
			rdt_CURRENT_3 								= 0;
			rdt_CURRENT_4 								= 0;
			rdt_CURRENT_5 								= 0;
			rdt_CURRENT_A								= 0;
			rdt_CURRENT_B 								= 0;
			rdt_CURRENT_C 								= 0;
			rdt_CURRENT_D 								= 0;
			rdt_CURRENT_WAVE_1							= 0;
			rdt_CURRENT_WAVE_2						= 0;
			rdt_CURRENT_WAVE_3						= 0;
			rdt_CURRENT_WAVE_4						= 0;
			rdt_CURRENT_WAVE_5						= 0;
			rdt_CURRENT_WAVE_A						= 0;
			rdt_CURRENT_WAVE_B						= 0;
			rdt_CURRENT_WAVE_C						= 0;
			rdt_CURRENT_WAVE_D						= 0;
			rdt_CURRENT_LEVEL_HIGH					    = 0;
			rdt_CURRENT_LEVEL_LOW						= 0;
			ndt_CURRENT_TREND                      		= 0;

		}
	}

			PC_Pivo("reset");
			/*
		 //Comment(fullComment + ,
		 Comment("Symbol " + _Symbol,
				"\n rdt_CURRENT_0           " + rdt_CURRENT_0,
				"\n rdt_CURRENT_1           " + rdt_CURRENT_1,
				"\n rdt_CURRENT_2           " + rdt_CURRENT_2,
				"\n rdt_CURRENT_A           " + rdt_CURRENT_A,
				"\n rdt_CURRENT_WAVE_1      " +	rdt_CURRENT_WAVE_1,
				"\n rdt_CURRENT_WAVE_2      " +	rdt_CURRENT_WAVE_2,
				"\n rdt_CURRENT_WAVE_A      " +	rdt_CURRENT_WAVE_A,
				"\n ndt_CURRENT_TREND       " + ndt_CURRENT_TREND          
				);
*/
	
	//+------------------------------------------------------------------+
	// New High
	//+------------------------------------------------------------------+	
	if (r_NEW_HIGH > 0 ) // Nova máxima
	{
		// É A PRIMEIRA MARCAÇÃO?
		if (rdt_CURRENT_LEVEL_HIGH > 0) // [(H1[S])] existe uma máxima? 
		{
			if(ndt_CURRENT_TREND == enum_TREND_DOWN) //[H1S_(H2[S])]  Tendência de baixa?
			{
				if(r_NEW_HIGH < rdt_CURRENT_0) // [H1S_H2S_(H3[S])] máxima menor que topo 0?
				{
					if (rdt_CURRENT_WAVE_2 > 0 ) // [H1S_H2S_H3S_(H4[S])] já tem onda 2?
					{
						if (r_NEW_HIGH > rdt_CURRENT_WAVE_2) // [H1S_H2S_L3S_H4S_(H5[S])] a nova máxima é menor que a 2 atual? (s) vai atualizar o valor da 2
						{
							rdt_CURRENT_2                        = r_NEW_HIGH;
							rdt_CURRENT_WAVE_2					= (r_NEW_HIGH - rdt_CURRENT_1);
							
							//CURRENT_IMPULSIVE_WAVE              = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL             = enum_LEVEL_2;
							
							PC_Pivo("[H1S_H2S_H3S_H4S_(H5[S])]");
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_2");
							DrawObjectLine("rdt_CURRENT_WAVE_2", PriceInfo[(size_PV_1/2)+1].time, r_NEW_HIGH, (PriceInfo[0].time)+ext_PV, r_NEW_HIGH, clrYellow);
						}
						else // [H1S_H2S_H3S_(H4[N])]  não vai atualizar o valor da 2
						{
							//TODO
							//FAZER O ESTUDO DOS TRIANGULOS
							//rdt_CURRENT_2                        = r_NEW_HIGH;
							//rdt_CURRENT_WAVE_2					= (r_NEW_HIGH - rdt_CURRENT_1);
							
							//CURRENT_IMPULSIVE_WAVE              = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL             = enum_LEVEL_2;
							
							PC_Pivo("[H1S_H2S_H3S_H4S_(H5[N])]");
							ObjectDelete(_Symbol, "triangulo");
							DrawObjectLine("triangulo", PriceInfo[(size_PV_1/2)+1].time, r_NEW_HIGH, (PriceInfo[0].time)+ext_PV, r_NEW_HIGH, clrWhite);
							
						}
					}
					else
					{
						if(r_NEW_HIGH > (rdt_CURRENT_0 - (rdt_CURRENT_WAVE_1*0.72))) // [H1S_H2S_H3S_H4N_(H5[S])] é a primeira B {L_OK}
						{
							rdt_CURRENT_2                        = r_NEW_HIGH;
							rdt_CURRENT_WAVE_2					= (r_NEW_HIGH - rdt_CURRENT_1);
							
							//CURRENT_IMPULSIVE_WAVE              = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL             = enum_LEVEL_2;
							
							PC_Pivo("[H1S_H2S_H3S_H4N_(H5[S])]");
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_2");
							DrawObjectLine("rdt_CURRENT_WAVE_2", PriceInfo[(size_PV_1/2)+1].time, r_NEW_HIGH, (PriceInfo[0].time)+ext_PV, r_NEW_HIGH, clrYellow);	
								
						}
						else // é mais uma corretiva {L_OK}
						{
							//TODO
							// ESTE CÓDIGO NÃO ESTÁ COMPLETO. PRECISA FAZER O ALGO QUE TRATA DAS ONDAS CORRETIVAS.
							rdt_CURRENT_A                        = r_NEW_HIGH;
							rdt_CURRENT_WAVE_A					= (r_NEW_HIGH - rdt_CURRENT_1);
							//ndt_CURRENT_CORRECTIVE_LEVEL         = enum_WAVE_A;
							//ndt_CURRENT_CORRECTIVE_LEVEL         = enum_LEVEL_A;
							//Comment("NOVA A " );
							PC_Pivo("[H1S_H2S_H3S_H4N_(H5[N])]");
							
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_A");
							DrawObjectLine("rdt_CURRENT_WAVE_A", PriceInfo[(size_PV_1/2)+1].time, r_NEW_HIGH, (PriceInfo[0].time)+ext_PV, r_NEW_HIGH, clrYellowGreen);
						}
					}

					
				}
				else // fez máxima maior que a mínima 0 (rompeu o topo) reversão. {L_OK} TODO - FAZER BACKTEST COM TRADE DE COMPRA EM RETRAÇÃO QUANDO HOUVER REVERSÃO
				{
					
					
					
					if(rdt_CURRENT_1 >0)
					{
						rdt_CURRENT_0                          		= rdt_CURRENT_1;
						rdt_CURRENT_1 								= r_NEW_HIGH;
						ddt_CURRENT_0								= ddt_CURRENT_1;
						ddt_CURRENT_1								= PriceInfo[(size_PV_1/2)+1].time;
						rdt_CURRENT_WAVE_1						    = (r_NEW_HIGH - rdt_CURRENT_0); 
					}


					ndt_CURRENT_WAVE  							= enum_WAVE_1;
					ndt_CURRENT_LEVEL            				= enum_LEVEL_1;
					ndt_CURRENT_TREND			            	= enum_TREND_UP;
					
					rdt_CURRENT_2 								= 0;
					rdt_CURRENT_3 								= 0;
					rdt_CURRENT_4 								= 0;
					rdt_CURRENT_5 								= 0;
					rdt_CURRENT_A								= 0;
					rdt_CURRENT_B 								= 0;
					rdt_CURRENT_C 								= 0;
					rdt_CURRENT_D 								= 0;
					rdt_CURRENT_WAVE_1							= 0;
					rdt_CURRENT_WAVE_2							= 0;
					rdt_CURRENT_WAVE_3							= 0;
					rdt_CURRENT_WAVE_4							= 0;
					rdt_CURRENT_WAVE_5							= 0;
					rdt_CURRENT_WAVE_A							= 0;
					rdt_CURRENT_WAVE_B							= 0;
					rdt_CURRENT_WAVE_C							= 0;
					rdt_CURRENT_WAVE_D							= 0;
					PC_Pivo("[H1S_H2S_(H3[N])]");
					
					
					
					//ENGOLFO OU REVERSÃO OU WOLF
					//CALCULAR RETRAÇÃO
				}						

			}
			else // ou fez nova máxima maior ou menor // ou fez novam máxima apos uma onda B ou onda 2
			{
				if(r_NEW_HIGH > rdt_CURRENT_1) // superou o topo, precisa saber se foi quanto a partir da onda 2
				{
					if(enum_LEVEL_2 > 0 )// É UMA 2
					{
						
						//TODO
						// VERIFICA SE ATINGIU OS ALVOS DE 123
						PC_Pivo("[H1S_H2N_H3S_(H4[S])]");
						// 
					}
					else // apenas ajusta o tamano o nível da onda 1.
					{
						rdt_CURRENT_1 							= r_NEW_HIGH;
						rdt_CURRENT_WAVE_1						= (r_NEW_HIGH - rdt_CURRENT_0);
						PC_Pivo("[H1S_H2N_H3S_(H4[N])]");
					}							
				}
					

			}					
		}
		else //  [(H1[N])] é a primeira máxima !
		{
			if (rdt_CURRENT_LEVEL_LOW == 0) // [H1N_(H2[S])] não tem mínima
			{
				
				
				rdt_CURRENT_0                    = r_NEW_HIGH;
				CURRENT_IMPULSIVE_LEVEL          = enum_LEVEL_0;
				ddt_CURRENT_0					 = PriceInfo[(size_PV_1/2)+1].time;
				ndt_CURRENT_LEVEL 	     		 = enum_LEVEL_0;
				ndt_CURRENT_LEVEL_STATUS         = enum_START_LEVEL;
				ndt_CURRENT_TREND                = enum_TREND_DOWN;

				PC_Pivo("[H1N_(H2[S])]");					
			}
			else //é a primeira máxima e já tem mínima {L_OK}
			{	
				if (r_NEW_HIGH > rdt_CURRENT_0) 
				{		
					rdt_CURRENT_1 							= r_NEW_HIGH;
					rdt_CURRENT_WAVE_1						= (r_NEW_HIGH - rdt_CURRENT_0);
					ddt_CURRENT_1							= PriceInfo[(size_PV_1/2)+1].time;
					ndt_CURRENT_WAVE  						= enum_WAVE_1;
					CURRENT_IMPULSIVE_LEVEL         	    = enum_LEVEL_1;
					ndt_CURRENT_LEVEL 	     				= enum_LEVEL_1;
					ndt_CURRENT_LEVEL_STATUS                = enum_r_NEW_HIGH_LEVEL;
					ndt_CURRENT_TREND                       = enum_TREND_UP;
					PC_Pivo("[H1N_H2N(H3[S])]"); 
				}
				
				else
				{

					//ndt_CURRENT_TREND                       = TREND_UP;
					//ndt_CURRENT_LEVEL_STATUS                = FAIL_LOWEST_LOW;
					PC_Pivo("[L1N_L2N(L3[N])]");
				}
				//ndt_CURRENT_LEVEL 	     				= LEVEL_1;
				//ndt_CURRENT_WAVE  						= WAVE_1;
				
			}
		}
			
			
			OLDEST_LEVEL_HIGH       = LAST_LEVEL_HIGH;
			LAST_LEVEL_HIGH         = rdt_CURRENT_LEVEL_HIGH;
			rdt_CURRENT_LEVEL_HIGH      = r_NEW_HIGH;	
			
			//ObjectDelete(_Symbol, "r_NEW_HIGH");
			//DrawObjectLine("r_NEW_HIGH", PriceInfo[(size_PV_1/2)+1].time, r_NEW_HIGH, (PriceInfo[0].time)+ext_PV, r_NEW_HIGH, clrRed);	
			ndt_CURRENT_LEVEL_TOP_BOTTOM = enum_LEVEL_TOP;
			
	}	

		//+------------------------------------------------------------------+
		// New Low
		//+------------------------------------------------------------------+
	

	if (r_NEW_LOW > 0 )
	{	
		if (rdt_CURRENT_LEVEL_LOW > 0) // [(L1[S])] existe uma mínima? 
		{
			if(ndt_CURRENT_TREND == enum_TREND_UP) // [L1S_(L2[S])] tendência de alta?
			{		
				if(r_NEW_LOW > rdt_CURRENT_0) // [L1S_L2S_(L3[S])] mínima maior que fundo 0?
				{
					if (rdt_CURRENT_WAVE_2 > 0 ) // [L1S_L2S_L3S_(L4[S])] tem onda 2?
					{
						if (r_NEW_LOW < rdt_CURRENT_WAVE_2) // [L1S_L2S_L3S_L4S_(L5[S])] a nova máxima é menor que a 2 atual? (s) vai atualizar o valor da 2
						{
							rdt_CURRENT_2                        = r_NEW_LOW;
							rdt_CURRENT_WAVE_2					 = (rdt_CURRENT_1 - r_NEW_LOW );
							
							//CURRENT_IMPULSIVE_WAVE              = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL             = enum_LEVEL_2;
							
							PC_Pivo("[L1S_L2S_L3S_L4S_(L5[S])]");
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_2");
							DrawObjectLine("rdt_CURRENT_WAVE_2", PriceInfo[(size_PV_1/2)+1].time, r_NEW_LOW, (PriceInfo[0].time)+ext_PV, r_NEW_LOW, clrYellow);
						}
						else // [L1S_L2S_L3S_L4S_(L5[N])] não vai atualizar o valor da 2
						{
							//TODO
							//FAZER O ESTUDO DOS TRIANGULOS
							
							//CURRENT_IMPULSIVE_WAVE              = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL             = enum_LEVEL_2;
							
							PC_Pivo("[L1S_L2S_L3S_L4S_(L5[N])]");
							ObjectDelete(_Symbol, "triangulo");
							DrawObjectLine("triangulo", PriceInfo[(size_PV_1/2)+1].time, r_NEW_LOW, (PriceInfo[0].time)+ext_PV, r_NEW_LOW, clrWhite);
							
						}
					}
					else // [L1S_L2S_L3S_(L4[N])] tem onda 2?
					{
						if(r_NEW_LOW < (rdt_CURRENT_1 - (rdt_CURRENT_WAVE_1*0.72))) // [L1S_L2S_L3S_L4N_(L5[S])] é a primeira B {L_OK}
						{
							rdt_CURRENT_2                       = r_NEW_LOW;
							rdt_CURRENT_WAVE_2					= (rdt_CURRENT_1 - r_NEW_LOW );
							
							//CURRENT_IMPULSIVE_WAVE            = enum_WAVE_2;
							//CURRENT_IMPULSIVE_LEVEL           = enum_LEVEL_2;
							
							PC_Pivo("[L1S_L2S_L3S_L4N_(L5[S])]");
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_2");
							DrawObjectLine("rdt_CURRENT_WAVE_2", PriceInfo[(size_PV_1/2)+1].time, r_NEW_LOW, (PriceInfo[0].time)+ext_PV, r_NEW_LOW, clrYellow);	
								
						}
						else // [L1S_L2S_L3S_L4N_(L5[N])] é mais uma corretiva {L_OK}
						{
							//TODO
							// ESTE CÓDIGO NÃO ESTÁ COMPLETO. PRECISA FAZER O ALGO QUE TRATA DAS ONDAS CORRETIVAS.
							rdt_CURRENT_A                       = r_NEW_LOW;
							rdt_CURRENT_WAVE_A					= (rdt_CURRENT_1 - r_NEW_LOW);
							//ndt_CURRENT_CORRECTIVE_LEVEL      = enum_WAVE_A;
							//ndt_CURRENT_CORRECTIVE_LEVEL      = enum_LEVEL_A;
							//Comment("NOVA A " );
							PC_Pivo("[L1S_L2S_L3S_L4N_(L5[N])]");
							
							ObjectDelete(_Symbol, "rdt_CURRENT_WAVE_A");
							DrawObjectLine("rdt_CURRENT_WAVE_A", PriceInfo[(size_PV_1/2)+1].time, r_NEW_LOW, (PriceInfo[0].time)+ext_PV, r_NEW_LOW, clrYellowGreen);
						}
					}

				}
				else // [L1S_L2S_(L3[N])] perdeu o fundo precisa inverter tudo. {L_OK}
				{
					
					
					if(rdt_CURRENT_1 >0)
					{
						rdt_CURRENT_0                           = rdt_CURRENT_1;
						rdt_CURRENT_1 							= r_NEW_LOW;
						ddt_CURRENT_0							= ddt_CURRENT_1;
						ddt_CURRENT_1							= PriceInfo[(size_PV_1/2)+1].time;
						rdt_CURRENT_WAVE_1						= (rdt_CURRENT_0 - r_NEW_LOW); 
					}
					
					
					
					
					
					
					ndt_CURRENT_WAVE  						= enum_WAVE_1;
					ndt_CURRENT_LEVEL            			= enum_LEVEL_1;
					ndt_CURRENT_TREND			            = enum_TREND_DOWN;
					//ENGOLFO OU REVERSÃO OU WOLF
					//CALCULAR RETRAÇÃO
					
					
					rdt_CURRENT_2 							= 0;
					rdt_CURRENT_3 							= 0;
					rdt_CURRENT_4 							= 0;
					rdt_CURRENT_5 							= 0;
					rdt_CURRENT_A							= 0;
					rdt_CURRENT_B 							= 0;
					rdt_CURRENT_C 							= 0;
					rdt_CURRENT_D 							= 0;
					rdt_CURRENT_WAVE_2						= 0;
					rdt_CURRENT_WAVE_3						= 0;
					rdt_CURRENT_WAVE_4						= 0;
					rdt_CURRENT_WAVE_5						= 0;
					rdt_CURRENT_WAVE_A						= 0;
					rdt_CURRENT_WAVE_B						= 0;
					rdt_CURRENT_WAVE_C						= 0;
					rdt_CURRENT_WAVE_D						= 0;
					
					PC_Pivo("[L1S_L2S_(L3[N])]");
				}						

			}
			else //  [L1S_(L2[N])] fez nova minima menor 
			{
				if(r_NEW_LOW < rdt_CURRENT_1) //  [L1S_L2N_(L3[S])] superou o topo, precisa saber se foi quanto a partir da onda 2
				{
					if(rdt_CURRENT_2 > 0 ) // [L1S_L2N_L3S(L4[S])] É UMA 2
					{
						//CURRENT_IMPULSIVE_WAVE +
						//TODO
						// VERIFICA SE ATINGIU OS ALVOS DE 123
						PC_Pivo("[L1S_L2N_L3S(L4[S])]");
						// 
					}else // [L1S_L2N_L3S(L4[N])] apenas ajusta o tamano o nível da onda 1. {L_OK}
					{
						rdt_CURRENT_1 							= r_NEW_LOW;
						rdt_CURRENT_WAVE_1						= (rdt_CURRENT_0 - r_NEW_LOW);
						PC_Pivo("[L1S_L2N_L3S(L4[N])]");
					}							
				} //  FALTANDO UM ELSE????
					

			}


			
		}
		else // [(L2[N])] é a primeira mínima 	
		{
			// tem máxima ?
			if (rdt_CURRENT_LEVEL_HIGH == 0) // [L1N_(L2[S])] é o primeiro nível {L_OK}
			{	
				rdt_CURRENT_0                 		    = r_NEW_LOW;
				CURRENT_IMPULSIVE_LEVEL     		    = enum_LEVEL_0;
				ddt_CURRENT_0							= PriceInfo[(size_PV_1/2)+1].time;
				ndt_CURRENT_LEVEL              			= enum_LEVEL_0;
				ndt_CURRENT_LEVEL_STATUS                = enum_START_LEVEL;
				ndt_CURRENT_TREND              		    = enum_TREND_UP;
				PC_Pivo("[L1N_(L2[S])]");
				//ndt_CURRENT_TREND                = TREND_UP; não pode ser trend up ainda pois não vai gerar tamanho de onda 1 e vai faltar referencia para calcular se uma nova minima seria B ou novo fundo
				
				
			}
			else // [L1N_(L2[N])] é a primeira mínima e já tem máxima
			{
				if (r_NEW_LOW < rdt_CURRENT_0 ) // [L1N_L2N(L3[S])]
				{	
					
					rdt_CURRENT_1 							= r_NEW_LOW;
					rdt_CURRENT_WAVE_1					= (rdt_CURRENT_0 - r_NEW_LOW);
					ddt_CURRENT_1							= PriceInfo[(size_PV_1/2)+1].time;
					ndt_CURRENT_WAVE  						= enum_WAVE_1;
					CURRENT_IMPULSIVE_LEVEL           		= enum_LEVEL_1;
					ndt_CURRENT_LEVEL 	     				= enum_LEVEL_1;
					ndt_CURRENT_LEVEL_STATUS             	= enum_r_NEW_LOW_LEVEL;
					ndt_CURRENT_TREND                       = enum_TREND_DOWN;
					PC_Pivo("[L1N_L2N(L3[S])]");
					
					
				}
				
				else // [L1N_L2N(L3[N])]
				{
					//ndt_CURRENT_TREND                       = TREND_UP;
					//ndt_CURRENT_LEVEL_STATUS                = FAIL_LOWEST_LOW;
					PC_Pivo("[L1N_L2N(L3[N])]");
					
				}
				//ndt_CURRENT_LEVEL 	     				= LEVEL_1;
				//ndt_CURRENT_WAVE  						= WAVE_1;
			}		
		}	

		OLDEST_LEVEL_LOW 		= LAST_LEVEL_LOW;
		LAST_LEVEL_LOW 			= rdt_CURRENT_LEVEL_LOW;
		rdt_CURRENT_LEVEL_LOW 	= r_NEW_LOW;

		//ObjectDelete(_Symbol, "r_NEW_LOW");
		//DrawObjectLine("r_NEW_LOW", PriceInfo[(size_PV_1/2)+1].time, r_NEW_LOW, (PriceInfo[0].time)+ext_PV, r_NEW_LOW, clrBlue);
		

		ndt_CURRENT_LEVEL_TOP_BOTTOM = enum_LEVEL_BOTTOM;	
	}
	
	
/*

				QUANDO ENCONTRA UM ABC, O ALGORITIMO NÃO DEVE PROJETAR ALVOS E RETRAÇÃO PARA OS NOVOS NIVEIS, MAS 
				CALCULAR O ALVO E A RETRAÇÃO DO A, RELATIVO AO B E NÃO ENTRE O B E O C COMO É ATUALMENTE.
				MAS DEVE SER CALCULADO A RETRAÇÃO DO B E C BEM COMO OS ALVOS DE FIBO EM DIREÇÃO AO A.




				sempre que um novo nível for identificado a seguinte seguencia será aplicada
				foi um topo ou um fundo
				se foi topo, ele está acima do anterior ou abaixo.?
				se tem um ultimo topo e fundo, compara se tem um topo e fundo anterior
				se ha novos topos e novos fundos, uma tendência pode estar em curso.
				avaliar a retração destes novos topos e fundos.
				se forem superior a 61,8(fechamento) tende a ser bandeira.



*/		
	
	bool plot_last_high_and_low = false;
	
	if (plot_last_high_and_low && rdt_CURRENT_LEVEL_HIGH != 0 && rdt_CURRENT_LEVEL_LOW != 0)
	{
		double dst = rdt_CURRENT_LEVEL_HIGH - rdt_CURRENT_LEVEL_LOW;
		
		PV_1_ret_50 = rdt_CURRENT_LEVEL_LOW + (dst/2);
		PV_1_ret_61 = rdt_CURRENT_LEVEL_LOW + (dst*0.61);
		PV_1_ret_38 = rdt_CURRENT_LEVEL_LOW + (dst*0.38);
		PV_1_H_fib_127 = rdt_CURRENT_LEVEL_LOW + (dst*1.27);
		PV_1_H_fib_161 = rdt_CURRENT_LEVEL_LOW + (dst*1.61);
		PV_1_H_fib_200 = rdt_CURRENT_LEVEL_LOW + (dst*2);
		PV_1_H_fib_261 = rdt_CURRENT_LEVEL_LOW + (dst*2.61);
		
		
		
		PV_1_L_fib_127 = rdt_CURRENT_LEVEL_HIGH - (dst*1.27);
		PV_1_L_fib_161 = rdt_CURRENT_LEVEL_HIGH - (dst*1.61);
		PV_1_L_fib_200 = rdt_CURRENT_LEVEL_HIGH - (dst*2);
		PV_1_L_fib_261 = rdt_CURRENT_LEVEL_HIGH - (dst*2.61);
		

		//ObjectDelete(_Symbol, "rdt_CURRENT_LEVEL_HIGH");
		//ObjectDelete(_Symbol, "rdt_CURRENT_LEVEL_LOW");
		ObjectDelete(_Symbol, "PV_1_ret_50");
		ObjectDelete(_Symbol, "PV_1_ret_61");
		ObjectDelete(_Symbol, "PV_1_ret_38");
		ObjectDelete(_Symbol, "PV_1_H_fib_127");
		ObjectDelete(_Symbol, "PV_1_L_fib_127");
		ObjectDelete(_Symbol, "PV_1_H_fib_161");
		ObjectDelete(_Symbol, "PV_1_L_fib_161");
		ObjectDelete(_Symbol, "PV_1_H_fib_200");
		ObjectDelete(_Symbol, "PV_1_L_fib_200");
		ObjectDelete(_Symbol, "PV_1_H_fib_261");
		ObjectDelete(_Symbol, "PV_1_L_fib_261");
		
		//DrawObjectLine("rdt_CURRENT_LEVEL_HIGH", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_HIGH, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_HIGH, clrRed);
		//DrawObjectLine("rdt_CURRENT_LEVEL_LOW", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_LOW, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_LOW, clrRed);
		DrawObjectLine("PV_1_ret_50", PriceInfo[(size_PV_1/2)+1].time, PV_1_ret_50, (PriceInfo[0].time)+ext_PV, PV_1_ret_50, clrLime);
		DrawObjectLine("PV_1_ret_61", PriceInfo[(size_PV_1/2)+1].time, PV_1_ret_61, (PriceInfo[0].time)+ext_PV, PV_1_ret_61, clrLime);
		DrawObjectLine("PV_1_ret_38", PriceInfo[(size_PV_1/2)+1].time, PV_1_ret_38, (PriceInfo[0].time)+ext_PV, PV_1_ret_38, clrLime);
		DrawObjectLine("PV_1_H_fib_127", PriceInfo[(size_PV_1/2)+1].time, PV_1_H_fib_127, (PriceInfo[0].time)+ext_PV, PV_1_H_fib_127, clrAqua);
		DrawObjectLine("PV_1_L_fib_127", PriceInfo[(size_PV_1/2)+1].time, PV_1_L_fib_127, (PriceInfo[0].time)+ext_PV, PV_1_L_fib_127, clrMediumVioletRed);
		DrawObjectLine("PV_1_H_fib_161", PriceInfo[(size_PV_1/2)+1].time, PV_1_H_fib_161, (PriceInfo[0].time)+ext_PV, PV_1_H_fib_161, clrAqua);
		DrawObjectLine("PV_1_L_fib_161", PriceInfo[(size_PV_1/2)+1].time, PV_1_L_fib_161, (PriceInfo[0].time)+ext_PV, PV_1_L_fib_161, clrMediumVioletRed);
		DrawObjectLine("PV_1_H_fib_200", PriceInfo[(size_PV_1/2)+1].time, PV_1_H_fib_200, (PriceInfo[0].time)+ext_PV, PV_1_H_fib_200, clrAqua);
		DrawObjectLine("PV_1_L_fib_200", PriceInfo[(size_PV_1/2)+1].time, PV_1_L_fib_200, (PriceInfo[0].time)+ext_PV, PV_1_L_fib_200, clrMediumVioletRed);
		DrawObjectLine("PV_1_H_fib_261", PriceInfo[(size_PV_1/2)+1].time, PV_1_H_fib_261, (PriceInfo[0].time)+ext_PV, PV_1_H_fib_261, clrAqua);
		DrawObjectLine("PV_1_L_fib_261", PriceInfo[(size_PV_1/2)+1].time, PV_1_L_fib_261, (PriceInfo[0].time)+ext_PV, PV_1_L_fib_261, clrMediumVioletRed);

		
		//DrawObjectFIBO("FIBO_r_NEW_HIGH", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_HIGH, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_LOW, clrDodgerBlue);
		//ObjectDelete(_Symbol, "FIBO_r_NEW_LOW");
		//DrawObjectFIBO("FIBO_r_NEW_LOW", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_LOW, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_HIGH, clrDodgerBlue);
		

	
	}
	
	
	color selected_color = clrYellow;
	if (ndt_CURRENT_TREND == enum_TREND_UP)
	{
		selected_color = clrBlue;
	}
	else if(ndt_CURRENT_TREND == enum_TREND_DOWN)
	{
		selected_color = clrRed;
	}
	else
	{
		selected_color = clrWhite;
	}	
	

	if (rdt_CURRENT_0 != 0)
	{
		ObjectDelete(_Symbol, "rdt_CURRENT_0");
		DrawObjectLine("rdt_CURRENT_0", ddt_CURRENT_0, rdt_CURRENT_0, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_0, selected_color);
	
	}
	
	
	if (rdt_CURRENT_1 != 0)
	{
		ObjectDelete(_Symbol, "rdt_CURRENT_1");
		DrawObjectLine("rdt_CURRENT_1", ddt_CURRENT_1, rdt_CURRENT_1, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_1, selected_color);
	
	}

	// set true
	bool plot_last_wave = true;
	
	if (plot_last_wave && rdt_CURRENT_0 != 0 && rdt_CURRENT_1 != 0)
	{
		
		double dst = 0;
		double ref = 0;
		string current_level = "DT";
			
		if (ndt_CURRENT_TREND == enum_TREND_UP)
		{
			dst = rdt_CURRENT_1 - rdt_CURRENT_0;
			rdt_R50 = rdt_CURRENT_0 + (dst/2);
			rdt_R61 = rdt_CURRENT_0 + (dst*0.61);
			rdt_R38 = rdt_CURRENT_0 + (dst*0.38);
			rdt_T027 = rdt_CURRENT_1 + (dst*0.27);
			rdt_T061 = rdt_CURRENT_1 + (dst*0.61);
			rdt_T100 = rdt_CURRENT_1 + (dst*1);
			rdt_T161 = rdt_CURRENT_1 + (dst*1.61);
			
			if(rdt_CURRENT_2 > 0)
			{
				rdt_E127 = rdt_CURRENT_2 + (dst*1.27);
				rdt_E161 = rdt_CURRENT_2 + (dst*1.61);
				rdt_E200 = rdt_CURRENT_2 + (dst*2);
				rdt_E261 = rdt_CURRENT_2 + (dst*2.61);
			}
		}
		else if (ndt_CURRENT_TREND == enum_TREND_DOWN)
		{
			dst = rdt_CURRENT_0 - rdt_CURRENT_1;
			rdt_R50 = rdt_CURRENT_0 - (dst/2);
			rdt_R61 = rdt_CURRENT_0 - (dst*0.61);
			rdt_R38 = rdt_CURRENT_0 - (dst*0.38);
			rdt_T027 = rdt_CURRENT_1 - (dst*0.27);
			rdt_T061 = rdt_CURRENT_1 - (dst*0.61);
			rdt_T100 = rdt_CURRENT_1 - (dst*1);
			rdt_T161 = rdt_CURRENT_1 - (dst*1.61);
			
			if(rdt_CURRENT_2 > 0)
			{
				rdt_E127 = rdt_CURRENT_2 - (dst*1.27);
				rdt_E161 = rdt_CURRENT_2 - (dst*1.61);
				rdt_E200 = rdt_CURRENT_2 - (dst*2);
				rdt_E261 = rdt_CURRENT_2 - (dst*2.61);

			}				
			
			
		}
		else
		{
			//TODO
			//Avaliar a necessidade deste código.
			/*
			ObjectDelete(_Symbol, current_level+"rdt_R50");
			ObjectDelete(_Symbol, current_level+"rdt_R61");
			ObjectDelete(_Symbol, current_level+"rdt_R38");
			ObjectDelete(_Symbol, current_level+"rdt_E127");
			ObjectDelete(_Symbol, current_level+"rdt_E161");
			ObjectDelete(_Symbol, current_level+"rdt_E200");
			ObjectDelete(_Symbol, current_level+"rdt_E261");
			ObjectDelete(_Symbol, current_level+"rdt_T027");
			ObjectDelete(_Symbol, current_level+"rdt_T061");
			ObjectDelete(_Symbol, current_level+"rdt_T100");
			ObjectDelete(_Symbol, current_level+"rdt_T161");
			*/
		}	

			ObjectDelete(_Symbol, current_level+"rdt_CURRENT_LEVEL_HIGH");
			ObjectDelete(_Symbol, current_level+"rdt_CURRENT_LEVEL_LOW");
			ObjectDelete(_Symbol, current_level+"rdt_R50");
			ObjectDelete(_Symbol, current_level+"rdt_R61");
			ObjectDelete(_Symbol, current_level+"rdt_R38");
			ObjectDelete(_Symbol, current_level+"rdt_E127");
			ObjectDelete(_Symbol, current_level+"rdt_E161");
			ObjectDelete(_Symbol, current_level+"rdt_E200");
			ObjectDelete(_Symbol, current_level+"rdt_E261");
			ObjectDelete(_Symbol, current_level+"rdt_T027");
			ObjectDelete(_Symbol, current_level+"rdt_T061");
			ObjectDelete(_Symbol, current_level+"rdt_T100");
			ObjectDelete(_Symbol, current_level+"rdt_T161");
			
			
			//DrawObjectLine("rdt_CURRENT_LEVEL_HIGH", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_HIGH, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_HIGH, clrRed);
			//DrawObjectLine("rdt_CURRENT_LEVEL_LOW", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_LOW, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_LOW, clrRed);
			DrawObjectLine(current_level+"rdt_R50", ddt_CURRENT_1, rdt_R50, (PriceInfo[0].time)+ext_PV, rdt_R50, clrLime);
			DrawObjectLine(current_level+"rdt_R61", ddt_CURRENT_1, rdt_R61, (PriceInfo[0].time)+ext_PV, rdt_R61, clrLime);
			DrawObjectLine(current_level+"rdt_R38", ddt_CURRENT_1, rdt_R38, (PriceInfo[0].time)+ext_PV, rdt_R38, clrLime);
			
			DrawObjectLine(current_level+"rdt_T027", ddt_CURRENT_0, rdt_T027, (PriceInfo[0].time)+ext_PV, rdt_T027, clrAqua);
			DrawObjectLine(current_level+"rdt_T061", ddt_CURRENT_0, rdt_T061, (PriceInfo[0].time)+ext_PV, rdt_T061, clrAqua);
			DrawObjectLine(current_level+"rdt_T100", ddt_CURRENT_0, rdt_T100, (PriceInfo[0].time)+ext_PV, rdt_T100, clrAqua);
			DrawObjectLine(current_level+"rdt_T161", ddt_CURRENT_0, rdt_T161, (PriceInfo[0].time)+ext_PV, rdt_T161, clrAqua);
			
			
			if(rdt_CURRENT_2 > 0)
			{
				DrawObjectLine(current_level+"rdt_E127", rdt_CURRENT_2, rdt_E127, (PriceInfo[0].time)+ext_PV, rdt_E127, clrMediumVioletRed);
				DrawObjectLine(current_level+"rdt_E161", rdt_CURRENT_2, rdt_E161, (PriceInfo[0].time)+ext_PV, rdt_E161, clrMediumVioletRed);
				DrawObjectLine(current_level+"rdt_E200", rdt_CURRENT_2, rdt_E200, (PriceInfo[0].time)+ext_PV, rdt_E200, clrMediumVioletRed);
				DrawObjectLine(current_level+"rdt_E261", rdt_CURRENT_2, rdt_E261, (PriceInfo[0].time)+ext_PV, rdt_E261, clrMediumVioletRed);

			}

			//DrawObjectFIBO("FIBO_r_NEW_HIGH", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_HIGH, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_LOW, clrDodgerBlue);
			//ObjectDelete(_Symbol, "FIBO_r_NEW_LOW");
			//DrawObjectFIBO("FIBO_r_NEW_LOW", PriceInfo[(size_PV_1/2)+1].time, rdt_CURRENT_LEVEL_LOW, (PriceInfo[0].time)+ext_PV, rdt_CURRENT_LEVEL_HIGH, clrDodgerBlue);

	}		
	

} //END (pivorManegment if)





void PC_Pivo(string call_from)
{
	
	 Comment("Symbol " + _Symbol,
		"\n call_from               " + call_from,
		"\n rdt_CURRENT_0           " + rdt_CURRENT_0,
		"\n rdt_CURRENT_1           " + rdt_CURRENT_1,
		"\n rdt_CURRENT_2           " + rdt_CURRENT_2,
		"\n rdt_R61        		    " + NormalizeDouble(round(rdt_R61), _Digits),
		"\n rdt_CURRENT_A           " + rdt_CURRENT_A,
		"\n rdt_CURRENT_WAVE_1      " +	rdt_CURRENT_WAVE_1,
		"\n rdt_CURRENT_WAVE_2      " +	rdt_CURRENT_WAVE_2,
		"\n rdt_CURRENT_WAVE_A      " +	rdt_CURRENT_WAVE_A,
		"\n ndt_CURRENT_TREND       " + ndt_CURRENT_TREND,
		"\n rdt_E127    			" + rdt_E127,
		"\n rdt_E161   			    " + rdt_E161, 
		"\n rdt_E200   			    " + rdt_E200, 
		"\n rdt_E261    		    " + rdt_E261 

		
		);
}
