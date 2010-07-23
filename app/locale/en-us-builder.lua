locale_index = {
	copyright = "eluaproject.net",
	upload_title = "Upload",
	builds_title = "Build Configurations",
	edit_build_title = "Edit Build Configuration",
	new_build_title = "New Build Configuration",
	files_title = "Stored Files",
	label_progress = "Progress",
	label_back = "Back",
	label_remove = "Remove",
	label_edit = "Edit",
	label_actions = "Actions",
	label_download = "Download",
	label_addfile = "Add Files",
	label_select = "Add",
	open_file = "The selected file does not exist.",
	label_add_files = "Selected Files",
	label_autorun = "Autorun",
	label_remove_edit = "Remove/Edit",
	label_remove_download = "Remove/Download",
	files_romfs_title = "ROM File System",
	files_romfsmode_title = "ROMFS Build Mode",
	labels = {
				greeting = "Hello",
				filename = "File Name",
				created_at = "Uploaded at",
				title = "Build Name",
				id = "Id",
				configs = "Scons line command",
				newbuild = "New Build",
				title_build = "Build Configuration Name",
				title_MCU = "MCU",
				confirmDeleteFile= "Do you really want to remove this file?",
				confirmDeleteBuild= "Do you really want to remove this build?",
				logout = "Logout",
				edit_account = "Account",
				confirmDownloadFile = "Confirms download file?",
				open_file = "The selected file does not exist.",
				file_type = "Category",
				user_files = "Only user files",
				v07_files = "Only v0.7 files",
				default = "All files",
				basic = "Basic",
				advanced = "Advanced",
				mode = "Build Options Configuration",
				general = "General",
				net ="Network",
				luarpc = "LuaRPC",
				box_view = "Add Files",
				close_box = "Close",
				files_list = "Stored Files",
				home = "Home",
				file_systems = "File Systems",
				upload = "Upload Files",
	},
	validator = {
					title_build = "The field 'Build Name' must be filled in.",
					file_id = "Select a file",
					title_target =  "Select a Target",
					checkNotExistBuild = "This Build name has already been used.",
					ip_address = "The IP address",
					mask_address = "The subnet mask",
					gateway_address = "The gateway IP",
					dns_address = "The DNS",
					address_valid = "is not valid.",
					autorun = "You cannot have selected autorun option distinct of the physical autorun file.",
	}
}
	
locale_components = {
	target_title = "Target Platform",
	component_title = "Components",
	net_title = "Network",
	luarpc_title = "LuaRPC",
	toolchain_title = "Toolchain",
	lua_optimize = "Lua Optimize RAM Flag",
	file_systems_title = "File Systems",
	labels = {
				target = "Target",
				build_xmodem = "BUILD_XMODEM",
				build_shell = "BUILD_SHELL",
				build_romfs = "BUILD_ROMFS",
				build_term = "BUILD_TERM",
				build_uip = "BUILD_UIP",
				build_dhcpc = "BUILD_DHCPC",
				build_dns = "BUILD_DNS",
				build_con_generic = "BUILD_CON_GENERIC",
				build_con_tcp = "BUILD_CON_TCP",
				build_adc = "BUILD_ADC",
				build_rpc = "BUILD_RPC",
				build_mmcfs = "BUILD_MMCFS",
				toolchain_default = "Default",
				toolchain_codesourcery = "CodeSourcery",
				toolchain_eabi = "EABI",	
				toolchain_yagarto = "Yagarto",
				romfsmode_verbatim = "VERBATIM",
				romfsmode_compressed = "COMPRESSED",
				romfsmode_compiled = "COMPILED",
				ip = "IP Adress:",	
				mask = "Subnet Mask:",	
				dns = "DNS:",
				gateway = "Gateway IP:",
			},
	target_prompt = "Select your target",
	target_info = "The targeted platform for the build.",
	label_build = "Save",
	build_xmodem = "XModem Protocol support for file transfers on the eLua Terminal.",	
	build_shell = "A simple command line Shell for eLua.",
	build_romfs = "A simple Flash read-only File System.",
	build_term = "Video Terminal I/O support.",
	build_uip = "TCP/IP Stack suppor.t",
	build_dhcpc = "A DHCP client.",
	build_dns = "A DNS client.",
	build_con_generic = "Serial (UART) Console support.",
	build_con_tcp = "TCP/IP (Ethernet) Console support.",
	build_adc = "Analog to Digital Converter module support.",
	build_rpc = "",
	build_mmcfs = "",
}

