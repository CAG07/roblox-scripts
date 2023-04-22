local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")

local currencyName = "Rings"

local PreviousPurchases = DataStoreService:GetDataStore("PreviousPurchases")

local one_hundred_rings = 1364364093

MarketplaceService.ProcessReceipt = function(receipt)

	--Receipt has PurchaseID, PlayerID, ProductID, CurrencySpentValue, CurrencyType, PlaceIdWherePurchased

	local ID = receipt.PlayerId.."-"..receipt.PurchaseID

	local success = nil

	pcall(function()
		success = PreviousPurchases:GetAsync(ID)
	end)

	if success then -- Has it already been bought?
		-- Purchased already
		return Enum.ProductPurchaseDecision.PurchaseGranted
	end

	local player = game.Players:GetPlayerByUserId(receipt.PlayerId)

	if not player then
		-- Left, disconnected
		return Enum.ProductPurchaseDecision.NotProcessedYet
	else
		if receipt.ProductId == one_hundred_rings then
			--Player bought 100 rings
			player.leaderstats[currencyName].Value = player.leaderstats[currencyName].Value + 100
		end

		--Add the previous if then statement for any additional currency variables

		pcall(function()
			PreviousPurchases:SetAsync(ID,true)
		end)
		return Enum.ProductPurchaseDecision.PurchaseGranted

	end
end
