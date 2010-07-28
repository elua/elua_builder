	<div id="upload_box">
		<input id="filename" name="filename" type="file"/>
		
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
					'buttonImg': 'images/buttons/button_upload.png',
					'buttonText':'hsjfhk',
					'hideButton': true,
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
	<div id="upload_buttons">
		<button onclick="$('#filename').uploadifyUpload();">Upload Files</button>
		<!--a href="javascript:$('#filename').uploadifyUpload();"><b>Upload Files</b></a-->
		<!--a href="javascript:$('#filename').uploadifyClearQueue();"><b>Clear Selected</b></a-->
	</div>