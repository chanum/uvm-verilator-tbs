all: simulate

NPROC = $$((`nproc`-1))

# -------------------------------------
# Testbench setup
# -------------------------------------
VERILATOR := verilator
ifdef VERILATOR_ROOT
VERILATOR := $(VERILATOR_ROOT)/bin/verilator
endif

# VERILATOR_UVM Path to repository uvm-verilator/verilator-verification-features-tests/uvm
UVM_ROOT ?=${VERILATOR_UVM}
UVM_TEST ?= mem_wr_rd_test

RTL_PATH ?= ./rtl
VIP_PATH ?= ./verif/vip
TB_PATH ?= ./verif/tb

VERILOG_DEFINE_FILES = ${UVM_ROOT}/src/uvm.sv ${TB_PATH}/tbench_top.sv ${RTL_PATH}/design.sv
VERILOG_INCLUDE_DIRS = ${VIP_PATH}/mem_vip ${TB_PATH} ${RTL_PATH} ${UVM_ROOT}/src

# -------------------------------------
# Compilation/simulation configuration
# -------------------------------------
SIM_NAME ?= mem_tb
SIM_DIR := $(SIM_NAME)-sim
COMPILE_ARGS += -DUVM_NO_DPI
COMPILE_ARGS += --prefix $(SIM_NAME) -o $(SIM_NAME)
COMPILE_ARGS += $(addprefix +incdir+, $(VERILOG_INCLUDE_DIRS))
EXTRA_ARGS += --timescale 1ns/1ps --error-limit 100
WARNING_ARGS += -Wno-lint \
	-Wno-style \
	-Wno-SYMRSVDWORD \
	-Wno-IGNOREDRETURN \
	-Wno-CONSTRAINTIGN \
	-Wno-ZERODLY

# -------------------------------------
# Make UVM test with Verilator
# -------------------------------------
$(SIM_DIR)/$(SIM_NAME).mk: $(wildcard hdl/*.sv)
	$(VERILATOR) --trace --cc --exe --main --timing -Mdir $(SIM_DIR) \
	${COMPILE_ARGS} ${EXTRA_ARGS} \
	${VERILOG_DEFINE_FILES} \
	${WARNING_ARGS}

$(SIM_DIR)/$(SIM_NAME): $(SIM_DIR)/$(SIM_NAME).mk
	$(MAKE) -j${NPROC} -C $(SIM_DIR) $(BUILD_ARGS) -f $(SIM_NAME).mk

simulate: $(SIM_DIR)/$(SIM_NAME).mk $(SIM_DIR)/$(SIM_NAME)
	$(SIM_DIR)/$(SIM_NAME) +UVM_TESTNAME=$(UVM_TEST)

clean:
	rm -rf simv*.daidir csrc
	rm -rf csrc* simv*
	rm -rf $(SIM_DIR)


.PHONY: simulate clean
