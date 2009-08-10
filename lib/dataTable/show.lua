---------------------------------------------------------------------
--- This module manipulates and generates visualization scripts for YUI Datatable 
-- @release $Id: show.lua,v1.0  2009/02/19 Vagner Nascimento Exp $
---------------------------------------------------------------------
local cgilua, error, pairs, string, tostring, type, table = cgilua, error, pairs, string, tostring, type, table
local json = require "json"
module ("dataTable.show")

--- Prints the DataTable CSS header
-- @param urlPath String with the relative path for CSS library
-- @usage <pre class='example'>
--			dt = require("dataTable.show")<br>
--			dt.printDataTableCSS('yui/css/')
--		  </pre>
function printDataTableCSS(urlPath)
	urlPath = urlPath or ""
	local css = [[
		<link rel="stylesheet" type="text/css" href="]]..urlPath..[[datatable.css" />
	]]
	cgilua.put(css)
end

--- Prints the required javascript headers
-- @param urlPath String with relative path for JS libraries
-- @usage <pre class='example'> dt.printJSheaders('yui/js/') </pre>
function printJSheaders(urlPath)
	urlPath = urlPath or ""
	local scripts = [[
		<script type="text/javascript" src="]]..urlPath..[[yahoo-dom-event.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[connection.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[json-min.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[element-min.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[dragdrop-min.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[datasource-min.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[datatable-min.js"></script>
		<script type="text/javascript" src="]]..urlPath..[[paginator-min.js"></script>		
	]]
	cgilua.put(scripts)
end

--- Prints the required CSS headers
-- @param urlPath String with relative path for CSS libraries
-- @usage <pre class='example'> dt.printYuiCSS('yui/css/') </pre>
function printYuiCSS(urlPath)
	urlPath = urlPath or ""
	local css = [[
		<link rel="stylesheet" type="text/css" href="]]..urlPath..[[fonts-min.css" />
		<link rel="stylesheet" type="text/css" href="]]..urlPath..[[datatable.css" />
	]]
	cgilua.put(css)
end


-- Prints the HTML tag body including the correct style class
-- @param args String with more arguments for tag body
function printBody(args)
	args = args or ""
	cgilua.put([[<body class="yui-skin-sam" ]]..args..">")
end

