module("verifyDate",package.seeall)



--Finds out if it's a leap year
--param ano the year you want to check
--return true if it's a leap year and false if it's not 
local function isLeapYear(ano) 
	if (math.mod(ano, 400) == 0) then 
		return true
	elseif (math.mod(ano, 100) == 0) then
		return false
	elseif (math.mod(ano, 4) == 0) then
		return true
	else 
		return false end
end


--- Finds out if a date is valid and returns day, month and year in separate elements on a table.
-- @param date the date that eyou want to validate
-- @param dateFormat the format of the date you're giving on date
-- @usage You will be using d for day, m for month and y for year 
-- @usage The date can be in any format you want as long as you put the format you're using in dateFormat:<br> 
-- 		  dd/mm/yyyy will work with 02/12/2000, but you'll need d/mm/yyyy to work with 2/12/2000.
-- @usage You don't need to use any separators if u dont want too:<br>
-- 		  ddmmyyyy will work with 02122000
-- @usage Date month and year can be sent in any order as long as it's on the same order as the parameter:<br>
-- 		  yyyy/mm/dd will work with  2000/12/02<br><br>
-- @usage Example:
-- <pre class='example'>
-- 		dateTable = {}<br>
-- 		date = "02/12/2000"; dateFormat = "dd/mm/yyyy"<br> 
-- 		flag, message, dateTable = verifyDate(date, dateFormat)<br>
-- 		print(flag, message)						--> true	Valid date<br>
-- 		print(dateTable.day, dateTable.month, dateTable.year)		--> 2	12	2000<br>
-- </pre>
-- @return false for invalid date and true for valid date
-- @return a string with "valid date" or the reason why the date is invalid
-- @return a table with the value of day in .day, month in .month and year in .year  
function verifyDate(date, dateFormat)
	if(string.len(date) ~= string.len(dateFormat) ) then
		return false, "date and dateFormat have different lenghts"
	end
	
--Divide os valores de date em dia, mes e ano
	local d1, d2 = string.find(dateFormat,"[dD]+")
	local m1, m2 = string.find(dateFormat,"[mM]+")
	local y1, y2 = string.find(dateFormat,"[yY]+")
	
	local dia = string.sub(date, d1, d2)
	local mes = string.sub(date, m1, m2)
	local ano = string.sub(date, y1, y2)
	
	dia = tonumber(dia)
	mes = tonumber(mes)
	ano = tonumber(ano)
	
--Verifica se o formato dado é igual ao da data em si
	if( (dia == nil) or (mes == nil) or (ano == nil) ) then
		return false, "date and dateFormat have different formats"
	end
	
--Verifica possíveis erros de data
	if dia <= 0 then
		return false, "Cant have day with value 0 or lower" end
	if mes <= 0 then
		return false, "Cant have month with value 0 or lower" end
	if ano <= 0 then
		return false, "Cant have year with value 0 or lower" end
	if dia > 31 then 
		return false, "Day with value higher then 31" end
	if dia > 30 and ( (mes == 4) or (mes == 6) or (mes == 9) or (mes == 11) ) then 
		return false, "Day with value higher then 30 on a month with 31 days" end
	if (dia > 29) and (mes == 2) then
		return false, "Day with value higher then 29 on month with a maximun of 29 days" end
	if (dia == 29) and (mes == 2) and not(isLeapYear(ano)) then 
		return false, "Day with value 29 on month 2 of a not leap year" end
	if(mes > 12) then 
		return false, "There's no month with value higher then 12" end
	
--Cria e retorna tabela com os valores de dia, mes e ano
	local validDate = {}
	
	if dia < 10 then
		dia = "0"..dia
	end

	if mes < 10 then
		mes = "0"..mes
	end

	validDate.day = dia
	validDate.month = mes
	validDate.year = ano
	return true, "Valid date", validDate
	
end