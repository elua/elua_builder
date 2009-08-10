<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>

<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>

<% if flash.get("validationMessagesBuild") ~= nil then %>
<br>
	<%= flash.get("validationMessagesBuild")%>
<% end %>
<div>
	<%= f.form({action=makeURL({control='builder',act='files'})}) %>
		<h2> <%= locale_index.labels.title_build %></h2><%= f.text_field({class="field2", name='title',size=10}) %> <br><br>
		<h2><%=locale_index.files_title%></h2><br>
		<div>
			<%
				local columns_files = { 
										{key="id", label = locale_index.label_select, width=40, formatter="myActions"},
										{key="filename", label= locale_index.labels.filename,  sortable=true,minWidth=1024, maxAutoWidth=150},
										{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=150},
				}
				
				extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<input type='checkbox' name='file_id' value="+oData+" border='0' style='margin-bottom:5px;'/> "
                                };
                                YAHOO.widget.DataTable.Formatter.myActions = this.actions;                                                        
                ]]
				
				local configs_files = {
										dataSetID = "dataSetFiles",
										serverPagination = false,
										defaultSorting = 'filename',
										rowsPerPage = 15,
										rowsPerPageOptions = {15,20,40,60},

				}
				local datasource_files = makeURL({control='files',act='repository'})
				dt.showDataTable(configs_files, columns_files, datasource_files, nil, extraFormatters)	
			%>
		</div><br>
		<a href="<%= makeURL({control= "builder", act="index"})%>"> <%=locale_index.label_back%> </a>
		<%= f.submit({value=locale_index.label_progress})%>
	<%= f.form_close() %>
</div>
<% render("footer.lp","_shared") %>