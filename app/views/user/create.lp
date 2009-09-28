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

<h2><%= locale_create.form_title %> </h2>

<%= flash.get("validationMessages")%>

<div class="link"><a href="<%= makeURL({control= "user", act="index"})%>"> <big><%=locale_index.label_back%></big> </a></div>
<div class="form">
<%= f.form({action=makeURL({control='user',act='register'})}) %>
		<div class="form_label"><%= locale_create.labels.name %>:<span class="required">*</span></span></div> <%= f.text_field({name='name', class="field login", value = user.name, maxlength = 80 }) %> <br><br>
		<div class="form_label"><%= locale_create.labels.email %>:<span class="required">*</span></div> <%= f.text_field({name='email',class="field login", value = user.email, maxlength = 80}) %> <br><br>
		<!--<div class="form_label"><%= locale_create.labels.co_email %>:<span class="required">*</span></div> <%= f.text_field({name='co_email',class="field login", value = user.email, maxlength = 80}) %> <br>-->
		<div class="form_label"><%= locale_create.labels.login %>:<span class="required">*</span></div> <%= f.text_field({name='login', class="field", value = user.login, maxlength = 10}) %> <br><br>
		<div class="form_label"><%= locale_create.labels.passwd %>:<span class="required">*</span></div> <%= f.password_field({name='passwd', class="field", value = user.password, maxlength = 12}) %> <br><br>
		<div class="form_label"><%= locale_create.labels.co_passwd %>:<span class="required">*</span></div> <%= f.password_field({name='co_passwd', class="field", value = "", maxlength = 12}) %> <br><br>
		<div class="form_label"><%= locale_create.labels.country %>:</div><%=f.select({name='country',prompt = locale_create.country_prompt}, User.COUNTRY, user.country)%> <br><br>
		<div class="form_label"><%= locale_create.labels.organization%>:</div> <%=f.select({name='organization', prompt = locale_create.organization_prompt, onchange="mainUses(this.value)"},User.ORGANIZATION, user.organization)%> <br><br>
		<span id="span_other" style="display:none"><div class="form_label"><%= locale_create.labels.other%>:</div> <%=f.text_area({name='other_use', prompt = locale_create.organization_prompt},user.other)%> <br><br></span>
		<div class="form_label"><%= locale_create.labels.remarks %>:</div><br> <%= f.text_area({name="remarks", class="text_area", value = user.remarks},user.remarks) %> <br><br>
</div> <br>
		<%= f.submit({value=locale_create.label_submit})%>
		<input type=reset value="<%=locale_create.label_clear%>"/>
<%= f.form_close() %>
<div class="link"><a href="<%= makeURL({control= "user", act="index"})%>"> <big><%=locale_index.label_back%></big> </a></div>

<% render("footer.lp","_shared") %>