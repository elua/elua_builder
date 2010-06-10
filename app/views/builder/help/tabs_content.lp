<div id='msg_help_toolchain' style="display:none;">
	<%= locale_help.advanced_tabs.toolchain %>
</div>
<div id='msg_help_romfs_build_mode' style="display:none;">
	<%= locale_help.advanced_tabs.romfs_mode %>
</div>
<div id='msg_help_components' style="display:none;">
	<%= locale_help.advanced_tabs.components %>
</div>
<div id='msg_help_network' style="display:none;">
	<%= locale_help.advanced_tabs.network %>
</div>
<div id='msg_help_file_systems' style="display:none;">
	<%= locale_help.advanced_tabs.file_systems %>
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
