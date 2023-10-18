
#ifndef RTWTYPES_H
#include "rtwtypes.h"


#endif

namespace coder {
struct inputStructure {
real_T _rtU_time;
real_T _rtU_muEarth;

real_T _rtU_muMoon;

real_T _rtU_muSun;
real_T _rtU_dtMeas;

real_T _rtU_sigmaAtt[3];

real_T _rtU_sigmaResAcc[3];
real_T _rtU_betaResAcc[3];

real_T _rtU_sigmaMeasBias[3];

real_T _rtU_betaMeasBias[3];
real_T _rtU_P0[144];

real_T _rtU_x0[12];

real_T _rtU_distanceLines;
real_T _rtU_limitAngle;

uint8_T _rtU_thres;

uint16_T _rtU_Nw;
real_T _rtU_patchSize;

real_T _rtU_Cov_K[25];

real_T _rtU_Cov_edge[4];
real_T _rtU_Cov_q[9];

real_T _rtU_probRANSAC;

real_T _rtU_numPointModelRANSAC;
real_T _rtU_sigmaInliersRANSAC;

real_T _rtU_rMoon;

real_T _rtU_maxIteration;
real_T _rtU_Kc_inv[9];

uint8_T _rtU_img[1048576];

real_T _rtU_dir_Sun2Cam_Cam[3];
real_T _rtU_DCM_Cam2PrincipalMoon[9];

real_T _rtU_estimated_quaternion_J20002Body[4];

real_T _rtU_earth_position_J2000[3];
real_T _rtU_moon_position_J2000[3];

real_T _rtU_sun_position_J2000[3];

};
inputStructure FULL_INPUT_STRUCT;

struct {
real_T _rtY_r_IP[3];
real_T _rtY_Cov_r_IP[9];

boolean_T _rtY_validity_IP;

real_T _rtY_xHat[12];
real_T _rtY_PHat[144];

real_T _rtY_xProp[12];

real_T _rtY_propagated_state_covariance[144];
} FULL_OUTPUT_STRUCT;



int main() {return 0;};
}