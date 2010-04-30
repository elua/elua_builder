-- Builder application Model

module("builder.model", package.seeall)
sqlI = require "sqlInjection"
Build = mapper:new("builds")
BuildFile = mapper:new("builds_files")
lfs = require("lfs")

function getBuilds()
	local UserModel = require "user.model"
	user = UserModel.getCurrentUser()
	local builds = db:selectall("*","builds","user_id = "..user.id,'order by created_at desc')
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

function saveBuildFile(file_id,build_id, category_id)
	local build_file = BuildFile:new({file_id = file_id,build_id = build_id, user_file = category_id})
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

function copyPathSuggestedFile(id)
	local UserModel = require "user.model"
	local FileModel = require "file.model" 
	local file_id = id
	local user = UserModel.getCurrentUser()
	local path = CONFIG.MVC_USERS..user.login
	local suggested_file = FileModel.getSuggestedFile(file_id)
	os.execute("cp -u "..CONFIG.MVC_ROMFS..suggested_file.category.."/"..suggested_file.filename.." "..path.."/rom_fs/"..suggested_file.filename)
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
   		cgilua.header("Content-Type", "application/download")
   		cgilua.header("Content-Type", [[application/octet-stream; name="]]..build_name..'.zip"')
   		cgilua.header("Content-Type", [[application/octetstream; name="]]..build_name..'.zip"')
    	cgilua.header("Content-Length", fileSize)
    	cgilua.header("Content-Transfer-Encoding", "binary")
    	cgilua.header("Content-Disposition",[[attachment; filename="]]..build_name..'.zip"')
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
local function setDefaultValues(configs)
	local defaults = {
			ip0 = "192",ip1 = "168", ip2 = "100", ip3 = "5",
			mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",
			gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",
			dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20",  
		}
	for i,v in pairs(defaults)do
		configs[i] = (configs[i] == "" or configs[i] == nil) and v or configs[i]
	end
end

function generate(build_obj)
	local build = getBuild(tonumber(build_obj.id))
	local name = build.title
	local dir = checkDir()
	local luaReports  = require "luaReports"
	local configs = nil
	local values = {}
	if (build.configs ~= nil and type(build.configs) == "string") then
		configs = assert(loadstring("return "..build.configs)())
		build.configs = assert(loadstring("return "..build.configs)())
	end
	setDefaultValues(build.configs)
	local files_id = build.configs.file_id
	
	-- copy source files
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	os.execute("cp -r "..CONFIG.ELUA_BASE.."* "..dir)
	-- removing files
	os.execute("rm -r "..dir.."/romfs/*")
	
	-- copy romfs files
	local FileModel = require "file.model"
	local path = CONFIG.MVC_USERS..user.login
	if (build.configs.autorun_file_id == nil or build.configs.autorun_file_id == "") then
		autorun_file_id = '0'
		autorun = autorun_file_id
	else
		local autorun_file_id = FileModel.getFileByID(build.configs.autorun_file_id)
		autorun = autorun_file_id.id
	end
	local build_files = FileModel.getFilesByBuild(tonumber(build.id))
	local size_file_id = #build_files
	for j = 1, size_file_id  do
		if tonumber(build_files[j].category_id) == 1 then		
			local filename = build_files[j].filename
			io:tmpfile(CONFIG.MVC_TMP)
			if (tonumber(build_files[j].file_id) == tonumber(autorun)) then
				os.execute("cp "..path.."/rom_fs/"..filename.." "..dir.."/romfs/autorun.lua")
				build_files[j].filename = 'autorun.lua'
			else
				os.execute("cp -r "..path.."/rom_fs/"..filename.." "..dir.."/romfs")
			end
		else
			local filename = build_files[j].filename
			local category = build_files[j].category
			local diretory_category = string.gsub(category,' ','_') 
			local path = CONFIG.MVC_ROMFS..diretory_category
			if (tonumber(build_files[j].file_id) == tonumber(autorun)) then
				os.execute("cp "..path.."/"..filename.." "..dir.."/romfs/autorun.lua")
				build_files[j].filename = 'autorun.lua'
			else
				os.execute("cp -r "..path.."/"..filename.." "..dir.."/romfs")
			end
		end
	end
	local files = build_files
	local platform = platforms_by_targets()[build.configs.target]
	build.configs = change_true_false(build.configs)
	local sconstructStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES.."SConstruct", {files = files},"string")
	--error(sconstructStr)
	local build_configs = CONFIGS
	local platform_confStr =luaReports.makeReport(CONFIG.MVC_TEMPLATES..platform.."_platform_conf.h", build_configs,"string")
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
	local scons_str = [[scons board=]]..build.configs.target..[[ ]]..toolchain_str..[[ ]]..lua_optimize_str..[[ ]]..romfsmode_str..[[ prog > log.txt 2> log_errors.txt;]]
	local move_clear_str = "cd "..dir..";zip ../build_"..build.id..".zip romfs/* *.bin *.elf SConstruct log*.txt src/platform/"..platform.."/platform_conf.h;rm -rf *; mv ../build_"..build.id..".zip ."
	local complement = [[export PATH=/usr/local/cross-cortex/bin:/usr/local/cross-cortex:/usr/local/cross-arm/bin:/usr/local/cross-arm:$PATH;cd ]]..dir..[[;]]
	configs.scons = scons_str
	update(tableToString(configs), build.id)
	
	os.execute(complement..scons_str)
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

CONFIGS = {
			build_xmodem='//', 
			build_shell='//', 
			build_romfs='//', 
			build_mmcfs='//', 
			build_term='//',
			build_uip='//',
			build_dhcpc='//',
			build_dns='//',
			build_con_generic='//',
			build_con_tcp='//',
			build_adc='//', 
			build_rpc='//',
}

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



