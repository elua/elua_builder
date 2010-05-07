<div id='msg_help_build_configuration' style="display:none;">
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
</div>
<div id='msg_help_target_title' style="display:none;">
	<b><%=locale_components.labels.target%></b>:&nbsp;<%=locale_components.target_info%>
</div>
<div id='msg_help_rom_file_system' style="display:none;">
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
</div>
<div id='msg_help_mode_selection' style="display:none;">
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
	blablablsdsafdhjasdhfjashfkj<br>
</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_build_configuration').bubbletip($('#msg_help_build_configuration'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_target_title').bubbletip($('#msg_help_target_title'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_rom_file_system').bubbletip($('#msg_help_rom_file_system'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_mode_selection').bubbletip($('#msg_help_mode_selection'), {deltaDirection: 'right', calculateOnShow:true});
	});
</script>