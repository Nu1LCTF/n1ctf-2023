#include <stdint.h>
#include <stdio.h>

void decipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], delta=0x636f3268, sum=delta*num_rounds;
    for (i=0; i < num_rounds; i++) {
        v1 -= (((v0 << 2) ^ (v0 >> 10)) + v0) ^ (sum + key[(sum>>11) & 3]);
        sum -= delta;
        v0 -= (((v1 << 9) ^ (v1 >> 6)) + v1) ^ (sum + key[sum & 3]);
    }
    v[0]=v0; v[1]=v1;
}

void encipher(unsigned int num_rounds, uint32_t v[2], uint32_t const key[4]) {
    unsigned int i;
    uint32_t v0=v[0], v1=v[1], sum=0, delta=0x636f3268;
    for (i=0; i < num_rounds; i++) {
        v0 += (((v1 << 9) ^ (v1 >> 6)) + v1) ^ (sum + key[sum & 3]);
        sum += delta;
        uint32_t tmp1 = (((v0 << 2) ^ (v0 >> 10)) + v0);
        uint32_t tmp2 = (sum + key[(sum>>11) & 3]);
        v1 += tmp1 ^ tmp2;
    }
    v[0]=v0; v[1]=v1;
}

int main() {
    uint32_t key[4] = {0x636f3268, 0x636f3268, 0x636f3268, 0x636f3268};
    uint32_t enc[9] = {1979671746, 897489479, 1099794343, 1301154413, 1769714755, 960071495, 1038852409, 3276753339, 0};
    for(int i = 0;i<4;i+=1) {
        decipher(8, enc+2*i, key);
    }
    printf("%s\n", (char*)enc);
    return 0;
}