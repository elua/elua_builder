-- User application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------

function index()
	render("index.lp")
end

function authenticate()
	user_aut = cgilua.POST
	local User = require "user.model"
	local val = require "validation"
	local validator = val.implement.new(user_aut)
	
	validator:validate('login',locale_register.validator.login, val.checks.isNotEmpty)
	validator:validate('passwd', locale_register.validator.passwd, val.checks.isNotEmpty)
	validator:validate('login',locale_register.validator.authenticate, function()
																	if val.checks.isNotEmpty(user_aut.login) and val.checks.isNotEmpty(user_aut.passwd)  then 
																		return User.checkUser(user_aut.login,user_aut.passwd)
																	else
																		return true
																	end
																end)
	
	if(validator:isValid())then
		User.authenticate(user_aut)
		flash.set('validationMessages',"")
		redirect({control="builder", act="index"})
	else
		flash.set('validationMessages',validator:htmlMessages())
		index()
	end
end

function logout()
	cgilua.cookies.delete ('system_cookie')
	redirect({control="user", act="index"})
end

function create()
	User = require "user.model"
	local users = User.getCurrentUser()
	if users ~= nil then
		user_obj = users
	end
	user = user_obj or {}
	render("create.lp")
end

function edit()
	User_Model = require "user.model"
	local users = User_Model.getCurrentUser()
	if users ~= nil then
		user_obj = users
	end
	user = user_obj or {}
	render("edit.lp")
end

function update()
	local UserModel = require "user.model"
	local current_user = UserModel.getCurrentUser()
	local user_obj = cgilua.POST
	--error(tableToString(user_obj))
	user_obj.login = current_user.login
	user_obj.id = current_user.id
	if (user_obj.change_passwd ~= "true")then
		user_obj.passwd = current_user.passwd
	end
	
	local val = require "validation"
	local validator = val.implement.new(user_obj)
	
	validator:validate('name',locale_register.validator.name,val.checks.isNotEmpty)
	
	validator:validate('email',locale_register.validator.email_none, val.checks.isNotEmpty)
	validator:validate('email',locale_register.validator.valid_email, val.checks.isEmail)
	--validator:validate('email',locale_register.validator.confirm_email, val.checks.isEqual,user_obj.co_email)
	
	validator:validate('login',locale_register.validator.login, val.checks.isNotEmpty)
	--validator:validate('login',locale_register.validator.login_min, val.checks.minLength,5)
	if (user_obj.change_passwd == "true")then
		validator:validate('passwd',locale_register.validator.passwd, val.checks.isNotEmpty)
		--validator:validate('passwd',locale_register.validator.passwd_min, val.checks.sizeString,5)
		validator:validate('passwd',locale_register.validator.confirm_passwd, val.checks.isEqual,user_obj.co_passwd)
	end	
	if user_obj.id == nil then
		validator:validate('login',locale_register.validator.checkNotExistLogin, UserModel.checkNotExistLogin)
	end
	
	if(validator:isValid())then
		UserModel.save(user_obj)
		flash.set('validationMessages',"")
		flash.set('notice',locale_register.validator.notice)
		redirect({control="builder", act="index"})
	else
		flash.set('validationMessages',validator:htmlMessages())
		edit()
	end
end

function register()
	user_obj = cgilua.POST
	local passwd = user_obj.passwd
	local val = require "validation"
	local UserModel = require "user.model"
   	local validator = val.implement.new(user_obj)
				
	validator:validate('name',locale_register.validator.name,val.checks.isNotEmpty)
	
	validator:validate('email',locale_register.validator.email_none, val.checks.isNotEmpty)
	validator:validate('email',locale_register.validator.valid_email, val.checks.isEmail)
	--validator:validate('email',locale_register.validator.confirm_email, val.checks.isEqual,user_obj.co_email)
	
	validator:validate('login',locale_register.validator.login, val.checks.isNotEmpty)
	--validator:validate('login',locale_register.validator.login_min, val.checks.minLength,5)
		
	validator:validate('passwd',locale_register.validator.passwd, val.checks.isNotEmpty)
	--validator:validate('passwd',locale_register.validator.passwd_min, val.checks.sizeString,5)
	validator:validate('passwd',locale_register.validator.confirm_passwd, val.checks.isEqual,user_obj.co_passwd)
	if user.id == nil then
		validator:validate('login',locale_register.validator.checkNotExistLogin, UserModel.checkNotExistLogin)
	end

	if(validator:isValid())then
		new_user, saved, err = UserModel.save(user_obj)
		--error(new_user)
		flash.set('validationMessages',"")
		flash.set('notice',locale_register.validator.notice)
		if (tonumber(new_user.id))then
			--error(user_obj.login.." "..user_obj.passwd)
			UserModel.authenticate({login = user_obj.login, passwd=passwd})
			redirect({control="builder", act="index"})
		end
	else
		flash.set('validationMessages',validator:htmlMessages())
		create()
	end
end


