-- Skype mega-caller Hammerspoon.

local cac = {"cmd", "shift"} 
-- hs.eventtap.keyStroke(cac, "r")

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "J", function ()
  while (true)
  do
  	hs.eventtap.keyStroke(cac, "r")
  	hs.eventtap.keyStroke(cac, "h")
  end
end)
