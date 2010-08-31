<% f = require "luawebforms" %>
<% dt = require("dataTable.show")%>

<% render("header.lp","_shared") %>

<div id="box_title"><%= locale_index.suggestion_title %> </div>

<%= flash.get('suggestionMessages') %>

<div id="create_page">
	<%= f.form({action=makeURL({control='user_suggestions',act='suggestion'})}) %>
		<%= locale_index.labels.suggestion_type %>:
		<p><%= f.select({name='suggestion_type_id', class="select_field", prompt=locale_index.suggestion_type_prompt},UserSuggestions.SUGGESTION_TYPE, user.suggestion_type_id) %></p>
		<%= locale_index.labels.description %>:
		<p><%= f.text_area({name='description', class="field remarks_field", value=user.description}) %></p>
	<div class="suggestion_button">
		<%= f.submit({value=locale_index.label_submit, class="button_submit"})%>
	</div>
	<%= f.form_close() %>
</div>

<% render("footer.lp","_shared") %>