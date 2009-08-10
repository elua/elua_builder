local cgilua, error, pairs, string, tostring, type = cgilua, error, pairs, string, tostring, type
local sool, treeView = sool, treeView


--- Class Tree. Displays a navigation Tree.

module ("treeView.Tree", sool.class())


--- (constructor) Creates a new Tree object.
-- @name [class].new
-- @usage local oTree = treeView.Tree.new("tree1")
-- @param name the tree name, for reference. Type: string
-- @return a new treeView.Tree object. Type: treeView.Tree

function new(name)
  local object = _M:create()

  if(type(name) == "string") then
    object.name = name
  else
    error("Invalid type of parameter 'name'. Expected 'string', got '"..type(name).."'.")
  end

  --Default values
  object.target = "_self"

  return object
end


--- Prints the JavaScript for the header for all trees on the page. tree. Should be inserted inside the html 'header' tag.
-- @name [class].printHeader
-- @param jsPath the path where the JavaScript source files are. Type: string
-- @param cssPath the path where the CSS file for the tree is. Type: string
-- @usage Tree.printHeader("scripts/js/")

function printHeader(jsPath, cssPath)
  if(type(jsPath) ~= "string") then
    error("Invalid type of parameter 'jsPath'. Expected 'string', got '"..type(jsPath).."'.")
  end
  if(type(cssPath) ~= "string") then
    error("Invalid type of parameter 'cssPath'. Expected 'string', got '"..type(cssPath).."'.")
  end

  cgilua.put([[
<link type="text/css" rel="stylesheet" href="]]..cssPath..[[treeview.css">
<script src="]]..jsPath..[[yahoo.js"></script>
<script src="]]..jsPath..[[event.js"></script>
<script src="]]..jsPath..[[treeview.js"></script>
<script src="]]..jsPath..[[connection.js"></script>

<script language="JavaScript">
<!--

var selectNodeData = new Object();

// Public Functions

function isTreeReady(treeName) {
  return treeReady[treeName]
}

function selectNode(treeName, idList, clickOnNode, index, node) {  
  var waitingForLoad = false;
  
  if (index == undefined) {
    index = 0;
    node = trees[treeName].getRoot();
  }
  
  for(var i = index; i < idList.length; i++) {
	if (!node.hasChildren(true)) {
	  return false;
	}
	else {
	  if (node.isDynamic() && !node.dynamicLoadComplete) {
	    selectNodeData[treeName] = new Object();
	    selectNodeData[treeName].idList = idList;
	    selectNodeData[treeName].currIndex = i;
	    selectNodeData[treeName].node = node;
        selectNodeData[treeName].clickOnNode = clickOnNode;
      
	    node.expand();
	    waitingForLoad = true;
	    break;
	  }
	  else {
	    node.expand();
	  }
	}	
	
	node = getChildById(node, idList[i]);
	if (node == null) {
	  return false;
	}
  }
  if (waitingForLoad == false) {
    if (node) {
	    if (node.data.ref.url) {
	      setSelectedNode(node.getContentEl().childNodes.item(0), treeName, node.data.ref.url, node.data.target);
	      if (clickOnNode) {
	        openNodeUrl(node.data.ref.url, node.data.target);
	      }
	    }
	    else {
	      setSelectedNode(node.getContentEl().childNodes.item(0), treeName);
	    }
      return true;
    }
    else {
      return false;
    }
  }
  return true;
}

// End of Public Functions


function getChildById(parentNode, id) {
  for (var i = 0; i < parentNode.children.length; i++) {  
    if (id.toString() == parentNode.children[i].data.ref.id.toString()) {
      return parentNode.children[i];
    }
  }
  return null;
}


function disableSelection(target) {
  if (typeof target.onselectstart != "undefined") {
    //IE
    target.onselectstart = function() { return false; }
  }
  else if (typeof target.style.MozUserSelect != "undefined") {
    //Firefox
    target.style.MozUserSelect = "none";
  }
}


var selectedTreeNode  = new Object();
var trees             = new Object();
var treeReady       = new Object();

function drawNodes(treeName, targetDefault, parentNode, oNodes) {
  for (var i = 0; i < oNodes.length; i++) {    
    var target = oNodes[i].target? oNodes[i].target : targetDefault;
        
    var html = "";    
    if (oNodes[i].url) {
      html = "<div class='node' onclick='treeNodeOnClick(this, \"" + treeName + "\", \"" + oNodes[i].url + "\", \"" + target + "\")'>";
    }
    else {
      html = "<div class='node' onclick='treeNodeOnClick(this, \"" + treeName + "\")'>";      
    }
    if (oNodes[i].icon) {
      html += "<img align='absmiddle' class='nodeIcon' src='" + oNodes[i].icon + "'>";
    }
    html += "<span class='nodeText'>" + oNodes[i].label + "</span>";
    html += "</div>";
    
    var node = new YAHOO.widget.HTMLNode(html, parentNode, false, true);
    
    node.data = new Object();
    oNodes[i].node = node;
    
    if (oNodes[i].startOpen) {
      node.expand();
    }
    
    if (oNodes[i].id) {
      node.data.id = oNodes[i].id;
    }

    node.data.treeName = treeName;
    node.data.target = target;
    node.data.ref = oNodes[i]; 
    if (oNodes[i].children) {
      drawNodes(treeName, targetDefault, node, oNodes[i].children);
    }
    else if (oNodes[i].childrenUrl) {
      node.data.childrenUrl = oNodes[i].childrenUrl;
      node.setDynamicLoad(loadNodeData, 0);
    }
    else {
      node.isLeaf = true;
    }
  }
}

function treeNodeOnClick(nodeSpan, treeName, url, target) {
  setSelectedNode(nodeSpan, treeName, url, target);
  openNodeUrl(url, target);  
}

function setSelectedNode(nodeSpan, treeName, url, target) {
  if (selectedTreeNode[treeName] != null) {
    selectedTreeNode[treeName].className = "node";
  }
  nodeSpan.className = "nodeSelected";
  
  selectedTreeNode[treeName] = nodeSpan;
}

function openNodeUrl(url, target) {
  if (url) {    
    window.open(url, target);
  }  
}

function loadNodeData(node, fnLoadComplete) {
  var sUrl = node.data.childrenUrl;
 
  var callback = {
    success: function(oResponse) {
      var oNodes = eval("[" + oResponse.responseText + "]");
      node.data.ref.children = oNodes;
      drawNodes(node.data.treeName, node.data.target, node, oNodes);

      oResponse.argument.fnLoadComplete();

      if (selectNodeData[node.data.treeName] != null) {       
        var idList = selectNodeData[node.data.treeName].idList;
        var currIndex = selectNodeData[node.data.treeName].currIndex;
        var currNode = selectNodeData[node.data.treeName].node;
        var clickOnNode = selectNodeData[node.data.treeName].clickOnNode;
        selectNodeData[node.data.treeName] = null;
        selectNode(node.data.treeName, idList, clickOnNode, currIndex, currNode);
      }
    },

    failure: function(oResponse) {
      oResponse.argument.fnLoadComplete();
    },

    argument: {
      "node": node,
      "fnLoadComplete": fnLoadComplete
    },
    timeout: 15000
  };

  YAHOO.util.Connect.asyncRequest('GET', sUrl, callback);
}

//-->
</script>
]])

