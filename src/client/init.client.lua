
local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)

local CreateDataDisplayGuisClass = CreateClass(require(script.CreateDataDisplayGuis))
local PlayerClass = CreateClass(require(script.Player))

local Player = PlayerClass.new()
Player.Initiate()

local CreateDataDisplayGuis = CreateDataDisplayGuisClass.new()
CreateDataDisplayGuis.LoadDataDisplayers()

