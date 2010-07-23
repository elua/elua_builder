<% f = require "luawebforms" %>
	<ul>
	    <li><a href="#general"><span><%=locale_index.labels.general%></span></a></li>
		<li><a href="#components"><span><%=locale_components.component_title%></span></a></li>
		<li><a href="#net"><span><%=locale_index.labels.net%></span></a></li>
		<li><a href="#file_systems"><span><%=locale_index.labels.file_systems%></span></a></li>
		<!--<li><a href="#luarpc"><span><%=locale_index.labels.luarpc%></span></a></li>-->
	</ul>

		<div id="general">
			<div id="box_title_tabs">
				<div class="box_text_build">
					<%= locale_components.toolchain_title %> &nbsp;
					<div class="help_2"><a id="help_toolchain" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
				</div>
			</div>
			<div class="build_components">
				<%=f.select({name="toolchain", class="select_field"},BuildModel.TOOLCHAINS, build.configs.toolchain)%>
				<!--<br><br><%= f.check_box({name='lua_optimize'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.lua_optimize})%><b><%=locale_components.lua_optimize%></b>-->
			</div>
			
			<div id="box_title_tabs">
				<div class="box_text_build">
					<%=locale_index.files_romfsmode_title%>&nbsp;
					<div class="help_2"><a id="help_romfs_build_mode" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
				</div>
			</div>
			<div class="build_components">
				<%=f.select({name="romfsmode", class="select_field"},BuildModel.ROMFSMODE, build.configs.romfsmode)%>
			</div>
			<!--<div>
				<div id="box_title_build">
					<div class="box_text_build"><%= locale_index.labels.title_MCU %></div>
				</div>
				<div class="build_components"><%= f.text_field({class="field name_field", name='mcu', value=build.mcu})%></div>
			</div>-->
	    </div>	
		
		<div id="components">
			<div>
				<div id="box_title_tabs">
					<div class="box_text_build">
						<%= locale_components.component_title %>&nbsp;
						<div class="help_2"><a id="help_components" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
					</div>
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
									<%= f.check_box({name='build_term', id= 'build_term', disabled=true, onclick='checked_term();'},BuildModel.CHECK_DEFAULT_VALUE,{build.configs.build_term}) %>
							</td> 
								<td><%= locale_components.labels.build_term %>	</td> 
								
							</tr> 
							<tr> 
							<td class="td_check_box">
									<%= f.check_box({name='build_shell', id= 'build_shell',disabled=true, onclick='checked_shell();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_shell}) %>
								</td> 
								<td><%= locale_components.labels.build_shell %>	</td> 
							</tr>  
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_xmodem', id= 'build_xmodem', disabled=true},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_xmodem}) %>
								</td> 
								<td><%= locale_components.labels.build_xmodem %></td> 
								
							</tr>
						
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_adc', id='build_adc', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_adc}) %>
								</td> 
								<td><%= locale_components.labels.build_adc %>	</td> 
							</tr>
							<tr> 
								<td class="td_check_box">
									<%= f.check_box({name='build_rpc', id='build_rpc', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_rpc}) %>
								</td> 
								<td><%= locale_components.labels.build_rpc %></td> 
							</tr>
						</tbody>
					</table>
				</div>
				
			</div>
		
		</div>
	
	<div id="net">
		<div>
			<div id="box_title_tabs">
				<div class="box_text_build">
					<%=locale_components.net_title%>&nbsp;
					<div class="help_2"><a id="help_network" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
				</div>
			</div>
			<div class="build_components">
				<table>
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_con_tcp', id='build_con_tcp',disabled=false, onclick='checked_con_tcp();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_tcp}) %>
						</td> 
						<td><%= locale_components.labels.build_con_tcp %></td> 
					</tr>
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_con_generic', disabled=false, id='build_con_generic',onclick='checked_con_generic();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_con_generic}) %>
						</td> 
						<td><%= locale_components.labels.build_con_generic %></td> 
					</tr>  
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_uip', id='build_uip', disabled=false, onclick='checked_ip();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_uip}) %>
						</td> 
						<td><%= locale_components.labels.build_uip %></td> 
						<td id="ip_box" style="display:none;">
							<div class="box_ip">
								<%= locale_components.labels.ip %>
								<%=f.text_field({class="field ip_field", name='ip0', id= "ip0",  value=build.configs.ip0, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='ip1', id= "ip1", value=build.configs.ip1, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='ip2', id= "ip2", value=build.configs.ip2, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='ip3', id= "ip3", value=build.configs.ip3, maxlength = 3, onblur="verifyIP($('#ip0').val(), $('#ip1').val(), $('#ip2').val(), $('#ip3').val(), 'ip')"})%>
							</div><br>
							<div class="box_ip">
								<%= locale_components.labels.mask %>
								<%=f.text_field({class="field ip_field", name='mask0', value=build.configs.mask0, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='mask1', value=build.configs.mask1, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='mask2', value=build.configs.mask2, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='mask3', value=build.configs.mask3, maxlength = 3, onblur="verifyIP($('#mask0').val(), $('#mask1').val(), $('#mask2').val(), $('#mask3').val(), 'mask')"})%>
							</div><br>
							<div class="box_ip">
								<%= locale_components.labels.gateway %>
								<%=f.text_field({class="field ip_field", name='gateway0', id= "gateway0", value=build.configs.gateway0, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='gateway1', id= "gateway1", value=build.configs.gateway1, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='gateway2', id= "gateway2", value=build.configs.gateway2, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='gateway3', id= "gateway3", value=build.configs.gateway3, maxlength = 3, onblur="verifyIP($('#gateway0').val(), $('#gateway1').val(), $('#gateway2').val(), $('#gateway3').val(), 'gateway')"})%>
							</div><br>
						</td>
						
					</tr> 
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_dns', id='build_dns',disabled=true, onclick='checked_dns();'},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dns}) %>
						</td> 
						<td><%= locale_components.labels.build_dns %></td> 
						<td id="dns_box" style="display:none;">
							<div class="box_dns">
								<%= locale_components.labels.dns %>
								<%=f.text_field({class="field ip_field", name='dns0', id= "dns0", value=build.configs.dns0, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='dns1', id= "dns1", value=build.configs.dns1, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='dns2', id= "dns2", value=build.configs.dns2, maxlength = 3})%>.
								<%=f.text_field({class="field ip_field", name='dns3', id= "dns3", value=build.configs.dns3, maxlength = 3, onblur="verifyIP($('#dns0').val(), $('#dns1').val(), $('#dns2').val(), $('#dns3').val(), 'dns')"})%>	
							</div>	
						</td>
					</tr> 
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_dhcpc', id='build_dhcpc',disabled=true},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_dhcpc}) %>
						</td> 
						<td><%= locale_components.labels.build_dhcpc %></td> 
					</tr> 
				</table>
			</div>
		</div>
	</div>
	<div id="file_systems">
		<div>
			<div id="box_title_tabs">
				<div class="box_text_build">
					<%= locale_components.file_systems_title %>&nbsp;
					<div class="help_2"><a id="help_file_systems" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
				</div>
			</div>
			<div class="build_components">
				<table>
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_romfs', id='build_romfs',disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_romfs}) %>
						</td> 
						<td><%= locale_components.labels.build_romfs %>	</td> 
					</tr> 
					<tr> 
						<td class="td_check_box">
							<%= f.check_box({name='build_mmcfs', id='build_mmcfs', disabled=false},BuildModel.CHECK_DEFAULT_VALUE, {build.configs.build_mmcfs}) %>
						</td> 
						<td><%= locale_components.labels.build_mmcfs %>	</td> 
					</tr>
				</table>
			</div>
		</div>
	</div>
	<!--<div id="luarpc">
		<div>
			<div id="box_title_tabs">
				<div class="box_text_build"><%=locale_components.luarpc_title%></div>
			</div>
		</div>
	</div>-->
