---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Radio.JPG" width="100%">
---
---**Core** - TACAN and other beacons.
---
---===
---
---## Features:
---
---  * Provide beacon functionality to assist pilots.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Core/Beacon)
---
---===
---
---### Authors: Hugues "Grey_Echo" Bousquet, funkyfranky
---*In order for the light to shine so brightly, the darkness must be present.* -- Francis Bacon
---
---After attaching a #BEACON to your Wrapper.Positionable#POSITIONABLE, you need to select the right function to activate the kind of beacon you want.
---There are two types of BEACONs available : the (aircraft) TACAN Beacon and the general purpose Radio Beacon.
---Note that in both case, you can set an optional parameter : the `BeaconDuration`. This can be very useful to simulate the battery time if your BEACON is
---attach to a cargo crate, for example. 
---
---## Aircraft TACAN Beacon usage
---
---This beacon only works with airborne Wrapper.Unit#UNIT or a Wrapper.Group#GROUP. Use #BEACON.ActivateTACAN() to set the beacon parameters and start the beacon.
---Use #BEACON.StopRadioBeacon() to stop it.
---
---## General Purpose Radio Beacon usage
---
---This beacon will work with any Wrapper.Positionable#POSITIONABLE, but **it won't follow the Wrapper.Positionable#POSITIONABLE** ! This means that you should only use it with
---Wrapper.Positionable#POSITIONABLE that don't move, or move very slowly. Use #BEACON.RadioBeacon() to set the beacon parameters and start the beacon.
---Use #BEACON.StopRadioBeacon() to stop it.
---@class BEACON : BASE
---@field ClassName string Name of the class "BEACON".
---@field Positionable CONTROLLABLE The @{Wrapper.Controllable#CONTROLLABLE} that will receive radio capabilities.
---@field System BEACON.System 
---@field Type BEACON.Type 
---@field UniqueName number Counter to make the unique naming work.
---@field private name NOTYPE 
BEACON = {}

---DEPRECATED: Please use #BEACON.ActivateTACAN() instead.
---Activates a TACAN BEACON on an Aircraft.
---
------
---
---USAGE
---```
----- Let's create a TACAN Beacon for a tanker
---local myUnit = UNIT:FindByName("MyUnit") 
---local myBeacon = myUnit:GetBeacon() -- Creates the beacon
---
---myBeacon:AATACAN(20, "TEXACO", true) -- Activate the beacon
---```
------
---@param TACANChannel number (the "10" part in "10Y"). Note that AA TACAN are only available on Y Channels
---@param Message string The Message that is going to be coded in Morse and broadcasted by the beacon
---@param Bearing boolean Can the BEACON be homed on ?
---@param BeaconDuration number How long will the beacon last in seconds. Omit for forever.
---@return BEACON #self
function BEACON:AATACAN(TACANChannel, Message, Bearing, BeaconDuration) end

---Activates an ICLS BEACON.
---The unit the BEACON is attached to should be an aircraft carrier supporting this system.
---
------
---@param Channel number ICLS channel.
---@param Callsign string The Message that is going to be coded in Morse and broadcasted by the beacon.
---@param Duration number How long will the beacon last in seconds. Omit for forever.
---@return BEACON #self
function BEACON:ActivateICLS(Channel, Callsign, Duration) end

---Activates a LINK4 BEACON.
---The unit the BEACON is attached to should be an aircraft carrier supporting this system.
---
------
---@param Frequency number LINK4 FRequency in MHz, eg 336.
---@param Morse string The ID that is going to be coded in Morse and broadcasted by the beacon.
---@param Duration number How long will the beacon last in seconds. Omit for forever.
---@return BEACON #self
function BEACON:ActivateLink4(Frequency, Morse, Duration) end

---Activates a TACAN BEACON.
---
------
---
---USAGE
---```
----- Let's create a TACAN Beacon for a tanker
---local myUnit = UNIT:FindByName("MyUnit") 
---local myBeacon = myUnit:GetBeacon() -- Creates the beacon
---
---myBeacon:ActivateTACAN(20, "Y", "TEXACO", true) -- Activate the beacon
---```
------
---@param Channel number TACAN channel, i.e. the "10" part in "10Y".
---@param Mode string TACAN mode, i.e. the "Y" part in "10Y".
---@param Message string The Message that is going to be coded in Morse and broadcasted by the beacon.
---@param Bearing boolean If true, beacon provides bearing information. If false (or nil), only distance information is available.
---@param Duration number How long will the beacon last in seconds. Omit for forever.
---@return BEACON #self
function BEACON:ActivateTACAN(Channel, Mode, Message, Bearing, Duration) end

---Create a new BEACON Object.
---This doesn't activate the beacon, though, use #BEACON.ActivateTACAN etc.
---If you want to create a BEACON, you probably should use Wrapper.Positionable#POSITIONABLE.GetBeacon() instead.
---
------
---@param Positionable POSITIONABLE The @{Wrapper.Positionable} that will receive radio capabilities.
---@return BEACON #Beacon object or #nil if the positionable is invalid.
function BEACON:New(Positionable) end

---Activates a general purpose Radio Beacon
---This uses the very generic singleton function "trigger.action.radioTransmission()" provided by DCS to broadcast a sound file on a specific frequency.
---Although any frequency could be used, only a few DCS Modules can home on radio beacons at the time of writing, i.e. the Mi-8, Huey, Gazelle etc.
---The following e.g. can home in on these specific frequencies : 
---* **Mi8**
---* R-828 -> 20-60MHz
---* ARKUD -> 100-150MHz (canal 1 : 114166, canal 2 : 114333, canal 3 : 114583, canal 4 : 121500, canal 5 : 123100, canal 6 : 124100) AM
---* ARK9 -> 150-1300KHz
---* **Huey**
---* AN/ARC-131 -> 30-76 Mhz FM
---
------
---
---USAGE
---```
----- Let's create a beacon for a unit in distress.
----- Frequency will be 40MHz FM (home-able by a Huey's AN/ARC-131)
----- The beacon they use is battery-powered, and only lasts for 5 min
---local UnitInDistress = UNIT:FindByName("Unit1")
---local UnitBeacon = UnitInDistress:GetBeacon()
---
----- Set the beacon and start it
---UnitBeacon:RadioBeacon("MySoundFileSOS.ogg", 40, radio.modulation.FM, 20, 5*60)
---```
------
---@param FileName string The name of the audio file
---@param Frequency number in MHz
---@param Modulation number either radio.modulation.AM or radio.modulation.FM
---@param Power number in W
---@param BeaconDuration number How long will the beacon last in seconds. Omit for forever.
---@return BEACON #self
function BEACON:RadioBeacon(FileName, Frequency, Modulation, Power, BeaconDuration) end

---Stops the AA TACAN BEACON
---
------
---@return BEACON #self
function BEACON:StopAATACAN() end

---Stops the Radio Beacon
---
------
---@return BEACON #self
function BEACON:StopRadioBeacon() end

---Converts a TACAN Channel/Mode couple into a frequency in Hz
---
------
---@param TACANChannel number 
---@param TACANMode string 
---@return number #Frequecy
---@return nil #if parameters are invalid
function BEACON:_TACANToFrequency(TACANChannel, TACANMode) end


---Beacon systems supported by DCS.
---https://wiki.hoggitworld.com/view/DCS_command_activateBeacon
---@class BEACON.System 
---@field BROADCAST_STATION number Broadcast station.
---@field ICLS_GLIDESLOPE number Carrier landing system.
---@field ICLS_LOCALIZER number Carrier landing system.
---@field ILS_GLIDESLOPE number ILS glide slope.
---@field ILS_LOCALIZER number ILS localizer
---@field PAR_10 number ?
---@field PRGM_GLIDESLOPE number PRGM glide slope.
---@field PRGM_LOCALIZER number PRGM localizer.
---@field PRMG_GLIDESLOPE number 
---@field PRMG_LOCALIZER number 
---@field RSBN_5 number Russian VOR/DME system.
---@field TACAN number TACtical Air Navigation system on ground.
---@field TACAN_AA_MODE_X number TACtical Air Navigation for aircraft on X band.
---@field TACAN_AA_MODE_Y number TACtical Air Navigation for aircraft on Y band.
---@field TACAN_TANKER_X number TACtical Air Navigation system for tankers on X band.
---@field TACAN_TANKER_Y number TACtical Air Navigation system for tankers on Y band.
---@field VOR number Very High Frequency Omni-Directional Range
---@field VORDME number Radio beacon that combines a VHF omnidirectional range (VOR) with a distance measuring equipment (DME).
---@field VORTAC number Radio-based navigational aid for aircraft pilots consisting of a co-located VHF omni-directional range (VOR) beacon and a tactical air navigation system (TACAN) beacon.
BEACON.System = {}


---Beacon types supported by DCS.
---@class BEACON.Type 
---@field AIRPORT_HOMER number 
---@field AIRPORT_HOMER_WITH_MARKER number 
---@field BROADCAST_STATION number 
---@field DME number 
---@field HOMER number 
---@field ICLS number Same as ICLS glideslope.
---@field ICLS_GLIDESLOPE number 
---@field ICLS_LOCALIZER number 
---@field ILS_FAR_HOMER number 
---@field ILS_GLIDESLOPE number 
---@field ILS_LOCALIZER number 
---@field ILS_NEAR_HOMER number 
---@field NAUTICAL_HOMER number 
---@field NULL number 
---@field PRMG_GLIDESLOPE number 
---@field PRMG_LOCALIZER number 
---@field RSBN number 
---@field TACAN number TACtical Air Navigation system.
---@field VOR number 
---@field VORTAC number 
---@field VOR_DME number 
BEACON.Type = {}



