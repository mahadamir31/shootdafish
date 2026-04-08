init = function()
  mode = "start"
  namechars = []
  mousecontrols = 0
  showtimer = 1
  nameinputbuffer = ""
  gameinit()
  levelinit()
end

Fish = class
  constructor = function(name)
    this.name=name
  end
end

levelinit=function()
  playersize=25
  x=0
  y=0
end


update = function()
  globaltime += 1/60
  if mode=="play" then
    // back button
    // 2D rectangular Collision Function (x,y inputs, location of the other colliding body, height and width of the rectangle)
    2drectcol(mouse.x,mouse.y,-185,80,25,25)
    if collided==1 and mouse.pressed then
      mode="start"
    end
    if timing==1 then
      gametime+=1/60
    end
    
    //debugging macros
    if keyboard.press.R then
      levelinit() //restart level
    end
    if keyboard.press.N then
      mode="start" //go to main menu
    end
  
  //main menu
  elsif mode == "start" then
    
    for button in startButtonList
      if button.hasClicked() then
        // Clicked Start Button
        if button.text == "Start" then
          mode = "nameinput"
          namechars=[]
          nameinputbuffer = ""
          timing=0
          gametime=0
          levelinit()
          break
          
        // Clicked Controls Button
        elsif button.text == "Controls" then
          mode = "controls"
          break
          
        // Clicked Settings Button
        elsif button.sprite == "cog" then
          mode = "settings"
          break
          
        // Clicked Leaderboard Button
        elsif button.text == "Leaderboard" then
          mode = "leaderboard"
          break
          
        elsif button.text == "Exit" then
          system.exit()
        end
      end
    end
    
  elsif mode == "nameinput" then
    // letters a-z
    if keyboard.press.A then namechars.push("A") end
    if keyboard.press.B then namechars.push("B") end
    if keyboard.press.C then namechars.push("C") end
    if keyboard.press.D then namechars.push("D") end
    if keyboard.press.E then namechars.push("E") end
    if keyboard.press.F then namechars.push("F") end
    if keyboard.press.G then namechars.push("G") end
    if keyboard.press.H then namechars.push("H") end
    if keyboard.press.I then namechars.push("I") end
    if keyboard.press.J then namechars.push("J") end
    if keyboard.press.K then namechars.push("K") end
    if keyboard.press.L then namechars.push("L") end
    if keyboard.press.M then namechars.push("M") end
    if keyboard.press.N then namechars.push("N") end
    if keyboard.press.O then namechars.push("O") end
    if keyboard.press.P then namechars.push("P") end
    if keyboard.press.Q then namechars.push("Q") end
    if keyboard.press.R then namechars.push("R") end
    if keyboard.press.S then namechars.push("S") end
    if keyboard.press.T then namechars.push("T") end
    if keyboard.press.U then namechars.push("U") end
    if keyboard.press.V then namechars.push("V") end
    if keyboard.press.W then namechars.push("W") end
    if keyboard.press.X then namechars.push("X") end
    if keyboard.press.Y then namechars.push("Y") end
    if keyboard.press.Z then namechars.push("Z") end
    
    if namechars.length > 3 then
      namechars.pop()
    end
    if keyboard.press.BACKSPACE then
      namechars.pop()
    end
    
    nameinputbuffer = namechars.join("")
    givenFishy = new Fish(nameinputbuffer)

    2drectcol(mouse.x, mouse.y, 50, -30, 60, 15)
    if (collided==1 and mouse.pressed) or keyboard.press.ENTER then
      if namechars.length > 0 then
        playername = nameinputbuffer
        mode = "play"
        timing = 0
        gametime = 0
        levelinit()
      end
    end
    2drectcol(mouse.x, mouse.y, -50, -30, 60, 15)
    if collided==1 and mouse.pressed then
      mode = "start"
    end
  //control scene
  elsif mode=="controls" then
    2drectcol(mouse.x,mouse.y,0,75,150,15)
    if collided==1 and mouse.pressed then
      mode="start"
      levelinit()
      collided=0
    end
    
  //settings scene
  elsif mode=="settings" then
      updateSettings()
      
  //leaderboard scene
  elsif mode=="leaderboard" then
    2drectcol(mouse.x,mouse.y,0,75,150,15)
    // Back button
    if collided==1 and mouse.pressed then
      mode="start"
      levelinit()
      collided=0
    end
    
    //Button 
    2drectcol(mouse.x,mouse.y,60,0,20,10)
    if collided==1 and mouse.pressed then
      drawstars=1
    end
    2drectcol(mouse.x,mouse.y,120,0,20,10)
    if collided==1 and mouse.pressed then
      drawstars=0
    end
    // Button 2
    2drectcol(mouse.x,mouse.y,60,40,20,10)
    if collided==1 and mouse.pressed then
      mousecontrols=1
    end
    2drectcol(mouse.x,mouse.y,120,40,20,10)
    if collided==1 and mouse.pressed then
      mousecontrols=0
    end
    //Button 3
    2drectcol(mouse.x,mouse.y,60,-40,20,10)
    if collided==1 and mouse.pressed then
      showtimer=1
    end
    2drectcol(mouse.x,mouse.y,120,-40,20,10)
    if collided==1 and mouse.pressed then
      showtimer=0
    end
    
  //Game Over
  elsif mode=="end" then
    2drectcol(mouse.x,mouse.y,0,70,120,20)
    if collided==1 and mouse.pressed then
      mode="start"
      levelinit()
    end
  end
