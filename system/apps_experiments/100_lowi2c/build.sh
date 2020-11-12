#https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads
set -e

mkdir -p build
cd build

arm-none-eabi-g++ -Os -Werror -fno-common -mcpu=cortex-m3 -mthumb -msoft-float -fno-exceptions -fno-rtti -fno-threadsafe-statics -Wno-psabi -DLA104 -DARDUINO=1000 -MD -D _ARM -D STM32F10X_HD -D STM32F10X_HD -c \
  ../source/main.cpp \
  ../source/stm32/stm32f10x_i2c.c -I../../../os_library/include/ -I../source/stm32
arm-none-eabi-gcc -fPIC -mcpu=cortex-m3 -mthumb -o output.elf -nostartfiles -T ../source/app.lds \
  ./main.o \
  ./stm32f10x_i2c.o -lbios_la104 -L../../../os_library/build

arm-none-eabi-objdump -d -S output.elf > output.asm
arm-none-eabi-readelf -all output.elf > output.txt

find . -type f -name '*.o' -delete
find . -type f -name '*.d' -delete

../../../../tools/elfstrip/elfstrip output.elf 100i2ct.elf
