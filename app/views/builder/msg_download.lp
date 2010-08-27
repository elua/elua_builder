<div id="boxes">
	<div id="msg_build_generated" class="window msg_build_generated">
		<div class="close_button">
			<a href="#"><img src="images/buttons/logout.png" title="<%=locale_index.label_close%>" border="0", onclick="msg_build_generated();"></a>
		</div>
		<div class="close_msg_build_generated">
			<%= flash.get("copyFileMessages")%>
			<%= flash.get("copyErrorsMessages")%>
		</div>
		<div class="button_download">
			<a href="<%= makeURL({control= "builder", act="download_binary_log", id=flash.get("build_id"), nfile=flash.get("nfile")})%>">
				<img name='download' src="images/buttons/download_binary_log.png" border='0' label='<%=locale_index.label_download%>'><br>
				<b><%=locale_index.download_binary_log%></b>
			</a>
		</div>	
	</div>
	<div id="mask"></div>
</div>
