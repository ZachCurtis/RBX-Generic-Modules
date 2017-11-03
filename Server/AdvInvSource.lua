local InvSource = {}

local starterTemplate = {}

local inventorySource = {
	{
		1,                                                          -- itemId
		"Shovel",                                                   -- itemName
		"Useful for digging holes",									-- itemDesc
		50,                                                         -- itemCost
		false,                                                      -- allow owned duplicates (stacking)
		game.ReplicatedStorage.ItemModels:FindFirstChild("Shovel"), -- model refrence for dropping. if none then set false to prevent attempted drops
		5,                                                          -- rarity rating for drops (1-100 where 1 is common and 100 is rare)
		"UtilityTool",                                              -- item grouping for location specific drops
		1251038                                                     -- assetId of decal for thumbnail. Only numbers as it's later formatted.
	},
	{
		2,
		"Pickaxe",
		"Useful for breaking rock",	
		125,
		false,
		false,
		10,
		"UtilityTool",
		1251038
	}
}

function InvSource:GetSource()
	return inventorySource
end

function InvSource:GetSarter()
	return starterTemplate
end

return InvSource
