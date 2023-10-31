################################################################################
# Automatically-generated file. Do not edit!
################################################################################
ifndef FUNCTION_NAME
FUNCTION_NAME = app
endif

# Add inputs and outputs from these tool invocations to the build variables 
LD_SRCS += \
../src/lscript.ld 


C_SRCS += $(wildcard ../src/*.c)               # list of source files
CPP_SRCS += $(wildcard ../src/*.cpp)               # list of source files

OBJS += $(patsubst ../src/%.c, ./src/%.o, $(C_SRCS)) # list of object files
OBJS += $(patsubst ../src/%.cpp, ./src/%.o, $(CPP_SRCS)) # list of object files

C_DEPS += $(patsubst %.o, %.d, $(OBJS)) # list of object files


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	$(ARM_GPP) -DIO_BASE_ADDR=$(IO_BASE_ADDR) -DUSE_AMP=1 -Wall -O0 -g3 -I"../../$(FUNCTION_NAME)_multicore_system/include_common" -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I ../../zed/export/zed/sw/zed/standalone_ps7_cortexa9_1/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: ARM v7 gcc compiler'
	$(ARM_GPP) -DIO_BASE_ADDR=($(IO_BASE_ADDR)) -DUSE_AMP=1 -Wall -O0 -g3 -I"../../$(FUNCTION_NAME)_multicore_system/include_common" -c -fmessage-length=0 -MT"$@" -mcpu=cortex-a9 -mfpu=vfpv3 -mfloat-abi=hard -I ../../zed/export/zed/sw/zed/standalone_ps7_cortexa9_1/bspinclude/include -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

