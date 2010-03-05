<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>
<% jquery = true %>
<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>
<script>

function checked_con_generic()
{
	if ($('#build_con_generic').is(':checked')) {
		$('#build_con_tcp').attr('checked',false);
		$('#build_term').attr('disabled',false);
		if($('#build_term').is(':checked')){
			$('#build_shell').attr('disabled',false);		
			if($('#build_shell').is(':checked')){
				$('#build_xmodem').attr('disabled',false);
			}
		}
	}
	else if(!$('#build_con_tcp').is(':checked')){
		$('#build_term').attr('disabled',true);
		$('#build_shell').attr('disabled',true);
		$('#build_xmodem').attr('disabled',true);
	}
}

function checked_con_tcp()
{
	if ($('#build_con_tcp').is(':checked')) {
		$('#build_con_generic').attr('checked',false);
		$('#build_term').attr('disabled',false);
		if($('#build_term').is(':checked')){
			$('#build_shell').attr('disabled',false);		
			if($('#build_shell').is(':checked')){
				$('#build_xmodem').attr('disabled',false);
			}
		}	
	}	
	else if (!$('#build_con_generic').is(':checked')){
		$('#build_term').attr('disabled',true);
		$('#build_shell').attr('disabled',true);
		$('#build_xmodem').attr('disabled',true);
	}	
}

function checked_term()
{
	if($('#build_term').is(':checked')){
		$('#build_shell').attr('disabled',false);
	}
	else{
		$('#build_shell').attr('disabled',true);
	}
}

function checked_shell()
{
	if ($('#build_shell').is(':checked')) {
		$('#build_xmodem').attr('disabled',false);
	}
	else{
		$('#build_xmodem').attr('disabled',true);
	}
}

function checked_ip()
{
	if ($('#build_uip').is(':checked')) {
		$('#ip_box').show();
		$('#build_dhcpc').attr('disabled',false);
		$('#build_dns').attr('disabled',false);
		if ($('#build_dns').is(':checked')) 
			$('#dns_box').show();
		else 
			$('#dns_box').hide();
	}
	else {
		$('#ip_box').hide();
		$('#dns_box').hide();
		$('#build_dhcpc').attr('disabled',true);
		$('#build_dns').attr('disabled',true);
	}
}

function checked_dns()
{
	if ($('#build_dns').is(':checked')) {
		$('#dns_box').show();
	}
	else{
		$('#dns_box').hide();
	}
}

function basic_mode(){
	$('#tabs').hide();
}

function advanced_mode(){
	$('#tabs').show();
}

function verifyIP(ip0, ip1, ip2, ip3, info)
{
	var IPvalue = ip0 +'.' + ip1 +'.' + ip2 +'.' + ip3;
	if (info == 'ip'){
		message = "<%= locale_index.validator.ip_address%>";
		valid = "<%=locale_index.validator.address_valid%>";
		}
	else if (info == 'gateway'){
		message = "<%= locale_index.validator.gateway_address%>";
		valid = "<%=locale_index.validator.address_valid%>";
	}
	else if (info == 'dns') {
		message = "<%= locale_index.validator.dns_address%>";
		valid = "<%=locale_index.validator.address_valid%>";
	}
	
	else if (info == 'mask') {
		message = "<%= locale_index.validator.mask_address%>";
		valid = "<%=locale_index.validator.address_valid%>";
	}
	
	errorString = "";
	
	var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
	var ipArray = IPvalue.match(ipPattern);
	
	if (IPvalue == "0.0.0.0")
		errorString = errorString + message + '  ' + IPvalue + '  ' + valid;
	else if (IPvalue == "255.255.255.255")
		errorString = errorString + message + '  ' + IPvalue + '  ' + valid;
	if (ipArray == null)
		errorString = errorString + message + '  ' + IPvalue + '  ' + valid;
	else {
		for (i = 0; i < 4; i++) {
			thisSegment = ipArray[i];
			if (thisSegment > 255) {
				errorString = errorString + message + '  ' + IPvalue + '  ' + valid;
				i = 4;
			}
			if ((i == 0) && (thisSegment > 255)) {
				errorString = errorString + message + '  ' + IPvalue + '  ' + valid;
				i = 4;
	      	}
	   	}
	}
	extensionLength = 3;
	if (errorString != "")
		alert (errorString);
}

</script>

<% if flash.get("validationMessagesBuild") ~= nil then %>
<br>
	<%= flash.get("validationMessagesBuild")%>
<% end %>


<div id="box_title"><%=  build.id ~= nil and locale_index.builds_title or locale_index.new_builds_title %></div>


