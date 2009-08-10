<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>
<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>

<script>
function confirmDeleteFile(id)
{
	if(confirm("<%=locale_index.labels.confirmDeleteFile%>"))
	{
		window.location.href="<%=makeURL({control= "files", act="delete"})%>&id="+id;
	}
}

function confirmDeleteBuild(id)
{
	if(confirm("<%=locale_index.labels.confirmDeleteBuild%>"))
	{
		window.location.href="<%=makeURL({control= "builder", act="delete"})%>&id="+id;
	}
}
</script>

<h4><%=locale_index.labels.greeting%>, <%= current_user.name %> </h4>

<h2><%=locale_index.builds_title%> </h2>

<div class="link" <a href="<%= makeURL({control= "builder", act="files"})%>"> <%=locale_index.labels.newbuild%> </a> </div>

<div>
	<%
		local columns_builds = {
							{key="id", label = locale_index.label_remove, width=40, formatter="myActionsRemove"},
							{key="title", label= locale_index.labels.title ,  sortable=true,minWidth=1024, maxAutoWidth=150},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=150},
							{key="configs", label=locale_index.labels.configs, sortable=true, minWidth=1024, maxAutoWidth=150},
		}
		extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<a href='javascript:void(0)' onClick='confirmDeleteBuild("+oData+")'>]]..locale_index.label_remove..[[</a> "
                                };
                                YAHOO.widget.DataTable.Formatter.myActionsRemove = this.actions;                       
        ]]
		local configs_builds = {
						dataSetID = "dataSet",
						serverPagination = false,
						defaultSorting = 'title',
						rowsPerPage = 15,
						rowsPerPageOptions = {15,20,40,60},

		}
		local datasource_builds = makeURL({control='builder',act='repository'})
		dt.showDataTable(configs_builds, columns_builds, datasource_builds,nil,extraFormatters)
	%>
</div><br>

<h2><%= locale_index.upload_title %> </h2><br>
<div>
	<form method="POST" enctype="multipart/form-data" action="start.lua?control=files&act=upload"> 
		<input type="file" name="file"> 
		<input type="submit" value="Upload"> 
	</form> 
</div><br>

<h2><%=locale_index.files_title%></h2><br>
<div>
	<%
		local columns_files = { 
							{key="id", label = locale_index.label_remove, width=40, formatter="myActions"},
							{key="filename", label= locale_index.labels.filename,  sortable=true,minWidth=1024, maxAutoWidth=150},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=150},
		}
  
		extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<a href='javascript:void(0)' onClick='confirmDeleteFile("+oData+")'>]]..locale_index.label_remove..[[</a> "
                                };
                                YAHOO.widget.DataTable.Formatter.myActions = this.actions                              
        ]]
		local configs_files = {
						dataSetID = "dataSetFiles",
						serverPagination = false,
						defaultSorting = 'filename',
						rowsPerPage = 15,
						rowsPerPageOptions = {15,20,40,60},

		}
		local datasource_files = makeURL({control='files',act='repository'})
		dt.showDataTable(configs_files, columns_files, datasource_files,nil,extraFormatters)
	%>
</div><br>

<% render("footer.lp","_shared") %>