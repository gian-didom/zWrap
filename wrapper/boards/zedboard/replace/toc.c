#include "xtime_l.h"
#include "toc.h"

double toc(double tstart_tv_sec)
{
  XTime tEnd;
  XTime_GetTime(&tEnd);
  return ((double) tEnd)/ (double)(COUNTS_PER_SECOND) * 1.0 - tstart_tv_sec;
}
