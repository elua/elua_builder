<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<h2><%= locale_index.login_title %> </h2>
<% if flash.get("notice") ~= nil then %>
<br>
	<div class="notice"> <%= flash.get("notice")%> </div>
<br>
<% end %>
<%= flash.get("validationMessages")%>
	<%= f.form({action=makeURL({control='user',act='authenticate'})}) %>
		<div class="form_label"> <%= locale_index.labels.login %>: </div> <%= f.text_field({class="field", name='login',size=10}) %> <br><br>
		<div class="form_label"> <%= locale_index.labels.passwd %>: </div> <%= f.password_field({class="field", name="passwd"}) %> <br> <br> 
		<%= f.submit({value=locale_index.label_submit})%>
	<%= f.form_close() %>
<br><br>
<a href="<%= makeURL({control= "user", act="create"})%>"> <%=locale_index.labels.newuser%> </a> 

<% render("footer.lp","_shared") %>