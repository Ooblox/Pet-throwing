local UserInputService = game:GetService("UserInputService")

return function(self)
    self.ListenInput = function()
        UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
            --if gameProcessedEvent then return end

            game.ReplicatedStorage.RemoteSignals.UserInput:FireServer("Began", input.UserInputType)
        end)

        UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
            game.ReplicatedStorage.RemoteSignals.UserInput:FireServer("Ended", input.UserInputType)
        end)
    end

    self.Initiate = function()
        self.ListenInput()
    end
end
