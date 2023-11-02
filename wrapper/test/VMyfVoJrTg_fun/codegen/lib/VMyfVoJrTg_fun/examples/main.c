/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 * File: main.c
 *
 * MATLAB Coder version            : 23.2
 * C/C++ source code generated on  : 02-Nov-2023 11:00:55
 */

/*************************************************************************/
/* This automatically generated example C main file shows how to call    */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include Files */
#include "main.h"
#include "VMyfVoJrTg_fun.h"
#include "VMyfVoJrTg_fun_terminate.h"
#include "VMyfVoJrTg_fun_types.h"

/* Type Definitions */
#ifndef typedef_emxArray_struct0_T_6x1x1x4
#define typedef_emxArray_struct0_T_6x1x1x4
typedef struct {
  struct0_T data[24];
  int size[4];
} emxArray_struct0_T_6x1x1x4;
#endif /* typedef_emxArray_struct0_T_6x1x1x4 */

/* Function Declarations */
static void argInit_19xd83xd443_real32_T(float result_data[],
                                         int result_size[3]);

static void argInit_2x224x1245_int64_T(int64m_T result[557760]);

static void argInit_450x2xd377_real32_T(float result_data[],
                                        int result_size[3]);

static void argInit_46xd139x78_char_T(char result_data[], int result_size[3]);

static void argInit_6xd152758_boolean_T(bool result_data[], int result_size[2]);

static void argInit_6xd1xd1x4_struct0_T(struct0_T result_data[],
                                        int result_size[4]);

static void argInit_8xd12x21xd376_boolean_T(bool result_data[],
                                            int result_size[4]);

static void argInit_9xd4608xd1_real32_T(float result_data[],
                                        int result_size[3]);

static bool argInit_boolean_T(void);

static void argInit_cell_0(cell_0 *result);

static char argInit_char_T(void);

static void argInit_d15xd37x114xd11_real_T(double result_data[],
                                           int result_size[4]);

static void argInit_d1697xd475_char_T(char result_data[], int result_size[2]);

static void argInit_d175x4269_real_T(double result_data[], int result_size[2]);

static void argInit_d23xd448x68_int32_T(int result_data[], int result_size[3]);

static void argInit_d2x66xd508xd3_boolean_T(bool result_data[],
                                            int result_size[4]);

static void argInit_d4xd63x40x18xd1_char_T(char result_data[],
                                           int result_size[5]);

static void argInit_d76x57x19_int64_T(int64m_T result_data[],
                                      int result_size[3]);

static void argInit_d7xd624x100_real32_T(float result_data[],
                                         int result_size[3]);

static int argInit_int32_T(void);

static int64m_T argInit_int64_T(void);

static float argInit_real32_T(void);

static double argInit_real_T(void);

static void argInit_struct0_T(struct0_T *result);

static void c_argInit_51xd9xd36xd22xd1_int3(int result_data[],
                                            int result_size[5]);

static void c_argInit_d2xd49x15x10xd27_real(float result_data[],
                                            int result_size[5]);

/* Function Definitions */
/*
 * Arguments    : float result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_19xd83xd443_real32_T(float result_data[],
                                         int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 19;
  result_size[1] = 2;
  result_size[2] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 19; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 2; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 19 * idx1) + 38 * idx2] = argInit_real32_T();
      }
    }
  }
}

/*
 * Arguments    : int64m_T result[557760]
 * Return Type  : void
 */
static void argInit_2x224x1245_int64_T(int64m_T result[557760])
{
  int idx0;
  int idx1;
  int idx2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 224; idx1++) {
      for (idx2 = 0; idx2 < 1245; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result[(idx0 + (idx1 << 1)) + 448 * idx2] = argInit_int64_T();
      }
    }
  }
}

/*
 * Arguments    : float result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_450x2xd377_real32_T(float result_data[], int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 450;
  result_size[1] = 2;
  result_size[2] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 450; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 2; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 450 * idx1) + 900 * idx2] = argInit_real32_T();
      }
    }
  }
}

/*
 * Arguments    : char result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_46xd139x78_char_T(char result_data[], int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 46;
  result_size[1] = 2;
  result_size[2] = 78;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 46; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 78; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 46 * idx1) + 92 * idx2] = argInit_char_T();
      }
    }
  }
}

/*
 * Arguments    : bool result_data[]
 *                int result_size[2]
 * Return Type  : void
 */
