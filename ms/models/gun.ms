Gun = class
  constructor = function(gunType, startTheta)
    this.gunType = gunType
    this.startTheta = startTheta

    // The gun sits on the barrel circumference and points inward.
    this.theta = this.startTheta + 180

    // visualTheta is the angle we actually draw the gun at.
    // It lets the gun visually rotate toward the slightly randomized shot angle.
    this.visualTheta = this.theta

    // Controls how quickly the gun returns to its normal resting angle after firing.
    // Lower = slower/smoother return. Higher = faster snap back.
    this.returnSpeed = .18

    this.projectiles = []

    local centerBarrX = -2
    local centerBarrY = 1
    local radiusBarrX = 158
    local radiusBarrY = 112

    this.px = centerBarrX + cosd(this.startTheta) * radiusBarrX
    this.py = centerBarrY + sind(this.startTheta) * radiusBarrY

    // Shooting sprite timing.
    this.shootingTimer = 0
    this.shootingDuration = .12

    if this.gunType == "blunderbuss" then
      this.sprite = "blunderbuss"
      this.shootingSprite = "blunderbussshooting"

      // Blunderbuss fires slower and has wider randomness.
      this.bullDelay = 4 + random.next() * 2
      this.spread = 12
    else
      this.gunType = "musket"
      this.sprite = "flintlock"
      this.shootingSprite = "flintlockshooting"

      // Flintlock fires faster and is a little more accurate.
      this.bullDelay = 2 + random.next() * 1.5
      this.spread = 8
    end
  end

  // Creates one projectile at the given angle.
  shootAProjectile = function(theta)
    local projectile = new Projectile(this.px, this.py, theta)
    this.projectiles.push(projectile)
  end

  // Fires this gun.
  upThePole = function()
    // Turn on the shooting sprite briefly.
    this.shootingTimer = this.shootingDuration

    // Slight randomization so guns do not always shoot perfectly toward center.
    local randomAngle = random.next() * this.spread * 2 - this.spread
    local shotTheta = this.theta + randomAngle

    // Rotate the gun sprite toward the actual shot direction.
    this.visualTheta = shotTheta

    if this.gunType == "blunderbuss" then
      // Blunderbuss fires three bullets in an arc.
      this.shootAProjectile(shotTheta - 12)
      this.shootAProjectile(shotTheta)
      this.shootAProjectile(shotTheta + 12)

      // Blunderbuss reloads slower.
      this.bullDelay = 4 + random.next() * 2.5
    else
      // Flintlock fires one bullet.
      this.shootAProjectile(shotTheta)

      // Flintlock reloads faster.
      this.bullDelay = 2 + random.next() * 1.5
    end
  end

  // Updates gun firing and its projectiles. Returns 1 if fish gets hit.
  update = function(fish)
    local dt = 1 / 60
    local flyinBullets = []

    // Smoothly return the gun sprite back to its normal barrel-facing angle.
    this.visualTheta += (this.theta - this.visualTheta) * this.returnSpeed

    if this.shootingTimer > 0 then
      this.shootingTimer -= dt
    end

    this.bullDelay -= dt

    if this.bullDelay <= 0 then
      this.upThePole()
    end

    for projectile in this.projectiles
      projectile.updatePosition()

      if projectile.hasHitFish(fish) then
        return 1
      end

      if not projectile.isDespawned() then
        flyinBullets.push(projectile)
      end
    end

    this.projectiles = flyinBullets

    return 0
  end

  draw = function()
    for projectile in this.projectiles
      projectile.draw()
    end

    local currentSprite = this.sprite

    if this.shootingTimer > 0 then
      currentSprite = this.shootingSprite
    end

    // Draw using visualTheta instead of theta so the sprite follows shot variation.
    screen.setDrawRotation(this.visualTheta)
    screen.drawSprite(currentSprite, this.px, this.py, 55)
    screen.setDrawRotation(0)
  end
end