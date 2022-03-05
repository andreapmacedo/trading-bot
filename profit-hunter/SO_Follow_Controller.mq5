#include "SO_Spread.mq5"

void SO_Follow_Controller(int callFrom)
{
  int response = 0;
  switch(SELECTED_VER) // Version
  {                                                           
    case 1:
      if(SELECTED_EN_MODE == 1) {
        response = Sys_Spread_v1(callFrom); 
      } else {
        // response = Sys_Spread_v2(callFrom); 
      }
      break;                                                                                                                                                                                   
  }

}
