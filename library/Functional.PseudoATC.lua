---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Pseudo_ATC.JPG" width="100%">
---
---**Functional** - Basic ATC.
--- 
---![Banner Image](..\Presentations\PSEUDOATC\PSEUDOATC_Main.jpg)
---
---====
---
---The pseudo ATC enhances the standard DCS ATC functions.
---
---In particular, a menu entry "Pseudo ATC" is created in the "F10 Other..." radiomenu.
---
---## Features:
---
---* Weather report at nearby airbases and mission waypoints.
---* Report absolute bearing and range to nearest airports and mission waypoints.
---* Report current altitude AGL of own aircraft.
---* Upon request, ATC reports altitude until touchdown.
---* Works with static and dynamic weather.
---* Player can select the unit system (metric or imperial) in which information is reported.
---* All maps supported (Caucasus, NTTR, Normandy, Persian Gulf and all future maps).
--- 
---====
---
---# YouTube Channel
---
---### [MOOSE YouTube Channel](https://www.youtube.com/channel/UCjrA9j5LQoWsG4SpS8i79Qg)
---
---===
---
---### Author: **funkyfranky**
---
---### Contributions: FlightControl, Applevangelist
---
---====
---Adds some rudimentary ATC functionality via the radio menu.
---
---Local weather reports can be requested for nearby airports and player's mission waypoints.
---The weather report includes
---
---* QFE and QNH pressures,
---* Temperature,
---* Wind direction and strength.
---
---The list of airports is updated every 60 seconds. This interval can be adjusted by the function #PSEUDOATC.SetMenuRefresh(*interval*).
---
---Likewise, absolute bearing and range to the close by airports and mission waypoints can be requested.
---
---The player can switch the unit system in which all information is displayed during the mission with the MOOSE settings radio menu.
---The unit system can be set to either imperial or metric. Altitudes are reported in feet or meter, distances in kilometers or nautical miles,
---temperatures in degrees Fahrenheit or Celsius and QFE/QNH pressues in inHg or mmHg.
---Note that the pressures are also reported in hPa independent of the unit system setting.
---
---In bad weather conditions, the ATC can "talk you down", i.e. will continuously report your altitude on the final approach.
---Default reporting time interval is 3 seconds. This can be adjusted via the #PSEUDOATC.SetReportAltInterval(*interval*) function.
---The reporting stops automatically when the player lands or can be stopped manually by clicking on the radio menu item again.
---So the radio menu item acts as a toggle to switch the reporting on and off.
---
---## Scripting
---
---Scripting is almost trivial. Just add the following two lines to your script:
---
---    pseudoATC=PSEUDOATC:New()
---    pseudoATC:Start()
---- PSEUDOATC class
---@class PSEUDOATC : BASE
---@field ClassName string Name of the Class.
---@field Debug boolean If true, print debug info to dcs.log file.
---@field private chatty boolean Display some messages on events like take-off and touchdown.
---@field private eventsmoose boolean [Deprecated] If true, events are handled by MOOSE. If false, events are handled directly by DCS eventhandler.
---@field private id string Some ID to identify who we are in output of the DCS.log file.
---@field private mdur number Duration in seconds how low messages to the player are displayed.
---@field private mrefresh number Interval in seconds after which the F10 menu is refreshed. E.g. by the closest airports. Default is 120 sec.
---@field private player table Table comprising each player info.
---@field private reportplayername boolean If true, use playername not callsign on callouts
---@field private talt number Interval in seconds between reporting altitude until touchdown. Default 3 sec.
---@field private version number PSEUDOATC version.
PSEUDOATC = {}

---Toggle report altitude reporting on/off.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:AltidudeTimerToggle(GID, UID) end

---Start altitude reporting scheduler.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:AltitudeTimeStart(GID, UID) end

---Stop/destroy DCS scheduler function for reporting altitude.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:AltitudeTimerStop(GID, UID) end

---Chatty mode off.
---Don't display some messages on take-off and touchdown.
---
------
function PSEUDOATC:ChattyOff() end

---Chatty mode on.
---Display some messages on take-off and touchdown.
---
------
function PSEUDOATC:ChattyOn() end

---Debug mode off.
---This is the default setting.
---
------
function PSEUDOATC:DebugOff() end

---Debug mode on.
---Send messages to everone.
---
------
function PSEUDOATC:DebugOn() end

---Create list of nearby airports sorted by distance to player unit.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:LocalAirports(GID, UID) end

---Create "F10/Pseudo ATC/Local Airports/Airport Name/" menu items each containing weather report and BR request.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:MenuAirports(GID, UID) end

