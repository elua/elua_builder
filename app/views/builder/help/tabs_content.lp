<div id='msg_help_toolchain' style="display:none;">
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
</div>
<div id='msg_help_romfs_build_mode' style="display:none;">
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
</div>
<div id='msg_help_components' style="display:none;">
	<b><%=locale_components.labels.build_term%></b>:&nbsp;<%=locale_components.build_term%><br><br>
	<b><%=locale_components.labels.build_xmodem%></b>:&nbsp;<%=locale_components.build_xmodem%><br><br>
	<b><%=locale_components.labels.build_xmodem%></b>:&nbsp;<%=locale_components.build_xmodem%><br><br>
	<b><%=locale_components.labels.build_adc%></b>:&nbsp;<%=locale_components.build_adc%><br><br>  
	<b><%=locale_components.labels.build_rpc%></b>:&nbsp;<%=locale_components.build_rpc%>
</div>
<div id='msg_help_network' style="display:none;">
	<b><%=locale_components.labels.build_con_tcp%></b>:&nbsp;<%=locale_components.build_con_tcp%><br><br> 
	<b><%=locale_components.labels.build_con_generic%></b>:&nbsp;<%=locale_components.build_con_generic%><br><br> 
	<b><%=locale_components.labels.build_uip%></b>:&nbsp;<%=locale_components.build_uip%><br><br>  
	<b><%=locale_components.labels.build_dns%></b>:&nbsp;<%=locale_components.build_dns%><br><br> 
	<b><%=locale_components.labels.build_dhcpc%></b>:&nbsp;<%=locale_components.build_dhcpc%>
</div>
<div id='msg_help_file_systems' style="display:none;">
	<b><%=locale_components.labels.build_romfs%></b>:&nbsp;<%=locale_components.build_romfs%><br><br> 
	<b><%=locale_components.labels.build_mmcfs%></b>:&nbsp;<%=locale_components.build_mmcfs%>
</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_toolchain').bubbletip($('#msg_help_toolchain'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_romfs_build_mode').bubbletip($('#msg_help_romfs_build_mode'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_components').bubbletip($('#msg_help_components'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_network').bubbletip($('#msg_help_network'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_file_systems').bubbletip($('#msg_help_file_systems'), {deltaDirection: 'right', calculateOnShow:true});
	});
</script>
