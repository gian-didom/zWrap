################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../../fname.mk
-include ../../compiler.mk
ifndef FUNCTION_NAME
FUNCTION_NAME = app
endif

-include ../../iomem.mk
ifndef IO_BASE_ADDR
IO_BASE_ADDR = 0x60000
endif

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include src/subdir.mk
-include subdir.mk
-include objects.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(S_UPPER_DEPS)),)
-include $(S_UPPER_DEPS)
endif
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
ELFSIZE += \
$(FUNCTION_NAME)_core0.elf.size \


# All Target
all:
	$(MAKE) --no-print-directory pre-build
	$(MAKE) --no-print-directory main-build

# Main-build Target
main-build: $(FUNCTION_NAME)_core0.elf secondary-outputs

# Tool invocations
$(FUNCTION_NAME)_core0.elf: $(OBJS) ../src/lscript.ld $(USER_OBJS)
	@echo 'Building target: $@'
	@echo 'Invoking: ARM v7 gcc linker'
	$(ARM_GCC) -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -Wl,--print-memory-usage -Wl,-build-id=none -specs=Xilinx.spec -Wl,-T -Wl,../src/lscript.ld -L ../../zed/export/zed/sw/zed/standalone_ps7_cortexa9_0/bsplib/lib -o "$(FUNCTION_NAME)_core0.elf" $(OBJS) $(USER_OBJS) $(LIBS)
	@echo 'Finished building target: $@'
	@echo ' '

$(FUNCTION_NAME)_core0.elf.size: $(FUNCTION_NAME)_core0.elf
	@echo 'Invoking: ARM v7 Print Size'
	arm-none-eabi-size $(FUNCTION_NAME)_core0.elf  |tee "$(FUNCTION_NAME)_core0.elf.size"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(EXECUTABLES)$(OBJS)$(S_UPPER_DEPS)$(C_DEPS)$(ELFSIZE) $(FUNCTION_NAME)_core0.elf
	-@echo ' '

pre-build:
	-a9-linaro-pre-build-step
	-@echo ' '

secondary-outputs: $(ELFSIZE)

.PHONY: all clean dependents main-build pre-build

-include ../makefile.targets
