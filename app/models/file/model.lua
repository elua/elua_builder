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

function getSuggestedFiles()
	local suggested_files = db:selectall("s.*,c.name as category",
							   "suggested_files s inner join categories c on c.id = s.category_id ")
	return suggested_files
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


function getFilesByIDs(file_ids)
	file_ids = {file_ids}
	if (type(file_ids) == "table")then	
		local UserModel = require "user.model"
		local user = UserModel.getCurrentUser()	
		local files = {}	
		local length_file_ids = #file_ids	
		for i=1,length_file_ids do 
			local file_id = string.split(length_file_ids[i],"_")
			files[i].id = file_id[1]
			files[i].category_id = file_id[2]
		end
		return files
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
	category = "User File"
	if type(file) == "table" then
		file.created_at = os.date("%Y-%m-%d %H:%M:%S")
	else
		file = {filename=filename, user_id = user.id, category=category}
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

function sugestedRomFSByID()
	local temp = {}
	local SUGGESTED_ROMFS = getSuggestedFiles()
	for _,v in pairs(SUGGESTED_ROMFS)do
		temp[v.id] = v
	end
	return temp
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