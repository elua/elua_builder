<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
	<title><%= locale_general.page_title %></title>
	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
	<META HTTP-EQUIV="Expires" CONTENT="-1">
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<link href='favicon.ico' rel='icon' type='image/vnd.microsoft.icon'/>
	<!-- <link rel='icon' href='/animated_favicon1.gif' type='image/gif' /> -->
	<%
	-- loadCSS("lib/yui/css/reset.css")
	%>
	<% loadCSS("css/style.css")%>
	<% loadJS('js/common.js') %>
	<% if jquery then %>
		<% loadJS('lib/jquery/jquery-1.3.2.min.js')%>
		<% loadJS('lib/jquery/ui.core.js')%>
		<% loadJS('lib/jquery/ui.tabs.js')%>
		<% loadCSS('lib/jquery/css/ui.all.css')%>
		<% loadJS('lib/jquery/ui.draggable.js') %>
		<% loadJS('lib/jquery/jQuery.bubbletip-1.0.6.js') %>
		<% loadCSS('lib/jquery/bubbletip/bubbletip.css')%>
		<% loadCSS('lib/jquery/bubbletip/bubbletip-IE.css')%>
	<!--<% loadJS('lib/jquery/uploadify/jquery.uploadify.v2.1.0.js')%>
		<% loadJS('lib/jquery/uploadify/swfobject.js')%>
		<% loadCSS('lib/jquery/uploadify/uploadify.css')%> -->
		<% loadJS('lib/jquery/jqModal.js') %>
		<% loadCSS('lib/jquery/css/jqModal.css')%>
		
		<% loadCSS('css/plupload.css')%>
		<% loadJS('lib/jquery/plupload/js/gears_init.js') %>
		<% loadJS('lib/jquery/plupload/js/plupload.browserplus.min.js') %>
		<% loadJS('lib/jquery/plupload/js/plupload.full.min.js') %>
		<% loadJS('lib/jquery/plupload/js/jquery.plupload.queue.min.js') %>
		
		
	<% else %>
		<% loadJS('lib/prototype-1.6.0.2.js') %>
		<% loadJS('lib/effects.js') %>
	<% end %>

</head>
<body>

<div id="block">

	<!-- Logo -->
	<div class="logo"><a href="<%= makeURL({control="builder", act="index"})%>"><img src="images/logo.png" label="<%=locale_index.labels.home%>" border=0></a></div>
	<!-- Central Box -->
	<% if  logged_user then %>
		<div class="links_right">
			<div class="hello"><%=locale_index.labels.greeting%>, <%= logged_user.name %></div>
			<a href="<%= makeURL({control="user", act="edit"})%>"> <img src="images/buttons/account.png" border=0>&nbsp; <%=locale_index.labels.edit_account%></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
			<a href="<%= makeURL({control="user", act="logout"})%>"><img src="images/buttons/logout.png" border=0>&nbsp; <%=locale_index.labels.logout%></a>				
		</div>
	<%end%>
	
	<div id="top_block"></div>
	<div id="bg_block">
		