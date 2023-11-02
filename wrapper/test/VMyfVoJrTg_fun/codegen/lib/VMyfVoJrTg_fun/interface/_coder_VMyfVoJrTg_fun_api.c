/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: _coder_VMyfVoJrTg_fun_api.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 02-Nov-2023 11:00:55
 */

/* Include Files */
#include "_coder_VMyfVoJrTg_fun_api.h"
#include "_coder_VMyfVoJrTg_fun_mex.h"

/* Type Definitions */
#ifndef typedef_emxArray_struct0_T_6x1x1x4
#define typedef_emxArray_struct0_T_6x1x1x4
typedef struct {
  struct0_T data[24];
  int32_T size[4];
} emxArray_struct0_T_6x1x1x4;
#endif /* typedef_emxArray_struct0_T_6x1x1x4 */

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;

emlrtContext emlrtContextGlobal = {
    true,                                                 /* bFirstTime */
    false,                                                /* bInitialized */
    131643U,                                              /* fVersionInfo */
    NULL,                                                 /* fErrorFunction */
    "VMyfVoJrTg_fun",                                     /* fFunctionName */
    NULL,                                                 /* fRTCallStack */
    false,                                                /* bDebugMode */
    {2045744189U, 2170104910U, 2743257031U, 4284093946U}, /* fSigWrd */
    NULL                                                  /* fSigMem */
};

/* Function Declarations */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3]);

static void ac_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int32_T ret_data[], int32_T ret_size[3]);

static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3]);

static void bc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3]);

static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, char_T y_data[],
                               int32_T y_size[2]);

static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                int32_T y_data[], int32_T y_size[3]);

static real32_T cc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId);

static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[2]);

static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3]);

static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct0_T y_data[],
                               int32_T y_size[4]);

static real32_T eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier);

static const mxArray *emlrt_marshallOut(const real_T u);

static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T y_data[], int32_T y_size[4]);

static real_T fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int32_T y_data[], int32_T y_size[5]);

static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[2]);

static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[4]);

static void hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int32_T ret_data[], int32_T ret_size[5]);

static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[4]);

static void ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[4]);

static int32_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static void jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[4]);

static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y_data[], int32_T y_size[2]);

static int32_T kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static int64_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId);

static void lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret_data[], int32_T ret_size[2]);

static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int64_T y_data[], int32_T y_size[3]);

static int64_T mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId);

static int64_T (*n_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[557760];

static void nb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int64_T ret_data[], int32_T ret_size[3]);

static int64_T (
    *o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                        const emlrtMsgIdentifier *parentId))[557760];

static int64_T (*ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[557760];

static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, cell_0 *y);

static boolean_T pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId);

static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, cell_0 *y);

static void qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret_data[], int32_T ret_size[4]);

static boolean_T r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId);

static void rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[3]);

static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y_data[], int32_T y_size[4]);

static void sb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[5]);

static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[3]);

static void tb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[2]);

static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[5]);

static void ub_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[5]);

static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[2]);

static void vb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3]);

static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y_data[], int32_T y_size[5]);

static char_T wb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId);

static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y_data[], int32_T y_size[3]);

static void xb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3]);

static char_T y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId);

static void yb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3]);

/* Function Definitions */
/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void ab_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3])
{
  xb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                int32_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void ac_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int32_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {23, 448, 68};
  int32_T iv[3];
  boolean_T bv[3] = {true, true, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int32", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real_T
 */
static real_T b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = fb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void bb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3])
{
  yb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void bc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {7, 624, 100};
  int32_T iv[3];
  boolean_T bv[3] = {true, true, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                char_T y_data[]
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, char_T y_data[],
                               int32_T y_size[2])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  d_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y_data, y_size);
  emlrtDestroyArray(&nullptr);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                int32_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void cb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                int32_T y_data[], int32_T y_size[3])
{
  ac_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real32_T
 */
static real32_T cc_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                    const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real32_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 0U,
                          (const void *)&dims);
  ret = *(real32_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                char_T y_data[]
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[2])
{
  gb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void db_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                const emlrtMsgIdentifier *parentId,
                                real32_T y_data[], int32_T y_size[3])
{
  bc_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                struct0_T y_data[]
 *                int32_T y_size[4]
 * Return Type  : void
 */
static void e_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, struct0_T y_data[],
                               int32_T y_size[4])
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  f_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y_data, y_size);
  emlrtDestroyArray(&nullptr);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : real32_T
 */
static real32_T eb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  real32_T y;
  y = cc_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 * Return Type  : real_T
 */
