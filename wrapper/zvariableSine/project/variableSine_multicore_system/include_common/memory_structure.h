// This files defines the memory mapping.
// It is closely coupled to the BSP (board support package).
// NOTE: This function should be auto-generated.

#ifndef _MEM_STRUCT
#define _MEM_STRUCT
#define ARM0_BASEADDR 0x100000                                  // Base address of Core1 dedicated memory
#define ARM1_STARTADR_LOC 0xFFFFFFF0                            // Memory region in which to write the base address of Core1
#define ARM1_BASEADDR 0x00900040

// Expansion: the COMM_VAL is the value of a volatile unsigned long.
// It is _volatile_ because its value can change with no action being taken by the code (in this case, Core1 could change its value)
// Unsigned long means that the value is 4 bytes at maximum.
// So basically COMM_VAL can take any value between 0 and 2^32 -1.

enum ARM0_STATUS_ENUM {
    IDLE_STATUS_ARM0 = 0,
    WAITING_FOR_INPUTS = 1,
    WAITING_FOR_OUTPUTS = 2
};

enum ARM1_STATUS_ENUM {
    IDLE_STATUS_ARM1 = 0,
    RUNNING_STATUS = 1,
	COMPLETED_STATUS = 2,
    ERROR_STATUS = -1
};

#define CORE0_STATUS_ADDR (0x30000-2*sizeof(int))
#define CORE0_STATUS_VAL (*(volatile enum ARM0_STATUS_ENUM*) (CORE0_STATUS_ADDR))

#define CORE1_STATUS_ADDR (CORE0_STATUS_ADDR+sizeof(int))
#define CORE1_STATUS_VAL (*(volatile enum ARM1_STATUS_ENUM*) (CORE1_STATUS_ADDR))

#define IO_BASE_ADDR 			(0x900000)                // Base shared memory address to store inputs

#include "memorymap.h"

#endif // #ifdef _MEM_STRUCT

