#ifndef B3S_MEM_H_
#define B3S_MEM_H_

#include "types.h"

void* memset(void* dst, uint8_t c, uint64_t count);
void* memcpy(void* dst, const void* src, uint64_t count);
void* memmove(void* dst, const void* src, uint64_t count);
int strlen(const char* s);

#endif
