Projectile = class
  constructor =function(px,py,theta)
    this.sprite = "bullet"
    this.px=px
    this.py=py
    this.theta = theta
    
    //projectile speed and size - can implement differnet sizes/speed if we feel like adding late game variability
    this.size =6
    this.speed =95
    this.vx =cosd(this.theta)* this.speed
    this.vy = sind(this.theta) * this.speed
    
    //used to handle shot bulllets and how long they hang around - should expire after about 4 seconds.
    this.life = 0
    this.maxLife = 4
  end
  updatePosition= function()
  //same as dt as in our other functions 
    local frameTime = 1/60
    //updates a bullets position and despawn timer based on its current velocity coordinates and frame time
    this.px +=  this.vx * frameTime
    this.py += this.vy * frameTime
    this.life += frameTime
    
  end

  //simple helper to determine whether a bullet should be despawned based on its time alive or its position outside of the runk
  isDespawned = function()
    return this.life >this.maxLife or this.px <-230 or this.px>230 or this.py <-130 or this.py >130
  end

  //Checks the collision factor on the fish
  hasHitFish = function(fish)
    //creates the hitbox for a fish and a bullet. Alternate values HERE to make it easier/harder to be hit
    local hitFrame = fish.size*0.25 + this.size *0.4
    local dx = this.px -fish.px
    local dy = this.py - fish.py
    return dx *dx +dy*dy <=hitFrame * hitFrame
  end
  draw =function()
    screen.setDrawRotation(this.theta)
    screen.drawSprite(this.sprite, this.px,this.py, this.size)
    screen.setDrawRotation(0)
  end
end

