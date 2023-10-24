#include "Subsystem1.h"



#ifndef RTWTYPES_H
#include "rtwtypes.h"

#endif


namespace coder {
struct inputStructure {real_T _rtU_time;

configuration_bus_architecture _rtU_Configurationbus;

uint8_T _rtU_img[1048576];
real_T _rtU_dir_Sun2Cam_Cam[3];

real_T _rtU_DCM_Cam2PrincipalMoon[9];

real_T _rtU_estimated_quaternion_J20002Body[4];
real_T _rtU_earth_position_J2000[3];

real_T _rtU_moon_position_J2000[3];

real_T _rtU_sun_position_J2000[3];
};

inputStructure FULL_INPUT_STRUCT;

struct {real_T _rtY_r_IP[3];

real_T _rtY_Cov_r_IP[9];

boolean_T _rtY_validity_IP;
real_T _rtY_xHat[12];

real_T _rtY_PHat[144];

real_T _rtY_xProp[12];
real_T _rtY_propagated_state_covariance[144];

} FULL_OUTPUT_STRUCT;



int main() {return 0;};}
