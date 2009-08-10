---------------------------------------------------------------------
--- This module generates a compatible Json DataTable repository.
-- @release $Id: repository.lua,v1.0 2009/02/19 Vagner Nascimento Exp $
---------------------------------------------------------------------
local cgilua, error, pairs, string, tostring, type, table = cgilua, error, pairs, string, tostring, type, table
local sool = require "sool"
local json = require "json"

module ("dataTable.repository",sool.class())

--- Creates a new instance of dataTable repository
-- @name [obj]:new
-- @param itens Lua table with itens for dataTable
-- @param arg Accepts a lua table with these arguments: startIndex, results, sort and dir
-- @param recordName String with the name of the Json resulting list
-- @usage <pre class='example'>
--			obj = require("dataTable.repository")<br>
--			ex1.: obj:new(table_itens)<br>
--			ex2.: other_obj:new(table_itens,{startIndex=0,results=30,sort='field1'},'results')
--		  </pre>
function _M:new(itens,arg,recordName)
	local object = _M:create()
	arg = arg or {}
	
	local startIndex = arg.startIndex or 0
	local results = arg.results
	local sort = arg.sort or "null"
	local dir  = arg.dir or "asc"
	local record = recordName or "records"
	
	if(results == nil)then
		results = #itens
	end
	
	local itens_from = (startIndex + 1)
	local itens_to = (startIndex+results)
	if itens_to >= (#itens + 1) then
		itens_to = #itens 
	end
	local itensPage = {}
	
	if(startIndex == 0)then
		itensPage = itens
	else
		
		for i = itens_from,itens_to do
			table.insert(itensPage, itens[i])
		end
	end
	local result = {
			recordsReturned=(itens_to - itens_from + 1),
		 	startIndex=startIndex,
		    totalRecords=#itens,
		    sort = sort,
		    dir = dir
    	}
    result[record] = itensPage
    object["repository"] = result
	--local repository = string.gsub(json.encode(result),"\\'","'")
	--repository = string.gsub(repository,"\"null\"","null")
	--object["repository"] = repository
	--return object
	return  object
end

--- Renders the instance of dataTable repository
-- @name [obj]:response
-- @param headerType String with the resulting HTML type header. The default value is 'application'.
-- @param headerSubtype String with the resulting HTML subtype header. The default value is 'json'.
-- @param headerCharset String with the resulting HTML charset. The default value is 'ISO-8859-1'.
-- @usage <pre class='example'>
-- 		   	ex1.: obj:response()<br>
-- 		  	ex2.: obj:response('text','plain','UTF-8')
-- 		  </pre>
function _M:response(headerType,headerSubtype,headerCharset)
	headerType = headerType or "application"
	headerSubtype = headerSubtype or "json"
	headerCharset = headerCharset or "ISO-8859-1"

	local repository = string.gsub(json.encode(self.repository),"\\'","'")
	repository = string.gsub(repository,"\"null\"","null")
	
	if(repository)then 
	
		cgilua.contentheader(headerType, headerSubtype..";charset="..headerCharset)
		cgilua.put(repository) 
	end
end

--- Returns a string with the result in Json
-- @name [obj]:get
function _M:get()
	return self.repository
end

