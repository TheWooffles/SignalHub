local esp = loadstring(game:HttpGet('https://raw.githubusercontent.com/0f76/seere_v3/main/ESP/v3_esp.lua'))()

esp.enabled = true

esp.teamcheck = false

esp.outlines = true
esp.shortnames = true
esp.team_boxes = {true,Color3.fromRGB(255,255,255),Color3.fromRGB(1,1,1),0}
esp.team_chams = {true,Color3.fromRGB(138, 139, 194),Color3.fromRGB(138, 139, 194),.25,.75,true}
esp.team_names = {true,Color3.fromRGB(255,255,255)}
esp.team_weapon = { true, Color3.fromRGB(255,255,255)}
esp.team_distance = true
esp.team_health = true

local fov = 20
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Cam = game.Workspace.CurrentCamera

local FOVring = Drawing.new("Circle")
FOVring.Visible = true
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(255, 255, 255) -- White color
FOVring.Filled = false
FOVring.Radius = fov
FOVring.Position = Cam.ViewportSize / 2

local function updateDrawings()
        local camViewportSize = Cam.ViewportSize
        FOVring.Position = camViewportSize / 2
        end

        local function onKeyDown(input)
                if input.KeyCode == Enum.KeyCode.Delete then
                        RunService:UnbindFromRenderStep("FOVUpdate")
                                FOVring:Remove()
                                end
                                end

                                        UserInputService.InputBegan:Connect(onKeyDown)

                                        local function lookAt(target)
                                            local lookVector = (target - Cam.CFrame.Position).unit
                                                local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
                                                    Cam.CFrame = newCFrame
                                                    end

                                                    local function getClosestPlayerInFOV(trg_part)
                                                        local nearest = nil
                                                            local last = math.huge
                                                                local playerMousePos = Cam.ViewportSize / 2

                                                                    for _, player in ipairs(Players:GetPlayers()) do
                                                                            if player ~= Players.LocalPlayer then
                                                                                        local part = player.Character and player.Character:FindFirstChild(trg_part)
                                                                                                    if part then
                                                                                                                    local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                                                                                                                                    local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude

                                                                                                                                                    if distance < last and isVisible and distance < fov then
                                                                                                                                                                        last = distance
                                                                                                                                                                                            nearest = player
                                                                                                                                                                                                    if Player.Team ~= LocalPlayer.Team then 
                                                                                                                                                                                                        return
                                                                                                                                                                                                            end
                                                                                                                                                                                                                        end
                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                    end

                                                                                                                                                                                                                                        return nearest
                                                                                                                                                                                                                                        end

                                                                                                                                                                                                                                        RunService.RenderStepped:Connect(function()
                                                                                                                                                                                                                                            updateDrawings()
                                                                                                                                                                                                                                                local closest = getClosestPlayerInFOV("Head")
                                                                                                                                                                                                                                                    if closest and closest.Character:FindFirstChild("Head") then
                                                                                                                                                                                                                                                            lookAt(closest.Character.Head.Position)
                                                                                                                                                                                                                                                                end
                                                                                                                                                                                                                                                                end)