<div id="create_page_build">
	<%= f.form({action = makeURL({control='builder',act='files'}), onsubmit="$('#send').attr('disabled',true);$('#generating').show()"})%>
		<%= f.hidden_field({name='id', value=build.id}) %>
		<%= f.hidden_field({name='created_at', value=build.created_at}) %>
		<br>
		<div>
			<div>
				<div id="box_title_build">
					<div class="box_text_build" ><%= locale_index.labels.title_build %></div>
				</div>
				<div class="build_components"><%= f.text_field({class="field name_field", name='title', value=build.title})%></div>
			</div>
			
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_components.target_title %></div>
				</div>
				<div class="build_components"><%= f.select({name='target',class="select_field",prompt = locale_components.target_prompt,onchange=tonumber(build.id) == nil and ("window.location.href='"..makeURL().."&target='+this.value+'&title='+$('#title').val()") or nil},BuildModel.TARGETS, build.configs.target) %></div>
			</div>
			
			<div>
				<div id="box_title_build">
					<div class="box_text_build" ><%= locale_index.labels.mode %></div>
				</div><br>
				<div class="build_components">
					<input type="button" name='basic' value='<%=locale_index.labels.basic%>', onclick="basic_mode();">
					<input type="button" name='advanced' value='<%=locale_index.labels.advanced%>', onclick="advanced_mode();">
				</div>
			</div>
			
			<div id="tabs" class="build_components">
			    <ul>
			        <li><a href="#general"><span><%=locale_index.labels.general%></span></a></li>
					<li><a href="#components"><span><%=locale_components.component_title%></span></a></li>
					<li><a href="#net"><span><%=locale_index.labels.net%></span></a></li>
					<li><a href="#luarpc"><span><%=locale_index.labels.luarpc%></span></a></li>
			    </ul>
			    <div id="general">
					<div id="box_title_build">
						<div class="box_text_build"><%= locale_components.toolchain_title %></div>
					</div>
					<div class="build_components">
						<%=f.select({name="toolchain", class="select_field"},BuildModel.TOOLCHAINS, build.configs.toolchain)%>
						<!--<br><br><%= f.check_box({name='lua_optimize'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.lua_optimize})%><b><%=locale_components.lua_optimize%></b>-->
					</div>
					
					<div id="box_title_build">
						<div class="box_text_build"><%=locale_index.files_romfsmode_title%></div>
					</div>
					<div class="build_components">
						<%=f.select({name="romfsmode", class="select_field"},BuildModel.ROMFSMODE, build.configs.romfsmode)%>
					</div>
			    </div>	
				
				<div id="components">
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
											<%= f.check_box({name='build_romfs', id='build_romfs',disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_romfs}) %>
										</td> 
										<td title="<%=locale_components.build_romfs%>" ><%= locale_components.labels.build_romfs %>	</td> 
									</tr> 
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_con_generic', disabled=false, id='build_con_generic',onclick='checked_con_generic();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_generic}) %>
										</td> 
										<td title="<%=locale_components.build_con_generic%>" ><%= locale_components.labels.build_con_generic %>	</td> 
									</tr> 
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_con_tcp', id='build_con_tcp',disabled=false, onclick='checked_con_tcp();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_tcp}) %>
										</td> 
										<td title="<%=locale_components.build_con_tcp%>" ><%= locale_components.labels.build_con_tcp %>	</td> 
									</tr> 
									
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_term', id= 'build_term', disabled=true, onclick='checked_term();'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.build_term}) %>
										</td> 
										<td title="<%=locale_components.build_term%>" ><%= locale_components.labels.build_term %>	</td> 
										
									</tr> 
									<tr> 
									<td class="td_check_box">
											<%= f.check_box({name='build_shell', id= 'build_shell',disabled=true, onclick='checked_shell();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_shell}) %>
										</td> 
										<td title="<%=locale_components.build_shell%>" ><%= locale_components.labels.build_shell %>	</td> 
									</tr>  
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_xmodem', id= 'build_xmodem', disabled=true},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_xmodem}) %>
										</td> 
										<td title="<%=locale_components.build_xmodem%>" ><%= locale_components.labels.build_xmodem %></td> 
										
									</tr> 
																
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_uip', id='build_uip', disabled=false, onclick='checked_ip();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_uip}) %>
										</td> 
										<td title="<%=locale_components.build_uip%>" ><%= locale_components.labels.build_uip %>	</td> 
										<td id="ip_box" style="display:none;">
											<div class="box_ip">
												<%= locale_components.labels.ip %>
												<%=f.text_field({class="field ip_field", name='ip0', id= "ip0",  value=build.configs.ip0, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='ip1', id= "ip1", value=build.configs.ip1, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='ip2', id= "ip2", value=build.configs.ip2, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='ip3', id= "ip3", value=build.configs.ip3, maxlength = 3, onblur="verifyIP($('ip0').value, $('ip1').value, $('ip2').value, $('ip3').value, 'ip')"})%>
											</div><br>
											<div class="box_ip">
												<%= locale_components.labels.mask %>
												<%=f.text_field({class="field ip_field", name='mask0', value=build.configs.mask0, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='mask1', value=build.configs.mask1, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='mask2', value=build.configs.mask2, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='mask3', value=build.configs.mask3, maxlength = 3, onblur="verifyIP($('mask0').value, $('mask1').value, $('mask2').value, $('mask3').value, 'mask')"})%>
											</div><br>
											<div class="box_ip">
												<%= locale_components.labels.gateway %>
												<%=f.text_field({class="field ip_field", name='gateway0', id= "gateway0", value=build.configs.gateway0, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='gateway1', id= "gateway1", value=build.configs.gateway1, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='gateway2', id= "gateway2", value=build.configs.gateway2, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='gateway3', id= "gateway3", value=build.configs.gateway3, maxlength = 3, onblur="verifyIP($('gateway0').value, $('gateway1').value, $('gateway2').value, $('gateway3').value, 'gateway')"})%>
											</div><br>
										</td>
										<script>checked_ip();</script>
									</tr> 
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_dhcpc', id='build_dhcpc',disabled=true},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dhcpc}) %>
										</td> 
										<td title="<%=locale_components.build_dhcpc%>" ><%= locale_components.labels.build_dhcpc %>	</td> 
										<script>checked_dhcpc();</script>
									</tr> 
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_dns', id='build_dns',disabled=true, onclick='checked_dns();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dns}) %>
										</td> 
										<td title="<%=locale_components.build_dns%>" ><%= locale_components.labels.build_dns %>	</td> 
										<td id="dns_box" style="display:none;">
											<div class="box_ip">
												<%= locale_components.labels.dns %>
												<%=f.text_field({class="field ip_field", name='dns0', id= "dns0", value=build.configs.dns0, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='dns1', id= "dns1", value=build.configs.dns1, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='dns2', id= "dns2", value=build.configs.dns2, maxlength = 3})%>.
												<%=f.text_field({class="field ip_field", name='dns3', id= "dns3", value=build.configs.dns3, maxlength = 3, onblur="verifyIP($('dns0').value, $('dns1').value, $('dns2').value, $('dns3').value, 'dns')"})%>	
											</div>	
										</td>
									</tr> 
									
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_adc', id='build_adc', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_adc}) %>
										</td> 
										<td title="<%=locale_components.build_adc%>" ><%= locale_components.labels.build_adc %>	</td> 
									</tr>
									
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_rpc', id='build_rpc', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_rpc}) %>
										</td> 
										<td title="<%=locale_components.build_rpc%>" ><%= locale_components.labels.build_rpc %>	</td> 
									</tr>
									
									<tr> 
										<td class="td_check_box">
											<%= f.check_box({name='build_mmcfs', id='build_mmcfs', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_mmcfs}) %>
										</td> 
										<td title="<%=locale_components.build_mmcfs%>" ><%= locale_components.labels.build_mmcfs %>	</td> 
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<script>
						checked_con_generic();
						checked_con_tcp();
						
						checked_ip();
					</script>
				</div>	    
				
				<div id="net"></div>
				
				<div id="luarpc"></div>
			</div><br>
			
			<script type="text/javascript">
	  			$(document).ready(function(){
	    		$("#tabs").tabs();
				$('#tabs').hide();
	  			});	
			</script>		
			<!--<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_index.labels.title_MCU %></div>
				</div>
				<div class="build_components"><%= f.text_field({class="field name_field", name='mcu', value=build.mcu})%></div>
			</div>-->
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%=locale_index.files_romfs_title%></div>
				</div>
				<div class="build_components">
					<input type=checkbox name="only_user_files" id="only_user_files" value="1" onclick="ref_dataSetFiles.myDataTable.reload('only_user_files='+this.checked);"><b><%=locale_index.labels.view%></b>
					<div>
						<%
							local columns_files = { 
													{key="id", label = locale_index.label_select, width=40, formatter="myActions", className="columnCenter"},
													{key="id", label = locale_index.label_autorun, width=100, formatter="autorun", className="columnCenter"},
													{key="filename", label= locale_index.labels.filename,  sortable=true,width=200},
													{key="category", label= locale_index.labels.file_type, sortable=true, width=100},
													{key="created_at", label=locale_index.labels.created_at, sortable=true, width=150},
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
													paginatorPosition = "bottom",
													rowsPerPage = 5,
													rowsPerPageOptions = {5,10,15,20,30,40,60},
			
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