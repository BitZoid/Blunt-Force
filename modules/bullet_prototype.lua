bulletProto = {}

--bullet callbacks libraries
require "modules/callbacks.bullet_1" --AKA bullet_1_callbacks

--signals the targeted factory to spawn a object with the properties provided
--factory : a string with the url to the factory
--callback : a function that will be called upon the death of the bullet
--direction, position : vector3
--speed : integer
--child-properties: if a child is desired, child-properties will contain the information
bulletProto.newBullet = function(factory_url, position, direction, speed, lifespan, callback_id, callback, reflected)	
	reflected = reflected or false
	thisBullet = factory.create(
		factory_url, 
		position, 
		vmath.quat_axis_angle(vmath.vector3(0, 0,1),math.atan2(direction.y,direction.x)), 
		{direction = direction, speed = speed, lifespan = lifespan, callback_id = callback_id, reflected = reflected}
	)	
	if not bullet_1_callbacks[callback_id]then
		bullet_1_callbacks[callback_id] = callback
	end
end

bulletProto.changeCallback = function(callback, callback_id)
	if not bullet_1_callbacks[callback_id] == callback then
		bullet_1_callbacks[callback_id] = callback
	end
end

bulletProto.bulletTypes = {
	"/bullet_1_factory#factory",
}