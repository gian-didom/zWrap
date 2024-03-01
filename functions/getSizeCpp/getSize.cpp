#include <stdio.h>
#pragma pack(1)

typedef struct  {
    int a[4];
    int b[7];
    bool c;
    char d[4];
} provaStruct;

#define SIZEMAX sizeof(provaStruct)
provaStruct prova;

int main () {
    printf("%i", (int) SIZEMAX);
    return SIZEMAX;
}
