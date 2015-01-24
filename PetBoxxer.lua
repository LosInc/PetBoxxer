local petinfoframe = CreateFrame("Frame")

total = 0
petDead = false
petExistAntiSpam = 0

petinfoframe:RegisterEvent("PLAYER_ENTERING_WORLD")
petinfoframe:RegisterUnitEvent("UNIT_PET", "player")
petinfoframe:SetScript("OnUpdate", function(self, elapsed)	
										total = total + elapsed
										if total >= 2 then
											petStatus()
											total = 0
										end
									end)

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
		SendChatMessage(date("%H:%M:%S") .. ": " .. msg, PARTY)
	else
		SendChatMessage(date("%H:%M:%S") .. ": " .. msg, SELF)
	end
end

function petStatus()
	local localPetDead = UnitIsDeadOrGhost("pet")	
	local PetExists = UnitExists("pet")
	local petName = ""
	
	if PetExists then
		petName = UnitName("pet");	
	else
		petName = "pet"
	end
		
	-- If not dead or revived, maybe dissmissed?	
	if not PetExists and petExistAntiSpam < 1 and not petDead then
		AddMessage("I have no pet right now.")	 
		petExistAntiSpam = petExistAntiSpam + 1
	end
	
	if PetExists and petExistAntiSpam > 0 then
		AddMessage("My pet (" .. petName ..") is back again.")
		petExistAntiSpam = 0
	end	
	
	if localPetDead and not petDead then
		if localPetDead then
			AddMessage("My pet (" .. petName ..") just died.")			
			-- set global pet dead to true so we do not spam
			petDead = true
		end
	end	
	
	-- Check if pet has been revived
	if not localPetDead and petDead then	
		AddMessage("My pet (" .. petName ..") is alive again.")
		
		petDead = false
	end

end