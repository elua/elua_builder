<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>
<% jquery = true %>
<% render("header.lp","_shared") %>

<% dt.printJSheaders("lib/yui/js/") %>
<% dt.printDataTableCSS("lib/yui/css/") %>
<% dt.printYuiCSS("lib/yui/css/") %>
<% loadJS('js/files.js') %>
<script>
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

<div id='loading' style='display:none;'>Loading...</div>

<div id="box_title">
	<%=  build.id ~= nil and locale_index.edit_build_title or locale_index.new_build_title %>&nbsp;
	<div class="help"><a id="help_build_configuration" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
</div>
<% if flash.get("validationMessagesBuild") ~= nil then %>
<br>
	<%= flash.get("validationMessagesBuild")%>
<% end %>

<div id="create_page_build">
	<%= f.form({action = makeURL({control='builder',act='files'}), onsubmit="$('#send').attr('disabled',true);$('#generating').show()"})%>
		<%= f.hidden_field({name='id', value=build.id}) %>
		<%= f.hidden_field({name='created_at', value=build.created_at}) %>
		<br>
		<div>
			<div>
				<div class="box_title_build">
					<div class="box_text_build" ><%= locale_index.labels.title_build %></div>
				</div>
				<div class="build_components"><%= f.text_field({class="field name_field", name='title', value=build.title})%></div>
			</div>
			
			<div>
				<div class="box_title_build">
					<div class="box_text_build">
						<%= locale_components.target_title %>&nbsp;
						<div class="help_2"><a id="help_target_title" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
					</div>
				</div>
				
				<div class="build_components"><%= f.select({name='target',class="select_field",prompt = locale_components.target_prompt,onchange=tonumber(build.id) == nil and ("unload_helps_tabs();ajax_request('"..makeURL({control='builder',act='tabs_content'}).."',{target:this.value}, '#tabs','loading',reload_tabs);") or nil},BuildModel.TARGETS, build.configs.target) %></div>
			</div>
			<!--Files ROMFS -->
			<div>
				<div class="box_title_build">
					<div class="box_text_build">
						<%=locale_index.files_romfs_title%>&nbsp;
						<div class="help_2"><a id="help_rom_file_system" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
					</div>		
				</div>
				<div class="links_right_add_files">
					<a href="#dialog" title="<%=locale_index.labels.box_view%>" name="view_file_list" id="view_file_list"><img src="images/buttons/btn_novoprojeto.gif" align="absmiddle" border=0> <b><%=locale_index.labels.box_view%></b></a>
				</div>	
				<br>
				<table id="file_list" class="table_align">
					<th>	
						<td width=15% align=center><b><%=locale_index.label_autorun%></b></td>
						<td width=45% align=center><b><%=locale_index.labels.filename%></b></td>
						<td width=35% align=center><b><%=locale_index.labels.file_type%></b></td>
					</th>
				</table><br>
				<script>
					window.onload = function(){
						<%for i,v in pairs(build_files)do
							local id = v.file_id.."_"..v.category_id
						%>
							add_file('<%= id%>','<%= v.filename%>','<%= v.category%>', <%= tostring(id == build.configs.autorun_file_id)%>);
						<% end %>
					}
				</script>
			</div>	
			<!--Mode Selection-->
			<div>
				<div class="box_title_build">
					<div class="box_text_build" >
						<%= locale_index.labels.mode %>:
						<input type="button" name='basic' id='basic' value='<%=locale_index.labels.basic%>', onclick="basic_mode();">
						<input type="button" name='advanced' id='advanced' value='<%=locale_index.labels.advanced%>', onclick="advanced_mode();"> &nbsp;
						<div class="help_2"><a id="help_mode_selection" href="#"><img src="images/buttons/help_2.png" border='0'></a></div>
					</div>
					<script>basic_mode();</script>
				</div>
			</div>
			<br>
			<div id="tabs" class="build_components">
			    <%= render('tabs_content.lp')%>
					
			</div><br>
			<% render("help/tabs_content.lp") %>
			<script type="text/javascript">
	  			function reload_tabs(){
					$("#tabs").tabs( "destroy" );
					$('#tabs').tabs();
					checked_con_generic();
					checked_con_tcp();						
					checked_ip();
					load_helps_tabs();
				}
				$(document).ready(function(){
					reload_tabs();
					$('#tabs').hide();
				});	
				
			</script>		
			
		</div>
		<!--Form Button -->
		<div class="build_button">
			<%= f.submit({id='send',class="button_submit",value = locale_components.label_build, onclick="showProgress()"}) %>
		</div>
	<%= f.form_close() %>
	<div id="bottom_text" class="links">
		<a href="<%= makeURL({control= "builder", act="index"})%>">&raquo;&nbsp;<%=locale_index.label_back%></a>
	</div>
</div>
<% render("stored_window.lp") %>

<script>
	function showProgress() {
	    var pb = document.getElementById("progressBar");
	    pb.innerHTML = '<img src="images/ajax-loader.gif" width="200" height ="40"/>';
	    pb.style.display = '';
}
</script>

<div class="generate" style="display:none;" id='generating' >
	<h2>Please wait.</h2><br/> 
	<div id="progressBar" style="display: none;">
		<img src="images/ajax-loader.gif" width="200" height ="40"/>
	</div>
	<h2><%= locale_index.generated_msg %></h2>
</div>
<% render("help/files.lp") %>
<% render("footer.lp","_shared") %>