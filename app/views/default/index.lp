<html>
<head>
    <title>MVC</title>
	  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	  <% loadCSS("css/style.css")%>

</head>
 <body >
 <H2>Hello to '<%= APP.controller %>' controller and '<%= APP.action %>' action page </h2><br/>
 Using lua <%= _VERSION %> version.
 
 <h2>CGILua Variables</h2>
<a href="<%= makeURL({control="default",act="teste",id=333,t=555})%>">aaaa</a>

<table border="1">
  <%
    local vars = {
        "script_file", "script_path", "script_pdir", "script_vdir", "script_vpath", "urlpath",
    }
    for _, v in ipairs(vars) do 
  %>
    <tr><td>cgilua.<%= v %></td><td><%= tostring(cgilua[v]) %></td></tr>
  <% end %>
</table>


<h2>Server Variables</h2>

<table border="1">
<%
local vars = {
    "SERVER_SOFTWARE", "SERVER_NAME", "SERVER_PROTOCOL", "SERVER_PORT",
    "GATEWAY_INTERFACE", "REQUEST_METHOD",
    "SCRIPT_NAME", "PATH_INFO", "PATH_TRANSLATED", "QUERY_STRING",
    "CONTENT_TYPE", "CONTENT_LENGTH", 
    "REMOTE_ADDR", "REMOTE_HOST", "REMOTE_USER", "REMOTE_IDENT",
    "AUTH_TYPE",
}
for _, v in ipairs(vars) do %>
  <tr><td><%= v %></td><td><%= tostring(cgilua.servervariable(v)) %></td></tr>
<% end %>
</table>

<%
local function showtable(t)
    cgilua.put "{"
    for i,v in pairs (t) do
        cgilua.put("\n")
        if type(v) == "table" then
            local vv = "{\n"
            for a,b in pairs(v) do
                vv = string.format ("%s  %s = [[%s]],\n", vv, a, tostring(b))
            end
            v = vv.." },"
            cgilua.put (string.format (" %s = %s", i, tostring(v)))
        else
            cgilua.put (string.format (" %s = [[%s]],", i, tostring(v)))
        end
    end
    if next(t) then
        cgilua.put "\n"
    end
    cgilua.put "}\n"
end
%>

<h2>cgilua.QUERY</h2>

<pre class="example">
<% showtable (cgilua.QUERY) %>
</pre>

</body>
</html>


