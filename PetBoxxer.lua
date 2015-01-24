local petinfoframe = CreateFrame("Frame")

total = 0
petDead = false

petinfoframe:RegisterEvent("PLAYER_ENTERING_WORLD")
petinfoframe:RegisterUnitEvent("UNIT_PET", "player")
petinfoframe:SetScript("OnUpdate", function(self, elapsed)
	
										total = total + elapsed
										if total >= 1 then
											petStatus()
											total = 0
										end
									end)



local PET_GUID;

--[[
  Constants
--]]
PARTY = "PARTY";
SAY = "SELF";

function HelloWorld()
	print("Pet Boxxer 0.1 loaded."); 
end

local function PLAYER_ENTERING_WORLD()
	-- Set global pet status
	petDead = UnitIsDeadOrGhost("pet") 
end

function AddMessage(msg)
	if UnitInParty("player") then	
		SendChatMessage(msg, PARTY)
	else
		SendChatMessage(msg, SELF)
	end
end

function petStatus()
	local localPetDead = UnitIsDeadOrGhost("pet")	
	
	if localPetDead and not petDead then
		
		if localPetDead then
			AddMessage("Pet died.")
			-- set global pet dead to true so we do not spam
			petDead = true
		end
	end	
	
	-- Check if pet has been revived
	if not localPetDead and petDead then	
		AddMessage("My pet lives once more.")
		
		petDead = false
	end
end

function UNIT_PET(unit)
	AddMessage("test")
	petStatus()
end