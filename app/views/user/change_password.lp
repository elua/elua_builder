<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<%= flash.get("validationMessagesHash")%>
<div id="box_title"><%= locale_index.labels.forgot_password %> </div>
<div id="create_page">
	<div class=""><%= locale_create.labels.email %>: <%= user.email%></div><br>
	<%= f.form({action=makeURL({control='user',act='forgot'})}) %>
		<%= f.hidden_field({name='user_hash', value=user.user_hash}) %>
		<div class=""><%= locale_create.labels.passwd %>:<span class="required">*</span></div> <%= f.password_field({name='passwd', class="field", maxlength = 12}) %> <br><br>
		<div class=""><%= locale_create.labels.co_passwd %>:<span class="required">*</span></div> <%= f.password_field({name='co_passwd', class="field", maxlength = 12}) %> <br><br>
		<%= f.submit({value=locale_create.label_submit})%>
	<%= f.form_close() %>
</div>

<% render("footer.lp","_shared") %>