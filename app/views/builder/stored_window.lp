<div class="background_box" style="display:none;" id="background_box">	
	<div class="box_file_list" id='files_list'>
		
		<div class="box_title_build box_size">
			<div class="box_text_build"><%= locale_index.labels.files_list %>
			<div class="links_right"><a href="javascript:void(0);" title="<%=locale_index.labels.close_box%>" onclick="box_close();"><img src="images/buttons/logout.png" border=0></a></div>
		</div></div>
		<div class="build_components">
			<input type=checkbox name="only_user_files" id="only_user_files" value="1" onclick="ref_dataSetFiles.myDataTable.reload('only_user_files='+this.checked);"><b><%=locale_index.labels.view%></b>
			<div>
				<%
					local columns_files = { 
											{key="id", label = locale_index.label_select, width=20, formatter="myActions", className="columnCenter"},
											{key="filename", label= locale_index.labels.filename,  sortable=true,width=200},
											{key="category", label= locale_index.labels.file_type, sortable=true, width=100},
											{key="created_at", label=locale_index.labels.created_at, sortable=true, width=150},
					}
					
					
					
					extraFormatters = [[
	                                
	                                //--- COLUMN FORMATTERS
	                                this.actions = function(elLiner, oRecord, oColumn, oData) {
										
	                                    elLiner.innerHTML = "<a href='javascript:add_file(\"" + oData+ "\",\""+oRecord.getData('filename')+"\",\""+oRecord.getData('category')+"\");'><img src=images/buttons/btn_novoprojeto.gif border=0 title=']]..locale_index.label_addfile..[['></a>";
	                                };
	                                YAHOO.widget.DataTable.Formatter.myActions = this.actions;  
									
									
									this.autorun = function(elLiner, oRecord, oColumn, oData) {
	                                    elLiner.innerHTML = "<input type='radio' name='autorun_file_id' value='"+oData['id']+"' onchange='toogle_check(this)' onclick='toogle_check(this)'> ";
	                                };
	                                YAHOO.widget.DataTable.Formatter.autorun = this.autorun;                                                        
	                ]]
					
					local configs_files = {
											dataSetID = "dataSetFiles",
											serverPagination = false,
											defaultSorting = 'filename',
											paginatorPosition = "bottom",
											rowsPerPage = 15,
											rowsPerPageOptions = {5,10,15,20,25},
	
					}
					local datasource_files = makeURL({control='files',act='repository',build_id = id })
					dt.showDataTable(configs_files, columns_files, datasource_files, nil, extraFormatters)	
				%>
			</div>
		</div>					
		<script>
            var files = [];
		    function add_file(id, filename, category, autorun){
			     if(! files[id]){
					var checked = (filename == 'autorun.lua')?'checked':'';
					checked = (autorun)?'checked':'';
					
					$('#file_list').append('<tr id="line_'+id+'"><td align=center><input type=\'hidden\' name=\'file_id\' value="'+id+'" /><a href="#" onclick="remove_file(\''+id+'\');"><img src=\'images/buttons/cancel.png\' border=\'0\' style=\'vertical-align:middle;margin-right:5px;\' /></a></td><td align=center><input type="radio" name="autorun_file_id" value="'+id+'" '+checked+' onchange="toogle_check(this)" onclick="toogle_check(this)"></td><td>'+filename+'</td><td align=center>'+category+'</td></tr>');
		      		files[id] = true; 
			     }
		    }
		    function remove_file(id){
				$('#line_'+id).remove();
				files[id] = false; 
		    }
	    </script>
	</div>
</div>
<script>$("#files_list").draggable({ handle: '#title_flies_list' });</script>