/*
 * This file is part of the coreboot project.
 *
 * Copyright (C) 2012 The Chromium OS Authors. All rights reserved.
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

// Scope (EC0)

Device (AC)
{
	Name (_HID, "ACPI0003")
#ifdef CONFIG_ACPI_SUBSYSTEM_ID
	Name (_SUB, CONFIG_ACPI_SUBSYSTEM_ID)
#endif
	Name (_PCL, Package () { \_SB })

	Method (_PSR)
	{
		Return (ACEX)
	}

	Method (_STA)
	{
		Return (0x0F)
	}
}
