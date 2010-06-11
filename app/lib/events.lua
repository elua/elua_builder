mvc_events = {}
function mvc_events.beforeAnyAction(jump)
	dofile(CONFIG.MVC_LIB.."general.lua")
	
	local dado = require"dado"
    db = dado.connect (CONFIG.DB.dbname,CONFIG.DB.username,CONFIG.DB.password,CONFIG.DB.driver)
    
    -- Connection database through Orbit Model (ORM)
    require "orbit.model"
    require "luasql.mysql"
    local envApp = luasql.mysql()
    local conn = envApp:connect(CONFIG.DB.dbname,CONFIG.DB.username,CONFIG.DB.password)
    mapper = orbit.model.new("", conn, "mysql")
    
    local UserModel = require "user.model"
    
    if(not UserModel.checkExceptions()) then
    	
    	if (UserModel.getCurrentUser() == nil or type(UserModel.getCurrentUser()) ~= "table")then
			traceLog('\nnao autenticou')
			flash.set("validationMessages",locale_general.denied_msg)
			redirect({control="user",act="index",redir=makeURL(cgilua.QUERY)})
			return false
		end
		
	end
	
	logged_user = UserModel.getCurrentUser()
end

function mvc_events.afterAnyAction()
end
