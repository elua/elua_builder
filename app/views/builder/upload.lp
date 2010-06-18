<div class="box_upload_list" style="display:none;" id="upload_box">
	<!-- 
	<input type="file" name="file" id="filename"> 
	<form method="POST" enctype="multipart/form-data" action="start.lua?control=files&act=upload" onsubmit="return( $('filename').value != '');">
		</form>
	<input type="submit" value="Upload">  -->
	<div class="logout_upload_right"><a href="javascript:void(0);" title="<%=locale_index.labels.close_box%>" onclick="box_upload_close();"><img src="images/buttons/logout.png" border=0></a></div>
	<input id="filename" name="filename" type="file"/>
	<a href="javascript:$('#filename').uploadifyUpload();"><b>Upload Files</b></a> | 
	<a href="javascript:$('#filename').uploadifyClearQueue();"><b>Clear Selected</b></a>
	<% local UserModel = require("user.model")%>
	
	<script type="text/javascript">
		function reload_grid(event, data)
		{
			ref_dataSetFiles.myDataTable.reload('filter='+this.value);
		}
		$(document).ready(function() {
			$('#filename').uploadify({
				'uploader'  : 'lib/jquery/uploadify/uploadify.swf',
				'script'    : '<%= makeURL({control='files', act='upload'})%>',
				'scriptData': {control:'files', act:'upload',h:'<%= current_user.user_hash %>'},
				'cancelImg' : 'images/cancel.png',
				'folder'    : 'lib/jquery/uploadify/uploads',
				'sizeLimit' : '524288',
				'auto'      : false,
				'simUploadLimit': 10,
				'queueSizeLimit' : 10,
				'multi'     : true,
				'onAllComplete' : reload_grid
			});
		}); 
	</script>
</div>