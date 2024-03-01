-include fname.mk

release:
	cd $(FUNCTION_NAME)_multicore_system/Release && $(MAKE) build 
	@echo "Image succesfully built. Copy-paste the BOOT.BIN file from $(FUNCTION_NAME)_multicore_system/Release into the SD card and run the application." 

debug:
	-cd $(FUNCTION_NAME)_multicore_system/Debug && $(MAKE) build
	@echo "Image succesfully built. Copy-paste the BOOT.BIN file from $(FUNCTION_NAME)_multicore_system/Debug into the SD card and run the application." 
