#
# This file was created by Xilinx Vitis tool.
#

-include ../../fname.mk
-include ../../compiler.mk

#
# tools
#

RM = rm -f
RMDIR = rm -rf



#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = ../../zed/export/zed/zed.xpfm
SYS_CONFIG = zed
DOMAINS = standalone_ps7_cortexa9_0,app_core1
BIF_PATH = ../../$(FUNCTION_NAME)_multicore_system/Release/system.bif

SD_FILES = --elf ../../$(FUNCTION_NAME)_core0/Release/$(FUNCTION_NAME)_core0.elf,ps7_cortexa9_0 --elf ../../$(FUNCTION_NAME)_core1/Release/$(FUNCTION_NAME)_core1.elf,ps7_cortexa9_1

#
# primary build targets
#
build:
	-@echo Building app for core0...
	cd ../../$(FUNCTION_NAME)_core0/Release && $(MAKE) all
	-@echo Building app for core1...
	cd ../../$(FUNCTION_NAME)_core1/Release && $(MAKE) all
	$(MAKE) package


package:
	-clean 
	-@echo Generating bif file for the system project
	@echo "the_ROM_image:" > $(FUNCTION_NAME).bif
	@echo "{" >> $(FUNCTION_NAME).bif
	@echo "[bootloader] ../../zed/zynq_fsbl/fsbl.elf" >> $(FUNCTION_NAME).bif
	@echo "../../$(FUNCTION_NAME)_core0/Release/$(FUNCTION_NAME)_core0.elf" >> $(FUNCTION_NAME).bif
	@echo "../../$(FUNCTION_NAME)_core1/Release/$(FUNCTION_NAME)_core1.elf" >> $(FUNCTION_NAME).bif
	@echo "}" >> $(FUNCTION_NAME).bif
	$(BOOTGEN) -image $(FUNCTION_NAME).bif -arch zynq -w on -o BOOT.BIN


clean:
	$(RMDIR) ./_sds
	${RMDIR} package
	${RM} $(FUNCTION_NAME).bif

.PHONY: all package clean

all: package


