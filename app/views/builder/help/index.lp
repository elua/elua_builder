<div id='msg_help_builds_title' style="display:none;">
	<%=locale_help.build_configurations %>
</div>
<div id='msg_help_stored_files' style="display:none;">
	<%=locale_help.stored_files %><br>

</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_builds_title').bubbletip($('#msg_help_builds_title'), {deltaDirection:'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
		$('#help_stored_files').bubbletip($('#msg_help_stored_files'), {deltaDirection:'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
	});
</script>