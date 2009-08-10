local global_env = _G
local cgilua, error, pairs, string, tostring, type, table, next = cgilua, error, pairs, string, tostring, type, table, next
local sool = require "sool"

module("validation.checks",package.seeall)

function isNotEmpty(value)
	if(value ~= nil and value ~= '')then
		return true
	end
end

function isNumber(value)
	if(tonumber(value))then
		return true
	end
end

function maxLength(value,size)
	if(string.len(value) <= size)then
		return true
	end
end

function minLength(value,size)
	if(string.len(value) >= size)then
		return true
	end
end

function maxNum(value,max)
	if(type(value)== "number" and value <= max)then
		return true
	end
end

function minNum(value,min)
	if(type(value)== "number" and value >= min)then
		return true
	end
end

function isBetween(value,min,max)
	if(value >=min and value <= max)then
		return true
	end
end

function isEmail(value)
	local endDomain = string.match(value,"^[%a%d._%-]+@[%a%d-.]+[.]+([%a]+)$")
	if(endDomain ~= nil and string.len(endDomain) >=2 and string.len(endDomain) <=4)then
		return true
	end
end

function isEqual(value1,value2)
	if(value1 == value2) then
		return true
	end
end

function sizeString(value1,value2)
	local v1 = string.len(value1)
	if(v1 == value2) then
		return true
	end
end
