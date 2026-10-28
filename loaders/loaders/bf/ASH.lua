-- =================================================================
-- UNIVERSAL GUI - PREMIUM ANIMATION & BILINGUAL MINT EDITION
-- =================================================================

local TweenService = game:GetService("TweenService")
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local TopBar = Instance.new("Frame")
local UICorner_Top = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local LangBtn = Instance.new("TextButton")
local LangCorner = Instance.new("UICorner")
local ButtonContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Setup ScreenGui
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame (Modern Charcoal Background)
MainFrame.Name = "MintUniversalMenu"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
MainFrame.BackgroundTransparency = 0.05
MainFrame.Position = UDim2.new(0.1, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner_Main.CornerRadius = UDim.new(0, 14)
UICorner_Main.Parent = MainFrame

-- Top Bar (Header)
TopBar.Name = "TopBar"
TopBar.Parent = MainFrame
TopBar.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
TopBar.Size = UDim2.new(1, 0, 0, 45)

UICorner_Top.CornerRadius = UDim.new(0, 14)
UICorner_Top.Parent = TopBar

-- Title Text
Title.Parent = TopBar
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "MINT SYSTEM v2.0"
Title.TextColor3 = Color3.fromRGB(0, 255, 170)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Language Switch Button
LangBtn.Parent = TopBar
LangBtn.Size = UDim2.new(0, 50, 0, 24)
LangBtn.Position = UDim2.new(1, -65, 0, 10)
LangBtn.BackgroundColor3 = Color3.fromRGB(48, 48, 54)
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Text = "TH"
LangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
LangBtn.TextSize = 10

LangCorner.CornerRadius = UDim.new(0, 6)
LangCorner.Parent = LangBtn

-- Container for Buttons
ButtonContainer.Parent = MainFrame
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Position = UDim2.new(0, 0, 0, 55)
ButtonContainer.Size = UDim2.new(1, 0, 1, -65)
ButtonContainer.CanvasSize = UDim2.new(0, 0, 0, 240)
ButtonContainer.ScrollBarThickness = 0

UIListLayout.Parent = ButtonContainer
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)

-- Language Database
local currentLang = "EN"
local languages = {
    EN = { speed_off = "Speed Hack : OFF", speed_on = "Speed Hack : ON", jump_off = "Super Jump : OFF", jump_on = "Super Jump : ON", grav_off = "Zero Gravity : OFF", grav_on = "Zero Gravity : ON", admin = "Open Infinite Yield" },
    TH = { speed_off = "วิ่งเร็ว : ปิด", speed_on = "วิ่งเร็ว : เปิด", jump_off = "กระโดดสูง : ปิด", jump_on = "กระโดดสูง : เปิด", grav_off = "ลบแรงโน้มถ่วง : ปิด", grav_on = "ลบแรงโน้มถ่วง : เปิด", admin = "เปิดเมนูแกล้งคน (IY)" }
}

-- Function to Create Animated Buttons
local function CreateMenuButton(name, order)
    local Btn = Instance.new("TextButton")
    local BtnCorner = Instance.new("UICorner")
    local BtnStroke = Instance.new("UIStroke")
    
    Btn.Name = name
    Btn.Parent = ButtonContainer
    Btn.BackgroundColor3 = Color3.fromRGB(36, 36, 40)
    Btn.Size = UDim2.new(0.88, 0, 0, 42)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 12
    Btn.LayoutOrder = order
    
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn
    
    BtnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    BtnStroke.Color = Color3.fromRGB(48, 48, 54)
    BtnStroke.Thickness = 1
    BtnStroke.Parent = Btn
    
    -- Smooth Animations (Hover & Click)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, tweenInfo, {Size = UDim2.new(0.92, 0, 0, 44), BackgroundColor3 = Color3.fromRGB(42, 42, 48)}):Play()
    end)
    
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, tweenInfo, {Size = UDim2.new(0.88, 0, 0, 42), BackgroundColor3 = (Btn:GetAttribute("Active") and Color3.fromRGB(16, 48, 38) or Color3.fromRGB(36, 36, 40))}):Play()
    end)
    
    Btn.MouseButton1Down:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.05), {Size = UDim2.new(0.85, 0, 0, 38)}):Play()
    end)
    
    Btn.MouseButton1Up:Connect(function()
        TweenService:Create(Btn, tweenInfo, {Size = UDim2.new(0.92, 0, 0, 44)}):Play()
    end)
    
    return Btn, BtnStroke
end

-- Create Buttons
local SpeedBtn, SpeedStroke = CreateMenuButton("SpeedBtn", 1)
local JumpBtn, JumpStroke = CreateMenuButton("JumpBtn", 2)
local GravBtn, GravStroke = CreateMenuButton("GravBtn", 3)
local AdminBtn, AdminStroke = CreateMenuButton("AdminBtn", 4)

-- System States
local lp = game.Players.LocalPlayer
local speedActive = false
local jumpActive = false
local gravActive = false

-- Function to Update All UI Text Based on Language and State
local function updateUIElements()
    local textSet = languages[currentLang]
    SpeedBtn.Text = speedActive and textSet.speed_on or textSet.speed_off
    JumpBtn.Text = jumpActive and textSet.jump_on or textSet.jump_off
    GravBtn.Text = gravActive and textSet.grav_on or textSet.grav_off
    AdminBtn.Text = textSet.admin
end

-- Visual Toggle Modifier
local function setVisualState(active, btn, stroke)
    btn:SetAttribute("Active", active)
    local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    if active then
        TweenService:Create(btn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(16, 48, 38), TextColor3 = Color3.fromRGB(0, 255, 170)}):Play()
        TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(0, 255, 170)}):Play()
    else
        TweenService:Create(btn, tweenInfo, {BackgroundColor3 = Color3.fromRGB(36, 36, 40), TextColor3 = Color3.fromRGB(200, 200, 200)}):Play()
        TweenService:Create(stroke, tweenInfo, {Color = Color3.fromRGB(48, 48, 54)}):Play()
    end
    updateUIElements()
end

-- Language Switcher Logic
LangBtn.MouseButton1Click:Connect(function()
    currentLang = (currentLang == "EN") and "TH" or "EN"
    LangBtn.Text = (currentLang == "EN") and "TH" or "EN"
    updateUIElements()
end)

-- Initialize Text
updateUIElements()

-- =================================================================
-- LOGIC & FEATURES
-- =================================================================

-- 1. WalkSpeed Feature
SpeedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    setVisualState(speedActive, SpeedBtn, SpeedStroke)
    task.spawn(function()
        while speedActive do
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid.WalkSpeed = 120
            end
            task.wait(0.1)
        end
    end)
    if not speedActive and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = 16
    end
end)

-- 2. JumpPower Feature
JumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    setVisualState(jumpActive, JumpBtn, JumpStroke)
    task.spawn(function()
        while jumpActive do
            if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                lp.Character.Humanoid.JumpPower = 150
                lp.Character.Humanoid.UseJumpPower = true
            end
            task.wait(0.1)
        end
    end)
    if not jumpActive and lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.JumpPower = 50
    end
end)

-- 3. Gravity Feature
GravBtn.MouseButton1Click:Connect(function()
    gravActive = not gravActive
    if gravActive then
        game.Workspace.Gravity = 0
    else
        game.Workspace.Gravity = 196.2
    end
    setVisualState(gravActive, GravBtn, GravStroke)
end)

-- 4. Open Infinite Yield
AdminBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://githubusercontent.com'))()
end)
