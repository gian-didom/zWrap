//
// Academic License - for use in teaching, academic research, and meeting
// course requirements at degree granting institutions only.  Not for
// government, commercial, or other organizational use.
// File: _coder_VMyfVoJrTg_fun_api.cpp
//
// MATLAB Coder version            : 23.2
// C/C++ source code generated on  : 27-Oct-2023 11:24:57
//

// Include Files
#include "_coder_VMyfVoJrTg_fun_api.h"
#include "_coder_VMyfVoJrTg_fun_mex.h"

// Variable Definitions
emlrtCTX emlrtRootTLSGlobal{nullptr};

emlrtContext emlrtContextGlobal{
    true,                                                 // bFirstTime
    false,                                                // bInitialized
    131643U,                                              // fVersionInfo
    nullptr,                                              // fErrorFunction
    "VMyfVoJrTg_fun",                                     // fFunctionName
    nullptr,                                              // fRTCallStack
    false,                                                // bDebugMode
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, // fSigWrd
    nullptr                                               // fSigMem
};

// Function Declarations
static void b_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[201168]);

static void c_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[758016]);

static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int32_T y[700672]);

static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[698611]);

static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y[498732]);

static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[695970]);

static int32_T d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int64_T ret[82308]);

static int64_T (*d_emlrt_marshallIn(const emlrtStack &sp,
                                    const mxArray *b_nullptr,
                                    const char_T *identifier))[557760];

static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[339300]);

static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[747075]);

static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int32_T ret[363528]);

static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y[181440]);

static int64_T e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             int64_T y[82308]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, cell_0 &y);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId, cell_0 &y);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real_T y[747075]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             char_T y[806075]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, char_T y[806075]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             int32_T y[363528]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             struct0_T y[24]);

static real_T emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId);

static real_T emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                               const char_T *identifier);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T y[396900]);

static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, struct0_T y[24]);

static const mxArray *emlrt_marshallOut(const real_T u);

static int64_T (
    *f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                        const emlrtMsgIdentifier *parentId))[557760];

static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[806075]);

static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[695970]);

static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int32_T ret[700672]);

static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[41472]);

static boolean_T g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[498732]);

static void g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[436800]);

static void h_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[916548]);

static char_T i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[396900]);

static void i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[181440]);

static void j_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[698611]);

static real32_T j_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId);

static void k_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[339300]);

static real_T k_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static void l_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[201168]);

static void m_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[758016]);

static void n_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[41472]);

static int32_T n_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static void o_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[436800]);

static int64_T o_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static int64_T (*p_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[557760];

static boolean_T q_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId);

static void r_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[916548]);

static char_T s_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId);

static real32_T t_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

