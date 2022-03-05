
#include "Orders_TP_Distance.mq5"
#include "Orders_SL_Distance.mq5"


void EN_OrderDistance_Settings(int chosen)
{
    switch(chosen)
    {
        case 0: 
            break;
        case 1:  // Distância por sequencia
            EN_STR_Distance_1();
            break;
        case 2:  // Distância por sequencia
            EN_STR_Distance_2();
            break;
        case 10:  // Distância por sequencia
            EstENOrerDst_10();
            break;
        case 11:  
            EstENOrerDst_11();
            break;
        case 20:  // Distância por sequencia e tendência
            EstENOrerDst_20();
            break;
        case 30:  // Distância por sequencia e trade status
            EstENOrerDst_30();
            break;
        case 100: 
            EstENOrerDst_100();
            break;
        case 50: // Distância por volume
            EstENOrerDst_50();
            break;
        case 51: 
            EstENOrerDst_51();
            break;
        case 52: 
            EstENOrerDst_52();
            break;
        case 1001: // independentes
            EstENOrerDst_01();
            break;
        case 1002: 
            EstENOrerDst_02();
            break;
        case 5010: // mistos
            EstENOrerDst_5010();
            break;
    }
}

void EN_STR_Distance_1()
{
    TopChange +=  SELECTED_EN_DISTANCE_LONG;
    BottomChange += SELECTED_EN_DISTANCE_SHORT;
}
void EN_STR_Distance_2()
{
    TopChange -=  SELECTED_EN_DISTANCE_LONG;
    BottomChange -= SELECTED_EN_DISTANCE_SHORT;
}


//+------------------------------------------------------------------+
// Distância por sequência
//+------------------------------------------------------------------+



void EstENOrerDst_10() 
{
    Print("Chamou a 10");
    double adj_end_seq;
    SetAdjDstSeqEnd(adj_end_seq);
    
    if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }

        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
    {
        double range;
        if( Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
}
void EstENOrerDst_11() 
{
    double adj_end_seq;
    SetAdjDstSeqEnd(adj_end_seq);
    
    if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }

        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI)   
    {
        double range;
        if( Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }

        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
}

void EstENOrerDst_20()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double adj_end_seq;
    SetAdjDstSeqEnd(adj_end_seq);
    if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI && CurrentTrend == 1)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }
        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI && CurrentTrend == -1)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
}
void EstENOrerDst_30()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double adj_end_seq;
    SetAdjDstSeqEnd(adj_end_seq);
    if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI && CurrentStatusSystem == 2) // contra a tendência
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }

        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI && CurrentStatusSystem == 2)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
}


void EstENOrerDst_100()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com a sequência de entradas consecutivas.
    -- Se aplica apenas ao lado da posição não atuando na ponta oposta.
    */
    double adj_end_seq;
    SetAdjDstSeqEnd(adj_end_seq);
    if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI && pos_status == 0)
    {
        double range;
        if(Current_Buy_Seq <= adj_end_seq)
        {
            range = Current_Buy_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Buy_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }

        SetDistanceBottomChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
    else if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI && pos_status == 1)   
    {
        double range;
        if(Current_Sell_Seq <= adj_end_seq)
        {
            range = Current_Sell_Seq-ADJ_DST_SEQ_TOL_INI;
        }
        else if(Current_Sell_Seq > adj_end_seq)
        {
            range = adj_end_seq-ADJ_DST_SEQ_TOL_INI;
        }
        SetDistanceTopChange(ADJ_DST_SEQ_MODE_PG, SELECTED_ADJ_DST_SEQ, range);
    }
}

//+------------------------------------------------------------------+
// Distância por volume
//+------------------------------------------------------------------+
void EstENOrerDst_50()
{
    /*
    -- incremento da distância pelo volume (apenas para lado contrário).
    */
    //Print("EstENOrerDst_50");
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);

    

    if(ref_vol > ADJ_DST_VOL_TOL_INI)
    {
        //double range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;

        double range;
        if(ref_vol <= adj_end_vol)
        {
            range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
        }
        else if(ref_vol > adj_end_vol)
        {
            range = adj_end_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
        }


        if(pos_status == 0)
        {
            SetDistanceBottomChange(ADJ_DST_VOL_MODE_PG, SELECTED_ADJ_DST_VOL, range);
        }
        if(pos_status == 1)
        {

            SetDistanceTopChange(ADJ_DST_VOL_MODE_PG, SELECTED_ADJ_DST_VOL, range);
        }
    }
}

