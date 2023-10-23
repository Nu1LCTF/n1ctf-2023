#include "sys/random.h"
#include "utils.h"
#include <cstdio>
#include <cstring>
#include <memory>
constexpr size_t CANARY_RANDBITS = 3;
constexpr size_t CANARY_SHIFTBITS = 4;
constexpr size_t CANARY_POOL_SIZE = 1 << CANARY_RANDBITS;
u64 user_canary[CANARY_POOL_SIZE];
u64 sys_canary[CANARY_POOL_SIZE];
template <size_t SIZE> struct ProtectedBuffer {
  char buf[SIZE];
  char padding = 0;
  u64 canary;
  ProtectedBuffer() {
    bzero(buf, sizeof(buf));
    canary = getCanary();
  }
  u64 getCanary() {
    u64 addr = (u64)this;
    u64 canary_idx = (addr >> CANARY_SHIFTBITS) & (CANARY_POOL_SIZE - 1);
    u64 raw_canary = user_canary[canary_idx] ^ sys_canary[canary_idx];
    return raw_canary;
  }
  void check() {
    if (canary != getCanary()) {
      raise("*** stack smash detected ***");
    }
  }
  template <typename Fn> void mut(Fn const &fn) {
    fn(buf);
    check();
  }
};

static void init_canary() {
  if (sizeof(sys_canary) != getrandom(sys_canary, sizeof(sys_canary), 0)) {
    raise("canary init error");
  }
  puts("To increase entropy, give me your canary");
  readall(user_canary);
}

struct UnsafeApp {
  UnsafeApp() { puts("creating dangerous app..."); }
  virtual ~UnsafeApp() {}
  virtual void launch() = 0;
};

struct BOFApp : UnsafeApp {
  void launch() override {
    ProtectedBuffer<64> buf;
    puts("input something to pwn :)");
    buf.mut([](char *p) { scanf("%[^\n]", p); });
    puts(buf.buf);
  }
};

static void backdoor() { system("/readflag"); }

int main() {
  setbuf(stdin, nullptr);
  setbuf(stdout, nullptr);
  init_canary();
  try {
    auto app = std::make_unique<BOFApp>();
    app->launch();
  } catch (...) {
    puts("error!!!");
    exit(1);
  }
}