all: build

CHAL_SOURCE = ./h2o.h2oc
CHAL_BINARY_OUT = ./h2o.binary # the subleq program
CHAL_ASM_OUT = ./h2o.asm
CHAL_DBGSYM = ./h2o.sym

build: $(SOURCE)
	h2occ $(CHAL_SOURCE) -o $(CHAL_BINARY_OUT) -a $(CHAL_ASM_OUT) -g $(CHAL_DBGSYM)