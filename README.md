# opentx-lua-scripts

## BatAlm.lua

A super simple battery monitoring script for when I fly LOS. It displays the voltage in large font and reads out the voltage when below the minVoltage.

Add 3sbat.wav and 4sbat.wav sound files to the '/SOUNDS/en' folder.  Pressing the togglewheel on the QX7 now changes between 3s and 4s battery minVoltages and plays wav.

Below are the configurable variables, minimum votage for 3 and 4s batteries, delay between announcments, and delay in first announcment to account for voltage sag.

```lua
local minVoltage3s = 10.8 -- minimum voltage for 3s
local minVoltage4s = 14.4 -- minimum voltage for 4s
local delayTimeInSeconds = 6.0 -- delay in seconds between announcments
local sagTimeInSeconds = 4.0 -- delay in seconds before announcment after dropping below minVoltage
```

## Useful links

https://opentx.gitbooks.io/opentx-2-2-lua-reference-guide/

Betaflight lua
https://github.com/betaflight/betaflight-tx-lua-scripts

OpenTX Simulation how to
https://www.youtube.com/watch?time_continue=112&v=emzo0jN-x9A

Text to speech for custom sounds.
https://text-to-speech-demo.ng.bluemix.net/

ffmpeg mp3 to wav convertion

```
ffmpeg -i song.mp3 -acodec pcm_s16le -ar 8000 -ac 1 song.wav
```

Online lua test
http://codepad.org