---Clear player menus.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:MenuClear(GID, UID) end

---Create player menus.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:MenuCreatePlayer(GID, UID) end

---Refreshes all player menues.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:MenuRefresh(GID, UID) end

---Create "F10/Pseudo ATC/Waypoints/<Waypoint i>  menu items.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
function PSEUDOATC:MenuWaypoints(GID, UID) end

---PSEUDOATC contructor.
---
------
---@return PSEUDOATC #Returns a PSEUDOATC object.
function PSEUDOATC:New() end

---Function called when a player enters a unit.
---
------
---@param unit UNIT Unit the player entered.
function PSEUDOATC:PlayerEntered(unit) end

---Function called when a player has landed.
---
------
---@param unit UNIT Unit of player which has landed.
---@param place string Name of the place the player landed at.
function PSEUDOATC:PlayerLanded(unit, place) end

---Function called when a player leaves a unit or dies.
---
------
---@param unit UNIT Player unit which was left.
function PSEUDOATC:PlayerLeft(unit) end

---Function called when a player took off.
---
------
---@param unit UNIT Unit of player which has landed.
---@param place string Name of the place the player landed at.
function PSEUDOATC:PlayerTakeOff(unit, place) end

---Report absolute bearing and range form player unit to airport.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
---@param position COORDINATE Coordinates at which the pressure is measured.
---@param location string Name of the location at which the pressure is measured.
function PSEUDOATC:ReportBR(GID, UID, position, location) end

---Report altitude above ground level of player unit.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
---@param dt? number (Optional) Duration the message is displayed.
---@param _clear? boolean (Optional) Clear previouse messages. 
---@return number #Altitude above ground.
function PSEUDOATC:ReportHeight(GID, UID, dt, _clear) end

---Weather Report.
---Report pressure QFE/QNH, temperature, wind at certain location.
---
------
---@param GID number Group id of player unit.
---@param UID number Unit id of player. 
---@param position COORDINATE Coordinates at which the pressure is measured.
---@param location string Name of the location at which the pressure is measured.
function PSEUDOATC:ReportWeather(GID, UID, position, location) end

---[Deprecated] Enable/disable event handling by MOOSE or DCS.
---
------
---@param switch boolean If true, events are handled by MOOSE (default). If false, events are handled directly by DCS.
function PSEUDOATC:SetEventsMoose(switch) end

---Set time interval after which the F10 radio menu is refreshed.
---
------
---@param interval number Interval in seconds. Default is every 120 sec.
function PSEUDOATC:SetMenuRefresh(interval) end

---Set duration how long messages are displayed.
---
------
---@param duration number Time in seconds. Default is 30 sec.
function PSEUDOATC:SetMessageDuration(duration) end

---Set time interval for reporting altitude until touchdown.
---
------
---@param interval number Interval in seconds. Default is every 3 sec.
function PSEUDOATC:SetReportAltInterval(interval) end

---Use player name, not call sign, in callouts
---
------
function PSEUDOATC:SetReportPlayername() end

---Starts the PseudoATC event handlers.
---
------
function PSEUDOATC:Start() end

---Display message to group.
---
------
---@param _unit UNIT Player unit.
---@param _text string Message text.
---@param _time number Duration how long the message is displayed.
---@param _clear boolean Clear up old messages.
function PSEUDOATC:_DisplayMessageToGroup(_unit, _text, _time, _clear) end

---Returns the unit of a player and the player name.
---If the unit does not belong to a player, nil is returned.
---
------
---@param _unitName string Name of the player unit.
---@return UNIT #Unit of player.
---@return string #Name of the player.
---@return NOTYPE #nil If player does not exist.
function PSEUDOATC:_GetPlayerUnitAndName(_unitName) end

---Function called my MOOSE event handler when a player enters a unit.
---
------
---@param EventData EVENTDATA 
function PSEUDOATC:_OnBirth(EventData) end

---Function called by MOOSE event handler when a player landed.
---
------
---@param EventData EVENTDATA 
function PSEUDOATC:_PlayerLanded(EventData) end

---Function called by MOOSE event handler when a player leaves a unit or dies.
---
------
---@param EventData EVENTDATA 
function PSEUDOATC:_PlayerLeft(EventData) end

---Function called by MOOSE/DCS event handler when a player took off.
---
------
---@param EventData EVENTDATA 
function PSEUDOATC:_PlayerTakeOff(EventData) end

---Returns a string which consits of this callsign and the player name.

---
------
---@param unitname string Name of the player unit.
function PSEUDOATC:_myname(unitname) end



