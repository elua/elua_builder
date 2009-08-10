-- Files application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------

function repository()
	local startIndex = cgilua.QUERY.startIndex
	local results = cgilua.QUERY.results
	local sort = cgilua.QUERY.sort
	local dir  = cgilua.QUERY.dir
	local query = cgilua.QUERY
	 	
	local FilesModel = require("files.model")
	local items = FilesModel.getFiles()
	 
	local DT = require("dataTable")
	local rep = DT.repository:new(items,{startIndex=startIndex,results=results,sort=sort,dir=dir})
	 
	rep:response('text','plain','UTF-8')
end

function upload()
	local FileModel = require("files.model") 
	local file_upload = cgilua.POST.file
    if file_upload and next(file_upload) then
		local _, name = cgilua.splitonlast(file_upload.filename)
		local file = file_upload.file
        local dir = FileModel.checkDir()
		destination = io.open(dir.."/"..name, "wb")
		FileModel.save(name)
        if destination then
            local bytes = file:read("*a")
            destination:write(bytes)
            destination:close()
        end
	end
	redirect({control="builder", act="index"})
end

function delete()
	local UserModel = require "user.model"
	local id = cgilua.QUERY.id
	local user = UserModel.getCurrentUser()
	local file = db:selectall("*","files","id = "..id)
	filename = file[1].filename
	local path = CONFIG.MVC_UPLOAD..user.login.."/"..filename
	os.remove(path)
	local files = db:delete ("files","id = "..id)
	redirect({control="builder", act="index"})
end