-- Builder application Model

module("builder.model", package.seeall)
sqlI = require "sqlInjection"
Build = mapper:new("builds")
BuildFile = mapper:new("builds_files")

function getBuilds()
	local UserModel = require "user.model"
	user = UserModel.getCurrentUser()
	local builds = db:selectall("*","builds","user_id = "..user.id)
	return builds
end

function save(values)
	local UserModel = require"user.model"
	local user = UserModel.getCurrentUser()
	values.user_id = user.id
	local build = Build:new(values)
	build:save()
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
