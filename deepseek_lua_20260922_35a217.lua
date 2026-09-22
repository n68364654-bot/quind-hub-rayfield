-- ═══════════════════════════════════════════════════════════
--   ██████  ██    ██ ██ ███    ██ ██████
--  ██    ██ ██    ██ ██ ████   ██ ██   ██
--  ██    ██ ██    ██ ██ ██ ██  ██ ██   ██
--  ██ ▄▄ ██ ██    ██ ██ ██  ██ ██ ██   ██
--   ██████   ██████  ██ ██   ████ ██████
--      ▀▀
--   Quind Hub — made by hashtrash
--   10 табов × 20 функций
-- ═══════════════════════════════════════════════════════════
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local TS         = game:GetService("TeleportService")
local Http       = game:GetService("HttpService")
local VU         = game:GetService("VirtualUser")
local RS         = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local LP  = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- ═══════════════════ STATE ═══════════════════
local S = {
    speedOn=false, speedVal=50,
    jumpOn=false, jumpVal=100,
    infJump=false,
    noclip=false,
    flyOn=false, flyVal=80,
    cframeFly=false,
    swimMode=false,
    gravity=false, gravityVal=196.2,
    hipHeight=2,
    sitOn=false,
    -- combat
    aimOn=false, aimFov=150, aimSmooth=0.25, aimPart="Head",
    aimVisCheck=true, aimTeamCheck=false,
    triggerBot=false,
    -- esp
    espOn=false, espName=true, espHP=true, espDist=true, espHL=true,
    espTracer=false, espBox=false,
    espMurder=false, espSheriff=false, espInnocent=false,
    -- visual
    fullbright=false, noFog=false,
    fovOn=false, fovVal=70,
    ambientColor=Color3.fromRGB(70,70,70),
    -- utility
    freeze=false, antiFling=false, antiVoid=false, antiAfk=true,
    antiRag=false, autoResp=false,
    chatSpam=false, chatMsg="Quind Hub on top",
    -- character
    ghost=false, transparency=0,
    charSize=1, headSize=1,
    camLock=false, fakeDeath=false,
    -- weapons
    hlWeapons=false, hideTools=false,
    autoEquipGun=false, autoEquipKnife=false,
    autoReload=false,
    -- random
    spin=false, spinSpeed=5,
    walkOnWater=false,
    jumpBoost=false,
}
local flyBV, flyBG, spinBV
local espCache = {}
local roleHighlights = {}

-- ═══════════════════ WINDOW ═══════════════════
local Window = Rayfield:CreateWindow({
    Name = "Quind Hub",
    LoadingTitle = "Загрузка Quind Hub...",
    LoadingSubtitle = "made by hashtrash",
    ConfigurationSaving = {Enabled=false},
    Discord = {Enabled=false},
    KeySystem = false,
})

-- helper
local function notify(t, c, d) Rayfield:Notify({Title=t, Content=c, Duration=d or 4}) end
local function role(p)
    if not p or not p.Character then return "Unknown" end
    for _, t in ipairs(p.Character:GetChildren()) do
        if t:IsA("Tool") then
            local n = t.Name:lower()
            if n:find("knife") then return "Murderer" end
            if n:find("gun") or n:find("revolver") or n:find("pistol") then return "Sheriff" end
        end
    end
    return "Innocent"
end
local function hum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end
local function hrp() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function dist(a,b) return (a-b).Magnitude end

-- ═══════════════════════════════════════════════════════════
-- TAB 1: MOVEMENT (20)
-- ═══════════════════════════════════════════════════════════
local T1 = Window:CreateTab("Movement", nil)
T1:CreateSection("Speed")
T1:CreateToggle({Name="Enable Speed",   Flag="m1",  Callback=function(v) S.speedOn=v end})
T1:CreateSlider({Name="Speed Value", Range={16,300}, Increment=1, Suffix=" ws",
    CurrentValue=50, Flag="m2", Callback=function(v) S.speedVal=v end})
T1:CreateToggle({Name="Sprint Toggle (shift)", Flag="m3", Callback=function(v) _G.Q_sprint=v end})
T1:CreateToggle({Name="Walk On Water", Flag="m4", Callback=function(v) S.walkOnWater=v end})

T1:CreateSection("Jump")
T1:CreateToggle({Name="Enable Jump Power", Flag="m5", Callback=function(v) S.jumpOn=v end})
T1:CreateSlider({Name="Jump Power", Range={50,500}, Increment=1,
    CurrentValue=100, Flag="m6", Callback=function(v) S.jumpVal=v end})
T1:CreateToggle({Name="Infinite Jump", Flag="m7", Callback=function(v) S.infJump=v end})
T1:CreateToggle({Name="High Jump Boost (x2)", Flag="m8", Callback=function(v) S.jumpBoost=v end})

T1:CreateSection("Fly & Noclip")
T1:CreateToggle({Name="Noclip",          Flag="m9",  Callback=function(v) S.noclip=v end})
T1:CreateToggle({Name="Fly (BodyVelocity)", Flag="m10", Callback=function(v) S.flyOn=v end})
T1:CreateSlider({Name="Fly Speed", Range={10,300}, Increment=1,
    CurrentValue=80, Flag="m11", Callback=function(v) S.flyVal=v end})
T1:CreateToggle({Name="CFrame Fly (no BV, harder to detect)", Flag="m12", Callback=function(v) S.cframeFly=v end})

T1:CreateSection("Physics")
T1:CreateToggle({Name="Low Gravity",    Flag="m13", Callback=function(v) S.gravity=v end})
T1:CreateSlider({Name="Gravity Value", Range={10,196}, Increment=1,
    CurrentValue=50, Flag="m14", Callback=function(v) S.gravityVal=v end})
T1:CreateSlider({Name="HipHeight", Range={0,20}, Increment=0.5,
    CurrentValue=2, Flag="m15", Callback=function(v) S.hipHeight=v end})
T1:CreateToggle({Name="Swim Mode (no fall damage)", Flag="m16", Callback=function(v) S.swimMode=v end})

T1:CreateSection("Extras")
T1:CreateToggle({Name="Auto-Sit (sliding)", Flag="m17", Callback=function(v) S.sitOn=v end})
T1:CreateToggle({Name="Spin Character", Flag="m18", Callback=function(v) S.spin=v end})
T1:CreateSlider({Name="Spin Speed", Range={1,30}, Increment=1,
    CurrentValue=5, Flag="m19", Callback=function(v) S.spinSpeed=v end})
