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
<div class="link"><a href="<%= makeURL({control= "builder", act="index"})%>"> <big><%=locale_index.label_back%></big> </a></div>
<div>
	<%= f.form({action = makeURL({control='builder',act='files'}), onsubmit="$('send').disabled=true;Element.show('generating')"}) %>
		<%= f.hidden_field({name='id', value=id}) %>
		<%= f.hidden_field({name='created_at', value=build.created_at}) %>
		<h2> <%= locale_index.labels.title_build %></h2>
		<%= f.text_field({class="field2", name='title',size=10, value=build.title}) %> <br><br>
		
		<h2><%= locale_components.target_title %> </h2>
		<label for="target"></label>
		<div> <%= f.select({name='target',prompt = locale_components.target_prompt},BuildModel.TARGETS, build.configs.target) %></div><br>
		
		<h2><%= locale_components.component_title %> </h2>	
		<table class="table_center"> 
			<tbody> 
				<tr> 
					<th style="text-align: left;">Include</th> 
					<th style="text-align: center;">Components</th> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_xmodem'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_xmodem}) %>
					</td> 
					<td><%= locale_components.labels.build_xmodem %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_shell'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_shell}) %>
					</td> 
					<td><%= locale_components.labels.build_shell %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_romfs'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_romfs}) %>
					</td> 
					<td><%= locale_components.labels.build_romfs %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_term'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.build_term}) %>
					</td> 
					<td><%= locale_components.labels.build_term %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_uip'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_uip}) %>
					</td> 
					<td><%= locale_components.labels.build_uip %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_dhcpc'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dhcpc}) %>
					</td> 
					<td><%= locale_components.labels.build_dhcpc %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_dns'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dns}) %>
					</td> 
					<td><%= locale_components.labels.build_dns %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_con_generic'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_generic}) %>
					</td> 
					<td><%= locale_components.labels.build_con_generic %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_con_tcp'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_tcp}) %>
					</td> 
					<td><%= locale_components.labels.build_con_tcp %>	</td> 
				</tr> 
				<tr> 
					<td class="espaco">
						<%= f.check_box({name='build_adc'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_adc}) %>
					</td> 
					<td><%= locale_components.labels.build_adc %>	</td> 
				</tr>
			</tbody>
		</table><br>
		
		<h2><%=locale_index.files_romfs_title%></h2><br>
		<div>
			<%
				local columns_files = { 
										{key="id", label = locale_index.label_select, width=40, formatter="myActions", className="columnCenter"},
										{key="id", label = locale_index.label_autorun, width=100, formatter="autorun", className="columnCenter"},
										{key="filename", label= locale_index.labels.filename,  sortable=true,minWidth=1024, maxAutoWidth=150},
										{key="created_at", label=locale_index.labels.created_at, sortable=true, minWidth=1024, maxAutoWidth=150},
				}
				
				extraFormatters = [[
                                
                                //--- COLUMN FORMATTERS
                                this.actions = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<input type='checkbox' name='file_id' value='"+oData['id']+"' "+ (oData['checked'] == true?'checked':'') +" border='0' style='margin-bottom:5px;'/> ";
                                };
                                YAHOO.widget.DataTable.Formatter.myActions = this.actions;  
								
								this.autorun = function(elLiner, oRecord, oColumn, oData) {
                                    elLiner.innerHTML = "<input type='radio' name='autorun_file_id' value='"+oData['id']+" /> ";
                                };
                                YAHOO.widget.DataTable.Formatter.autorun = this.autorun;                                                         
                ]]
				
				local configs_files = {
										dataSetID = "dataSetFiles",
										serverPagination = false,
										defaultSorting = 'filename',
										rowsPerPage = 15,
										rowsPerPageOptions = {15,20,40,60},

				}
				local datasource_files = makeURL({control='files',act='repository',build_id = id })
				dt.showDataTable(configs_files, columns_files, datasource_files, nil, extraFormatters)	
			%>
		</div><br>
		
		
		<%= f.submit({id='send',value = locale_components.label_build}) %>
	<%= f.form_close() %>
</div>
<div class="link"><a href="<%= makeURL({control= "builder", act="index"})%>"> <big><%=locale_index.label_back%></big> </a></div>

<div class="generate" style="display:none;" id='generating' >
	<h2>Please wait.</h2><br/> 
	<img src="images/ajax-loader.gif"><br/><br/>
	<h2>Build is being generated.</h2>
</div>
<% render("footer.lp","_shared") %>