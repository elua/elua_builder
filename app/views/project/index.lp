<% f = require "luawebforms" %>
<% dt = require "dataTable.show" %>

<% render("header.lp","_shared") %>
<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>
<% local is_administrator = tonumber(USER_AUTH.administrator) == 1 %>

<% if is_administrator then %> 
	<div class="bar_top">
		+ <a href="<%= makeURL({control='project',act='edit'})%>"><%= locale_index.new_project_label %></a>
	</div>
<% end %>
<h2><%= locale_index.page_sub_title %></h2>

<br/>
<% if flash.get("notice") then %> 
	<span class="notice" id="notice"><%= flash.get("notice") %></span>
	<script> $('notice').fade({duration:4.0}); </script>
<% end %>
<div id="list">
	<% 
		local extraFormatters = ""
		if is_administrator then
			extraFormatters = [[
				
				this.actions = function(elLiner, oRecord, oColumn, oData) {
					
					elLiner.innerHTML = "<a class='edit_button' title=']]..locale_index.edit_label_link..[[' href=']]..makeURL({control='project',act='edit'})..[[&id="+oData+"' >]]..locale_index.edit_label_link..[[</a>";
					elLiner.innerHTML += "<a class='remove_button' title=']]..locale_index.remove_label_title..[[' href='#' onclick='if(confirm(\"]]..locale_index.remove_label_link..[[\")){window.location.href=\"]]..makeURL({control='project',act='remove'})..[[&id="+oData+"\"}' >]]..locale_index.remove_label_title..[[</a>";
			    };					        
		        YAHOO.widget.DataTable.Formatter.actions = this.actions;
			]]
		else
			extraFormatters = [[
				this.actions = function(elLiner, oRecord, oColumn, oData) {
						elLiner.innerHTML = "<a title=']]..locale_index.view_title_link..[[' href=']]..makeURL({control='project',act='view'})..[[&id="+oRecord.getData("id")+"' >]]..locale_index.show_label_link..[[</a>";
					
			    };					        
		        YAHOO.widget.DataTable.Formatter.actions = this.actions;
			]]
		end
		
		local insertBefore = extraFormatters..[[
				YAHOO.widget.DataTable.Formatter.none = function(){return};
				this.projectView = function(elLiner, oRecord, oColumn, oData) {
					
					elLiner.innerHTML = "<a title=']]..locale_index.view_title_link..[[' href=']]..makeURL({control='project',act='view'})..[[&id="+oRecord.getData("id")+"' >"+
					oData + "</a>";
			    };					        
		        YAHOO.widget.DataTable.Formatter.projectView = this.projectView;
		]]
		
		local columns = {
				{key="name", label= locale_index.columns.name,  sortable=true,minWidth=1024, maxAutoWidth=150, formatter="projectView"},
		        {key="symbol", label= locale_index.columns.symbol,width=150},
				{key="situation", label= locale_index.columns.situation, width=70},
		        {key="location", label= locale_index.columns.location, width=100},
				{key="actual_start_dt", label= locale_index.columns.actual_start_dt, width=70},
				{key="actual_end_dt", label= locale_index.columns.actual_end_dt, width=70},
				{key="scheduled_start_dt", label= locale_index.columns.scheduled_start_dt, width=70},
				{key="scheduled_end_dt", label= locale_index.columns.scheduled_end_dt, width=70},
				{key="id", label = locale_index.columns.actions, width=100, formatter = "actions"},
			}
		
		local configs = {
				dataSetID = "dataSet",
				firstPageLinkLabel = general_paginator.firstPageLinkLabel,
				lastPageLinkLabel = general_paginator.lastPageLinkLabel,
				previousPageLinkLabel = general_paginator.previousPageLinkLabel,
				nextPageLinkLabel = general_paginator.nextPageLinkLabel,
				
				paginatorTemplate = general_paginator.paginatorTemplate,
				pageReportTemplate = general_paginator.pageReportTemplate,
				paginatorPosition = general_paginator.paginatorPosition,
		
				serverPagination = true,
				defaultSorting = 'name',
				rowsPerPage = 20,
				rowsPerPageOptions = {15,20,40,60},

				}
		local datasource = makeURL({control='project',act='repository'})
		
		dt.showDataTable(configs,columns, datasource,nil,insertBefore)
	
	%>
</div>

<% render("footer.lp","_shared") %>