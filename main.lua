local library = {}
local TweenService = game:GetService("TweenService")

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

function library:CreateWindow(name,theme)
    local theme1, theme2, theme3
    local toolight = false
    
    -- Удаляем старое меню, если есть
    for i,v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == "By Shaddow" then
            v:Destroy()
        end
    end

    -- Выбор темы
    local themes = {
        Normal = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(176, 148, 255)},
        Reverse = {Color3.fromRGB(26,26,26), Color3.fromRGB(32,32,32), Color3.fromRGB(176, 148, 255)},
        Blood = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(138, 3, 3)},
        Gainsboro = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(220, 220, 221), true},
        Canary = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(255, 253, 130)},
        Emerald = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(68, 207, 108)},
        Crimson = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(214, 40, 57)},
        ["Deep Sea"] = {Color3.fromRGB(32,32,32), Color3.fromRGB(26,26,26), Color3.fromRGB(40, 81, 214)}
    }
    
    theme1, theme2, theme3, toolight = unpack(themes[theme] or themes.Normal)
    print("Theme selected: "..theme)

    -- Создаем основные элементы
    local Screen = Instance.new("ScreenGui")
    Screen.Name = "By Shaddow"
    Screen.Parent = game:WaitForChild("CoreGui")
    Screen.Enabled = true

    -- Top Bar с увеличенной областью захвата
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Screen
    Top.AnchorPoint = Vector2.new(0.5, 0.5)
    Top.BackgroundColor3 = theme1
    Top.BorderSizePixel = 0
    Top.Position = UDim2.new(0.5, 0, 0.2, 0)
    Top.Size = UDim2.new(0, 700, 0, 40) -- Увеличенная высота для лучшего захвата
    Top.Active = true
    Top.Draggable = true
    
    -- Добавляем скругленные углы
    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 6)
    TopCorner.Parent = Top

    -- Текст заголовка
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Top
    TextLabel.BackgroundTransparency = 1
    TextLabel.Position = UDim2.new(0.05, 0, 0, 0)
    TextLabel.Size = UDim2.new(0.9, 0, 1, 0)
    TextLabel.Font = Enum.Font.GothamSemibold
    TextLabel.Text = name
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextSize = 18
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Кнопка toggle с анимацией
    local Toggle = Instance.new("ImageButton")
    Toggle.Name = "Toggle"
    Toggle.Parent = Top
    Toggle.BackgroundTransparency = 1
    Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
    Toggle.Position = UDim2.new(0.97, 0, 0.5, 0)
    Toggle.Size = UDim2.new(0, 25, 0, 25)
    Toggle.Image = "rbxassetid://3926305904" -- Иконка стрелки
    Toggle.ImageRectOffset = Vector2.new(324, 364)
    Toggle.ImageRectSize = Vector2.new(36, 36)
    Toggle.ImageColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Rotation = 180 -- Начальное положение (меню открыто)

    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Top
    Main.AnchorPoint = Vector2.new(0.5, 0)
    Main.BackgroundColor3 = theme2
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 1, 5)
    Main.Size = UDim2.new(1, 0, 0, 500) -- Большая высота
    Main.ClipsDescendants = true
    
    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 6)
    MainCorner.Parent = Main

    -- Tabs (левая панель)
    local Tabs = Instance.new("ScrollingFrame")
    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundColor3 = theme1
    Tabs.BackgroundTransparency = 0
    Tabs.BorderSizePixel = 0
    Tabs.Position = UDim2.new(0.01, 0, 0.02, 0)
    Tabs.Size = UDim2.new(0.23, 0, 0.96, 0)
    Tabs.CanvasSize = UDim2.new(0, 0, 2, 0)
    Tabs.ScrollBarThickness = 5
    Tabs.ScrollBarImageColor3 = theme3
    
    local TabsCorner = Instance.new("UICorner")
    TabsCorner.CornerRadius = UDim.new(0, 6)
    TabsCorner.Parent = Tabs

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.Parent = Tabs
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Padding = UDim.new(0, 5)

    -- Items (правая панель)
    local Items = Instance.new("ScrollingFrame")
    Items.Name = "Items"
    Items.Parent = Main
    Items.BackgroundTransparency = 1
    Items.BorderSizePixel = 0
    Items.Position = UDim2.new(0.26, 0, 0.02, 0)
    Items.Size = UDim2.new(0.73, 0, 0.96, 0)
    Items.CanvasSize = UDim2.new(0, 0, 2, 0)
    Items.ScrollBarThickness = 5
    Items.ScrollBarImageColor3 = theme3

    -- Footer
    local Footer = Instance.new("Frame")
    Footer.Name = "Footer"
    Footer.Parent = Main
    Footer.BackgroundColor3 = theme1
    Footer.BorderSizePixel = 0
    Footer.Position = UDim2.new(0.01, 0, 0.93, 0)
    Footer.Size = UDim2.new(0.98, 0, 0.05, 0)
    
    local FooterCorner = Instance.new("UICorner")
    FooterCorner.CornerRadius = UDim.new(0, 6)
    FooterCorner.Parent = Footer

    local FooterText = Instance.new("TextLabel")
    FooterText.Parent = Footer
    FooterText.BackgroundTransparency = 1
    FooterText.Size = UDim2.new(1, 0, 1, 0)
    FooterText.Font = Enum.Font.Gotham
    FooterText.Text = "Shaddow UI Library | v2.0 | "..os.date("%d/%m/%Y %H:%M")
    FooterText.TextColor3 = Color3.fromRGB(255, 255, 255)
    FooterText.TextSize = 14

    -- Анимация открытия/закрытия
    local opened = true
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    
    local function toggleMenu()
        play("rbxassetid://178104975")
        opened = not opened
        
        if opened then
            -- Анимация открытия
            TweenService:Create(Toggle, tweenInfo, {Rotation = 180}):Play()
            TweenService:Create(Main, tweenInfo, {Size = UDim2.new(1, 0, 0, 500)}):Play()
        else
            -- Анимация закрытия
            TweenService:Create(Toggle, tweenInfo, {Rotation = 0}):Play()
            TweenService:Create(Main, tweenInfo, {Size = UDim2.new(1, 0, 0, 0)}):Play()
        end
    end

    Toggle.MouseButton1Click:Connect(toggleMenu)

    -- Drag с увеличенной областью
    local dragInput, dragStart, startPos
    local function updateInput(input)
        local delta = input.Position - dragStart
        local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        TweenService:Create(Top, TweenInfo.new(0.15), {Position = position}):Play()
    end

    Top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragStart = input.Position
            startPos = Top.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragInput = nil
                end
            end)
        end
    end)

    Top.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput then
            updateInput(input)
        end
    end)

    local InsideLibrary = {}

    function InsideLibrary:CreateTab(text)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = text.." Button"
        TabButton.Parent = Tabs
        TabButton.BackgroundColor3 = theme1
        TabButton.BackgroundTransparency = 0
        TabButton.Size = UDim2.new(0.9, 0, 0, 35) -- Большие кнопки вкладок
        TabButton.Font = Enum.Font.GothamSemibold
        TabButton.Text = text
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.TextSize = 15
        TabButton.AutoButtonColor = false
        
        local TabButtonCorner = Instance.new("UICorner")
        TabButtonCorner.CornerRadius = UDim.new(0, 6)
        TabButtonCorner.Parent = TabButton

        local TabFrame = Instance.new("ScrollingFrame")
        TabFrame.Parent = Items
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size = UDim2.new(1, 0, 1, 0)
        TabFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
        TabFrame.ScrollBarThickness = 5
        TabFrame.ScrollBarImageColor3 = theme3
        TabFrame.Visible = false

        local TabLayout = Instance.new("UIListLayout")
        TabLayout.Parent = TabFrame
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 10)

        TabButton.MouseButton1Click:Connect(function()
            play("rbxassetid://1412830636")
            
            -- Анимация смены вкладки
            for _, v in pairs(Items:GetChildren()) do
                if v:IsA("ScrollingFrame") then
                    TweenService:Create(v, tweenInfo, {ScrollBarImageTransparency = 1}):Play()
                    v.Visible = false
                end
            end
            
            for _, t in pairs(Tabs:GetChildren()) do
                if t:IsA("TextButton") then
                    TweenService:Create(t, tweenInfo, {BackgroundColor3 = theme1}):Play()
                end
            end
            
            TweenService:Create(TabButton, tweenInfo, {BackgroundColor3 = theme3}):Play()
            TabFrame.Visible = true
            TweenService:Create(TabFrame, tweenInfo, {ScrollBarImageTransparency = 0}):Play()
        end)

        local InsideTab = {}

        -- Здесь будут функции для создания элементов управления (как в предыдущих версиях)
        -- Они должны быть адаптированы под новую структуру
        
        return InsideTab
    end

    return InsideLibrary
end

return library
