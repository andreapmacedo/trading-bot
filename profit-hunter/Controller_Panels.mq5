//#include "Panel_01.mq5"
//#include "Panel_Client.mq5"
#include "Panel_Full.mq5"


void PanelController()
{	
    CreatePanels();
}


void CreatePanels()
{

    //int pnl_01 = CreatePanel_01();
    //int pnl_02 = CreatePanel_Client();
    int pnl_full = CreatePanel_Full();



}



void RemoveAllPanels()
{

    //RemovePanel_01();
    //RemovePanel_CLient();
    RemovePanel_Full();

}