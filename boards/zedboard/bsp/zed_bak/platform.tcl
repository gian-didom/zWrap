# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\gianfry\passinputs_dualcore\zed\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\gianfry\passinputs_dualcore\zed\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {zed}\
-hw {C:\Xilinx\Vitis\2023.1\data\embeddedsw\lib\fixed_hwplatforms\zed.xsa}\
-out {C:/Users/gianfry/passinputs_dualcore}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {zed}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
domain create -name {helloworld_core1} -os {standalone} -proc {ps7_cortexa9_1} -arch {32-bit} -display-name {helloworld_core1} -desc {} -runtime {cpp}
platform generate -domains 
platform write
domain -report -json
bsp reload
bsp config extra_compiler_flags "-mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -nostartfiles -g -Wall -Wextra -fno-tree-loop-distribute-patterns -DUSE_AMP=1"
bsp write
bsp reload
catch {bsp regenerate}
platform generate
domain active {zynq_fsbl}
bsp reload
domain active {standalone_ps7_cortexa9_0}
bsp reload
bsp setlib -name lwip213 -ver 1.0
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_ps7_cortexa9_0 
platform clean
platform generate
bsp config ipv6_enable "false"
bsp config ipv6_enable "true"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_ps7_cortexa9_0 
bsp config ipv6_enable "false"
bsp write
bsp reload
catch {bsp regenerate}
platform generate -domains standalone_ps7_cortexa9_0 
bsp reload
