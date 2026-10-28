-- =================================================================
-- AUTOSYNC HUB - PREMIUM BILINGUAL MINT & RED EDITION (FINAL VERSION)
-- =================================================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = lp:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [ASSET] URL โลโก้ ASH ของคุณ
local LOGO_ASSET_ID = "rbxassetid://138379471192994" 

-- =================================================================
-- 1. สร้างปุ่มย่อไอคอนลอย (Icon Toggle Mode)
-- =================================================================
local IconButton = Instance.new("ImageButton")
local IconCorner = Instance.new("UICorner")
local IconStroke = Instance.new("UIStroke")

IconButton.Name = "ASH_ToggleIcon"
IconButton.Parent = ScreenGui
IconButton.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
IconButton.Position = UDim2.new(0.02, 0, 0.15, 0)
IconButton.Size = UDim2.new(0, 50, 0, 50)
IconButton.Image = LOGO_ASSET_ID
IconButton.Visible = false -- เริ่มต้นซ่อนไว้ จะแสดงเมื่อปิดหน้าต่างหลัก
IconButton.Active = true
IconButton.Draggable = true

IconCorner.CornerRadius = UDim.new(0, 12)
IconCorner.Parent = IconButton
IconStroke.Color = Color3.fromRGB(0, 255, 170)
IconStroke.Thickness = 1.5
IconStroke.Parent = IconButton

-- =================================================================
-- 2. สร้างหน้าต่างหลัก (Main Window)
-- =================================================================
local MainFrame = Instance.new("Frame")
local MainCorner = Instance.new("UICorner")
local MainStroke = Instance.new("UIStroke")
local TopBar = Instance.new("Frame")
local TopCorner = Instance.new("UICorner")
local LogoImg = Instance.new("ImageLabel")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")

MainFrame.Name = "AutoSyncMain"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Position = UDim2.new(0.3, 0, 0.25, 0)
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Active = true
MainFrame.Draggable = true

MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame
MainStroke.Color = Color3.fromRGB(220, 40, 60) -- Dark Red Border
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- TopBar Header
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(26, 26, 30)
TopBar.Size = UDim2.new(1, 0, 0, 50)

TopCorner.CornerRadius = UDim.new(0, 16)
TopCorner.Parent = TopBar

LogoImg.Parent = TopBar
LogoImg.BackgroundTransparency = 1
LogoImg.Position = UDim2.new(0, 12, 0, 8)
LogoImg.Size = UDim2.new(0, 34, 0, 34)
LogoImg.Image = LOGO_ASSET_ID

Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 55, 0, 0)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "AUTOSYNC HUB"
Title.TextColor3 = Color3.fromRGB(0, 255, 170) -- Mint
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Parent = TopBar
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -40, 0, 10)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(220, 40, 60) -- Red
CloseBtn.TextSize = 16

-- =================================================================
-- 3. ระบบแดชบอร์ดเมนูด้านบน (Top Dashboard Navigation)
-- =================================================================
local NavScroll = Instance.new("ScrollingFrame")
local NavList = Instance.new("UIListLayout")

NavScroll.Name = "NavScroll"
NavScroll.Parent = MainFrame
NavScroll.BackgroundTransparency = 1
NavScroll.Position = UDim2.new(0, 0, 0, 52)
NavScroll.Size = UDim2.new(1, 0, 0, 40)
NavScroll.CanvasSize = UDim2.new(0, 650, 0, 0)
NavScroll.ScrollBarThickness = 0

NavList.Parent = NavScroll
NavScroll.ScrollingDirection = Enum.ScrollingDirection.X
NavList.FillDirection = Enum.FillDirection.Horizontal
NavList.SortOrder = Enum.SortOrder.LayoutOrder
NavList.Padding = UDim.new(0, 8)

-- Container สำหรับหน้าเนื้อหาของแต่ละแท็บ
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 15, 0, 100)
ContentFrame.Size = UDim2.new(1, -30, 1, -115)

