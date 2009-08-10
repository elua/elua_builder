local oo = require "oo"
local require = require
---------------------------------------------------------------------
--- Lua DataTable is a library developed to easily manipulate the Yahoo Datatable component.
--  @release $Id: datatable.lua,v 1.0 2009/02/19 Vagner Nascimento Exp $
---------------------------------------------------------------------
-- <h2>Dependencies</h2>
-- DataTable has dependencies with two libraries:<BR>
-- <ul><li>SOOL - Simple Object Oriented for Lua - <a href='http://luaforge.net/projects/sool' target='_blank'>http://luaforge.net/projects/sool</a></li>
-- <li>Lua4Json - <a href='http://luaforge.net/projects/luajson' target='_blank'>http://luaforge.net/projects/luajson</a></li></ul>
-- <h2>Reference</h2>
-- To know more about YUI DataTable and see usage examples visit <a href='http://developer.yahoo.com/yui/datatable/' target='_blank'>http://developer.yahoo.com/yui/datatable/</a>
module ("dataTable", oo.package())

repository     = require "dataTable.repository"
show		   = require "dataTable.show"



