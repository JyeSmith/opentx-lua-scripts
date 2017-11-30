-- FENIX_BatteryAlarm.lua
-- https://github.com/jyesmith/opentx-lua-scripts
-- By Jye Smith

-- CONFIG --

local minVoltage = 14.4 -- minimum voltage before announcment
local delayTimeInSeconds = 6.0 -- delay in seconds between announcments
local sagTimeInSeconds = 4.0 -- delay in seconds between announcments

-- DON'T EDIT BELOW THIS LINE --

local unitVolts = 1 -- Sets voltage units to be announced
local battVolts = 0
local timeOfLastAnnouncment = 0
local timeBelowMinVoltage = 0
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
    
    if battVolts <= minVoltage and getTime() > (timeOfLastAnnouncment + (delayTimeInSeconds * 100)) then
      if timeBelowMinVoltage == 0 then 
        timeBelowMinVoltage = getTime()
      end
      if getTime() > (timeBelowMinVoltage + (sagTimeInSeconds * 100)) then
        playNumber(battVolts*10, unitVolts, PREC1)
        timeOfLastAnnouncment = getTime()
      end
    elseif battVolts > minVoltage then
      timeBelowMinVoltage = 0
    end -- delay
  
  end -- getRSSI()

end 

local function run_func(event)
  -- run_func is called periodically only when screen is visible
  
  lcd.clear()  
	
  if rssi > 0 then
    if battVolts <= minVoltage then
      lcd.drawText(25, 15, battVolts, XXLSIZE + BLINK )
    else 
      lcd.drawText(25, 15, battVolts, XXLSIZE )
    end
  else
    lcd.drawText(25, 15, "00.0", XXLSIZE )
  end

end

return { run=run_func, background=bg_func, init=init_func  }
