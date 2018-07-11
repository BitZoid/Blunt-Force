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
	factory.create("/enemyFactory#factory", location, nil, properties)
end

_IdleBehaviors = {}
_TrackingBehaviors = {}
_ShootingPatterns = {}

_ShootingPatterns[1] = function(bulletURL, obj) --machinegun
	enemyProto.delay(.1, "waitS", function()
		bulletProto.newBullet(bulletURL, 
		go.get(".", "position"), 
		enemyProto.derivativeDirection(enemyProto.target(go.get("/hero_collection/hero", "position")), -3, 3), 
		200 + enemyProto.randomFloat(-20, 20), .5, 1,
		function()
			bulletProto.newBullet(bulletURL,  
			go.get(".", "position"), 
			enemyProto.derivativeDirection(enemyProto.randomDirection(), -100, 100),
			200 + enemyProto.randomFloat(-20, 20), 1, 2,
			function()
			end)
		end)
		obj.shooting = false
	end)
end

_ShootingPatterns[2] = function(bulletURL, obj) --shotgun
	enemyProto.delay(.1, "waitS", function()
		bulletProto.newBullet(bulletURL, 
		go.get(".", "position"), 
		enemyProto.derivativeDirection(enemyProto.target(go.get("/hero_collection/hero", "position")), -1, 1), 
		200 + enemyProto.randomFloat(-20, 20), .5, 1)
		bulletProto.newBullet(bulletURL, 
		go.get(".", "position"), 
		enemyProto.derivativeDirection(enemyProto.target(go.get("/hero_collection/hero", "position")), -22, -21), 
		200 + enemyProto.randomFloat(-20, 20), .5, 1)
		bulletProto.newBullet(bulletURL, 
		go.get(".", "position"), 
		enemyProto.derivativeDirection(enemyProto.target(go.get("/hero_collection/hero", "position")), 21, 22), 
		200 + enemyProto.randomFloat(-20, 20), .5, 1)
		obj.shooting = false
	end)
end

_IdleBehaviors[1] = {
	{
		directionMode = 1,
		speedMultiplier = 1,
		minSpeedMultiplier = 0,
		durationLower = 1,
		durationUpper = 2,
		completionDelayLower = 5,
		completionDelayUpper = 10
	},
	{
		directionMode = 1,
		speedMultiplier = 1.2,
		minSpeedMultiplier = 0.2,
		durationLower = .5,
		durationUpper = 2.5,
		completionDelayLower = 2,
		completionDelayUpper = 3
	},
	{
		directionMode = 0,
		speedMultiplier = .8,
		minSpeedMultiplier = .3,
		durationLower = 1,
		durationUpper = 5,
		completionDelayLower = 0,
		completionDelayUpper = 4
	},
	{
		directionMode = 0,
		speedMultiplier = 0,
		minSpeedMultiplier = 0,
		durationLower = 3,
		durationUpper = 5,
		completionDelayLower = 0,
		completionDelayUpper = 0
	}
}

_TrackingBehaviors[1] = {
	{
		directionMode = 2,
		speedMultiplier = 1,
		minSpeedMultiplier = 1,
		durationLower = 1,
		durationUpper = 2,
		completionDelayLower = 0,
		completionDelayUpper = 0
	}
}

_BulletCallbacks = {

}







