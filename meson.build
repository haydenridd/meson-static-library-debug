project('static_library_troubleshooting_meson',
	['c'],
	default_options : [
		'warning_level=3',
		'werror=false',
		'optimization=plain',
		'c_std=c11',
	],
	meson_version: '>=0.58.0',
	version: '0.1'
)

################################
# Project Options and Settings #
################################

# Compiler args
warning_flags = [
	# Disabled Warnings
	'-Wno-unknown-pragmas',
	'-Wno-padded',
	'-Wno-unused-parameter'
]

# These variables should be set for all combinations of compilers and native: true/false
compile_flags = [
	# Diagnostics
	'-fdiagnostics-show-option',
	# Compiler Optimization Flags
	'-ffunction-sections', # Place each function in its own section (ELF Only)
	'-fdata-sections', # Place each data in its own section (ELF Only)
	'-fdevirtualize', # Attempt to convert calls to virtual functions to direct calls
	'-fno-strict-aliasing', # See Linus describing issues w/ strict aliasing here https://www.mail-archive.com/linux-btrfs@vger.kernel.org/msg01647.html
	# Manually specify debug level
	'-O2',
	'-g0',
]

compile_flags += warning_flags
add_project_arguments(compile_flags, language: 'c')

# Linker args
link_flags = [
	'-Wl,--gc-sections', # Strip out unused function/data sections created by -ffunction-sections and -fdata-sections
	'-Wl,--print-memory-usage'
]

# Linker script
linker_script_path = meson.project_source_root() / 'linker_script' / 'STM32F750N8Hx_FLASH.ld'
link_flags += '-T' + linker_script_path

# For detecting changes to linker file and forcing re-linking
linker_script_deps = linker_script_path

map_file_format = '-Wl,-Map,@0@.map' # For adding a map file output to an executable
add_project_link_arguments(link_flags, language: 'c')

#######################
# Process Source Tree #
#######################
subdir('src')