static real_T emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier)
{
  emlrtMsgIdentifier thisId;
  real_T y;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = b_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

/*
 * Arguments    : const real_T u
 * Return Type  : const mxArray *
 */
static const mxArray *emlrt_marshallOut(const real_T u)
{
  const mxArray *m;
  const mxArray *y;
  y = NULL;
  m = emlrtCreateDoubleScalar(u);
  emlrtAssign(&y, m);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                struct0_T y_data[]
 *                int32_T y_size[4]
 * Return Type  : void
 */
static void f_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               struct0_T y_data[], int32_T y_size[4])
{
  static const int32_T dims[4] = {6, 1, 1, 4};
  static const char_T *fieldNames[8] = {
      "AlGyAsIvgK", "zZyADJpHqO", "BlXEngBqzH", "CdCkoejhss",
      "XeNerqszEk", "PkgsAAScKP", "DTVMSPoGbh", "fRrRenWmpF"};
  emlrtMsgIdentifier thisId;
  int32_T sizes[4];
  int32_T i;
  int32_T n;
  boolean_T bv[4] = {false, true, true, false};
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckVsStructR2012b((emlrtCTX)sp, parentId, u, 8,
                           (const char_T **)&fieldNames[0], 4U,
                           (const void *)&dims[0], &bv[0], &sizes[0]);
  y_size[0] = sizes[0];
  y_size[1] = sizes[1];
  y_size[2] = sizes[2];
  y_size[3] = sizes[3];
  n = 6 * (sizes[1] * (sizes[2] << 2));
  for (i = 0; i < n; i++) {
    thisId.fIdentifier = "AlGyAsIvgK";
    g_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, i,
                                                      0, "AlGyAsIvgK")),
                       &thisId, y_data[i].AlGyAsIvgK.data,
                       y_data[i].AlGyAsIvgK.size);
    thisId.fIdentifier = "zZyADJpHqO";
    h_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, i,
                                                      1, "zZyADJpHqO")),
                       &thisId, y_data[i].zZyADJpHqO.data,
                       y_data[i].zZyADJpHqO.size);
    thisId.fIdentifier = "BlXEngBqzH";
    i_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, i,
                                                      2, "BlXEngBqzH")),
                       &thisId, y_data[i].BlXEngBqzH.data,
                       y_data[i].BlXEngBqzH.size);
    thisId.fIdentifier = "CdCkoejhss";
    y_data[i].CdCkoejhss =
        j_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u,
                                                          i, 3, "CdCkoejhss")),
                           &thisId);
    thisId.fIdentifier = "XeNerqszEk";
    k_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, i,
                                                      4, "XeNerqszEk")),
                       &thisId, y_data[i].XeNerqszEk.data,
                       y_data[i].XeNerqszEk.size);
    thisId.fIdentifier = "PkgsAAScKP";
    y_data[i].PkgsAAScKP =
        l_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u,
                                                          i, 5, "PkgsAAScKP")),
                           &thisId);
    thisId.fIdentifier = "DTVMSPoGbh";
    m_emlrt_marshallIn(sp,
                       emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u, i,
                                                      6, "DTVMSPoGbh")),
                       &thisId, y_data[i].DTVMSPoGbh.data,
                       y_data[i].DTVMSPoGbh.size);
    thisId.fIdentifier = "fRrRenWmpF";
    y_data[i].fRrRenWmpF =
        j_emlrt_marshallIn(sp,
                           emlrtAlias(emlrtGetFieldR2017b((emlrtConstCTX)sp, u,
                                                          i, 7, "fRrRenWmpF")),
                           &thisId);
  }
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : real_T
 */
static real_T fb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  real_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 0U,
                          (const void *)&dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                int32_T y_data[]
 *                int32_T y_size[5]
 * Return Type  : void
 */