local tabs = {}
local currentTab = nil

local function CreateTab(name, order)
    local TabBtn = Instance.new("TextButton")
    local TabCorner = Instance.new("UICorner")
    local TabStroke = Instance.new("UIStroke")
    
    TabBtn.Name = name .. "Tab"
    TabBtn.Parent = NavScroll
    TabBtn.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
    TabBtn.Size = UDim2.new(0, 110, 0, 32)
    TabBtn.Font = Enum.Font.GothamSemibold
    TabBtn.Text = name
    TabBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabBtn.TextSize = 12
    TabBtn.LayoutOrder = order
    
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn
    TabStroke.Color = Color3.fromRGB(45, 45, 50)
    TabStroke.Thickness = 1
    TabStroke.Parent = TabBtn
    
    local Page = Instance.new("ScrollingFrame")
    Page.Name = name .. "Page"
    Page.Parent = ContentFrame
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 170)
    Page.CanvasSize = UDim2.new(0, 0, 0, 500)
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 12)
    
    tabs[name] = {Button = TabBtn, Stroke = TabStroke, Page = Page}
    
    TabBtn.MouseEnter:Connect(function()
        if currentTab ~= name then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(42, 42, 48)}):Play()
        end
    end)
    TabBtn.MouseLeave:Connect(function()
        if currentTab ~= name then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(32, 32, 36)}):Play()
        end
    end)
    
    TabBtn.MouseButton1Click:Connect(function()
        for tName, tData in pairs(tabs) do
            if tName == name then
                currentTab = name
                tData.Page.Visible = true
                TweenService:Create(tData.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(16, 48, 38), TextColor3 = Color3.fromRGB(0, 255, 170)}):Play()
                TweenService:Create(tData.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 255, 170)}):Play()
            else
                tData.Page.Visible = false
                TweenService:Create(tData.Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(32, 32, 36), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
                TweenService:Create(tData.Stroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 45, 50)}):Play()
            end
        end
    end)
    
    return Page
end

-- สร้างแท็บทั้ง 4 หมวดหมู่
local DashboardPage = CreateTab("Dashboard", 1)
local CheatsPage = CreateTab("Cheats / Risk", 2)
local ExecutorPage = CreateTab("Executor", 3)
local InfoPage = CreateTab("Hub Info", 4)

-- ตั้งค่าเริ่มต้นที่หน้า Dashboard
tabs["Dashboard"].Page.Visible = true
currentTab = "Dashboard"
tabs["Dashboard"].Button.BackgroundColor3 = Color3.fromRGB(16, 48, 38)
tabs["Dashboard"].Button.TextColor3 = Color3.fromRGB(0, 255, 170)
tabs["Dashboard"].Stroke.Color = Color3.fromRGB(0, 255, 170)

-- =================================================================
-- 4. ส่วนประกอบ UI Elements (ต่อจากโค้ดเดิมของคุณจนเสร็จสมบูรณ์)
-- =================================================================

-- ฟังก์ชันสร้าง Toggle เปิด-ปิด
local function CreateToggle(parent, text, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Stroke = Instance.new("UIStroke")
    local Indicator = Instance.new("Frame")
    local IndCorner = Instance.new("UICorner")
    
    Frame.Size = UDim2.new(0.96, 0, 0, 40)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    Frame.Parent = parent
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    Btn.Size = UDim2.new(0, 45, 0, 22)
    Btn.Position = UDim2.new(1, -57, 0, 9)
    Btn.BackgroundColor3 = Color3.fromRGB(36, 36, 40)
    Btn.Text = ""
    Btn.Parent = Frame
    Corner.CornerRadius = UDim.new(1, 0)
    Corner.Parent = Btn
    Stroke.Color = Color3.fromRGB(55, 55, 60)
    Stroke.Thickness = 1
    Stroke.Parent = Btn
    
    Indicator.Size = UDim2.new(0, 16, 0, 16)
    Indicator.Position = default and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 4, 0, 3)
    Indicator.BackgroundColor3 = default and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(150, 150, 150)
    Indicator.Parent = Btn
    IndCorner.CornerRadius = UDim.new(1, 0)
    IndCorner.Parent = Indicator
    
    local enabled = default
    Btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 4, 0, 3)
        local targetColor = enabled and Color3.fromRGB(0, 255, 170) or Color3.fromRGB(150, 150, 150)
        TweenService:Create(Indicator, TweenInfo.new(0.2), {Position = targetPos, BackgroundColor3 = targetColor}):Play()
        task.spawn(callback, enabled)
    end)
