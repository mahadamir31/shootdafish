hasInitButtons = 0

initStartButtons = function()
  startButtonList = []
  
  local tmp = new Button(0, 25, 85, 25)
  tmp.setText("Start", 12)
  startButtonList.push(tmp)
  
  local tmp = new Button(0, -10, 130, 25)
  tmp.setText("Controls", 12)
  startButtonList.push(tmp)
  
  local tmp = new Button(-150, -75, 35, 35)
  tmp.setSprite("cog", 40, 40)
  tmp.setColors("", "")
  startButtonList.push(tmp)
  
  local tmp = new Button(0, -45, 190, 25)
  tmp.setText("Leaderboard", 12)
  startButtonList.push(tmp)
  
  local tmp = new Button(0, -80, 70, 25)
  tmp.setText("Exit", 12)
  startButtonList.push(tmp)

  hasInitButtons = 1
end

drawstartscreen = function()
  if not hasInitButtons then
    initStartButtons()
  end
  
  screen.clear()
  screen.setFont("PixelOperator")
  screen.drawText("Fish In a Barrel", 0, 60, 20, "rgb(255,255,255)")
  
  for button in startButtonList
    button.draw()
  end
  
  //background asset
  screen.drawSprite("backgroundgame", 0, 0, 400, )
end

//Controls Draw ----------------------------------------
drawcontrols=function()
  screen.drawText("WASD - MOVE",0,40,15,"rgb(255,255,255)")
  if mousecontrols==0 then
    screen.drawText("ARROWS - LOOK AROUND",0,10,15,"rgb(255,255,255)")
  else
    screen.drawText("MOUSE - LOOK AROUND",0,10,15,"rgb(255,255,255)")
  end
  screen.drawText("SPACE - JUMP",0,-20,15,"rgb(255,255,255)")
  screen.drawText("R - RESTART LEVEL",0,-50,15,"rgb(255,255,255)")
  screen.drawText("N - MAIN MENU",0,-80,15,"rgb(255,255,255)")
  
  //Back Button
  2drectcol(mouse.x,mouse.y,0,75,150,15)
  if collided==1 then
    screen.setAlpha(1)
  else
    screen.setAlpha(0.5)
  end
  screen.fillRect(0,75,300,30,"rgb(150,150,150)")
  screen.drawText("BACK",0,75,15,"rgb(255,255,255)")
  
  //background
  screen.drawSprite("backgroundgame", 0, 0, 400, )
end

drawleaderboard = function()
  //clean the screen
  screen.clear()
  //Lil top swimma action being implemented at the top
  screen.drawText("The Top Swimmas",0, 50, 12, "rgb(255,255,255" )
  screen.drawText("1:JEB 99999", -4, 25, 10, "rgb(255,215,0")
  screen.drawText("2:MAH 99998", -2, 0, 10, "rgb(192,192,192")
  screen.drawText("3:RAH 99997", -4, -25, 10, "rgb(205,127,50")
  screen.drawText("User Best: JME 10", 0, -60, 10, "rgb(255,255,255" )

  //Back button 
  2drectcol(mouse.x,mouse.y,0,75,150,15)
  if collided==1 then
    screen.setAlpha(1)
  else
    screen.setAlpha(0.5)
  end
  screen.fillRect(0,80,300,30,"rgb(150,150,150)")
  screen.drawText("BACK",0,80,15,"rgb(255,255,255)")
  
  //bnackground
  screen.drawSprite("backgroundgame", 0, 0, 400, )
end
drawend=function()
  screen.setFont( "PixelOperator" )
  screen.drawText("Congratulations!",0,20,20,"rgb(255,255,255)")
  screen.drawText("You finished with a time of:",0,-40,10,"rgb(255,255,255)")
  screen.drawText(round(gametime*100)/100+" seconds",0,-60,10,"rgb(255,255,255)")
  2drectcol(mouse.x,mouse.y,0,70,120,20)
  if collided==1 then
    screen.setAlpha(1)
  else
    screen.setAlpha(0.5)
  end
  screen.fillRect(0,70,240,40,"rgb(150,150,150)")
  screen.drawText("Main menu",0,70,20,"rgb(255,255,255)")
end

gameinit=function()
  gametime=0
  timing=0 //?
  lives=0
end

//2d Rectangle Mouse Button Function
2drectcol = function(px,py,x,y,w,h)
  if px>x-w and px<x+w then
    if py>y-h and py<y+h then
      collided=1
    else
      collided=0
    end
  else
    collided=0
  end
end