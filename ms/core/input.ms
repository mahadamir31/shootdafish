// Input helper focused on translating raw keyboard state into higher-level text entry.
Input = object
  // Appends A-Z input into a character buffer with backspace support and a max length.
  captureNameCharacters = function(characters, maxLength)
    if keyboard.press.BACKSPACE and characters.length > 0 then
        characters.pop()
    end

    if characters.length >= maxLength then
      return
    end

    if keyboard.press.A then characters.push("A") 
    elsif keyboard.press.B then characters.push("B") 
    elsif keyboard.press.C then characters.push("C") 
    elsif keyboard.press.D then characters.push("D") 
    elsif keyboard.press.E then characters.push("E") 
    elsif keyboard.press.F then characters.push("F") 
    elsif keyboard.press.G then characters.push("G") 
    elsif keyboard.press.H then characters.push("H") 
    elsif keyboard.press.I then characters.push("I") 
    elsif keyboard.press.J then characters.push("J") 
    elsif keyboard.press.K then characters.push("K") 
    elsif keyboard.press.L then characters.push("L") 
    elsif keyboard.press.M then characters.push("M") 
    elsif keyboard.press.N then characters.push("N") 
    elsif keyboard.press.O then characters.push("O") 
    elsif keyboard.press.P then characters.push("P") 
    elsif keyboard.press.Q then characters.push("Q") 
    elsif keyboard.press.R then characters.push("R") 
    elsif keyboard.press.S then characters.push("S") 
    elsif keyboard.press.T then characters.push("T") 
    elsif keyboard.press.U then characters.push("U") 
    elsif keyboard.press.V then characters.push("V") 
    elsif keyboard.press.W then characters.push("W") 
    elsif keyboard.press.X then characters.push("X")
    elsif keyboard.press.Y then characters.push("Y")
    elsif keyboard.press.Z then characters.push("Z") end
      
  end
end
