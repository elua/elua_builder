local cgilua, os, error, pairs, string, tostring, type, table = cgilua, os, error, pairs, string, tostring, type, table
local require, math, tonumber = require, math, tonumber
local getfenv = getfenv

module("luaReports",package.seeall)

-- OUTPUT TYPES
local output = {}

function output.string(result)
	return result
end

function output.screen(result)
	cgilua.put(result)
end

function output.download(result,fileName)
	fileName = fileName or "report_"..os.date("%Y%m%d")..".txt"
	cgilua.header ("Content-type", "application/octet-stream")
	cgilua.header ("Content-Disposition", [[attachment; filename="]]..fileName..[["]])
	cgilua.put(result)
end

function makeReport(templatePath, valuesTable,outFormat,fileName)
	require "cosmo"
	local tempFile = io.open(templatePath, "r")
	local fileString = tempFile:read("*a")
	local result = cosmo.fill(fileString,valuesTable)
	
	outFormat = outFormat or "string"
	return output[outFormat](result,fileName)
end
