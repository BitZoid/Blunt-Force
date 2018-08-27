_ShootingPatterns = {}

_ShootingPatterns[1] = function(bulletURL, obj) --machinegun
	enemyProto.delay(.01, "waitS", function()
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
	enemyProto.delay(.5, "waitS", function()
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

_ShootingPatterns[3] = function(bulletURL, obj) --roadhog
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
			bulletProto.newBullet(bulletURL,  
			go.get(".", "position"), 
			enemyProto.derivativeDirection(enemyProto.randomDirection(), -100, 100),
			200 + enemyProto.randomFloat(-20, 20), 1, 2,
			function()
			end)
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