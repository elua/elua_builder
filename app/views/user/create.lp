<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<script>
	function mainUses(value)
	{
		if(value == "Other"){
			$('span_other').style.display = "block";
		}
		else
		{
			$('span_other').style.display = "none";
		}
	}
</script>

<div id="box_title"><%= locale_create.form_title %> </div>
<%= flash.get("validationMessages")%> 

<div id="create_page">
	<%= f.form({action=makeURL({control='user',act='register'})}) %>
		<div class=""><%= locale_create.labels.name %>:<span class="required">*</span></span></div> <%= f.text_field({name='name', class="field name_field", value = user.name, maxlength = 80 }) %> <br><br>
		<div class=""><%= locale_create.labels.email %>:<span class="required">*</span></div> <%= f.text_field({name='email',class="field name_field", value = user.email, maxlength = 80}) %> <br><br>
		<div class=""><%= locale_create.labels.login %>:<span class="required">*</span></div> <%= f.text_field({name='login', class="field login_field", value = user.login, maxlength = 30}) %> <br><br>
		<div class=""><%= locale_create.labels.passwd %>:<span class="required">*</span></div> <%= f.password_field({name='passwd', class="field login_field", value = user.password, maxlength = 12}) %> <br><br>
		<div class=""><%= locale_create.labels.co_passwd %>:<span class="required">*</span></div> <%= f.password_field({name='co_passwd', class="field login_field", value = "", maxlength = 12}) %> <br><br>
		<div class=""><%= locale_create.labels.country %>:</div><%=f.select({name='country', class="select_field", prompt = locale_create.country_prompt}, User.COUNTRY, user.country)%> <br><br>
		<div class=""><%= locale_create.labels.organization%>:</div> <%=f.select({name='organization', class="select_field", prompt = locale_create.organization_prompt, onchange="mainUses(this.value)"},User.ORGANIZATION, user.organization)%> <br><br>
		<span id="span_other" style="display:none"><div class="form_label"><%= locale_create.labels.other%>:</div> <%=f.text_area({name='other_use', class="field", prompt = locale_create.organization_prompt},user.other)%> <br><br></span>
		<div class=""><%= locale_create.labels.remarks %>:</div><br> <%= f.text_area({name="remarks", class="field remarks_field", value = user.remarks},user.remarks) %> <br><br>
		<div class="create_button">
			<%= f.submit({value=locale_create.label_submit, class="button_submit"})%>
			<input type=reset value="<%=locale_create.label_clear%>" class="button_submit"/>
		</div>
	<%= f.form_close() %>
	<div id="bottom_text" class="links">
		<a href="<%= makeURL({control= "user", act="index"})%>">&raquo;&nbsp;<%=locale_index.label_back%></a>
	</div>
</div>

<% render("footer.lp","_shared") %>