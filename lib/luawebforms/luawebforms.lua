---------------------------------------------------------------------
--- LuaWebForms is a Lua library developed to create and manipulate HTML forms.
--- Some methods were based on Ruby on Rails Form Tag Helper, 
---	but new features were included to manipulate better "select", "radiobox" and "checkbox" tags.
--
-- @class module
-- @name luawebforms
-- @release $Id: luaWebForms.lua,v 1.0 beta 2008/07/02 15:17:00 Vagner Nascimento Exp $
---------------------------------------------------------------------

local cgilua = cgilua
local require = require
local print = print

module ("luawebforms", package.seeall)

----------------------------------------------
-- Local auxiliar Methods
----------------------------------------------

-- Returns a table where the values are table keys.
--  Used in intersection operations
--	@param tab Lua table 
local function value_to_key(tab)
	local res = {}
	for k,v in next,tab do
		res[v]= true
	end
	return res
end

-- Flatten a lua table
--	*Original function in Orbit.lua
--	@param tab Lua table 
local function flatten(t)
   local res = {}
   for _, item in ipairs(t) do
      if type(item) == "table" then
	 res[#res + 1] = flatten(item)
      else
	 res[#res + 1] = item
      end
   end
   return table.concat(res)
end

-- Bulds a HTML tag
--	*Original function in Orbit.lua
--	@param name Name of HTML tag
--	@param data Lua table with tag argumts
--	@param before_tag String to be concatenated before the tag
--	@param after_tag String to be concatenated after the tag
-- 	@param close_tag If is a true value,it is included a "/" in the end of the tag,to closing it
--	@param block_tag If is a true value,it is close the block tag. Ex: </tag>
local function make_tag(name, data, before_tag, after_tag, close_tag, block_tag)
  if not data then
    return "<" .. name .. class .. "/>"
  elseif type(data) == "string" then
    return "<" .. name .. class .. ">" .. data ..
      "</" .. name .. ">"
  else
    local attrs = {}
    for k, v in pairs(data) do
      if type(k) == "string" then
        if(type(v)=="boolean" and v)then
        	table.insert(attrs, tostring(k))
        elseif(type(v)=="string" or type(v)=="number")then
        	table.insert(attrs, k .. '="' .. v .. '"')
        end
       
      end
    end
    local open_tag = "<" .. name .." ".. table.concat(attrs, " ")
    if(close_tag)then
    	open_tag = open_tag .. "/>"
    else
    	 open_tag = open_tag .. ">"
    end
    local block_tag_value = ""
    if(block_tag)then
    	block_tag_value = "</" .. name .. ">"	
    end
    if(before_tag == nil)then
    	before_tag = ""
    end
    if(after_tag == nil)then
    	after_tag = ""
    end
    return before_tag .. open_tag .. flatten(data) .. after_tag .. block_tag_value       
  end      
end

----------------------------------------------
--- Form Methods
----------------------------------------------

--- Returns a string with a input form tag.
-- @param arg Lua table with text input parameters
-- @usage obj.text_field({name="field1", value="xpto", readonly=true})
---------------------------------------------------------------------
function text_field(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type="text"
	return make_tag("input",arg,"","",true)
end

--- Returns a string with a hidden form tag.
-- @param arg Lua table with hidden input parameters
-- @usage obj.hidden_field({name="hidden1", value="xpto"})
---------------------------------------------------------------------
function hidden_field(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type="hidden"
	return make_tag("input",arg,"","",true)
end

--- Returns a string with a file field form tag.
-- @param arg Lua table with file input parameters
-- @usage obj.file_field({name="file"})
---------------------------------------------------------------------
function file_field(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type="file"
	return make_tag("input",arg,"","",true)
end

--- Returns a string with a password field form tag.
-- @param arg Lua table with password input parameters
-- @usage obj.password_field({name="passwd", value="1234"})
---------------------------------------------------------------------
function password_field(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type="password"
	return make_tag("input",arg,"","",true)
end

--- Returns a string with a submit button form tag.
-- @param arg Lua table with submit parameters
-- @usage obj.submit({name="send", value="send"})
---------------------------------------------------------------------
function submit(arg, insertBefore, insertAfter)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	local insertBefore = insertBefore or "";
	local insertAfter = insertAfter or "";
	
	arg.type="submit"
	return make_tag("input",arg,insertBefore,insertAfter,true)
	
end

--- Returns a string with a form button tag.
-- @param arg Lua table with button parameters
-- @usage obj.button({name="bt1", value="Hello", onclick="alert('Hello')"})
---------------------------------------------------------------------
function button(arg, insertBefore, insertAfter)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	local insertBefore = insertBefore or "";
	local insertAfter = insertAfter or "";
	
	arg.type="button"
	return make_tag("input",arg,insertBefore,insertAfter,true)
	
end

--- Returns a string with a label tag.
-- @param arg Lua table with label parameters
-- @param value String with label content 
-- @usage obj.label({name="label1"},"Field Label1")
---------------------------------------------------------------------
function label(arg,value)
	if(arg == nil)then
		arg = {}
	end
	if(arg["for"] == nil)then
		arg["for"] = arg.name
	end
	arg.name = nil
	return make_tag("label",arg,"",value,false,true)
	
end

--- Returns a string with a text-area form tag.
-- @param arg Lua table with text-area parameters
-- @param value String with text-area content 
-- @usage obj.text_area({name="text1"},"very long text or string variable")
---------------------------------------------------------------------
function text_area(arg,value)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	return make_tag("textarea",arg,"",value,false,true)
	
end

--- Returns a string with a image submit button tag.
-- @param arg Lua table with image submit parameters
-- @usage obj.image_submit({name="bt_img", value="ok", src="/img/bt.gif"})
---------------------------------------------------------------------
function image_submit(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type="image"
	return make_tag("input",arg,"","",true)
end

--- Returns a string with a open form tag.
-- @param arg Lua table with form parameters
-- @usage obj.form({action="sender.lua"})
-- @return If no method was defined, it is used the default "Post", ex: &lt;form action="sender.lua" method="post"&gt;
function form(arg)
	if(arg == nil)then
		arg = {}
	end
	if(arg.method == nil)then
		arg.method = "post"
	end
	if(arg.multipart == true)then
		arg.enctype = "multipart/form-data"
		arg.multipart = nil
	end
	local tag = make_tag("form",arg,"","",false,false)
	return tag
end

--- Returns a string with &lt;/form&gt;, to close the tag form
--	@usage obj.form_close()
function form_close()
	return "</form>"
end


--- Returns a string with a select form tag.
-- @param arg Lua table with select parameters
-- @param values Accepts a table in the format: {{value="xxx",option="xxoptionxx"},{value="zzz", option="zzoptionzz"}}
-- @param selected_value Accepts a string or number to be selected
-- @usage obj.select({name="drop1"},{{value=1,option="value1},{value="b",option="value b"}},"b") 
function select(arg,values,selected_value)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	local option_values = ""
	if(arg.prompt)then
		option_values = make_tag("option",{value=""},"",arg.prompt,false,true)
	end
	if(type(values)=="table")then
		for k,v in next,values do
			local selected_v = false
			if(selected_value ~= nil and tostring(selected_value) == tostring(v.value))then
				selected_v = true
			end
			local option_item = v.option
			v.option = nil
			v.selected = selected_v
			option_values = option_values.."\n"..make_tag("option",v,"",option_item,false,true)
		end
	end
	
	return make_tag("select",arg,"",option_values,false,true)
end


--- Returns a string with a group of check boxs tags.
-- @param arg Lua table with check box parameters
-- @param values Accepts a table in the format:	{{value="apple",label="Apple"},{value="orange", label="Orange"},{value="grape", label="Grapes"}}
-- @param checked_values Accepts a table in the format:	{"apple","grape"}
-- @param spacer Puts the string sent after or before the check box. The default value is a " "(space)
-- @param left_labels If the value is true, the labels are positioned before the check box. The default is the right side
-- @usage obj.check_box({name="fruits"},{{value="ap",label="Apple"},{value="or", label="Orange"}}, {"or","ap"})
function check_box(arg,values,checked_values,spacer,left_labels)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type = "checkbox"
	if(spacer == nil)then
		spacer = " "
	end
	checks = ""
	local key_values_res = {}
	if(type(checked_values)=="table")then
		key_values_res = value_to_key(checked_values)
	end
	
	if(type(values)=="table")then
		for k,v in next,values do
			arg.value = ""
			arg.value = v.value
			arg.checked = false
			if(key_values_res[arg.value])then
				arg.checked = true
			end
			if(left_labels)then
				checks = checks.."\n"..make_tag("input",arg,v.label,spacer,true,false)
			else
				checks = checks.."\n"..make_tag("input",arg,"",v.label..spacer,true,false)
			end
		end
	end
	
	return checks
end

--- Returns a string with a group of radio buttons. 
-- @param arg Lua table with radio button parameters
-- @param values Accepts a table in the format:	{{value="br",label="Brazil"},{value="es", label="Spain"},{value="us", label="USA"}}
-- @param checked_values Accepts a string or number to be selected
-- @param spacer Puts the string sent after or before the radio button. The default value is a " "(space)
-- @param left_labels If the value is true, the labels are positioned before the radio button. The default is the right side
-- @usage obj.radio_button({{value="br",label="Brazil"},{value="es", label="Spain"}}, "es")
function radio_button(arg,values,checked_value,spacer,left_labels)
	if(arg == nil)then
		arg = {}
	end
	if(arg.id== nil)then
		arg.id = arg.name
	end
	arg.type = "radio"
	if(spacer == nil)then
		spacer = " "
	end
	radios = ""
	
	if(type(values)=="table")then
		for k,v in next,values do
			arg.value = v.value
			arg.checked = false
			if(v.value == checked_value)then
				arg.checked = true
			end
			
			if(left_labels)then
				radios = radios.."\n"..make_tag("input",arg,v.label,spacer,true,false)
			else
				radios = radios.."\n"..make_tag("input",arg,"",v.label..spacer,true,false)
			end
		end
	end
	
	return radios
end