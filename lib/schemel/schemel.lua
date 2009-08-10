local cgilua, error, pairs, string, tostring, type, table = cgilua, error, pairs, string, tostring, type, table
local sool = require "sool"

module("schemel", sool.class())


function setScheme(self,physicalScheme,appScheme)
	local object = self
	object.appScheme = {}
	object.physicalScheme = {}
	for k,v in pairs(physicalScheme)do
		if(appScheme[v.name])then
			object.appScheme[v.name] = {type= v.type, name = appScheme[v.name].name, physicalName = v.name}
			object.physicalScheme[appScheme[v.name].name] = {type= v.type, name = v.name, appName = appScheme[v.name].name}
		else
			object.appScheme[v.name] = {type= v.type, name = v.name, physicalName = v.name}
			object.physicalScheme[v.name] = {type= v.type, name = v.name, appName = v.name}
		end
		
	end
	return object
end

function physicalToApp(self,scheme)
	local object = self
	return intersecSchemes(scheme,object.appScheme)
end

function appToPhysical(self,scheme)
	local object = self
	return intersecSchemes(scheme,object.physicalScheme)
end
--Syntactic sugar for physicalToApp
function p2a(self,scheme)
	return physicalToApp(self,scheme)
end

--Syntactic sugar for appToPhysical
function a2p(self,scheme)
	return appToPhysical(self,scheme)
end

function intersecSchemes(tb1,tb2)
	local temp = {}
	local tempK = ''
	for k,v in pairs(tb1)do
			if(tb2[k])then
				tempK = tb2[k].name
			else
				tempK = k
			end
		if(type(v) == "table")then
			temp[tempK] = intersecSchemes(v,tb2)
		else
			temp[tempK] = v
		end
	end
	return temp
end


function printScheme(tb,level)
	level = level or 1
	for k,v in pairs(tb)do
		if(type(v) == "table")then
			cgilua.put("Level:"..level.." - Key:"..k.."<dir>")
			printScheme(v,level+1)
			cgilua.put("</dir>")
		else
			cgilua.print("Level:"..level.." - Key:"..k.." Value:",v)
			cgilua.put("<br>")
		end
	end
	
end

