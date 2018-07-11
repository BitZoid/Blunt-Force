-- Functions used in enemy AI
enemyProto = {}

--returns true if the target GO is within the radius from the origin
enemyProto.targetInRange = function(origin, target, radius)		return math.sqrt(math.abs(origin.x - target.x)^2 + math.abs(origin.y - target.y)^2) <= radius		end

--returns a random direction vector with a magnitude of 1 (normalized)
enemyProto.randomDirection = function()		return vmath.normalize(vmath.vector3((math.random()-.5) * 2, (math.random()-.5) * 2, 0))		end

--returns a normalized v3 pointing to the target from the go's position
enemyProto.target = function(targetPosition)		return vmath.normalize(vmath.vector3(targetPosition.x - go.get(".", "position").x, targetPosition.y - go.get(".", "position").y, 0))	end

--returns a float inbetweeen the two numbers provided, rounded up and down respectively
enemyProto.randomFloat = function(rangeMin, rangeMax)		return math.random(math.ceil(rangeMin), math.floor(rangeMax - 1)) + math.random()		end


--simplified call to the go.animate function
enemyProto.delay = function(duration, var, callbackFunc)		go.animate("#", var, go.PLAYBACK_ONCE_FORWARD, 0, go.EASING_LINEAR, duration, 0, callbackFunc)		end

--Returns a velocity that is a degree inbetween rangeMin and rangeMax offset from the previous velocity (Normalized)
enemyProto.derivativeDirection = function(previousDir, rangeMin, rangeMax)
	output = vmath.vector3(0)
	deviation = enemyProto.randomFloat(rangeMin, rangeMax)
	output.x = math.cos(math.atan2(previousDir.y, previousDir.x) + math.pi*deviation/180)
	output.y = math.sin(math.atan2(previousDir.y, previousDir.x) + math.pi*deviation/180)
	return output
end

--- enemyProto . rayCast
--simpler syntax for making raycasts
--requires code in on_message to catch and do something with the returns
enemyProto.rayCast = function(targetPosition, targetGroups, id)
	targetGroups = targetGroups or {_HeroHash, _WallsHash}
	id = id or 0
	physics.ray_cast( go.get(".", "position"), targetPosition, targetGroups, id)
end

enemyProto.flip = function(velocity)		if velocity.x < 0 then sprite.set_hflip("#sprite", true)  elseif velocity.x > 0 then  sprite.set_hflip("#sprite", false)  end			end

enemyProto.createEnemy = function(location, properties)
	factory.create("enemyFactory", location, nil, properties)
end







