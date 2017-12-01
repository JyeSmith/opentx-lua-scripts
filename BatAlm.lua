-- FENIX_BatteryAlarm.lua
-- https://github.com/jyesmith/opentx-lua-scripts
-- By Jye Smith

-- CONFIG --

local minVoltage = 14.4 -- minimum voltage before announcment
local delayTimeInSeconds = 6.0 -- delay in seconds between announcments
local sagTimeInSeconds = 4.0 -- delay in seconds before announcment after dropping below minVoltage

-- DON'T EDIT BELOW THIS LINE --

local unitVolts = 1 -- Sets voltage units to be announced
local battVolts = 999
local timeOfLastAnnouncment = 0
local rssi, alarm_low, alarm_crit = getRSSI()

function round(num, numDecimalPlaces)
  return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

local function init_func()
  -- init_func is called once when model is loaded
end

local function bg_func()
  -- bg_func is called periodically (always, the screen visibility does not matter)
  
  rssi, alarm_low, alarm_crit = getRSSI()
  
  if rssi > 0 then
    
    battVolts = round(getValue("VFAS"), 1)
    currentTime = getTime()
    
    if battVolts <= minVoltage and currentTime > timeOfLastAnnouncment then
      timeOfLastAnnouncment = currentTime + delayTimeInSeconds * 100
      playNumber(battVolts*10, unitVolts, PREC1)
    elseif battVolts > minVoltage then
      timeOfLastAnnouncment = currentTime + sagTimeInSeconds * 100
    end -- delay
  
  end -- getRSSI()

end 

local function run_func(event)
  -- run_func is called periodically only when screen is visible
  
  lcd.clear()
  
  if rssi > 0 and battVolts <= minVoltage then
    lcd.drawText(22, 15, battVolts, XXLSIZE + BLINK )
  elseif rssi > 0 and battVolts > minVoltage then
    lcd.drawText(22, 15, battVolts, XXLSIZE )
  else
    lcd.drawText(43, 20, "RSSI = " .. rssi, LSIZE )
    lcd.drawText(22, 35, "Plug in the Quad!", LSIZE )
  end

end

return { run=run_func, background=bg_func, init=init_func  }
