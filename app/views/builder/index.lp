<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>

<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>

<div class="hello"><%=locale_index.labels.greeting%>, <%= current_user.name %></div>
<br /><br />
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



<div id="box_title">
	<%=locale_index.builds_title%> 
	<div class="links_right">
		<!--<div style="float:right; font-size:12px; margin:-20px 15px 10px 0px;"></div>-->
			<img src="images/buttons/account.png">&nbsp; <a href="<%= makeURL({control="user", act="edit"})%>"><%=locale_index.labels.edit_account%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
			<img src="images/buttons/logout.png">&nbsp; <a href="<%= makeURL({control="user", act="logout"})%>"><%=locale_index.labels.logout%></a>				
	</div>
</div>
<br />
<div><a href="<%= makeURL({control= "builder", act="files"})%>"> <input type="button" value="<%=locale_index.labels.newbuild%>" class="button_submit"> </a> </div><br>
<div >
	<%
		local columns_builds = {
							{key="id", label = locale_index.label_actions, width=80, formatter="actions", className="columnCenter"},
							{key="title", label= locale_index.labels.title ,  sortable=true,width=200},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, Width=60},
							{key="configs", label=locale_index.labels.configs, sortable=true, width=353},
		}
		local extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = " <a href=']]..makeURL({control= "builder", act="download"})..[[&id="+oData+"'><img src=images/buttons/download.png border=0 title=']]..locale_index.label_download..[['></a>";
									elLiner.innerHTML += " <a href=']]..makeURL({control= "builder", act="files"})..[[&id="+oData+"'><img src=images/buttons/edit.png border=0 title=']]..locale_index.label_edit..[['></a>";
									elLiner.innerHTML += "<a href='javascript:void(0)' onClick='confirmDeleteBuild("+oData+")'><img src=images/buttons/delete.png border=0 title=']]..locale_index.label_remove..[['></a> ";
                                };
                                YAHOO.widget.DataTable.Formatter.actions = this.actions;    
		
								                 
        ]]
		local configs_builds = {
						dataSetID = "dataSetBuilds",
						serverPagination = false,
						defaultSorting = 'title',
						paginatorID = "paginatorBuilds",
						paginatorPosition = "bottom",
						rowsPerPage = 10,
						rowsPerPageOptions = {5,10,15,20},

		}
		local datasource_builds = makeURL({control='builder',act='repository'})
		dt.showDataTable(configs_builds, columns_builds, datasource_builds,nil,extraFormatters)
	%>
</div><br><br />

<div id="box_title"><%=locale_index.files_title%></div><br />
<div class="upload">
		<form method="POST" enctype="multipart/form-data" action="start.lua?control=files&act=upload" onsubmit="return( $('filename').value != '');"> 
			<input type="file" name="file" id="filename"> 
			<input type="submit" value="Upload"> 
		</form> 
	</div><br><br>
<div>
	<%
		local columns_files = { 
							{key="id", label = locale_index.label_actions, width=80, formatter="action", className="columnCenter"},
							{key="filename", label= locale_index.labels.filename,  sortable=true,width=400},
							{key="category", label= locale_index.labels.file_type, sortable=true, width=123},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, width=130},
		}
  
		local extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.action = function(elLiner, oRecord, oColumn, oData) {
									elLiner.innerHTML += " <a href=']]..makeURL({control= "files", act="download"})..[[&id="+oRecord.getData('id')['id']+"'><img src=images/buttons/download.png border=0 title=]]..locale_index.label_download..[[></a>";
									if (oRecord.getData('category') != 'V0.6 File')
									{
                                    	elLiner.innerHTML += "<a href='javascript:void(0)' onClick='confirmDeleteFile("+oRecord.getData('id')['id']+")'><img src=images/buttons/delete.png border=0 title=]]..locale_index.label_remove..[[></a>";
									}
									
									
                                };
                                YAHOO.widget.DataTable.Formatter.action = this.action
								
        ]]
		local configs_files = {
						dataSetID = "dataSetFiles",
						serverPagination = false,
						defaultSorting = 'filename',
						paginatorID = "paginatorFiles",
						paginatorPosition = "bottom",
						rowsPerPage = 15,
						rowsPerPageOptions = {10,15,20,30,40},

		}
		local datasource_files = makeURL({control='files',act='repository'})
		dt.showDataTable(configs_files, columns_files, datasource_files,nil,extraFormatters)
	%>
	<br>
	<!--<h2><%= locale_index.upload_title %> </h2><br>-->
	
</div><br>

<% render("footer.lp","_shared") %>