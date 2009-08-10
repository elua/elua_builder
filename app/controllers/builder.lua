-- Builder application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------


function index()
	local UserModel = require "user.model"
	current_user = UserModel.getCurrentUser()
	render("index.lp")
end

function files()
	build = cgilua.POST or {}
	local BuildModel = require "builder.model"
	local val = require "validation"
	local validator = val.implement.new(build)
	
	if isPOST() then
		build.file_id = (build.file_id == nil) and "" or build.file_id 
			
		validator:validate('title',locale_index.validator.title_build, val.checks.isNotEmpty)
		validator:validate('title',locale_index.validator.checkNotExistBuild, BuildModel.checkNotExistBuild)
		validator:validate('file_id', locale_index.validator.file_id, val.checks.isNotEmpty)
		
		if(validator:isValid())then
			local build_obj = BuildModel.save(build)
			if (type(build.file_id) == "table") then
				for _,file_id in pairs(build.file_id)do
					BuildModel.saveBuildFile(file_id,build_obj.id)
				end
			else
				BuildModel.saveBuildFile(build.file_id,build_obj.id)
			end
			redirect({control="builder", act="components"})
		else
			flash.set('validationMessagesBuild',validator:htmlMessages())
			render("files.lp")
		end
	else
		render("files.lp")
	end
end

function components()
	id = cgilua.QUERY.id
	BuilderModel = require "builder.model"
	for _,v in pairs(BuilderModel.TARGETS) do 
		v.option = v.value
	end
	render("components.lp")
end

function generate()
	components = cgilua.POST
	local BuildModel = require "builder.model"
	local val = require "validation"
	local validator = val.implement.new(components)
	
	validator:validate('target',locale_index.validator.title_target, val.checks.isNotEmpty)
	
	if(validator:isValid())then
		
		local config_str = "config = {"
		for i,v in pairs(components) do
			config_str = config_str.. i.."='"..tostring(v).."',"
		end
		config_str = config_str .."}"	
		build = BuildModel.update(config_str, components.build_id)
		redirect({control="builder", act="index"})
		else
			flash.set('validationMessagesBuild',validator:htmlMessages())
			render("files.lp")
		end
	render "generated.lp"
end

function repository()
	local startIndex = cgilua.QUERY.startIndex
	local results = cgilua.QUERY.results
	local sort = cgilua.QUERY.sort
	local dir  = cgilua.QUERY.dir
	local query = cgilua.QUERY
	 	
	local BuilderModel = require("builder.model")
	local items = BuilderModel.getBuilds()
	 
	local DT = require("dataTable")
	local rep = DT.repository:new(items,{startIndex=startIndex,results=results,sort=sort,dir=dir})
	 
	rep:response('text','plain','UTF-8')
end

function delete()
	local UserModel = require "user.model"
	local id = cgilua.QUERY.id
	local user = UserModel.getCurrentUser()
	local build = db:selectall("*","builds","id = "..id)
	local builds = db:delete ("builds","id = "..id)
	redirect({control="builder", act="index"})
end