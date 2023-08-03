local CreateClass = require(game.ReplicatedStorage.Shared.CreateClass)
local PlayerInst = game.Players.LocalPlayer

local InputControllerClass = CreateClass(require(script.Parent.InputController))
local MouseClass = CreateClass(require(script.Parent.Mouse))
local CameraClass = CreateClass(require(script.Parent.Camera))

return function(self)    
    self.Initiate = function()
        print("sudfjs")
        local InputController = InputControllerClass.new()
        InputController.Initiate()

        local Mouse = MouseClass.new()
        Mouse.Initiate()

        local Camera = CameraClass.new()
        Camera.Initiate()
    end
end
