#
# This file is part of the coreboot project.
#
# Copyright (C) 2010 Google Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#

ifeq ($(CONFIG_NORTHBRIDGE_INTEL_SANDYBRIDGE),y)

ramstage-y += memmap.c
ramstage-y += northbridge.c
ramstage-y += pcie.c
ramstage-y += gma.c

ramstage-y += acpi.c

romstage-y += memmap.c

ramstage-y += common.c
romstage-y += common.c
smm-y += common.c

ifeq ($(CONFIG_USE_NATIVE_RAMINIT),y)
romstage-y += early_dmi.c
romstage-y += raminit.c
romstage-y += raminit_common.c
romstage-y += raminit_sandy.c
romstage-y += raminit_ivy.c
romstage-y += ../../../device/dram/ddr3.c
else
romstage-y += raminit_mrc.c
cbfs-files-y += mrc.bin
mrc.bin-file := $(call strip_quotes,$(CONFIG_MRC_FILE))
mrc.bin-position := 0xfffa0000
mrc.bin-type := mrc
endif
romstage-y += romstage.c
romstage-y += early_init.c
romstage-y += ../../../arch/x86/walkcbfs.S

smm-y += finalize.c

postcar-y += memmap.c

endif