--- Prints the appropriated DataTable visualization script for the settings informed
-- @param configs Accepts a lua table with these optional arguments:<pre class='example'style='padding: 0px 0px 0px 0px;' ><ul>
--		<li>paginatorID: String or Lua Table with the HTML ids for the paginator DIV container.<br>The default value is 'paginator';</li>
--		<li>paginatorPosition: String with the paginator position. Accepts 'top','bottom' and 'both'.<br>The default value is 'top';</li>
--		<li>dataSetID: String with the HTML id for the dataTable DIV container.<br>The default value is 'dataSet';</li>
--		<li>pagination: Boolean value that enables or disables the pagination.<br>The default is enabled;</li>
--		<li>serverPagination: Boolean value that enables or disables the server-side pagination.<br>The default is the client-side pagination;</li>
--		<li>serverSorting: Boolean value that enables or disables the server-side sorting.<br>The default is the client-side sortng;</li>
--		<li>resultList: String with the name of the itens list in the data source .<br>The default value is 'records';</li>
--		<li>totalRecordsField: String with the name of the total number of itens in the data source.<br>The default value is 'totalRecords';</li>
--		<li>pageLinks: Number of pagination links. The default value is 5;</li>
--		<li>rowsPerPage: Number of itens per page. The default value is 30;</li>
--		<li>defaultSorting: The name of the default field paginator.<br>The default is the first column;</li>
--		<li>rowsPerPageOptions: Lua table with the rows per page options.<br>The default values are {15,30,60};<br>
--		<li>paginatorTemplate: String with the paginator template. The default paginator format is:<br><font size=1>&lt;b&gt;{CurrentPageReport}&lt;/b&gt; {PreviousPageLink} {PageLinks} {NextPageLink} {RowsPerPageDropdown};</font><br>
--		<li>pageReportTemplate: Changes the paginator report. The default value is '{currentPage} of {totalPages}';</li>
--		<li>firstPageLinkLabel: Changes the first page link. The default value is '<< first';</li>
--		<li>lastPageLinkLabel: Changes the last page link. The default value is 'last >>';</li>
--		<li>previousPageLinkLabel: Changes the previous page link. The default value is '< prev';</li>
--		<li>nextPageLinkLabel: Changes the next page link. The default value is 'next >';</li>
--		<li>rowSelection: Boolean value that enables or disables the row selection.<br>The default value is disabled;</li>
--		<li>scrollable: Accepts a lua table in this format "{width='500px',height='300px'}" that <br> sets the width and height with scrolling;</li>
--		<li>defaultDir: String with the default sorting direction ('asc' or 'desc').<br>The default direction is ascendant;</li>
--		<li>mainClassNameCSS: String with the main CSS class name</li>
-- <ul></pre>
-- @param columns Lua table with each column and its settings. Accepts a table like this:<br>
--	<pre class='example'>{{key="id", label= "id", sortable=true},<br>{key="name", label="Full Name", sortable=true, minWidth=100, maxAutoWidth=150},<br>{key="age", label="Age", width=40}}</pre>
-- @param dataSource String with the name, path or URL for the data source;<br><br>
-- @param dataSourceType Accepts a string with the type of data source (JSARRAY, JSON, HTMLTABLE, XML and TEXT).The default value is JSON;<br><br>
-- @param insertBefore Accepts a string with javascript code that is inserted in the begining of the dataTable script;<br><br>
-- @param insertAfter Accepts a string with javascript code that is inserted in the ending of the dataTable script;<br><br>
-- @usage <pre class='example'> 
--			local dt = require("datatable.show")<br>
--			local columns = {{key="name", label= "name",sortable=true},{key="age", label="age"}}<br>
--			local configs = {rowsPerPage = 15, defaultSorting = "name", serverPagination = true}<br>
--			local datasource = "datasource.lua"<br>
--			dt.showDataTable(configs,columns,datasource)
--</pre>
-- * For more parameters and details please visit <a href='http://developer.yahoo.com/yui/datatable/' target='_blank'>http://developer.yahoo.com/yui/datatable/</a><br><br>
--- <H2>Extra properties</h2>
-- If you are using a remote data source (JSON, XML or TEXT), sometimes it is necessary to reload or filter rows from the repository and you can do it using the datatable JS method 'reload'. Just pass a string with arguments that are concatenates with the request of data source.<br>
-- See the example of the lua page below:<br> <pre class='example' style='padding:5px 5px 5px 5px'>
--			&lt;HTML&gt;&lt;BODY&gt;<BR><BR>
--			Filter:<br>		
--			&lt;a href="javascript:ref_DTsetEx.myDataTable.reload('name=A&age=30');"&gt;Names with A and Age=30&lt;/a&gt;<BR><BR>
--			<% local dt = require("datatable.show")<br>
--			local columns = {{key="name", label= "name",sortable=true},{key="age", label="age"}}<br>
--			local configs = {serverPagination = true, dataSetID = "DTsetEx",}<br>
--			local datasource = "jsonRepository.lua"<br>
--			dt.showDataTable(configs,columns,datasource) %><br><br>
--			&lt;/BODY&gt;&lt;/HTML&gt;
--</pre>  
function showDataTable(configs,columns,dataSource,dataSourceType, insertBefore,insertAfter)
	configs = configs or {}
	dataSourceType =  dataSourceType or "JSON"
	dataSourceType = string.upper(dataSourceType)
	if dataSourceType ~= "JSARRAY" then
		if(not string.find(dataSource,"?"))then
			dataSource = dataSource.."?"
		else
			dataSource = dataSource.."&"
		end
		dataSource = "'"..dataSource.."'"
	end
	insertBefore = insertBefore or ""
	insertAfter = insertAfter or ""
	local paginatorID = configs.paginatorID or {'paginator1','paginator2'}
	if type(paginatorID) == "string" then
		paginatorID = {paginatorID}
	end
	local paginatorPosition = configs.paginatorPosition or "top"
	
	local dataSetID = configs.dataSetID or "dataSet"
	local serverPagination = configs.serverPagination
	local serverSorting = configs.serverSorting
	if(serverPagination)then
		serverSorting = true
	end	
	local pagination = true
	if(configs.pagination ~= nil)then
	 	pagination = configs.pagination
	end
	if(pagination == false)then
		serverPagination = false
	end
	
	local autoResizeable = configs.autoResizeable
	if (autoResizeable ~= nil)then
		autoResizeable.minScreenWidth = autoResizeable.minScreenWidth or 0
	end 
	
	local mainClassNameCSS = configs.mainClassNameCSS or "yui-skin-sam"
	local resultList = configs.resultList or "records"
	local totalRecordsField = configs.totalRecordsField or "totalRecords"
	local pageLinks = configs.pageLinks or 5
	local rowsPerPage = configs.rowsPerPage or 30
	
	local rowsPerPageOptions = configs.rowsPerPageOptions or {15,30,60}
	local paginatorTemplate = configs.paginatorTemplate or "<b>{CurrentPageReport}</b> {PreviousPageLink} {PageLinks} {NextPageLink} {RowsPerPageDropdown}"
	
	local pageReportTemplate = configs.pageReportTemplate
	local firstPageLinkLabel = configs.firstPageLinkLabel
	local lastPageLinkLabel = configs.lastPageLinkLabel
	local previousPageLinkLabel = configs.previousPageLinkLabel
	local nextPageLinkLabel = configs.nextPageLinkLabel
	
	local rowSelection = configs.rowSelection
	local scrollable = ""
	if(type(configs.scrollable) == "table")then
		local scrollEnabled = "true"
		if configs.scrollable.maxScreenWidth ~= nil then
			scrollEnabled = "window.screen.width < 1024"
			configs.scrollable.maxScreenWidth = nil
		end
		scrollable = "scrollable:("..scrollEnabled.."),"..string.gsub(json.encode(configs.scrollable),"[{}]","")..","
	end
	local fields = {}
	for k,v in pairs(columns)do
		table.insert(fields,v.key)
	end
	local defaultSorting = configs.defaultSorting
	if(not defaultSorting)then
		defaultSorting = fields[1]
	end
	local defaultDir = configs.defaultDir or "asc"
	
	local script = [[
	<div class="]]..mainClassNameCSS..[[">
	]]
	if(paginatorPosition ~= "bottom" and pagination == true)then
		script = script..[[<div id="]]..paginatorID[1]..[["></div>]]
	end
	script = script..[[
	<div id="]]..dataSetID..[["></div>
	<script type="text/javascript">
	
	var ref_]]..dataSetID..[[;
	YAHOO.util.Event.addListener(window, "load", function() { 
	    YAHOO.example.PaginationSorting = new function() {
	]]
	script = script .. insertBefore ..[[
			ref_]]..dataSetID..[[ = this;
			filter_]]..dataSetID..[[ = "";
	        Paginator  = YAHOO.widget.Paginator;
	        DataTable  = YAHOO.widget.DataTable;
	        // Column definitions
	        this.myColumnDefs = ]].. string.gsub(json.encode(columns),"\"YAHOO.([.,:%w]+)\"","YAHOO.%1") ..[[;
	
	        // DataSource instance
	        this.myDataSource = new YAHOO.util.DataSource(]]..dataSource..[[);
	        this.myDataSource.responseType = YAHOO.util.DataSource.TYPE_]]..dataSourceType..[[;
	        this.myDataSource.responseSchema = {
	            resultsList: "]]..resultList..[[",
	            fields: ]].. json.encode(fields)..[[ ,
	            metaFields : {
	            totalRecords: ']]..totalRecordsField..[['}
	        };
			
			this.buildQueryString = function (state,dt) {
				
				var plusURL = "";
				if(filter_]]..dataSetID..[[){plusURL = '&'+filter_]]..dataSetID..[[;}
		    	sDir = (dt.get("sortedBy").dir === YAHOO.widget.DataTable.CLASS_ASC) ?  "asc" : "desc";
	
		    	var query = "startIndex=" + state.pagination.recordOffset +
		        	   "&results=" + state.pagination.rowsPerPage+"&sort="+dt.get("sortedBy").key+"&dir="+sDir+plusURL;
		       return query;
		    };
			
			this.myPaginator = new Paginator({
		        containers         : ]]..json.encode(paginatorID)..[[,
		        pageLinks          : ]]..pageLinks..[[,
		        rowsPerPage        : ]]..rowsPerPage..[[,
		        
		        rowsPerPageOptions : ]]..json.encode(rowsPerPageOptions)..[[,
		        template           : ']]..paginatorTemplate..[['
		    ]]
		     if (firstPageLinkLabel ~= nil and firstPageLinkLabel ~= '')then
	        	script = script ..[[,firstPageLinkLabel:']]..firstPageLinkLabel..[[']]	
	         end
	         if (lastPageLinkLabel ~= nil and lastPageLinkLabel ~= '')then
	        	script = script ..[[,lastPageLinkLabel:']]..lastPageLinkLabel..[[']]	
	         end
	         if (previousPageLinkLabel ~= nil and previousPageLinkLabel ~= '')then
	        	script = script ..[[,previousPageLinkLabel:']]..previousPageLinkLabel..[[']]	
	         end
	         if (nextPageLinkLabel ~= nil and nextPageLinkLabel ~= '')then
	        	script = script ..[[,nextPageLinkLabel:']]..nextPageLinkLabel..[[']]	
	         end

	        if (pageReportTemplate ~= nil and pageReportTemplate ~= '')then
	        	script = script ..[[,pageReportTemplate:']]..pageReportTemplate..[[']]	
	        end
		    script = script ..[[
		    });
			
			
	        // DataTable instance
	        this.oConfigs = {]]
	       
	        if(pagination)then
	        	if(serverPagination)then
	        		script = script .. [[	
		            initialRequest: "startIndex=0&results=]]..rowsPerPage..[[&sort=]]..defaultSorting..[[&dir=]]..defaultDir..[[", // Server parameters for initial request
			        dynamicData: true, 
			        paginationEventHandler : DataTable.handleDataSourcePagination,
			        paginator              : this.myPaginator,
			        generateRequest        : this.buildQueryString,
			    	]]
	        	else
		        	script = script .. [[	
		            initialRequest: "sort=]]..defaultSorting..[[&dir=]]..defaultDir..[[", // Server parameters for initial request
			        paginator              : this.myPaginator,
			      
			    	]]
		    	end
		    else
		    	script = script .. [[
		    	initialRequest: "sort=]]..defaultSorting..[[&dir=]]..defaultDir..[[", // Server parameters for initial request
		    	]]
	        end
	        script = script .. scrollable..[[
	        	
	            sortedBy: {key:"]]..defaultSorting..[[", dir:YAHOO.widget.DataTable.CLASS_]]..string.upper(defaultDir)..[[} // Set up initial column headers UI
	           
	        };
	        this.myDataTable = new YAHOO.widget.DataTable("]]..dataSetID..[[", this.myColumnDefs,
	                this.myDataSource, this.oConfigs);
	        this.myDataTable.handleDataReturnPayload = function(oRequest, oResponse, oPayload) {
				        oPayload.totalRecords = oResponse.meta.totalRecords;
				        return oPayload;
		        }
			]]
			
			if(serverSorting)then
			script = script .. [[
		        // Override function for custom server-side sorting
		        this.myDataTable.sortColumn = function(oColumn) {
		            // Default ascending
		            var sDir = "]]..defaultDir..[[";
		            
		            // If already sorted, sort in opposite direction
		            if(oColumn.key === this.get("sortedBy").key) {
		                sDir = (this.get("sortedBy").dir === YAHOO.widget.DataTable.CLASS_ASC) ?
		                        "desc" : "asc";
		            }
		
		            // Pass in sort values to server request
		            this.plusURL = "";
					if(filter_]]..dataSetID..[[){this.plusURL = '&'+filter_]]..dataSetID..[[;}
		            
		            ]]
		            if(serverPagination)then
		            	script = script .. [[var newRequest = "sort=" + oColumn.key + "&dir=" + sDir + "&results="+this.get("paginator").getRowsPerPage()+"&startIndex=0"+this.plusURL;]]
		            else
		            	script = script .. [[var newRequest = "sort=" + oColumn.key + "&dir=" + sDir+this.plusURL;]]
		            end
		            script = script ..[[
		           // Define the new state
		                this.newState = {
		                    startIndex: 0,
		                    sorting: { // Sort values
		                        key: oColumn.key,
		                        dir: (sDir === "desc") ? YAHOO.widget.DataTable.CLASS_DESC : YAHOO.widget.DataTable.CLASS_ASC
		                    }
		             ]]
		             if(pagination)then
		             script = script ..[[
		                    ,
		                    pagination : { // Pagination values
		                        recordOffset: 0, // Default to first page when sorting
		                        rowsPerPage: this.get("paginator").getRowsPerPage()
		                    }
		              ]]
		              end
		              script = script ..[[
		                };
		            // Create callback for data request
		            var oCallback = {
		                success: this.onDataReturnInitializeTable,
		                failure: this.onDataReturnInitializeTable,
		                scope: this,
		                argument: this.newState
		            }
		            
		            // Send the request
		           
		            this.getDataSource().sendRequest(newRequest, oCallback);
		            
		        };
		    ]]
		  	end
			if(rowSelection)then
				script = script .. [[
				// Subscribe to events for row selection
		        this.myDataTable.subscribe("rowMouseoverEvent", this.myDataTable.onEventHighlightRow);
		        this.myDataTable.subscribe("rowMouseoutEvent", this.myDataTable.onEventUnhighlightRow);
		        this.myDataTable.subscribe("rowClickEvent", this.myDataTable.onEventSelectRow);
		
		        // Programmatically select the first row
		        this.myDataTable.selectRow(this.myDataTable.getTrEl(0));
		        // Programmatically bring focus to the instance so arrow selection works immediately
		        this.myDataTable.focus();
			]]
			end
			script = script .. [[  
			this.myDataTable.reload = function(addURL,funcAfterLoad,interval)
			{ 
				 
				 filter_]]..dataSetID..[[ = addURL;
				 var sDir = "]]..defaultDir..[[";
		            
		            // If already sorted, sort in opposite direction
		            
		
		            // Pass in sort values to server request
		           // Define the new state
		           ]]
		            if(serverPagination)then
		            	script = script .. [[var newRequest = "sort=" + "]]..defaultSorting..[[" + "&dir=" + sDir + "&results=]]..rowsPerPage..[[&startIndex=0&"+addURL;]]
		          	else
						script = script .. [[var newRequest = "sort=" + "]]..defaultSorting..[[" + "&dir=" + sDir+"&"+addURL;]]								          	
		          	end
		          	script = script ..[[
		                var newState = {
		                    startIndex: 0,
		                    sorting: { // Sort values
		                        key: ']]..defaultSorting..[[',
		                        dir: (sDir === "desc") ? YAHOO.widget.DataTable.CLASS_DESC : YAHOO.widget.DataTable.CLASS_ASC
		                    }
		                  ]]  
	                  if(pagination)then
	             		script = script ..[[
		                    ,
		                    pagination : { // Pagination values
		                        recordOffset: 0, // Default to first page when sorting
		                        rowsPerPage: this.get("paginator").getRowsPerPage()
		                    }
		                    ]]
	                  end
	                  script = script ..[[
		              };
		            // Create callback for data request
		            alferCallBack = function(obj,funcAfterLoad,interval)
		            {  	if(!interval)
		            		interval = 0;
		            	if(funcAfterLoad)
		            		window.setInterval(funcAfterLoad,interval);
		            	return obj.onDataReturnInitializeTable;
		            }
		            
		            var oCallback = {
		                success: alferCallBack(this,funcAfterLoad,interval),
		                failure: alferCallBack(this,funcAfterLoad,interval),
		                scope: this,
		                argument: newState
		            }
		             
		            // Send the request
		           
		           this.getDataSource().sendRequest(newRequest, oCallback);
					 
			}      
         	]]
         	
         	if(autoResizeable ~= nil)then
         	script = script ..[[
	         	function resizeDTColumns(obj,adjust)
	         	{
	 					if(window.screen.width >= ]]..autoResizeable.minScreenWidth..[[)
	 					{
		 					var total_width = 0;
		 					if(!adjust)
		 						adjust = 0;
							 for(i=0;i<obj.myColumnDefs.length;i++)
							 {	if(obj.myColumnDefs[i]['key'] != ']]..autoResizeable.columnKey..[[')
							 		total_width += obj.myDataTable.getColumn(obj.myColumnDefs[i]['key']).width;
							 }
		 								
		 						obj.myDataTable.setColumnWidth(obj.myDataTable.getColumn(']]..autoResizeable.columnKey..[['),document.body.clientWidth-total_width + adjust);
		 				}
					}
					var widthAdjust = ]]..autoResizeable.widthAdjust..[[;
					
					window.onresize = function(){resizeDTColumns(ref_]]..dataSetID..[[,widthAdjust)};
					
					resizeDTColumns(this,widthAdjust-20);
					

         		]]
         	end
         	script = script ..insertAfter.. [[ 
			    };}); 
			
			</script>
		]]
		if(paginatorID[2] ~=nil and (paginatorPosition == "bottom" or paginatorPosition == "both") and pagination == true) then
			script = script..[[<div id="]]..paginatorID[2]..[["></div>]]
		elseif(paginatorID[1] ~=nil and paginatorPosition == "bottom" and pagination == true)then
			script = script..[[<div id="]]..paginatorID[1]..[["></div>]]
		end
		script = script..[[</div>]]
	cgilua.put(script)
end
