local MarketplaceService = game:GetService("MarketplaceService")
local player = game.Players.LocalPlayer

script.Parent.Activated:Connect(function()
	MarketplaceService:PromptProductPurchase(player,1364364093)
end)
