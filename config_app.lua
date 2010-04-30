-- #### Application variables ###
CONFIG = {}
CONFIG.PATH = [[/var/www/led/carlos/elua_builder]]
CONFIG.APP_NAME = "carlos-elua_builder"
CONFIG.ENABLE_SESSIONS = true
CONFIG.MAX_FILE_SIZE = 60000 * 1024    -- in bytes
CONFIG.LANGUAGE     = "en-us"

-- enable this option when you want to use mapped URLs , like : "../app_name/controller/action/ID"
-- it is recommended that a rewrite rule is used, for example: "RewriteRule ^app_name/(.*)$ /cgi-bin/cgilua.cgi/app_name/web/start.lua?route=/$1 [L]"
CONFIG.ENABLE_MAPPED_URL = false

CONFIG.LIB_PATH     = CONFIG.PATH.."/lib/"
CONFIG.LUA_PATH     = CONFIG.LIB_PATH.."?/init.lua;"..CONFIG.LIB_PATH.."?/?.lua;"..CONFIG.LIB_PATH.."?.lua;"
package.path = CONFIG.LUA_PATH..[[/?.lua;]]..package.path

CONFIG.COOKIE_NAME = "complement"
CONFIG.MD5KEY = "lua-kepler"


-- ### MVC Definitions ###
CONFIG.MVC_LIB = CONFIG.PATH.."/app/lib/"
CONFIG.MVC_CONTROL = CONFIG.PATH.."/app/controllers/"
CONFIG.MVC_VIEW    = CONFIG.PATH.."/app/views/"
CONFIG.MVC_MODEL = CONFIG.PATH.."/app/models/"
CONFIG.MVC_LOCALE = CONFIG.PATH.."/app/locale/"
CONFIG.MVC_WEB = CONFIG.PATH.."/app/web/"
CONFIG.MVC_TEMPLATES = CONFIG.PATH.."/app/templates/"
CONFIG.MVC_TMP = CONFIG.PATH.."/tmp/"
CONFIG.MVC_REPORTS = CONFIG.PATH.."/app/reports/"
CONFIG.MVC_USERS = CONFIG.PATH.."/users/"
CONFIG.ELUA_BASE = CONFIG.PATH.."/elua_src_base/"
CONFIG.MVC_ROMFS = CONFIG.PATH.."/suggested_files/"
CONFIG.APP_DOMAIN = "ubuntu/carlos-elua_builder/start.lua"



--MAIL Server Variables
CONFIG.MAIL_SERVER = {
    server = "192.168.100.105",
    user = "gsanchez@192.168.100.105",
    password = "Nosso lab",
    systemMailFrom = "carlos.deodoro@gmail.com",
    adminMailFrom = "carlos.deodoro@gmail.com",
    
    devMailFrom = "carlos.deodoro@gmail.com",
    devMailTo = "carlos.deodoro@gmail.com",
    environment = "DEVELOPMENT" -- Accepts "DEVELOPMENT" or "PRODUCTION"
}

-- DATABASE DEFINITIONS

CONFIG.DB = {
    server = "localhost",
    dbname = "eluabuilder",
    username = "eluabuilder",
    password = "eluabuilder",
    driver = "mysql"
}

dofile("../extra_cgilua_cfg.lua")
