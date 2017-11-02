local LevelSys = {}

if not _G.exp then
	_G.exp = {}
end

function LevelSys:AddPlayer(player, loadData)
	if loadData then
		_G.exp[player] = loadData
	else
		_G.exp[player] = 0
	end
end

function LevelSys:AddExp(player, expToAdd)
	local oldExp = _G.exp[player]
	local newExp = _G.exp[player] + expToAdd
	local oldLvl = self:GetLevel(oldExp)
	local newLvl = self:GetLevel(newExp)
	_G.exp[player] = newExp
	if oldLvl < newLvl then
		return true
	else
		return false
	end
end

function LevelSys:GetExp(player)
	return _G.exp[player]
end

function LevelSys:GetLevel(exp)
	local baseExp = 1000 --level 1 exp
	local factor = .8
	local level = math.floor((exp/baseExp)^factor)
	return level
end

function LevelSys:RemovePlayer(player)
	_G.exp[player] = nil
end

return LevelSys
