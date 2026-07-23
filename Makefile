#=========================================================
# Tang Nano 9K Build
#=========================================================

GOWIN_SH    := LD_LIBRARY_PATH=/tools/gowin_eda/IDE/lib \
			   QT_QPA_PLATFORM=offscreen \
			   DISPLAY= \
			   gw_sh

GOWIN_PLL   := gowin_pll

BUILD_DIR   := build
TOP         := top
TCL_SCRIPT  := scripts/build.tcl
BITSTREAM   := $(BUILD_DIR)/impl/pnr/$(TOP).fs

PLL_WRAPPER := rtl/gowin_rpll.v

.DEFAULT_GOAL := all
.PHONY: all flash clean

all: $(BITSTREAM)

$(BITSTREAM): rtl/counter.v rtl/top.v $(PLL_WRAPPER) constraints/tangnano9k.cst $(TCL_SCRIPT)
	@mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && $(GOWIN_SH) ../$(TCL_SCRIPT)

#Generate the PLL wrapper
$(PLL_WRAPPER):
	$(GOWIN_PLL) \
	-d "GW1NR-9 C6/I5" \
	-i 27 \
	-o 16 \
	-f $@

flash: $(BITSTREAM)
	openFPGALoader -b tangnano9k $(BITSTREAM)

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(PLL_WRAPPER)

