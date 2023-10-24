# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: C:\Users\gianfry\passinputs_dualcore\app_multicore_system\_ide\scripts\systemdebugger_app_multicore_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source C:\Users\gianfry\passinputs_dualcore\app_multicore_system\_ide\scripts\systemdebugger_app_multicore_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw C:/Users/gianfry/passinputs_dualcore/zed/export/zed/hw/zed.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source C:/Users/gianfry/passinputs_dualcore/app_core0/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow C:/Users/gianfry/passinputs_dualcore/app_core0/Debug/app_core0.elf
targets -set -nocase -filter {name =~ "*A9*#1"}
dow C:/Users/gianfry/passinputs_dualcore/app_core1/Debug/app_core1.elf
configparams force-mem-access 0
bpadd -addr &main
