# Meson Static Library Conundrum

This repo exists to try to help isolate an issue I'm seeing with static libraries with the `arm-none-eabi` toolchain.

## System Information
- Host system info:
    ```
    Operating System: Fedora Linux 37 (Workstation Edition)
        CPE OS Name: cpe:/o:fedoraproject:fedora:37
            Kernel: Linux 6.4.12-100.fc37.x86_64
        Architecture: x86-64
    Hardware Vendor: Lenovo
    Hardware Model: ThinkPad X1 Carbon Gen 10
    Firmware Version: N3AET72W (1.37 )
    ```
- Compiler: `gcc-arm-none-eabi: 10.3-2021.10`
- Compiling for target: `STM32F750N8`

## The Problem
- I've created a very simple "blinky" test app that utilizes ST Micro's HAL to startup the MCU, and blink an LED
- The directory structure is very simple:
  - `src/main.c` - My blinky code
  - `src/hal/*` - STM supplied HAL with startup assembly, drivers, etc.
- If you go to the build file for the HAL i've writen: `src/hal/meson.build` you will see a critical code block:

```
############### Does NOT work ###############
lib_hal = static_library('hal',
    hal_srcs,
    include_directories: hal_incdirs,
    install: false,
    build_by_default: false,
    c_args: compile_args
)

hal_dep = declare_dependency(
    include_directories: hal_incdirs,
    link_with: lib_hal,
    compile_args: compile_args
)
#############################################

################# Works #################
# hal_dep = declare_dependency(
#     include_directories: hal_incdirs,
#     sources: hal_srcs,
#     compile_args: compile_args
# )
#########################################
```
- It's relatively self explanatory, when a dependency is added with raw sources, everything works fine
- However, when HAL is instead compiled as a static library, and then linked in, things go awry
- Specifically, the ISR routines don't seem to work, and examining a diff of `objdump -x` between the two binaries it seems that things are getting put at *slightly* different locations when the HAL is a static library

## CMake Comparison
- CMake files also exist in this repo to demonstrate that building the HAL as a static library using CMake (also with `ninja` as a backend) works just fine
- Interestingly, if you diff `objdump -x` for the working meson `.elf` file (no static library) and the cmake `.elf` file you'll see all symbols are at the exact same location!
- So something specifically is happening in how meson is handling the static library...

## Replication Info
- Commands for building using `meson`:
  - `meson setup --wipe --cross-file meson/cross/STM32F750xx.txt buildresults`
  - `meson compile -C buildresults`
- Commands for building using `CMake`:
  - `cmake -B build -S . --preset default`
  - `cmake --build --preset build`
- Flashing to device:
  - Only relevant if you have this MCU laying around which I understand is unlikely, but figured I would include it :)
  - `meson compile -C buildresults/ flash_jlink`
  - OR
  - `cmake --build --preset flash`