static void argInit_6xd152758_boolean_T(bool result_data[], int result_size[2])
{
  int i;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 6;
  result_size[1] = 2;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 12; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result_data[i] = argInit_boolean_T();
  }
}

/*
 * Arguments    : struct0_T result_data[]
 *                int result_size[4]
 * Return Type  : void
 */
static void argInit_6xd1xd1x4_struct0_T(struct0_T result_data[],
                                        int result_size[4])
{
  int idx0;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 6;
  result_size[1] = 1;
  result_size[2] = 1;
  result_size[3] = 4;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 6; idx0++) {
    if ((result_size[1U] - 1 >= 0) && (result_size[2U] - 1 >= 0)) {
      for (idx3 = 0; idx3 < 4; idx3++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        argInit_struct0_T(
            &result_data[idx0 + 6 * result_size[1] * result_size[2] * idx3]);
      }
    }
  }
}

/*
 * Arguments    : bool result_data[]
 *                int result_size[4]
 * Return Type  : void
 */
static void argInit_8xd12x21xd376_boolean_T(bool result_data[],
                                            int result_size[4])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 8;
  result_size[1] = 2;
  result_size[2] = 21;
  result_size[3] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 8; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 21; idx2++) {
        for (idx3 = 0; idx3 < 2; idx3++) {
          /* Set the value of the array element.
Change this value to the value that the application requires. */
          result_data[((idx0 + 8 * idx1) + 16 * idx2) + 336 * idx3] =
              argInit_boolean_T();
        }
      }
    }
  }
}

/*
 * Arguments    : float result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_9xd4608xd1_real32_T(float result_data[], int result_size[3])
{
  int idx0;
  int idx1;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 9;
  result_size[1] = 2;
  result_size[2] = 1;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 9; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      result_data[idx0 + 9 * idx1] = argInit_real32_T();
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : bool
 */
static bool argInit_boolean_T(void)
{
  return false;
}

/*
 * Arguments    : cell_0 *result
 * Return Type  : void
 */
static void argInit_cell_0(cell_0 *result)
{
  float d_result_tmp;
  int c_result_tmp;
  char b_result_tmp;
  bool result_tmp;
  /* Set the value of each structure field.
Change this value to the value that the application requires. */
  result_tmp = argInit_boolean_T();
  result->f8 = result_tmp;
  b_result_tmp = argInit_char_T();
  result->f15 = b_result_tmp;
  c_result_tmp = argInit_int32_T();
  result->f17 = c_result_tmp;
  d_result_tmp = argInit_real32_T();
  result->f19 = d_result_tmp;
  result->f20 = b_result_tmp;
  result->f1 = result_tmp;
  argInit_d15xd37x114xd11_real_T(result->f2.data, result->f2.size);
  result->f3 = argInit_int64_T();
  argInit_46xd139x78_char_T(result->f4.data, result->f4.size);
  argInit_d4xd63x40x18xd1_char_T(result->f5.data, result->f5.size);
  argInit_6xd152758_boolean_T(result->f6.data, result->f6.size);
  c_argInit_d2xd49x15x10xd27_real(result->f7.data, result->f7.size);
  argInit_19xd83xd443_real32_T(result->f9.data, result->f9.size);
  result->f10 = b_result_tmp;
  argInit_450x2xd377_real32_T(result->f11.data, result->f11.size);
  argInit_9xd4608xd1_real32_T(result->f12.data, result->f12.size);
  argInit_d23xd448x68_int32_T(result->f13.data, result->f13.size);
  argInit_d7xd624x100_real32_T(result->f14.data, result->f14.size);
  result->f16 = c_result_tmp;
  result->f18 = d_result_tmp;
}

/*
 * Arguments    : void
 * Return Type  : char
 */
static char argInit_char_T(void)
{
  return '?';
}

/*
 * Arguments    : double result_data[]
 *                int result_size[4]
 * Return Type  : void
 */
static void argInit_d15xd37x114xd11_real_T(double result_data[],
                                           int result_size[4])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  result_size[2] = 114;
  result_size[3] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 114; idx2++) {
        for (idx3 = 0; idx3 < 2; idx3++) {
          /* Set the value of the array element.
Change this value to the value that the application requires. */
          result_data[((idx0 + 2 * idx1) + 4 * idx2) + 456 * idx3] =
              argInit_real_T();
        }
      }
    }
  }
}

