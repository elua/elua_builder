		
	</div>
	<div id="footer">
		<div class="hr1"></div>
		<% if  (logged_user) then %>
			<div class="elua_logo">
				<a href="http://www.eluaproject.net" target="_blank"><img src="images/eLua_logo.png" border=0><%=locale_general.copyright%></a>
				<div class="suggestions_icon">
					<a href="<%= makeURL({control= "user_suggestions", act="index"})%>">
						<img src="images/mail.png" border=0 alt="<%=locale_index.labels.suggestion%>" title="<%=locale_index.labels.suggestion%>">
						<%=locale_index.labels.suggestion%>
					</a>
				</div>
			</div>
		<%else%>
			<div class="elua_logo">
				<a href="http://www.eluaproject.net" target="_blank"><img src="images/eLua_logo.png" border=0><%=locale_general.copyright%></a>
			</div>
		<%end%>
	</div>
	<div id="bottom_block">	</div>
</div>
	<div id="ajax-indicator" style="display:none;"><span>Carregando...</span></div>

</body>
</html>
