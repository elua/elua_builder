dofile("../config_app.lua")

if (CONFIG.ENABLE_MAPPED_URL == true) then
  dofile(CONFIG.MVC_LIB.."dispatch.lua")
end

require "flash"
dofile(CONFIG.MVC_LIB.."support.lua")
dofile(CONFIG.MVC_LIB.."events.lua")

local currenty_lang = CONFIG.LANGUAGE
cgilua.doif(CONFIG.MVC_LOCALE..currenty_lang.."-general.lua")

----------------------------------------------------------------------------
-- CGILua MVC loader.
--
-- @release $Id: start.lua,v 1.00 beta 2008/06/13 Vagner Nascimento Exp $
----------------------------------------------------------------------------
package.path = CONFIG.MVC_MODEL..[[?.lua;]]..package.path
APP = {}
local controller = cgilua.QUERY.control or cgilua.POST.control or 'default'
local action = cgilua.QUERY.act or cgilua.POST.act or 'index'
APP.controller = controller
APP.action = action

-- Load controller
if(controller and controller ~= "")then
  if (cgilua.doif(CONFIG.MVC_CONTROL..controller..".lua"))then
  	  -- Load controller locale 
  	  cgilua.doif(CONFIG.MVC_LOCALE..currenty_lang.."-"..controller..".lua") 	  
  	  -- Event before action
      env = getfenv()
      local ok, any_action = run_safe(mvc_events.beforeAnyAction)
      if (ok and  any_action ~= false)then 
	      -- Load Action
	      local before_status = true
	      if(env[controller..'_before'] and type(env[controller..'_before'])== "function")then
	      	ok , before_status = run_safe(env[controller..'_before'])
	      	before_status = before_status == nil and true or false
	      end
	      
	      if(action and action ~= "") then
	          if(before_status and env[action] and type(env[action])== "function")then
	              run_safe(env[action])
	          end
	      else
	           if(before_status and env["index"] and type(env["index"])== "function")then
	              action = "index"
	              APP.action = action
	              run_safe(index)
	          end   
	      end
	  	  run_safe(mvc_events.afterAnyAction)
	  end
  else
    cgilua.handlelp(CONFIG.MVC_LIB.."pages/controller_error.lp")
    
  end
else
  -- Load default controller if none was defined in URL
  local ok, any_action = run_safe(mvc_events.beforeAnyAction)
  if (ok and  any_action ~= false)then
	  cgilua.doif(CONFIG.MVC_CONTROL.."default.lua")
	  run_safe(index)
	  run_safe(mvc_events.afterAnyAction)
  end
end

