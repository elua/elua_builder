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
			
		if isPOST() then
			build = cgilua.POST
			val = require "validation"
			validator = val.implement.new(build)
			build = BuildModel.setDefaultValues(build)
			build.file_id = (build.file_id == nil) and "" or build.file_id	
			build.configs = tableToString(build)
			
			validator:validate('title',locale_index.validator.title_build, val.checks.isNotEmpty)
			validator:validate('target',locale_index.validator.title_target, val.checks.isNotEmpty)
		
			if(validator:isValid())then
				if (type(build.file_id) == "table") then
					local length_build_file_id = #build.file_id
					for i=1,length_build_file_id do
						local file_id = build.file_id[i]
						if string.sub(file_id,0,1)== '0' then
							local romfs = FileModel.ROMFS_V07
							local length_romfs = #romfs
							for i=1,length_romfs do
								local file_romfs = romfs[i]
								if file_romfs.id == file_id then
									filename = file_romfs.filename
									BuildModel.copyPathFile(filename)
									FileModel.save(filename)
									file = FileModel.getFileByName(filename)
									build.file_id[i]= file.id	
								end
							end	
						end
					end	
					local build_obj = BuildModel.save(build)
					BuildModel.deleteFilesFromBuild(build.id)
					for _,file_id in pairs(build.file_id)do	
						BuildModel.saveBuildFile(file_id,build_obj.id)
					end
				else
					if string.sub(build.file_id,0,1)== '0' then
						local romfs = FileModel.ROMFS_V07
						local length_romfs = #romfs
						for i=1,length_romfs do
							local file_romfs = romfs[i]
							if file_romfs.id == build.file_id then
								filename = file_romfs.filename
								
								BuildModel.copyPathFile(filename)
								FileModel.save(filename)
								file = FileModel.getFileByName(filename)
								build.file_id = file.id	
							end
						end	
						local build_obj = BuildModel.save(build)
						BuildModel.deleteFilesFromBuild(build.id)
						BuildModel.saveBuildFile(build.file_id,build_obj.id)
					else
						local build_obj = BuildModel.save(build)
						BuildModel.saveBuildFile(build.file_id,build_obj.id)		
					end
				end			
				-- Generates a build				
				BuildModel.generate(build.id)
				redirect({control="builder",act="index"})
			else				
				build = {}
				build.configs = cgilua.POST
				flash.set('validationMessagesBuild',validator:htmlMessages())		
				render("files.lp")
			end
		else
			local target = cgilua.QUERY.target
			build.configs = {}
			if (target ~= nil and target ~= '')then
				build.configs = BuildModel.PLATFORM[target]
			else
				
			end
			build.title = cgilua.QUERY.title			
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
	for i,v in pairs(items)do
		local configs = assert(loadstring("return "..v.configs)())
		v.configs = (type(configs) == "table" and configs.scons) and configs.scons or ''
	end
	
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