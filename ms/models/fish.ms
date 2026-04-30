// Simple domain model for the player's named fish.
Fish = class
  // Stores the fish display name selected during onboarding.
  constructor = function(name, size)
    this.name = name
    this.sprite = "fish"
    this.size = size

    
    
    this.theta = 0 // Angle the fish faces
    // X and Y position
    this.px = 0
    this.py = 0
    // X and Y velocity
    this.vx = 0
    this.vy = 0
  end
  
  updatePosition = function()
    // dragConst: Higher number = less drag
    // Equivalent to mass/drag coefficient in physics.
    local dragConst = 30
    local v_max = 120
    local dt = 1 / 60
    local rx = mouse.x - this.px
    local ry = mouse.y - this.py
    
    this.vx = dragConst*rx + (this.vx - dragConst*rx) * exp(-dt/dragConst)
    this.vy = dragConst*ry + (this.vy - dragConst*ry) * exp(-dt/dragConst)
    this.theta = atan2d(this.vy, this.vx)
    
    local v_mag = sqrt((this.vx^2) + (this.vy^2))
    
    if v_mag > v_max then
      this.vx = v_max * cosd(this.theta)
      this.vy = v_max * sind(this.theta)
    end

    this.px += this.vx * dt
    this.py += this.vy * dt
    
    // --- Barrel boundary ---
    local barrel_cx = -2       // center X of barrel
    local barrel_cy = 1       // center Y of barrel
    local barrel_rx = 131     // horizontal radius (tune to make wider)
    local barrel_ry = 100      // vert radius (curr val that works)
    local fish_r    = this.size / 2

    local next_x = this.px + this.vx * dt
    local next_y = this.py + this.vy * dt

    // Normalize position into "unit circle" space
    local dx = (next_x - barrel_cx) / (barrel_rx - fish_r)
    local dy = (next_y - barrel_cy) / (barrel_ry - fish_r)
    local dist = sqrt(dx*dx + dy*dy)

    if dist > 1 then
      // Project back onto ellipse edge
      this.px = barrel_cx + (dx / dist) * (barrel_rx - fish_r)
      this.py = barrel_cy + (dy / dist) * (barrel_ry - fish_r)
      // Kill outward velocity
      local nx = dx / dist
      local ny = dy / dist
      local dot = this.vx * nx + this.vy * ny
      if dot > 0 then
        this.vx -= dot * nx
        this.vy -= dot * ny
        // Readjust fish angle to prevent jitter
        this.theta = atan2d(this.vy, this.vx) 
      end
    else
      this.px = next_x
      this.py = next_y
    end
  end
  
  draw = function()
    this.updatePosition()
    
    screen.setDrawRotation(this.theta)
    screen.drawSprite(this.sprite, this.px, this.py, this.size)
    screen.setDrawRotation(0)
  end
  
end
