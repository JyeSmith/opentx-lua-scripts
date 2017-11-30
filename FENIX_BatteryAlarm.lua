-- FENIX_BatteryAlarm.lua
-- https://github.com/jyesmith/opentx-lua-scripts
-- By Jye Smith

-- CONFIG --

minVoltage = 14.4 -- minimum voltage before announcment
delayInSeconds = 4.0 -- delay in seconds between announcments

-- DON'T EDIT BELOW THIS LINE --

unitVolts = 1
battVolts = 0
timeOfLastAnnouncment = 0

local function init_func()
  -- init_func is called once when model is loaded
end

local function bg_func()
  -- bg_func is called periodically (always, the screen visibility does not matter)
  
  if getRSSI() then
    
    battVolts = getValue(vfas)
    
	if getTime() < timeOfLastAnnouncment + (delayInSeconds * 100) and battVolts < minVoltage then
      playNumber(battVolts, unitVolts)
      timeOfLastAnnouncment = gettime()
	end -- delay
	
  end -- getRSSI()
  
end 

local function run_func(event)
  -- run_func is called periodically only when screen is visible
  
  lcd.clear()  
  
  if battVolts < minVoltage then
    lcd.drawText(30, 20, battVolts .. "V", XXLSIZE + INVERS + BLINK )
  else
    lcd.drawText(30, 20, battVolts .. "V", XXLSIZE )  
  end
    
end

return { run=run_func, background=bg_func, init=init_func  }