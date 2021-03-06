##
## This file is part of the coreboot project.
##
## Copyright (C) 2012 Google Inc.
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; version 2 of the License.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##

ramstage-y += ec.c

romstage-y += chromeos.c
ramstage-y += chromeos.c

SPD_BIN = $(obj)/spd.bin

# Include spd ROM data
$(SPD_BIN):
	xxd -rg1 $(src)/mainboard/samsung/lumpy/spd.hex >| $@

cbfs-files-y += spd.bin
spd.bin-file := $(SPD_BIN)
spd.bin-type := spd
romstage-y += gpio.c

ramstage-$(CONFIG_MAINBOARD_USE_LIBGFXINIT) += gma-mainboard.ads
