/*
 * This file is part of the coreboot project.
 *
 * Copyright (C) 2012 The ChromiumOS Authors.  All rights reserved.
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

/*
 * Chrome OS Embedded Controller interface
 *
 * Constants that should be defined:
 *
 * SIO_EC_MEMMAP_ENABLE     : Enable EC LPC memory map resources
 * EC_LPC_ADDR_MEMMAP       : Base address of memory map range
 * EC_MEMMAP_SIZE           : Size of memory map range
 *
 * SIO_EC_HOST_ENABLE       : Enable EC host command interface resources
 * EC_LPC_ADDR_HOST_DATA    : EC host command interface data port
 * EC_LPC_ADDR_HOST_CMD     : EC host command interface command port
 * EC_HOST_CMD_REGION0      : EC host command buffer
 * EC_HOST_CMD_REGION1      : EC host command buffer
 * EC_HOST_CMD_REGION_SIZE  : EC host command buffer size
 */

// Scope is \_SB.PCI0.LPCB

Device (SIO) {
	Name (_HID, EisaId ("PNP0A05"))
	Name (_UID, 0)
	Name (_ADR, 0)

#ifdef SIO_EC_MEMMAP_ENABLE
	Device (ECMM) {
		Name (_HID, EISAID ("PNP0C02"))
#ifdef CONFIG_ACPI_SUBSYSTEM_ID
		Name (_SUB, CONFIG_ACPI_SUBSYSTEM_ID)
#endif
		Name (_UID, 4)
		Name (_ADR, 0)

		Method (_STA, 0, NotSerialized) {
			Return (0x0F)
		}

		Name (_CRS, ResourceTemplate ()
		{
			IO (Decode16, EC_LPC_ADDR_MEMMAP, EC_LPC_ADDR_MEMMAP,
			    0x08, EC_MEMMAP_SIZE)
		})

		Name (_PRS, ResourceTemplate ()
		{
			IO (Decode16, EC_LPC_ADDR_MEMMAP, EC_LPC_ADDR_MEMMAP,
			    0x08, EC_MEMMAP_SIZE)
		})
	}
#endif

#ifdef SIO_EC_HOST_ENABLE
	Device (ECUI) {
		Name (_HID, EISAID ("PNP0C02"))
#ifdef CONFIG_ACPI_SUBSYSTEM_ID
		Name (_SUB, CONFIG_ACPI_SUBSYSTEM_ID)
#endif
		Name (_UID, 3)
		Name (_ADR, 0)

		Method (_STA, 0, NotSerialized) {
			Return (0x0F)
		}

		Name (_CRS, ResourceTemplate ()
		{
			IO (Decode16,
			    EC_LPC_ADDR_HOST_DATA, EC_LPC_ADDR_HOST_DATA,
			    0x01, 0x01)
			IO (Decode16,
			    EC_LPC_ADDR_HOST_CMD, EC_LPC_ADDR_HOST_CMD,
			    0x01, 0x01)
			IO (Decode16,
			    EC_HOST_CMD_REGION0, EC_HOST_CMD_REGION0, 0x08,
			    EC_HOST_CMD_REGION_SIZE)
			IO (Decode16,
			    EC_HOST_CMD_REGION1, EC_HOST_CMD_REGION1, 0x08,
			    EC_HOST_CMD_REGION_SIZE)
		})

		Name (_PRS, ResourceTemplate ()
		{
			StartDependentFn (0, 0) {
				IO (Decode16, EC_LPC_ADDR_HOST_DATA,
				    EC_LPC_ADDR_HOST_DATA, 0x01, 0x01)
				IO (Decode16, EC_LPC_ADDR_HOST_CMD,
				    EC_LPC_ADDR_HOST_CMD, 0x01, 0x01)
				IO (Decode16,
				    EC_HOST_CMD_REGION0, EC_HOST_CMD_REGION0,
				    0x08, EC_HOST_CMD_REGION_SIZE)
				IO (Decode16,
				    EC_HOST_CMD_REGION1, EC_HOST_CMD_REGION1,
				    0x08, EC_HOST_CMD_REGION_SIZE)
			}
			EndDependentFn ()
		})
	}
#endif

#ifdef SIO_EC_ENABLE_COM1
	Device (COM1) {
		Name (_HID, EISAID ("PNP0501"))
#ifdef CONFIG_ACPI_SUBSYSTEM_ID
		Name (_SUB, CONFIG_ACPI_SUBSYSTEM_ID)
#endif
		Name (_UID, 1)
		Name (_ADR, 0)

		Method (_STA, 0, NotSerialized) {
			Return (0x0B)
		}

		Name (_CRS, ResourceTemplate ()
		{
			IO (Decode16, 0x03F8, 0x3F8, 0x08, 0x08)
			IRQNoFlags () {4}
		})

		Name (_PRS, ResourceTemplate ()
		{
			StartDependentFn (0, 0) {
				IO (Decode16, 0x03F8, 0x3F8, 0x08, 0x08)
				IRQNoFlags () {4}
			}
			EndDependentFn ()
		})
	}
#endif
}

#ifdef SIO_EC_ENABLE_PS2K
#if CONFIG(SOC_INTEL_BAYTRAIL) || CONFIG(SOC_INTEL_BRASWELL)
}

Scope (\_SB.PCI0)
{
#endif
	Device (PS2K)		// Keyboard
	{
#if CONFIG(SOC_INTEL_BAYTRAIL)|| CONFIG(SOC_INTEL_BRASWELL)
		Name (_UID, 1)
		Name (_ADR, 1)
#else
		Name (_UID, 0)
		Name (_ADR, 0)
#endif
		Name (_HID, "GOOG000A")
		Name (_CID, Package() { EISAID("PNP0303"), EISAID("PNP030B"), "GGL0303" } )
#ifdef CONFIG_ACPI_SUBSYSTEM_ID
	Name (_SUB, CONFIG_ACPI_SUBSYSTEM_ID)
#endif

	Method (_STA, 0, NotSerialized) {
		Return (0x0F)
	}

	Name (_CRS, ResourceTemplate()
	{
		IO (Decode16, 0x60, 0x60, 0x01, 0x01)
		IO (Decode16, 0x64, 0x64, 0x01, 0x01)
#ifdef SIO_EC_PS2K_IRQ
		SIO_EC_PS2K_IRQ
#else
		IRQ (Edge, ActiveHigh, Exclusive) {1}
#endif
	})

	Name (_PRS, ResourceTemplate()
	{
		StartDependentFn (0, 0) {
			IO (Decode16, 0x60, 0x60, 0x01, 0x01)
			IO (Decode16, 0x64, 0x64, 0x01, 0x01)
#ifdef SIO_EC_PS2K_IRQ
			SIO_EC_PS2K_IRQ
#else
			IRQ (Edge, ActiveHigh, Exclusive) {1}
#endif
		}
		EndDependentFn ()
	})
}
#endif