// Function Definitions
//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                boolean_T y[201168]
// Return Type  : void
//
static void b_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[201168])
{
  l_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                boolean_T y[758016]
// Return Type  : void
//
static void c_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[758016])
{
  m_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *b_nullptr
//                const char_T *identifier
// Return Type  : int64_T (*)[557760]
//
static int64_T (*d_emlrt_marshallIn(const emlrtStack &sp,
                                    const mxArray *b_nullptr,
                                    const char_T *identifier))[557760]
{
  emlrtMsgIdentifier thisId;
  int64_T(*y)[557760];
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = f_emlrt_marshallIn(sp, emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                int32_T y[700672]
// Return Type  : void
//
static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int32_T y[700672])
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real32_T y[698611]
// Return Type  : void
//
static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[698611])
{
  j_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                int64_T ret[82308]
// Return Type  : void
//
static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int64_T ret[82308])
{
  static const int32_T dims[3]{76, 57, 19};
  int64_T(*r)[82308];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int64", false, 3U,
                          (const void *)&dims[0]);
  r = (int64_T(*)[82308])emlrtMxGetData(src);
  for (int32_T i{0}; i < 82308; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : int32_T
//
static int32_T d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  int32_T y;
  y = n_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                char_T y[498732]
// Return Type  : void
//
static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y[498732])
{
  g_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real_T y[695970]
// Return Type  : void
//
static void d_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y[695970])
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                int32_T ret[363528]
// Return Type  : void
//
static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int32_T ret[363528])
{
  static const int32_T dims[4]{51, 9, 36, 22};
  int32_T(*r)[363528];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int32", false, 4U,
                          (const void *)&dims[0]);
  r = (int32_T(*)[363528])emlrtMxGetData(src);
  for (int32_T i{0}; i < 363528; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real32_T y[339300]
// Return Type  : void
//
static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[339300])
{
  k_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real_T ret[747075]
// Return Type  : void
//
static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[747075])
{
  static const int32_T dims[2]{175, 4269};
  real_T(*r)[747075];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "double", false, 2U,
                          (const void *)&dims[0]);
  r = (real_T(*)[747075])emlrtMxGetData(src);
  for (int32_T i{0}; i < 747075; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : int64_T
//
static int64_T e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  int64_T y;
  y = o_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                char_T y[181440]
// Return Type  : void
//
static void e_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y[181440])
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                char_T y[806075]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             char_T y[806075])
{
  f_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *b_nullptr
//                const char_T *identifier
//                char_T y[806075]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, char_T y[806075])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : real_T
//
static real_T emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = k_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *b_nullptr
//                const char_T *identifier
// Return Type  : real_T
//
static real_T emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                               const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  y = emlrt_marshallIn(sp, emlrtAlias(b_nullptr), &thisId);
  emlrtDestroyArray(&b_nullptr);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *b_nullptr
//                const char_T *identifier
//                struct0_T y[24]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, struct0_T y[24])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                struct0_T y[24]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             struct0_T y[24])
{
  static const int32_T dims[4]{6, 1, 1, 4};
  static const char_T *fieldNames[8]{"AlGyAsIvgK", "zZyADJpHqO", "BlXEngBqzH",
                                     "CdCkoejhss", "XeNerqszEk", "PkgsAAScKP",
                                     "DTVMSPoGbh", "fRrRenWmpF"};
  emlrtMsgIdentifier thisId;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b((emlrtConstCTX)&sp, parentId, u, 8,
                         (const char_T **)&fieldNames[0], 4U,
                         (const void *)&dims[0]);
  for (int32_T i{0}; i < 24; i++) {
    thisId.fIdentifier = "AlGyAsIvgK";
    emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u, i, 0,
                                                    "AlGyAsIvgK")),
                     &thisId, y[i].AlGyAsIvgK);
    thisId.fIdentifier = "zZyADJpHqO";
    b_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u, i,
                                                      1, "zZyADJpHqO")),
                       &thisId, y[i].zZyADJpHqO);
    thisId.fIdentifier = "BlXEngBqzH";
    c_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u, i,
                                                      2, "BlXEngBqzH")),
                       &thisId, y[i].BlXEngBqzH);
    thisId.fIdentifier = "CdCkoejhss";
    y[i].CdCkoejhss =
        d_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u,
                                                          i, 3, "CdCkoejhss")),
                           &thisId);
    thisId.fIdentifier = "XeNerqszEk";
    emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u, i, 4,
                                                    "XeNerqszEk")),
                     &thisId, y[i].XeNerqszEk);
    thisId.fIdentifier = "PkgsAAScKP";
    y[i].PkgsAAScKP =
        e_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u,
                                                          i, 5, "PkgsAAScKP")),
                           &thisId);
    thisId.fIdentifier = "DTVMSPoGbh";
    emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u, i, 6,
                                                    "DTVMSPoGbh")),
                     &thisId, y[i].DTVMSPoGbh);
    thisId.fIdentifier = "fRrRenWmpF";
    y[i].fRrRenWmpF =
        d_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)&sp, u,
                                                          i, 7, "fRrRenWmpF")),
                           &thisId);
  }
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                int32_T y[363528]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             int32_T y[363528])
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real_T y[747075]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real_T y[747075])
{
  e_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                int64_T y[82308]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             int64_T y[82308])
{
  d_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *b_nullptr
//                const char_T *identifier
//                cell_0 &y
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *b_nullptr,
                             const char_T *identifier, cell_0 &y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = const_cast<const char_T *>(identifier);
  thisId.fParent = nullptr;
  thisId.bParentIsCell = false;
  emlrt_marshallIn(sp, emlrtAlias(b_nullptr), &thisId, y);
  emlrtDestroyArray(&b_nullptr);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                cell_0 &y
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId, cell_0 &y)
{
  static const int32_T iv[4]{10, 1, 1, 2};
  emlrtMsgIdentifier thisId;
  boolean_T bv[4];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  bv[1] = false;
  bv[2] = false;
  bv[3] = false;
  emlrtCheckCell((emlrtCTX)&sp, parentId, u, 4U, (void *)&iv[0], &bv[0]);
  thisId.fIdentifier = "1";
  y.f1 = g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 0)), &thisId);
  thisId.fIdentifier = "2";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 1)),
                     &thisId, y.f2);
  thisId.fIdentifier = "3";
  y.f3 = e_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 2)), &thisId);
  thisId.fIdentifier = "4";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 3)),
                     &thisId, y.f4);
  thisId.fIdentifier = "5";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 4)),
                     &thisId, y.f5);
  thisId.fIdentifier = "6";
  h_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 5)),
                     &thisId, y.f6);
  thisId.fIdentifier = "7";
  emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 6)),
                   &thisId, y.f7);
  thisId.fIdentifier = "8";
  y.f8 = g_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 7)), &thisId);
  thisId.fIdentifier = "9";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 8)),
                     &thisId, y.f9);
  thisId.fIdentifier = "10";
  y.f10 = i_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 9)), &thisId);
  thisId.fIdentifier = "11";
  e_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 10)),
                     &thisId, y.f11);
  thisId.fIdentifier = "12";
  f_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 11)),
                     &thisId, y.f12);
  thisId.fIdentifier = "13";
  d_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 12)),
                     &thisId, y.f13);
  thisId.fIdentifier = "14";
  g_emlrt_marshallIn(sp,
                     emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 13)),
                     &thisId, y.f14);
  thisId.fIdentifier = "15";
  y.f15 = i_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 14)), &thisId);
  thisId.fIdentifier = "16";
  y.f16 = d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 15)), &thisId);
  thisId.fIdentifier = "17";
  y.f17 = d_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 16)), &thisId);
  thisId.fIdentifier = "18";
  y.f18 = j_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 17)), &thisId);
  thisId.fIdentifier = "19";
  y.f19 = j_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 18)), &thisId);
  thisId.fIdentifier = "20";
  y.f20 = i_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)&sp, parentId, u, 19)), &thisId);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real32_T y[396900]
