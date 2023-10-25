/*
 * Copyright (C) 2009 - 2019 Xilinx, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
 * SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
 * OF SUCH DAMAGE.
 *
 */

#include <stdio.h>
#include <string.h>

#include "lwip/err.h"
#include "lwip/tcp.h"
#include "lwip/udp.h"
#include "memory_structure.h"

#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif


#define UDP_PORT 7
#define TCP_PORT 8

struct tcp_pcb* tcpobj;

char RUN_COMMAND[] = "run\n";
char STATUS_COMMAND[] = "status\n";


int transfer_output() {
	static long current_pointer = 0;
	err_t err;

	// If the output size is too big, then split in multiple sends
	if (OUTPUT_STRUCT_SIZE >= tcp_sndbuf(tcpobj)) {

		// We need to split this in multiple sends

		int bytesToSend;
		int bufAvailable = tcp_sndbuf(tcpobj);
		if (bufAvailable > (OUTPUT_STRUCT_SIZE-current_pointer)) {
			bytesToSend = (OUTPUT_STRUCT_SIZE-current_pointer);
		} else {
			bytesToSend = bufAvailable;
		}

		err = tcp_write(tcpobj, (void*) (OUTPUTSTRUCT_BASE_ADDR+current_pointer), bytesToSend, 0);
		tcp_output(tcpobj);
		current_pointer += bytesToSend;

	} else {
	err = tcp_write(tcpobj, OUTPUTSTRUCT_BASE_ADDR, OUTPUT_STRUCT_SIZE, 0);
	current_pointer = OUTPUT_STRUCT_SIZE;
	};

	// If we sent all the bytes, then
	if (current_pointer >= OUTPUT_STRUCT_SIZE) {
	CORE1_STATUS_VAL = IDLE_STATUS_ARM1;
	CORE0_STATUS_VAL = IDLE_STATUS_ARM0;
	current_pointer = 0;
	}
	return (int) err;
}

int transfer_data() {
	return 0;
}


err_t tcp_recv_callback(void *arg, struct tcp_pcb *tpcb,
                               struct pbuf *p, err_t err)
{
	static long current_pointer = 0;
	/* do not read the packet if we are not in ESTABLISHED state */
	if (!p) {
		tcp_close(tpcb);
		tcp_recv(tpcb, NULL);
		return ERR_OK;
	}

	/* indicate that the packet has been received */
	tcp_recved(tpcb, p->len);

	/* echo back the payload */
	/* in this case, we assume that the payload is < TCP_SND_BUF */

		// err = tcp_write(tpcb, p->payload, p->len, 1);
		if (CORE0_STATUS_VAL == WAITING_FOR_INPUTS) {
			if (p->len >= INPUT_STRUCT_SIZE) {
				// We have received all inputs.
				memcpy((void*) INPUTSTRUCT_BASE_ADDR, p->payload, INPUT_STRUCT_SIZE);
				// Signal that it is possible to proceed
				CORE0_STATUS_VAL = WAITING_FOR_OUTPUTS;
			} else {
				memcpy((void*) (INPUTSTRUCT_BASE_ADDR+current_pointer), p->payload, p->len);
				current_pointer += p->len;
				if (current_pointer >= INPUT_STRUCT_SIZE) {
					current_pointer = 0;
					CORE0_STATUS_VAL = WAITING_FOR_OUTPUTS;
				}
			}
		}


	/* free the received pbuf */
	pbuf_free(p);

	return ERR_OK;
}

err_t accept_callback(void *arg, struct tcp_pcb *newpcb, err_t err)
{
	static int connection = 1;

	/* set the receive callback for this connection */
	tcp_recv(newpcb, tcp_recv_callback);


	/* just use an integer number indicating the connection id as the
	   callback argument */
	tcp_arg(newpcb, (void*)(UINTPTR)connection);

	tcpobj = newpcb;

	/* increment for fsubsequent accepted connections */
	connection++;

	return ERR_OK;
}


void manage_run() {
	// Set status to waiting_for_inputs
	CORE0_STATUS_VAL = WAITING_FOR_INPUTS;
}

/** Receive data on a udp session */
static void udp_manage_callback(void *arg, struct udp_pcb *tpcb,
		struct pbuf *p, const ip_addr_t *addr, u16_t port)
{
	err_t err;


	xil_printf("Received a message.\n");


	/* echo back the payload on TCP */
	/* in this case, we assume that the payload is < TCP_SND_BUF */
	if (tcp_sndbuf(tcpobj) > p->len) {
		// err = tcp_write(tcpobj, p->payload, p->len, 1);

		if (strcmp(RUN_COMMAND, (char*) p->payload) == 0) {
			manage_run();
		}
		// tcp_output(tcpobj);
	} else
		xil_printf("no space in tcp_sndbuf\n\r");

	printf(err);

	pbuf_free(p);
	return;
}


int start_application_udp()
{
	struct udp_pcb *pcb;
	err_t err;

	/* create new UDP PCB structure */
	pcb = udp_new();
	if (!pcb) {
		xil_printf("Error creating PCB UDP. Out of Memory\n\r");
		return -1;
	}

	/* bind to specified UDP port */
	err = udp_bind(pcb, IP_ADDR_ANY, UDP_PORT);
	if (err != ERR_OK) {
		xil_printf("UDP server: Unable to bind to port");
		xil_printf(" %d: err = %d\r\n", UDP_PORT, err);
		udp_remove(pcb);
		return -1;
	}


	udp_recv(pcb, udp_manage_callback, NULL);



	/* we do not need any arguments to callback functions */

	xil_printf("UDP server started @ port %d\n\r", UDP_PORT);

	return 0;
}


struct tcp_pcb* start_application_tcp()
{
	struct tcp_pcb *pcb;
	err_t err;

	/* create new TCP PCB structure */
	pcb = tcp_new_ip_type(IPADDR_TYPE_ANY);
	if (!pcb) {
		xil_printf("Error creating PCB. Out of Memory\n\r");
		return NULL;
	}

	/* bind to specified @port */
	err = tcp_bind(pcb, IP_ANY_TYPE, TCP_PORT);
	if (err != ERR_OK) {
		xil_printf("Unable to bind to port %d: err = %d\n\r", TCP_PORT, err);
		return NULL;
	}

	/* we do not need any arguments to callback functions */
	tcp_arg(pcb, NULL);

	/* listen for connections */
	pcb = tcp_listen(pcb);
	if (!pcb) {
		xil_printf("Out of memory while tcp_listen\n\r");
		return NULL;
	}

	/* specify callback to use for incoming connections */
	tcp_accept(pcb, accept_callback);

	xil_printf("TCP echo server started @ port %d\n\r", TCP_PORT);

	return pcb;
};


int start_application() {

	// Create TCP object
	struct tcp_pcb* tcpobj_ptr = start_application_tcp();

	if (!tcpobj_ptr) {
		xil_printf("ERROR while creating TCP channel");
		return -1;
	};

	// Create UDP object
	start_application_udp();

	return  0;
};

