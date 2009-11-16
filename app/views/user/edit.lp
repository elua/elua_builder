<% f = require "luawebforms" %>
<% render("header.lp","_shared") %>

<script>
	function changePasswd(field)
	{
		if(field.checked){
			$('passwd').disabled=false;
			$('co_passwd').disabled=false;
		}
		else{
			$('passwd').disabled=true;
			$('co_passwd').disabled=true;
		}
	}
	
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

<div id="box_title"><%= locale_create.form_title %></div>
<%= flash.get("validationMessages")%>

<div id="create_page">
	<%= f.form({action=makeURL({control='user',act='update'})}) %>
			<div class="form_label"><%= locale_create.labels.name %>:</div> <%= f.text_field({name='name',class="field name_field", value = user.name, maxlength = 80 }) %> <br><br>
			<div class="form_label"><%= locale_create.labels.email %>:</div> <%= f.text_field({name='email',class="field name_field", value = user.email, maxlength = 80}) %> <br><br>
			<div>
				<fieldset id="fieldset">
			  		<legend><%= f.check_box({name='change_passwd',value="1", onclick="changePasswd(this)"}, User_Model.CHECK_DEFAULT_VALUE)%>Change Password</legend><br><br>
					<label for="passwd"><div class="form_label"><%= locale_create.labels.passwd %>:</div></label>
			   		<%= f.password_field({name='passwd',class="field login_field", maxlength = 8, disabled=true}) %> <br><br>
			    	<label for="co_passwd"><div class="form_label"><%= locale_create.labels.co_passwd %>:</div></label>
			    	<%= f.password_field({name='co_passwd',class="field login_field", maxlength = 8,disabled=true}) %> <br><br>
			    </fieldset>
				<br>
			</div>
			<div class="form_label"><%= locale_create.labels.country %>:</div><%=f.select({name='country', class="select_field", prompt = locale_create.country_prompt}, User_Model.COUNTRY, user.country)%> <br><br>
			<div class="form_label"><%= locale_create.labels.organization%>:</div> <%=f.select({name='organization', class="select_field", prompt = locale_create.organization_prompt, onchange="mainUses(this.value)"},User_Model.ORGANIZATION, user.organization)%> <br><br>
			<span id="span_other" style="display:none"><div class="form_label"><%= locale_create.labels.other%>:</div> <%=f.text_area({name='other_use', prompt = locale_create.organization_prompt},user.other_use)%> <br><br></span>
			<div class="form_label"><%= locale_create.labels.remarks %>:</div><br> <%= f.text_area({name="remarks", class="field remarks_field", value = user.remarks},user.remarks) %> <br><br>
			<div class="create_button">
				<%= f.submit({value=locale_create.label_submit, class="button_submit"})%>
			</div>
	<%= f.form_close() %>
</div>
<div id="bottom_text" class="links">
	<a href="<%= makeURL({control= "builder", act="index"})%>">&raquo;&nbsp;<%=locale_index.label_back%></a>
</div>

<% render("footer.lp","_shared") %>