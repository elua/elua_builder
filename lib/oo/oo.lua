local ipairs, setmetatable, type = ipairs, setmetatable, type 

--- Object Orientation module, for internal use only.
module "oo"


-- Looks up for method in the class list
local function searchMethod (method, classList)
  for i = 1, #classList do
    local methodFound = classList[i][method]
    if (methodFound) then 
      return methodFound
    end
  end
end


-- Creates a new ordinary class    
function class(baseClassList)
  return function(newClass)
    local fixedBaseClassList
  
    if ((type(baseClassList) == "table") and baseClassList.class) then
      fixedBaseClassList = {baseClassList}
    elseif (not baseClassList) then
      fixedBaseClassList = {}
    else 
      fixedBaseClassList = baseClassList
    end
  
    setmetatable(newClass, {__index = function (t, method)
      return searchMethod(method, fixedBaseClassList)
    end})

    newClass.__index = newClass

    -- Creates a new instance of newClass
    function newClass:create()
      local newInstance = {}
      setmetatable(newInstance, newClass)
      return newInstance
    end

    -- Returns the class of the instance
    function newClass:class()
      return newClass
    end

    -- Returns the super classes of the instance in a table
    function newClass:superClass()
      return fixedBaseClassList
    end
  end
end


function staticClass(baseClassList)
  return function(newClass)
    local fixedBaseClassList
  
    if ((type(baseClassList) == "table") and baseClassList.class) then
      fixedBaseClassList = {baseClassList}
    elseif (not baseClassList) then
      fixedBaseClassList = {}
    else 
      fixedBaseClassList = baseClassList
    end
  
    setmetatable(newClass, {__index = function (t, method)
      return searchMethod(method, fixedBaseClassList)
    end})

    newClass.__index = newClass

    -- Returns the class of the instance
    function newClass:class()
      return newClass
    end

    -- Returns the super classes of the instance in a table
    function newClass:superClass()
      return fixedBaseClassList
    end
  end
end


-- Creates a new package
function package(newPackage)
end


-- Returns true if the object is an instance of the base class or if the class inherits from the base class
function isA(objectOrClass, baseClass)
  local retVal = false
  
  if ((type(objectOrClass) == "table") and objectOrClass.class) then
    local currClass = objectOrClass:class()
    if (currClass == baseClass) then
      retVal = true
    else
      local baseClassList = currClass:superClass()
      for _, currBaseClass in ipairs(baseClassList) do
        if (isA(currBaseClass, baseClass)) then
          retVal = true
          break
        end
      end    
    end    
  end  
  return retVal
end
