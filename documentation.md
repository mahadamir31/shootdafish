# Fish in a Barrel: Documentation

This project is a microStudio game/app written in microScript. The code is organized around a small scene system:

- `main.ms` responsible for initializing and gameplay loop.
- `core/` contains global state, constants, input helpers, UI helpers, and scene routing.
- `screens/` contains one object per screen.
- `models/` contains gameplay objects: fish, guns, bullets, and gun spawning.
- `ui_utils/` contains reusable controls.
- `services/` contains persistence.
- `sprites/` contains image assets referenced by the code.

## `project.json`

Purpose: microStudio project metadata and asset manifest.

How it works:

- Stores the project title, slug, orientation, aspect ratio, supported platforms, input controls, and engine choices.
- Lists every code and sprite file with version and size information.
- Tells microStudio this is an app using `microscript_v1_t` and `M1` graphics.

## `ms/main.ms`

Purpose: engine entry point and scene registration.

How it works:

- `registerScreens()` maps scene ids from `SCENES` to screen objects.
- `init()` initializes global state, registers screens, and starts at the start screen.
- `update()` ticks shared state first, then updates the active scene.
- `draw()` delegates rendering to the active scene.

## `ms/core/constants.ms`

Purpose: shared scene ids, theme values, and layout constants.

How it works:

- `SCENES` defines string ids used by `SceneManager`.
- `THEME` centralizes sprite names and colors used across UI.
- `LAYOUT` defines the logical screen size used by background drawing.

## `ms/core/app_state.ms`

Purpose: central state shared between scenes.

How it works:

- `init()` creates global timers, loads settings, initializes player state, sets placeholder leaderboard data, loads best time, and creates the first run.
- `resetRun()` creates a fresh gameplay run with timer, lives, a `Fish`, and a `GunControlz`.
- `resetNameInput()` clears the temporary character buffer.
- `beginNameEntry()` resets name input and run state before starting a new game flow.
- `refreshNameBuffer()` joins typed characters into a visible name string.
- `confirmName()` saves the typed name, resets gameplay, and starts timing.
- `tick()` increments global time and gameplay time when the active scene is `PLAY`.
- `completeRun()` stops timing and asks `AppStorage` to persist the best time.
- `saveSettings()` persists current settings.
- `getPlayerLabel()` returns the player name or `"Anonymous"`.

## `ms/core/scene_manager.ms`

Purpose: simple scene router.

How it works:

- `scenes` stores scene objects by name.
- `register(name, scene)` adds screens to the registry.
- `change(name)` updates `AppState.scene`, then calls the new scene's `enter()` hook if present.
- `getCurrent()` returns the active screen object.
- `update()` and `draw()` delegate to the active screen if those methods exist.

## `ms/core/input.ms`

Purpose: converts raw keyboard presses into name-entry characters.

How it works:

- `captureNameCharacters(characters, maxLength)` receives an array and edits it directly.
- Backspace removes the last character.
- If the array is already at `maxLength`, it ignores new letters.
- It checks A through Z and appends the matching uppercase letter for a newly pressed key.

## `ms/core/ui.ms`

Purpose: shared drawing and formatting helpers.

How it works:

- `drawBackground()` clears the screen and draws `THEME.backgroundSprite`.
- `drawInGameBackground()` clears the screen and draws `THEME.inGameBackground`.
- `drawPanel()` attempts to draw a translucent panel.
- `drawTitle()` and `drawBodyText()` standardize font and text drawing.
- `isPointerInRect()` tests mouse position against centered rectangles.
- `formatTime()` formats seconds to hundredths, then appends `"s"`.

## `ms/services/app_storage.ms`

Purpose: persistence for settings and best time.

How it works:

- Uses microStudio's `storage.get()` and `storage.set()` API.
- `loadSettings()` returns stored settings, or defaults when storage returns `0`.
- `saveSettings(settings)` writes the full settings object.
- `getBestTime()` reads the saved best time.
- `saveBestTime(time)` compares a run time against the saved value and may overwrite it.

