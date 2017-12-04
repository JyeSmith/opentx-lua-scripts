-- PotSnd.lua
-- https://github.com/jyesmith/opentx-lua-scripts
-- By Jye Smith

-- WARNING - UNTESTED! THIS MESSAGE WILL BE REMOVED ONCE TESTED.

local filePlayed = false

local function run(event)

  local potValue = getValue("s1")             -- http://downloads-20.open-tx.org/firmware/lua_fields.txt

  if potValue < 1200 and ~filePlayed then
    playFile(low_rates)                       -- https://opentx.gitbooks.io/opentx-2-2-lua-reference-guide/general/playFile.html
    filePlayed = true
  elseif potValue > 1400 and potValue < 1600 and ~filePlayed then
    playFile(mid_rates)
    filePlayed = true
  elseif potValue > 1800 and ~filePlayed then
    playFile(high_rates)
    filePlayed = true
  else
    filePlayed = false
  end

end

return { run=run }
