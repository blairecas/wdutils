Some utilities and ROM code for working with HDD on MS-0511
(!) do not use them except wdinit.dsk (!)

wdinit.dsk
floppy disk image to help init WD HDD
will write block 0 and minimal RT-11 partition on WD0

wdr2.sav
replacement resident for wdr.sav from Oleg H.
slower, bigger (and uncut :) etc..
changed to lba28 and added 'flush cache'

ide_wdromv0110.bin
ide_wdromv0200.bin
original and my ROM cartridge images

m324pa.raw
flash data (ver 3.6 with ide_wdromv0200.bin) for atmega on KAKAVE board
it's for 14.7456MHz oscillator version, 324pa chip

hdsend.exe, hdsend.bin
read and write MS0511 HDD data over RS-232
(!) images data is NOT inverted for this program


-----------------------------------
HDD WD image format used in MS-0511
-----------------------------------

Data is inverted on HDD device (because of PDP-11 bus)

Block 0 (CHS 0:0:1)
-------------------
0x0000 (byte) sectors for track (e.g. 63)
0x0001 (byte) heads count (e.g. 16)
0x0002 (word) RT-11 partition 0 size in blocks
0x0004 (word) RT-11 partition 1 size
..
0x0030 (word) RT-11 partition 23 size
.. (unknown)
0x0050 (word) 0x003x ascii code of last selected partition number (0..7)
0x0052 (word) number of 50Hz ticks to wait for user input at boot
0x0054 (word) 0x03E8 whats this? sort of magic number
.. (unknown)
0x01FC (word) chksumm negative (neg) low word (32-bit summ of first 254 words)
0x01FE (word) chksumm inverted (com) high word (32-bit summ of first 254 words)

Block 1 (CHS 0:0:2) .. 
----------------------
RT-11 partitions data (usual .dsk format)
http://www.bitsavers.org/pdf/dec/pdp11/rt11/v5.6_Aug91/AA-PD6PA-TC_RT-11_Volume_and_File_Formats_Manual_Aug91.pdf
Logical block 0 of .dsk can be WD bootloader code

standard WD HDD cartridge ROM will do next things on boot:
- test checksum on block 0 (will work with wrong checksum)
- wait some time (50Hz ticks on addr 0x0052 in block 0) allowing user 
  to select partition number for boot
  will not wait if only one partition
- load first block of that partition to CPU addr 0 and set CPU PC=0
- ...
- profit ^_^

Bootloader (first block of that partition) MUST not use addrs @#144, @#146. 
So that code in bootloader is safe:
  .=0
  br 200
  .=200
  main bootloader code 
