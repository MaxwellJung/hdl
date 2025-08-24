HDL_DIR := ./hdl
BUILD_DIR := ./build
SIM_DIR := ./sim
HDL_FILES := $(shell find $(HDL_DIR) -name '*.sv' -or -name '*.v')

all: counter_tb.vcd

# Icarus

%_tb.vcd: %_tb.vvp
	vvp $^

%_tb.vvp: force
	iverilog -g2005-sv -o $*_tb.vvp \
		-s $(basename $(notdir $*))_tb \
		$(SIM_DIR)/$(basename $(notdir $*))_tb.sv $(HDL_FILES)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

force: ;
