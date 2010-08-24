<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>

<% jquery = true %>
<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>


<br /><br />
<script type="text/javascript">
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

function msg_build_generated(){
	$('#msg_build_generated').hide();
}

</script>

<% if (flash.get("copyFileMessages") ~= nil or flash.get("copyErrorsMessages") ~= nil) then %>
	<div class="msg_build_generated" id="msg_build_generated">
		<div class="close_button">
			<a href="#"><img src="images/buttons/logout.png" border='0', onclick="msg_build_generated();"></a>
		</div>
		<div class="close_msg_build_generated">
			<%= flash.get("copyFileMessages")%>
			<%= flash.get("copyErrorsMessages")%>
		</div>
		<div class="button_download">
			<a href="<%= makeURL({control= "builder", act="download_binary_log"})%>">
				<img name='download' src="images/buttons/download_binary_log.png" border='0' label='<%=locale_index.label_download%>'><br>
				<b><%=locale_index.download_binary_log%></b>
			</a>
		</div>
	</div>
<% end %>

<div id="box_title">
	<div style="float:left;"><%=locale_index.builds_title%> </div>&nbsp;
	<div class="help"><a id="help_builds_title" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
</div>
<br>
<div>
	<a href="<%= makeURL({control= "builder", act="files"})%>"> 
		<img src="images/buttons/button.png"  alt="<%=locale_index.labels.newbuild%>" title="<%=locale_index.labels.newbuild%>" border='0'> 
		<div class="button_newbuild">
			<%=locale_index.labels.newbuild%>
		</div>
	</a>
</div><br>
<div >
	<%
		local columns_builds = {
							{key="id", label = locale_index.label_actions, width=100, formatter="actions", className="columnCenter"},
							{key="title", label= locale_index.labels.title ,  sortable=true,width=200},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, Width=60},
							{key="configs", label=locale_index.labels.configs, sortable=true, width=333},
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
						rowsPerPageOptions = {5,10,15,20,25},

		}
		local datasource_builds = makeURL({control='builder',act='repository'})
		dt.showDataTable(configs_builds, columns_builds, datasource_builds,nil,extraFormatters)
	%>
</div><br><br />

<div id="box_title">
	<%=locale_index.files_title%>&nbsp;
	<div class="help"><a id="help_stored_files" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
</div><br />
	
	<%= render("upload.lp")%>
<div>
	<br>
	<!--<select name="filter" id="filter" onchange="ref_dataSetFiles.myDataTable.reload('filter='+this.value);">
		<option value="none" selected><%=locale_index.labels.default%></option>
		<option value="only_user_files"><%=locale_index.labels.user_files%></option>
		<option value="only_V07_files"><%=locale_index.labels.v07_files%></option>
	</select> -->
	<div id="notice">
		<%= flash.get("removeSucessMessages")%>
		<% if flash.get("removefailureMessages") ~= nil then %>
			<div id="errorExplanation"><%= flash.get("removefailureMessages")%> </div>
		<% end %>
	</div>	
</div>

	<%
		local columns_files = { 
							{key="id", label = locale_index.label_actions, width=100, formatter="action", className="columnCenter"},
							{key="filename", label= locale_index.labels.filename,  sortable=true,width=370},
							{key="category", label= locale_index.labels.file_type, sortable=true, width=123},
							{key="created_at", label=locale_index.labels.created_at, sortable=true, width=140},
		}
  
		local extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.action = function(elLiner, oRecord, oColumn, oData) {
									elLiner.innerHTML += " <a href=']]..makeURL({control= "files", act="download"})..[[&id="+oRecord.getData('id')+"'><img src=images/buttons/download.png border=0 title=]]..locale_index.label_download..[[></a>";
									if (oRecord.getData('category') == 'User file')
									{
                                    	elLiner.innerHTML += "<a href='#' onClick='confirmDeleteFile(\""+oRecord.getData('id')+"\")'><img src=images/buttons/delete.png border=0 title=]]..locale_index.label_remove..[[></a>";
									}
									
									
                                };
                                YAHOO.widget.DataTable.Formatter.action = this.action
								
        ]]
		local configs_files = {
						dataSetID = "dataSetFiles",
						serverPagination = false,
						defaultSorting = 'created_at',
						paginatorID = "paginatorFiles",
						paginatorPosition = "bottom",
						rowsPerPage = 10,
						rowsPerPageOptions = {5,10,15,20,25},

		}
		local datasource_files = makeURL({control='files',act='repository'})
		dt.showDataTable(configs_files, columns_files, datasource_files,nil,extraFormatters)
	%>
	<br>
	<!--<h2><%= locale_index.upload_title %> </h2><br>-->
	
<% render("help/index.lp") %>
	
<% render("footer.lp","_shared") %>