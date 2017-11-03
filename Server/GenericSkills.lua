local GenericSkills = {}
--[[
	
	1 - Strength
	2 - Agility
	3 - Luck
	4 - Dexterity
	
--]]

local skillsTemplate = {
	{
		1,          -- current level
		99,         -- maximum level
		"Strength"  -- name
	},
	{
		1,          -- current level
		99,         -- maximum level
		"Agility"   -- name
	},
	{
		1,          -- current level
		99,         -- maximum level
		"Luck"      -- name
	}
	,
	{
		1,          -- current level
		99,         -- maximum level
		"Dexterity" -- name
	}
}
if not _G.skills then 
    _G.skills = {}
end

function GenericSkills:AddPlayer(player,loadData)
	--loadData coming from datastore
	_G.skills[player] = loadData or skillsTemplate
end

function GenericSkills:GetSkillLevel(player, skillEnum)
	if _G.skills[player] then
		return _G.skills[player][skillEnum][1]
	else
		self:AddPlayer(player)
	end
end

function GenericSkills:GetAllSkills(player)
	if _G.skills[player] then
		return _G.skills[player]
	else
		self:AddPlayer(player)
	end
end

function GenericSkills:AddSkillLevel(player,skillEnum,levelsToAdd)
	local newLvl = _G.skills[player][skillEnum][1] + levelsToAdd
	local maxLvl = _G.skills[player][skillEnum][2]
	if newLvl < maxLvl then
		_G.skills[player][skillEnum][1] = newLvl
	else
		_G.skills[player][skillEnum][1] = maxLvl
	end
end

function GenericSkills:SetCharacter(player)
	if _G.skills[player] then
		local char = player.Character
		local humanoid = char:FindFirstChild("Humanoid")
		local setHealth = 100 + (_G.skills[player][1][1] * .2)
		local setWalk = 16 + (_G.skills[player][2][1] * .1)
		
		humanoid.WalkSpeed = setWalk
		humanoid.MaxHealth = setHealth
		humanoid.Health = setHealth
		
	else
		self:AddPlayer(player)
		wait()
		self:SetCharacter(player)
	end
end

function GenericSkills:RemovePlayer(player)
	_G.skills[player] = nil	
end

return GenericSkills