end

--- Sets the children, represented by a TreeNodes object.
-- @name [object]:setChildren
-- @param children the TreeNodes object representing the children. Type: TreeNode
-- @usage oTree:setChildren(oTreeNodes)

function _M:setChildren(children)
  if(sool.isA(children, treeView.Nodes)) then
    self.children = children
  else
    error("Invalid type of parameter 'children'. Expected 'treeView.Nodes'.")
  end
end


--- Sets the tree html default target.
-- @name [object]:setTarget
-- @param target the tree html target where the node's url will be open by default. Can be overriden by each node target attribute. Valid values: "_blank", "_parent", "_self", "_top" (all in lowercase) or the destination window/frame name. Default: "_self". Type: string
-- @usage oTree:setTarget("_blank")

function _M:setTarget(target)
  if(type(target) == "string") then
    self.target = target
  else
    error("Invalid type of parameter 'target'. Expected 'string', got '"..type(target).."'.")
  end
end


--- Prints the code that builds the tree. Should be inserted at the position the tree will appear, inside the html 'body' tag.
-- @name [object]:printBody
-- @usage oTree:printBody()

function _M:printBody()

  cgilua.put([[

<div id="]]..self.name..[["></div>

<script language="JavaScript">
<!--

disableSelection(document.getElementById("]]..self.name..[["));
trees["]]..self.name..[["] = new YAHOO.widget.TreeView("]]..self.name..[[");
treeReady["]]..self.name..[["] = false;

function buildTree]]..self.name..[[() {
  
  selectedTreeNode["]]..self.name..[["] = null;
]])

  function printNodes(oNodes)
    cgilua.put("[\n")
    local nodeIndex, oNode = oNodes:getNextNode(nil)
    local isFirst = true
    while(oNode) do
      if (not isFirst) then
       cgilua.put(",\n")
      else
        isFirst = false
      end    
      cgilua.put("    {label: \""..oNode:getLabel().."\"")

      if (oNode:getId()) then
        cgilua.put(", id: \""..oNode:getId().."\"")
      end
      
      if (oNode:getUrl()) then
        cgilua.put(", url: \""..oNode:getUrl().."\"")
      end
      
      if (oNode:getTarget()) then
        cgilua.put(", target: \""..oNode:getTarget().."\"")
      end
      
      
      if (oNode:getIcon()) then
        cgilua.put(", icon: \""..oNode:getIcon().."\"")
      end      
      
      if (oNode:getStartOpen()) then
        cgilua.put(", startOpen: \""..tostring(oNode:getStartOpen()).."\"")
      end      

      if (oNode:getChildren()) then
        cgilua.put(", children: ")
        printNodes(oNode:getChildren())
        cgilua.put("\n    ]")
      elseif (oNode:getChildrenUrl()) then
        cgilua.put(", childrenUrl: \""..oNode:getChildrenUrl().."\"")
      end
      cgilua.put("}")
      
      nodeIndex, oNode = oNodes:getNextNode(nodeIndex)
    end
  end
  
  cgilua.put("  var rootNode = trees[\""..self.name.."\"].getRoot();\n");
  
  cgilua.put("  oNodes = ")
  printNodes(self.children)
  
  cgilua.put("\n  ]\n")
  cgilua.put("  drawNodes(\""..self.name.."\", \""..self.target.."\", rootNode, oNodes);")


  cgilua.put([[

  trees["]]..self.name..[["].draw();
  treeReady["]]..self.name..[["] = true;
}

//-->
</script>

]])

end


--- Makes all trees on page show. Should be inserted in end of the page, inside the html 'body' tag.
-- @name [class]:show
-- @usage treeView.Tree.show()

function show()

  cgilua.put([[

<script language = "JavaScript">
<!--

function buildTrees() {
  for (var key in trees) {
    eval("buildTree" + key + "();");
  }
}

YAHOO.util.Event.onDOMReady(buildTrees, null, true);

//-->
</script>

  ]])
end

