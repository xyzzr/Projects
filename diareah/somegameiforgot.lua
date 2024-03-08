local Config = {
    WindowName = "< Clearware | Version 1.0A >",
    detailsofgamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name .. " | " .. game.PlaceId,
    Color = Color3.fromRGB(0,47,108),
    Keybind = Enum.KeyCode.Z
}
local tpservice = game:GetService("TeleportService")


-- Teleport Stuff
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end -- End of teleport stuff


function TPReturner() -- Serverhop
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function switchServer()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xyzzr/libarys/main/Bracket%20V3.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))
local Tab1 = Window:CreateTab(Config.detailsofgamename)
local Section1 = Tab1:CreateSection("Main")
local Section2 = Tab1:CreateSection("Misc")



---------------------- Start of script / First Section
Section1:CreateLabel("Shitty Titty Start")

-------------
local Button1 = Section1:CreateButton("Button 1", function()
	print("Click Button 1")
end)
Button1:AddToolTip("Just a button stupid bitch")
-------------
local Toggle1 = Section1:CreateToggle("Toggle 1", nil, function(State)
	print(State)
end)
Toggle1:AddToolTip("Just a toggle retard")

-------------

local TextBox1 = Section1:CreateTextBox("TextBox 1", "Only numbers", true, function(Value)
	print(Value)
end)

-------------
local Slider1 = Section1:CreateSlider("Slider 1", 0,100,nil,true, function(Value)
	print(Value)
end)
Slider1:AddToolTip("Slider 1 ToolTip")
Slider1:SetValue(50)

---------------------- A functioning dropdown

local Dropdown1 = Section1:CreateDropdown("Dropdown", {"Example1","Example2","Example3", "Example4"}, function(String)
    locationSelected = String
end)

local Button1 = Section1:CreateButton("Click this after selecting", function()
    if locationSelected == "Example1" then
            print("Whale is gay 1")
        elseif locationSelected == "Example2" then
            print("Whale is gay 2")
        elseif locationSelected == "Example3" then
             print("Whale is gay 3")
        elseif locationSelected == "Example4" then
            print("Whale is gay 4")
    end
end)

----------------------- Player Movement Section
Section1:CreateLabel("Client Movement")


local Slider1 = Section1:CreateSlider("Walkspeed", 16,500,16,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end)
local Slider1 = Section1:CreateSlider("Jumppower", 50,500,50,true, function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end)


local Toggle2 = Section1:CreateToggle("Infinite jump", nil, function(State)
    toggle = State
       local Player = game:GetService("Players").LocalPlayer
        Player:GetMouse().KeyDown:connect(function(k)
        if toggle then
            wait()
           if k:byte() == 32 then
           Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
           Humanoid:ChangeState("Jumping")
           wait(0.1)
           Humanoid:ChangeState("Seated")
                  end
            end
      end)
end)

-------------

getgenv().esp = false
getgenv().teamcheck = false
getgenv().Color = Color3.fromRGB(255, 0, 0)

local Toggle3 = Section2:CreateToggle("Toggle Chams", nil, function(State)
			getgenv().esp = State
		spawn(function()
		while wait() do
		    if not getgenv().esp then
		          for i,v in pairs(game.Players:GetChildren()) do
		              if v.Character and v.Character:FindFirstChild("Highlight") then
		                  local Highlight = v.Character:FindFirstChild("Highlight")
		                  Highlight.Enabled = false
    		      end
		      end 
		      else
		          for i,v in pairs(game.Players:GetChildren()) do
		             if getgenv().teamcheck == true then
		               if v.Character and v ~= game.Players.LocalPlayer and v.TeamColor ~= game.Players.LocalPlayer.TeamColor then
    		                 if v.Character:FindFirstChild("Highlight") then
    		                 local Highlight = v.Character:FindFirstChild("Highlight") 
    		                 Highlight.Enabled = true
    		                 Highlight.FillColor = getgenv().Color
    		                 Highlight.Adornee = v.Character
    		                 else
    		                 local Highlight = Instance.new("Highlight",v.Character)
    		                 Highlight.Enabled = true
    		                 Highlight.FillColor = getgenv().Color
    		                 Highlight.Adornee = v.Character
    		              end       
    		           end  
		                if v.TeamColor == game.Players.LocalPlayer.TeamColor then
    		              if v.Character and v.Character:FindFirstChild("Highlight") then
    		                  local Highlight = v.Character:FindFirstChild("Highlight")
        		              Highlight.Enabled = false
        		          end    
    		            end 
    		          else
    		              if v.Character and v ~= game.Players.LocalPlayer then
    		                 if v.Character:FindFirstChild("Highlight") then
    		                 local Highlight = v.Character:FindFirstChild("Highlight") 
    		                 Highlight.Enabled = true
    		                 Highlight.FillColor = getgenv().Color
    		                 Highlight.Adornee = v.Character
    		                 else
    		                 local Highlight = Instance.new("Highlight",v.Character)
    		                 Highlight.Enabled = true
    		                 Highlight.FillColor = getgenv().Color
    		                 Highlight.Adornee = v.Character
    		              end       
    		           end    
		            end       
		      end    
		    end  
		end    
		end)
end)
Toggle3:AddToolTip("Cham other players and see them trough walls")

local Colorpicker1 = Section2:CreateColorpicker("Cham Color", function(Color)
   getgenv().Color = Color
end)

----------------------- Other Section
Section2:CreateLabel("Other")

local Button2 = Section2:CreateButton("Anti-Afk", function()
	print("Click Button 1")
end)
Button2:AddToolTip("Prevents roblox from kicking you when you are afk")

local Button3 = Section2:CreateButton("Instant ProximityPrompt", function()
game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(prompt)
   prompt.HoldDuration = 0
    end)
end)
Button3:AddToolTip("Proximity Prompts become instant")

----------------------- Server Tab
Section2:CreateLabel("Server")

local Button4 = Section2:CreateButton("Rejoin", function()
tpservice:Teleport(game.PlaceId, plr)
end) 
local Button5 = Section2:CreateButton("Server hop", function()
switchServer()
end)   

-------------------------------- UI Settings Section
Section2:CreateLabel("UI Settings")

local Toggle4 = Section2:CreateToggle("UI Toggle", nil, function(State)
    Window:Toggle(State)
end)

-- credits to jan for patterns
local Dropdown3 = Section2:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Cats","Floral"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Cats" then
		Window:SetBackground("13976195638")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker3 = Section2:CreateColorpicker("UI Theme Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(Config.Color)


local Slider3 = Section2:CreateSlider("Decal Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section2:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)


----------------------- Credits // End of UI
Section2:CreateLabel("Credits")
Section2:CreateLabel("Jailedd: Owner")
Section2:CreateLabel("Lonelywhale: Contribution")


-- UI Keyblind setter
Toggle4:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
    Config.Keybind = Enum.KeyCode[Key]
end)    
Toggle4:SetState(true) 
