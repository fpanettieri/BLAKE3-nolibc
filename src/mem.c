#include "mem.h"

#include "assert.h"
#include "types.h"
#include "syscall.h"

void* memset(void* dst, uint8_t c, uint64_t count)
{
  uint8_t* bytes;

  assert(dst);
  assert(count > 0);

  bytes = (uint8_t*)dst;
  while (count--) { *bytes++ = c; }
  return dst;
}

void* memcpy(void* dst, const void* src, uint64_t count)
{
  uint8_t* to;
  const uint8_t* from;

  assert(src && dst);
  assert(count > 0);

  to = (uint8_t*)dst;
  from = (const uint8_t*)src;
  while (count--) { *to++ = *from++; }
  return dst;
}

void* memmove(void* dst, const void* src, uint64_t count)
{
  uint8_t* to;
  const uint8_t* from;

  assert(src && dst);
  assert(count > 0);

  to = (uint8_t*)dst;
  from = (const uint8_t*)src;
  for (to += count, from += count; count--;){ *--to = *--from; }
  return dst;
}

int strlen(const char* s)
{
  char* p = (char*) s;
  while (*p) { ++p; }
  return p - s;
}

