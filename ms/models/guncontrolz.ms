GunControlz = class
  constructor = function()
    this.currGuns = []
    this.nextGunSpawnT = 0

    // This makes sure the forced 36-second blunderbuss only happens once.
    this.firstBlunderbussSpawned = 0

    // Start with one basic flintlock/musket.
    this.createGun("musket")
    this.spawnChance(0)
  end

  randSpawn = function(minV, maxV)
    return minV + random.next() * (maxV - minV)
  end

  createGun = function(gunType)
    local startTheta = this.randSpawn(0, 360)
    local gun = new Gun(gunType, startTheta)
    this.currGuns.push(gun)
  end

  fetchMaxGuns = function(currTime)
    local gunLimit = 1

    if currTime >= 15 then
      gunLimit = 2
    end

    if currTime >= 35 then
      gunLimit = 4
    end

    if currTime >= 60 then
      gunLimit = 5
    end

    if currTime >= 90 then
      gunLimit = 7
    end

    if currTime >= 125 then
      gunLimit = 8
    end

    return gunLimit
  end

  spawnChance = function(currTime)
    local minDelay = 8
    local maxDelay = 12

    if currTime >= 30 then
      minDelay = 7
      maxDelay = 10
    end

    if currTime >= 60 then
      minDelay = 5
      maxDelay = 8
    end

    if currTime >= 100 then
      minDelay = 4
      maxDelay = 7
    end

    this.nextGunSpawnT = currTime + this.randSpawn(minDelay, maxDelay)
  end

  chooseGunType = function(currTime)
    // Before 36 seconds, only spawn muskets/flintlocks.
    if currTime < 36 then
      return "musket"
    end

    // The chance increases as time goes on.
    // At 36 seconds: about 25%
    // At 60 seconds: about 35%
    // At 90 seconds: about 50%
    // At 125 seconds: about 65%
    // Later: capped at 75%
    local blunderChance = .25

    if currTime >= 60 then
      blunderChance = .35
    end

    if currTime >= 90 then
      blunderChance = .50
    end

    if currTime >= 125 then
      blunderChance = .65
    end

    if currTime >= 160 then
      blunderChance = .75
    end

    if random.next() < blunderChance then
      return "blunderbuss"
    end

    return "musket"
  end

  determineGuns = function(currTime)
    local gunLimit = this.fetchMaxGuns(currTime)

    if this.currGuns.length >= gunLimit then
      return
    end

    local gunType = this.chooseGunType(currTime)
    this.createGun(gunType)

    // Optional extra spawn later in the game.
    // This makes the ramp feel less predictable.
    if currTime >= 45 and this.currGuns.length < gunLimit and random.next() < .25 then
      gunType = this.chooseGunType(currTime)
      this.createGun(gunType)
    end
  end

  update = function(fish, currTime)
    // Hardcoded first blunderbuss at exactly/after 36 seconds.
    // It only spawns if there is room under the current gun limit.
    if currTime >= 36 and not this.firstBlunderbussSpawned then
      local gunLimit = this.fetchMaxGuns(currTime)

      if this.currGuns.length < gunLimit then
        this.createGun("blunderbuss")
        this.firstBlunderbussSpawned = 1

        // Push the next normal spawn a little later so the forced blunderbuss
        // does not immediately stack with another spawn.
        this.spawnChance(currTime)
      end
    end

    if currTime >= this.nextGunSpawnT then
      this.determineGuns(currTime)
      this.spawnChance(currTime)
    end

    for gun in this.currGuns
      if gun.update(fish) then
        return 1
      end
    end

    return 0
  end

  draw = function()
    for gun in this.currGuns
      gun.draw()
    end
  end
end