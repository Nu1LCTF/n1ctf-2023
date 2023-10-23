#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/capability.h>

int main(){
    cap_t caps = cap_from_text("cap_dac_override=eip");
    cap_set_file("/bin/cat", caps);
}