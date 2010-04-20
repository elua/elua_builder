-- Files application Model

module("file.model", package.seeall)
sqlI = require "sqlInjection"
File = mapper:new("files")
lfs = require("lfs")

function getFiles()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("f.*,c.name as category",
							   "files f inner join categories c on c.id = f.category_id ",
							   "f.user_id = "..user.id)
	return files
end

function getUserFile(file_id)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("*","files","user_id = "..tonumber(user.id).." and id= '"..tonumber(file_id).."'")
	return files[1]
end

function getFileSuggested(file_id)
	local file_id = tonumber(file_id)
	local files = db:selectall("*","suggested_files","id = "..file_id)
	return files[1]   
end

function sugestedRomFSByID()
	local temp = {}
	local SUGGESTED_ROMFS = getSuggestedFiles()
	for _,v in pairs(SUGGESTED_ROMFS)do
		temp[v.id] = v
	end
	return temp
end

function getSuggestedFiles()
	local suggested_files = db:selectall("s.*,c.name as category",
							   "suggested_files s inner join categories c on c.id = s.category_id ")
	return suggested_files
end

function getSuggestedFile(id)
	if tonumber(id) then
		local suggested_files = db:selectall("s.*,c.name as category",
								   "suggested_files s inner join categories c on c.id = s.category_id ",
								   "s.id ="..tonumber(id)
								   )
		if type(suggested_files) == "table" then
			return suggested_files[1]
		end
	end
end

function getFilesByBuild(build_id)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("f.*,bf.build_id",
								"files f inner join builds_files bf on bf.file_id = f.id",
								"f.user_id = "..user.id.." and bf.build_id = "..sqlI.sqlInjection(build_id,"number"))
	return files
end

function getAllFiles()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	
	local files = db:selectall([[f.id, f.filename, c.name as category,c.id as category_id from files f inner join categories c on c.id = f.category_id where f.user_id = ]]..user.id..[[ UNION
								select s.id, s.filename,c.name as category, c.id as category_id]],
								[[suggested_files s inner join categories c on c.id = s.category_id]])
	return files
	
end

function getFilesByBuildIndex(build_id)
	if tonumber(build_id) then
		local files = getFilesByBuild(build_id)
		local files_tb = {}
		for _,v in pairs(files)do
			files_tb[v.id] = true
		end
		return files_tb
	end
end

function getDirFile(id,category_id)
	local file_id = id
	local category_id = category_id
	local UserModel = require "user.model"
	if (tonumber(category_id) == 1) then
		local user = UserModel.getCurrentUser()
		local user_file = db:selectall("*","files","user_id = "..tonumber(user.id).." and id= '"..tonumber(file_id).."'")
		if (type(user_file) == "table") then
			local filename = user_file[1].filename
			io:tmpfile(CONFIG.MVC_TMP)
			open, errorMsg =io.open(CONFIG.MVC_USERS..user.login.."/rom_fs/"..filename, "rb")
			return open,filename
		end
	else
		local suggested_file = getSuggestedFile(file_id)
		if (type(suggested_file) == "table") then
			io:tmpfile(CONFIG.MVC_TMP)
			open, errorMsg =io.open(CONFIG.MVC_ROMFS..suggested_file.category.."/"..suggested_file.filename, "rb")
			return open,suggested_file.filename
		end
	end
end

function download(open, filename)
	local fileSize = getFileSize(open)
   	cgilua.header("Content-Type", "application/download")
   	cgilua.header("Content-Type", [[application/octet-stream; name="]]..filename..'"')
   	cgilua.header("Content-Type", [[application/octetstream; name="]]..filename..'"')
	cgilua.header("Content-Length", fileSize)
	cgilua.header("Content-Transfer-Encoding", "binary")
	cgilua.header("Content-Disposition",[[attachment; filename="]]..filename..'"')
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

function delete(id)
	local UserModel = require "user.model"
	local file_id = id
	local user = UserModel.getCurrentUser()
	local file = db:selectall("*","files","user_id = "..tonumber(user.id).." and id= '"..tonumber(file_id).."'")
	if (type(file) == "table") then
		local filename = file[1].filename
		local path = CONFIG.MVC_USERS..user.login.."/rom_fs/"..filename
		local errors = os.remove(path)
		local files = db:delete ("files","id = "..tonumber(file_id).." and user_id = '"..tonumber(user.id).."'")
		local files_build = db:delete ("builds_files", "file_id="..tonumber(file_id))	
		
		return errors
	end
end

function getFileByID(file_id)
	local file_id = string.split(file_id,"_")
	file.id = file_id[1]
	file.category_id = file_id[2]
	
	return file
end

function getFileByName(filename)
	local UserModel = require "user.model"
	filename = sqlI.sqlInjection(filename,"string")
	local user = UserModel.getCurrentUser()
	local files = db:selectall("*","files","user_id = "..user.id.." and filename= '" .. filename.."'")
	if type(files[1]) == "table" then
		return files[1]
	end
end

function getFileSize(file)
 	local current = file:seek()
 	local size = file:seek("end")
 	file:seek("set", current)
 	return tonumber(size)
end

function save(filename)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local file = getFileByName(filename)
	category = 1
	if type(file) == "table" then
		file.created_at = os.date("%Y-%m-%d %H:%M:%S")
	else
		file = {filename = filename, user_id = user.id, category_id = category}
	end
	local file = File:new(file)
	return file:save()
end

function checkDir()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local path = CONFIG.MVC_USERS..user.login
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end
	local path = path.."/rom_fs"
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end
	return path
end

function categoryNameById(id)
	local category_id = db:selectall("*","categories","id = "..id)
	return category_id[1].name
end

function getCategories()
	return db:selectall("*","categories")
end
function categoriesIndexesById()
	local temp_categories = {}
	for _,v in pairs(getCategories())do
		temp_categories[v.id] = v
	end
	return temp_categories
end