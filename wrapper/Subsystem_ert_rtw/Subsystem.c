/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Subsystem.c
 *
 * Code generated for Simulink model 'Subsystem'.
 *
 * Model version                  : 1.0
 * Simulink Coder version         : 23.2 (R2023b) 01-Aug-2023
 * C/C++ source code generated on : Tue Oct 17 14:19:33 2023
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: ARM Compatible->ARM Cortex-A (32-bit)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Subsystem.h"
#include <math.h>
#include "rtwtypes.h"

/* Model step function */
void Subsystem_step(RT_MODEL_Subsystem_T *const Subsystem_M, real_T
                    Subsystem_U_Input, real_T Subsystem_U_Input1, real_T
                    *Subsystem_Y_Output)
{
  /* Outport: '<Root>/Output' incorporates:
   *  DotProduct: '<S1>/Dot Product'
   *  Inport: '<Root>/Input'
   *  Inport: '<Root>/Input1'
   *  Sqrt: '<S1>/Sqrt'
   */
  *Subsystem_Y_Output = sqrt(Subsystem_U_Input * Subsystem_U_Input1);
  UNUSED_PARAMETER(Subsystem_M);
}

/* Model initialize function */
void Subsystem_initialize(RT_MODEL_Subsystem_T *const Subsystem_M, real_T
  *Subsystem_U_Input, real_T *Subsystem_U_Input1, real_T *Subsystem_Y_Output)
{
  /* Registration code */

  /* external inputs */
  *Subsystem_U_Input = 0.0;
  *Subsystem_U_Input1 = 0.0;

  /* external outputs */
  *Subsystem_Y_Output = 0.0;
  UNUSED_PARAMETER(Subsystem_M);
}

/* Model terminate function */
void Subsystem_terminate(RT_MODEL_Subsystem_T *const Subsystem_M)
{
  /* (no terminate code required) */
  UNUSED_PARAMETER(Subsystem_M);
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
