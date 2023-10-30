//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: _coder_VMyfVoJrTg_fun_mex.cpp
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 27-Oct-2023 11:24:57
//

// Include Files
#include "_coder_VMyfVoJrTg_fun_mex.h"
#include "_coder_VMyfVoJrTg_fun_api.h"

// Function Definitions
//
// Arguments    : int32_T nlhs
//                mxArray *plhs[]
//                int32_T nrhs
//                const mxArray *prhs[]
// Return Type  : void
//
void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
                 const mxArray *prhs[])
{
  mexAtExit(&VMyfVoJrTg_fun_atexit);
  // Module initialization.
  VMyfVoJrTg_fun_initialize();
  // Dispatch the entry-point.
  unsafe_VMyfVoJrTg_fun_mexFunction(nlhs, plhs, nrhs, prhs);
  // Module termination.
  VMyfVoJrTg_fun_terminate();
}

//
// Arguments    : void
// Return Type  : emlrtCTX
//
emlrtCTX mexFunctionCreateRootTLS()
{
  emlrtCreateRootTLSR2022a(&emlrtRootTLSGlobal, &emlrtContextGlobal, nullptr, 1,
                           nullptr, "UTF-8", true);
  return emlrtRootTLSGlobal;
}

//
// Arguments    : int32_T nlhs
//                mxArray *plhs[2]
//                int32_T nrhs
//                const mxArray *prhs[5]
// Return Type  : void
//
void unsafe_VMyfVoJrTg_fun_mexFunction(int32_T nlhs, mxArray *plhs[2],
                                       int32_T nrhs, const mxArray *prhs[5])
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  const mxArray *b_prhs[5];
  const mxArray *outputs[2];
  int32_T i1;
  st.tls = emlrtRootTLSGlobal;
  // Check for proper number of arguments.
  if (nrhs != 5) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:WrongNumberOfInputs", 5, 12, 5, 4,
                        14, "VMyfVoJrTg_fun");
  }
  if (nlhs > 2) {
    emlrtErrMsgIdAndTxt(&st, "EMLRT:runTime:TooManyOutputArguments", 3, 4, 14,
                        "VMyfVoJrTg_fun");
  }
  // Call the function.
  for (int32_T i{0}; i < 5; i++) {
    b_prhs[i] = prhs[i];
  }
  VMyfVoJrTg_fun_api(b_prhs, nlhs, outputs);
  // Copy over outputs to the caller.
  if (nlhs < 1) {
    i1 = 1;
  } else {
    i1 = nlhs;
  }
  emlrtReturnArrays(i1, &plhs[0], &outputs[0]);
}

//
// File trailer for _coder_VMyfVoJrTg_fun_mex.cpp
//
// [EOF]
//
