  require "luarocks.require"
  require"cgilua"
  require"cgilua.cookies"

  local max_file_size = CONFIG.MAX_FILE_SIZE or (1024 * 1024)
  cgilua.setmaxfilesize(max_file_size)
  cgilua.setmaxinput(max_file_size)
  
  -- Basic configuration for using sessions  
  if(CONFIG.ENABLE_SESSIONS ~= nil and CONFIG.ENABLE_SESSIONS)then
    require"cgilua.session"
    cgilua.session.setsessiondir (CONFIG.MVC_TMP)
   
    -- The following function must be called by every script that needs session.
    local already_enabled = false
    function cgilua.enablesession ()
     if already_enabled then
        return
      else
        already_enabled = true
      end
      cgilua.session.open ()
      cgilua.addclosefunction (cgilua.session.close)
    end
  end