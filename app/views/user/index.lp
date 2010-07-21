<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<div id="box_title"><%= locale_index.login_title %></div>
<!--[if IE 6]>  
       <div class="browser_msg"><img src="images/error_2.gif"><%=locale_index.browser_msg%></div>   
<![endif]-->
<div id="login_combo" class="<%= flash.get("validationMessages") == nil and "ok" or "fail" %>">

	<div id="bottom_text">
		<div id="login_box">
			<%= f.form({action=makeURL({control='user',act='authenticate'})}) %>
				<p><div> <%= locale_index.labels.login %>: </div> <%= f.text_field({class="field login_field", name='login',size=25}) %></p>
				<p><div> <%= locale_index.labels.passwd %>: </div> <%= f.password_field({class="field login_field", name="passwd", size=25}) %></p>
				<p><div class="button"><%= f.submit({value=locale_index.label_submit, class="button_submit"})%></div></p>
			<%= f.form_close() %>
		</div>
		<div class="links">
			<a href="<%= makeURL({control= "user", act="create"})%>">&raquo;&nbsp;<%=locale_index.labels.newuser%></a><br>
			<a href="<%= makeURL({control= "user", act="forgot_password"})%>">&raquo;&nbsp;<%=locale_index.labels.forgot_password%></a>
		</div>	
		<%= flash.get("validationMessages")%>
		<% if flash.get("notice") ~= nil then %>
			<div class="notice"> <%= flash.get("notice")%> </div>
		<% end %>
	</div>	
</div>
			
<% render("footer.lp","_shared") %>