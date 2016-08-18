local watchedGUID
local soulStone = 20707
local darkIntent = 109773 -- For debugging
local funItem = "Seafarer's Slidewhistle"

-- Not using "self" or "event" right now, but if I need them in the future reindexing all of the select calls would be a pain.
function ScornStone(self, event, ...)
	local eventType = select(2, ...)
	local targetGUID, targetName = select(8, ...)

	-- First, check to see if we need to watch someone new.
	if (
		eventType == "SPELL_CAST_SUCCESS"
	) then

		local spellid = select(11, ...);
		

		--print(targetGUID)
		--print(targetName)
		--print(spellid)

		if (
			spellid == soulStone
		) then

			watchedGUID = targetGUID
			SendChatMessage(targetName .. ", I believe in you.");
			-- Still need to figure out how to do this.
			-- UseItemByName(funItem)
		end
	-- Failing that, see if our current target kicked the bucket.
	elseif (
		eventType == "UNIT_DIED"
	) then

		if (
			watchedGUID
			and targetGUID == watchedGUID
		) then

			SendChatMessage(targetName .. ", I'm not angry, just disappointed.");
			-- Probably better to unregister the event.  Maybe someday!
			watchedGUID = nil
		end
	end
end