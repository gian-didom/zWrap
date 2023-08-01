#include "callFunction.h"
void callFunction() {
// Define input and output struct pointer
inputStruct* pI = (inputStruct*) INPUTSTRUCT_BASE_ADDR;
outputStruct* pO = (outputStruct*) OUTPUTSTRUCT_BASE_ADDR;
// Call function
variableSine(
pI->omega, 

pI->t, 

&(pO->result), 

&(pO->success)
);

}
