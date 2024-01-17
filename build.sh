#!/bin/bash

if i686-elf-gcc --version; then
	echo detected gcc crosscompiler
else
	echo "please install/comile gcc crosscompiler. If you have it installed, please set it in path. Otherwise script is going to fail"
	exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
	  -d|--delete)
		  	echo deleting
			COMPILE=0
			shift
	  
			;;

         -i|--install)
              COMPILE=1
              echo installing
			 shift
			 ;;
			
		 	-*|--*)
      			echo "Unknown option $1"
      			shift
				exit 1
      		;;

	esac
done


if [[ "$COMPILE" == "1" ]]; then
i686-elf-as boot.s -o boot.o
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

elif [[ "$COMPILE" == "0" ]]; then
	rm boot.o
	rm kernel.o
	rm myos.bin
fi

if grub-file --is-x86-multiboot myos.bin; then
  echo kernel multiboot confirmed.
else
  echo the file is not multiboot. Try checking _start pointer. If this is not heplping, idk, turn off your pc
fi
