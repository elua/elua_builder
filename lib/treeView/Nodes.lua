local cgilua, error, ipairs, table, type = cgilua, error, ipairs, table, type
local sool, treeView = sool, treeView


--- Class Nodes. Collection of Node.

module ("treeView.Nodes", sool.class())



--- (constructor) Creates a new Nodes object.
-- @name [class].new
-- @param params optional number indexed table containing a sequence of treeView.Node objects
-- @usage local oNodes = treeView.Nodes.new()
-- @usage local oNodes = treeView.Nodes.new{oNode1, oNode2, oNode3}
-- @return a new treeView.Nodes object. Type: treeView.Nodes
-- @see treeView.Node

function new(params)
  local object = _M:create()

  object.nodes = {}

  if (params) then
    if (type(params) ~= "table") then
      error("Invalid type of parameter 'params'. Expected 'table', got '"..type(params).."'.")
    end

    for i, v in ipairs(params) do
      if (sool.isA(v, treeView.Node)) then
        table.insert(object.nodes, v)
      else
        error("Invalid type of parameter. Expected 'Node'.")
      end
    end
  end

  return object
end


--- Inserts a new tree node into the collection.
-- @name [object]:insert
-- @param node node entry to be inserted. Type: treeView.Node
-- @usage oNodes:insert(oNode1)
-- @see treeView.Node

function _M:insert(node)
  if (sool.isA(node, treeView.Node)) then
    table.insert(self.nodes, node)
  else
    error("Invalid type of parameter 'node'. Expected 'Node'.")
  end
end


--- Returns the next node in the list.
-- @name [object]:getNextNode
-- @param nodeIndex the function will return the (nodeIndex + 1)th node. If nodeIndex is nil, returns the first node.
-- @usage oNodes:getNextNode()
-- @usage oNodes:getNextNode(5)
-- @return the next node index and the next node in the list. Type number and treeView.Node

function _M:getNextNode(nodeIndex)
  if (not nodeIndex) then
    nodeIndex = 0
  end
  return nodeIndex + 1, self.nodes[nodeIndex + 1]
end


--- Returns the number of children
-- @name [object]:getSize
-- @usage local numOfChildren = oNodes:getSize()
-- @return the number of children. Type: number

function _M:getSize()
  return #self.nodes
end


--- Prints the nodes in JavaScript format.
-- @name [object]:printJS
-- @usage oNodes:printJS()

function _M:printJS()
  cgilua.put(self.getJS())
end


--- Returns all nodes in JavaScript format.
-- @name [object]:getJS
-- @usage oNodes:getJS()
-- @return a string with all nodes in JavaScript format

function _M:getJS()
  local nodesStr = ""
  local count = #(self.nodes)

  for i = 1, count do
    nodesStr = nodesStr..self.nodes[i]:getJS()
    if (i < count) then
      nodesStr = nodesStr..","
    end
    nodesStr = nodesStr.."\n" 
  end

  return nodesStr
end
