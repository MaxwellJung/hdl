HDL_DIR := ./hdl
BUILD_DIR := ./build
SIM_DIR := ./sim
HDL_FILES := $(shell find $(HDL_DIR) -name '*.sv' -or -name '*.v')
SIM_FILES := $(shell find $(SIM_DIR) -name '*.sv' -or -name '*.v')

all: $(BUILD_DIR)/counter_tb.vcd $(BUILD_DIR)/vga_timing_generator_tb.vcd

# Icarus

%_tb.vcd: %_tb.vvp
	vvp $^
	mv $(basename $(notdir $*))_tb.vcd $@

%_tb.vvp: $(HDL_FILES) $(SIM_FILES)
	mkdir -p $(dir $@)
	iverilog -g2005-sv -o $@ \
		-s $(basename $(notdir $*))_tb \
		$(SIM_DIR)/$(basename $(notdir $*))_tb.sv $(HDL_FILES)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

force: ;
