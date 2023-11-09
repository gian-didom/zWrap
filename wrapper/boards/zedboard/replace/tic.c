#include "xtime_l.h"
#include "tic.h"

void tic(double *tstart_tv_sec)
{
  XTime tStart;
  XTime_GetTime(&tStart);
  *tstart_tv_sec = ((double) tStart)/((double) COUNTS_PER_SECOND) * 1.0;
  return;
}