// Return Type  : void
//
static void emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                             const emlrtMsgIdentifier *parentId,
                             real32_T y[396900])
{
  i_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const real_T u
// Return Type  : const mxArray *
//
static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = nullptr;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real_T ret[695970]
// Return Type  : void
//
static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real_T ret[695970])
{
  static const int32_T dims[4]{15, 37, 114, 11};
  real_T(*r)[695970];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "double", false, 4U,
                          (const void *)&dims[0]);
  r = (real_T(*)[695970])emlrtMxGetData(src);
  for (int32_T i{0}; i < 695970; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                char_T ret[806075]
// Return Type  : void
//
static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[806075])
{
  static const int32_T dims[2]{1697, 475};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "char", false, 2U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b((emlrtConstCTX)&sp, src, &ret[0], 806075);
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real32_T y[41472]
// Return Type  : void
//
static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[41472])
{
  n_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                int32_T ret[700672]
// Return Type  : void
//
static void f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               int32_T ret[700672])
{
  static const int32_T dims[3]{23, 448, 68};
  int32_T(*r)[700672];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int32", false, 3U,
                          (const void *)&dims[0]);
  r = (int32_T(*)[700672])emlrtMxGetData(src);
  for (int32_T i{0}; i < 700672; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : int64_T (*)[557760]
//
static int64_T (*f_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[557760]
{
  int64_T(*y)[557760];
  y = p_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : boolean_T
//
static boolean_T g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = q_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                real32_T y[436800]
// Return Type  : void
//
static void g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y[436800])
{
  o_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                char_T ret[498732]
// Return Type  : void
//
static void g_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[498732])
{
  static const int32_T dims[3]{46, 139, 78};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "char", false, 3U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b((emlrtConstCTX)&sp, src, &ret[0], 498732);
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
//                boolean_T y[916548]
// Return Type  : void
//
static void h_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y[916548])
{
  r_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y);
  emlrtDestroyArray(&u);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                char_T ret[181440]
// Return Type  : void
//
static void i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               char_T ret[181440])
{
  static const int32_T dims[4]{4, 63, 40, 18};
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "char", false, 4U,
                          (const void *)&dims[0]);
  emlrtImportCharArrayR2015b((emlrtConstCTX)&sp, src, &ret[0], 181440);
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real32_T ret[396900]
// Return Type  : void
//
static void i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[396900])
{
  static const int32_T dims[5]{2, 49, 15, 10, 27};
  real32_T(*r)[396900];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 5U,
                          (const void *)&dims[0]);
  r = (real32_T(*)[396900])emlrtMxGetData(src);
  for (int32_T i{0}; i < 396900; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : char_T
//
static char_T i_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  char_T y;
  y = s_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real32_T ret[698611]
// Return Type  : void
//
static void j_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[698611])
{
  static const int32_T dims[3]{19, 83, 443};
  real32_T(*r)[698611];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 3U,
                          (const void *)&dims[0]);
  r = (real32_T(*)[698611])emlrtMxGetData(src);
  for (int32_T i{0}; i < 698611; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *u
//                const emlrtMsgIdentifier *parentId
// Return Type  : real32_T
//
static real32_T j_emlrt_marshallIn(const emlrtStack &sp, const mxArray *u,
                                   const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = t_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real32_T ret[339300]
// Return Type  : void
//
static void k_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[339300])
{
  static const int32_T dims[3]{450, 2, 377};
  real32_T(*r)[339300];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 3U,
                          (const void *)&dims[0]);
  r = (real32_T(*)[339300])emlrtMxGetData(src);
  for (int32_T i{0}; i < 339300; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : real_T
//
static real_T k_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<real_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                boolean_T ret[201168]
// Return Type  : void
//
static void l_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[201168])
{
  static const int32_T dims[4]{2, 66, 508, 3};
  boolean_T(*r)[201168];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "logical", false, 4U,
                          (const void *)&dims[0]);
  r = (boolean_T(*)[201168])emlrtMxGetLogicals(src);
  for (int32_T i{0}; i < 201168; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                boolean_T ret[758016]
// Return Type  : void
//
static void m_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[758016])
{
  static const int32_T dims[4]{8, 12, 21, 376};
  boolean_T(*r)[758016];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "logical", false, 4U,
                          (const void *)&dims[0]);
  r = (boolean_T(*)[758016])emlrtMxGetLogicals(src);
  for (int32_T i{0}; i < 758016; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : int32_T
//
static int32_T n_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  int32_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int32", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<int32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real32_T ret[41472]
// Return Type  : void
//
static void n_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[41472])
{
  static const int32_T dims[2]{9, 4608};
  real32_T(*r)[41472];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 2U,
                          (const void *)&dims[0]);
  r = (real32_T(*)[41472])emlrtMxGetData(src);
  for (int32_T i{0}; i < 41472; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : int64_T
//
static int64_T o_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  int64_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int64", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<int64_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                real32_T ret[436800]
// Return Type  : void
//
static void o_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               real32_T ret[436800])
{
  static const int32_T dims[3]{7, 624, 100};
  real32_T(*r)[436800];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 3U,
                          (const void *)&dims[0]);
  r = (real32_T(*)[436800])emlrtMxGetData(src);
  for (int32_T i{0}; i < 436800; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : int64_T (*)[557760]
//
static int64_T (*p_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId))[557760]
{
  static const int32_T dims[3]{2, 224, 1245};
  int64_T(*ret)[557760];
  int32_T iv[3];
  boolean_T bv[3]{false, false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "int64", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (int64_T(*)[557760])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : boolean_T
//
static boolean_T q_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  boolean_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
//                boolean_T ret[916548]
// Return Type  : void
//
static void r_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                               const emlrtMsgIdentifier *msgId,
                               boolean_T ret[916548])
{
  static const int32_T dims[2]{6, 152758};
  boolean_T(*r)[916548];
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "logical", false, 2U,
                          (const void *)&dims[0]);
  r = (boolean_T(*)[916548])emlrtMxGetLogicals(src);
  for (int32_T i{0}; i < 916548; i++) {
    ret[i] = (*r)[i];
  }
  emlrtDestroyArray(&src);
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : char_T
//
static char_T s_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                 const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  char_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "char", false, 0U,
                          (const void *)&dims);
  emlrtImportCharR2015b((emlrtCTX)&sp, src, &ret);
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const emlrtStack &sp
//                const mxArray *src
//                const emlrtMsgIdentifier *msgId
// Return Type  : real32_T
//
static real32_T t_emlrt_marshallIn(const emlrtStack &sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims{0};
  real32_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)&sp, msgId, src, "single", false, 0U,
                          (const void *)&dims);
  ret = *static_cast<real32_T *>(emlrtMxGetData(src));
  emlrtDestroyArray(&src);
  return ret;
}

