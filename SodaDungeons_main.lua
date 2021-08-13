local addonName, addonTable = ...
local frame = CreateFrame("FRAME", "coolframe");
frame:RegisterEvent("PLAYER_ENTERING_WORLD");
frame:RegisterEvent("ADDON_LOADED");
frame:RegisterEvent("PLAYER_LEVEL_UP");

colors = {}
colors["gray"] = "|cFF889D9D"
colors["green"] = "|cFF458B00"
colors["yellow"] = "|cFFFFF569"
colors["orange"] = "|cFFFF8000"
colors["red"] = "|cFFFF3F40"

local function PrintRecommendedDungeons(level)
    print("Recommended dungeons for your level:")
    for key, val in ipairs(addonTable.DungeonsByLevel) do
        local name, lowerRange, upperRange = val[1], val[2], val[3]
        local color
        if level >= lowerRange and level <= upperRange then
            if level == lowerRange then
                color = colors["orange"]
            else
                color = colors["yellow"]
            end
            print(color, name, lowerRange, upperRange, "|r")
        end
    end
end

local function PrintAllDungeons(level)
    for key, val in ipairs(addonTable.DungeonsByLevel) do
        name, lowerRange, upperRange = val[1], val[2], val[3]
        local color
        if level >= upperRange + 3 then 
            color = colors["gray"]
        elseif level >= upperRange then
            color = colors["green"]
        elseif level > lowerRange then
            color = colors["yellow"]
        elseif level == lowerRange then
            color = colors["orange"]
        else
            color = colors["red"]
        end
        print(color, name, lowerRange, upperRange, "|r") --gray
    end
end

function frame:OnEvent(event, arg1, arg2, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        PrintRecommendedDungeons(UnitLevel("player"))
    end
    if event == "PLAYER_LEVEL_UP" then
        PrintRecommendedDungeons(arg1)
    end
end
frame:SetScript("OnEvent", frame.OnEvent)

SLASH_DD1 = "/sodadungeon"
SLASH_DD2 = "/sd"
local function MyCommands(msg, editbox)
    local level = UnitLevel("player")
    if msg == "all" then
        PrintAllDungeons(level)
    else --no additional parameters
        PrintRecommendedDungeons(level)
    end
end
SlashCmdList["SD"] = MyCommands