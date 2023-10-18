/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Subsystem.h
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

#ifndef RTW_HEADER_Subsystem_h_
#define RTW_HEADER_Subsystem_h_
#ifndef Subsystem_COMMON_INCLUDES_
#define Subsystem_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* Subsystem_COMMON_INCLUDES_ */

#include "Subsystem_types.h"
#include "rt_defines.h"

/* Real-time Model Data Structure */
struct tag_RTM_Subsystem_T {
  char_T rt_unused;
};

/* Model entry point functions */
extern void Subsystem_initialize(RT_MODEL_Subsystem_T *const Subsystem_M, real_T
  *Subsystem_U_Input, real_T *Subsystem_U_Input1, real_T *Subsystem_Y_Output);
extern void Subsystem_step(RT_MODEL_Subsystem_T *const Subsystem_M, real_T
  Subsystem_U_Input, real_T Subsystem_U_Input1, real_T *Subsystem_Y_Output);
extern void Subsystem_terminate(RT_MODEL_Subsystem_T *const Subsystem_M);

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('prova/Subsystem')    - opens subsystem prova/Subsystem
 * hilite_system('prova/Subsystem/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'prova'
 * '<S1>'   : 'prova/Subsystem'
 */
#endif                                 /* RTW_HEADER_Subsystem_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
