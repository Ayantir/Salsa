--[[
-------------------------------------------------------------------------------
-- Dyer, by Ayantir
-------------------------------------------------------------------------------
This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial — You may not use the material for commercial purposes.
    ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode
]]

local ADDON_NAME = "Salsa"
local soundToPlay = 1
local sounds = {}

local function ToggleUI()
	SCENE_MANAGER:ToggleTopLevel(Salsa)
end

local function OnAddonLoaded(_, addon)

	if addon == ADDON_NAME then
		
		for soundName, value in pairs(SOUNDS) do
			table.insert(sounds, {n = soundName, v = value})
		end
		
		table.sort(sounds, function(a, b) return a.n < b.n end)
		
		local soundName = GetControl(Salsa, "SoundName")
		soundName:SetText(sounds[soundToPlay].n)
		
		SCENE_MANAGER:RegisterTopLevel(Salsa, false)
		
		SLASH_COMMANDS["/salsa"] = ToggleUI
		
		EVENT_MANAGER:UnregisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED)
		
	end
	
end

function Salsa_NextSound(_, delta)
	soundToPlay = soundToPlay + delta
	soundToPlay = math.max(soundToPlay, 1)
	soundToPlay = math.min(soundToPlay, #sounds)
	
	local soundName = GetControl(Salsa, "SoundName")
	soundName:SetText(sounds[soundToPlay].n)	
end

function Salsa_PlaySound()
	PlaySound(sounds[soundToPlay].v)
end

EVENT_MANAGER:RegisterForEvent(ADDON_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)