/******************************************************************************
*
* Copyright (C) 2023 Gianfranco Di Domenico.  All rights reserved.
* E-mail: gianfranco.didomenico@polimi.it
*
******************************************************************************/

/*
 * init.c: manage Core1 execution and start ethernet IP application on Core0
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */


#include <stdio.h>                  // stdio for printf and general i/o
#include <sleep.h>                  // sleep for waiting (How does sleep wait actually with no clock...)
#include "xil_io.h"                 // Xilinx specific I/O
#include "xil_mmu.h"                // Xilinx specific MMU (Memory Management Unit)
#include "platform.h"               // Platform specification
#include "xil_printf.h"             // Lightweight printf
#include "xpseudo_asm.h"            // Pseudo-assembly commands (i.e., sev)
#include "xil_exception.h"          // Exception management
#include "memory_structure.h"       // Memory region mapping
#include "main_eth.h"

#define sev() __asm__("sev")        // Define sev command


void disableOCMCache() {
    //Disable cache on OCM
    // S=b1 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0
    Xil_SetTlbAttributes(0xFFFF0000,0x14de2);
};

void set_core1_memory() {
    xil_printf("ARM0: writing startaddress for ARM1\n\r");
    Xil_Out32(ARM1_STARTADR_LOC, ARM1_BASEADDR);
    dmb(); //waits until write has finished
}

void start_core1() {
    print("ARM0: sending the SEV to wake up ARM1\n\r");
    sev();
};

int main()
{
    CORE0_STATUS_VAL = IDLE_STATUS_ARM0;
    CORE1_STATUS_VAL = IDLE_STATUS_ARM1;
    init_platform();

    // Core1 management
    disableOCMCache();      // Disable OCM cache.
    set_core1_memory();     // Write memory address to proper region
    start_core1();          // Start Core1 execution

    // Start Ethernet interface loop
    main_eth();

    cleanup_platform();
    return 0;
}

