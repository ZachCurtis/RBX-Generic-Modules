local Preloader = {}
local contentSP = game:GetService("ContentProvider")

function Preloader:PreloadAssets(assetList)
	spawn(function() --create a seperate thread to not interfer with QueLength
		contentSP:PreloadAsync(assetList)
		return true --preloadAsync yeilds the thread so this wont return true until it's done loading
	end)
end

function Preloader:GetQueueLength()
	return contentSP.RequestQueueSize
end

function Preloader:GetBaseUrl()
	return contentSP.BaseUrl --honestly not sure if this will ever return anything other than roblox.com
end

return Preloader
