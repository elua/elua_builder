dofile("../config_app.lua")

APP = {}
JUMP_AUTHENTICATION = true

dofile(CONFIG.MVC_LIB.."support.lua")
dofile(CONFIG.MVC_LIB.."events.lua")

local currenty_lang = CONFIG.LANGUAGE
cgilua.doif(CONFIG.MVC_LOCALE..currenty_lang.."-general.lua")

package.path = CONFIG.MVC_MODEL..[[?.lua;]]..package.path
mvc_events.beforeAnyAction(true)
if (...)then
	file_arg = string.gsub(...,"([.%w-_]+.lua)","%1")
	print("------ MVC CONSOLE - LOADING FILE: ".. file_arg .. "\n\n")
	dofile("scripts/"..file_arg)
else
	print("--- Please, give a lua script file as argument.")
end


function reset_models(model)
	local reseted = {}
	if(type(model) == "string" and type(package.loaded[model] == "table"))then
		package.loaded[model] = nil
		return {model}
	end
	for i,_ in pairs(package.loaded)do
		if (string.match(i,"^.+[.]model$"))then
			table.insert(reseted, i)
			package.loaded[i] = nil
		end
	end
	return reseted
end

function reload_models()
	for _,v in pairs(reset_models())do
		require(v)
	end
end