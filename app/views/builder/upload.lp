<form action="<%= makeURL({control="files", act="upload"})%>" method="POST">
	<div id="uploader">
		<input type="file" name="file" size="40">
		<input type="submit">
		<p>You browser doesn't have Flash, Silverlight, Gears, BrowserPlus or HTML5 support.</p>
	</div>
</form>

<script>
$(function() {
	$("#uploader").pluploadQueue({
		// General settings
		runtimes : 'html5,flash,silverlight,browserplus,gears',
		url : '<%=makeURL({control='files',act='upload'})%>',
		max_file_size : '10mb',
		chunk_size : '1mb',
		unique_names : true,

		// Resize images on clientside if we can
		resize : {width : 320, height : 240, quality : 90},

		// Specify what files to browse for
		filters : [
			{title : "Image files", extensions : "jpg,gif,png"},
			{title : "Zip files", extensions : "zip"}
		],

		// Flash settings
		flash_swf_url : 'lib/jquery/plupload/js/plupload.flash.swf',

		// Silverlight settings
		silverlight_xap_url : 'lib/jquery/plupload/js/plupload.silverlight.xap'
	});

	// Client side form validation
	$('form').submit(function(e) {
		var uploader = $('#uploader').pluploadQueue();

		// Validate number of uploaded files
		if (uploader.total.uploaded == 0) {
			// Files in queue upload them first
			if (uploader.files.length > 0) {
				// When all files are uploaded submit form
				uploader.bind('UploadProgress', function() {
					if (uploader.total.uploaded == uploader.files.length)
						$('form').submit();
				});

				uploader.start();
			} else
				alert('You must at least upload one file.');

			e.preventDefault();
		}
	});
});
</script>
<!--
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
		<a href="javascript:$('#filename').uploadifyUpload();"><b>Upload Files</b></a>
		<a href="javascript:$('#filename').uploadifyClearQueue();"><b>Clear Selected</b></a>
	</div>

-->