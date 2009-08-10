local cgilua, error, tostring, type = cgilua, error, tostring, type
local sool, treeView = sool, treeView


--- Class Node. Sets a node for class TreeView.

module ("treeView.Node", sool.class())


--- (constructor) Creates a new tree node object.
-- @name [class].new
-- @param params optional table containing one or more named parameters for object initialization. Available parameters: label, icon, url, children, childrenUrl, startOpen, id
-- @usage local oNode = treeView.Node.new{label = "Google", icon = "img/google.gif", url = "http://www.google.com"} 
-- @return a new treeView.Node object. Type: treeView.Node

function new(params)
  local object = _M:create()
  
  if (type(params) ~= "table") then
    error("Invalid type of parameter 'params'. Expected 'table', got '"..type(params).."'.")
  end
  
  if (params.label) then
    object:setLabel(params.label)
  else
    object:setLabel("")
  end

  if (params.icon) then
    object:setIcon(params.icon)
  end

  if (params.url) then
    object:setUrl(params.url)
  end

  if (params.startOpen) then 
    object:setStartOpen(params.startOpen)
  end

  if (params.children) then
    object:setChildren(params.children)
  end
  
  if (params.childrenUrl) then    
    object:setChildrenUrl(params.childrenUrl)
  end

  if (params.id) then    
    object:setId(params.id)
  end

  if (params.target) then    
    object:setTarget(params.target)
  end

  if (params.data) then    
    object:setData(params.data)
  end
  
  return object
end

--- Sets the node data.
-- @name [object]:setData
-- @param data the node data. Type: table
-- @usage oNode:setData({"Administrator"})

function _M:setData(data)
  if(type(data) == "table") then
    self.data = data
  else
    error("Invalid type of parameter 'data'. Expected 'table', got '"..type(data).."'.")
  end
end

--- Gets the node data.
-- @name [object]:getData
-- @usage local data = oNode:getData()
-- @return the node data. Type: table

function _M:getData()
  return self.data
end

--- Sets the node label.
-- @name [object]:setLabel
-- @param label the node label. Type: string
-- @usage oNode:setLabel("Google")

function _M:setLabel(label)
  if(type(label) == "string") then
    self.label = label
  else
    error("Invalid type of parameter 'label'. Expected 'string', got '"..type(label).."'.")
  end
end


--- Gets the node label.
-- @name [object]:getLabel
-- @usage local label = oNode:getLabel()
-- @return the node label. Type: string

function _M:getLabel()
  return self.label
end




--- Sets the url where the icon is located.
-- @name [object]:setIcon
-- @param icon the url where the icon is located. Type: string
-- @usage oNode:setIcon("img/google.gif")

function _M:setIcon(icon)
  if(type(icon) == "string") then
    self.icon = icon
  else
    error("Invalid type of parameter 'icon'. Expected 'string', got '"..type(icon).."'.")
  end
end


--- Gets the url where the icon is located.
-- @name [object]:getIcon
-- @usage local icon = oNode:getIcon()
-- @return the url where the icon is located. Type: string

function _M:getIcon()
  return self.icon
end


--- Sets the url the node will call when clicked.
-- @name [object]:setUrl
-- @param url the url the node will call when clicked. Type: string
-- @usage oNode:setUrl("http://www.google.com")

function _M:setUrl(url)
  if(type(url) == "string") then
    self.url = url
  else
    error("Invalid type of parameter 'url'. Expected 'string', got '"..type(url).."'.")
  end
end


--- Gets the url the node will call when clicked.
-- @name [object]:getUrl
-- @usage local url = oNode:getUrl()
-- @return url the node will call when clicked. Type: string

function _M:getUrl()
  return self.url
end


--- Sets the html target where the node url will be opened. Overrides the tree target attribute.
-- @name [object]:setTarget(target)
-- @usage oNode:setTarget("_blank")

function _M:setTarget(target)
  if(type(target) == "string") then
    self.target = target
  else
    error("Invalid type of parameter 'target'. Expected 'string', got '"..type(target).."'.")
  end
end

--- Gets the html target where the node url will be opened.
-- @name [object]:getTarget()
-- @usage local target = oNode:getTarget()
-- @return the target where the node url will be opened. Type: string

