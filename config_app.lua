-- #### Application variables ###
CONFIG = {}
CONFIG.PATH = [[/var/www/eluabuilder/eluabuilder]]
CONFIG.APP_NAME = "elua_builder"
CONFIG.ENABLE_SESSIONS = true
CONFIG.MAX_FILE_SIZE = 60000 * 1024    -- in bytes
CONFIG.LANGUAGE     = "en-us"

-- enable this option when you want to use mapped URLs , like : "../app_name/controller/action/ID"
-- it is recommended that a rewrite rule is used, for example: "RewriteRule ^app_name/(.*)$ /cgi-bin/cgilua.cgi/app_name/web/start.lua?route=/$1 [L]"
CONFIG.ENABLE_MAPPED_URL = false

CONFIG.LIB_PATH     = CONFIG.PATH.."/lib/"
CONFIG.LUA_PATH     = CONFIG.LIB_PATH.."?/init.lua;"..CONFIG.LIB_PATH.."?/?.lua;"..CONFIG.LIB_PATH.."?.lua;"
package.path = CONFIG.LUA_PATH..[[/?.lua;]]..package.path

CONFIG.COOKIE_NAME = "app_onyx"
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
CONFIG.MVC_USERS = CONFIG.PATH.."/app/users/"


--MAIL Server Variables
CONFIG.MAIL_SERVER = {
    server = "localhost",
    user = "default@localhost",
    password = "",
    systemMailFrom = "admin@localhost",
    adminMailFrom = "admin@localhost",
    
    devMailFrom = "dev@localhost",
    devMailTo = "dev@localhost",
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
