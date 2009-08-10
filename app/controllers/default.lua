-- Default application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------


function index()
  render("index.lp")
  
end

function redir()
redirect({control="default",act="teste",id=333,t=555})
end

function teste()
	cgilua.put("teste")
end
