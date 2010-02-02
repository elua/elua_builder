-- Builder application Model

module("builder.model", package.seeall)
sqlI = require "sqlInjection"
Build = mapper:new("builds")
BuildFile = mapper:new("builds_files")
lfs = require("lfs")

function getBuilds()
	local UserModel = require "user.model"
	user = UserModel.getCurrentUser()
	local builds = db:selectall("*","builds","user_id = "..user.id)
	return builds
end

function getBuild(id)
	local build = db:selectall("*","builds","id = "..id)
	return build[1]
end

local function checkDir()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local path = CONFIG.MVC_USERS..user.login
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end
	local path = path.."/builds"
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end
	local path = path.."/"..build.id
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end	
	return path
end

function save(values)
	local UserModel = require"user.model"
	local user = UserModel.getCurrentUser()
	values.user_id = user.id
	if tonumber(values.id) == nil then
		values.id = nil
	else
		values.created_at = values.created_at
	end
	
	local build = Build:new(values)
	obj, ok, err = build:save()
	return build
end

function saveBuildFile(file_id,build_id)
	local build_file = BuildFile:new({file_id = file_id,build_id = build_id})
	return build_file:save()
end

function update(configs, build_id)
	local build_configs = db:update ("builds", {configs = configs}, "id = "..build_id)
	return build_configs
end

function checkNotExistBuild(title)
	title = sqlI.sqlInjection(title,"string")
	local builds = db:selectall("*","builds","title = '"..title.."'")
	if (type(builds[1]) == "table")then 
		return false
	end
	return true
end

function copyPathFile(filename)
	local UserModel = require "user.model"
	local FileModel = require "file.model" 
	local user = UserModel.getCurrentUser()
	local dir = FileModel.checkDir()
	local path = CONFIG.MVC_USERS..user.login
	os.execute("cp -u "..CONFIG.ELUA_BASE..'romfs/'..filename.." "..path.."/rom_fs/"..filename.."")
end

function setDefaultValues(build)
	local COMPONENT_DEFAULT_VALUE = {build_xmodem = 'false', build_shell = 'false', build_romfs = 'false', build_term = 'false', build_uip = 'false', build_dhcpc = 'false', build_dns = 'false', build_con_generic = 'false', build_con_tcp = 'false', build_adc = 'false'}
	for i,v in pairs(COMPONENT_DEFAULT_VALUE) do
		build[i] = build[i] == nil and v or build[i]
	end
	return build
end

function delete(id)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local build = db:selectall("*","builds","id = "..id)
	local build_name = build[1].title
	local path = CONFIG.MVC_USERS..user.login.."/builds/"..id
	os.execute("rm -r "..path)
	if io.open(path,"r") == nil then
		local builds = db:delete ("builds","id = "..id)
		local files_build = db:delete ("builds_files", "build_id="..id)
	end
end

function deleteFilesFromBuild(build_id)
	return db:delete("builds_files", "build_id="..sqlI.sqlInjection(build_id,"number"))
end

