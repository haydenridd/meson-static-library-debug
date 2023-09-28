APP_sources = ['main.c']

APP = executable('APP.elf',
	APP_sources,
	dependencies: [
		hal_dep,
	],
	install: false,
	link_args: [map_file_format.format(meson.current_build_dir() / 'APP')],
	link_depends: linker_script_deps
)

###############
# Run Targets #
###############
conf_data = configuration_data()
conf_data.set('firmware_filepath', meson.current_build_dir() / 'APP.elf')
configure_file(input : meson.project_source_root() / 'meson/jlink/load_firmware.jlink.in',
			output : 'load_firmware.jlink',
			configuration : conf_data)

command_list = [
	'/usr/bin/JLinkExe', '-device',  'STM32F750N8', 
	'-NoGui', '1', '-if', 'SWD', '-speed',  '4000', 
	'-autoconnect', '1', '-ExitOnError', '1',
	'-CommandFile', meson.current_build_dir() / 'load_firmware.jlink'
]
run_target('flash_jlink',
		command : command_list, depends: APP)
