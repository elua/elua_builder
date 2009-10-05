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
	local FileModel = require "file.model" 
	local user = UserModel.getCurrentUser()
	BuildModel = require "builder.model"
	
	for _,v in pairs(BuildModel.TARGETS) do 
		v.option = v.value
	end
	
	
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
			val = require "validation"
			validator = val.implement.new(build)
			build = BuildModel.setDefaultValues(build)
			build.file_id = (build.file_id == nil) and "" or build.file_id 
			build.configs = tableToString(build)
			validator:validate('title',locale_index.validator.title_build, val.checks.isNotEmpty)
			validator:validate('target',locale_index.validator.title_target, val.checks.isNotEmpty)
			--validator:validate('file_id', locale_index.validator.file_id, val.checks.isNotEmpty)
			if build.id == nil then
				validator:validate('title',locale_index.validator.checkNotExistBuild, BuildModel.checkNotExistBuild)
			end
			if(validator:isValid())then
				local build_obj = BuildModel.save(build)
				BuildModel.deleteFilesFromBuild(build.id)
				if (type(build.file_id) == "table") then
					
					for _,file_id in pairs(build.file_id)do
						BuildModel.saveBuildFile(file_id,build_obj.id)
					end
				else
					BuildModel.saveBuildFile(build.file_id,build_obj.id)
				end
				-- Generates a build				
				BuildModel.generate(build.id)
				redirect({control="builder",act="index"})
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
	local BuilderModel = require "builder.model"
	local id = cgilua.QUERY.id
	BuilderModel.delete(id)
	redirect({control="builder", act="index"})
end

function download()
	local BuilderModel = require "builder.model"
	local id = cgilua.QUERY.id
	BuilderModel.download(id)
end