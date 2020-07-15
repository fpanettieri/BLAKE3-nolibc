# Name
  b3s - compute BLAKE3 message digest

# Usage
  $ echo 'test' | b3s
  > dea2b412aa90f1b43a06ca5e8b8feafec45ae1357971322749480f4e1572eaa2

  $ cat /dev/sda1 | b3s
  > 6ea06c5c03314e41c1c07b8eac7c11e6c3b55eae9913b1559cef2efbd0934688

# About
  Minimalist nolibc integration of [BLAKE3](https://github.com/BLAKE3-team/BLAKE3):
  
    . Input is read ONLY from STDIN
    . The generated hash is wrote directly to STDOUT
    . C99 source compiled without libc

  The reference source code has been barely modified. In files where changes were required, the original code has been kept for future reference / study.

# Authors
  The authors of the reference implementation can be found [here](https://github.com/BLAKE3-team/BLAKE3#intellectual-property).

  This 'nolibc implementation' was written by Fabio Panettieri.


