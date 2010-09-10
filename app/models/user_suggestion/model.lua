-- User Suggestion application Model

module("user_suggestion.model", package.seeall)

require("md5")
sqlI = require "sqlInjection"
User = mapper:new("users")
UserSuggestions = mapper:new("user_suggestions")

function save(values)
	values.user_id = tonumber(values.user_id)
	values.suggestion_type_id = tonumber(values.suggestion_type_id)
	local user_suggestions = UserSuggestions:new(values)
	user_suggestions:save()
	return user_suggestions
end

SUGGESTION_TYPE = {
					{value="1",option="Suggestion", disabled = false},
					{value="2",option="Question", disabled = false},
					{value="3", option="Issue", disabled = false},
					{value="4", option="Bug report", disabled = false},
					{value="5", option="Abuse report", disabled = false},
					{value="6", option="Other", disabled = false},
}