locale_help ={
				build_configurations = [[
           This section keeps your previously saved build sessions, so you can reuse it over and over without having to reconfigure it's options.<br /> 
		  		 To create a <b>new build entry</b>, click on the <b>New Build</b> button, configure your options and (don't forget ! :) click on the <b>save</b> button.<br />
           The left icons on each list entry allows you to: <br />
             <img src='images/buttons/download.png' border='0' width=15 align='absbottom'/> Download eLua built with these configuration options<br />
             <img src='images/buttons/edit.png' border='0' width=15 align='absbottom'/> Edit the build configuration<br />
             <img src='images/buttons/delete.png' border='0' width=15 align='absbottom'/> Delete the build configuration<br />
           You can click on the column titles to sort the list by that key.<br />
				]],

				stored_files = [[
           This section allows you to upload files from your computer and store them in our servers for use on the eLua File Systems on your builds.<br />
           Press the <b>Browse</b> button to select the files you want to upload. Multiple selections are allowed.<br />
           The list shows your stored files and you can filter it with the small combo box options on the top left.<br />
           Files included on the official distros are always available for your builds.<br />
           The left icons on each list entry allows you to: <br />
              <img src='images/buttons/download.png' border='0' width=15 align='absbottom'/> Download the file<br/>
							<img src='images/buttons/delete.png' border='0' width=15 align='absbottom'/> Remove the file (only user files can be removed)<br/>
           You can click on the column titles to sort the list by that key.<br />

				]],

				stored_files_window = [[
           Click on the <b>+</b> icon to include the file on your build ROMFS<br />
				]],

				build = {
					main_build = [[ 
           Teste #########.<br />
						econd line.
				  ]],

					target_platform = [[ 
            Select on the combo box your desired target platform.<br />
          ]],

					ROM_FS = [[
            This section lists the files to be included in your ROM File System built with eLua.<br />
            Click on the top right <b>add files</b> icon to include files from your Stored Files list to the ROMFS on the build.<br />
            Click on any of the <Autorun> radio buttons to make that file an Autorun File on your build.<br />
            You can click on the column titles to sort the list by that key.<br />
          ]],

					options_configuration = [[
						<b>Basic</b> mode shows only the essential options for a simple build.<br />
            <b>Advanced</b> mode opens new tabs and offers more detailed options.<br />
            Click on the button of the mode you want to work with.<br />
 					]]
				},

				advanced_tabs = {
					toolchain = [[
            Select the toolchain you want to use for this build.<br />
          ]],

					romfs_mode = [[
            Select the mode you want to build your ROMFS<br />
              VERBATIM: Include files in the exact format you have uploaded (or the distro's originals)<br />
              COMPRESS: Removes every possible character that still keep the file semantically identical to the original<br />
              COMPILE: Compile the file and consider it's bytecode results as the file to be included in your ROMFS<br />
          ]],

					components = [[
						BUILD_TERM: Video Terminal I/O support<br />
						BUILD_SHELL: The eLua Shell<br />
						BUILD_XMODEM: XModem Protocol support for file transfers on the eLua Terminal<br />
						BUILD_ADC: Analog to Digital Converter module support<br />
						BUILD_RPC: Remote Procedure Call support<br />
					]],

					network = [[
						BUILD_CON_TCP: TCP/IP (Ethernet) Console support<br />
						BUILD_CON_GENERIC: Serial (UART) Console support<br />
						BUILD_UIP: TCP/IP Stack support<br /> 
						BUILD_DNS: A DNS client for the NET module<br />
						BUILD_DHCPC: A DHCP clientfor the NET module<br /> 
					]],

					file_systems = [[
						BUILD_ROMFS: Flash read-only File System support<br />
						BUILD_MMCFS: The SD/MMC File System support<br />
					]]
				}
}
