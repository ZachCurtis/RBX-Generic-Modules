
November 2017
InfinityDesign's generic module scripts Ver 1.0
	
Contains:
	GenericCash !           	- simple money system
	GenericSkills !				    - simple RPG inspired skill system with character effects.
	GenericInventory !			  - simple unlimited inventory without item stacking
	GenericScopingDatastore 	- easy to use datastore methods based on player scoping
	
----------------------------------------------------------------------------------------------------------------------------------------	
	
	
How to use these modules: 
(http://wiki.roblox.com/index.php?title=API:Class/ModuleScript)

	'!' in 'Contains:' denotes that a new table entry must be made for each new player. 
	Use :AddPlayer() to create the table before attempting to interact with the data. 
	It's recommended that you call :AddPlayer() for all modules in use in a PlayerAdded event function after loading data.
	For every function with :AddPlayer(), there is also a :RemovePlayer() that you should call after saving data on PlayerRemoving.
	
----------------------------------------------------------------------------------------------------------------------------------------	
	
	
Recommended snytax:
	local GenericCash = require(script.GenericCash)
	GenericCash:AddPlayer(...)

	
----------------------------------------------------------------------------------------------------------------------------------------		
		
	
API:
	
	GenericCash:
		GenericCash:AddPlayer(player,loadData) - creates index for player. loadData expects an integer.
		GenericCash:CheckBalance(player)       - returns integer of player's balance
		GenericCash:AddCash(player,cashToAdd)  - adds integer cashToAdd to player's table
		GenericCash:CheckPurchase(player,cost) - check balance of player with item cost, return true/false
		GenericCash:SpendCash(player,cost)     - removes cash from players table. (contains a secondary CheckPurchase() to revalidate, not to use for player feedback)
		GenericCash:RemovePlayer(player)       - Cleans up table.
		
	GenericSkills:
		GenericSkills:AddPlayer(player, inputData) 	 	              - creates index for player. Expects a table 'inputData' from a datastore preformatted in the module
		GenericSkills:GetAllSkills(player)           	              - gets a table of skills. table structure is outlined internally.
		GenericSkills:GetSkillLevel(player, skillEnum)              - get a single skill level with a provided skillEnum integer (see below for enum list)
		GenericSkills:AddSkillLevel(player, skillEnum, levelsToAdd) - Adds levels to skill enum. 
		GenericSkills:SetCharacter(player)                          - Updates characters health and walkspeed relative to levels of strength and agility.
		GenericSkills:RemovePlayer(player)                          - Cleans up table.
		
	GenericInventory:
		GenericInventory:AddPlayer(player, loadData)      - creates index for player, expects table loadData.
		GenericInventory:GetInventory(player)             - returns a table of the inventory
		GenericInventory:AddItem(player, itemToAdd)       - add an item to player's inventory. itemToAdd expects an integer. 
		GenericInventory:RemoveItem(player, itemToRemove) - remove an item from player's inventory.
		GenericInventory:CheckOwned(player, itemToCheck)  - check if a player owns an item
		GenericInventory:RemovePlayer(player)             - Cleans up table.
	
	GenericScopingDatastore:
		GenericScopingDS:LoadDS(player)              - used internally to return player's datastore scope.
		GenericScopingDS:LoadData(player, key)       - preforms a GetAsync to the player's scope and provided key. Returns contained variable/table
		GenericScopingDS:SaveData(player, key, data) - saves varible/table data to provided key in players scope. Returns true if successful. Returns error if not.
	
		
----------------------------------------------------------------------------------------------------------------------------------------		
	
		
ModuleScripts with internal settings:

GenericCash:
	starterCash - Integer. only used if you don't provide loadData to :AddPlayer()
		
GenericSkills:
	skillsTemplate - a table of skill tables. Each skill table contains a starting level, then a maximum level, then the skill name
		
GenericScopingDatastore:
	datastoreName - a string of the name of the datastore. Changing this will erase all saved data. 
		
----------------------------------------------------------------------------------------------------------------------------------------			
		
		
Further detailing:
	player always refers to the player's refrence in game.Players.
	
GenericSkills contains two extra skills; dexterity and luck. These are not internally used.
	Skills can be added to GenericSkills if they follow the template format. Skill enums will always be corrolated to the position of the 
	skill's table.
	
GenericScopingDatastore does not provide any external data cache methods or request throttling. It's recommended that you only load/save 
	when players join, leave, or the server shuts down.
	
GenericInventory requires that item arguments always be an integer. This uses a sloppy method of using item id as table index. Will be
	corrected to be less awful and allow for item stacking in a future version. 
