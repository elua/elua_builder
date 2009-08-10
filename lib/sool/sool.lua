local ipairs, setmetatable, type = ipairs, setmetatable, type 

--- SOOL - Simple Object Oriented lib for Lua.
-- Based on several OO implementations for Lua available on the web, SOOL implements 
-- instantiation, static classes, multiple inheritance and object type verification.
-- SOOL does not intend to be a complete implementation of OO for Lua, instead it intends to be simple and short.

module "sool"


-- Internal function: Looks up for method in the class list
local function searchMethod (method, classList)
  for i = 1, #classList do
    local methodFound = classList[i][method]
    if (methodFound) then 
      return methodFound
    end
  end
end


--- Creates a new ordinary class. Should be applied to a module on its creation.
-- @name sool.class
-- @param superclasses optional: single superclass or table containing superclasses for the new class
-- @usage <pre class='example'>
--        --package: transportation<br>
--        --superclass: Vehicle<br>
--        --new class: Automobile<br>
--        module ("transportation.Automobile", sool.class(transportation.Vehicle))<br>
--        <br>
--        function new()<br>
--        ...
--        </pre>

function class(superclasses)
  return function(newClass)
    local fixedSuperclassList
  
    if ((type(superclasses) == "table") and superclasses.class) then
      fixedSuperclassList = {superclasses}
    elseif (not superclasses) then
      fixedSuperclassList = {}
    else 
      fixedSuperclassList = superclasses
    end
  
    setmetatable(newClass, {__index = function (t, method)
      return searchMethod(method, fixedSuperclassList)
    end})

    newClass.__index = newClass

	--- Creates a new instance of the class. 
	-- @name [class]:create
	-- @usage <pre class='example'>
	--        --Class constructor<br>
	--        function new(attribute1)
	--          <dir>
	--          local object = _M:create()<br>
	--          object.attribute1 = attribute1 --Attribute defined on constructor<br>
	--          object.attribute2 = "SOME_VALUE" --Default value for attribute<br>
	--          return object
	--          </dir>
	--        end
    --        </pre>

    function newClass:create()
      local newInstance = {}
      setmetatable(newInstance, newClass)
      return newInstance
    end


	--- Returns the class of the instance. 
	-- @name [object]:class
	-- @usage <pre class='example'>
	--        print (sool.isA(object1:class(), Class1)
    --        </pre>
    -- @return the class of the instance.

    function newClass:class()
      return newClass
    end

    --- Returns the superclasses of the instance in a table.
	-- @name [object]:superclasses
	-- @usage <pre class='example'>
	--        local superclasses = object1:superclasses()<br>
	--        for i, v in ipairs(superclasses) do
	--          <dir>
    --          -- do something with each class v
	--          </dir>
	--        end
    --        </pre>
    -- @return the superclasses of the instance in a table.
    function newClass:superclasses()
      return fixedSuperclassList
    end
  end
end


--- Creates a new static class (a class only with class methods, and cannot be instatiated). Should be applied to a module on its creation.
-- @name sool.staticClass
-- @param superclasses optional: single superclass or table containing superclasses for the new class
-- @usage <pre class='example'>
--        module ("config.colors", sool.staticClass())<br>
--        <br>
--        function new()<br>
--        ...
--        </pre>
function staticClass(superclasses)
  return function(newClass)
    local fixedSuperclassList
  
    if ((type(superclasses) == "table") and superclasses.class) then
      fixedSuperclassList = {superclasses}
    elseif (not superclasses) then
      fixedSuperclassList = {}
    else 
      fixedSuperclassList = superclasses
    end
  
    setmetatable(newClass, {__index = function (t, method)
      return searchMethod(method, fixedSuperclassList)
    end})

    newClass.__index = newClass

	--- Returns the static class itself. 
	-- @name [staticClass]:class
	-- @usage <pre class='example'>
	--        print (sool.isA(staticClass1:class(), SomeOtherClass)
    --        </pre>
    -- @return the static class itself.
    function newClass:class()
      return newClass
    end

    --- Returns the superclasses of the static class in a table.
	-- @name [staticClass]:superclasses
	-- @usage <pre class='example'>
	--        local superclasses = object1:superclasses()<br>
	--        for i, v in ipairs(superclasses) do
	--          <dir>
    --          -- do something with each class v
	--          </dir>
	--        end
    --        </pre>
    -- @return the superclasses of the static class in a table.
    function newClass:superclasses()
      return fixedSuperclassList
    end
  end
end


--- Creates a new package. Should be applied to a module on its creation. Usually, a package is used to group classes. 
-- @name sool.package
-- @usage <pre class='example'>
--         module ("display", sool.package())<br>
--         <br>
--         Menu = require "display.Menu"<br>
--         Text = require "display.Text"<br>
--         Button = require "display.Button"
--        </pre>
function package()
end


--- Verifies if the object is an instance of the base class or if the class inherits from the base class.
-- @name sool.isA
-- @param objectOrClass object or class being verified
-- @param superclass supposed parent class
-- @usage <pre class='example'>
--        print(sool.isA(object1, Class1))<br>
--        print(sool.isA(Class1, Class2))
--        </pre>
-- @return true if object is an instance of the base class or if the class inherits from the base class. Otherwise, returns false.

function isA(objectOrClass, superclass)
  local retVal = false
  
  if ((type(objectOrClass) == "table") and objectOrClass.class) then
    local currClass = objectOrClass:class()
    if (currClass == superclass) then
      retVal = true
    else
      local superclasses = currClass:superclass()
      for _, currsuperclass in ipairs(superclasses) do
        if (isA(currSuperclass, superclass)) then
          retVal = true
          break
        end
      end    
    end    
  end  
  return retVal
end
