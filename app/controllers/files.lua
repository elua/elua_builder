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
	local params = cgilua.QUERY
	
	local items = FileModel.getAllFiles(params)
	for i,v in pairs(items)do
		v.id  = v.id..'_'..v.category_id
	end
	local DT = require("dataTable")
	local rep = DT.repository:new(items,{startIndex=startIndex,results=results,sort=sort,dir=dir})
	
	  -- Bust cache in the head
    cgilua.header("Expires", "Mon, 26 Jul 1997 05:00:00 GMT")   -- Date in the past
    cgilua.header("Last-Modified", os.date "!%%a, %%d %%b %%Y %%H:%%M:%%S GMT")
    -- always modified
    cgilua.header("Cache-Control", "no-cache, must-revalidate") -- HTTP/1.1
    cgilua.header("Pragma", "no-cache")                         -- HTTP/1.0
	rep:response('text','plain','UTF-8')
end

function upload()
	local FileModel = require("file.model") 
	local file_upload = cgilua.POST.file
    traceLog(tableToString(cgilua.POST))
    if file_upload and next(file_upload) and file_upload.filename ~= nil and file_upload.filename ~= "" then
		local _, name = cgilua.splitonlast(file_upload.filename)
		local file = file_upload.file
        local dir = FileModel.checkDir()
		destination = io.open(dir.."/"..name, "wb")	
		FileModel.save(name)
        if destination then
            local bytes = file:read("*a")
            destination:write(bytes)
            cgilua.put(tostring(destination:close()))
        end
	end
end

function delete()
	local FileModel = require("file.model") 
	local id = cgilua.QUERY.id
	local file = FileModel.getFileByID(id)
	local errors = FileModel.delete(file.id)
	if errors ~= nil then
		flash.set('removeSucessMessages', "The selected file was successfully removed.")
	else
		flash.set('removefailureMessages', "The selected file was not removed.")
	end
	redirect({control="builder", act="index"})
end

function download()
	local FileModel = require "file.model" 
	local id = cgilua.QUERY.id
	local file = FileModel.getFileByID(id)
	local open, filename = FileModel.getDirFile(file.id, file.category_id)
	if (open==nil) then --ops, something went wrong, file does not exists!
    	cgilua.put("<h2>".."The selected file does not exist".."</h2>")
   	else
   		FileModel.download(open, filename)
   	end	
end