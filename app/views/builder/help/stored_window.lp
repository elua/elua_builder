<div id='msg_help_stored_files_list' style="display:none;">
	<%= locale_help.stored_files_window %>
</div>

<script type="text/javascript">
    $(window).bind('load', function(){
		$('#help_stored_files_list').bubbletip($('#msg_help_stored_files_list'), {deltaDirection: 'left', calculateOnShow:true, bindShow:'focus', delayHide:50, bindHide:'blur'});
	});
</script>
