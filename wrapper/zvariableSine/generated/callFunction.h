#ifndef ZCALL_FUNCTION
#define ZCALL_FUNCTION
#include "memory_structure.h"
#include "variableSine.h"

#ifdef __cplusplus
namespace coder {};
using namespace coder;
#endif
typedef struct inputStruct {
real_T omega;
real_T t;
} inputStruct;

typedef struct outputStruct {
real_T result;
real_T success;
} outputStruct;

void callFunction();
#endif
