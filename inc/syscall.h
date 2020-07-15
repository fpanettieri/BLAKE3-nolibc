#ifndef B3S_SYSCALL_H_
#define B3S_SYSCALL_H_

int read(int fd, void* buf, int count);
int write(int fd, void* buf, int len);
void exit(int status);

#endif
