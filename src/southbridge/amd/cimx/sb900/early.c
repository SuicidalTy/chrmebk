/*
 * This file is part of the coreboot project.
 *
 * Copyright (C) 2011 Advanced Micro Devices, Inc.
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

// Use simple device model for this file even in ramstage
#define __SIMPLE_DEVICE__

#include <stdint.h>
#include <device/pci_ids.h>
#include <arch/io.h>
#include "SbPlatform.h"
#include "sb_cimx.h"
#include <console/console.h>
#include "smbus.h"


/**
 * @brief South Bridge CIMx romstage entry,
 *        wrapper of sbPowerOnInit entry point.
 */
void sb_poweron_init(void)
{
	AMDSBCFG sb_early_cfg;
	u8 data;

	printk(BIOS_SPEW, "SB900 - Early.c - sb_poweron_init - Start.\n");

	//Enable/Disable PCI Bridge Device 14 Function 4.
	outb(0xEA, 0xCD6);
	data = inb(0xCD7);
	data &= ~BIT0;
	if (!CONFIG(PCIB_ENABLE)) {
		data |= BIT0;
	}
	outb(data, 0xCD7);

	SbPowerOnInit_Config(&sb_early_cfg);
	//sb_early_cfg.StdHeader.Func = SB_POWERON_INIT;
	//AmdSbDispatcher(&sb_early_cfg);
	//TODO
	//AMD_IMAGE_HEADER was missing, when using AmdSbDispatcher,
	// VerifyImage() will fail, LocateImage() takes minutes to find the image.
	sbPowerOnInit(&sb_early_cfg);
	printk(BIOS_SPEW, "SB900 - Early.c - sb_poweron_init - End.\n");
}

/**
 * @brief South Bridge CIMx romstage entry,
 *        wrapper of sbPowerOnInit entry point.
 */
void sb_before_pci_init(void)
{
	AMDSBCFG sb_early_cfg;

	printk(BIOS_SPEW, "SB900 - Early.c - sb_before_pci_init - Start.\n");
	sb900_cimx_config(&sb_early_cfg);
	//sb_early_cfg.StdHeader.Func = SB_POWERON_INIT;
	//AmdSbDispatcher(&sb_early_cfg);
	//TODO
	//AMD_IMAGE_HEADER was missing, when using AmdSbDispatcher,
	// VerifyImage() will fail, LocateImage() takes minutes to find the image.
	sbBeforePciInit(&sb_early_cfg);
	printk(BIOS_SPEW, "SB900 - Early.c - sb_before_pci_init - End.\n");
}

void sb_After_Pci_Init(void)
{
	AMDSBCFG sb_early_cfg;

	printk(BIOS_SPEW, "SB900 - Early.c - sb_After_Pci_Init - Start.\n");
	sb900_cimx_config(&sb_early_cfg);
	//sb_early_cfg.StdHeader.Func = SB_POWERON_INIT;
	//AmdSbDispatcher(&sb_early_cfg);
	//TODO
	//AMD_IMAGE_HEADER was missing, when using AmdSbDispatcher,
	// VerifyImage() will fail, LocateImage() takes minutes to find the image.
	sbAfterPciInit(&sb_early_cfg);
	printk(BIOS_SPEW, "SB900 - Early.c - sb_After_Pci_Init - End.\n");
}

void sb_Mid_Post_Init(void)
{
	AMDSBCFG sb_early_cfg;

	printk(BIOS_SPEW, "SB900 - Early.c - sb_Mid_Post_Init - Start.\n");
	sb900_cimx_config(&sb_early_cfg);
	//sb_early_cfg.StdHeader.Func = SB_POWERON_INIT;
	//AmdSbDispatcher(&sb_early_cfg);
	//TODO
	//AMD_IMAGE_HEADER was missing, when using AmdSbDispatcher,
	// VerifyImage() will fail, LocateImage() takes minutes to find the image.
	sbMidPostInit(&sb_early_cfg);
	printk(BIOS_SPEW, "SB900 - Early.c - sb_Mid_Post_Init - End.\n");
}

void sb_Late_Post(void)
{
	AMDSBCFG sb_early_cfg;
	u8 data;

	printk(BIOS_SPEW, "SB900 - Early.c - sb_Late_Post - Start.\n");
	sb900_cimx_config(&sb_early_cfg);
	//sb_early_cfg.StdHeader.Func = SB_POWERON_INIT;
	//AmdSbDispatcher(&sb_early_cfg);
	//TODO
	//AMD_IMAGE_HEADER was missing, when using AmdSbDispatcher,
	// VerifyImage() will fail, LocateImage() takes minutes to find the image.
	sbLatePost(&sb_early_cfg);

	//Set ACPI SCI IRQ to 0x9.
	data = CONFIG_ACPI_SCI_IRQ;
	outb(0x10, 0xC00);
	outb(data, 0xC01);
	outb(0x90, 0xC00);
	outb(data, 0xC01);

	if (data > 0x7) {
		data = inb(0x4D1);
		data |= (1 << (CONFIG_ACPI_SCI_IRQ - 8));
		outb(data, 0x4D1);
	} else {
		data = inb(0x4D0);
		data |= (1 << (CONFIG_ACPI_SCI_IRQ));
		outb(data, 0x4D0);
	}

	printk(BIOS_SPEW, "SB900 - Early.c - sb_Late_Post - End.\n");
}
