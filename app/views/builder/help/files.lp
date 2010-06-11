<div id='msg_help_build_configuration' style="display:none;">
	<%= locale_help.build.main_build %>
</div>
<div id='msg_help_target_title' style="display:none;">
	<%= locale_help.build.target_platform %>
</div>
<div id='msg_help_rom_file_system' style="display:none;">
	<%= locale_help.build.ROM_FS %>
</div>
<div id='msg_help_mode_selection' style="display:none;">
	<%= locale_help.build.options_configuration %>
</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_build_configuration').bubbletip($('#msg_help_build_configuration'), {deltaDirection: 'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
		$('#help_target_title').bubbletip($('#msg_help_target_title'), {deltaDirection: 'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
		$('#help_rom_file_system').bubbletip($('#msg_help_rom_file_system'), {deltaDirection: 'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
		$('#help_mode_selection').bubbletip($('#msg_help_mode_selection'), {deltaDirection: 'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
	});
</script>