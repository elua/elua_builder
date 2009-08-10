---------------------------------------------------------------------
--- This module executes declared tests in a lua table, verifying if the elements are valid. 
-- @release $Id: repository.lua,v 1.0 beta 2008/07/29 Vagner Nascimento Exp $
---------------------------------------------------------------------
local global_env = _G
local cgilua, error, pairs, string, tostring, type, table, next = cgilua, error, pairs, string, tostring, type, table, next
local sool = require "sool"

module("validation.implement",sool.class())

--- Creates a new instance of the tests
-- @param itens Lua table with itens for dataTable
-- @param tbl 
function new(tbl)
	local obj = create()
	obj.object = tbl
	obj.messages = {}
	return obj
end

--- Makes a single test in a field
-- @param self 
-- @param key String with the name of the field for test
-- @param msg Message that will be returned if the test has failed
-- @param func Function that verifies if the condition is true, otherwise, the validation message is added 
-- @param ... Extra fields sent for the validation function  
function validate(self,key,msg,func,...)
	local obj = self
	local tbl = obj.object
	for k,v in pairs(tbl) do
		if(k == key)then
			if ((type(func)== 'boolean' and func == false) or (type(func)=='function' and (func(v,...) == false or func(v,...) == nil)))then
				table.insert(obj.messages,{key = k, message = msg})
			end
		end
	end
end

--- Returns if the all fields passed through the validation
function isValid(self)
	if(#self.messages > 0 or next(self.messages))then
		return false
	else
		return true
	end
end
-- Returns the messages by field.
function groupedMessages(self)
	local group = {}
	for _,v in pairs(self.messages) do
		if(group[v.key] == nil)then
			group[v.key] = {v.message}
		else
			table.insert(group[v.key],v.message)
		end
	end
	return group
end

--Returns a html box with the list of messages
function htmlMessages(self,divID)
	if(#self.messages > 0)then
		divID = divID or "errorExplanation"
		local htmlResult = "<div id='"..divID.."'><ul>"
		for _,v in pairs(self.messages) do
			htmlResult = htmlResult.."<li>"..v.message.."</li>"
		end
		htmlResult = htmlResult.."</ul></div>"
		return htmlResult
	end
end