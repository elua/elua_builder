-- User Suggestions application controller
--------------------------------------------------------------------
-- Using: Just define bellow lua functions required by the action
-- and if any was required, the 'index' function will be used.
--------------------------------------------------------------------

function index() 
	local UserModel = require "user.model"
	UserSuggestions = require "user_suggestion.model"
	current_user = UserModel.getCurrentUser()
	local user = user_suggestion or {}
	render("suggestions.lp")
end

function suggestion()
	suggestion = {}
	suggestion.description = cgilua.POST.description
	suggestion.suggestion_type_id = cgilua.POST.suggestion_type_id
	local UserSuggestions = require "user_suggestion.model"
	local UserModel = require "user.model"
	local current_user = UserModel.getCurrentUser()
	suggestion.user_id = current_user.id

	local val = require "validation"
	local validator = val.implement.new(suggestion)
	validator:validate('suggestion_type_id',locale_index.validator.suggestion_type, val.checks.isNotEmpty)
	validator:validate('description',locale_index.validator.description,  val.checks.isNotEmpty)
	
	if(validator:isValid())then
		UserSuggestions.save(suggestion)
		flash.set('suggestionMessages', locale_index.validator.suggestionMessages)
		redirect({control="builder", act="index"})
	else
		flash.set('suggestionMessages',validator:htmlMessages())
		index()
	end
end