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
<div class="link">
	<a href="<%= makeURL({control="user", act="edit"})%>"><img src="images/buttons/edit_user.gif" title="<%=locale_index.labels.edit_account%>"></a>
	<a href="<%= makeURL({control="user", act="logout"})%>"><img src="images/buttons/exit.png" title="<%=locale_index.labels.logout%>"></a>
</div>
<h2><%=locale_index.builds_title%> </h2>


<h4>
	<%=locale_index.labels.greeting%>, <%= current_user.name %> 
</h4>

<div class="link" <a href="<%= makeURL({control= "builder", act="files"})%>"> <%=locale_index.labels.newbuild%> </a> </div>

<div>
	<%
		local columns_builds = {
							{key="id", label = locale_index.label_remove_edit, width=60, formatter="actions", className="columnCenter"},
							{key="title", label= locale_index.labels.title ,  sortable=true,minWidth=1024, maxAutoWidth=80, formatter="myActionsSelect"},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=80},
							{key="configs", label=locale_index.labels.configs, sortable=true, minWidth=1024, maxAutoWidth=650},
		}
		extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<a href='javascript:void(0)' onClick='confirmDeleteBuild("+oData+")'><img src=images/buttons/cancel.png title=]]..locale_index.label_remove..[[></a> ";
									elLiner.innerHTML += " <a href=']]..makeURL({control= "builder", act="files"})..[[&id="+oData+"'><img src=images/buttons/kedit.png title=]]..locale_index.label_edit..[[></a>";
                                };
                                YAHOO.widget.DataTable.Formatter.actions = this.actions;    
		
								this.view = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<a href=']]..makeURL({control="builder", act="download"})..[[&id="+oRecord.getData("id")+"' >"+oData+"</a>";
                                };
                                YAHOO.widget.DataTable.Formatter.myActionsSelect = this.view;                   
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
	<form method="POST" enctype="multipart/form-data" action="start.lua?control=files&act=upload" onsubmit="return( $('filename').value != '');"> 
		<input type="file" name="file" id="filename"> 
		<input type="submit" value="Upload"> 
	</form> 
</div><br>

<h2><%=locale_index.files_title%></h2><br>
<div>
	<%
		local columns_files = { 
							{key="id", label = locale_index.label_remove_download, width=90, formatter="action", className="columnCenter"},
							{key="filename", label= locale_index.labels.filename,  sortable=true,minWidth=1024, maxAutoWidth=150},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=150},
		}
  
		extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.action = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<a href='javascript:void(0)' onClick='confirmDeleteFile("+oData['id']+")'><img src=images/buttons/cancel.png title=]]..locale_index.label_remove..[[></a>";
									elLiner.innerHTML += " <a href=']]..makeURL({control= "files", act="download"})..[[&id="+oData['id']+"'><img src=images/buttons/agt_add-to-desktop.png title=]]..locale_index.label_download..[[></a>";
                                };
                                YAHOO.widget.DataTable.Formatter.action = this.action
								
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