local Inventory = {}

if not _G.inv then 
    _G.inv = {}
end

function Inventory:AddPlayer(player,loadData)
	--loadData coming from datastore
	_G.inv[player] = loadData or {}
end

function Inventory:GetInventory(player)
	return _G.inv[player]
end

function Inventory:AddItem(player, itemToAdd)
	table.insert(_G.inv[player], itemToAdd)
end

function Inventory:RemoveItem(player, itemToRemove)
	for i = 1, #_G.inv[player] do
		if _G.inv[player][i] == itemToRemove then
			table.remove(_G.inv[player], i)
			break
		end
	end
end

function Inventory:CheckOwned(player, itemToCheck)
	local check = false
	for i = 1, #_G.inv[player] do
		if _G.inv[player][i] == itemToCheck then
			check = true
			break
		end
	end
	return check
end

function Inventory:RemovePlayer(player)
	_G.inv[player] = nil	
end

return Inventory
