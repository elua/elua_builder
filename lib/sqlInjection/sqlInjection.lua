local cgilua, error, pairs, string, tostring, type, table = cgilua, error, pairs, string, tostring, type, table

verifyDate = require "verifyDate"

module ("sqlInjection", package.seeall)

function sqlInjection(var, typeVar)
	
	if var ~= nil and var ~= "" then
		if (typeVar == "string") then
			var = string.gsub(var, "'", "''")
		end
		
		if (typeVar == "number") then
			if (tonumber(var)) == nil then
				var = "null"
			end
		end
		
		if (typeVar == "boolean") then
			if (string.lower(var) == "false" or string.lower(var) == "n") then
				var = 0
			elseif (string.lower(var) == "true" or string.lower(var) == "y"  or string.lower(var) == "s") then
				var = 1
			end
		end
		
		if (typeVar == "date") then
			ok, msg, dateSQL = verifyDate.verifyDate(var, "dd/mm/yyyy")
			if ok then
				var = dateSQL.year.."-"..dateSQL.month.."-"..dateSQL.day
			else
				var = ""
			end
		end
		
	end

	return var
end


function treatTableInjection(tb_source,tb_types)
	for k,v in pairs(tb_source) do
		--cgilua.put(tb_types[k].type)
		--tb_source[k] = 	sqlInjection(v,tb_types[k].type)
	end
	return tb_source
end
