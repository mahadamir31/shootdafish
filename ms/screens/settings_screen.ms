// Settings scene. Lets the player edit persisted app preferences.
SettingsScreen = object
  isReady = 0

  // Builds sliders and buttons once, then reuses them on every visit.
  ensureSetup = function()
    if this.isReady then
      return
    end

    this.volumeSlider = new Slider("VOL", 15, 42, 120, 0, 10, AppState.settings.volume)
    this.sensitivitySlider = new Slider("SEN", 15, 8, 120, 0, 10, AppState.settings.sensitivity)
    this.fovSlider = new Slider("FOV", 15, -26, 120, 0, 10, AppState.settings.fov)
    this.backButton = new Button(0, -62, 110, 20)
    this.backButton.setText("Back", 12)

    this.isReady = 1
    this.syncFromState()
  end

  // Copies current saved settings into the UI controls.
  syncFromState = function()
    this.volumeSlider.setValue(AppState.settings.volume)
    this.sensitivitySlider.setValue(AppState.settings.sensitivity)
    this.fovSlider.setValue(AppState.settings.fov)
  end

  // Refreshes controls when the player enters the scene.
  enter = function()
    this.ensureSetup()
    this.syncFromState()
  end

  // Reads slider/button changes, updates state, and persists only if something changed.
  update = function()
    this.ensureSetup()

    local changed = 0
    this.volumeSlider.update()
    this.sensitivitySlider.update()
    this.fovSlider.update()

    local volume = round(this.volumeSlider.value)
    local sensitivity = round(this.sensitivitySlider.value)
    local fov = round(this.fovSlider.value)

    if volume != AppState.settings.volume then
      AppState.settings.volume = volume
      changed = 1
    end

    if sensitivity != AppState.settings.sensitivity then
      AppState.settings.sensitivity = sensitivity
      changed = 1
    end

    if fov != AppState.settings.fov then
      AppState.settings.fov = fov
      changed = 1
    end

    if changed then
      AppStorage.saveSettings(AppState.settings)
      this.syncFromState()
    end

    if this.backButton.wasPressed() then
      SceneManager.change(SCENES.START)
    end
  end

  // Draws the settings panel and every interactive control.
  draw = function()
    this.ensureSetup()
    UI.drawBackground()
    UI.drawPanel(0, -18, 320, 185)
    UI.drawTitle("Settings", 70)

    this.volumeSlider.draw()
    this.sensitivitySlider.draw()
    this.fovSlider.draw()
    this.backButton.draw()
  end
end
