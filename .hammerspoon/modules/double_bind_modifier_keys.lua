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

  local ms_wait = 150
  local ns_wait = ms_wait * 1000000

  local keyDownAt = 0
  hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(eventType)
    local keyCode = modToCode[modName]

    if eventType:getKeyCode() ~= keyCode then
      return false
    end

    keyDown = eventType:getFlags()[codeToMod[keyCode]]
    if keyDown then
      keyDownAt = eventType:timestamp()
    else
      if (eventType:timestamp() - keyDownAt) <= ns_wait then
        hs.eventtap.keyStroke(modifiers, key)
      end
    end
  end):start()
end
doubleBindModifierKey('ctrl', {}, 'escape')
doubleBindModifierKey('left shift', {'shift'}, '9')
doubleBindModifierKey('right shift', {'shift'}, '0')
