<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<%= flash.get("validationMessages")%>
<p><b><%= flash.get("email_reset")%></b></p>
<%= f.form({action=makeURL({control='user',act='forgot_password'})}) %>
	<div class="form_label"><%= locale_create.labels.email %>:</div> <%= f.text_field({name='email',class="field login", value ='', maxlength = 80}) %> <br><br>
	<%= f.submit({value=locale_create.label_submit})%>
<%= f.form_close() %>

<% render("footer.lp","_shared") %>