## `ms/ui_utils/button.ms`

Purpose: reusable menu/button component.

How it works:

- Constructor stores position, dimensions, label state, color state, and optional sprite state.
- `isHovering()` uses `UI.isPointerInRect()`.
- `wasPressed()` returns true only when the pointer is hovering and `mouse.press` is true.
- `draw()` changes alpha based on hover, optionally fills a rectangle, optionally draws a sprite, optionally draws text, then resets alpha.
- Setter methods configure text, font, colors, and sprite.

## `ms/ui_utils/slider.ms`

Purpose: reusable horizontal numeric slider.

How it works:

- Constructor stores label, geometry, min/max range, current value, and handle dimensions.
- `setValue()` syncs the control from external state.
- `isHovering()` checks whether the mouse is near the slider track.
- `update()` only works while `mouse.pressed` is held and the pointer is over the slider.
- Mouse x-position is converted into normalized track position `t`, clamped to `[0, 1]`, then mapped into the configured numeric range.
- `draw()` renders label, track, handle, and rounded value.

## `ms/screens/start_screen.ms`

Purpose: main menu.

How it works:

- Builds buttons once using `ensureSetup()`.
- `createEntry()` wraps a `Button` with a string id.
- Buttons include Start, Controls, Leaderboard, Exit, and a cog sprite Settings button.
- `enter()` ensures setup.
- `update()` checks each button and navigates based on its id.
- Start resets name-entry state and switches to `NAME_INPUT`.
- Exit calls `system.exit()`.
- `draw()` paints the background, title, panel, and buttons.

## `ms/screens/name_input_screen.ms`

Purpose: player/fish name entry before gameplay.

How it works:

- Builds Confirm and Cancel buttons once.
- `enter()` clears previous name input.
- `update()` captures up to 3 uppercase letters through `Input.captureNameCharacters()`.
- The typed character array is converted into `AppState.nameInput.buffer`.
- Confirm or Enter saves the name, resets the run, starts the timer, and switches to `PLAY`.
- Cancel returns to the start screen.
- `draw()` shows title, helper text, blinking cursor, typed buffer, and buttons.

## `ms/screens/play_screen.ms`

Purpose: gameplay scene and HUD.

How it works:

- Builds a back button once.
- `enter()` ensures a `GunControlz` object exists.
- `update()` handles:
  - Back button or `N`: reset run and return to start.
  - `R`: reset run and restart timing.
  - Gun controller update: if a projectile hits the fish, switch to `END`.
- `draw()` renders in-game background, back button, HUD text, guns/projectiles, fish, and timer.

## `ms/screens/end_screen.ms`

Purpose: end-of-run summary.

How it works:

- Builds a Main Menu button once.
- `enter()` calls `AppState.completeRun()` to stop timing and save the record.
- `update()` returns to start when Main Menu is pressed, resetting the run.
- `draw()` shows background, panel, title, fish/player name, final time, and button.

## `ms/screens/control_screen.ms`

Purpose: static controls reference screen.

How it works:

- Creates one Back button.
- `update()` returns to start when Back is pressed.
- `draw()` shows background, title, current controls text, and button.

## `ms/screens/settings_screen.ms`

Purpose: settings editor.

How it works:

- Builds three sliders and a Back button once.
- Sliders map to `AppState.settings.volume`, `sensitivity`, and `fov`.
- `syncFromState()` copies stored state values into slider controls.
- `enter()` refreshes controls from the current settings.
- `update()` updates sliders, rounds their values, compares them with `AppState.settings`, and saves only when something changed.
- Back returns to start.
- `draw()` renders background, panel, title, sliders, and Back button.

## `ms/screens/leaderboard_screen.ms`

Purpose: displays placeholder rankings and the local best time.

How it works:

