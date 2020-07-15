#ifndef B3S_ASSERT_H_
#define B3S_ASSERT_H_

# ifdef DEBUG
  # define assert(exp) if(!(exp)) { exit(-1); }
# else
  # define assert(exp)
# endif

#endif