static void g_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int32_T y_data[], int32_T y_size[5])
{
  hb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                char_T ret_data[]
 *                int32_T ret_size[2]
 * Return Type  : void
 */
static void gb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[2])
{
  static const int32_T dims[2] = {1697, 475};
  int32_T iv[2];
  boolean_T bv[2] = {true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                boolean_T y_data[]
 *                int32_T y_size[4]
 * Return Type  : void
 */
static void h_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[4])
{
  ib_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                int32_T ret_data[]
 *                int32_T ret_size[5]
 * Return Type  : void
 */
static void hb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int32_T ret_data[], int32_T ret_size[5])
{
  static const int32_T dims[5] = {51, 9, 36, 22, 1};
  int32_T iv[5];
  boolean_T bv[5] = {false, true, true, true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int32", false, 5U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  ret_size[4] = iv[4];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                boolean_T y_data[]
 *                int32_T y_size[4]
 * Return Type  : void
 */
static void i_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[4])
{
  jb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                boolean_T ret_data[]
 *                int32_T ret_size[4]
 * Return Type  : void
 */
static void ib_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[4])
{
  static const int32_T dims[4] = {2, 66, 508, 3};
  int32_T iv[4];
  boolean_T bv[4] = {true, false, true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 4U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : int32_T
 */
static int32_T j_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  int32_T y;
  y = kb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                boolean_T ret_data[]
 *                int32_T ret_size[4]
 * Return Type  : void
 */
static void jb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[4])
{
  static const int32_T dims[4] = {8, 12, 21, 376};
  int32_T iv[4];
  boolean_T bv[4] = {false, true, false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 4U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y_data[]
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void k_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y_data[], int32_T y_size[2])
{
  lb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : int32_T
 */
static int32_T kb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  int32_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int32", false, 0U,
                          (const void *)&dims);
  ret = *(int32_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : int64_T
 */
static int64_T l_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                  const emlrtMsgIdentifier *parentId)
{
  int64_T y;
  y = mb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret_data[]
 *                int32_T ret_size[2]
 * Return Type  : void
 */
static void lb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret_data[], int32_T ret_size[2])
{
  static const int32_T dims[2] = {175, 4269};
  int32_T iv[2];
  boolean_T bv[2] = {true, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 8, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                int64_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void m_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               int64_T y_data[], int32_T y_size[3])
{
  nb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : int64_T
 */
static int64_T mb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                   const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  int64_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int64", false, 0U,
                          (const void *)&dims);
  ret = *(int64_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 * Return Type  : int64_T (*)[557760]
 */
static int64_T (*n_emlrt_marshallIn(const emlrtStack *sp,
                                    const mxArray *nullptr,
                                    const char_T *identifier))[557760]
{
  emlrtMsgIdentifier thisId;
  int64_T(*y)[557760];
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  y = o_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId);
  emlrtDestroyArray(&nullptr);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                int64_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void nb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                int64_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {76, 57, 19};
  int32_T iv[3];
  boolean_T bv[3] = {true, false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int64", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 8, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : int64_T (*)[557760]
 */
static int64_T (*o_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId))[557760]
{
  int64_T(*y)[557760];
  y = ob_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : int64_T (*)[557760]
 */
static int64_T (*ob_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId))[557760]
{
  static const int32_T dims[3] = {2, 224, 1245};
  int64_T(*ret)[557760];
  int32_T iv[3];
  boolean_T bv[3] = {false, false, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "int64", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret = (int64_T(*)[557760])emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *nullptr
 *                const char_T *identifier
 *                cell_0 *y
 * Return Type  : void
 */
static void p_emlrt_marshallIn(const emlrtStack *sp, const mxArray *nullptr,
                               const char_T *identifier, cell_0 *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char_T *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  q_emlrt_marshallIn(sp, emlrtAlias(nullptr), &thisId, y);
  emlrtDestroyArray(&nullptr);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : boolean_T
 */
static boolean_T pb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                     const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  boolean_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 0U,
                          (const void *)&dims);
  ret = *emlrtMxGetLogicals(src);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                cell_0 *y
 * Return Type  : void
 */
static void q_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId, cell_0 *y)
{
  static const int32_T iv[4] = {10, 1, 1, 2};
  emlrtMsgIdentifier thisId;
  boolean_T bv[4];
  thisId.fParent = parentId;
  thisId.bParentIsCell = true;
  bv[0] = false;
  bv[1] = false;
  bv[2] = false;
  bv[3] = false;
  emlrtCheckCell((emlrtCTX)sp, parentId, u, 4U, (void *)&iv[0], &bv[0]);
  thisId.fIdentifier = "1";
  y->f1 = r_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 0)), &thisId);
  thisId.fIdentifier = "2";
  s_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 1)),
                     &thisId, y->f2.data, y->f2.size);
  thisId.fIdentifier = "3";
  y->f3 = l_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 2)), &thisId);
  thisId.fIdentifier = "4";
  t_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 3)),
                     &thisId, y->f4.data, y->f4.size);
  thisId.fIdentifier = "5";
  u_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 4)),
                     &thisId, y->f5.data, y->f5.size);
  thisId.fIdentifier = "6";
  v_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 5)),
                     &thisId, y->f6.data, y->f6.size);
  thisId.fIdentifier = "7";
  w_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 6)),
                     &thisId, y->f7.data, y->f7.size);
  thisId.fIdentifier = "8";
  y->f8 = r_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 7)), &thisId);
  thisId.fIdentifier = "9";
  x_emlrt_marshallIn(sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 8)),
                     &thisId, y->f9.data, y->f9.size);
  thisId.fIdentifier = "10";
  y->f10 = y_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 9)), &thisId);
  thisId.fIdentifier = "11";
  ab_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 10)),
                      &thisId, y->f11.data, y->f11.size);
  thisId.fIdentifier = "12";
  bb_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 11)),
                      &thisId, y->f12.data, y->f12.size);
  thisId.fIdentifier = "13";
  cb_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 12)),
                      &thisId, y->f13.data, y->f13.size);
  thisId.fIdentifier = "14";
  db_emlrt_marshallIn(sp,
                      emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 13)),
                      &thisId, y->f14.data, y->f14.size);
  thisId.fIdentifier = "15";
  y->f15 = y_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 14)), &thisId);
  thisId.fIdentifier = "16";
  y->f16 = j_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 15)), &thisId);
  thisId.fIdentifier = "17";
  y->f17 = j_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 16)), &thisId);
  thisId.fIdentifier = "18";
  y->f18 = eb_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 17)), &thisId);
  thisId.fIdentifier = "19";
  y->f19 = eb_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 18)), &thisId);
  thisId.fIdentifier = "20";
  y->f20 = y_emlrt_marshallIn(
      sp, emlrtAlias(emlrtGetCell((emlrtCTX)sp, parentId, u, 19)), &thisId);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real_T ret_data[]
 *                int32_T ret_size[4]
 * Return Type  : void
 */
