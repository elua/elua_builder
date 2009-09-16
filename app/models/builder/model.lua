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
			os.execute("cp -r -u "..path.."/rom_fs/"..v.filename.." "..dir.."/romfs")
		end
		local platform = platforms_by_targets()[build.configs.target]
		
		local sconstructStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES.."SConstruct", values,"string")
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
    	
    	-- Run scons
    	os.execute([[cd ]]..dir..[[;scons board=]]..build.configs.target..[[ -c ;scons  board=]]..build.configs.target..[[ prog > log_b.txt]])
		os.execute("cd "..dir..";zip ../build_"..build.id..".zip *.bin *.elf SConstruct log_b.txt src/platform/"..platform.."/platform_conf.h;rm -r *; mv ../build_"..build.id..".zip .")  
end


TARGETS = {
			{value ="EK-LM3S8962", platform = 'lm3s', disabled = false},
			{value ="EK-LM3S6965", platform = 'lm3s', disabled = false},
			{value ="SAM7-EX256", platform = 'at91sam7x', disabled = true},
			{value ="STR9-COMSTICK", platform = 'str9', disabled = true},
			{value ="PC", platform = 'i386', disabled = true},
			{value ="SIM", platform = 'sim', disabled = true},
			{value ="LPC-H2888", platform = 'lpc288x', disabled = true},
			{value ="MOD711", platform = 'str7', disabled = true},
			{value ="STM3210E-EVAL", platform = 'stm32', disabled = true},
			{value ="ATEVK1100", platform = 'avr32', disabled = true},
			{value ="ET-STM32", platform = 'stm32', disabled = true},
			{value ="EAGLE-100", platform = 'lm3s', disabled = true},
		}
function platforms_by_targets()
	local platforms = {}
	for i,v in pairs(TARGETS)do
		platforms[v.value] = v.platform or ""
	end
	return platforms
end
CHECK_DEFAULT_VALUE = {{label = "", value = "true"}}