end

-- ฟังก์ชันสร้าง Slider ตัวปรับแต่งระดับ
local function CreateSlider(parent, text, min, max, default, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local ValueLabel = Instance.new("TextLabel")
    local SliderBar = Instance.new("Frame")
    local SliderFill = Instance.new("Frame")
    local SliderTrigger = Instance.new("TextButton")
    
    Frame.Size = UDim2.new(0.96, 0, 0, 45)
    Frame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
    Frame.Parent = parent
    local fCorner = Instance.new("UICorner")
    fCorner.CornerRadius = UDim.new(0, 8)
    fCorner.Parent = Frame
    
    Label.Size = UDim2.new(0.5, 0, 0, 20)
    Label.Position = UDim2.new(0, 12, 0, 4)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    ValueLabel.Size = UDim2.new(0.4, 0, 0, 20)
    ValueLabel.Position = UDim2.new(1, -112, 0, 4)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.GothamSemibold
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
    ValueLabel.TextSize = 13
    ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
    ValueLabel.Parent = Frame
    
    SliderBar.Size = UDim2.new(1, -24, 0, 6)
    SliderBar.Position = UDim2.new(0, 12, 0, 28)
    SliderBar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    SliderBar.Parent = Frame
    local sbCorner = Instance.new("UICorner")
    sbCorner.CornerRadius = UDim.new(1, 0)
    sbCorner.Parent = SliderBar
    
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
    SliderFill.Parent = SliderBar
    local sfCorner = Instance.new("UICorner")
    sfCorner.CornerRadius = UDim.new(1, 0)
    sfCorner.Parent = SliderFill
    
    SliderTrigger.Size = UDim2.new(1, 0, 1, 0)
    SliderTrigger.BackgroundTransparency = 1
    SliderTrigger.Text = ""
    SliderTrigger.Parent = SliderBar
    
    local isDragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(pos, 0, 1, 0)
        local value = math.floor(min + (pos * (max - min)))
        ValueLabel.Text = tostring(value)
        task.spawn(callback, value)
    end
    
    SliderTrigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            update(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)
end

-- =================================================================
-- 5. บรรจุฟังก์ชันการโกงและระบบสั่งการของแต่ละหน้าใช้งาน
-- =================================================================

-- [PAGE 1: DASHBOARD] - ปรับแต่งความสามารถทั่วไปเรียบง่าย
CreateSlider(DashboardPage, "WalkSpeed (ความเร็วการวิ่ง)", 16, 250, 16, function(value)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = value
    end
end)

CreateSlider(DashboardPage, "JumpPower (แรงกระโดด)", 50, 300, 50, function(value)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").UseJumpPower = true
        lp.Character:FindFirstChildOfClass("Humanoid").JumpPower = value
    end
end)

CreateSlider(DashboardPage, "Gravity Control (แรงโน้มถ่วง)", 0, 196, 196, function(value)
    workspace.Gravity = value
end)

-- [PAGE 2: CHEATS / RISK] - หมวดหมู่ระบบโกงระดับสูง
local infJumpEnabled = false
CreateToggle(CheatsPage, "Infinite Jump (กระโดดไม่จำกัด)", false, function(state)
    infJumpEnabled = state
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled and lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

CreateToggle(CheatsPage, "Invisibility Client (หายตัวถาวร)", false, function(state)
    if lp.Character then
        for _, part in pairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = state and 1 or 0
            end
        end
    end
end)

CreateToggle(CheatsPage, "God Mode Client (อมตะหลอก)", false, function(state)
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        if state then
            lp.Character:FindFirstChildOfClass("Humanoid").MaxHealth = math.huge
            lp.Character:FindFirstChildOfClass("Humanoid").Health = math.huge
        else
            lp.Character:FindFirstChildOfClass("Humanoid").MaxHealth = 100
            lp.Character:FindFirstChildOfClass("Humanoid").Health = 100
        end
    end
end)

CreateToggle(CheatsPage, "Bypass Basic Anti-Cheat (ข้ามการตรวจจับ)", false, function(state)
    if state then
        local mt = getrawmetatable(game)
        if setreadonly then setreadonly(mt, false) end
        local old = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if tostring(method) == "Kick" or tostring(method) == "kick" then
                return nil
            end
            return old(self, ...)
        end)
    end
end)

-- [PAGE 3: EXECUTOR] - ช่อง Textbox สำหรับรันสดคำสั่ง Lua
local ExecTextBox = Instance.new("TextBox")
local ExecBtn = Instance.new("TextButton")
local ExecCorner = Instance.new("UICorner")

ExecTextBox.Size = UDim2.new(0.96, 0, 0, 150)
ExecTextBox.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
ExecTextBox.ClearTextOnFocus = false
ExecTextBox.Font = Enum.Font.Code
ExecTextBox.MultiLine = true
ExecTextBox.Text = "-- พิมพ์คำสั่ง Lua ตรงนี้แล้วกด Execute ด้านล่าง"
ExecTextBox.TextColor3 = Color3.fromRGB(240, 240, 240)
ExecTextBox.TextSize = 12
ExecTextBox.TextXAlignment = Enum.TextXAlignment.Left
ExecTextBox.TextYAlignment = Enum.TextYAlignment.Top
ExecTextBox.Parent = ExecutorPage
local etCorner = Instance.new("UICorner")
etCorner.CornerRadius = UDim.new(0, 8)
etCorner.Parent = ExecTextBox

ExecBtn.Size = UDim2.new(0.96, 0, 0, 36)
ExecBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 60)
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.Text = "EXECUTE LIVE CODE"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize = 13
ExecBtn.Parent = ExecutorPage