- Creates one Back button.
- `draw()` shows three hardcoded leaderboard strings from `AppState.leaderboard`.
- It also shows a local best record if `AppState.bestTime != 0`.
- Back returns to start.

## `ms/models/fish.ms`

Purpose: player-controlled fish model.

How it works:

- Constructor stores name, sprite, size, angle, position, and velocity.
- `updatePosition()` moves the fish toward the mouse using velocity smoothing.
- It caps max velocity.
- It constrains the fish inside an ellipse representing the barrel.
- If the fish would leave the ellipse, it projects the fish back to the boundary and removes outward velocity.
- `draw()` updates position, rotates the sprite to face movement direction, draws the fish, then resets rotation.

## `ms/models/projectile.ms`

Purpose: bullet/projectile model.

How it works:

- Constructor stores sprite, starting position, angle, size, speed, velocity vector, current life, and max life.
- `updatePosition()` advances position by velocity at 60 FPS and increments lifetime.
- `isDespawned()` returns true when lifetime exceeds 4 seconds or when position leaves wide screen bounds.
- `hasHitFish(fish)` checks circular collision using fish size and projectile size.
- `draw()` rotates and draws the bullet sprite.

## `ms/models/gun.ms`

Purpose: one enemy gun placed around the barrel.

How it works:

- Constructor receives a gun type and angle around the barrel.
- It points the gun inward by adding 180 degrees.
- It places the gun on an ellipse around the barrel center.
- It chooses a sprite and rough firing delay based on gun type.
- It then randomizes firing delay to stagger gun fire.
- `shootAProjectile(theta)` creates one `Projectile`.
- `upThePole()` fires either one shot for musket/flintlock or three spread shots for blunderbuss.
- `update(fish)` counts down the firing delay, fires when ready, updates projectiles, returns `1` if any projectile hits the fish, and keeps non-despawned projectiles.
- `draw()` draws all projectiles, then draws the rotated gun sprite.

## `ms/models/guncontrolz.ms`

Purpose: manages all active guns and difficulty scaling.

How it works:

- Constructor initializes `currGuns`, sets next spawn time, creates a starting musket, and schedules the next spawn.
- `randSpawn(minV, maxV)` returns a random float in a range.
- `createGun(gunType)` creates a `Gun` at a random angle and stores it in `currGuns`.
- `fetchMaxGuns(currTime)` increases the allowed gun count over time.
- `spawnChance(currTime)` schedules the next spawn delay, reducing delay as time increases.
- `determineGuns(currTime)` chooses whether to spawn a musket or blunderbuss.
- `update(fish, currTime)` spawns guns when the scheduled time arrives, updates every gun, and returns `1` if any gun reports a fish hit.
- `draw()` draws every active gun.

## Sprite Asset

These image files do not define code classes. They behave like asset objects that are referenced by sprite name from classes or screen objects.

### `sprites/backgroundgame.png`

Purpose: main/menu background image.

Used by:

- `THEME.backgroundSprite = "backgroundgame"`
- `UI.drawBackground()`

### `sprites/background_ingame.png`

Purpose: gameplay background image.

Used by:

- `THEME.inGameBackground = "background_ingame"`
- `UI.drawInGameBackground()`
- `PlayScreen.draw()`

Class diagram:

### `sprites/fish.png`

Purpose: fish/player sprite.

### `sprites/bullet.png`

Purpose: projectile sprite.

### `sprites/flintlock.png`

Purpose: normal gun/musket visual.

### `sprites/blunderbuss.png`

Purpose: blunderbuss gun visual.

### `sprites/flintlockshooting.png`

Purpose: shooting-state flintlock sprite asset.

### `sprites/blunderbussshooting.png`

Purpose: shooting-state blunderbuss sprite asset.

### `sprites/cog.png`

Purpose: settings button icon.

### `sprites/poster.png`

Purpose: project poster/preview art.

### `sprites/title_background.png`

Purpose: title background asset.
