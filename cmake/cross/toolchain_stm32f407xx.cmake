# Defining ARM GCC toolchain
set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}c++)
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE ${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

# Target system
set(CMAKE_SYSTEM_PROCESSOR ARM)

 # Set some language/extensions standards
 set(CMAKE_C_STANDARD 11)
 set(CMAKE_C_STANDARD_REQUIRED ON)
 set(CMAKE_C_EXTENSIONS OFF)
 set(CMAKE_CXX_STANDARD 17)
 set(CMAKE_CXX_STANDARD_REQUIRED ON)
 set(CMAKE_CXX_EXTENSIONS OFF)

 # Generate .elf files
 set(CMAKE_EXECUTABLE_SUFFIX_C   .elf)
 set(CMAKE_EXECUTABLE_SUFFIX_CXX .elf)
 set(CMAKE_EXECUTABLE_SUFFIX_ASM .elf)

# ARM Parameters
set (CORTEX_MCU         cortex-m7    )
set (CORTEX_ABI         aapcs        )
set (CORTEX_FLOAT_ABI   hard         )
set (CORTEX_FPU         fpv5-sp-d16  )

set(CPU_PARAMETERS
    -mcpu=${CORTEX_MCU}
    -mfloat-abi=${CORTEX_FLOAT_ABI}
    -mfpu=${CORTEX_FPU}
    -mabi=${CORTEX_ABI}
    -mthumb
)

add_compile_options(
  "${CPU_PARAMETERS}"
)

# Specific MCU utilizing ARM
set (MCU_MODEL          STM32F750xx)

# Embedded defines for vendor code
set(TOOLCHAIN_DEFINES
    ${MCU_MODEL}
    USE_HAL_DRIVER
)

# Defines
add_compile_definitions(
    ${TOOLCHAIN_DEFINES}
)

# Linker settings
set(TOOLCHAIN_LINKER_FLAGS
    --specs=nano.specs
    --specs=nosys.specs
)

add_link_options(
  ${CPU_PARAMETERS}
  ${TOOLCHAIN_LINKER_FLAGS}
)