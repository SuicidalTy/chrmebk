/*
 * This file is part of the coreboot project.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#define BRIGHTNESS_UP \_SB.PCI0.GFX0.INCB
#define BRIGHTNESS_DOWN \_SB.PCI0.GFX0.DECB
#define ACPI_VIDEO_DEVICE \_SB.PCI0.GFX0
#define EC_LENOVO_H8_ME_WORKAROUND 1
#define THINKPAD_EC_GPE 23
#include <arch/acpi.h>
DefinitionBlock(
	"dsdt.aml",
	"DSDT",
	0x02,		// DSDT revision: ACPI v2.0 and up
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x20141018	// OEM revision
)
{
	#include "acpi/platform.asl"
	#include "acpi/gpe.asl"
	#include <cpu/intel/model_206ax/acpi/cpu.asl>
	#include <southbridge/intel/bd82x6x/acpi/platform.asl>
	#include <southbridge/intel/bd82x6x/acpi/globalnvs.asl>
	#include <southbridge/intel/bd82x6x/acpi/sleepstates.asl>

	Scope (\_SB) {
		Device (PCI0)
		{
			#include <northbridge/intel/sandybridge/acpi/sandybridge.asl>
			#include <southbridge/intel/bd82x6x/acpi/pch.asl>
			#include <drivers/intel/gma/acpi/default_brightness_levels.asl>
		}
	}
}
