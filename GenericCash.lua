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
	_G.cash[player] = loadData or starterCash
end

function CashBank:RemovePlayer(player)
	_G.cash[player] = nil	
end

function CashBank:CheckPurchase(player, cost)
	return _G.cash[player] >= cost and true or false
end

function CashBank:SpendCash(player,cost)
	_G.cash[player] = _G.cash[player] - cost
	return _G.cash[player]
end

return CashBank
