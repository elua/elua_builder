local cgilua, require, error, pairs, string, tostring, type, next, table,print, tonumber = cgilua, require, error, pairs, string, tostring, type, next, table,print, tonumber
local sool = require "sool"
local attr = attr
local mapper = mapper
local db = db
local sqlI = require "sqlInjection"
local md5 = require "md5"
local CONFIG = CONFIG 
local APP = APP
local showDate = showDate
local populateTable = populateTable
local USER_AUTH = USER_AUTH

-- Project application Model

module("project.model", sool.class())

Project = mapper:new('projects')
ProjectUser = mapper:new('project_user')

function new(values)
	local object = create()
	attr(object,values)
	return object
end

local function formatProjectDates(row)
	row.actual_start_dt = showDate(string.sub(row.actual_start_dt or "",1,10), "yyyy-mm-dd") or ""
	row.actual_end_dt = showDate(string.sub(row.actual_end_dt or "",1,10), "yyyy-mm-dd") or ""
	row.scheduled_start_dt = showDate(string.sub(row.scheduled_start_dt or "",1,10), "yyyy-mm-dd") or ""
	row.scheduled_end_dt = showDate(string.sub(row.scheduled_end_dt or "",1,10), "yyyy-mm-dd") or ""
end

function getSituations()
	local situations = db:selectall("*","situations")
	return situations
end


function getProjects(params,sort,desc)
	local query = ""
	if (tonumber(USER_AUTH.administrator) ~= 1)then
		query = " inner join project_user pu on pu.project_id = p.id and pu.user_id = ".. sqlI.sqlInjection(USER_AUTH.id,"number")
	end
	local projects = db:selectall([[p.id, p.situation_id, p.name, p.symbol, p.description, p.location, p.actual_start_dt, 
								p.actual_end_dt, p.scheduled_start_dt, p.scheduled_end_dt, p.estimated_cost, 
								p.effective_cost, p.created_at, s.name as situation]],
						"projects p inner join situations s on p.situation_id = s.id".. query
					)
	for i,v in pairs(projects)do
		formatProjectDates(v)
	end
	return projects
end

function getProject(id)
	local result = {}
	if(tonumber(id))then
		
		result = db:selectall(
						"p.id, p.situation_id, p.name, p.symbol, p.description, p.location, p.actual_start_dt, p.actual_end_dt, p.scheduled_start_dt, p.scheduled_end_dt, p.estimated_cost, p.effective_cost, p.created_at, s.name as situation",
						"projects p inner join situations s on p.situation_id = s.id",
						"p.id = ".. sqlI.sqlInjection(id,"number")
					)
	end
	if #result == 1 then
		formatProjectDates(result[1])
		return result[1]
	else
		return {}
	end
end

function remove(self, params)
	if(tonumber(params.id)) then
		local msg = ""
		--msg = msg..db:delete("projects","id = "..sqlI.sqlInjection(params.id,"number"))

		--deleting responsibles
		msg = msg..db:delete("responsibles", "activity_id in (select a.id from activities a inner join groups g on a.group_id = g.id inner join projects p on g.project_id = p.id where p.id = "..sqlI.sqlInjection(params.id,"number")..")")

		--deleting reports
		msg = msg..db:delete("reports", "activity_id in (select a.id from activities a inner join groups g on a.group_id = g.id inner join projects p on g.project_id = p.id where p.id = "..sqlI.sqlInjection(params.id,"number")..")")	

		--deleting activities		
		msg = msg..db:delete("activities", "group_id in (select id from groups where project_id = "..sqlI.sqlInjection(params.id,"number")..")")

		--deleting groups
		msg = msg..db:delete("groups", "project_id = "..sqlI.sqlInjection(params.id,"number"))	

		--deleting users
		msg = msg..db:delete("project_user", "project_id = "..sqlI.sqlInjection(params.id,"number"))	

		--deleting documents
		msg = msg..db:delete("documents", "project_id = "..sqlI.sqlInjection(params.id,"number"))	
		
		--finally, deleting the project
		msg = msg..db:delete("projects", "id = "..sqlI.sqlInjection(params.id,"number"))	
	
		if(msg)then
			return true
		else
			return false , msg
		end
	end
end

function save(params)
	params = populateTable(params)

	local project = Project:new(params)
	
	proj, saved, err = project:save()
	return proj, saved, err 
end

function getParticipants(params,sort,dir)
	if(tonumber(params.project_id))then

		local participants = db:selectall(
							 "pu.id,u.full_name, u.email, pf.name as profile_name, p.name as project_name, pu.project_id",
							 [[users u inner join project_user pu on pu.user_id = u.id
							   inner join projects p on p.id = pu.project_id
							   inner join profiles pf on pf.id = pu.profile_id]],
							   "pu.project_id = " .. sqlI.sqlInjection(params.project_id,"number")
							)
		return participants
	end
	return {}
end

function getParticipant(id)
	if(tonumber(id))then
		local participant = db:selectall(
							 "pu.id,u.full_name, u.email, pf.name as profile_name, p.name as project_name, pu.project_id",
							 [[users u inner join project_user pu on pu.user_id = u.id
							   inner join projects p on p.id = pu.project_id
							   inner join profiles pf on pf.id = pu.profile_id]],
							   "pu.id = " .. sqlI.sqlInjection(id,"number")
							)
		return participant[1]
	end
end

function removeParticipant(id)
	if(tonumber(id)) then
		local msg = db:delete("project_user","id = "..sqlI.sqlInjection(id,"number"))
		if(msg)then
			return true
		else
			return false , msg
		end
	end
end

function addParticipant(params)
	local project_user = ProjectUser:new(params)
	proj, saved, err = project_user:save()
	return proj, saved, err 
end
