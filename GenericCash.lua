local CashBank = {}

local starterCash = 50 -- only used if you don't provide loadData to :AddPlayer()


if not _G.cash then 
    _G.cash = {}
end

-- API code
function CashBank:CheckBalance(player)
    print(_G.cash[player])
	return _G.cash[player]
end

function CashBank:AddCash(player,cashToAdd)
    _G.cash[player] = _G.cash[player] + cashToAdd
end

function CashBank:AddPlayer(player,loadData)
	if loadData then
		--loadData coming from datastore
		_G.cash[player] = {}
		_G.cash[player] = loadData
	else
		_G.cash[player] = starterCash
	end
	
end

function CashBank:RemovePlayer(player)
	_G.cash[player] = nil	
end

function CashBank:CheckPurchase(player, cost)
	if _G.cash[player] >= cost then
		return true
	else
		return false
	end
end

function CashBank:SpendCash(player,cost)
	_G.cash[player] = _G.cash[player] - cost
	return _G.cash[player]
end

return CashBank
