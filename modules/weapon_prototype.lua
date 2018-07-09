--bullet callbacks libraries
require "modules/callbacks.bullet_1" --aka bullet_1_callbacks

weaponProto = {}

weaponProto.reflectBullet = function( callback, callback_id, propertiesTable, targetUrl)
	--callback = (if a different callback is desired)
	--callback_id = integer location of where the callback is to be positioned in the callbacks table
	
	--propertiesTable can include:
		--speedMultiplier = scalar to multiply the speed(and speed_initial) by
		--speed = sets the speed(and speed_initial) to the hard value
		--lifespanMultiplier = scalar to multiply the lifespan(and lifespan_initial) by (lifespan is reverted to initial_lifespan before multiplied)
		--lifespan = sets the lifespan(and lifespan_initial) to the hard value
	
	if callback and callback_id then
		propertiesTable.callback_id = callback_id
		--checks the bullet's type to determine which callback library should be updated
		if go.get(targetUrl, "type") == 1 then
			if (not bullet_1_callbacks[callback_id] == callback) or  bullet_1_callbacks[callback_id] == nil then
				print("updating callback...")
				bullet_1_callbacks[callback_id] = callback
			end
		end
	end
	msg.post(targetUrl, "weaponReflect", propertiesTable)
end