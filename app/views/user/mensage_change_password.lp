<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<div id="box_title"><%= locale_index.labels.forgot_password %> </div>

<div id="notice"> 
	<%= flash.get("validationMessages")%>
</div>

<% render("footer.lp","_shared") %>