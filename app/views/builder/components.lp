<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<h2><%= locale_components.target_title %> </h2>
<%= f.form({action = makeURL({control='builder',act='generate'})}) %>
	<%= f.hidden_field({name='build_id', value=id}) %>
	<label for="target"> <%= locale_components.labels.target %>:</label> 
	<div> <%= f.select({name='target',prompt = locale_components.target_prompt},BuilderModel.TARGETS) %></div><br>
	<h2><%= locale_components.component_title %> </h2>	
		<table class="table_center"> 
			<tbody> 
			<tr> 
				<th style="text-align: left;">Check</th> 
				<th style="text-align: center;">Components</th> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_xmodem'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_xmodem %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_shell'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_shell %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_romfs'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_romfs %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_term'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_term %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_uip'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_uip %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_dhcpc'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_dhcpc %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_dns'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_dns %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_con_generic'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_con_generic %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_con_tcp'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_con_tcp %>	</td> 
			</tr> 
			<tr> 
				<td class="espaco">
					<%= f.check_box({name='build_adc'},BuilderModel.CHECK_DEFAULT_VALUE) %>
				</td> 
				<td><%= locale_components.labels.build_adc %>	</td> 
			</tr>
		</table><br>
	<%= f.submit({value = locale_components.label_submit}) %>
<%= f.form_close() %>

<% render("footer.lp","_shared") %>
