<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>

<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>
<!--<script>
function limpaBuild(element)
{
	radios = document.getElementsByName(element);
	for(i=0; i< radios.length; i++)
	{
		if (radios[i].checked ==true)
			radios[i].checked = false;
		
	}
}
</script>-->
<% if flash.get("validationMessagesBuild") ~= nil then %>
<br>
	<%= flash.get("validationMessagesBuild")%>
<% end %>

<div id="box_title"><%= locale_index.builds_title%></div>

<div id="create_page_build">
	<%= f.form({action = makeURL({control='builder',act='files'}), onsubmit="$('send').disabled=true;Element.show('generating')"}) %>
		<%= f.hidden_field({name='id', value=id}) %>
		<%= f.hidden_field({name='created_at', value=build.created_at}) %>
		<br>
		<div>
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_index.labels.title_build %></div>
				</div>
				<div class="build_components"><%= f.text_field({class="field name_field", name='title', value=build.title})%></div>
			</div>
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_components.target_title %></div>
				</div>
				<div class="build_components"><%= f.select({name='target',class="select_field",prompt = locale_components.target_prompt},BuildModel.TARGETS, build.configs.target) %></div>
			</div>
			
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_components.toolchain_title %></div>
				</div>
				<div class="build_components"><%=f.select({name="toolchain", class="select_field"},BuildModel.TOOLCHAINS, build.configs.toolchain)%></div>
			</div>
						
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_components.component_title %></div>
				</div>
				<div class="build_components">
					<table> 
						<thead>
							<tr> 
								<th>Include</th> 
								<th>Components</th> 
							</tr> 
						</thead>
						<tbody> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_xmodem'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_xmodem}) %>
								</td> 
								<td><%= locale_components.labels.build_xmodem %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_shell'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_shell}) %>
								</td> 
								<td><%= locale_components.labels.build_shell %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_romfs'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_romfs}) %>
								</td> 
								<td><%= locale_components.labels.build_romfs %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_term'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.build_term}) %>
								</td> 
								<td><%= locale_components.labels.build_term %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_uip'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_uip}) %>
								</td> 
								<td><%= locale_components.labels.build_uip %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_dhcpc'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dhcpc}) %>
								</td> 
								<td><%= locale_components.labels.build_dhcpc %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_dns'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dns}) %>
								</td> 
								<td><%= locale_components.labels.build_dns %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_con_generic'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_generic}) %>
								</td> 
								<td><%= locale_components.labels.build_con_generic %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_con_tcp'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_tcp}) %>
								</td> 
								<td><%= locale_components.labels.build_con_tcp %>	</td> 
							</tr> 
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_adc'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_adc}) %>
								</td> 
								<td><%= locale_components.labels.build_adc %>	</td> 
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%=locale_index.files_romfs_title%></div>
				</div>
				<div class="build_components">
					<div>
						<%
							local columns_files = { 
													{key="id", label = locale_index.label_select, width=40, formatter="myActions", className="columnCenter"},
													
													{key="filename", label= locale_index.labels.filename,  sortable=true,width=360},
													{key="file_type", label= locale_index.labels.file_type, sortable=true, width=123},
													{key="created_at", label=locale_index.labels.created_at, sortable=true, width=150},
							}
							
							--{key="id", label = locale_index.label_autorun, width=100, formatter="autorun", className="columnCenter"},
							
							extraFormatters = [[
			                                
			                                //--- COLUMN FORMATTERS
			                                this.actions = function(elLiner, oRecord, oColumn, oData) {
			                                    elLiner.innerHTML = "<input type='checkbox' name='file_id' value='"+oData['id']+"' "+ (oData['checked'] == true?'checked':'') +" border='0' style='margin-bottom:5px;'/> ";
			                                };
			                                YAHOO.widget.DataTable.Formatter.myActions = this.actions;  
											
											/*
											this.autorun = function(elLiner, oRecord, oColumn, oData) {
			                                    elLiner.innerHTML = "<input type='radio' name='autorun_file_id' value='"+oData['id']+" /> ";
			                                };
			                                YAHOO.widget.DataTable.Formatter.autorun = this.autorun;    */                                                     
			                ]]
							
							local configs_files = {
													dataSetID = "dataSetFiles",
													serverPagination = false,
													defaultSorting = 'filename',
													paginatorPosition = "bottom",
													rowsPerPage = 15,
													rowsPerPageOptions = {15,20,40,60},
			
							}
							local datasource_files = makeURL({control='files',act='repository',build_id = id })
							dt.showDataTable(configs_files, columns_files, datasource_files, nil, extraFormatters)	
						%>
					</div>
				</div>
			</div>	
			<!--<input type="button" name="bt1" value="Limpar builds" onclick="limpaBuild('autorun_file_id')">-->
			<div class="build_button">
				<%= f.submit({id='send',class="button_submit",value = locale_components.label_build}) %>
			</div>
		</div>
	<%= f.form_close() %>
	<div id="bottom_text" class="links">
		<a href="<%= makeURL({control= "builder", act="index"})%>">&raquo;&nbsp;<%=locale_index.label_back%></a>
	</div>
</div>

<div class="generate" style="display:none;" id='generating' >
	<h2>Please wait.</h2><br/> 
	<img src="images/ajax-loader.gif"><br/><br/>
	<h2>Build is being generated.</h2>
</div>
<% render("footer.lp","_shared") %>