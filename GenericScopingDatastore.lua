local PlayerScopeDS = {}

local dataBaseName = "MallTest" --change to reset saved data

local DataStoreService = game:GetService("DataStoreService")

function PlayerScopeDS:LoadDS(player) 
	local scope = "player_" .. player.UserId
	local dS = DataStoreService:GetDataStore(dataBaseName, scope)
	
	return dS
end

function PlayerScopeDS:LoadData(player, key)
	local dS = self:LoadDS(player)
	local data
	
	local success, errorMsg = pcall(function()
		data = dS:GetAsync(key)
	end)
	if success then
		return data
	else
		--notify player or maybe try again idk
	end
end

function PlayerScopeDS:SaveData(player, key, data)
	local dS = self:LoadDS(player)
	local success, errorMsg = pcall(function()
		dS:UpdateAsync(key,function(oldData)
			local newData = oldData
			newData = data
			return newData
		end)
	end)
	if success then
		return true
	else
		print(errorMsg)
	end
	
end
	

return PlayerScopeDS