//
// Arguments    : const mxArray * const prhs[5]
//                int32_T nlhs
//                const mxArray *plhs[2]
// Return Type  : void
//
void VMyfVoJrTg_fun_api(const mxArray *const prhs[5], int32_T nlhs,
                        const mxArray *plhs[2])
{
  static cell_0 JFDmJNevGZ;
  static struct0_T FieEkIcymP[24];
  static char_T eguWQhvSLY[806075];
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  int64_T(*TWgrWEqeae)[557760];
  real_T b_time;
  real_T oyvELPSlUC;
  real_T oyvELPSlUCmod;
  st.tls = emlrtRootTLSGlobal;
  // Marshall function inputs
  oyvELPSlUC = emlrt_marshallIn(st, emlrtAliasP(prhs[0]), "oyvELPSlUC");
  emlrt_marshallIn(st, emlrtAliasP(prhs[1]), "eguWQhvSLY", eguWQhvSLY);
  emlrt_marshallIn(st, emlrtAliasP(prhs[2]), "FieEkIcymP", FieEkIcymP);
  TWgrWEqeae = d_emlrt_marshallIn(st, emlrtAlias(prhs[3]), "TWgrWEqeae");
  emlrt_marshallIn(st, emlrtAliasP(prhs[4]), "JFDmJNevGZ", JFDmJNevGZ);
  // Invoke the target function
  VMyfVoJrTg_fun(oyvELPSlUC, eguWQhvSLY, FieEkIcymP, *TWgrWEqeae, &JFDmJNevGZ,
                 &oyvELPSlUCmod, &b_time);
  // Marshall function outputs
  plhs[0] = emlrt_marshallOut(oyvELPSlUCmod);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(b_time);
  }
}

//
// Arguments    : void
// Return Type  : void
//
void VMyfVoJrTg_fun_atexit()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  VMyfVoJrTg_fun_xil_terminate();
  VMyfVoJrTg_fun_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

//
// Arguments    : void
// Return Type  : void
//
void VMyfVoJrTg_fun_initialize()
{
  emlrtStack st{
      nullptr, // site
      nullptr, // tls
      nullptr  // prev
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, nullptr);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

//
// Arguments    : void
// Return Type  : void
//
void VMyfVoJrTg_fun_terminate()
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

//
// File trailer for _coder_VMyfVoJrTg_fun_api.cpp
//
// [EOF]
//
