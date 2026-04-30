// Minimal scene router that keeps screen-specific logic isolated from the game loop.
SceneManager = object
  // Scene registry keyed by the ids in SCENES.
  scenes = object end

  // Adds a scene object to the registry.
  register = function(name, scene)
    this.scenes[name] = scene
  end

  // Switches the active scene and calls its enter hook if it has one.
  change = function(name)
    AppState.scene = name
    local scene = this.scenes[name]
    if scene and scene.enter then
      scene.enter()
    end
  end

  // Returns the current active scene object.
  getCurrent = function()
    return this.scenes[AppState.scene]
  end

  // Runs the active scene's per-frame update logic.
  update = function()
    local scene = this.getCurrent()
    if scene and scene.update then
      scene.update()
    end
  end

  // Runs the active scene's draw logic.
  draw = function()
    local scene = this.getCurrent()
    if scene and scene.draw then
      scene.draw()
    end
  end
end
