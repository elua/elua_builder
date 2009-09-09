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
	--local path_build = CONFIG.MVC_USERS..user.login.."/builds/"..id.."/"..build_name..".bin"
	--local path_scontruct = CONFIG.MVC_USERS..user.login.."/builds/"..id.."/".."SConstruct"
	--os.remove(path_build)
	--os.remove(path_scontruct)
	
	local files = lfs.dir(path)
	local file = files()
	while file do
		os.remove(path.."/"..file)
		file = files()
	end
	
	if lfs.rmdir(path)then
		local builds = db:delete ("builds","id = "..id)
		local files_build = db:delete ("builds_files", "build_id="..id)
	end
	
end

function generate(id)
		local build = getBuild(tonumber(id))
		local name = build.title
		local dir = checkDir()
		local luaReports  = require "luaReports"
		local values = {}
		-- copy de source files
		os.execute("cp -r "..CONFIG.ELUA_BASE.."* "..dir)
		
		local sconstructStr = luaReports.makeReport(CONFIG.MVC_TEMPLATES.."SConstruct", values,"string")

		local destination = io.open(dir.."/SConstruct", "w")
		if destination then
    		destination:write(sconstructStr)
    		destination:close()
    	end
    	-- Run scons
    	os.execute([[cd ]]..dir..[[;scons board=EK-LM3S8962 -c > log_c.txt;scons  board=EK-LM3S8962 prog > log_b.txt]])
		
end


TARGETS = {
			{value ="EK-LM3S8962", disabled = false},
			{value ="EK-LM3S6965", disabled = false},
			{value ="SAM7-EX256", disabled = true},
			{value ="STR9-COMSTICK", disabled = true},
			{value ="PC", disabled = true},
			{value ="SIM", disabled = true},
			{value ="LPC-H2888", disabled = true},
			{value ="MOD711", disabled = true},
			{value ="STM3210E-EVAL", disabled = true},
			{value ="ATEVK1100", disabled = true},
			{value ="ET-STM32", disabled = true},
			{value ="EAGLE-100", disabled = true},
		}
CHECK_DEFAULT_VALUE = {{label = "", value = "true"}}



