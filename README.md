# opentx-lua-scripts

## BatAlm.lua

A super simple battery monitoring script for when I fly LOS. It displays the voltage in large font and reads out the voltage when below the minVoltage.

Below are the configuratble variable, minimum votage, delay between announcments, and delay in first announcment to account for voltage sag.

```lua
local minVoltage = 14.4 -- minimum voltage before announcment
local delayTimeInSeconds = 6.0 -- delay in seconds between announcments
local sagTimeInSeconds = 4.0 -- delay in seconds before announcment after dropping below minVoltage
```

## Useful links

https://opentx.gitbooks.io/opentx-2-2-lua-reference-guide/

Betaflight lua
https://github.com/betaflight/betaflight-tx-lua-scripts

OpenTX Simulation how to
https://www.youtube.com/watch?time_continue=112&v=emzo0jN-x9A

Online lua test
http://codepad.org
