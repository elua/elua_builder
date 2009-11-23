----------------------------------
-- Support Library for LED's MVC
----------------------------------

-- Show Lua Page, if no view has been sent, will be used the same of controller 
function render(lp,view)
  if(not view)then
     view = APP.controller
  end
  cgilua.handlelp(CONFIG.MVC_VIEW..view.."/"..lp)
end

-- Load Model
function loadModel()
    cgilua.doif(CONFIG.MVC_MODEL..APP.controller.."/"..APP.controller..".lua")
end

-- make safe URLs, adding controller and action 
-- ## Receive a luatable with argument
function makeURL(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.control == nil or arg.control == "")then
		arg.control = APP.controller
	end
	if(arg.act == nil or arg.act == "")then
		arg.act = APP.action
	end
  local url = "start.lua?control="..arg.control.."&act="..arg.act
  if (CONFIG.ENABLE_MAPPED_URL == true) then 	
    url = "/"..CONFIG.APP_NAME.."/"..(arg.control).."/"..(arg.act)..(arg.id and "/"..arg.id or "")
    arg.id = nil
  end
  arg.control, arg.act = nil, nil
	local result = cgilua.urlcode.encodetable(arg)
	if result and result ~= '' then
		return url.."&"..result
	else
		return url
	end
end

function loadJS(urlPath)
	urlPath = urlPath or ""
	local scripts = [[<script type="text/javascript" src="]]..urlPath..[["></script>]]
	cgilua.put(scripts)
end

function loadCSS(urlPath,media)
	urlPath = urlPath or ""
	media = media or "all"
	local cssLink = [[<link href="]]..urlPath..[[" rel="stylesheet" type="text/css" media="]]..media..[[">]]
	cgilua.put(cssLink)
end

-- Returns if the current page was required by post
function isPOST()
	if(next(cgilua.POST))then
		return true
	else
		return false
	end 
end

function redirect(arg,external)
	if(external)then
		cgilua.redirect(arg)
	else
		if(arg == nil)then
			arg = {}
		end
		if(arg.control == nil or arg.control == "")then
			arg.control = APP.controller
		end
		if(arg.act == nil or arg.act == "")then
			arg.act = APP.action
		end
		if (CONFIG.ENABLE_MAPPED_URL == true) then 	
		    url = cgilua.mkabsoluteurl("/"..CONFIG.APP_NAME.."/"..(arg.control).."/"..(arg.act)..(arg.id and "/"..arg.id or ""))
		    arg.control = nil
		    arg.act = nil
		    arg.id = nil
		    
		    local complement = cgilua.urlcode.encodetable(arg) ~= nil and "&"..cgilua.urlcode.encodetable(arg) or ""
		    
			cgilua.redirect(url..complement)
		else
			--cgilua.redirect(cgilua.mkabsoluteurl(cgilua.urlpath),arg)
			cgilua.redirect(cgilua.mkabsoluteurl("/"..CONFIG.APP_NAME.."/"..makeURL(arg)))
		end
		
	end
end