void EstENOrerDst_51()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com os lotes de volume incrementado.
    */
    
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);

    //if(ref_vol > SELECTED_ADJ_DST_VOL_TOL_INI && ref_vol <= adj_end_vol)
    if(ref_vol > SELECTED_ADJ_DST_VOL_TOL_INI )
    {
        //double range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;

        double range;
        if(ref_vol <= adj_end_vol)
        {
            range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
        }
        else if(ref_vol > adj_end_vol)
        {
            range = adj_end_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
        }



        SetDistanceBottomChange(ADJ_DST_VOL_MODE_PG, SELECTED_ADJ_DST_VOL, range);
        SetDistanceTopChange(ADJ_DST_VOL_MODE_PG, SELECTED_ADJ_DST_VOL, range);

    }
}
void EstENOrerDst_52()
{
    /*
    -- Aplica o incremento de distancia na próxima entrada de acordo com os lotes de volume incrementado.
    */
    
    double adj_end_vol;
    double ref_vol;
    
    SetAdjDstVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);
    //double range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;


    double range;
    if(ref_vol <= adj_end_vol)
    {
        range = ref_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
    }
    else if(ref_vol > adj_end_vol)
    {
        range = adj_end_vol-SELECTED_ADJ_DST_VOL_TOL_INI;
    }

    if(ref_vol > ADJ_DST_VOL_TOL_INI && ref_vol <= adj_end_vol)
    {


        if(pos_status == 0)
        {
            SetDistanceBottomChange(true, SELECTED_ADJ_DST_VOL, range);
            SetDistanceTopChange(false, SELECTED_ADJ_DST_VOL, range);
        }
        if(pos_status == 1)
        {

            SetDistanceBottomChange(false, SELECTED_ADJ_DST_VOL, range);
            SetDistanceTopChange(true, SELECTED_ADJ_DST_VOL, range);
        }
    }
    else if(ref_vol > ADJ_DST_VOL_TOL_INI && ref_vol > adj_end_vol)
    {
        if(pos_status == 0)
        {
            SetDistanceBottomChange(true, SELECTED_ADJ_DST_VOL, range);   
        }
        if(pos_status == 1)
        {
            SetDistanceTopChange(true, SELECTED_ADJ_DST_VOL, range);
        }               
    }
}


void SetDistanceBottomChange(double mode_pg, double selected_adj, double range)
{
    if(mode_pg)
    {
        BottomChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        BottomChange  += selected_adj * range;
    }
}
void SetDistanceBottomChange_evo(double mode_pg, double selected_adj, double start, double end)
{
    double range;
    if(end > start)
    {
        range = end - start;
    } 
    if(mode_pg)
    {
        BottomChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        BottomChange  += selected_adj * range;
    }
}


void SetDistanceTopChange(double mode_pg, double selected_adj, double range)
{
    if(mode_pg)
    {
        TopChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        TopChange  += selected_adj * range;
    }
}
void SetDistanceTopChange_evo(double mode_pg, double selected_adj, double start, double end)
{
    double range;
    if(end > start)
    {
        range = end - start;
    } 
    if(mode_pg)
    {
        //Print("mode_pg");
        TopChange  += SetSimplePGMode(selected_adj, range);
    }
    else
    {
        //Print("mode_pa");
        TopChange  += selected_adj * range;
    }
}



void EstENOrerDst_5010()
{

    EstENOrerDst_50();
    EstENOrerDst_10();

}


void EstENOrerDst_01()
{

    double adj_end_seq;
    double adj_end_vol;
    double ref_vol;
    SetAdjDstSeqEnd(adj_end_seq);
    SetAdjVolVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);


    if(ref_vol > SELECTED_ADJ_DST_VOL_TOL_INI && ref_vol <= adj_end_vol)
    {
        if(pos_status == 0)
        {
            BottomChange = SELECTED_ADJ_DST_VOL * (ref_vol - ADJ_DST_SEQ_TOL_INI);
            if(Current_Sell_Seq > ADJ_DST_SEQ_TOL_INI && Current_Sell_Seq <= adj_end_seq)   
            {
                TopChange  += SELECTED_ADJ_DST_SEQ * (Current_Sell_Seq - ADJ_DST_SEQ_TOL_INI); 
            }
        }
        if(pos_status == 1)
        {
            TopChange = SELECTED_ADJ_DST_VOL * (ref_vol - ADJ_DST_SEQ_TOL_INI); 
            if(Current_Buy_Seq > ADJ_DST_SEQ_TOL_INI && Current_Buy_Seq <= adj_end_seq)
            {
                BottomChange  += SELECTED_ADJ_DST_SEQ * (Current_Buy_Seq - ADJ_DST_SEQ_TOL_INI);
            }            
        }
    }
}
void EstENOrerDst_02()
{
    /*
        Faz o mesmo que o 13 mas soma a sequência com o volume para o mesmo lado
    */

    //double adj_end_seq;
    double adj_end_vol;
    double ref_vol;
    //SetAdjDstSeqEnd(adj_end_seq);
    SetAdjVolVolEnd(adj_end_vol);
    GetCurrentPositionVolume(ref_vol);



    if(ref_vol > ADJ_DST_SEQ_TOL_INI && ref_vol <= adj_end_vol)
    {
        if(pos_status == 0)
        {
            BottomChange += SELECTED_ADJ_DST_VOL * (ref_vol - ADJ_DST_SEQ_TOL_INI);   
        }
        if(pos_status == 1)
        {
            TopChange += SELECTED_ADJ_DST_VOL * (ref_vol - ADJ_DST_SEQ_TOL_INI); 
        }
    }

    EstENOrerDst_10();
          

}