T1:CreateButton({Name="Reset All Movement", Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.infJump = false,false,false,false,false
    notify("Movement","все опции сброшены")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 2: COMBAT (20)
-- ═══════════════════════════════════════════════════════════
local T2 = Window:CreateTab("Combat", nil)
T2:CreateSection("Aimbot")
T2:CreateToggle({Name="Enable Aimbot (Camera)", Flag="c1", Callback=function(v) S.aimOn=v end})
T2:CreateSlider({Name="Aimbot FOV (px)", Range={30,500}, Increment=5,
    CurrentValue=150, Flag="c2", Callback=function(v) S.aimFov=v end})
T2:CreateSlider({Name="Smoothing", Range={0.05,1}, Increment=0.05,
    CurrentValue=0.25, Flag="c3", Callback=function(v) S.aimSmooth=v end})
T2:CreateDropdown({Name="Target Part",
    Options={"Head","HumanoidRootPart","UpperTorso","Torso"},
    CurrentOption={"Head"}, Flag="c4",
    Callback=function(o) S.aimPart = type(o)=="table" and o[1] or o end})
T2:CreateToggle({Name="Visible Check (raycast)", Flag="c5",
    Callback=function(v) S.aimVisCheck=v end})
T2:CreateToggle({Name="Team Check (skip Innocents)", Flag="c6",
    Callback=function(v) S.aimTeamCheck=v end})

T2:CreateSection("Trigger / Auto")
T2:CreateToggle({Name="Trigger Bot (auto-shoot on target)", Flag="c7",
    Callback=function(v) S.triggerBot=v end})
T2:CreateButton({Name="Force Fire Current Tool", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") and t:FindFirstChildWhichIsA("RemoteEvent") then
                for _, r in ipairs(t:GetChildren()) do
                    if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                end
            end
        end
    end
end})
T2:CreateButton({Name="Force Reload", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then
                for _, r in ipairs(t:GetChildren()) do
                    if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end
                end
            end
        end
    end
end})
T2:CreateToggle({Name="Auto Reload", Flag="c8", Callback=function(v) S.autoReload=v end})

T2:CreateSection("Knife")
T2:CreateButton({Name="Auto-Equip Knife", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("knife") then
            t.Parent = LP.Character; notify("Knife","equipped"); return
        end
    end
    notify("Knife","нет в инвентаре")
end})
T2:CreateButton({Name="Swing Knife (spam)", Callback=function()
    task.spawn(function()
        for i=1,5 do
            if LP.Character then
                for _, t in ipairs(LP.Character:GetChildren()) do
                    if t:IsA("Tool") and t.Name:lower():find("knife") then
                        if t:FindFirstChildWhichIsA("RemoteEvent") then
                            for _, r in ipairs(t:GetChildren()) do
                                if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                            end
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end})
T2:CreateButton({Name="Face Nearest Player", Callback=function()
    local best, bd
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
            local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
            if not bd or d<bd then bd=d; best=p end
        end
    end
    if best and hrp() then
        local pos = best.Character.HumanoidRootPart.Position
        hrp().CFrame = CFrame.new(hrp().Position, Vector3.new(pos.X, hrp().Position.Y, pos.Z))
    end
end})
T2:CreateButton({Name="Lock Camera To Nearest", Callback=function()
    local best, bd
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and hrp() then
            local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
            if not bd or d<bd then bd=d; best=p end
        end
    end
    if best then Cam.CameraSubject = best.Character:FindFirstChildOfClass("Humanoid") end
end})

T2:CreateSection("Info")
T2:CreateParagraph({Title="Про Silent Aim / Kill Aura",
    Content="В MM2 урон валидируется сервером. Silent Aim и Kill Aura не работают ни в одном хабе, включая платные. Если видишь их в списке — это кнопка-обманка."})
T2:CreateParagraph({Title="Про Aimbot",
    Content="Camera Aimbot работает только на клиенте — двигает твою камеру. На сервер не влияет, но помогает целиться руками."})
T2:CreateParagraph({Title="Рекомендации",
    Content="Smoothing 0.15-0.30 — оптимально. Меньше — палево, больше — не успеваешь."})
T2:CreateButton({Name="Test Aimbot (highlight target 3s)", Callback=function()
    local target = getClosest and getClosest() or nil
    if target and target.Parent then
        local hl = Instance.new("Highlight", target.Parent)
        hl.FillColor = Color3.fromRGB(255,0,255)
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        task.delay(3, function() hl:Destroy() end)
        notify("Aimbot","цель подсвечена 3 сек")
    else
        notify("Aimbot","цель не найдена")
    end
end})
T2:CreateButton({Name="Reset Combat Settings", Callback=function()
    S.aimOn=false; S.triggerBot=false
    notify("Combat","сброшено")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 3: ESP (20)
-- ═══════════════════════════════════════════════════════════
local T3 = Window:CreateTab("ESP", nil)
T3:CreateSection("Players")
T3:CreateToggle({Name="Enable Player ESP", Flag="e1", Callback=function(v) S.espOn=v end})
T3:CreateToggle({Name="Show Name",        CurrentValue=true, Flag="e2", Callback=function(v) S.espName=v end})
T3:CreateToggle({Name="Show Health",      CurrentValue=true, Flag="e3", Callback=function(v) S.espHP=v end})
T3:CreateToggle({Name="Show Distance",    CurrentValue=true, Flag="e4", Callback=function(v) S.espDist=v end})
T3:CreateToggle({Name="Highlight Body",   CurrentValue=true, Flag="e5", Callback=function(v) S.espHL=v end})
T3:CreateToggle({Name="Tracer To Player", Flag="e6", Callback=function(v) S.espTracer=v end})
T3:CreateToggle({Name="Box ESP",          Flag="e7", Callback=function(v) S.espBox=v end})

T3:CreateSection("Role Filters")
T3:CreateToggle({Name="Highlight Murderer (red)",  Flag="e8", Callback=function(v) S.espMurder=v end})
T3:CreateToggle({Name="Highlight Sheriff (blue)",  Flag="e9", Callback=function(v) S.espSheriff=v end})
T3:CreateToggle({Name="Highlight Innocent (green)",Flag="e10", Callback=function(v) S.espInnocent=v end})

T3:CreateSection("Objects")
T3:CreateToggle({Name="Highlight Dropped Weapons", Flag="e11", Callback=function(v) S.hlWeapons=v end})
T3:CreateToggle({Name="Highlight Coins", Flag="e12", Callback=function(v) _G.Q_hlCoins=v end})
T3:CreateToggle({Name="Highlight Corpses", Flag="e13", Callback=function(v) _G.Q_hlCorpses=v end})
T3:CreateToggle({Name="Show Death Markers (X)", Flag="e14", Callback=function(v) _G.Q_deathMarkers=v end})

T3:CreateSection("Advanced")
T3:CreateToggle({Name="Ignore Dead Players", CurrentValue=true, Flag="e15", Callback=function(v) _G.Q_ignoreDead=v end})
T3:CreateToggle({Name="Show Only In FOV",    Flag="e16", Callback=function(v) _G.Q_espFovOnly=v end})
T3:CreateToggle({Name="Rainbow ESP Color",   Flag="e17", Callback=function(v) _G.Q_espRainbow=v end})
T3:CreateButton({Name="Clear All ESP", Callback=function()
    for _, e in pairs(espCache) do
        if e.hl then e.hl:Destroy() end
        if e.bg then e.bg:Destroy() end
    end
    espCache = {}
    notify("ESP","очищено")
end})
T3:CreateButton({Name="Count Visible Players", Callback=function()
    local c=0
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and hrp() then
            local sp, on = Cam:WorldToViewportPoint(p.Character:GetPivot().Position)
            if on then c+=1 end
        end
    end
    notify("ESP","в поле зрения: "..c)
end})
T3:CreateButton({Name="Reset ESP Settings", Callback=function()
    S.espOn,S.espTracer,S.espBox = false,false,false
    notify("ESP","сброшено")
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 4: VISUAL (20)
-- ═══════════════════════════════════════════════════════════
local T4 = Window:CreateTab("Visual", nil)
T4:CreateSection("Lighting")
T4:CreateToggle({Name="Fullbright", Flag="v1", Callback=function(v) S.fullbright=v end})
T4:CreateToggle({Name="Remove Fog", Flag="v2", Callback=function(v) S.noFog=v end})
T4:CreateButton({Name="Set Day (12:00)", Callback=function()
    Lighting.ClockTime = 12; notify("Lighting","день")
end})
T4:CreateButton({Name="Set Night (00:00)", Callback=function()
    Lighting.ClockTime = 0; notify("Lighting","ночь")
end})
T4:CreateButton({Name="Set Blood Moon Red", Callback=function()
    Lighting.Ambient = Color3.fromRGB(80,0,0)
    Lighting.OutdoorAmbient = Color3.fromRGB(60,0,0)
    Lighting.Brightness = 1
    notify("Lighting","красная луна")
end})
T4:CreateButton({Name="Reset Lighting", Callback=function()
    Lighting.Ambient = Color3.fromRGB(70,70,70)
    Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
    Lighting.Brightness = 1
    Lighting.FogEnd = 100000
    Lighting.ClockTime = 14
    S.fullbright,S.noFog = false,false
    notify("Lighting","сброшено")
end})

T4:CreateSection("Camera")
T4:CreateToggle({Name="FOV Changer", Flag="v3", Callback=function(v) S.fovOn=v end})
T4:CreateSlider({Name="FOV Value", Range={40,140}, Increment=1, Suffix="°",
    CurrentValue=70, Flag="v4", Callback=function(v) S.fovVal=v end})
T4:CreateButton({Name="First Person", Callback=function()
    LP.CameraMode = Enum.CameraMode.LockFirstPerson
end})
T4:CreateButton({Name="Third Person", Callback=function()
    LP.CameraMode = Enum.CameraMode.Classic
end})
T4:CreateButton({Name="Zoom Out (FOV 120)", Callback=function()
    Cam.FieldOfView = 120
end})
T4:CreateButton({Name="Reset FOV", Callback=function()
    Cam.FieldOfView = 70; S.fovOn=false
end})

T4:CreateSection("Effects")
T4:CreateToggle({Name="Disable Shadows", Flag="v5", Callback=function(v)
    Lighting.GlobalShadows = not v
end})
T4:CreateToggle({Name="No Ambient (black)", Flag="v6", Callback=function(v)
    if v then
        Lighting.Ambient = Color3.fromRGB(0,0,0)
        Lighting.OutdoorAmbient = Color3.fromRGB(0,0,0)
    end
end})
T4:CreateButton({Name="Remove All Particles", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
            obj.Enabled = false
        end
    end
    notify("Visual","частицы отключены")
end})
T4:CreateButton({Name="Remove Textures (low graphics)", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 1 end
    end
    notify("Visual","текстуры скрыты")
end})
T4:CreateButton({Name="Restore Textures", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") then obj.Transparency = 0 end
    end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 5: TELEPORT (20)
-- ═══════════════════════════════════════════════════════════
local T5 = Window:CreateTab("Teleport", nil)

local tpDropdown
tpDropdown = T5:CreateDropdown({Name="Select Player",
    Options={"(refresh)"}, CurrentOption={"(refresh)"}, Flag="t1",
    Callback=function(o) end})

T5:CreateButton({Name="Refresh Player List", Callback=function()
    local l = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP then table.insert(l, p.Name) end
    end
    if #l==0 then l={"(none)"} end
    tpDropdown:Refresh(l, true)
end})

T5:CreateSection("To Player")
T5:CreateButton({Name="Teleport To Selected", Callback=function()
    local t = Players:FindFirstChild(tpDropdown.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        hrp().CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
    end
end})
T5:CreateButton({Name="Teleport Behind Selected", Callback=function()
    local t = Players:FindFirstChild(tpDropdown.CurrentOption)
    if t and t.Character and t.Character:FindFirstChild("HumanoidRootPart") and hrp() then
        local tPos = t.Character.HumanoidRootPart.CFrame
        hrp().CFrame = tPos * CFrame.new(0,3,3)
    end
end})
T5:CreateButton({Name="Teleport To Random Player", Callback=function()
    local l = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then table.insert(l,p) end
    end
    if #l>0 and hrp() then
        local t = l[math.random(1,#l)]
        hrp().CFrame = t.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
    end
end})

T5:CreateSection("Map")
T5:CreateButton({Name="Teleport To Gun (map)", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") or (obj:IsA("BasePart") and obj.Name:lower():find("gun")) then
            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
            if part and hrp() then hrp().CFrame = part.CFrame + Vector3.new(0,3,0); return end
        end
    end
    notify("TP","gun не найден")
end})
T5:CreateButton({Name="Teleport To Knife (map)", Callback=function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("knife") then
            local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
            if part and hrp() then hrp().CFrame = part.CFrame + Vector3.new(0,3,0); return end
        end
    end
    notify("TP","knife не найден")
end})
T5:CreateButton({Name="Teleport To Random Coin", Callback=function()
    local coins = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("coin") and obj:IsA("BasePart") then
            table.insert(coins, obj)
        end
    end
    if #coins>0 and hrp() then
        hrp().CFrame = coins[math.random(1,#coins)].CFrame + Vector3.new(0,3,0)
    else
        notify("TP","монет не найдено")
    end
end})

T5:CreateSection("Coordinates")
local xIn, yIn, zIn
xIn = T5:CreateInput({Name="X", PlaceholderText="0", RemoveTextAfterFocusLost=false, Callback=function() end})
yIn = T5:CreateInput({Name="Y", PlaceholderText="50", RemoveTextAfterFocusLost=false, Callback=function() end})
zIn = T5:CreateInput({Name="Z", PlaceholderText="0", RemoveTextAfterFocusLost=false, Callback=function() end})
T5:CreateButton({Name="Teleport To Coordinates", Callback=function()
    if hrp() then
        local x = tonumber(xIn) or 0
        local y = tonumber(yIn) or 50
        local z = tonumber(zIn) or 0
        hrp().CFrame = CFrame.new(x,y,z)
    end
end})

T5:CreateSection("Extras")
T5:CreateButton({Name="Save My Position", Callback=function()
    if hrp() then _G.Q_savedPos = hrp().CFrame; notify("TP","позиция сохранена") end
end})
T5:CreateButton({Name="Load Saved Position", Callback=function()
    if _G.Q_savedPos and hrp() then hrp().CFrame = _G.Q_savedPos end
end})
T5:CreateButton({Name="Teleport Up +50", Callback=function()
    if hrp() then hrp().CFrame = hrp().CFrame + Vector3.new(0,50,0) end
end})
T5:CreateButton({Name="Teleport Forward +50", Callback=function()
    if hrp() then hrp().CFrame = hrp().CFrame + Cam.CFrame.LookVector * 50 end
end})
T5:CreateButton({Name="Teleport To Spawn", Callback=function()
    local sp = workspace:FindFirstChildOfClass("SpawnLocation")
    if sp and hrp() then hrp().CFrame = sp.CFrame + Vector3.new(0,5,0) end
end})
T5:CreateButton({Name="Teleport To Highest Point", Callback=function()
    local top, y = nil, -math.huge
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Anchored and obj.Position.Y > y then
            y = obj.Position.Y; top = obj
        end
    end
    if top and hrp() then hrp().CFrame = top.CFrame + Vector3.new(0,5,0) end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 6: WEAPONS (20)
-- ═══════════════════════════════════════════════════════════
local T6 = Window:CreateTab("Weapons", nil)
T6:CreateSection("Equip")
T6:CreateButton({Name="Equip Gun", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent = LP.Character; notify("Weapons","gun equipped"); return end
    end
    notify("Weapons","gun нет")
end})
T6:CreateButton({Name="Equip Knife", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent = LP.Character; notify("Weapons","knife equipped"); return end
    end
    notify("Weapons","knife нет")
end})
T6:CreateButton({Name="Equip Any", Callback=function()
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") then t.Parent = LP.Character; notify("Weapons","equipped "..t.Name); return end
    end
end})
T6:CreateToggle({Name="Auto-Equip Gun", Flag="w1", Callback=function(v) S.autoEquipGun=v end})
T6:CreateToggle({Name="Auto-Equip Knife", Flag="w2", Callback=function(v) S.autoEquipKnife=v end})

T6:CreateSection("Drop")
T6:CreateButton({Name="Drop Current Tool", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then t.Parent = LP.Backpack; break end
        end
    end
end})
T6:CreateButton({Name="Drop All Tools", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then t.Parent = LP.Backpack end
        end
    end
end})

T6:CreateSection("Tracking")
T6:CreateToggle({Name="Highlight Ground Weapons", Flag="w3", Callback=function(v) S.hlWeapons=v end})
T6:CreateToggle({Name="Hide Others' Tools", Flag="w4", Callback=function(v) S.hideTools=v end})
T6:CreateToggle({Name="Auto Reload", Flag="w5", Callback=function(v) S.autoReload=v end})
T6:CreateButton({Name="Count Tools On Map", Callback=function()
    local c=0
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Tool") then c+=1 end
    end
    notify("Weapons","на карте: "..c)
end})

T6:CreateSection("Inventory")
local invLabel = T6:CreateParagraph({Title="Inventory", Content="?"})
T6:CreateButton({Name="Refresh Inventory", Callback=function()
    local l = {}
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") then table.insert(l, t.Name) end
    end
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then table.insert(l, "["..t.Name.."]") end
        end
    end
    invLabel:Set({Title="Inventory", Content=#l>0 and table.concat(l, ", ") or "пусто"})
end})
T6:CreateButton({Name="Check Ammo", Callback=function()
    if not LP.Character then return end
    for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") then
            local a = t:FindFirstChild("Ammo") or t:FindFirstChild("AmmoValue") or t:FindFirstChild("Clip")
            if a then notify("Ammo", t.Name..": "..tostring(a.Value or a.Name)); return end
        end
    end
    notify("Ammo","счётчик не найден")
end})

T6:CreateSection("Utility")
T6:CreateButton({Name="Unequip All", Callback=function()
    if LP.Character then
        for _, t in ipairs(LP.Character:GetChildren()) do
            if t:IsA("Tool") then t.Parent = LP.Backpack end
        end
    end
end})
T6:CreateButton({Name="Reset Weapon Settings", Callback=function()
    S.hlWeapons,S.hideTools,S.autoEquipGun,S.autoEquipKnife=false,false,false,false
    notify("Weapons","сброшено")
end})
T6:CreateButton({Name="Print All My Tools", Callback=function()
    print("=== Tools ===")
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") then print(t.Name) end
    end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 7: CHARACTER (20)
-- ═══════════════════════════════════════════════════════════
local T7 = Window:CreateTab("Character", nil)
T7:CreateSection("Size")
T7:CreateSlider({Name="Body Scale", Range={0.3,3}, Increment=0.1,
    CurrentValue=1, Flag="h1", Callback=function(v)
    S.charSize = v
    local h = hum()
    if h then
        h.BodyHeightScale.Value=v; h.BodyWidthScale.Value=v
        h.BodyDepthScale.Value=v; h.HeadScale.Value=v
    end
end})
T7:CreateSlider({Name="Head Only Scale", Range={0.3,3}, Increment=0.1,
    CurrentValue=1, Flag="h2", Callback=function(v)
    S.headSize=v
    if LP.Character then
        local hd = LP.Character:FindFirstChild("Head")
        if hd then
            for _, m in ipairs(hd:GetChildren()) do
                if m:IsA("SpecialMesh") then m.Scale = Vector3.new(v,v,v) end
            end
        end
    end
end})
T7:CreateButton({Name="Reset Size", Callback=function()
    local h = hum()
    if h then
        h.BodyHeightScale.Value=1; h.BodyWidthScale.Value=1
        h.BodyDepthScale.Value=1; h.HeadScale.Value=1
    end
end})

T7:CreateSection("Visibility")
T7:CreateSlider({Name="Transparency", Range={0,1}, Increment=0.05,
    CurrentValue=0, Flag="h3", Callback=function(v)
    S.transparency=v
    if LP.Character then
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency=v end
        end
    end
end})
T7:CreateToggle({Name="Ghost Mode", Flag="h4", Callback=function(v) S.ghost=v end})
T7:CreateButton({Name="Hide Accessories", Callback=function()
    if LP.Character then
        for _, a in ipairs(LP.Character:GetChildren()) do
            if a:IsA("Accessory") or a:IsA("Hat") then a:Destroy() end
        end
    end
end})

T7:CreateSection("Actions")
T7:CreateButton({Name="Ragdoll Self", Callback=function()
    local h = hum(); if h then h.PlatformStand=true end
end})
T7:CreateButton({Name="Unragdoll", Callback=function()
    local h = hum(); if h then h.PlatformStand=false end
end})
T7:CreateButton({Name="Sit", Callback=function()
    local h = hum(); if h then h.Sit=true end
end})
T7:CreateButton({Name="Stand", Callback=function()
    local h = hum(); if h then h.Sit=false end
end})
T7:CreateButton({Name="Reset Character", Callback=function()
    if LP.Character then LP.Character:BreakJoints() end
end})

T7:CreateSection("Emotes")
local emotes = {"wave","dance","dance2","dance3","laugh","cheer","point","salute"}
local emoteDD = T7:CreateDropdown({Name="Select Emote", Options=emotes,
    CurrentOption={"wave"}, Flag="h5", Callback=function(o) end})
T7:CreateButton({Name="Play Emote", Callback=function()
    local h = hum()
    if h then
        local n = type(emoteDD.CurrentOption)=="table" and emoteDD.CurrentOption[1] or emoteDD.CurrentOption
        pcall(function() h:PlayEmote(n) end)
    end
end})
T7:CreateToggle({Name="Emote Spam", Flag="h6", Callback=function(v) _G.Q_emoteSpam=v end})

T7:CreateSection("Camera")
T7:CreateToggle({Name="Lock Camera To Head", Flag="h7", Callback=function(v) S.camLock=v end})
T7:CreateButton({Name="Reset Camera", Callback=function()
    Cam.CameraSubject = hum(); Cam.CameraType = Enum.CameraType.Custom
end})
T7:CreateButton({Name="First Person", Callback=function()
    LP.CameraMode = Enum.CameraMode.LockFirstPerson
end})
T7:CreateButton({Name="Third Person", Callback=function()
    LP.CameraMode = Enum.CameraMode.Classic
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 8: ROLES & INFO (20)
-- ═══════════════════════════════════════════════════════════
local T8 = Window:CreateTab("Roles & Info", nil)
local myRoleP = T8:CreateParagraph({Title="My Role", Content="-"})
local aliveP  = T8:CreateParagraph({Title="Alive", Content="-"})
local murdP   = T8:CreateParagraph({Title="Murderer", Content="-"})
local sherP   = T8:CreateParagraph({Title="Sheriff", Content="-"})
local dMurdP  = T8:CreateParagraph({Title="Dist to Murderer", Content="-"})
local dSherP  = T8:CreateParagraph({Title="Dist to Sheriff", Content="-"})

T8:CreateButton({Name="Refresh My Role", Callback=function()
    myRoleP:Set({Title="My Role", Content=role(LP)})
end})
T8:CreateButton({Name="Scan All Roles", Callback=function()
    local a, m, s = 0, "-", "-"
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health>0 then
            a+=1
            local r = role(p)
            if r=="Murderer" then m=p.Name end
            if r=="Sheriff" then s=p.Name end
        end
    end
    aliveP:Set({Title="Alive", Content=tostring(a)})
    murdP:Set({Title="Murderer", Content=m})
    sherP:Set({Title="Sheriff", Content=s})
end})
T8:CreateButton({Name="Print Roles To Console", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        print(p.Name, role(p))
    end
end})
T8:CreateButton({Name="Notify All Roles", Callback=function()
    local l={}
    for _, p in ipairs(Players:GetPlayers()) do
        table.insert(l, p.Name..": "..role(p))
    end
    notify("Roles", table.concat(l, ", "), 8)
end})
T8:CreateButton({Name="Who Has Knife?", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Murderer" then notify("Knife Holder", p.Name); return end
    end
    notify("Knife Holder","не найден")
end})
T8:CreateButton({Name="Who Has Gun?", Callback=function()
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Sheriff" then notify("Gun Holder", p.Name); return end
    end
    notify("Gun Holder","не найден")
end})
T8:CreateButton({Name="List Innocents", Callback=function()
    local l={}
    for _, p in ipairs(Players:GetPlayers()) do
        if role(p)=="Innocent" then table.insert(l, p.Name) end
    end
    notify("Innocents", #l>0 and table.concat(l, ", ") or "none", 6)
end})
T8:CreateButton({Name="Copy My Role", Callback=function()
    if setclipboard then setclipboard(role(LP)); notify("Roles","скопировано") end
end})

T8:CreateSection("Detectors")
T8:CreateToggle({Name="Murderer Detector (Red HL)",  Flag="r1", Callback=function(v) S.espMurder=v end})
T8:CreateToggle({Name="Sheriff Detector (Blue HL)",  Flag="r2", Callback=function(v) S.espSheriff=v end})
T8:CreateToggle({Name="Innocent Detector (Green HL)",Flag="r3", Callback=function(v) S.espInnocent=v end})
T8:CreateToggle({Name="Auto-Update Distances", Flag="r4", Callback=function(v) _G.Q_autoDist=v end})
T8:CreateToggle({Name="Warn If Murderer <30 studs", Flag="r5", Callback=function(v) _G.Q_warnM=v end})
T8:CreateToggle({Name="Warn If Sheriff <30 studs", Flag="r6", Callback=function(v) _G.Q_warnS=v end})

T8:CreateSection("Stats")
T8:CreateButton({Name="Count Alive Players", Callback=function()
    local c=0
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health>0 then c+=1 end
    end
    notify("Players","alive: "..c)
end})
T8:CreateButton({Name="Count Dead Players", Callback=function()
    local c=0
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if not h or h.Health<=0 then c+=1 end
        end
    end
    notify("Players","dead: "..c)
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 9: UTILITY (20)
-- ═══════════════════════════════════════════════════════════
local T9 = Window:CreateTab("Utility", nil)
T9:CreateSection("Server")
T9:CreateButton({Name="Rejoin Server", Callback=function() TS:Teleport(game.PlaceId, LP) end})
T9:CreateButton({Name="Server Hop (smallest)", Callback=function()
    local req = (syn and syn.request) or http_request or request
    if not req then return notify("Error","executor no HTTP") end
    local ok, res = pcall(function()
        return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"})
    end)
    if ok and res and res.Body then
        local d = Http:JSONDecode(res.Body)
        local best
        for _, s in ipairs(d.data or {}) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                if not best or s.playing < best.playing then best = s end
            end
        end
        if best then TS:TeleportToPlaceInstance(game.PlaceId, best.id, LP) end
    end
end})
T9:CreateButton({Name="Server Hop (biggest)", Callback=function()
    local req = (syn and syn.request) or http_request or request
    if not req then return end
    local ok, res = pcall(function()
        return req({Url="https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Desc&limit=100"})
    end)
    if ok and res and res.Body then
        local d = Http:JSONDecode(res.Body)
        for _, s in ipairs(d.data or {}) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TS:TeleportToPlaceInstance(game.PlaceId, s.id, LP); return
            end
        end
    end
end})
T9:CreateButton({Name="Copy Job ID", Callback=function()
    if setclipboard then setclipboard(game.JobId); notify("Server","Job ID скопирован") end
end})
T9:CreateButton({Name="Show Place Info", Callback=function()
    notify("Info", game.PlaceId.." / "..game.JobId, 6)
end})

T9:CreateSection("Character")
T9:CreateToggle({Name="Anti-AFK", CurrentValue=true, Flag="u1", Callback=function(v) S.antiAfk=v end})
T9:CreateToggle({Name="Anti-Fling", Flag="u2", Callback=function(v) S.antiFling=v end})
T9:CreateToggle({Name="Anti-Void", Flag="u3", Callback=function(v) S.antiVoid=v end})
T9:CreateToggle({Name="Anti-Ragdoll", Flag="u4", Callback=function(v) S.antiRag=v end})
T9:CreateToggle({Name="Auto-Respawn", Flag="u5", Callback=function(v) S.autoResp=v end})
T9:CreateToggle({Name="Freeze Player", Flag="u6", Callback=function(v) S.freeze=v end})
T9:CreateButton({Name="Reset Character", Callback=function()
    if LP.Character then LP.Character:BreakJoints() end
end})

T9:CreateSection("Chat")
T9:CreateInput({Name="Chat Message", CurrentValue="Quind Hub on top",
    PlaceholderText="текст", RemoveTextAfterFocusLost=false,
    Callback=function(t) S.chatMsg=t end})
T9:CreateToggle({Name="Chat Spam", Flag="u7", Callback=function(v) S.chatSpam=v end})
T9:CreateButton({Name="Send Message Once", Callback=function()
    pcall(function()
        RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(S.chatMsg, "All")
    end)
end})
T9:CreateButton({Name="Clear Chat", Callback=function()
    for _, g in ipairs(game:GetService("CoreGui"):GetDescendants()) do
        if g:IsA("Frame") and g.Name:lower():find("chat") then g:Destroy() end
    end
end})

T9:CreateSection("System")
T9:CreateButton({Name="Show Ping", Callback=function()
    local s = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]
    notify("Ping", math.floor(s:GetValue()).." ms")
end})
T9:CreateButton({Name="Show FPS", Callback=function()
    notify("FPS", math.floor(1/game:GetService("RunService").RenderStepped:Wait()))
end})
T9:CreateButton({Name="Rejoin On Low Health", Callback=function()
    if hum() and hum().Health < 20 then TS:Teleport(game.PlaceId, LP) end
end})

-- ═══════════════════════════════════════════════════════════
-- TAB 10: ANTI / PROTECTION (20)
-- ═══════════════════════════════════════════════════════════
local T10 = Window:CreateTab("Anti / Protection", nil)
T10:CreateSection("Auto-Defend")
T10:CreateToggle({Name="Auto-Flee From Murderer (run away)", Flag="a1", Callback=function(v) _G.Q_flee=v end})
T10:CreateToggle({Name="Auto-Jump When Murderer Near", Flag="a2", Callback=function(v) _G.Q_autoJumpM=v end})
T10:CreateToggle({Name="Auto-Hide (crouch far)", Flag="a3", Callback=function(v) _G.Q_autoHide=v end})
T10:CreateToggle({Name="Auto-Teleport From Murderer", Flag="a4", Callback=function(v) _G.Q_tpFrom=v end})
T10:CreateToggle({Name="Auto-Crouch", Flag="a5", Callback=function(v) _G.Q_crouch=v end})
T10:CreateButton({Name="Panic: Teleport To Random Spot", Callback=function()
    if hrp() then hrp().CFrame = CFrame.new(math.random(-200,200), 80, math.random(-200,200)) end
end})

T10:CreateSection("Detections")
T10:CreateToggle({Name="Warn On Knife Equip (anyone)", Flag="a6", Callback=function(v) _G.Q_warnKnife=v end})
T10:CreateToggle({Name="Warn On Gun Equip (anyone)", Flag="a7", Callback=function(v) _G.Q_warnGun=v end})
T10:CreateToggle({Name="Warn On Player Approach (<15 studs)", Flag="a8", Callback=function(v) _G.Q_warnApproach=v end})
T10:CreateToggle({Name="Highlight Who's Looking At You", Flag="a9", Callback=function(v) _G.Q_seeWatchers=v end})
T10:CreateButton({Name="Notify If Someone Teleports To Me", Callback=function()
    _G.Q_tpWarn = not _G.Q_tpWarn
    notify("Anti","TP-детектор: "..tostring(_G.Q_tpWarn))
end})

T10:CreateSection("Anti-Cheat Bypass")
T10:CreateButton({Name="Bypass: Reset All Velocity", Callback=function()
    local r = hrp(); if r then r.AssemblyLinearVelocity = Vector3.zero end
end})
T10:CreateButton({Name="Bypass: Clear BodyMovers", Callback=function()
    if LP.Character then
        for _, o in ipairs(LP.Character:GetDescendants()) do
            if o:IsA("BodyVelocity") or o:IsA("BodyGyro") or o:IsA("BodyAngularVelocity") then o:Destroy() end
        end
    end
end})
T10:CreateButton({Name="Bypass: Reset WalkSpeed", Callback=function()
    local h = hum(); if h then h.WalkSpeed = 16 end; S.speedOn = false
end})
T10:CreateButton({Name="Bypass: Reset JumpPower", Callback=function()
    local h = hum(); if h then h.JumpPower = 50 end; S.jumpOn = false
end})
T10:CreateButton({Name="Bypass: Unanchor My Character", Callback=function()
    if LP.Character then
        for _, p in ipairs(LP.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.Anchored = false end
        end
    end
end})
T10:CreateButton({Name="Panic: Disable All", Callback=function()
    S.speedOn,S.jumpOn,S.flyOn,S.noclip,S.aimOn,S.espOn,S.triggerBot = false,false,false,false,false,false,false
    S.antiFling,S.antiVoid,S.ghost = false,false,false
    _G.Q_flee,_G.Q_autoJumpM,_G.Q_autoHide,_G.Q_tpFrom = false,false,false,false
    notify("PANIC","всё выключено",6)
end})
T10:CreateButton({Name="Panic: Reset Character", Callback=function()
    if LP.Character then LP.Character:BreakJoints() end
end})

T10:CreateSection("Info")
T10:CreateParagraph({Title="Внимание",
    Content="Anti-Fling, Anti-Void и подобные функции могут конфликтовать с обычной физикой. Если персонаж странно себя ведёт — жми Panic: Disable All."})
T10:CreateButton({Name="Report Active Functions", Callback=function()
    local on = {}
    for k, v in pairs(S) do if v == true then table.insert(on, k) end end
    notify("Active", #on>0 and table.concat(on, ", ") or "none", 8)
end})

-- ═══════════════════════════════════════════════════════════
-- ═══════════════════ ЛОГИКА ═══════════════════
-- ═══════════════════════════════════════════════════════════

local function getClosest()
    local best, bd = nil, S.aimFov
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character then
            local h = p.Character:FindFirstChildOfClass("Humanoid")
            if h and h.Health>0 then
                if S.aimTeamCheck and role(p)=="Innocent" then continue end
                local part = p.Character:FindFirstChild(S.aimPart) or p.Character:FindFirstChild("HumanoidRootPart")
                if part then
                    local sp, on = Cam:WorldToViewportPoint(part.Position)
                    if on then
                        local d = (Vector2.new(sp.X,sp.Y) - Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)).Magnitude
                        if d < bd then bd = d; best = part end
                    end
                end
            end
        end
    end
    return best
end
_G.Q_getClosest = getClosest

-- MAIN LOOP
RunService.Heartbeat:Connect(function()
    local ch = LP.Character
    if not ch then return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if not h then return end

    -- speed / jump / freeze
    if S.freeze then
        h.WalkSpeed = 0; h.JumpPower = 0
    else
        local sp = S.speedOn and S.speedVal or 16
        if _G.Q_sprint and UIS:IsKeyDown(Enum.KeyCode.LeftShift) then sp = sp * 1.5 end
        h.WalkSpeed = sp
        h.JumpPower = S.jumpOn and S.jumpVal or 50
        if S.jumpBoost then h.JumpPower = (S.jumpOn and S.jumpVal or 50) * 2 end
    end

    -- fly
    local r = ch:FindFirstChild("HumanoidRootPart")
    if S.flyOn and r then
        if not flyBV or not flyBV.Parent then
            flyBV = Instance.new("BodyVelocity")
            flyBV.MaxForce = Vector3.new(9e9,9e9,9e9)
            flyBV.Velocity = Vector3.zero
            flyBV.Parent = r
        end
        local dir = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
        flyBV.Velocity = dir * S.flyVal
    else
        if flyBV then flyBV:Destroy() flyBV = nil end
    end

    -- cframe fly
    if S.cframeFly and r then
        local move = Vector3.zero
        if UIS:IsKeyDown(Enum.KeyCode.W) then move += Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then move -= Cam.CFrame.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then move -= Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then move += Cam.CFrame.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0,1,0) end
        if move.Magnitude > 0 then
            r.CFrame = r.CFrame + move * (S.flyVal/60)
        end
    end

    -- noclip
    if S.noclip or S.ghost then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end
        end
    end

    -- gravity
    workspace.Gravity = S.gravity and S.gravityVal or 196.2

    -- hip height
    if r then
        local hip = h:FindFirstChild("HipHeight")
        if hip then hip.Value = S.hipHeight end
    end

    -- spin
    if S.spin and r then
        r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(S.spinSpeed), 0)
    end

    -- auto sit
    if S.sitOn then h.Sit = true end

    -- ghost transparency
    if S.ghost then
        for _, p in ipairs(ch:GetDescendants()) do
            if p:IsA("BasePart") then p.Transparency = 0.7 end
        end
    end

    -- anti-rag
    if S.antiRag and h.PlatformStand then h.PlatformStand = false end

    -- fake death
    if S.fakeDeath then h.PlatformStand = true end
end)

-- INF JUMP
UIS.JumpRequest:Connect(function()
    if S.infJump and hum() then hum():ChangeState(Enum.HumanoidStateType.Jumping) end
end)

-- AIMBOT
RunService.RenderStepped:Connect(function()
    if S.aimOn then
        local t = getClosest()
        if t then
            if S.aimVisCheck then
                local ray = Ray.new(Cam.CFrame.Position, (t.Position - Cam.CFrame.Position).Unit * 500)
                local hit = workspace:FindPartOnRay(ray, LP.Character)
                if not hit or not hit:IsDescendantOf(t.Parent) then return end
            end
            Cam.CFrame = Cam.CFrame:Lerp(CFrame.new(Cam.CFrame.Position, t.Position), S.aimSmooth)
        end
    end
end)

-- TRIGGER BOT
RunService.Heartbeat:Connect(function()
    if S.triggerBot then
        local t = getClosest()
        if t then
            if LP.Character then
                for _, tool in ipairs(LP.Character:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, r in ipairs(tool:GetChildren()) do
                            if r:IsA("RemoteEvent") then pcall(function() r:FireServer() end) end
                        end
                    end
                end
            end
        end
    end
end)

-- ESP
local function clearESP(p)
    local e = espCache[p]
    if e then
        if e.hl then e.hl:Destroy() end
        if e.bg then e.bg:Destroy() end
        espCache[p] = nil
    end
end

local function updateESP(p)
    if p == LP then return end
    local ch = p.Character
    if not ch or not S.espOn then clearESP(p); return end
    local h = ch:FindFirstChildOfClass("Humanoid")
    if _G.Q_ignoreDead and (not h or h.Health <= 0) then clearESP(p); return end

    local e = espCache[p]
    if not e then
        e = {}
        e.hl = Instance.new("Highlight")
        e.hl.FillColor = Color3.fromRGB(255,60,60)
        e.hl.OutlineColor = Color3.fromRGB(255,255,255)
        e.hl.FillTransparency = 0.55
        e.hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        e.hl.Parent = ch

        e.bg = Instance.new("BillboardGui")
        e.bg.Size = UDim2.new(0,220,0,40)
        e.bg.StudsOffset = Vector3.new(0,3,0)
        e.bg.AlwaysOnTop = true
        e.bg.Parent = ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")

        e.label = Instance.new("TextLabel")
        e.label.Size = UDim2.new(1,0,1,0)
        e.label.BackgroundTransparency = 1
        e.label.TextColor3 = Color3.fromRGB(255,255,255)
        e.label.TextStrokeTransparency = 0
        e.label.Font = Enum.Font.GothamBold
        e.label.TextSize = 14
        e.label.Parent = e.bg

        espCache[p] = e
    end

    e.hl.Parent = ch
    e.hl.Enabled = S.espHL
    if _G.Q_espRainbow then
        e.hl.FillColor = Color3.fromHSV((tick()*0.3)%1, 1, 1)
    end
    local hd = ch:FindFirstChild("Head") or ch:FindFirstChild("HumanoidRootPart")
    if hd then e.bg.Parent = hd end

    local txt = {}
    if S.espName then table.insert(txt, p.Name) end
    if S.espHP and h then table.insert(txt, "["..math.floor(h.Health).."]") end
    if S.espDist and hrp() and ch:FindFirstChild("HumanoidRootPart") then
        local d = dist(ch.HumanoidRootPart.Position, hrp().Position)
        table.insert(txt, math.floor(d).."m")
    end
    e.label.Text = table.concat(txt, " ")
end

RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do updateESP(p) end
end)
Players.PlayerRemoving:Connect(clearESP)

-- ROLE HIGHLIGHTS
RunService.RenderStepped:Connect(function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local r = role(p)
            local want = (S.espMurder and r=="Murderer")
                      or (S.espSheriff and r=="Sheriff")
                      or (S.espInnocent and r=="Innocent")
            local hl = roleHighlights[p]
            if want then
                if not hl then
                    hl = Instance.new("Highlight")
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.FillTransparency = 0.6
                    hl.Parent = p.Character
                    roleHighlights[p] = hl
                end
                hl.FillColor = r=="Murderer" and Color3.fromRGB(255,0,0)
                             or r=="Sheriff" and Color3.fromRGB(0,120,255)
                             or Color3.fromRGB(0,255,0)
            elseif hl then
                hl:Destroy(); roleHighlights[p] = nil
            end
        end
    end
end)

-- VISUAL LOOP
RunService.Heartbeat:Connect(function()
    if S.fullbright then
        Lighting.Ambient = Color3.fromRGB(255,255,255)
        Lighting.Brightness = 2
        Lighting.ClockTime = 12
    end
    if S.noFog then
        Lighting.FogEnd = 1e6
        Lighting.FogStart = 1e6
    end
    Cam.FieldOfView = S.fovOn and S.fovVal or 70
end)

-- ANTI-FLING
RunService.Heartbeat:Connect(function()
    if S.antiFling and LP.Character then
        for _, o in ipairs(LP.Character:GetDescendants()) do
            if o:IsA("BodyVelocity") or o:IsA("BodyAngularVelocity") or o:IsA("BodyGyro") then
                o:Destroy()
            end
        end
    end
end)

-- ANTI-VOID
RunService.Heartbeat:Connect(function()
    if S.antiVoid and hrp() and hrp().Position.Y < -50 then
        hrp().CFrame = CFrame.new(0, 50, 0)
    end
end)

-- ANTI-AFK
LP.Idled:Connect(function()
    if S.antiAfk then
        VU:CaptureController()
        VU:ClickButton2(Vector2.new())
    end
end)

-- AUTO RESPAWN
LP.CharacterAdded:Connect(function()
    if S.autoResp then
        task.wait(0.5)
        if LP.Character then LP.Character:BreakJoints() end
    end
end)

-- CHAT SPAM
task.spawn(function()
    while task.wait(2) do
        if S.chatSpam then
            pcall(function()
                RS.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(S.chatMsg, "All")
            end)
        end
    end
end)

-- EMOTE SPAM
task.spawn(function()
    while task.wait(1.5) do
        if _G.Q_emoteSpam and hum() then
            pcall(function() hum():PlayEmote("dance") end)
        end
    end
end)

-- AUTO EQUIP
task.spawn(function()
    while task.wait(1) do
        if S.autoEquipGun and LP.Character then
            local has = false
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("gun") then has = true end
            end
            if not has then
                for _, t in ipairs(LP.Backpack:GetChildren()) do
                    if t:IsA("Tool") and t.Name:lower():find("gun") then t.Parent = LP.Character; break end
                end
            end
        end
        if S.autoEquipKnife and LP.Character then
            local has = false
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") and t.Name:lower():find("knife") then has = true end
            end
            if not has then
                for _, t in ipairs(LP.Backpack:GetChildren()) do
                    if t:IsA("Tool") and t.Name:lower():find("knife") then t.Parent = LP.Character; break end
                end
            end
        end
    end
end)

-- AUTO RELOAD
task.spawn(function()
    while task.wait(3) do
        if S.autoReload and LP.Character then
            for _, t in ipairs(LP.Character:GetChildren()) do
                if t:IsA("Tool") then
                    for _, r in ipairs(t:GetChildren()) do
                        if r:IsA("RemoteEvent") then pcall(function() r:FireServer("Reload") end) end
                    end
                end
            end
        end
    end
end)

-- WEAPON HIGHLIGHT
task.spawn(function()
    while task.wait(0.5) do
        if S.hlWeapons then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Tool") then
                    local hl = obj:FindFirstChild("__Q_WeaponHL__")
                    if not hl then
                        hl = Instance.new("Highlight")
                        hl.Name = "__Q_WeaponHL__"
                        hl.FillColor = Color3.fromRGB(255,200,0)
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Parent = obj
                    end
                end
            end
        else
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Tool") then
                    local hl = obj:FindFirstChild("__Q_WeaponHL__")
                    if hl then hl:Destroy() end
                end
            end
        end
    end
end)

-- HIDE OTHERS' TOOLS
task.spawn(function()
    while task.wait(0.3) do
        if S.hideTools then
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character then
                    for _, t in ipairs(p.Character:GetChildren()) do
                        if t:IsA("Tool") then
                            for _, part in ipairs(t:GetDescendants()) do
                                if part:IsA("BasePart") then part.LocalTransparencyModifier = 1 end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- AUTODIST + WARNINGS
task.spawn(function()
    while task.wait(1) do
        if _G.Q_autoDist and hrp() then
            local dm, ds = "-", "-"
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local r = role(p)
                    local d = math.floor(dist(p.Character.HumanoidRootPart.Position, hrp().Position))
                    if r == "Murderer" then dm = d.." studs" end
                    if r == "Sheriff" then ds = d.." studs" end
                end
            end
            dMurdP:Set({Title="Dist to Murderer", Content=dm})
            dSherP:Set({Title="Dist to Sheriff", Content=ds})
        end
    end
end)

-- AUTO DEFEND
RunService.Heartbeat:Connect(function()
    if not hrp() then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p~=LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local d = dist(p.Character.HumanoidRootPart.Position, hrp().Position)
            local r = role(p)
            if r == "Murderer" then
                if d < 30 then
                    if _G.Q_warnM then notify("⚠ MURDERER", p.Name.." в "..math.floor(d), 2) end
                    if _G.Q_flee then
                        local away = (hrp().Position - p.Character.HumanoidRootPart.Position).Unit * 40
                        hrp().CFrame = hrp().CFrame + away
                    end
                    if _G.Q_autoJumpM then
                        local h = hum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
                    end
                    if _G.Q_tpFrom then
                        hrp().CFrame = CFrame.new(math.random(-150,150), 80, math.random(-150,150))
                    end
                end
            end
            if r == "Sheriff" and d < 30 and _G.Q_warnS then
                notify("⚠ SHERIFF", p.Name.." в "..math.floor(d), 2)
            end
        end
    end
end)

-- WATCHER DETECTOR
task.spawn(function()
    while task.wait(0.5) do
        if _G.Q_seeWatchers then
            for _, p in ipairs(Players:GetPlayers()) do
                if p~=LP and p.Character and p.Character:FindFirstChild("Head") and hrp() then
                    local look = p.Character.Head.CFrame.LookVector
                    local toMe = (hrp().Position - p.Character.Head.Position).Unit
                    if look:Dot(toMe) > 0.85 then
                        notify("👁 Watch", p.Name.." смотрит на тебя", 1.5)
                    end
                end
            end
        end
    end
end)

-- CAM LOCK
RunService.RenderStepped:Connect(function()
    if S.camLock then
        local hd = LP.Character and LP.Character:FindFirstChild("Head")
        if hd then Cam.CameraSubject = hd end
    end
end)

-- ═══════════════ READY ═══════════════
Rayfield:Notify({
    Title = "Quind Hub",
    Content = "Загружено. made by hashtrash.",
    Duration = 6,
})