end

drawnameinput = function()
  screen.clear()
  screen.setFont(BitCell)

  // Background box
  screen.fillRect(0, 0, 180, 120, "rgba(0,0,0,0.75)")

  // Prompt text
  screen.drawText("Enter your name:", 0, 30, 14, "rgb(255,255,255)")

  // Show what's been typed + blinking cursor
  cursor = ""
  if floor(globaltime * 2) % 2 == 0 then cursor = "|" end
  screen.drawText(nameinputbuffer + cursor, 0, 10, 18, "rgb(255, 210, 80)")

  // Confirm button
  2drectcol(mouse.x, mouse.y, 80, -30, 60, 15)
  if collided == 1 then screen.setAlpha(1) else screen.setAlpha(0.6) end
  screen.fillRect(80, -30, 120, 30, "rgb(60,180,100)")
  screen.drawText("CONFIRM", 80, -30, 13, "rgb(255,255,255)")

  // Cancel button
  2drectcol(mouse.x, mouse.y, -80, -30, 60, 15)
  if collided == 1 then screen.setAlpha(1) else screen.setAlpha(0.6) end
  screen.fillRect(-80, -30, 120, 30, "rgb(180,60,60)")
  screen.drawText("CANCEL", -80, -30, 13, "rgb(255,255,255)")

  screen.setAlpha(1)
end

draw = function()
  if mode=="play" then
    screen.clear()
    
    screen.setFont(BitCell) // Timer, death count, level
    2drectcol(mouse.x,mouse.y,-185,80,25,25)
    if collided==1 then
      screen.setAlpha(1)
    else
      screen.setAlpha(0.5)
    end
    //back sprite
    screen.drawSprite("sprite",-185,80,50,50)
    screen.setAlpha(1)
    
    //Time sprite
    screen.setDrawAnchor(-1,0)
    screen.drawText(round(gametime*100)/100,-198,-80,15,"rgb(255,255,255)") // Round gametime to 2 decimal places
    screen.setDrawAnchor(0,0)
    
    screen.setAlpha(0)
  elsif mode=="start" then
    drawstartscreen()
  elsif mode == "nameinput" then
    drawnameinput()
  elsif mode=="controls" then
    screen.clear()
    drawcontrols()
  elsif mode=="settings" then
    drawsettings()
  elsif mode=="leaderboard" then
    drawleaderboard()
  elsif mode=="end" then
    screen.clear()
    drawend()
    screen.setAlpha(1)
  end
end