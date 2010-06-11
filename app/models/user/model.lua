-- User application Model

module("user.model", package.seeall)

require("md5")
sqlI = require "sqlInjection"
User = mapper:new("users")


-- Sets here the controllers and action that are exceptions to the validation
function checkExceptions()
	local exceptions = {
		user = {index = true, authenticate = true, create = true, forgot = true, forgot_password = true, register = true, denied = true},
		default = {index = true},
	}
	return (exceptions[APP.controller] ~= nil and exceptions[APP.controller][APP.action]) and true or false
end

function save(values)
	values.passwd = md5.sumhexa(values.passwd)
	values.actived = true
	local user = User:new(values)
	user:save()
	return user
end

function getUserHash(user_hash)
	local user = db:selectall("*","users","user_hash = '"..user_hash.."'")
	if (type(user[1]) == "table")then 
		return user[1]
	end
end

function getUser(id)
	if tonumber(id) then
		local users = db:selectall("*","users","id = '"..tonumber(id).."'")
		if (type(users[1]) == "table")then 
			return users[1]
		end
	end
end

function checkUser(login, passwd)
	login = sqlI.sqlInjection(login,"string")
	passwd = md5.sumhexa(sqlI.sqlInjection(passwd,"string"))
	local users = db:selectall("*","users","login = '"..login.."' and passwd = '"..passwd.."'")
	if (type(users[1]) == "table")then 
		return true, users[1]
	end
end

function saveHash(user)
	local date = os.date()
	local user_hash = md5.sumhexa(user.login..date)
	db:update("users",{user_hash=user_hash},"id="..user.id)
	user.user_hash = user_hash
	return user
end

function userHash(email)
	local user = db:selectall("*","users","email = '"..sqlI.sqlInjection(email,"string").."'")
	if type(user[1]) == 'table' then
		return saveHash(user[1])
	end
end


function checkEmail(email)
	email = sqlI.sqlInjection(email,"string")
	local users = db:selectall("*","users","email = '"..email.."'")
	if users == nil then
		return false
	else
		if (type(users[1]) == "table")then 
			return true, users[1]
		end
	end
end

function authenticate(user)
	local login = user.login
	local passwd = user.passwd
	local ok, user = checkUser(login,passwd)
	if (type(user) == "table") then
		require "cgilua.cookies"
		cgilua.cookies.set(CONFIG.COOKIE_NAME, md5.crypt(login,CONFIG.MD5KEY).."#&#"..md5.crypt(passwd,CONFIG.MD5KEY))
		return user
	end
end

function getCurrentUser()
	require "cgilua.cookies"
	local cookieUser = cgilua.cookies.get(CONFIG.COOKIE_NAME)
	if(cookieUser ~= nil)then
		local cookieData = {}
		
		cookieData = string.split(cgilua.cookies.get(CONFIG.COOKIE_NAME),"#&#")
		if (cookieData ~= nil)then
			local ok, user = checkUser(md5.decrypt(tostring(cookieData[1]),CONFIG.MD5KEY), md5.decrypt(tostring(cookieData[2]),CONFIG.MD5KEY))
			if ok then return user end
		end
	else
		local h = cgilua.POST.h
		if h ~= nil and h ~= '' then
			return getUserHash(h)
		end
	end
end

function getIdCurrentUser()
	local user = getCurrentUser()
	local ids = db:selectall("id","users","login = '"..user.login.."'")
	local user_id = ids[1]
	local id = user_id
	return id
end

function checkNotExistLogin(login)
	login = sqlI.sqlInjection(login,"string")
	local users = db:selectall("*","users","login = '"..login.."'")
	if (type(users[1]) == "table")then 
		return false
	end
	return true
end

function logout()
	require "cgilua.cookies"
	return cgilua.cookies.delete(CONFIG.COOKIE_NAME)
end

