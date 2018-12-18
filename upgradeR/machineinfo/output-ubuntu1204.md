
$ sh machineinfo.sh 

#################################################################
## Ubuntu Version: $lsb_release -a
No LSB modules are available.
Distributor ID:	Ubuntu
Description:	Ubuntu 12.04.4 LTS
Release:	12.04
Codename:	precise
#################################################################
## Machine Arquitecture: $uname -a
Linux N55SL 3.4.0-030400-generic #201205210521 SMP Mon May 21 09:28:36 UTC 2012 i686 i686 i386 GNU/Linux
#################################################################
## CPU INFO: $grep -E: (^model name|^vendor_id|^flags) /proc/cpuinfo | sort | uniq
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx rdtscp lm constant_tsc arch_perfmon pebs bts xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer xsave avx lahf_lm ida arat epb xsaveopt pln pts dts tpr_shadow vnmi flexpriority ept vpid
model name	: Intel(R) Core(TM) i7-2670QM CPU @ 2.20GHz
vendor_id	: GenuineIntel
#################################################################
#GRAPHIC CARD INFO:  $lspci -vnn | grep VGA -A 12
00:02.0 VGA compatible controller [0300]: Intel Corporation 2nd Generation Core Processor Family Integrated Graphics Controller [8086:0116] (rev 09) (prog-if 00 [VGA controller])
	Subsystem: ASUSTeK Computer Inc. Device [1043:212b]
	Flags: bus master, fast devsel, latency 0, IRQ 55
	Memory at dc400000 (64-bit, non-prefetchable) [size=4M]
	Memory at b0000000 (64-bit, prefetchable) [size=256M]
	I/O ports at e000 [size=64]
	Expansion ROM at <unassigned> [disabled]
	Capabilities: <access denied>
	Kernel driver in use: i915
	Kernel modules: i915

00:16.0 Communication controller [0780]: Intel Corporation 6 Series/C200 Series Chipset Family MEI Controller #1 [8086:1c3a] (rev 04)
	Subsystem: ASUSTeK Computer Inc. Device [1043:1347]
--
01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GF116M [GeForce GT 555M/635M] [10de:1247] (rev ff) (prog-if ff)
	!!! Unknown header type 7f

03:00.0 Network controller [0280]: Intel Corporation Centrino Wireless-N 1030 [Rainbow Peak] [8086:008a] (rev 34)
	Subsystem: Intel Corporation Centrino Wireless-N 1030 BGN [8086:5305]
	Flags: bus master, fast devsel, latency 0, IRQ 56
	Memory at ddc00000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: <access denied>
	Kernel driver in use: iwlwifi
	Kernel modules: iwlwifi

04:00.0 USB controller [0c03]: ASMedia Technology Inc. ASM1042 SuperSpeed USB Host Controller [1b21:1042] (prog-if 30 [XHCI])
	Subsystem: ASUSTeK Computer Inc. Device [1043:1059]
#################################################################
## gcc version: $gcc --version -O3 -std=c99
gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
Copyright (C) 2011 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.



