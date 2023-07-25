local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")

local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PlayersManagerClass = CreateClass(require(script.PlayersManager))

local PlayersManager = PlayersManagerClass.new()
PlayersManager.Initiate()