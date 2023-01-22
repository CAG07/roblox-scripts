
local currencyName = "Rings"

local Players = game:GetService("Players")
local DataStore = game:GetService("DataStoreService"):GetDataStore("TestDataStore")

game.Players.PlayerAdded:Connect(function(player)

	local folder = Instance.new("Folder")
	folder.Name = "leaderstats"
	folder.Parent = player

	local currency = Instance.new("IntValue")
        currency.Name = currencyName
	currency.Parent = folder
	--currency.Value = 50 Replaced with if else statement below, all new players get 50 rings

	local ID = currencyName.."-"..player.UserId
	local savedData = nil

	pcall(function()
		savedData = DataStore:GetAsync(ID)
	end)

	if savedData ~= nil then
		currency.Value = savedData
		print("Data loaded")
	else
		--New player
		currency.Value = 50
		print("New player")
	end

end)

game.Players.PlayerRemoving:Connect(function(player)
	local ID = currencyName.."-"..player.UserId
	DataStore:SetAsync(ID,player.leaderstats[currencyName].Value)
end)

game:BindToClose(function()

	-- When game is ready to shut down
	for i, player in pairs(game.Players:GetPlayers()) do
		if player then
			player:Kick("Game is shutting down")
		end
	end

	--task.wait(5) is no longer required for the last player because this issue is fixed

end)

--27:00
