<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><%= locale_general.page_title %></title>
	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	
	<% loadCSS("css/style.css")%>
	<% loadJS('js/common.js') %>
</head>
<body>
	<div id="block">
	<!-- Logo -->
	<div class="logo"><a href="<%= makeURL({control="builder", act="index"})%>"><img src="images/logo.png" label="<%=locale_index.labels.home%>" border=0></a></div>
	<!-- Central Box -->
	<div id="top_block"></div>
	<div id="bg_block">
		<div class='friendly_error'><img src="images/error.png"></div>
		<div class='friendly_error_msg'><%=locale_general.friendly_error_msg%></div>
	</div>
	<div id="footer">
		<div class="hr1"></div>
		<%=locale_general.copyright%>
	</div>
	<div id="bottom_block">	</div>
</div>
	<div id="ajax-indicator" style="display:none;"><span>Carregando...</span></div>

</body>
</html>