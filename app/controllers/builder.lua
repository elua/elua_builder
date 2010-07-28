-- Builder application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------

function index()
	local UserModel = require "user.model"
	local BuildModel = require "builder.model"
	UserModel.saveHash(UserModel.getCurrentUser())
	current_user = UserModel.getCurrentUser()
	render("index.lp")	
end

function tabs_content()
	BuildModel = require "builder.model"
	local UserModel = require "user.model"
	current_user = UserModel.getCurrentUser()
	local target = cgilua.POST.target
	build = {}
	build.configs = {}
	if (target ~= nil and target ~= '')then
		build.configs = BuildModel.PLATFORM[target]			
	end
	render('tabs_content.lp')
end

function files()	
	build =  {}
	id = cgilua.QUERY.id
	build_files = {}
	local UserModel = require "user.model"
	local FileModel = require "file.model" 
	current_user = UserModel.getCurrentUser()
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
		build_files = FileModel.getFilesByBuild(tonumber(id))
		--cgilua.put(tableToString(build_files))
		render("files.lp")
	else		
		if isPOST() then
			build = cgilua.POST
			
			
			build.file_id = (build.file_id == nil) and "" or build.file_id	
			build.configs = tableToString(build)
				
			local validator = BuildModel.validate(build)
			
			if(validator:isValid())then
				local build_obj = BuildModel.save(build)
				if tonumber(build_obj.id) then
					BuildModel.deleteFilesFromBuild(build_obj.id)
					if build.file_id ~= nil and build.file_id ~= '' then					
						file_id = type(build.file_id) == "table" and build.file_id or {build.file_id}
						local size_file_id = #file_id
						local files = {}
						for i=1,size_file_id do
							files[i] = FileModel.getFileByID(file_id[i])
							if tonumber(files[i].category_id) == 1 then
								open,filename = FileModel.getDirFile(files[i].id, files[i].category_id)
								FileModel.save(filename)
								BuildModel.saveBuildFile(files[i].id, build_obj.id, files[i].category_id)
							else
								BuildModel.copyPathSuggestedFile(files[i].id)
								open,filename = FileModel.getDirFile(files[i].id, files[i].category_id)	
								BuildModel.saveBuildFile(files[i].id,build_obj.id, files[i].category_id)
							end
						end
						build_obj.file_id = files
					end
				end
				-- Generates a build	
				BuildModel.generate(build_obj)
				redirect({control="builder",act="index"})
			else				
				build = cgilua.POST or {}
				build.configs = cgilua.POST
				build.title = cgilua.POST.title
				build_files = FileModel.getFilesByIDs(build.file_id) or {}
				
				--build_files = cgilua.POST.file_id
				flash.set('validationMessagesBuild',validator:htmlMessages())		
				render("files.lp")
			end
		else
			build.configs = {}		
			build.configs = {ip0 = "192", ip1 = "168", ip2 = "100", ip3 = "5",
			mask0 = "255", mask1 = "255", mask2 = "255", mask3 = "0",
			gateway0 = "192", gateway1 = "168", gateway2 = "100", gateway3 = "20",
			dns0 = "192", dns1 = "168", dns2 = "100", dns3 = "20"}
			
			local date = os.date()
			build.title = cgilua.QUERY.title
			build.title = (build.title == '' or build.title == nil) and "New Build "..date or build.title
			
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
	  -- Bust cache in the head
    cgilua.header("Expires", "Mon, 26 Jul 1997 05:00:00 GMT")   -- Date in the past
    cgilua.header("Last-Modified", os.date "!%%a, %%d %%b %%Y %%H:%%M:%%S GMT")
    -- always modified
    cgilua.header("Cache-Control", "no-cache, must-revalidate") -- HTTP/1.1
    cgilua.header("Pragma", "no-cache")                         -- HTTP/1.0
    
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

function upload_window()
	render( "upload.lp")
end

function error()
	render("error.lp")
end