-- Files application Model

module("file.model", package.seeall)
sqlI = require "sqlInjection"
File = mapper:new("files")
lfs = require("lfs")

function getFiles()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("*","files","user_id = "..user.id)
	return files
end

function getFilesByBuild(build_id)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("f.*,bf.build_id",
								"files f inner join builds_files bf on bf.file_id = f.id",
								"f.user_id = "..user.id.." and bf.build_id = "..sqlI.sqlInjection(build_id,"number"))
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

function getFileByName(filename)
	local UserModel = require "user.model"
	filename = sqlI.sqlInjection(filename,"string")
	local user = UserModel.getCurrentUser()
	local files = db:selectall("*","files","user_id = "..user.id.." and filename= '" .. filename.."'")
	if type(files[1]) == "table" then
		return files[1]
	end
end

function save(filename)
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local file = getFileByName(filename)
	if type(file) == "table" then
		file.created_at = os.date("%Y-%m-%d %H:%M:%S")
	else
		file = {filename=filename, user_id = user.id}
	end
	local file = File:new(file)
	return file:save()
end

function checkDir()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local path = CONFIG.MVC_UPLOAD..user.login
	dir = lfs.attributes(path)
	if dir == nil then
		lfs.mkdir(path)
	end
	return path
end

