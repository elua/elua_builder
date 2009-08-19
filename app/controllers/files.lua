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
	local build_id = cgilua.QUERY.build_id
	local FileModel = require("file.model")
	
	local items = FileModel.getFiles()
	local build_files_index = FileModel.getFilesByBuildIndex(build_id)
	for _,v in pairs(items)do
		if type(build_files_index) == "table" then
			v.id = {id = v.id, checked = build_files_index[v.id]}
		else
			v.id = {id = v.id, checked = false}
		end
	end
		 
	local DT = require("dataTable")
	local rep = DT.repository:new(items,{startIndex=startIndex,results=results,sort=sort,dir=dir})
	 
	rep:response('text','plain','UTF-8')
end

function upload()
	local FileModel = require("file.model") 
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
	local filename = file[1].filename
	local path = CONFIG.MVC_UPLOAD..user.login.."/"..filename
	os.remove(path)
	local files = db:delete ("files","id = "..id)
	local files_build = db:delete ("builds_files", "file_id="..id)
	redirect({control="builder", act="index"})
end

function download()
	local UserModel = require "user.model"
	local FileModel = require("file.model") 
	local id = cgilua.QUERY.id
	local user = UserModel.getCurrentUser()
	local file = db:selectall("*","files","id = "..id)
	local filename = file[1].filename
	
	io:tmpfile(CONFIG.MVC_TMP)
	open, errorMsg =io.open(CONFIG.MVC_UPLOAD..user.login.."/"..filename, "rb")

   if (open==nil) then --ops, something went wrong, file does not exists!
    cgilua.put("<h2>"..locale_index.label_error_open_file.."</h2>")
   else
   fileSize = FileModel.getFileSize(open)
   -- cgilua.header("Pragma", "public")
   -- cgilua.header("Cache-Control", "must-revalidate, post-check=0, pre-check=0")
    cgilua.header("Content-Type", "application/force-download")
    cgilua.header("Content-Disposition",[[attachment; filename="]]..filename)
    cgilua.header("Content-Type", "application/octet-stream; name="..filename)
    cgilua.header("Content-Type", "application/octetstream; name="..filename)
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