-- Form values
COUNTRY = {
			{value="AL", option = "Albania"}, 
			{value="DZ", option = "Algeria"}, 
			{value="AS", option = "American Samoa"}, 
			{value="AD", option = "Andorra"}, 
			{value="AO", option = "Angola"}, 
			{value="AI", option = "Anguilla"}, 
			{value="AQ", option = "Antarctica"}, 
			{value="AG", option = "Antigua And Barbuda"}, 
			{value="AR", option = "Argentina"}, 
			{value="AM", option = "Armenia"}, 
			{value="AW", option = "Aruba"}, 
			{value="AU", option = "Australia"}, 
			{value="AT", option = "Austria"}, 
			{value="AZ", option = "Azerbaijan"}, 
			{value="BS", option = "Bahamas"}, 
			{value="BH", option = "Bahrain"}, 
			{value="BD", option = "Bangladesh"}, 
			{value="BB", option = "Barbados"}, 
			{value="BY", option = "Belarus"}, 
			{value="BE", option = "Belgium"}, 
			{value="BZ", option = "Belize"}, 
			{value="BJ", option = "Benin"}, 
			{value="BM", option = "Bermuda"}, 
			{value="BT", option = "Bhutan"}, 
			{value="BO", option = "Bolivia"}, 
			{value="BA", option = "Bosnia &amp; Herzegovina"}, 
			{value="BW", option = "Botswana"}, 
			{value="BV", option = "Bouvet Island"}, 
			{value="BR", option = "Brazil"}, 
			{value="IO", option = "British Indian Ocean Territory"}, 
			{value="BN", option = "Brunei"}, 
			{value="BG", option = "Bulgaria"}, 
			{value="BF", option = "Burkina Faso"}, 
			{value="BI", option = "Burundi"}, 
			{value="KH", option = "Cambodia"}, 
			{value="CM", option = "Cameroon"}, 
			{value="CA", option = "Canada"}, 
			{value="CV", option = "Cape Verde"}, 
			{value="KY", option = "Cayman Islands"}, 
			{value="CF", option = "Central African Republic"}, 
			{value="TD", option = "Chad"}, 
			{value="CL", option = "Chile"}, 
			{value="CN", option = "China"}, 
			{value="CX", option = "Christmas Island"}, 
			{value="CC", option = "Cocos (Keeling) Islands"}, 
			{value="CO", option = "Colombia"}, 
			{value="KM", option = "Comoros"}, 
			{value="CG", option = "Congo"}, 
			{value="ZR", option = "Congo, Democratic Republic Of"}, 
			{value="CK", option = "Cook Islands"}, 
			{value="CR", option = "Costa Rica"}, 
			{value="CI", option = "Cote D&#39;Ivoire"}, 
			{value="HR", option = "Croatia"}, 
			{value="CY", option = "Cyprus"}, 
			{value="CZ", option = "Czech Republic"}, 
			{value="DK", option = "Denmark"}, 
			{value="DJ", option = "Djibouti"}, 
			{value="DM", option = "Dominica"}, 
			{value="DO", option = "Dominican Republic"}, 
			{value="TP", option = "East Timor"}, 
			{value="EC", option = "Ecuador"}, 
			{value="EG", option = "Egypt"}, 
			{value="SV", option = "El Salvador"}, 
			{value="GQ", option = "Equatorial Guinea"}, 
			{value="ER", option = "Eritrea"}, 
			{value="EE", option = "Estonia"}, 
			{value="ET", option = "Ethiopia"}, 
			{value="FK", option = "Falkland Islands"}, 
			{value="FO", option = "Faroe Islands"}, 
			{value="FJ", option = "Fiji"}, 
			{value="FI", option = "Finland"}, 
			{value="FR", option = "France"}, 
			{value="GF", option = "French Guiana"}, 
			{value="PF", option = "French Polynesia"}, 
			{value="TF", option = "French Southern Territories"}, 
			{value="GA", option = "Gabon"}, 
			{value="GM", option = "Gambia, The"}, 
			{value="GE", option = "Georgia"}, 
			{value="DE", option = "Germany"}, 
			{value="GH", option = "Ghana"}, 
			{value="GI", option = "Gibraltar"}, 
			{value="GR", option = "Greece"}, 
			{value="GL", option = "Greenland"}, 
			{value="GD", option = "Grenada"}, 
			{value="GP", option = "Guadeloupe"}, 
			{value="GU", option = "Guam"}, 
			{value="GT", option = "Guatemala"}, 
			{value="GN", option = "Guinea"}, 
			{value="GW", option = "Guinea-Bissau"}, 
			{value="GY", option = "Guyana"}, 
			{value="HT", option = "Haiti"}, 
			{value="HM", option = "Heard And Mc Donald Islands"}, 
			{value="HN", option = "Honduras"}, 
			{value="HK", option = "Hong Kong"}, 
			{value="HU", option = "Hungary"}, 
			{value="IS", option = "Iceland"}, 
			{value="IN", option = "India"}, 
			{value="ID", option = "Indonesia"}, 
			{value="IQ", option = "Iraq"}, 
			{value="IE", option = "Ireland"}, 
			{value="IL", option = "Israel"}, 
			{value="IT", option = "Italy"}, 
			{value="JM", option = "Jamaica"}, 
			{value="JP", option = "Japan"}, 
			{value="JO", option = "Jordan"}, 
			{value="KZ", option = "Kazakhstan"}, 
			{value="KE", option = "Kenya"}, 
			{value="KI", option = "Kiribati"}, 
			{value="KR", option = "Korea (Republic Of)"}, 
			{value="KW", option = "Kuwait"}, 
			{value="KG", option = "Kyrgyzstan"}, 
			{value="LA", option = "Laos"}, 
			{value="LV", option = "Latvia"}, 
			{value="LB", option = "Lebanon"}, 
			{value="LS", option = "Lesotho"}, 
			{value="LR", option = "Liberia"}, 
			{value="LY", option = "Libya"}, 
			{value="LI", option = "Liechtenstein"}, 
			{value="LT", option = "Lithuania"}, 
			{value="LU", option = "Luxembourg"}, 
			{value="MO", option = "Macau"}, 
			{value="MK", option = "Macedonia, The F.Y.R. Of"}, 
			{value="MG", option = "Madagascar"}, 
			{value="MW", option = "Malawi"}, 
			{value="MY", option = "Malaysia"}, 
			{value="MV", option = "Maldives"}, 
			{value="ML", option = "Mali"}, 
			{value="MT", option = "Malta"}, 
			{value="MH", option = "Marshall Islands"}, 
			{value="MQ", option = "Martinique"}, 
			{value="MR", option = "Mauritania"}, 
			{value="MU", option = "Mauritius"}, 
			{value="YT", option = "Mayotte"}, 
			{value="MX", option = "Mexico"}, 
			{value="FM", option = "Micronesia"}, 
			{value="MD", option = "Moldova"}, 
			{value="MC", option = "Monaco"}, 
			{value="MN", option = "Mongolia"}, 
			{value="ME", option = "Montenegro"}, 
			{value="MS", option = "Montserrat"}, 
			{value="MA", option = "Morocco"}, 
			{value="MZ", option = "Mozambique"}, 
			{value="MM", option = "Myanmar"}, 
			{value="NA", option = "Namibia"}, 
			{value="NR", option = "Nauru"}, 
			{value="NP", option = "Nepal"}, 
			{value="NL", option = "Netherlands"}, 
			{value="AN", option = "Netherlands Antilles"}, 
			{value="NC", option = "New Caledonia"}, 
			{value="NZ", option = "New Zealand"}, 
			{value="NI", option = "Nicaragua"}, 
			{value="NE", option = "Niger"}, 
			{value="NG", option = "Nigeria"}, 
			{value="NU", option = "Niue"}, 
			{value="NF", option = "Norfolk Island"}, 
			{value="MP", option = "Northern Mariana Islands"}, 
			{value="NO", option = "Norway"}, 
			{value="OM", option = "Oman"}, 
			{value="PK", option = "Pakistan"}, 
			{value="PW", option = "Palau"}, 
			{value="PA", option = "Panama"}, 
			{value="PG", option = "Papua New Guinea"}, 
			{value="PY", option = "Paraguay"}, 
			{value="PE", option = "Peru"}, 
			{value="PH", option = "Philippines"}, 
			{value="PN", option = "Pitcairn"}, 
			{value="PL", option = "Poland"}, 
			{value="PT", option = "Portugal"}, 
			{value="PR", option = "Puerto Rico"}, 
			{value="QA", option = "Qatar"}, 
			{value="RE", option = "Reunion"}, 
			{value="RO", option = "Romania"}, 
			{value="RU", option = "Russian Federation"}, 
			{value="RW", option = "Rwanda"}, 
			{value="GS", option = "S Georgia, S Sandwich Islands"}, 
			{value="KN", option = "Saint Kitts And Nevis"}, 
			{value="LC", option = "Saint Lucia"}, 
			{value="VC", option = "Saint Vincent, The Grenadines"}, 
			{value="WS", option = "Samoa"}, 
			{value="SM", option = "San Marino"}, 
			{value="ST", option = "Sao Tome And Principe"}, 
			{value="SA", option = "Saudi Arabia"}, 
			{value="SN", option = "Senegal"}, 
			{value="RS", option = "Serbia"}, 
			{value="SC", option = "Seychelles"}, 
			{value="SL", option = "Sierra Leone"}, 
			{value="SG", option = "Singapore"}, 
			{value="SK", option = "Slovakia"}, 
			{value="SI", option = "Slovenia"}, 
			{value="SB", option = "Solomon Islands"}, 
			{value="SO", option = "Somalia"}, 
			{value="ZA", option = "South Africa"}, 
			{value="ES", option = "Spain"}, 
			{value="LK", option = "Sri Lanka"}, 
			{value="SH", option = "St. Helena"}, 
			{value="PM", option = "St. Pierre And Miquelon"}, 
			{value="SR", option = "Suriname"}, 
			{value="SJ", option = "Svalbard And Jan Mayen Islands"}, 
			{value="SZ", option = "Swaziland"}, 
			{value="SE", option = "Sweden"}, 
			{value="CH", option = "Switzerland"}, 
			{value="TW", option = "Taiwan"}, 
			{value="TJ", option = "Tajikistan"}, 
			{value="TZ", option = "Tanzania"}, 
			{value="TH", option = "Thailand"}, 
			{value="TG", option = "Togo"}, 
			{value="TK", option = "Tokelau"}, 
			{value="TO", option = "Tonga"}, 
			{value="TT", option = "Trinidad And Tobago"}, 
			{value="TN", option = "Tunisia"}, 
			{value="TR", option = "Turkey"}, 
			{value="TM", option = "Turkmenistan"}, 
			{value="TC", option = "Turks And Caicos Islands"}, 
			{value="TV", option = "Tuvalu"}, 
			{value="UG", option = "Uganda"}, 
			{value="UA", option = "Ukraine"}, 
			{value="AE", option = "United Arab Emirates"}, 
			{value="GB", option = "United Kingdom"}, 
			{value="US", option = "United States"}, 
			{value="UM", option = "United States Outlying Islands"}, 
			{value="UY", option = "Uruguay"}, 
			{value="UZ", option = "Uzbekistan"}, 
			{value="VU", option = "Vanuatu"}, 
			{value="VA", option = "Vatican City State"}, 
			{value="VE", option = "Venezuela"}, 
			{value="VN", option = "Vietnam"}, 
			{value="VG", option = "Virgin Islands (British)"}, 
			{value="VI", option = "Virgin Islands (U.S.)"}, 
			{value="WF", option = "Wallis And Futuna Islands"}, 
			{value="EH", option = "Western Sahara"}, 
			{value="YE", option = "Yemen"}, 
			{value="ZM", option = "Zambia"}, 
			{value="ZW", option = "Zimbabwe"},
		}
		
ORGANIZATION = {
				{value="Academic", option ="Academic"},
				{value="Automotive", option ="Automotive"},
				{value="Inteligent Sensors", option ="Inteligent Sensors"},
				{value="Military", option ="Military"},
				{value="RAD e Prototyping", option ="RAD e Prototyping"},
				{value="Robotics", option ="Robotics"},
				{value="Signal Processing", option ="Signal Processing"},
				{value="Space Exploration", option ="Space Exploration"},
				{value="Other", option ="Other"},
		}
		
CHECK_DEFAULT_VALUE = {{label = "", value = "true"}}


