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

ROMFS_V06 = {
				{id="0.1",filename = 'bisect.lua', category= 'V0.6 File',created_at=""},
				{id="0.2",filename = 'hangman.lua', category= 'V0.6 File',created_at=""},
				{id="0.3",filename = 'index.pht', category= 'V0.6 File',created_at=""}, 
			}
			x = {
				lhttpd = {filename = 'lhttpd.lua', category= 'V0.6 File'}, 
				test = {filename = 'test.lua', category= 'V0.6 File'},
				pong = {filename = 'pong.lua', category= 'V0.6 File'},
				LM3S = {filename = 'LM3S.lua', category= 'V0.6 File'},
				led = {filename = 'led.lua', category= 'V0.6 File'},
				piano = {filename = 'piano.lua', category= 'V0.6 File'},
				pwmled = {filename = 'pwmled.lua', category= 'V0.6 File'},
				tvbgone = {filename = 'tvbgone.lua', category= 'V0.6 File'},
				codes = {filename = 'codes.bin', category= 'V0.6 File'},
				hello = {filename = 'hello.lua', category= 'V0.6 File'},
				info =  {filename = 'info.lua', category= 'V0.6 File'},
				morse = {filename = 'morse.lua', category= 'V0.6 File'},
				dualpwm = {filename = 'dualpwm.lua', category= 'V0.6 File'},
				adcscope = {filename = 'adcscope.lua', category= 'V0.6 File'},
				adcpoll= {filename = 'adcpoll.lua', category= 'V0.6 File'},
				life = {filename = 'life.lua', category= 'V0.6 File'},
				logo_lua = {filename = 'logo.lua', category= 'V0.6 File'}, 
				logo_bin = {filename = 'logo.bin', category= 'V0.6 File'},
}
