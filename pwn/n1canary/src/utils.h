#pragma once
#include <cstdlib>
#include <stdexcept>
#include <unistd.h>
using u64 = unsigned long long;
static inline void raise(const char *msg) {
  puts(msg);
  throw std::runtime_error(msg);
}
static inline void readall(void *ptr, size_t size) {
  char *p = (char *)ptr;
  size_t tot = 0;
  while (tot < size) {
    auto res = read(STDIN_FILENO, p + tot, size - tot);
    if (res <= 0)
      raise("IO error");
    tot += res;
  }
}
template <typename T> static inline void readall(T &dest) {
  readall(&dest, sizeof(dest));
}