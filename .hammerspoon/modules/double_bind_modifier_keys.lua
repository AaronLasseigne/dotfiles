function doubleBindModifierKey(modName, modifiers, key)
  local ms_wait = 140
  local ns_wait = ms_wait * 1000000

  local keyDownAt = 0
  hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(eventType)
    keyDownAt = 0
  end):start()
  hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(eventType)
    local keyCode = hs.keycodes.map[modName]

    if eventType:getKeyCode() ~= keyCode then
      return false
    end

    local genericModName = modName:gsub("^right", "")
    keyDown = eventType:getFlags()[genericModName]
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
doubleBindModifierKey('rightctrl', {}, 'escape')
doubleBindModifierKey('shift', {'shift'}, '9')
doubleBindModifierKey('rightshift', {'shift'}, '0')