/*
 * Arguments    : char result_data[]
 *                int result_size[2]
 * Return Type  : void
 */
static void argInit_d1697xd475_char_T(char result_data[], int result_size[2])
{
  int i;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 4; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result_data[i] = argInit_char_T();
  }
}

/*
 * Arguments    : double result_data[]
 *                int result_size[2]
 * Return Type  : void
 */
static void argInit_d175x4269_real_T(double result_data[], int result_size[2])
{
  int i;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 4269;
  /* Loop over the array to initialize each element. */
  for (i = 0; i < 8538; i++) {
    /* Set the value of the array element.
Change this value to the value that the application requires. */
    result_data[i] = argInit_real_T();
  }
}

/*
 * Arguments    : int result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_d23xd448x68_int32_T(int result_data[], int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  result_size[2] = 68;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 68; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 2 * idx1) + 4 * idx2] = argInit_int32_T();
      }
    }
  }
}

/*
 * Arguments    : bool result_data[]
 *                int result_size[4]
 * Return Type  : void
 */
static void argInit_d2x66xd508xd3_boolean_T(bool result_data[],
                                            int result_size[4])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 66;
  result_size[2] = 2;
  result_size[3] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 66; idx1++) {
      for (idx2 = 0; idx2 < 2; idx2++) {
        for (idx3 = 0; idx3 < 2; idx3++) {
          /* Set the value of the array element.
Change this value to the value that the application requires. */
          result_data[((idx0 + 2 * idx1) + 132 * idx2) + 264 * idx3] =
              argInit_boolean_T();
        }
      }
    }
  }
}

/*
 * Arguments    : char result_data[]
 *                int result_size[5]
 * Return Type  : void
 */
static void argInit_d4xd63x40x18xd1_char_T(char result_data[],
                                           int result_size[5])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  result_size[2] = 40;
  result_size[3] = 18;
  result_size[4] = 1;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 40; idx2++) {
        for (idx3 = 0; idx3 < 18; idx3++) {
          result_data[((idx0 + 2 * idx1) + 4 * idx2) + 160 * idx3] =
              argInit_char_T();
        }
      }
    }
  }
}

/*
 * Arguments    : int64m_T result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_d76x57x19_int64_T(int64m_T result_data[],
                                      int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 57;
  result_size[2] = 19;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 57; idx1++) {
      for (idx2 = 0; idx2 < 19; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 2 * idx1) + 114 * idx2] = argInit_int64_T();
      }
    }
  }
}

/*
 * Arguments    : float result_data[]
 *                int result_size[3]
 * Return Type  : void
 */
static void argInit_d7xd624x100_real32_T(float result_data[],
                                         int result_size[3])
{
  int idx0;
  int idx1;
  int idx2;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  result_size[2] = 100;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 100; idx2++) {
        /* Set the value of the array element.
Change this value to the value that the application requires. */
        result_data[(idx0 + 2 * idx1) + 4 * idx2] = argInit_real32_T();
      }
    }
  }
}

/*
 * Arguments    : void
 * Return Type  : int
 */
static int argInit_int32_T(void)
{
  return 0;
}

/*
 * Arguments    : void
 * Return Type  : int64m_T
 */
static int64m_T argInit_int64_T(void)
{
  static const int64m_T r = {
      {0U, 0U} /* chunks */
  };
  return r;
}

/*
 * Arguments    : void
 * Return Type  : float
 */
static float argInit_real32_T(void)
{
  return 0.0F;
}

/*
 * Arguments    : void
 * Return Type  : double
 */
static double argInit_real_T(void)
{
  return 0.0;
}

/*
 * Arguments    : struct0_T *result
 * Return Type  : void
 */
