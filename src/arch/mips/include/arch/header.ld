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

/* We use ELF as output format. So that we can debug the code in some form. */
OUTPUT_ARCH(mips)

PHDRS
{
	to_load PT_LOAD;
}

#ifdef __BOOTBLOCK__
ENTRY(_start)
#else
ENTRY(stage_entry)
#endif
