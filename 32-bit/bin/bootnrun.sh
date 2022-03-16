nasm -f bin ../src/boot.asm -o ../bin/boot.bin
sudo qemu-system-x86_64 ../bin/boot.bin
