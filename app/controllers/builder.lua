-- Builder application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------


function index()
	local UserModel = require "user.model"
	local BuildModel = require "builder.model"
	current_user = UserModel.getCurrentUser()
	render("index.lp")
end

function files()
	
	build =  {}
	id = cgilua.QUERY.id
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	BuildModel = require "builder.model"
	
	for _,v in pairs(BuildModel.TARGETS) do 
		v.option = v.value
	end
	local val = require "validation"
	local validator = val.implement.new(build)
	
	if tonumber(id) then
		build = BuildModel.getBuild(id)
		
		if (build.configs ~= nil and type(build.configs) == "string") then
			build.configs = assert(loadstring("return "..build.configs)())
		end
		render("files.lp")
	else
		build.configs = {}
		if isPOST() then
			build = cgilua.POST
			build = BuildModel.setDefaultValues(build)
			build.file_id = (build.file_id == nil) and "" or build.file_id 
			--cgilua.put(tableToString(cgilua.POST))
			
			build.configs = tableToString(build)
			validator:validate('title',locale_index.validator.title_build, val.checks.isNotEmpty)
			validator:validate('title',locale_index.validator.checkNotExistBuild, BuildModel.checkNotExistBuild)
			validator:validate('file_id', locale_index.validator.file_id, val.checks.isNotEmpty)
			validator:validate('target',locale_index.validator.title_target, val.checks.isNotEmpty)
			if(validator:isValid())then
				
				local build_obj = BuildModel.save(build)
				if (type(build.file_id) == "table") then
					for _,file_id in pairs(build.file_id)do
						BuildModel.saveBuildFile(file_id,build_obj.id)
					end
				else
					BuildModel.saveBuildFile(build.file_id,build_obj.id)
				end
				redirect({control='builder',act='index'})
			else
				flash.set('validationMessagesBuild',validator:htmlMessages())
				render("files.lp")
			end
		else
			render("files.lp")
		end
	end
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