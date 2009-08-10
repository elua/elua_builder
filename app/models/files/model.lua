-- Files application Model

module("files.model", package.seeall)
sqlI = require "sqlInjection"
File = mapper:new("files")
lfs = require("lfs")

function getFiles()
	local UserModel = require "user.model"
	local user = UserModel.getCurrentUser()
	local files = db:selectall("*","files","user_id = "..user.id)
	return files
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

