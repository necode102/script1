local library = {}
local mouse = game.Players.LocalPlayer:GetMouse()

function play(id)
    for _, v in next, workspace:GetChildren() do
        if v.Name == "GUISound" then
            v:Destroy()
        end
    end
    local Sound = Instance.new("Sound", workspace)
    Sound.Name = "GUISound"
    Sound.Volume = 6
    Sound.SoundId = id
    Sound:Play()
end

function library:CreateWindow(name, theme)
    local theme1
    local theme2
    local theme3
    local toolight = false
    
    -- Удаляем старые окна
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "By Shaddow" then
            v:Destroy()
        end
    end

    -- Выбор темы
    if theme == "Normal" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(176, 148, 255)
    elseif theme == "Reverse" then
        theme1 = Color3.fromRGB(26,26,26)
        theme2 = Color3.fromRGB(32,32,32)
        theme3 = Color3.fromRGB(176, 148, 255)
    elseif theme == "Blood" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(138, 3, 3)
    elseif theme == "Gainsboro" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(220, 220, 221)
        toolight = true
    elseif theme == "Canary" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(255, 253, 130)
    elseif theme == "Emerald" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(68, 207, 108)
    elseif theme == "Crimson" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(214, 40, 57)
    elseif theme == "Deep Sea" then
        theme1 = Color3.fromRGB(32,32,32)
        theme2 = Color3.fromRGB(26,26,26)
        theme3 = Color3.fromRGB(40, 81, 214)
    end

    -- Создание элементов интерфейса
    local Screen = Instance.new("ScreenGui")
    local Top = Instance.new("ImageLabel")
    local Toggle = Instance.new("ImageButton")
    local Main = Instance.new("ImageLabel")
    local Tabs = Instance.new("ImageLabel")
    local UIGridLayout = Instance.new("UIGridLayout")
    local TabContainer = Instance.new("Folder")
    local Items = Instance.new("ImageLabel")
    local TextLabel = Instance.new("TextLabel")
    local Footer = Instance.new("ImageLabel")

    Screen.Name = "By Shaddow"
    Screen.Parent = game:WaitForChild("CoreGui")
    Screen.Enabled = true

    Top.Name = "Top"
    Top.Parent = Screen
    Top.AnchorPoint = Vector2.new(0.5, 0.5)
    Top.BackgroundColor3 = Color3.fromRGB(33, 32, 49)
    Top.BackgroundTransparency = 1.000
    Top.Active = true
    Top.Position = UDim2.new(0.5, 0, 0.2, 0)
    Top.Size = UDim2.new(0, 650, 0, 30)
    Top.Image = "rbxassetid://3570695787"
    Top.ImageColor3 = theme1
    Top.ScaleType = Enum.ScaleType.Slice
    Top.SliceCenter = Rect.new(100, 100, 100, 100)
    Top.SliceScale = 0.030
    Top.Draggable = true

    -- Прикрепление к курсору мыши
    mouse.Move:Connect(function()
        if not Top.Draggable then
            Top.Position = UDim2.new(0, mouse.X, 0, mouse.Y + 20)
        end
    end)

    TextLabel.Parent = Top
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.Position = UDim2.new(0.035, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 600, 0, 30)
    TextLabel.Font = Enum.Font.SourceSansSemibold
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 16.000

    Toggle.Name = "Toggle"
    Toggle.Parent = Top
    Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.BackgroundTransparency = 1.000
    Toggle.Position = UDim2.new(0.009, 0, 0.15, 0)
    Toggle.Rotation = 90.000
    Toggle.Size = UDim2.new(0, 20, 0, 20)
    Toggle.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Image = "https://www.roblox.com/Thumbs/Asset.ashx?width=420&height=420&assetId=4731371541"

    Main.Name = "Main"
    Main.Parent = Top
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BackgroundTransparency = 1.000
    Main.Position = UDim2.new(0.5, 0, 6.8, 0)
    Main.Size = UDim2.new(0, 650, 0, 450)
    Main.Image = "rbxassetid://3570695787"
    Main.ImageColor3 = theme2
    Main.ScaleType = Enum.ScaleType.Slice
    Main.SliceCenter = Rect.new(100, 100, 100, 100)
    Main.SliceScale = 0.030

    Tabs.Name = "Tabs"
    Tabs.Parent = TabContainer
    Tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tabs.BackgroundTransparency = 1.000
    Tabs.Position = UDim2.new(0.013, 0, 0.03, 0)
    Tabs.Size = UDim2.new(0, 150, 0, 420)
    Tabs.Image = "rbxassetid://3570695787"
    Tabs.ImageColor3 = theme1
    Tabs.ScaleType = Enum.ScaleType.Slice
    Tabs.SliceCenter = Rect.new(100, 100, 100, 100)
    Tabs.SliceScale = 0.020

    UIGridLayout.Parent = Tabs
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellSize = UDim2.new(0, 150, 0, 30)

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main

    Items.Name = "Items"
    Items.Parent = Main
    Items.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Items.BackgroundTransparency = 1.000
    Items.Position = UDim2.new(0.245, 0, 0.03, 0)
    Items.Size = UDim2.new(0, 480, 0, 420)
    Items.Image = "rbxassetid://3570695787"
    Items.ImageColor3 = theme1
    Items.ScaleType = Enum.ScaleType.Slice
    Items.SliceCenter = Rect.new(100, 100, 100, 100)
    Items.SliceScale = 0.020

    Footer.Name = "Footer"
    Footer.Parent = Main
    Footer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Footer.BackgroundTransparency = 1.000
    Footer.Position = UDim2.new(0.013, 0, 0.93, 0)
    Footer.Size = UDim2.new(0, 624, 0, 25)
    Footer.Image = "rbxassetid://3570695787"
    Footer.ImageColor3 = theme1
    Footer.ScaleType = Enum.ScaleType.Slice
    Footer.SliceCenter = Rect.new(100, 100, 100, 100)
    Footer.SliceScale = 0.020
    
    local FooterText = Instance.new("TextLabel")
    FooterText.Parent = Footer
    FooterText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    FooterText.BackgroundTransparency = 1.000
    FooterText.Size = UDim2.new(1, 0, 1, 0)
    FooterText.Font = Enum.Font.SourceSansSemibold
    FooterText.Text = "Shaddow UI Library | v1.3 | "..os.date("%d/%m/%Y %H:%M")
    FooterText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FooterText.TextSize = 14.000

    local opened = true
    Toggle.MouseButton1Click:Connect(function()
        if opened then
            Main.Visible = false
            Toggle.Rotation = 0
            opened = false
            Top.Draggable = false -- Отключаем перетаскивание при закрытии
        else
            Main.Visible = true
            Toggle.Rotation = 90
            opened = true
            Top.Draggable = true -- Включаем перетаскивание при открытии
        end
    end)

    local InsideLibrary = {}

    function InsideLibrary:CreateTab(text)
        local TextButton1 = Instance.new("TextButton")
        local Frame = Instance.new("ScrollingFrame")
        local UIGridLayout_2 = Instance.new("UIGridLayout")
        local UICorner = Instance.new("UICorner")

        TextButton1.Name = text.." Button"
        TextButton1.Parent = Tabs
        TextButton1.BackgroundColor3 = Color3.fromRGB(32,32,32)
        TextButton1.BackgroundTransparency = 1.000
        TextButton1.Size = UDim2.new(0, 150, 0, 30)
        TextButton1.Font = Enum.Font.SourceSansSemibold
        TextButton1.Text = text
        TextButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton1.TextSize = 15.000

        Frame.Parent = Items
        Frame.Active = true
        Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Frame.BackgroundTransparency = 1.000
        Frame.BorderSizePixel = 0
        Frame.Position = UDim2.new(0.017, 0, 0.035, 0)
        Frame.Size = UDim2.new(0, 460, 0, 400)
        Frame.CanvasSize = UDim2.new(0, 0, 2, 0)
        Frame.ScrollBarImageColor3 = theme2
        Frame.ScrollBarThickness = 8

        UICorner.Parent = Frame

        UIGridLayout_2.Parent = Frame
        UIGridLayout_2.FillDirection = Enum.FillDirection.Vertical
        UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        UIGridLayout_2.CellSize = UDim2.new(0, 100, 0, 25)
        UIGridLayout_2.StartCorner = Enum.StartCorner.TopRight

        Frame.ChildAdded:Connect(function()
            if #Frame:GetChildren() > 15 then
                Frame.CanvasSize = UDim2.new(0, 0, Frame.CanvasSize.Y.Scale + 0.15, 0)
            end
        end)

        TextButton1.MouseButton1Click:Connect(function()
            for i,v in next, Items:GetChildren() do
                v.Visible = false
            end
            for i,t in next, Tabs:GetChildren() do
                if t.ClassName ~= "UIGridLayout" then
                    t.TextColor3 = Color3.fromRGB(255, 255, 255)
                end
                TextButton1.TextColor3 = theme3
            end
            Frame.Visible = true
            play("rbxassetid://1412830636")
        end)

        local InsideTab = {}

        function InsideTab:CreateDropdown(text, list, callback)
            local BodyYSize = 0
            local IsDropped = false
            callback = callback or function() end
            list = list or {}
            text = text or "Dropdown"
            local Dropdown = Instance.new("TextLabel")
            local TextButton = Instance.new("TextButton")
            local TextButton_Roundify_2px_2 = Instance.new("ImageLabel")
            local DropdownContainer = Instance.new("ImageLabel")
            local UIListLayout_2 = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Frame
            Dropdown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.BackgroundTransparency = 1.000
            Dropdown.Size = UDim2.new(0, 220, 0, 50)
            Dropdown.Font = Enum.Font.SourceSansSemibold
            Dropdown.Text = text
            Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
            Dropdown.TextSize = 15.000

            TextButton.Parent = Dropdown
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.BackgroundTransparency = 1.000
            TextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
            TextButton.BorderSizePixel = 0
            TextButton.Position = UDim2.new(1, 0, 0, 0)
            TextButton.Size = UDim2.new(0, 40, 0, 30)
            TextButton.ZIndex = 2
            TextButton.Font = Enum.Font.SourceSansBold
            TextButton.Text = "+"
            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.TextSize = 15.000

            TextButton_Roundify_2px_2.Name = "TextButton_Roundify_2px"
            TextButton_Roundify_2px_2.Parent = TextButton
            TextButton_Roundify_2px_2.Active = true
            TextButton_Roundify_2px_2.AnchorPoint = Vector2.new(0.5, 0.5)
            TextButton_Roundify_2px_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_Roundify_2px_2.BackgroundTransparency = 1.000
            TextButton_Roundify_2px_2.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextButton_Roundify_2px_2.Selectable = true
            TextButton_Roundify_2px_2.Size = UDim2.new(1, 0, 1, 0)
            TextButton_Roundify_2px_2.Image = "rbxassetid://3570695787"
            TextButton_Roundify_2px_2.ImageColor3 = theme2
            TextButton_Roundify_2px_2.ScaleType = Enum.ScaleType.Slice
            TextButton_Roundify_2px_2.SliceCenter = Rect.new(100, 100, 100, 100)
            TextButton_Roundify_2px_2.SliceScale = 0.020

            TextButton.MouseButton1Click:Connect(function()
                play("rbxassetid://178104975")
                if not IsDropped then
                    IsDropped = true
                    TextButton.TextColor3 = theme3
                    DropdownContainer.Visible = true
                else
                    IsDropped = false
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownContainer.Visible = false
                end
            end)

            for i,v in pairs(list) do
                BodyYSize = BodyYSize + 30
                local TextButton_2 = Instance.new("TextButton")
                TextButton_2.Parent = DropdownContainer
                TextButton_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextButton_2.BackgroundTransparency = 1.000
                TextButton_2.Size = UDim2.new(0, 230, 0, 30)
                TextButton_2.Font = Enum.Font.SourceSansSemibold
                TextButton_2.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextButton_2.Text = v
                TextButton_2.TextSize = 15.000
                TextButton_2.ZIndex = 4

                TextButton_2.MouseButton1Click:Connect(function()
                    Dropdown.Text = v
                    callback(v)
                    IsDropped = false
                    DropdownContainer.Visible = false
                end)
            end

            DropdownContainer.Name = "DropdownContainer"
            DropdownContainer.Parent = TextButton
            DropdownContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownContainer.BackgroundTransparency = 1.000
            DropdownContainer.Position = UDim2.new(1.5, 0, 0, 0)
            DropdownContainer.Size = UDim2.new(0, 230, 0, BodyYSize)
            DropdownContainer.Image = "rbxassetid://3570695787"
            DropdownContainer.ImageColor3 = theme2
            DropdownContainer.Visible = false
            DropdownContainer.ScaleType = Enum.ScaleType.Slice
            DropdownContainer.SliceCenter = Rect.new(100, 100, 100, 100)
            DropdownContainer.SliceScale = 0.020
            DropdownContainer.ZIndex = 3

            UIListLayout_2.Parent = DropdownContainer
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
        end

        function InsideTab:CreateSlider(text, minvalue, maxvalue, callback)
            text = text or "Slider"
            minvalue = minvalue or 0
            maxvalue = maxvalue or 100
            callback = callback or function() end

            local uis = game:GetService("UserInputService")
            local Value

            local Slider = Instance.new("TextLabel")
            local Frame_3 = Instance.new("ImageLabel")
            local SliderButton = Instance.new("TextButton")
            local TextButton_Roundify_2px = Instance.new("ImageLabel")
            local SliderInner = Instance.new("ImageLabel")
            local TextLabel_2 = Instance.new("TextLabel")
            
            Slider.Name = "Slider"
            Slider.Parent = Frame
            Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Slider.BackgroundTransparency = 1.000
            Slider.Size = UDim2.new(0, 220, 0, 50)
            Slider.Font = Enum.Font.SourceSansSemibold
            Slider.Text = text
            Slider.TextColor3 = Color3.fromRGB(255, 255, 255)
            Slider.TextSize = 15.000
            
            Frame_3.Name = "Frame"
            Frame_3.Parent = Slider
            Frame_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_3.BackgroundTransparency = 1.000
            Frame_3.Position = UDim2.new(1, 0, 0.395, 0)
            Frame_3.Size = UDim2.new(0, 180, 0, 10)
            Frame_3.Image = "rbxassetid://3570695787"
            Frame_3.ImageColor3 = theme2
            Frame_3.ScaleType = Enum.ScaleType.Slice
            Frame_3.SliceCenter = Rect.new(100, 100, 100, 100)
            Frame_3.SliceScale = 0.020
            
            SliderButton.Name = "SliderButton"
            SliderButton.Parent = Slider
            SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderButton.BackgroundTransparency = 1.000
            SliderButton.BorderSizePixel = 0
            SliderButton.Position = UDim2.new(1, 0, 0.391, 0)
            SliderButton.Size = UDim2.new(0, 180, 0, 10)
            SliderButton.Font = Enum.Font.SourceSans
            SliderButton.Text = ""
            SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            SliderButton.TextSize = 14.000
            
            TextButton_Roundify_2px.Name = "TextButton_Roundify_2px"
            TextButton_Roundify_2px.Parent = SliderButton
            TextButton_Roundify_2px.Active = true
            TextButton_Roundify_2px.AnchorPoint = Vector2.new(0.5, 0.5)
            TextButton_Roundify_2px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton_Roundify_2px.BackgroundTransparency = 1.000
            TextButton_Roundify_2px.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextButton_Roundify_2px.Selectable = true
            TextButton_Roundify_2px.Size = UDim2.new(1, 0, 1, 0)
            TextButton_Roundify_2px.Image = "rbxassetid://3570695787"
            TextButton_Roundify_2px.ImageColor3 = theme2
            TextButton_Roundify_2px.ScaleType = Enum.ScaleType.Slice
            TextButton_Roundify_2px.SliceCenter = Rect.new(100, 100, 100, 100)
            TextButton_Roundify_2px.SliceScale = 0.020
            
            SliderInner.Name = "SliderInner"
            SliderInner.Parent = SliderButton
            SliderInner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderInner.BackgroundTransparency = 1.000
            SliderInner.Size = UDim2.new(0, 0, 0, 10)
            SliderInner.Image = "rbxassetid://3570695787"
            SliderInner.ImageColor3 = theme3
            SliderInner.ScaleType = Enum.ScaleType.Slice
            SliderInner.SliceCenter = Rect.new(100, 100, 100, 100)
            SliderInner.SliceScale = 0.020
            
            TextLabel_2.Parent = Slider
            TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_2.BackgroundTransparency = 1.000
            TextLabel_2.BorderSizePixel = 2
            TextLabel_2.Position = UDim2.new(3.1, 0, 0.4, 0)
            TextLabel_2.Size = UDim2.new(0, 40, 0, 10)
            TextLabel_2.Font = Enum.Font.SourceSansBold
            TextLabel_2.Text = tostring(minvalue)
            TextLabel_2.TextColor3 = theme3
            TextLabel_2.TextSize = 15.000
            TextLabel_2.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

            SliderButton.MouseButton1Down:Connect(function()
                Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 180) * SliderInner.AbsoluteSize.X) + tonumber(minvalue)) or 0
                pcall(function()
                    callback(Value)
                    TextLabel_2.Text = Value
                end)
                SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 180), 0, 10)
                moveconnection = mouse.Move:Connect(function()
                    Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 180) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                    pcall(function()
                        callback(Value)
                        TextLabel_2.Text = Value
                    end)
                    SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 180), 0, 10)
                end)
                releaseconnection = uis.InputEnded:Connect(function(Mouse)
                    if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                        Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 180) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                        pcall(function()
                            callback(Value)
                        end)
                        SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 180), 0, 10)
                        moveconnection:Disconnect()
                        releaseconnection:Disconnect()
                    end
                end)
            end)
        end

        function InsideTab:CreateToggle(text, callback)
            text = text or "New Toggle"
            callback = callback or function() end
            local switchactions = {}
            local Toggle_2 = Instance.new("TextLabel")
            local Frame_t = Instance.new("ImageLabel")
            local Frame_2 = Instance.new("ImageLabel")
            local ToggleButton = Instance.new("TextButton")

            Toggle_2.Name = "Toggle"
            Toggle_2.Parent = Frame
            Toggle_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Toggle_2.BackgroundTransparency = 1.000
            Toggle_2.Size = UDim2.new(0, 220, 0, 50)
            Toggle_2.Font = Enum.Font.SourceSansSemibold
            Toggle_2.Text = text
            Toggle_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle_2.TextSize = 15.000

            Frame_t.Name = "Frame"
            Frame_t.Parent = Toggle_2
            Frame_t.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_t.BackgroundTransparency = 1.000
            Frame_t.Position = UDim2.new(1, 0, 0.333, 0)
            Frame_t.Size = UDim2.new(0, 35, 0, 15)
            Frame_t.Image = "rbxassetid://3570695787"
            Frame_t.ImageColor3 = theme2
            Frame_t.ScaleType = Enum.ScaleType.Slice
            Frame_t.SliceCenter = Rect.new(100, 100, 100, 100)
            Frame_t.SliceScale = 0.250

            Frame_2.Name = "Frame_2"
            Frame_2.Parent = Frame_t
            Frame_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Frame_2.BackgroundTransparency = 1.000
            Frame_2.Position = UDim2.new(0, 3, 0.15, 0)
            Frame_2.Size = UDim2.new(0, 12, 0, 12)
            Frame_2.Image = "rbxassetid://3570695787"
            Frame_2.ScaleType = Enum.ScaleType.Slice
            Frame_2.SliceCenter = Rect.new(100, 100, 100, 100)
            Frame_2.SliceScale = 0.250

            ToggleButton.Name = "ToggleButton"
            ToggleButton.Parent = Toggle_2
            ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleButton.BackgroundTransparency = 1.000
            ToggleButton.Position = UDim2.new(1, 0, 0.333, 0)
            ToggleButton.Size = UDim2.new(0, 35, 0, 15)
            ToggleButton.Font = Enum.Font.SourceSans
            ToggleButton.Text = ""
            ToggleButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            ToggleButton.TextSize = 14.000

            local enabled = false
            function trigger()
                enabled = not enabled
                pcall(callback, enabled)
                play("rbxassetid://6309164078")
                if enabled then
                    Frame_t.ImageColor3 = theme3
                    if toolight then
                        Frame_2.ImageColor3 = Color3.fromRGB(26,26,26)
                    end
                    Frame_2.Position = UDim2.new(0.59, 0, 0.15, 0)
                else
                    Frame_t.ImageColor3 = theme2
                    if toolight then
                        Frame_2.ImageColor3 = theme3
                    end
                    Frame_2.Position = UDim2.new(0, 3, 0.15, 0)
                end
            end

            ToggleButton.MouseButton1Click:Connect(trigger)

            function switchactions:Set(state)
                enabled = state
                if enabled then
                    Frame_t.ImageColor3 = theme3
                    if toolight then
                        Frame_2.ImageColor3 = Color3.fromRGB(26,26,26)
                    end
                    Frame_2.Position = UDim2.new(0.59, 0, 0.15, 0)
                else
                    Frame_t.ImageColor3 = theme2
                    if toolight then
                        Frame_2.ImageColor3 = theme3
                    end
                    Frame_2.Position = UDim2.new(0, 3, 0.15, 0)
                end
                pcall(callback, enabled)
            end
            return switchactions
        end

        function InsideTab:CreateButton(text, callback)
            text = text or "New Button"
            callback = callback or function() end
            local Button = Instance.new("TextButton")
            local Button_Roundify_3px = Instance.new("ImageLabel")
            
            Button.Name = "Btn"
            Button.Parent = Frame
            Button.BackgroundColor3 = Color3.fromRGB(116, 116, 116)
            Button.BackgroundTransparency = 1.000
            Button.BorderSizePixel = 0
            Button.Position = UDim2.new(-0.005, 0, 0.06, 0)
            Button.Size = UDim2.new(0, 45, 0, 25)
            Button.ZIndex = 2
            Button.Font = Enum.Font.SourceSansSemibold
            Button.Text = text
            Button.TextColor3 = Color3.fromRGB(255, 255, 255)
            Button.TextSize = 15.000
            
            Button_Roundify_3px.Name = "Button_Roundify_3px"
            Button_Roundify_3px.Parent = Button
            Button_Roundify_3px.Active = true
            Button_Roundify_3px.AnchorPoint = Vector2.new(0.5, 0.5)
            Button_Roundify_3px.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Button_Roundify_3px.BackgroundTransparency = 1.000
            Button_Roundify_3px.Position = UDim2.new(0.5, 0, 0.5, 0)
            Button_Roundify_3px.Selectable = true
            Button_Roundify_3px.Size = UDim2.new(1, 0, 1, 0)
            Button_Roundify_3px.Image = "rbxassetid://3570695787"
            Button_Roundify_3px.ImageColor3 = theme2
            Button_Roundify_3px.ScaleType = Enum.ScaleType.Slice
            Button_Roundify_3px.SliceCenter = Rect.new(100, 100, 100, 100)
            Button_Roundify_3px.SliceScale = 0.030

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
                play("rbxassetid://178104975")
            end)
        end

        function InsideTab:Show()
            for i,v in next, Items:GetChildren() do
                v.Visible = false
            end
            Frame.Visible = true
            TextButton1.TextColor3 = theme3
        end

        return InsideTab
    end
    return InsideLibrary
end

return library
