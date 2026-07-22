#=========================================================
# Tang Nano 9K Build
#=========================================================

GOWIN_SH   := LD_LIBRARY_PATH=/tools/gowin_eda/IDE/lib \
			  QT_QPA_PLATFORM=offscreen \
			  DISPLAY= \
			  gw_sh

BUILD_DIR  := build
TOP        := top
TCL_SCRIPT := scripts/build.tcl
BITSTREAM  := $(BUILD_DIR)/impl/pnr/$(TOP).fs


.PHONY: all flash clean

all: $(BITSTREAM)

$(BITSTREAM): rtl/counter.v rtl/top.v constraints/tangnano9k.cst $(TCL_SCRIPT)
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && $(GOWIN_SH) ../$(TCL_SCRIPT)

flash: $(BITSTREAM)
	openFPGALoader -b tangnano9k $(BITSTREAM)

clean:
	rm -rf $(BUILD_DIR)

