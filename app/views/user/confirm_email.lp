<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<div id="box_title"><%= locale_index.labels.forgot_password %> </div>
<div id="notice"> 
	<%= flash.get("validationMessagesForgot")%>
	<%= flash.get("validationMessagesHash")%>
	<%= flash.get("email_reset")%>
</div>

<div id="forgot_password_combo">
	<div id="forgot_box">
		<!--[if IE]>  
    		<div style="height:10px"></div>
		<![endif]--> 
		<%= f.form({action=makeURL({control='user',act='forgot_password'})}) %>
			<%= locale_create.labels.email %>: <%= f.text_field({name='email',class="field name_field", value ='', maxlength = 80}) %> 
			<div class="forgot_button">
				<%= f.submit({value=locale_create.label_submit, class="button_submit"})%>
			</div>
		<%= f.form_close() %>
	</div><br><br>
	<div id="bottom_text" class="links">
			<a href="<%= makeURL({control= "user", act="index"})%>">&raquo;&nbsp;<%=locale_index.label_back%></a>
	</div>
</div>

<% render("footer.lp","_shared") %>