static void qb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real_T ret_data[], int32_T ret_size[4])
{
  static const int32_T dims[4] = {15, 37, 114, 11};
  int32_T iv[4];
  boolean_T bv[4] = {true, true, false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "double", false, 4U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 8, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : boolean_T
 */
static boolean_T r_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                    const emlrtMsgIdentifier *parentId)
{
  boolean_T y;
  y = pb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                char_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void rb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {46, 139, 78};
  int32_T iv[3];
  boolean_T bv[3] = {false, true, false};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real_T y_data[]
 *                int32_T y_size[4]
 * Return Type  : void
 */
static void s_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real_T y_data[], int32_T y_size[4])
{
  qb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                char_T ret_data[]
 *                int32_T ret_size[5]
 * Return Type  : void
 */
static void sb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                char_T ret_data[], int32_T ret_size[5])
{
  static const int32_T dims[5] = {4, 63, 40, 18, 1};
  int32_T iv[5];
  boolean_T bv[5] = {true, true, false, false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 5U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  ret_size[4] = iv[4];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                char_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void t_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[3])
{
  rb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                boolean_T ret_data[]
 *                int32_T ret_size[2]
 * Return Type  : void
 */
static void tb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                boolean_T ret_data[], int32_T ret_size[2])
{
  static const int32_T dims[2] = {6, 152758};
  int32_T iv[2];
  boolean_T bv[2] = {false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "logical", false, 2U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 1, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                char_T y_data[]
 *                int32_T y_size[5]
 * Return Type  : void
 */
static void u_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               char_T y_data[], int32_T y_size[5])
{
  sb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret_data[]
 *                int32_T ret_size[5]
 * Return Type  : void
 */
static void ub_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[5])
{
  static const int32_T dims[5] = {2, 49, 15, 10, 27};
  int32_T iv[5];
  boolean_T bv[5] = {true, true, false, false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 5U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  ret_size[3] = iv[3];
  ret_size[4] = iv[4];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                boolean_T y_data[]
 *                int32_T y_size[2]
 * Return Type  : void
 */
static void v_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               boolean_T y_data[], int32_T y_size[2])
{
  tb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void vb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {19, 83, 443};
  int32_T iv[3];
  boolean_T bv[3] = {false, true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y_data[]
 *                int32_T y_size[5]
 * Return Type  : void
 */
static void w_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y_data[], int32_T y_size[5])
{
  ub_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 * Return Type  : char_T
 */
static char_T wb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                  const emlrtMsgIdentifier *msgId)
{
  static const int32_T dims = 0;
  char_T ret;
  emlrtCheckBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "char", false, 0U,
                          (const void *)&dims);
  emlrtImportCharR2015b((emlrtCTX)sp, src, &ret);
  emlrtDestroyArray(&src);
  return ret;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 *                real32_T y_data[]
 *                int32_T y_size[3]
 * Return Type  : void
 */
static void x_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                               const emlrtMsgIdentifier *parentId,
                               real32_T y_data[], int32_T y_size[3])
{
  vb_emlrt_marshallIn(sp, emlrtAlias(u), parentId, y_data, y_size);
  emlrtDestroyArray(&u);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void xb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {450, 2, 377};
  int32_T iv[3];
  boolean_T bv[3] = {false, false, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *u
 *                const emlrtMsgIdentifier *parentId
 * Return Type  : char_T
 */
static char_T y_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u,
                                 const emlrtMsgIdentifier *parentId)
{
  char_T y;
  y = wb_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

/*
 * Arguments    : const emlrtStack *sp
 *                const mxArray *src
 *                const emlrtMsgIdentifier *msgId
 *                real32_T ret_data[]
 *                int32_T ret_size[3]
 * Return Type  : void
 */
static void yb_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src,
                                const emlrtMsgIdentifier *msgId,
                                real32_T ret_data[], int32_T ret_size[3])
{
  static const int32_T dims[3] = {9, 4608, 1};
  int32_T iv[3];
  boolean_T bv[3] = {false, true, true};
  emlrtCheckVsBuiltInR2012b((emlrtConstCTX)sp, msgId, src, "single", false, 3U,
                            (const void *)&dims[0], &bv[0], &iv[0]);
  ret_size[0] = iv[0];
  ret_size[1] = iv[1];
  ret_size[2] = iv[2];
  emlrtImportArrayR2015b((emlrtConstCTX)sp, src, &ret_data[0], 4, false);
  emlrtDestroyArray(&src);
}

/*
 * Arguments    : const mxArray * const prhs[5]
 *                int32_T nlhs
 *                const mxArray *plhs[2]
 * Return Type  : void
 */
void VMyfVoJrTg_fun_api(const mxArray *const prhs[5], int32_T nlhs,
                        const mxArray *plhs[2])
{
  static cell_0 JFDmJNevGZ;
  static emxArray_struct0_T_6x1x1x4 FieEkIcymP;
  static char_T eguWQhvSLY_data[806075];
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  int64_T(*TWgrWEqeae)[557760];
  real_T b_time;
  real_T oyvELPSlUC;
  real_T oyvELPSlUCmod;
  int32_T b_FieEkIcymP[4];
  int32_T eguWQhvSLY_size[2];
  st.tls = emlrtRootTLSGlobal;
  /* Marshall function inputs */
  oyvELPSlUC = emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "oyvELPSlUC");
  c_emlrt_marshallIn(&st, emlrtAliasP(prhs[1]), "eguWQhvSLY", eguWQhvSLY_data,
                     eguWQhvSLY_size);
  e_emlrt_marshallIn(&st, emlrtAliasP(prhs[2]), "FieEkIcymP", FieEkIcymP.data,
                     FieEkIcymP.size);
  TWgrWEqeae = n_emlrt_marshallIn(&st, emlrtAlias(prhs[3]), "TWgrWEqeae");
  p_emlrt_marshallIn(&st, emlrtAliasP(prhs[4]), "JFDmJNevGZ", &JFDmJNevGZ);
  /* Invoke the target function */
  b_FieEkIcymP[0] = FieEkIcymP.size[0];
  b_FieEkIcymP[1] = FieEkIcymP.size[1];
  b_FieEkIcymP[2] = FieEkIcymP.size[2];
  b_FieEkIcymP[3] = FieEkIcymP.size[3];
  VMyfVoJrTg_fun(oyvELPSlUC, eguWQhvSLY_data, eguWQhvSLY_size, FieEkIcymP.data,
                 b_FieEkIcymP, *TWgrWEqeae, &JFDmJNevGZ, &oyvELPSlUCmod,
                 &b_time);
  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(oyvELPSlUCmod);
  if (nlhs > 1) {
    plhs[1] = emlrt_marshallOut(b_time);
  }
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void VMyfVoJrTg_fun_atexit(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  VMyfVoJrTg_fun_xil_terminate();
  VMyfVoJrTg_fun_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void VMyfVoJrTg_fun_initialize(void)
{
  emlrtStack st = {
      NULL, /* site */
      NULL, /* tls */
      NULL  /* prev */
  };
  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, NULL);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void VMyfVoJrTg_fun_terminate(void)
{
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/*
 * File trailer for _coder_VMyfVoJrTg_fun_api.c
 *
 * [EOF]
 */