ExecCorner.CornerRadius = UDim.new(0, 8)
ExecCorner.Parent = ExecBtn

ExecBtn.MouseButton1Click:Connect(function()
    local code = ExecTextBox.Text
    if loadstring then
        local success, err = pcall(loadstring(code))
        if not success then
            warn("AutoSync Live Exec Error: " .. tostring(err))
        end
    else
        warn("Executor ในระบบของคุณไม่รองรับคำสั่ง loadstring ระดับระบบ!")
    end
end)

-- [PAGE 4: HUB INFO] - หน้ารายละเอียดโปรเจกต์
local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(0.96, 0, 0, 180)
InfoText.BackgroundTransparency = 1
InfoText.Font = Enum.Font.Gotham
InfoText.Text = "PROJECT NAME: AutoSync Hub (ASH)\nVERSION: Premium Mint & Red Final\nSYSTEM COMPATIBILITY: Windows (Solara / Xeno)\nDEVELOPERS: Co-Developed successfully by User & Assistant.\n\n[สถานะระบบหลังบ้าน: พร้อมทำงานผ่าน GitHub Loader เรียบร้อย 100%]"
InfoText.TextColor3 = Color3.fromRGB(180, 180, 180)
InfoText.TextSize = 13
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.Parent = InfoPage

-- =================================================================
-- 6. ระบบสลับหน้าการแสดงผล (Toggle UI System)
-- =================================================================
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconButton.Visible = true
end)

IconButton.MouseButton1Click:Connect(function()
    IconButton.Visible = false
    MainFrame.Visible = true
end)
