//
// Prerelease License - for engineering feedback and testing purposes
// only. Not for sale.
// File: variableSine.cpp
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 27-Jul-2023 14:38:44
//

// Include Files
#include "variableSine.h"
#include <cmath>

// Function Definitions
//
// UNTITLED Summary of this function goes here
//    Detailed explanation goes here
//
// Arguments    : double omega
//                double t
//                double *result
//                double *success
// Return Type  : void
//
void variableSine(double omega, double t, double *result, double *success)
{
  *result = std::sin(omega * t);
  *success = 1.0;
}

//
// File trailer for variableSine.cpp
//
// [EOF]
//
