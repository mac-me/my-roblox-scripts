-- =================================================================
-- AUTOSYNC HUB - PREMIUM BILINGUAL MINT & RED EDITION
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
NavScroll.CanvasSize = UDim2.new(0, 650, 0, 0) -- เลื่อนแนวนอนยาวๆ ได้
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
    Page.CanvasSize = UDim2.new(0, 0, 0, 400)
    
    local PageList = Instance.new("UIListLayout")
    PageList.Parent = Page
    PageList.SortOrder = Enum.SortOrder.LayoutOrder
    PageList.Padding = UDim.new(0, 12)
    
    tabs[name] = {Button = TabBtn, Stroke = TabStroke, Page = Page}
    
    -- อนิเมชั่น Hover บนแท็บหลัก
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
    
    return Page
end

local function SwitchTab(name)
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
end

-- สร้างแท็บทั้ง 4 หมวดหมู่ตามสั่ง
local MainTab = CreateTab("Dashboard", 1)
local CombatTab = CreateTab("Cheats / Risk", 2)
local ExecTab = CreateTab("Executor", 3)
local InfoTab = CreateTab("Hub Info", 4)

-- =================================================================
-- 4. ส่วนประกอบ UI Elements (Buttons, Toggles, Sliders)
-- =================================================================
local function CreateToggle(parent, text, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Btn = Instance.new("TextButton")
    local Corner = Instance.new("UICorner")
    local Stroke = Instance.new("UIStroke")
    
    Frame.Size = UDim2.new(0.96, 0, 0, 40)
    Frame.BackgroundTransparency = 1
    Frame.Parent = parent
    
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    Btn.Size = UDim2.new(0, 45, 0, 24)
    Btn.Position = UDim2.new(1, -50, 0, 8)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Btn.Text = ""
    Btn.Parent = Frame
    
    Corner.CornerRadius = UDim.new(0, 12)
    Corner.Parent = Btn
    Stroke.Color = Color3.fromRGB(60, 60, 65)
    Stroke.Thickness = 1
    Stroke.Parent = Btn
    
    local active = false
    Btn.MouseButton1Click:Connect(function()
        active = not active
        local tInfo = TweenInfo.new(0.2)
        if active then
            TweenService:Create(Btn, tInfo, {BackgroundColor3 = Color3.fromRGB(16, 48, 38)}):Play()
            TweenService:Create(Stroke, tInfo, {Color = Color3.fromRGB(0, 255, 170)}):Play()
        else
            TweenService:Create(Btn, tInfo, {BackgroundColor3 = Color3.fromRGB(40, 40, 45)}):Play()
            TweenService:Create(Stroke, tInfo, {Color = Color3.fromRGB(60, 60, 65)}):Play()
        end
        callback(active)
    end)
end

local function CreateInputBox(parent, text, placeholder, callback)
    local Frame = Instance.new("Frame")
    local Label = Instance.new("TextLabel")
    local Box = Instance.new("TextBox")
    local Corner = Instance.new("UICorner")
    local Stroke = Instance.new("UIStroke")
    
    Frame.Size = UDim2.new(0.96, 0, 0, 40)
    Frame.BackgroundTransparency = 1
    Frame.Parent = parent
    
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.GothamSemibold
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(220, 220, 220)
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Frame
    
    Box.Size = UDim2.new(0, 80, 0, 26)
    Box.Position = UDim2.new(1, -85, 0, 7)
    Box.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 12
    Box.Parent = Frame
    
    Corner.CornerRadius = UDim.new(0, 6)
    Corner.Parent = Box
    Stroke.Color = Color3.fromRGB(50, 50, 55)
    Stroke.Parent = Box
    
    Box.FocusLost:Connect(function(ep)
        if ep then 
            callback(Box.Text) 
        end
    end)
end

-- =================================================================
-- 5. บรรจุฟังก์ชันการทำงานในหน้าต่างๆ
-- =================================================================

-- [TAB 1: DASHBOARD]
local wsVal, jpVal, gravVal = 16, 50, 196.2
local loopSpeed, loopJump = false, false

CreateInputBox(MainTab, "ความเร็วการวิ่ง (WalkSpeed)", "16", function(val)
    wsVal = tonumber(val) or 16
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = wsVal
    end
end)

CreateToggle(MainTab, "ล็อกความเร็วถาวร (Loop Speed)", function(state)
    loopSpeed = state
end)

CreateInputBox(MainTab, "พลังกระโดดสูง (JumpPower)", "50", function(val)
    jpVal = tonumber(val) or 50
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.JumpPower = jpVal
        lp.Character.Humanoid.UseJumpPower = true
    end
end)

CreateToggle(MainTab, "ล็อกพลังกระโดดถาวร (Loop Jump)", function(state)
    loopJump = state
end)

CreateInputBox(MainTab, "ปรับแรงโน้มถ่วง (Gravity)", "196.2", function(val)
    gravVal = tonumber(val) or 196.2
    game.Workspace.Gravity = gravVal
end)

RunService.RenderStepped:Connect(function()
    if loopSpeed and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = wsVal
    end
    if loopJump and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.JumpPower = jpVal
        lp.Character.Humanoid.UseJumpPower = true
    end
end)

-- [TAB 2: CHEATS / RISK]
local infJumpActive = false
CreateToggle(CombatTab, "กระโดดไม่จำกัด (Infinite Jump)", function(state)
    infJumpActive = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if infJumpActive and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid:ChangeState("Jumping")
    end
end)

CreateToggle(CombatTab, "หายตัวถาวร (Invisibility)", function(state)
    if lp.Character and lp.Character:FindFirstChild("LowerTorso") then
        for _, v in pairs(lp.Character:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                v.Transparency = state and 1 or 0
            end
        end
    end
end)

CreateToggle(CombatTab, "เปิดระบบอมตะหลอก (God Mode Client)", function(state)
    if state and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.MaxHealth = 999999
        lp.Character.Humanoid.Health = 999999
    else
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.MaxHealth = 100
            lp.Character.Humanoid.Health = 100
        end
    end
end)

CreateToggle(CombatTab, "ป้องกันระบบแอนตี้ชีท (Bypass Anti-Cheat)", function(state)
    if state then
        local g = hookmetamethod(game, "__index", function(self, key)
            if self == lp.Character and (key == "WalkSpeed" or key == "JumpPower") then
                return 16
            end
            return g(self, key)
        end)
    end
end)

-- [TAB 3: EXECUTOR (ระบบเขียนสด)]
local ExecBox = Instance.new("TextBox")
local ExecBtn = Instance.new("TextButton")
local ExecCorner = Instance.new("UICorner")

ExecBox.Size = UDim2.new(0.96, 0, 0, 150)
ExecBox.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
ExecBox.Font = Enum.Font.Code
ExecBox.Text = "-- พิมพ์โค้ด Lua ของคุณที่นี่เพื่อรันสด...\nprint('Hello AutoSync')"
ExecBox.TextColor3 = Color3.fromRGB(0, 255, 170)
ExecBox.TextSize = 11
ExecBox.TextXAlignment = Enum.TextXAlignment.Left
ExecBox.TextYAlignment = Enum.TextYAlignment.Top
ExecBox.ClearTextOnFocus = false
ExecBox.MultiLine = true
ExecBox.Parent = ExecTab

ExecBtn.Size = UDim2.new(0.96, 0, 0, 35)
ExecBtn.BackgroundColor3 = Color3.fromRGB(220, 40, 60)
ExecBtn.Font = Enum.Font.GothamBold
ExecBtn.Text = "EXECUTE CODE"
ExecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecBtn.TextSize = 12
ExecBtn.Parent = ExecTab

ExecCorner.CornerRadius = UDim.new(0, 6)
ExecCorner.Parent = ExecBtn

ExecBtn.MouseButton1Click:Connect(function()
    local code = ExecBox.Text
    local success, err = pcall(function()
        assert(loadstring(code))()
    end)
    if not success then
        warn("ASH Executor Error: " .. tostring(err))
    end
end)

-- [TAB 4: HUB INFO]
local function CreateInfoText(parent, labelText, valueText)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.96, 0, 0, 24)
    Label.BackgroundTransparency = 1
    Label.Font = Enum.Font.Gotham
    Label.Text = "• " .. labelText .. ": " .. valueText
    Label.TextColor3 = Color3.fromRGB(18, 180, 200)
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = parent
end

CreateInfoText(InfoTab, "Hub Name", "AutoSync Hub")
CreateInfoText(InfoTab, "Version", "1.0.0 (Premium UI)")
CreateInfoText(InfoTab, "Developer", "mac-me & Team")
CreateInfoText(InfoTab, "Discord Link", "discord.gg/autosync-hub")
CreateInfoText(InfoTab, "Manual / Guide", "เปิดแท็บ Dashboard ปรับค่าตัวเลข แล้วกด Enter ได้เลย")

-- =================================================================
-- 6. ระบบ อนิเมชั่น ซ่อน/เปิด หน้าต่าง (Icon Toggle & Close UI)
-- =================================================================
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

CloseBtn.MouseButton1Click:Connect(function()
    local t1 = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1})
    t1:Play()
    t1.Completed:Connect(function()
        MainFrame.Visible = false
        IconButton.Visible = true
        IconButton.Size = UDim2.new(0, 0, 0, 0)
        TweenService:Create(IconButton, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 50, 0, 50)}):Play()
    end)
end)

IconButton.MouseButton1Click:Connect(function()
    local t2 = TweenService:Create(IconButton, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)})
    t2:Play()
    t2.Completed:Connect(function()
        IconButton.Visible = false
        MainFrame.Visible = true
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 520, 0, 360), BackgroundTransparency = 0.05}):Play()
    end)
end)

-- เริ่มต้นเปิดการใช้งาน
SwitchTab("Dashboard")
