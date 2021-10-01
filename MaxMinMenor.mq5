//+------------------------------------------------------------------+
//|                                                    Dunningan.mq5 |
//|                                                alexsanderCardoso |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "alexsanderCardoso"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2
//--- plot Venda
#property indicator_label1  "Venda"
#property indicator_type1   DRAW_ARROW
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1
//--- plot Compra
#property indicator_label2  "Compra"
#property indicator_type2   DRAW_ARROW
#property indicator_color2  clrGreen
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

//--- input parameters
input int      Input1;

//--- indicator buffers
double         VendaBuffer[];
double         CompraBuffer[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,VendaBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,CompraBuffer,INDICATOR_DATA);
   
   PlotIndexSetInteger(0,PLOT_ARROW,234);
   PlotIndexSetInteger(1,PLOT_ARROW,233);
   
   PlotIndexSetInteger(0,PLOT_ARROW_SHIFT,-10);
   PlotIndexSetInteger(1,PLOT_ARROW_SHIFT,10);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
   for(int i=MathMax(1,prev_calculated-1);i<rates_total;i++)
     {
         if(low[i] < low[i-1] && high[i] < high[i-1])
           {
             VendaBuffer[i] = high[i];
           }
          else
            {
             VendaBuffer[i] = 0;
            }
            
          if(low[i] > low[i-1] && high[i] > high[i-1])
           {
             CompraBuffer[i] = low[i];
           }
          else
            {
             CompraBuffer[i] = 0;
            }
     }
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
