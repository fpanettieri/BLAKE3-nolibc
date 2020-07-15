#include "assert.h"
#include "blake3.h"
#include "mem.h"
#include "syscall.h"
#include "types.h"
#include "io.h"

#define BUF_SIZE 65536
#define OUT_LEN (BLAKE3_OUT_LEN * 2)
#define HEX "0123456789abcdef"

int main()
{
  // init
	blake3_hasher hasher;
	blake3_hasher_init(&hasher);

  // read stdin
	unsigned char buf[BUF_SIZE];
  int nread;
  while ((nread = read(STDIN, buf, BUF_SIZE)) > 0) {
    blake3_hasher_update(&hasher, buf, nread);
  }

  // finalize
  uint8_t hash[BLAKE3_OUT_LEN];
  blake3_hasher_finalize(&hasher, hash, BLAKE3_OUT_LEN);

  // print
  uint8_t out[OUT_LEN + 1];
  for (uint8_t i = 0; i < BLAKE3_OUT_LEN; i++) {
    out[i * 2]     = HEX[hash[i] / 16];
    out[i * 2 + 1] = HEX[hash[i] % 16];
  }
  out[OUT_LEN] = '\n';
  write(STDOUT, out, OUT_LEN + 1);

	return 0;
}