function _M:getTarget()
  return self.target
end

--- Defines if the node starts open, showing all children, if any.
-- @name [object]:setStartOpen
-- @param startOpen true if node should start open showing all children, false otherwise. Default: false. Type: boolean
-- @usage oNode:setStartOpen(true)

function _M:setStartOpen(startOpen)
  if(type(startOpen) == "boolean") then
    self.startOpen = startOpen
  else
    error("Invalid type of parameter 'startOpen'. Expected 'boolean', got '"..type(startOpen).."'.")
  end
end


--- Gets the value that indicates if node will start open, showing all children, if any.
-- @name [object]:getStartOpen
-- @usage local startOpen = oNode:getStartOpen()
-- @return a boolean value. True indicates the node will start open showing all children, and false indicates it will start closed.

function _M:getStartOpen()
  return self.startOpen
end


--- Sets the children, represented by a Nodes object.
-- @name [object]:setChildren
-- @param children the Nodes object representing the children. Type: treeView.Node
-- @usage oNode:setChildren(oNodes)

function _M:setChildren(children)
  if(sool.isA(children, treeView.Nodes) or (children == nil)) then
    self.children = children
  else
    error("Invalid type of parameter 'children'. Expected 'treeView.Nodes'.")
  end
end


--- Gets the children, represented by a treeView.Nodes object.
-- @name [object]:getChildren
-- @usage oNode:getChildren()
-- @return a treeView.Nodes object with all children. Type: treeView.Nodes 

function _M:getChildren()
  return self.children
end


--- Sets the url for fetching the children, if not set by the setChildren method.
-- @name [object]:setChildrenUrl
-- @param url the url for fetching the children. The children must be returned in the Nodes.getJS() format. Type: string
-- @usage oNode:setChildrenUrl("http://someurl/getchildren.lua?id=325")

function _M:setChildrenUrl(url)
  if(type(url) == "string") then
    self.childrenUrl = url
  else
    error("Invalid type of parameter 'url'. Expected 'string', got '"..type(url).."'.")
  end
end


--- Gets the url for fetching the children, if not set by the setChildren method.
-- @name [object]:getChildrenUrl
-- @usage oNode:getChildrenUrl()
-- @return the url for fetching the children, if not set by the setChildren method. Type: string

function _M:getChildrenUrl()
  return self.childrenUrl
end


--- Sets the id of the node. Must be unique among siblings for correct use. Used to locate the node from outside the tree.
-- @name [object]:setId
-- @param id the node id. Type: string. Numbers will be accepted but converted to strings.
-- @usage oNode:setId("node12")

function _M:setId(id)  
  if((type(id) == "string") or (type(id) == "number")) then
    self.id = tostring(id)
  else
    error("Invalid type of parameter 'id'. Expected 'string', got '"..type(id).."'.")
  end
end


--- Gets the node id.
-- @name [object]:getId
-- @usage local id = oNode:getId()
-- @return the node id. Type: string

function _M:getId()
  return self.id
end


-- Internal function
-- Returns the node in JavaScript format for building up the tree

function _M:getJS()
  local iconStr = [[{label: "]]..self.label..[["]]
  
  if (self.url) then
    iconStr = iconStr..[[, url: "]]..self.url..[["]]
  end
  
   if (self.target) then
    iconStr = iconStr..[[, target: "]]..self.target..[["]]
  end
  
  if (self.icon) then
    iconStr = iconStr..[[, icon: "]]..self.icon..[["]]
  end

  if (self.startOpen) then
    iconStr = iconStr..[[, startOpen: "]]..tostring(self.startOpen)..[["]]
  end

  if (self.id) then
    iconStr = iconStr..[[, id: "]]..tostring(self.id)..[["]]
  end
    
  if (self.children) then
    iconStr = iconStr..", children: [\n"
    iconStr = iconStr..self.children:getJS()
    iconStr = iconStr.."]\n"
  elseif (self.childrenUrl) then
    iconStr = iconStr..[[, childrenUrl: "]]..self.childrenUrl..[["]]
  end
  
  iconStr = iconStr.."}"
  
  return iconStr
end