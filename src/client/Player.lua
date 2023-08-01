local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PlayerInst = game.Players.LocalPlayer

local InputControllerClass = CreateClass(require(script.Parent.InputController))
local MouseClass = CreateClass(require(script.Parent.Mouse))

return function(self)    

    
    self.Initiate = function()
        local InputController = InputControllerClass.new()
        InputController.Initiate()

        local Mouse = MouseClass.new()
        Mouse.Initiate()
    end
end
