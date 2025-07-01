---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Functional.Shorad.jpg" width="100%">
---
---**Functional** - Short Range Air Defense System.
---
---===
---
---## Features: 
---
---  * Short Range Air Defense System
---  * Controls a network of short range air/missile defense groups.
---
---===
---
---## Missions:
---
---### [SHORAD - Short Range Air Defense](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Shorad)
---
---===
---
---### Author : **applevangelist **
---*Good friends are worth defending.* Mr Tushman, Wonder (the Movie) 
---
---Simple Class for a more intelligent Short Range Air Defense System
---
---#SHORAD
---Moose derived missile intercepting short range defense system.
---Protects a network of SAM sites. Uses events to switch on the defense groups closest to the enemy.
---Easily integrated with Functional.Mantis#MANTIS to complete the defensive system setup.
---
---## Usage
---
---Set up a #SET_GROUP for the SAM sites to be protected:  
---
---       `local SamSet = SET_GROUP:New():FilterPrefixes("Red SAM"):FilterCoalitions("red"):FilterStart()`   
---   
---By default, SHORAD will defense against both HARMs and AG-Missiles with short to medium range. The default defense probability is 70-90%.
---When a missile is detected, SHORAD will activate defense groups in the given radius around the target for 10 minutes. It will *not* react to friendly fire.    
---       
---### Start a new SHORAD system, parameters are:
---  
--- * Name: Name of this SHORAD.  
--- * ShoradPrefix: Filter for the Shorad #SET_GROUP.  
--- * Samset: The #SET_GROUP of SAM sites to defend.  
--- * Radius: Defense radius in meters. 
--- * ActiveTimer: Determines how many seconds the systems stay on red alert after wake-up call.  
--- * Coalition: Coalition, i.e. "blue", "red", or "neutral".* 
---   
---       `myshorad = SHORAD:New("RedShorad", "Red SHORAD", SamSet, 25000, 600, "red")`       
---
---## Customization options   
--- 
--- * myshorad:SwitchDebug(debug)
--- * myshorad:SwitchHARMDefense(onoff)
--- * myshorad:SwitchAGMDefense(onoff)
--- * myshorad:SetDefenseLimits(low,high)
--- * myshorad:SetActiveTimer(seconds)
--- * myshorad:SetDefenseRadius(meters)
--- * myshorad:AddScootZones(ZoneSet,Number,Random,Formation)
---- **SHORAD** class, extends Core.Base#BASE
---@class SHORAD : BASE
---@field ActiveGroups table Table for the timer function
---@field ActiveTimer number How long a Shorad stays active after wake-up in seconds
---@field ClassName string 
---@field Coalition string The coalition of this Shorad
---@field DefendHarms boolean Default true, intercept incoming HARMS
---@field DefendMavs boolean Default true, intercept incoming AG-Missiles
---@field DefenseHighProb number Default 90, maximum detection limit
---@field DefenseLowProb number Default 70, minimum detection limit
---@field Groupset SET_GROUP The set of Shorad groups
---@field Harms table 
---@field Mavs table TODO complete list?
---@field Prefixes string String to be used to build the @{#Core.Set#SET_GROUP} 
---@field Radius number Shorad defense radius in meters
---@field Samset SET_GROUP The set of SAM groups to defend
---@field SkateNumber number Number of zones to consider
---@field SkateZones SET_ZONE Zones in this set are considered
---@field UseEmOnOff boolean Decide if we are using Emission on/off (default) or AlarmState red/green
---@field private debug boolean Set the debug state
---@field private lid string The log ID for the dcs.log
---@field private maxscootdist number Max distance of the next zone
---@field private minscootdist number Min distance of the next zone
---@field private name string Name of this Shorad
---@field private scootformation string Formation to take for scooting, e.g. "Vee" or "Cone"  
---@field private scootrandomcoord boolean If true, use a random coordinate in the zone and not the center
---@field private shootandscoot boolean If true, shoot and scoot between zones
SHORAD = {}

---Add a SET_ZONE of zones for Shoot&Scoot
---
------
---@param self SHORAD 
---@param ZoneSet SET_ZONE Set of zones to be used. Units will move around to the next (random) zone between 100m and 3000m away.
---@param Number number Number of closest zones to be considered, defaults to 3.
---@param Random boolean If true, use a random coordinate inside the next zone to scoot to.
---@param Formation string Formation to use, defaults to "Cone". See mission editor dropdown for options.
---@return SHORAD #self
function SHORAD:AddScootZones(ZoneSet, Number, Random, Formation) end

---Main function - work on the EventData
---
------
---@param self SHORAD 
---@param EventData EVENTDATA The event details table data set
---@return SHORAD #self 
function SHORAD:HandleEventShot(EventData) end

---Instantiates a new SHORAD object
---
------
---@param self SHORAD 
---@param Name string Name of this SHORAD
---@param ShoradPrefix string Filter for the Shorad #SET_GROUP
---@param Samset SET_GROUP The #SET_GROUP of SAM sites to defend
---@param Radius number Defense radius in meters, used to switch on SHORAD groups **within** this radius
---@param ActiveTimer number Determines how many seconds the systems stay on red alert after wake-up call
---@param Coalition string Coalition, i.e. "blue", "red", or "neutral"
---@param UseEmOnOff boolean Use Emissions On/Off rather than Alarm State Red/Green (default: use Emissions switch)
---@return SHORAD #self
function SHORAD:New(Name, ShoradPrefix, Samset, Radius, ActiveTimer, Coalition, UseEmOnOff) end

---Set the number of seconds a SHORAD site will stay active
---
------
---@param self SHORAD 
---@param seconds number Number of seconds systems stay active
---@return SHORAD #self 
function SHORAD:SetActiveTimer(seconds) end

---Set defense probability limits
---
------
---@param self SHORAD 
---@param low number Minimum detection limit, integer 1-100
---@param high number Maximum detection limit integer 1-100
---@return SHORAD #self 
function SHORAD:SetDefenseLimits(low, high) end

---Set the number of meters for the SHORAD defense zone
---
------
---@param self SHORAD 
---@param meters number Radius of the defense search zone in meters. #SHORADs in this range around a targeted group will go active 
---@return SHORAD #self 
function SHORAD:SetDefenseRadius(meters) end

---Set using Emission on/off instead of changing alarm state
---
------
---@param self SHORAD 
---@param switch boolean Decide if we are changing alarm state or AI state
---@return SHORAD #self 
function SHORAD:SetUsingEmOnOff(switch) end

---Switch defense for AGMs
---
------
---@param self SHORAD 
---@param onoff boolean 
---@return SHORAD #self 
function SHORAD:SwitchAGMDefense(onoff) end

---Switch debug state on
---
------
---@param self SHORAD 
---@param debug boolean Switch debug on (true) or off (false)
---@param onoff NOTYPE 
---@return SHORAD #self 
function SHORAD:SwitchDebug(debug, onoff) end

---Switch debug state off
---
------
---@param self SHORAD 
---@return SHORAD #self 
function SHORAD:SwitchDebugOff() end

---Switch debug state on
---
------
---@param self SHORAD 
---@return SHORAD #self 
function SHORAD:SwitchDebugOn() end

---Switch defense for HARMs
---
------
---@param self SHORAD 
---@param onoff boolean 
---@return SHORAD #self 
function SHORAD:SwitchHARMDefense(onoff) end

---Check the coalition of the attacker
---
------
---@param self SHORAD 
---@param Coalition string name
---@return boolean #Returns false for a match
function SHORAD:_CheckCoalition(Coalition) end

---Check if a HARM was fired
---
------
---@param self SHORAD 
---@param WeaponName string 
---@return boolean #Returns true for a match
function SHORAD:_CheckHarms(WeaponName) end

---Check if an AGM was fired
---
------
---@param self SHORAD 
---@param WeaponName string 
---@return boolean #Returns true for a match
function SHORAD:_CheckMavs(WeaponName) end

---Check if the missile is aimed at a SAM site
---
------
---@param self SHORAD 
---@param TargetGroupName string Name of the target group
---@return boolean #Returns true for a match, else false
function SHORAD:_CheckShotAtSams(TargetGroupName) end

---Check if the missile is aimed at a SHORAD
---
------
---@param self SHORAD 
---@param TargetGroupName string Name of the target group
---@return boolean #Returns true for a match, else false
function SHORAD:_CheckShotAtShorad(TargetGroupName) end

---Initially set all groups to alarm state GREEN
---
------
---@param self SHORAD 
---@return SHORAD #self
function SHORAD:_InitState() end

---Calculate if the missile shot is detected
---
------
---@param self SHORAD 
---@return boolean #Returns true for a detection, else false
function SHORAD:_ShotIsDetected() end

---(Internal) Calculate hit zone of an AGM-88
---
------
---@param self SHORAD 
---@param SEADWeapon table DCS.Weapon object
---@param pos0 COORDINATE Position of the plane when it fired
---@param height number Height when the missile was fired
---@param SEADGroup GROUP Attacker group
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return SHORAD #self 
---@private
function SHORAD:onafterCalculateHitZone(SEADWeapon, pos0, height, SEADGroup, From, Event, To) end

---(Internal) Shoot and Scoot
---
------
---@param self SHORAD 
---@param From string 
---@param Event string 
---@param To string 
---@param Shorad GROUP Shorad group
---@return SHORAD #self 
---@private
function SHORAD:onafterShootAndScoot(From, Event, To, Shorad) end

---Wake up #SHORADs in a zone with diameter Radius for ActiveTimer seconds
---
------
---
---USAGE
---```
---Use this function to integrate with other systems, example   
---
---local SamSet = SET_GROUP:New():FilterPrefixes("Blue SAM"):FilterCoalitions("blue"):FilterStart()
---myshorad = SHORAD:New("BlueShorad", "Blue SHORAD", SamSet, 22000, 600, "blue")
---myshorad:SwitchDebug(true)
---mymantis = MANTIS:New("BlueMantis","Blue SAM","Blue EWR",nil,"blue",false,"Blue Awacs")
---mymantis:AddShorad(myshorad,720)
---mymantis:Start()
---```
------
---@param self SHORAD 
---@param TargetGroup string Name of the target group used to build the #ZONE
---@param Radius number Radius of the #ZONE
---@param ActiveTimer number Number of seconds to stay active
---@param TargetCat? number (optional) Category, i.e. Object.Category.UNIT or Object.Category.STATIC
---@param ShotAt boolean If true, function is called after a shot
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return SHORAD #self 
---@private
function SHORAD:onafterWakeUpShorad(TargetGroup, Radius, ActiveTimer, TargetCat, ShotAt, From, Event, To) end



