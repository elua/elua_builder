<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

	<% for i,v in pairs(cgilua.POST) do %>
		<%= i %> : <%= v %> <BR>
	<% end %>
	
<% render("footer.lp","_shared") %>