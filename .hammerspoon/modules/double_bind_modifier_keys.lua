function doubleBindModifierKey(modName, modifiers, key)
  local modToCode = {
    ['left shift'] = 56,
    ['ctrl'] = 59,
    ['right shift'] = 60
  }
  local codeToMod = {
    [56] = 'shift', -- left
    [59] = 'ctrl',
    [60] = 'shift' -- right
  }

  local displayLoneTap = null
  local locked = false

  hs.caffeinate.watcher.new(function(eventType)
    if eventType == hs.caffeinate.watcher.screensDidLock then
      locked = true
      displayLoneTap = null
    end
    if eventType == hs.caffeinate.watcher.screensDidUnlock then
      locked = false
      displayLoneTap = null
    end
  end):start()

  hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(eventType)
    displayLoneTap = null
  end):start()

  hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(eventType)
    if locked then
      return
    end

    keyCode = eventType:getKeyCode()

    pressedDown = eventType:getFlags()[codeToMod[keyCode]]
    if pressedDown then
      displayLoneTap = keyCode
    else
      if keyCode == modToCode[modName] and keyCode == displayLoneTap then
        hs.eventtap.keyStroke(modifiers, key)
        displayLoneTap = null
      end
    end
  end):start()
end
doubleBindModifierKey('ctrl', {}, 'escape')
doubleBindModifierKey('left shift', {'shift'}, '9')
doubleBindModifierKey('right shift', {'shift'}, '0')