static void argInit_struct0_T(struct0_T *result)
{
  int result_tmp;
  /* Set the value of each structure field.
Change this value to the value that the application requires. */
  result_tmp = argInit_int32_T();
  result->fRrRenWmpF = result_tmp;
  c_argInit_51xd9xd36xd22xd1_int3(result->AlGyAsIvgK.data,
                                  result->AlGyAsIvgK.size);
  argInit_d2x66xd508xd3_boolean_T(result->zZyADJpHqO.data,
                                  result->zZyADJpHqO.size);
  argInit_8xd12x21xd376_boolean_T(result->BlXEngBqzH.data,
                                  result->BlXEngBqzH.size);
  result->CdCkoejhss = result_tmp;
  argInit_d175x4269_real_T(result->XeNerqszEk.data, result->XeNerqszEk.size);
  result->PkgsAAScKP = argInit_int64_T();
  argInit_d76x57x19_int64_T(result->DTVMSPoGbh.data, result->DTVMSPoGbh.size);
}

/*
 * Arguments    : int result_data[]
 *                int result_size[5]
 * Return Type  : void
 */
static void c_argInit_51xd9xd36xd22xd1_int3(int result_data[],
                                            int result_size[5])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 51;
  result_size[1] = 2;
  result_size[2] = 2;
  result_size[3] = 2;
  result_size[4] = 1;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 51; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 2; idx2++) {
        for (idx3 = 0; idx3 < 2; idx3++) {
          result_data[((idx0 + 51 * idx1) + 102 * idx2) + 204 * idx3] =
              argInit_int32_T();
        }
      }
    }
  }
}

/*
 * Arguments    : float result_data[]
 *                int result_size[5]
 * Return Type  : void
 */
static void c_argInit_d2xd49x15x10xd27_real(float result_data[],
                                            int result_size[5])
{
  int idx0;
  int idx1;
  int idx2;
  int idx3;
  int idx4;
  /* Set the size of the array.
Change this size to the value that the application requires. */
  result_size[0] = 2;
  result_size[1] = 2;
  result_size[2] = 15;
  result_size[3] = 10;
  result_size[4] = 2;
  /* Loop over the array to initialize each element. */
  for (idx0 = 0; idx0 < 2; idx0++) {
    for (idx1 = 0; idx1 < 2; idx1++) {
      for (idx2 = 0; idx2 < 15; idx2++) {
        for (idx3 = 0; idx3 < 10; idx3++) {
          for (idx4 = 0; idx4 < 2; idx4++) {
            /* Set the value of the array element.
Change this value to the value that the application requires. */
            result_data[(((idx0 + 2 * idx1) + 4 * idx2) + 60 * idx3) +
                        600 * idx4] = argInit_real32_T();
          }
        }
      }
    }
  }
}

/*
 * Arguments    : int argc
 *                char **argv
 * Return Type  : int
 */
int main(int argc, char **argv)
{
  (void)argc;
  (void)argv;
  /* The initialize function is being called automatically from your entry-point
   * function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
You can call entry-point functions multiple times. */
  main_VMyfVoJrTg_fun();
  /* Terminate the application.
You do not need to do this more than one time. */
  VMyfVoJrTg_fun_terminate();
  return 0;
}

/*
 * Arguments    : void
 * Return Type  : void
 */
void main_VMyfVoJrTg_fun(void)
{
  static cell_0 r;
  static emxArray_struct0_T_6x1x1x4 FieEkIcymP;
  static int64m_T rv[557760];
  static char eguWQhvSLY_data[806075];
  double b_time;
  double oyvELPSlUCmod;
  int eguWQhvSLY_size[2];
  /* Initialize function 'VMyfVoJrTg_fun' input arguments. */
  /* Initialize function input argument 'eguWQhvSLY'. */
  argInit_d1697xd475_char_T(eguWQhvSLY_data, eguWQhvSLY_size);
  /* Initialize function input argument 'FieEkIcymP'. */
  argInit_6xd1xd1x4_struct0_T(FieEkIcymP.data, FieEkIcymP.size);
  /* Initialize function input argument 'TWgrWEqeae'. */
  /* Initialize function input argument 'JFDmJNevGZ'. */
  /* Call the entry-point 'VMyfVoJrTg_fun'. */
  argInit_2x224x1245_int64_T(rv);
  argInit_cell_0(&r);
  VMyfVoJrTg_fun(argInit_real_T(), eguWQhvSLY_data, eguWQhvSLY_size,
                 FieEkIcymP.data, FieEkIcymP.size, rv, &r, &oyvELPSlUCmod,
                 &b_time);
}

/*
 * File trailer for main.c
 *
 * [EOF]
 */
