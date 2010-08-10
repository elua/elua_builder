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

function validate(build)
	local val = require "validation"
	local validator = val.implement.new(build)

	validator:validate('title',locale_index.validator.title_build, val.checks.isNotEmpty)
	validator:validate('target',locale_index.validator.title_target, val.checks.isNotEmpty)
	validator:validate('autorun_file_id',locale_index.validator.autorun, checkAutorun, build.file_id)
	return validator
end

function checkAutorun(autorun_file_id, file_ids)
	if (autorun_file_id ~= '' and autorun_file_id ~= nil)then
		local FileModel = require "file.model"
		local autorun_file = FileModel.getFileByID(autorun_file_id)
		local files = FileModel.getFilesByIDs(file_ids)
		
		for i,v in pairs(files) do
			if (v.filename == 'autorun.lua' and not(v.file_id == autorun_file.id and v.category_id == autorun_file.category_id)) then
				return false
			end
		end
	end
	return true
end

local function checkDir(build)
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
	local diretory_category = string.gsub(suggested_file.category,' ','_') 
	os.execute("cp -u "..CONFIG.MVC_ROMFS..diretory_category.."/"..suggested_file.filename.." "..path.."/rom_fs/"..suggested_file.filename)
end

function setDefaultValues(build)
	local COMPONENT_DEFAULT_VALUE = {build_xmodem = 'false', build_shell = 'false', build_romfs = 'false', build_term = 'false', build_uip = 'false', build_dhcpc = 'false', build_dns = 'false', build_con_generic = 'false', build_con_tcp = 'false', build_adc = 'false'}
	for i,v in pairs(COMPONENT_DEFAULT_VALUE) do
		build[i] = build[i] == nil and v or build[i]
	end
	return build
end

function delete(id)
	if (tonumber(id)) then
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
	local build_name = string.gsub(build[1].title,'[\/:?"<>|]','_')
	
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
function setDefaultValues(configs)
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

function copy_romfs(build, build_dir)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local FileModel = require "file.model"
	local user_folder = CONFIG.MVC_USERS..user.login
	local autorun_file_id = (build.configs.autorun_file_id == nil or build.configs.autorun_file_id == "") and 0 or FileModel.getFileByID(build.configs.autorun_file_id).id
	local build_files = FileModel.getFilesByBuild(tonumber(build.id))

	local scons_files = {} 
	for j,file in pairs(build_files) do
		local source_path = tonumber(file.category_id) == 1 and user_folder.."/rom_fs" or CONFIG.MVC_ROMFS..string.gsub(file.category ,' ','_')
		local file_name = (tonumber(file.file_id) == tonumber(autorun_file_id)) and "autorun.lua" or file.filename 
		local destination = build_dir.."/romfs/"..file_name
		os.execute("cp '"..source_path.."/"..file.filename.."' '"..destination.."'")
		if file_name ~= "autorun.lua" then
			table.insert(scons_files, {filename = file_name})
		end
	end
	return scons_files
end


function generate(build_obj)
	require "cosmo"
	local build = getBuild(tonumber(build_obj.id))
	local name = build.title
	local dir = checkDir(build)
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
	-- removing files
	--os.execute("rm "..dir.."/*.bin;rm "..dir.."/*.elf" )
	
	os.execute('if [ -d "'..dir..'" ]; then; cd '..dir..';rm -rf; fi;')
	--coping elua base
	os.execute("cp -r "..CONFIG.ELUA_BASE.."* "..dir)
	-- clear romfs files
	os.execute("rm -r "..dir.."/romfs/*")
	
	-- copy romfs files
	local scons_files = copy_romfs(build, dir)
	
	local platform = platforms_by_targets()[build.configs.target]
	build.configs = change_true_false(build.configs)
	local sconstructStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES.."SConstruct", {files = scons_files},"string")
	--error(sconstructStr)
	
	local platform_confStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES..platform.."_platform_conf.h", build.configs,"string")
	
	local platform_confStr = cosmo.fill(platform_confStr,CONFIGS)
	
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
	
	local complement = [[export PATH=/opt/codesourcery/bin:/usr/local/]]..PLATFORM[build.configs.target].compile..[[:/usr/local/]]..PLATFORM[build.configs.target].compile..[[/bin:$PATH;cd ]]..dir..[[;]]
	configs.scons = scons_str
	update(tableToString(configs), build.id)
	
	os.execute(complement..scons_str)
	os.execute(move_clear_str)  
end

PLATFORM = {}
PLATFORM["EK-LM3S8962"] = {compile = 'cross-cortex', target ='EK-LM3S8962', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["EK-LM3S9B92"] = {compile = 'cross-cortex', target ='EK-LM3S9B92', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["EK-LM3S6965"] = {compile = 'cross-cortex', target ='EK-LM3S6965', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true', build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["EAGLE-100"] = {compile = 'cross-arm', target ='EAGLE-100', toolchain = 'codesourcery', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true', build_uip='true',build_dhcpc='false',build_dns='true',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["SAM7-EX256"] = {compile = 'cross-arm', target ='SAM7-EX256', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["STR9-COMSTICK"] = {compile = 'cross-arm', target ='STR9-COMSTICK', toolchain = 'codesourcery', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false',build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["STR-E912"] = {compile = 'cross-arm', target ='STR-E912', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false',build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["PC"] = {compile = 'cross-arm', target ='PC', toolchain = 'default', build_xmodem='false', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["SIM"] = {compile = 'cross-arm', target ='SIM', toolchain = 'default', build_xmodem='false', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["LPC-H2888"] = {compile = 'cross-arm', target ='LPC-H2888', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["MOD711"] = {compile = 'cross-arm', target ='MOD711', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["ET-STM32"] = {compile = 'cross-arm', target ='ET-STM32', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["STM3210E-EVAL"] = {compile = 'cross-arm', target ='STM3210E-EVAL', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='true', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='true', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["ATEVK1100"] = {compile = 'cross-arm', target ='ATEVK1100', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='false',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
PLATFORM["ELUA-PUC"] = {compile = 'cross-arm', target ='ELUA-PUC', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
--PLATFORM["MBED"] = {compile = 'cross-cortex', target ='MBED', toolchain = 'default', build_xmodem='true', build_shell='true', build_romfs='true', build_mmcfs='false', build_term='true',build_uip='false',build_dhcpc='false',build_dns='false',build_con_generic='true',build_con_tcp='false',build_adc='false', build_rpc='true',ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5", mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}

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



