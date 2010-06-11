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
      
      if (mvc_events.beforeAnyAction() ~= false)then
	      -- Load Action
	      local before_status = true
	      if(env[controller..'_before'] and type(env[controller..'_before'])== "function")then
	      	before_status = env[controller..'_before']()
	      	if(before_status == nil)then before_status = true end
	      end
	      
	      if(action and action ~= "") then
		          if(before_status and env[action] and type(env[action])== "function")then
		              local status, error = assert(pcall(env[action]))
		          end
	      else
	           if(before_status and env["index"] and type(env["index"])== "function")then
	              action = "index"
	              APP.action = action
	              index()
	          end   
	      end
	  	mvc_events.afterAnyAction()
	  end
      
     
  else
    cgilua.handlelp(CONFIG.MVC_LIB.."pages/controller_error.lp")
    
  end
else
  -- Load default controller if none was defined in URL
  if (mvc_events.beforeAnyAction() ~= false)then
	  cgilua.doif(CONFIG.MVC_CONTROL.."default.lua")
	  index()
	  mvc_events.afterAnyAction()
  end
end

