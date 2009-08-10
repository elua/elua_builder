local function route_match(url, pattern)
    local params = {}
    local captures = string.gsub(pattern, "(/$[%w_-]+)", "/([^/]*)")
    local url_parts = {string.match(url, captures)}
    local i = 1
    for name in string.gmatch(pattern, "/$([%w_-]+)") do
        params[name] = url_parts[i]
        i = i + 1
    end
    return next(params) and params
end

local function complete_route()
  local query_route_var = "route"
  local query_route = cgilua.QUERY[query_route_var]
  if(query_route ~= "" and query_route ~= nil and query_route ~= "/")then
    local route_table =  route_match(cgilua.QUERY.route,"/$control/$act/$id") or route_match(cgilua.QUERY.route,"/$control/$act") or route_match(cgilua.QUERY.route,"/$control") 
    for i,v in pairs(route_table)do
      cgilua.QUERY[i] = v
    end
  end
end

complete_route()