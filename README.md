# kwn
kernel without name

you need i686 cross compiler to build the kernel. to compile everything run bash script "build.sh"

### bash script options ###

you can run build.sh with several options.

### install ###

compile the kernel

### delete ###

clean kernel dir from source files

### * ###

if you parse anything else there will be an error

# manual kernel compiling

run in your terminal

i686-elf-as boot.s -o boot.o
i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
i686-elf-gcc -T linker.ld -o myos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc




