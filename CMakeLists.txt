cmake_minimum_required(VERSION 3.23)

# Directory definitions
set(REPO_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

# Project definition
project(
    static_library_troubleshooting_cmake
    VERSION 0.0.1
    DESCRIPTION "Debugging static library issues w/ Meson using CMake for comparison"
    LANGUAGES C ASM
)

# Define executable
set(EXECUTABLE_NAME "APP_cmake")
add_executable(${EXECUTABLE_NAME})

# Compiler args
set(WARNING_FLAGS
	# Disabled Warnings
	-Wno-unknown-pragmas
	-Wno-padded
	-Wno-unused-parameter
)

set(OPT_FLAGS
    -O2 -g0
)

set(COMPILE_FLAGS
    # Diagnostics
	-fdiagnostics-show-option
	# Compiler Optimization Flags
	-ffunction-sections
	-fdata-sections
	-fdevirtualize
	-fno-strict-aliasing
)

target_compile_options(${EXECUTABLE_NAME} PUBLIC
    "${WARNING_FLAGS}"
    "${COMPILE_FLAGS}"
	"${OPT_FLAGS}"
)

# Linker args
set(LINKER_ARGS 
    -Wl,--gc-sections    
    -Wl,--print-memory-usage
    -Wl,-Map=${EXECUTABLE_NAME}.map
)

# Linker script
set(LINKER_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/linker_script/STM32F750N8Hx_FLASH.ld)

# TODO: change to "add_link_options" ?
target_link_options(${EXECUTABLE_NAME} PUBLIC
    ${LINKER_ARGS}
   -T${LINKER_SCRIPT}
)

# Add project source directory
add_subdirectory(src)

# Flash using JLINK
include(${REPO_ROOT_DIR}/cmake/jlink/find_jlink.cmake)

# Edit flash file to include target specific stuff
set(JLINK_FLASH_TARGET_FILE ${CMAKE_CURRENT_SOURCE_DIR}/build/${EXECUTABLE_NAME}.elf)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/jlink/flash.jlink.in ${CMAKE_CURRENT_SOURCE_DIR}/cmake/jlink/flash.jlink)

# JLink specific targets
add_custom_target(flash 
    COMMAND ${JLINK} -device STM32F750N8 -speed 4000 -if SWD -NoGui 1 -CommanderScript ${CMAKE_CURRENT_SOURCE_DIR}/cmake/jlink/flash.jlink 
    DEPENDS ${EXECUTABLE_NAME}
)

add_custom_target(reset 
    COMMAND ${JLINK} -device STM32F750N8 -speed 4000 -if SWD -NoGui 1 -CommanderScript ${CMAKE_CURRENT_SOURCE_DIR}/cmake/jlink/reset.jlink 
)