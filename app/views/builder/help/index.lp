<div id='msg_help_builds_title' style="display:none;">
	<%=locale_help.what_build_configurations_title%><br>
	<%=locale_help.what_build_configurations%><br>
	<%=locale_help.new_build_configurations_title%><br>
	<%=locale_help.new_build_configurations%><br>
	<%=locale_help.buttons_build_configurations_title%><br>
	<%=locale_help.buttons_build_configurations%><br>
</div>
<div id='msg_help_stored_files' style="display:none;">
	<%=locale_help.what_build_configurations_title%><br>
	<%=locale_help.what_build_configurations%><br>
	<%=locale_help.new_build_configurations_title%><br>
	<%=locale_help.new_build_configurations%><br>
	<%=locale_help.buttons_build_configurations_title%><br>
	<%=locale_help.buttons_build_configurations%><br>
</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_builds_title').bubbletip($('#msg_help_builds_title'), {deltaDirection:'right', calculateOnShow:true});
		$('#help_stored_files').bubbletip($('#msg_help_stored_files'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_build_configuration').bubbletip($('#msg_help_build_configuration'), {deltaDirection: 'right', calculateOnShow:true});
		$('#help_target_title').bubbletip($('#msg_help_target_title'), {deltaDirection: 'right', calculateOnShow:true});
	});
</script>