function makeOptionsTable(valueKey,optionKey,tb)
	tbResult = {}
	for k,v in pairs(tb) do
		table.insert(tbResult,{value = v[valueKey], option = v[optionKey]})
	end
	return tbResult
end

--- divides <em>str</em> into substrings based on a delimiter (pattern), returning an table of these substrings. 
-- <br>
-- @param str input string.
-- @param pattern pattern delimiter.
-- @usage <code>string.split(" now's the time", " ")  --> { "now's", "the", "time" }</code>
-- @usage <code>string.split("1, 2.34,56, 7", "[,%s]+") --> { "1", "2.34", "56", "7" }</code>
-- @usage <code>string.split("mellow yellow", "ello" --> { "m", "w y", "w" }</code>
-- @usage <code>string.split("1,2,,3,4,,", ",")   --> { "1", "2", "", "3", "4" }</code>
function string.split(str, pattern)
 local str = str
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pattern
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
  table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function attr(mainTB,complTB)
	if(type(complTB)=="table")then
		for k,v in pairs(complTB) do
				mainTB[k] = v
		end
		return mainTB
	end
end

function showDate(dateValue, format,outFormatter)
	if(dateValue ~= nil and dateValue ~= '')then
		outFormatter = outFormatter or "%d/%m/%Y"
		local verify = require "verifyDate"
		local ok, msg, newDate = verify.verifyDate(dateValue, format)
		
		if ok then
			return os.date(outFormatter,os.time(newDate))
		else
			return false
		end
	end
end

function generateTimeStamp()
	timeStamp = os.time()
	
	return timeStamp
end

--generic function to send mail
function sendmail(sender, to, copy, title, msg, priority)
	require "luarocks.require"

	require"cgilua.serialize"
	require"socket.smtp"
	
	priority = priority or 3

	--print out message headers	
	local source = socket.smtp.message {
	headers = {subject = title, ["content-type"] = 'text/html', ["x-priority"] = priority},
	body = msg
	}
	
	if(CONFIG.MAIL_SERVER.environment ~= "PRODUCTION")then
		sender = CONFIG.MAIL_SERVER.devMailFrom
		to = CONFIG.MAIL_SERVER.devMailTo
	end
	-- Sends the message
	local r, e = socket.smtp.send {
		server = CONFIG.MAIL_SERVER.server,
		from = sender,
		rcpt = to,
		cc = copy,
		source = source,
		user = CONFIG.MAIL_SERVER.user,
		password = CONFIG.MAIL_SERVER.password
	}
	
	return e
end

--function to remove spaces before an after the given input
function trim(strIn)
   if (not strIn) then
     return nil
   end
   local _, _, strOut = string.find(strIn, "^%s*(.-)%s*$")
   return strOut
end

function round(num, idp)
	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
end
-- function to add and subtract dates
date_day = {}
function date_day.add(tbDate,days,outFormat)
	outFormat = outFormat or "%d/%m/%Y"
	return os.date(outFormat,(os.time(tbDate))+(60*60*24*days))
end

function date_day.diff(tbDate,days,outFormat)
	outFormat = outFormat or "%d/%m/%Y"
	return os.date(outFormat,(os.time(tbDate))-(60*60*24*days))
end

function selectedMenu(name,srtReturned)
	if(APP.controller == name)then
		return srtReturned
	end
	return ""
end

function replaceAccents(s)
	if s ~= nil and s ~= "" then
		local incidence = {
			{old = "À", new = "&Agrave;"},
			{old = "Á", new = "&Aacute;"},
			{old = "Â", new = "&Acirc;"},
			{old = "Ã", new = "&Atilde;"},
			{old = "Ä", new = "&Auml;"},
			{old = "Å", new = "&Aring;"},
			{old = "Æ", new = "&AElig;"},
			{old = "Ç", new = "&Ccedil;"},
			{old = "È", new = "&Egrave;"},
			{old = "É", new = "&Eacute;"},
			{old = "Ê", new = "&Ecirc;"},
			{old = "Ë", new = "&Euml;"},
			{old = "Ì", new = "&Igrave;"},
			{old = "Í", new = "&Iacute;"},
			{old = "Î", new = "&Icirc;"},
			{old = "Ï", new = "&Iuml;"},
			
			{old = "Ñ", new = "&Ntilde;"},
			{old = "Ò", new = "&Ograve;"},
			{old = "Ó", new = "&Oacute;"},
			{old = "Ô", new = "&Ocirc;"},
			{old = "Õ", new = "&Otilde;"},
			{old = "Ö", new = "&Ouml;"},
			{old = "Ø", new = "&Oslash;"},
			{old = "Ù", new = "&Ugrave;"},
			{old = "Ú", new = "&Uacute;"},
			{old = "Û", new = "&Ucirc;"},
			{old = "Ü", new = "&Uuml;"},
				
			{old = "à", new = "&agrave;"},
			{old = "á", new = "&aacute;"},
			{old = "â", new = "&acirc;"},
			{old = "ã", new = "&atilde;"},
			{old = "ä", new = "&auml;"},
			{old = "å", new = "&aring;"},
			{old = "æ", new = "&aelig;"},
			{old = "ç", new = "&ccedil;"},
			{old = "è", new = "&egrave;"},
			{old = "é", new = "&eacute;"},
			{old = "ê", new = "&ecirc;"},
			{old = "ë", new = "&euml;"},
			{old = "ì", new = "&igrave;"},
			{old = "í", new = "&iacute;"},
			{old = "î", new = "&icirc;"},
			{old = "ï", new = "&iuml;"},
			
			{old = "ñ", new = "&ntilde;"},
			{old = "ò", new = "&ograve;"},
			{old = "ó", new = "&oacute;"},
			{old = "ô", new = "&ocirc;"},
			{old = "õ", new = "&otilde;"},
			{old = "ö", new = "&ouml;"},
			{old = "÷", new = "&divide;"},
			{old = "ø", new = "&oslash;"},
			{old = "ù", new = "&ugrave;"},
			{old = "ú", new = "&uacute;"},
			{old = "û", new = "&ucirc;"},
			{old = "ü", new = "&uuml;"}
		}
	
		for i, v in pairs(incidence) do
			s = string.gsub(s, v.old, v.new)
		end
	end
	
	return s
end

--function to populate your table only with values that are not null or empty
--just in case for use with mysql insert or update

function populateTable(t)
	tempParams = {}
	
	for i, v in pairs(t) do
		if v ~= nil and v ~= "" then
			tempParams[i] = v
		end
	end
	
	return tempParams
end

function tableToString(tb)
	if (type(tb) == "table") then
		local str = "{"
		for i,v in pairs(tb) do
			local value = ""
			if (type(v) == "table") then
				str = str.. i.."="..tableToString(v)..","
			else
				local value = tonumber(v) ~= nil and tonumber(v) or [["]]..tostring(v)..[["]]
				if(tonumber(i))then
					str = str..value..","
				else
					str = str.. i.."="..value..","
				end
			end
			
		end
		return str .."}"
	end
end