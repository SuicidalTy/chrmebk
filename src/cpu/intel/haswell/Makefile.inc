ramstage-y += haswell_init.c
ramstage-y += tsc_freq.c
romstage-y += romstage.c
romstage-y += tsc_freq.c
romstage-y += ../car/romstage.c

postcar-y += tsc_freq.c

ramstage-y += acpi.c
ramstage-$(CONFIG_HAVE_SMI_HANDLER) += smmrelocate.c

smm-y += finalize.c
smm-y += tsc_freq.c

bootblock-y += ../car/non-evict/cache_as_ram.S
bootblock-y += ../car/bootblock.c
bootblock-y += ../../x86/early_reset.S
bootblock-y += bootblock.c
bootblock-y += tsc_freq.c

postcar-y += ../car/non-evict/exit_car.S

verstage-y += tsc_freq.c

subdirs-y += ../../x86/tsc
subdirs-y += ../../x86/mtrr
subdirs-y += ../../x86/lapic
subdirs-y += ../../x86/cache
subdirs-y += ../../x86/smm
subdirs-y += ../microcode
subdirs-y += ../turbo
subdirs-y += ../common

cpu_microcode_bins += $(wildcard 3rdparty/intel-microcode/intel-ucode/06-3c-*)
cpu_microcode_bins += $(wildcard 3rdparty/intel-microcode/intel-ucode/06-45-*)
