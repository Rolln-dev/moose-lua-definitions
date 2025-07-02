---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/SEAD.JPG" width="100%">
---
---**Functional** - Make SAM sites evasive and execute defensive behaviour when being fired upon.
---
---===
---
---## Features:
---
---  * When SAM sites are being fired upon, the SAMs will take evasive action will reposition themselves when possible.
---  * When SAM sites are being fired upon, the SAMs will take defensive action by shutting down their radars.
---  * SEAD calculates the time it takes for a HARM to reach the target - and will attempt to minimize the shut-down time.
---  * Detection and evasion of shots has a random component based on the skill level of the SAM groups.
---
---===
---
---## Missions:
---
---[SEV - SEAD Evasion](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Sead)
---
---===
---
---### Authors: **applevangelist**, **FlightControl**
---
---Last Update: Dec 2024
---
---===
---Make SAM sites execute evasive and defensive behaviour when being fired upon.
---
---This class is very easy to use. Just setup a SEAD object by using #SEAD.New() and SAMs will evade and take defensive action when being fired upon.
---Once a HARM attack is detected, SEAD will shut down the radars of the attacked SAM site and take evasive action by moving the SAM
---vehicles around (*if* they are driveable, that is). There's a component of randomness in detection and evasion, which is based on the
---skill set of the SAM set (the higher the skill, the more likely). When a missile is fired from far away, the SAM will stay active for a 
---period of time to stay defensive, before it takes evasive actions.
---
---# Constructor:
---
---Use the #SEAD.New() constructor to create a new SEAD object.
---
---      SEAD_RU_SAM_Defenses = SEAD:New( { 'RU SA-6 Kub', 'RU SA-6 Defenses', 'RU MI-26 Troops', 'RU Attack Gori' } )
---@class SEAD : BASE
---@field CallBack function Callback function for suppression plans.
---@field ClassName string The Class Name.
---@field EngagementRange number Engagement Range.
---@field HarmData table Missile enumerators - from DCS ME and Wikipedia
---@field Harms table Missile enumerators
---@field Padding number Padding in seconds.
---@field SEADGroupPrefixes table Table of SEAD prefixes.
---@field SuppressedGroups table Table of currently suppressed groups.
---@field TargetSkill table Table of target skills.
---@field UseCallBack boolean Switch for callback function to be used.
---@field UseEmissionsOnOff NOTYPE 
---@field WeaponTrack boolen Track switch, if true track weapon speed for 30 secs.
---@field private debug boolean Debug switch.
SEAD = {}

---Set an object to call back when going evasive.
---
------
---@param Object table The object to call. Needs to have object functions as follows: `:SeadSuppressionPlanned(Group, Name, SuppressionStartTime, SuppressionEndTime)`  `:SeadSuppressionStart(Group, Name)`,  `:SeadSuppressionEnd(Group, Name)`, 
---@return SEAD #self
function SEAD:AddCallBack(Object) end

---(Internal) Detects if an SAM site was shot with an anti radiation missile.
---In this case, take evasive actions based on the skill level set within the ME.
---
------
---@param EventData EVENTDATA 
---@return SEAD #self
function SEAD:HandleEventShot(EventData) end

---Creates the main object which is handling defensive actions for SA sites or moving SA vehicles.
---When an anti radiation missile is fired (KH-58, KH-31P, KH-31A, KH-25MPU, HARM missiles), the SA will shut down their radars and will take evasive actions...
---Chances are big that the missile will miss.
---
------
---
---USAGE
---```
----- CCCP SEAD Defenses
----- Defends the Russian SA installations from SEAD attacks.
---SEAD_RU_SAM_Defenses = SEAD:New( { 'RU SA-6 Kub', 'RU SA-6 Defenses', 'RU MI-26 Troops', 'RU Attack Gori' } )
---```
------
---@param SEADGroupPrefixes table Table of #string entries or single #string, which is a table of Prefixes of the SA Groups in the DCS mission editor on which evasive actions need to be taken.
---@param Padding? number (Optional) Extra number of seconds to add to radar switch-back-on time
---@return SEAD #self
function SEAD:New(SEADGroupPrefixes, Padding) end

---Sets the engagement range of the SAMs.
---Defaults to 75% to make it more deadly. Feature Request #1355
---
------
---@param range number Set the engagement range in percent, e.g. 55 (default 75)
---@return SEAD #self
function SEAD:SetEngagementRange(range) end

---Set the padding in seconds, which extends the radar off time calculated by SEAD
---
------
---@param Padding number Extra number of seconds to add for the switch-on (default 10 seconds)
---@return SEAD #self
function SEAD:SetPadding(Padding) end

---Set SEAD to use emissions on/off in addition to alarm state.
---
------
---@param Switch boolean True for on, false for off.
---@return SEAD #self
function SEAD:SwitchEmissions(Switch) end

---Update the active SEAD Set (while running)
---
------
---@param SEADGroupPrefixes table The prefixes to add, note: can also be a single #string
---@return SEAD #self
function SEAD:UpdateSet(SEADGroupPrefixes) end

---(Internal) Check if a known HARM was fired
---
------
---@param WeaponName string 
---@return boolean #Returns true for a match
---@return string #name Name of hit in table
function SEAD:_CheckHarms(WeaponName) end

---(Internal) Return distance in meters between two coordinates or -1 on error.
---
------
---@param _point1 COORDINATE Coordinate one
---@param _point2 COORDINATE Coordinate two
---@return number #Distance in meters
function SEAD:_GetDistance(_point1, _point2) end

---(Internal) Calculate hit zone of an AGM-88
---
------
---@param SEADWeapon table DCS.Weapon object
---@param pos0 COORDINATE Position of the plane when it fired
---@param height number Height when the missile was fired
---@param SEADGroup GROUP Attacker group
---@param SEADWeaponName string Weapon Name
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return SEAD #self 
---@private
function SEAD:onafterCalculateHitZone(SEADWeapon, pos0, height, SEADGroup, SEADWeaponName, From, Event, To) end

---(Internal) Handle Evasion
---
------
---@param _targetskill string 
---@param _targetgroup GROUP 
---@param SEADPlanePos COORDINATE 
---@param SEADWeaponName string 
---@param SEADGroup GROUP Attacker Group
---@param timeoffset number Offset for tti calc
---@param Weapon WEAPON 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@return SEAD #self 
---@private
function SEAD:onafterManageEvasion(_targetskill, _targetgroup, SEADPlanePos, SEADWeaponName, SEADGroup, timeoffset, Weapon, From, Event, To) end



