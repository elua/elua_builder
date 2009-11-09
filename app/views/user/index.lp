<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>


		<div id="box_title">
			<div id="title"><%= locale_index.login_title %></div>
			<div id="login_combo" class="<%= flash.get("validationMessages") == nil and "ok" or "fail" %>">
				<%= flash.get("validationMessages")%>
				<% if flash.get("notice") ~= nil then %>
					<div class="notice"> <%= flash.get("notice")%> </div>
				<% end %>
				<div id="bottom_text">
					<div id="login_box">
						<%= f.form({action=makeURL({control='user',act='authenticate'})}) %>
							<p><div> <%= locale_index.labels.login %>: </div> <%= f.text_field({class="field", name='login',size=25}) %></p>
							<p><div> <%= locale_index.labels.passwd %>: </div> <%= f.password_field({class="field", name="passwd", size=25}) %></p>
							<p><div class="button"><%= f.submit({value=locale_index.label_submit, class="button_submit"})%></div></p>
						<%= f.form_close() %>
					</div>
					<div class="links">
						<a href="<%= makeURL({control= "user", act="create"})%>">&raquo;&nbsp;<%=locale_index.labels.newuser%></a><br>
						<a href="<%= makeURL({control= "user", act="forgot_password"})%>">&raquo;&nbsp;<%=locale_index.labels.forgot_password%></a>
					</div>
					
				</div>
				
			</div>
		</div>





<% render("footer.lp","_shared") %>