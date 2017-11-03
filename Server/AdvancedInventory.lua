local AdvancedInv = {}
local invSource = require(script.AdvInvSource)

local sourceList = invSource:GetSource()


if not _G.advancedInv then
	_G.advancedInv = {}
end

function AdvancedInv:AddPlayer(player, loadData)
	_G.advancedInv[player] = loadData or invSource:GetStarter()
end

function AdvancedInv:RemovePlayer(player)
	_G.advancedInv[player] = nil
end

function AdvancedInv:CheckIfOwned(player, itemId)
	local inv = _G.advancedInv[player]
	for i = 1, #inv do
		if inv[1] == itemId then
			return true --player owns it, let's break the loop
		end
	end
	return false --player doesn't own it
end

function AdvancedInv:AddItem(player, itemId)
	if itemId == sourceList[itemId][1] and _G.advancedInv[player] then --cross refrence to ensure index matches id
		if sourceList[itemId][6] == false then
			local check = self:CheckIfOwned(player, itemId)
			return false
		end
		table.insert(_G.advancedInv[player], itemId)
		return true
	else
		return false
	end
end

function AdvancedInv:RemoveItem(player, itemId)
	local inv = _G.advancedInv[player]
	for i = 1, #inv do
		if inv[1] == itemId then
			table.remove(inv, i)
			return true
		end
	end
	return false --player doesn't own it so we cant remove it
end

function AdvancedInv:GetInventory(player, sortMethod)
	if sortMethod == "numerical" then
		local sortedTable = _G.advancedInv[player]
		table.sort(sortedTable)
		return sortedTable
	elseif sortMethod == "rarity" then
		local startTable = _G.advancedInv[player]
		local sortedTable = {}
		for i = 1, #startTable - 1 do
			local currentId = startTable[i]
			local t = i
			repeat
				wait()
				t = t - 1
			until
			t < 1 or sourceList[startTable[t]][7] <= sourceList[currentId][7]
			table.insert(sortedTable, t + 1, currentId)
		end
	elseif sortMethod == "raw" then
		return _G.advancedInv[player]
	end
end

function AdvancedInv:GetGroupFromSource(group)
	local sorted = {}
	for i = 1, #sourceList do
		if sourceList[i][7] == group then
			table.insert(sorted, sourceList[i][1])
		end
	end
	return sorted
end

function AdvancedInv:GetItemInfo(itemId)
	local item = sourceList[itemId]
	if item then
		local id, name, desc, cost, ref, canStack, rarity, itemGroup, thumbnail = item[1], item[2], item[3], item[4], item[5], item[6], item[7], item[8], item[9]
		return id, name, desc, cost, ref, canStack, rarity, itemGroup, thumbnail
	end
end

function AdvancedInv:GetItemIdByName(name)
	for i = 1, #sourceList do
		if sourceList[i][2] == name then
			return sourceList[i][1]
		end
	end
end

return AdvancedInv
