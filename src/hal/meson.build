# Required defines for HAL/Chip Selection
hal_device_name = 'STM32F750xx'
compile_args = []
compile_args += '-D@0@'.format(hal_device_name)
compile_args += '-DUSE_HAL_DRIVER'

hal_incdirs = []
hal_srcs    = []

hal_incdirs += include_directories('.')
hal_incdirs += include_directories('Drivers')
hal_incdirs += include_directories('Drivers/STM32F7xx_HAL_Driver/Inc')
hal_incdirs += include_directories('Drivers/CMSIS/Device/ST/STM32F7xx/Include')
hal_incdirs += include_directories('Drivers/CMSIS/Include')

hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_cortex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_tim_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_rcc_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_flash_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_dma_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_pwr_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_i2c_ex.c')]
hal_srcs += [files('Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_exti.c')]

hal_srcs += [files('cubemx_main.c')]
hal_srcs += [files('startup_stm32f750xx.s')]
hal_srcs += [files('stm32f7xx_hal_msp.c')]
hal_srcs += [files('stm32f7xx_it.c')]
hal_srcs += [files('system_stm32f7xx.c')]

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