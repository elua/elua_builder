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

SUGGESTED_ROMFS = {
				{id="0.1",filename = 'adcpoll.lua', category= 'V0.7 File',created_at=""},
				{id="0.2",filename = 'adcscope.lua', category= 'V0.7 File',created_at=""},
				{id="0.3",filename = 'bisect.lua', category= 'V0.7 File',created_at=""},
				{id="0.4",filename = 'codes.bin', category= 'V0.7 File',created_at=""},
				{id="0.5",filename = 'dualpwm.lua', category= 'V0.7 File',created_at=""},
				{id="0.6",filename = 'EK-LM3S6965.lua', category= 'V0.7 File',created_at=""},
				{id="0.7",filename = 'EK-LM3S8962.lua', category= 'V0.7 File',created_at=""},
				{id="0.8",filename = 'hangman.lua', category= 'V0.7 File',created_at=""},
				{id="0.9",filename = 'hello.lua', category= 'V0.7 File',created_at=""},
				{id="0.10",filename = 'index.pht', category= 'V0.7 File',created_at=""},
				{id="0.11",filename = 'info.lua', category= 'V0.7 File',created_at=""},
				{id="0.12",filename = 'led.lua', category= 'V0.7 File',created_at=""},
				{id="0.13",filename = 'lhttpd.lua', category= 'V0.7 File',created_at=""},
				{id="0.14",filename = 'life.lua', category= 'V0.7 File',created_at=""},
				{id="0.15",filename = 'logo.bin', category= 'V0.7 File',created_at=""},
				{id="0.16",filename = 'logo.lua', category= 'V0.7 File',created_at=""},
				{id="0.17",filename = 'morse.lua', category= 'V0.7 File',created_at=""},
				{id="0.18",filename = 'piano.lua', category= 'V0.7 File',created_at=""},
				{id="0.19",filename = 'pong.lua', category= 'V0.7 File',created_at=""},
				{id="0.20",filename = 'pwmled.lua', category= 'V0.7 File',created_at=""}, 
				{id="0.21",filename = 'snake.lua', category= 'V0.7 File',created_at=""}, 
				{id="0.22",filename = 'spaceship.lua', category= 'V0.7 File',created_at=""}, 
				{id="0.23",filename = 'test.lua', category= 'V0.7 File',created_at=""}, 
				{id="0.24",filename = 'tetrives.lua', category= 'V0.7 File',created_at=""}, 
				{id="0.25",filename = 'tvbgone.lua', category= 'V0.7 File',created_at=""}, 
			}

function sugestedRomFSByID()
	local temp = {}
	for _,v in pairs(SUGGESTED_ROMFS)do
		temp[v.id] = v
	end
	return temp
end