function download(id)
	local UserModel = require "user.model"
	local FileModel = require"file.model" 
	local id = cgilua.QUERY.id
	local user = UserModel.getCurrentUser()
	local build = db:selectall("*","builds","id = "..id)
	local build_name = build[1].title
	
	io:tmpfile(CONFIG.MVC_TMP)
	open, errorMsg =io.open(CONFIG.MVC_USERS..user.login.."/builds/"..id.."/build_"..build[1].id..".zip", "rb")

   	if (open==nil) then --ops, something went wrong, file does not exists!
    	cgilua.put("<h2>".."The selected file does not exist".."</h2>")
   	else
   		fileSize = FileModel.getFileSize(open)
   		-- cgilua.header("Pragma", "public")
   		-- cgilua.header("Cache-Control", "must-revalidate, post-check=0, pre-check=0")
   		cgilua.header("Content-Type", "application/force-download")
   		cgilua.header("Content-Disposition",[[attachment; filename="]]..build_name..".zip")
   		cgilua.header("Content-Type", "application/octet-stream; name="..build_name..".zip")
   		cgilua.header("Content-Type", "application/octetstream; name="..build_name..".zip")
    	cgilua.header("Content-Transfer-Encoding", "binary")
    	cgilua.header("Content-Length ", fileSize)
    	while true do
    		local bytes = open:read(1024)
       		if not bytes then 
        		break
        	else
            	cgilua.put(bytes)
        	end
    	end
    	open:close()
   	end
end

function generate(id)
		local build = getBuild(tonumber(id))
		local name = build.title
		local dir = checkDir()
		local luaReports  = require "luaReports"
		local values = {}
		if (build.configs ~= nil and type(build.configs) == "string") then
			build.configs = assert(loadstring("return "..build.configs)())
		end
		build.configs = change_true_false(build.configs)
		--for i,v in pairs(change_true_false(build.configs))do
		--	cgilua.put(i,(v),"<br>")
		--end
		-- copy source files
		local UserModel = require "user.model"
		local user = UserModel.getCurrentUser()
		os.execute("cp -r "..CONFIG.ELUA_BASE.."* "..dir)
		
		-- copy romfs files
		local FileModel = require "file.model"
		local files = FileModel.getFilesByBuild(build.id)
		
		local path = CONFIG.MVC_USERS..user.login
		for i,v in pairs(files) do
			if(tonumber(v.id) == tonumber(build.configs.autorun_file_id))then
				os.execute("cp -u "..path.."/rom_fs/"..v.filename.." "..dir.."/romfs/autorun.lua")
				files[i].filename = "autorun.lua"
			else
				os.execute("cp -r -u "..path.."/rom_fs/"..v.filename.." "..dir.."/romfs")
			end	
		end
		local platform = platforms_by_targets()[build.configs.target]
		
		local sconstructStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES.."SConstruct", {files = files},"string")
		--error(sconstructStr)
		local platform_confStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES..platform.."_platform_conf.h", build.configs,"string")
		
		local destination = io.open(dir.."/SConstruct", "w")
		if destination then
    		destination:write(sconstructStr)
    		destination:close()
    	end
    	
    	local platform_save = io.open(dir.."/src/platform/"..platform.."/platform_conf.h", "w")
		if platform_save then
    		platform_save:write(platform_confStr)
    		platform_save:close()
    	end
    	
    	local toolchain_str = build.configs.toolchain == "default" and "" or " toolchain="..build.configs.toolchain
    	local lua_optimize_str = build.configs.lua_optimize == true and "optram=1" or ""
    	
    	local romfsmode_str = "romfs="..build.configs.romfsmode
    	
    	-- Run scons
		local scons_str = [[cd ]]..dir..[[;scons board=]]..build.configs.target..[[ -c ;scons board=]]..build.configs.target..[[ ]]..toolchain_str..[[ ]]..lua_optimize_str..[[ ]]..romfsmode_str..[[ prog > log_b.txt]]
    	local move_clear_str = "cd "..dir..";zip ../build_"..build.id..".zip *.bin *.elf SConstruct log_b.txt src/platform/"..platform.."/platform_conf.h;rm -r *; mv ../build_"..build.id..".zip ."

    	os.execute(scons_str)
		os.execute(move_clear_str)  
end

PLATFORM = {}
PLATFORM["EK-LM3S8962"] = {target ='EK-LM3S8962', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["EK-LM3S9B92"] = {target ='EK-LM3S9B92', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["EK-LM3S6965"] = {target ='EK-LM3S6965', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true', build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["EAGLE-100"] = {target ='EAGLE-100', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true', build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["SAM7-EX256"] = {target ='SAM7-EX256', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["STR9-COMSTICK"] = {target ='STR9-COMSTICK', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false',build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["STR-E912"] = {target ='STR-E912', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false',build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["PC"] = {target ='PC', toolchain = 'default', build_xmodem='false', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["SIM"] = {target ='SIM', toolchain = 'default', build_xmodem='false', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["LPC-H2888"] = {target ='LPC-H2888', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["MOD711"] = {target ='MOD711', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["ET-STM32"] = {target ='ET-STM32', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["STM3210E-EVAL"] = {target ='STM3210E-EVAL', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true'}
PLATFORM["ATEVK1100"] = {target ='ATEVK1100', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false'}
PLATFORM["ELUA-PUC"] = {target ='ELUA-PUC', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='true'}
--PLATFORM["MBED"] = {target ='MBED', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='true'}

TARGETS = {
			{value ="EK-LM3S8962", platform = 'lm3s', disabled = false},
			{value ="EK-LM3S9B92", platform = 'lm3s', disabled = false},
			{value ="EK-LM3S6965", platform = 'lm3s', disabled = false},
			{value ="EAGLE-100", platform = 'lm3s', disabled = false},	
			{value ="SAM7-EX256", platform = 'at91sam7x', disabled = false},
			{value ="MOD711", platform = 'str7', disabled = false},
			{value ="STR9-COMSTICK", platform = 'str9', disabled = false},
			{value="STR-E912", platform = 'str9', disabled = false},
			{value ="PC", platform = 'i386', disabled = false},
			{value ="SIM", platform = 'sim', disabled = false},
			{value ="LPC-H2888", platform = 'lpc288x', disabled = false},
			{value ="STM3210E-EVAL", platform = 'stm32', disabled = false},
			{value ="ET-STM32", platform = 'stm32', disabled = false},
			{value ="ATEVK1100", platform = 'avr32', disabled = false},
			{value="ELUA-PUC", platform = 'lpc24xx', disabled = false},
			{value ="MBED", platform = 'str9', disabled = true},
		}
		
TOOLCHAINS = {
				{value="default",option=locale_components.labels.toolchain_default, disabled = false},
				{value="codesourcery", option=locale_components.labels.toolchain_codesourcery, disabled = false},
				{value="EABI", option=locale_components.labels.toolchain_eabi, disabled = true},
				{value="Yagarto", option=locale_components.labels.toolchain_yagarto, disabled = true},
			}

ROMFSMODE = {
				{value="verbatim", option=locale_components.labels.romfsmode_verbatim, disabled=false},
				{value="compress", option=locale_components.labels.romfsmode_compressed, disabled=false},
				{value="compile", option=locale_components.labels.romfsmode_compiled, disabled=false},
}

function platforms_by_targets()
	local platforms = {}
	for i,v in pairs(TARGETS)do
		platforms[v.value] = v.platform or ""
	end
	return platforms
end
CHECK_DEFAULT_VALUE = {{label = "", value = "true"}}



