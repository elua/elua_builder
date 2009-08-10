local global_env = _G
local cgilua, error, pairs, string, tostring, type, table = cgilua, error, pairs, string, tostring, type, table
local require, math, tonumber = require, math, tonumber
module("flash")

flash = {}

-- Returns the default flash sessionID
local function getFlashSessionID()
	require "cgilua.cookies"
	cookieID = cgilua.cookies.get("flash_cookie") 
	if(cookieID == nil or cookieID == '')then
		cookieID = cgilua.cookies.set("flash_cookie", math.random()*(10^14))
	end
	return tonumber(cookieID)
end

-- Sets a flash message in the temporary session
function flash.set(name,msg)
	local flash = cgilua.session.load(getFlashSessionID()) or {}
	flash[name] = msg
	flash['__views'] = 0
	cgilua.session.save(getFlashSessionID(),flash)
end

-- Returns the values of the flash
function flash.get(name)
	local flash = cgilua.session.load(getFlashSessionID())
	if(flash and flash[name])then
		return flash[name]
	end
end

-- Verifies the state of the session. If was set, the session is reset.
function flash.verify()
	local _flash = cgilua.session.load(getFlashSessionID())
	if _flash and _flash.__views == 0 then
		_flash['__views'] = 1
		cgilua.session.save(getFlashSessionID(),_flash)
	else
		flash.resetFlashs()
	end
end

-- Resets a single flash message
function flash.reset(name)
	local flash = cgilua.session.load(getFlashSessionID())
	if(flash and flash[name])then
		flash[name] = nil
		cgilua.session.save(getFlashSessionID(),flash)
	end
end
-- Resets all flash messages
function flash.resetFlashs()
	cgilua.session.delete(getFlashSessionID())
end

flash.verify()
global_env.flash  = flash
