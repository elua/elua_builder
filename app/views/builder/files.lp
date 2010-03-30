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
	$('#basic').attr('disabled',true);
	$('#advanced').attr('disabled',false);
}

function advanced_mode(){
	$('#tabs').show();
	$('#basic').attr('disabled',false);
	$('#advanced').attr('disabled',true);
}

function toogle_check(elem)
{	if(elem.checked)
		elem.checked = false;
	else
		elem.checked = true;
	
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
<div id='loading' style='display:none;'>Loading...</div>

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
				
				<div class="build_components"><%= f.select({name='target',class="select_field",prompt = locale_components.target_prompt,onchange=tonumber(build.id) == nil and ("ajax_request('"..makeURL({control='builder',act='tabs_content'}).."',{target:this.value}, '#tabs','loading',reload_tabs);") or nil},BuildModel.TARGETS, build.configs.target) %></div>
			</div>
			<!--Files ROMFS -->
			<div>
				<div id="box_title_build">
					<div class="box_text_build"><%=locale_index.files_romfs_title%></div>
				</div>
				<div class="build_components">
					<input type=checkbox name="only_user_files" id="only_user_files" value="1" onclick="ref_dataSetFiles.myDataTable.reload('only_user_files='+this.checked);"><b><%=locale_index.labels.view%></b>
					<div>
						<%
							local columns_files = { 
													{key="id", label = locale_index.label_select, width=20, formatter="myActions", className="columnCenter"},
													{key="filename", label= locale_index.labels.filename,  sortable=true,width=200},
													{key="category", label= locale_index.labels.file_type, sortable=true, width=100},
													{key="created_at", label=locale_index.labels.created_at, sortable=true, width=150},
							}
							
							
							
							extraFormatters = [[
			                                
			                                //--- COLUMN FORMATTERS
			                                this.actions = function(elLiner, oRecord, oColumn, oData) {
												
			                                    elLiner.innerHTML = "<a href='javascript:add_file(" + oData['id'] + ",\""+oRecord.getData('filename')+"\",\""+oRecord.getData('category')+"\");'><img src=images/buttons/btn_novoprojeto.gif border=0 title=']]..locale_index.label_addfile..[['></a>";
			                                };
			                                YAHOO.widget.DataTable.Formatter.myActions = this.actions;  
											
											
											this.autorun = function(elLiner, oRecord, oColumn, oData) {
			                                    elLiner.innerHTML = "<input type='radio' name='autorun_file_id' value='"+oData['id']+"' onchange='toogle_check(this)' onclick='toogle_check(this)'> ";
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
					<script>
			            var files = [];
					    function add_file(id, filename, category, autorun){
						     if(! files[id]){
							 	var checked = autorun?'checked':'';
						      	$('#file_list').append('<tr id="id"><td align=center><input type=\'hidden\' name=\'file_id\' value=\''+id+'\' /><a href="#" onclick="remove_file(\''+id+'\');"><img src=\'images/buttons/cancel.png\' border=\'0\' style=\'vertical-align:middle;margin-right:5px;\' /></a></td><td align=center><input type="radio" name="autorun_file_id" value="'+id+'" '+checked+' onchange="toogle_check(this)" onclick="toogle_check(this)"></td><td>'+filename+'</td><td align=center>'+category+'</td></tr>');
						      	files[id] = true;      
						     }
					    }
					    function remove_file(id){
							$('#id').remove();
							files[id] = false; 
					    }
			    
			     </script>
			   <br />   
			   <h3><%=locale_index.label_add_files%></h3>  
			   <table id="file_list">
					<th>	
						<td width=60px align=center><b><%=locale_index.label_autorun%></b></td>
						<td width=300px align=center><b><%=locale_index.labels.filename%></b></td>
						<td width=160px align=center><b><%=locale_index.labels.file_type%></b></td>
					</th>
			    
			   </table>
				</div>
			</div>	
			<script>
				window.onload = function(){
					<%for i,v in pairs(build_files)do%>
					add_file(<%= v.id%>,'<%= v.filename%>','<%= v.category%>', <%= tostring(tonumber(v.id) == tonumber(build.configs.autorun_file_id))%>);
					<% end %>
				}
			</script>
			<!--Mode Selection-->
			<div>
				<div id="box_title_build">
					<div class="box_text_build" >
						<%= locale_index.labels.mode %>:
						<input type="button" name='basic' id='basic' value='<%=locale_index.labels.basic%>', onclick="basic_mode();">
						<input type="button" name='advanced' id='advanced' value='<%=locale_index.labels.advanced%>', onclick="advanced_mode();">
					</div>
					<script>basic_mode();</script>
				</div>
			</div>
			<br>
			<div id="tabs" class="build_components">
			    <%= render('tabs_content.lp')%>
			   
				
			</div><br>
			
			<script type="text/javascript">
	  			function reload_tabs(){
					$("#tabs").tabs( "destroy" );
					$('#tabs').tabs();
					checked_con_generic();
					checked_con_tcp();						
					checked_ip();
				}
				$(document).ready(function(){
					reload_tabs();
					$('#tabs').hide();
				});	
				
			</script>		
			
		</div>
		<!--Form Button -->
		<div class="build_button">
			<%= f.submit({id='send',class="button_submit",value = locale_components.label_build}) %>
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