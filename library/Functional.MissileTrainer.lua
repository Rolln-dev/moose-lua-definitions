---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Missile_Trainer.JPG" width="100%">
---
---**Functional** - Train missile defence and deflection.
---
---===
---
---## Features:
---
---  * Track the missiles fired at you and other players, providing bearing and range information of the missiles towards the airplanes.
---  * Provide alerts of missile launches, including detailed information of the units launching, including bearing, range
---  * Provide alerts when a missile would have killed your aircraft.
---  * Provide alerts when the missile self destructs.
---  * Enable / Disable and Configure the Missile Trainer using the various menu options.
---
---===
---
---## Missions:
---
---[MIT - Missile Trainer](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/MissileTrainer)
---
---===
---
---Uses the MOOSE messaging system to be alerted of any missiles fired, and when a missile would hit your aircraft,
---the class will destroy the missile within a certain range, to avoid damage to your aircraft.
---
---When running a mission where the missile trainer is used, the following radio menu structure ( 'Radio Menu' -> 'Other (F10)' -> 'MissileTrainer' ) options are available for the players:
---
--- * **Messages**: Menu to configure all messages.
---    * **Messages On**: Show all messages.
---    * **Messages Off**: Disable all messages.
--- * **Tracking**: Menu to configure missile tracking messages.
---    * **To All**: Shows missile tracking messages to all players.
---    * **To Target**: Shows missile tracking messages only to the player where the missile is targeted at.
---    * **Tracking On**: Show missile tracking messages.
---    * **Tracking Off**: Disable missile tracking messages.
---    * **Frequency Increase**: Increases the missile tracking message frequency with one second.
---    * **Frequency Decrease**: Decreases the missile tracking message frequency with one second.
--- * **Alerts**: Menu to configure alert messages.
---    * **To All**: Shows alert messages to all players.
---    * **To Target**: Shows alert messages only to the player where the missile is (was) targeted at.
---    * **Hits On**: Show missile hit alert messages.
---    * **Hits Off**: Disable missile hit alert messages.
---    * **Launches On**: Show missile launch messages.
---    * **Launches Off**: Disable missile launch messages.
--- * **Details**: Menu to configure message details.
---    * **Range On**: Shows range information when a missile is fired to a target.
---    * **Range Off**: Disable range information when a missile is fired to a target.
---    * **Bearing On**: Shows bearing information when a missile is fired to a target.
---    * **Bearing Off**: Disable bearing information when a missile is fired to a target.
--- * **Distance**: Menu to configure the distance when a missile needs to be destroyed when near to a player, during tracking. This will improve/influence hit calculation accuracy, but has the risk of damaging the aircraft when the missile reaches the aircraft before the distance is measured.
---    * **50 meter**: Destroys the missile when the distance to the aircraft is below or equal to 50 meter.
---    * **100 meter**: Destroys the missile when the distance to the aircraft is below or equal to 100 meter.
---    * **150 meter**: Destroys the missile when the distance to the aircraft is below or equal to 150 meter.
---    * **200 meter**: Destroys the missile when the distance to the aircraft is below or equal to 200 meter.
---    
---# Developer Note
---
---![Banner Image](..\Images\deprecated.png)
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE.
---Therefore, this class is considered to be deprecated and superseded by the [Functional.Fox](https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Functional.Fox.html) class, which provides the same functionality.
---
---===
---
---### Authors: **FlightControl**
---
---### Contributions:
---
---   * **Stuka (Danny)**: Who you can search on the Eagle Dynamics Forums. Working together with Danny has resulted in the MISSILETRAINER class.
---     Danny has shared his ideas and together we made a design.
---     Together with the **476 virtual team**, we tested the MISSILETRAINER class, and got much positive feedback!
---   * **132nd Squadron**: Testing and optimizing the logic.
---
---===
---
---# Constructor:
---
---Create a new MISSILETRAINER object with the #MISSILETRAINER.New method:
---
---  * #MISSILETRAINER.New: Creates a new MISSILETRAINER object taking the maximum distance to your aircraft to evaluate when a missile needs to be destroyed.
---
---MISSILETRAINER will collect each unit declared in the mission with a skill level "Client" and "Player", and will monitor the missiles shot at those.
---
---# Initialization:
---
---A MISSILETRAINER object will behave differently based on the usage of initialization methods:
---
--- * #MISSILETRAINER.InitMessagesOnOff: Sets by default the display of any message to be ON or OFF.
--- * #MISSILETRAINER.InitTrackingToAll: Sets by default the missile tracking report for all players or only for those missiles targeted to you.
--- * #MISSILETRAINER.InitTrackingOnOff: Sets by default the display of missile tracking report to be ON or OFF.
--- * #MISSILETRAINER.InitTrackingFrequency: Increases, decreases the missile tracking message display frequency with the provided time interval in seconds.
--- * #MISSILETRAINER.InitAlertsToAll: Sets by default the display of alerts to be shown to all players or only to you.
--- * #MISSILETRAINER.InitAlertsHitsOnOff: Sets by default the display of hit alerts ON or OFF.
--- * #MISSILETRAINER.InitAlertsLaunchesOnOff: Sets by default the display of launch alerts ON or OFF.
--- * #MISSILETRAINER.InitRangeOnOff: Sets by default the display of range information of missiles ON of OFF.
--- * #MISSILETRAINER.InitBearingOnOff: Sets by default the display of bearing information of missiles ON of OFF.
--- * #MISSILETRAINER.InitMenusOnOff: Allows to configure the options through the radio menu.
--- 
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE.
---Therefore, this class is considered to be deprecated and superseded by the [Functional.Fox](https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Documentation/Functional.Fox.html) class, which provides the same functionality.
---@deprecated
---@class MISSILETRAINER : BASE
---@field AlertsHitsOnOff NOTYPE 
---@field AlertsLaunchesOnOff NOTYPE 
---@field AlertsToAll NOTYPE 
---@field DBClients SET_CLIENT 
---@field DetailsBearingOnOff NOTYPE 
---@field DetailsRangeOnOff NOTYPE 
---@field MenusOnOff NOTYPE 
---@field MessagesOnOff NOTYPE 
---@field TrackingOnOff NOTYPE 
---@field TrackingToAll NOTYPE 
MISSILETRAINER = {}

---Sets by default the display of hit alerts ON or OFF.
---
------
---@param self MISSILETRAINER 
---@param AlertsHitsOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitAlertsHitsOnOff(AlertsHitsOnOff) end

---Sets by default the display of launch alerts ON or OFF.
---
------
---@param self MISSILETRAINER 
---@param AlertsLaunchesOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitAlertsLaunchesOnOff(AlertsLaunchesOnOff) end

---Sets by default the display of alerts to be shown to all players or only to you.
---
------
---@param self MISSILETRAINER 
---@param AlertsToAll boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitAlertsToAll(AlertsToAll) end

---Sets by default the display of bearing information of missiles ON of OFF.
---
------
---@param self MISSILETRAINER 
---@param DetailsBearingOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitBearingOnOff(DetailsBearingOnOff) end

---Enables / Disables the menus.
---
------
---@param self MISSILETRAINER 
---@param MenusOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitMenusOnOff(MenusOnOff) end

---Sets by default the display of any message to be ON or OFF.
---
------
---@param self MISSILETRAINER 
---@param MessagesOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitMessagesOnOff(MessagesOnOff) end

---Sets by default the display of range information of missiles ON of OFF.
---
------
---@param self MISSILETRAINER 
---@param DetailsRangeOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitRangeOnOff(DetailsRangeOnOff) end

---Increases, decreases the missile tracking message display frequency with the provided time interval in seconds.
---The default frequency is a 3 second interval, so the Tracking Frequency parameter specifies the increase or decrease from the default 3 seconds or the last frequency update.
---
------
---@param self MISSILETRAINER 
---@param TrackingFrequency number Provide a negative or positive value in seconds to incraese or decrease the display frequency.
---@return MISSILETRAINER #self
function MISSILETRAINER:InitTrackingFrequency(TrackingFrequency) end

---Sets by default the display of missile tracking report to be ON or OFF.
---
------
---@param self MISSILETRAINER 
---@param TrackingOnOff boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitTrackingOnOff(TrackingOnOff) end

---Sets by default the missile tracking report for all players or only for those missiles targeted to you.
---
------
---@param self MISSILETRAINER 
---@param TrackingToAll boolean true or false
---@return MISSILETRAINER #self
function MISSILETRAINER:InitTrackingToAll(TrackingToAll) end

---Creates the main object which is handling missile tracking.
---When a missile is fired a SCHEDULER is set off that follows the missile. When near a certain a client player, the missile will be destroyed.
---
------
---@param self MISSILETRAINER 
---@param Distance number The distance in meters when a tracked missile needs to be destroyed when close to a player.
---@param Briefing? string (Optional) Will show a text to the players when starting their mission. Can be used for briefing purposes.
---@return MISSILETRAINER #
function MISSILETRAINER:New(Distance, Briefing) end

---Detects if an SA site was shot with an anti radiation missile.
---In this case, take evasive actions based on the skill level set within the ME.
---
------
---@param self MISSILETRAINER 
---@param EventData EVENTDATA 
---@param EVentData NOTYPE 
function MISSILETRAINER:OnEventShot(EventData, EVentData) end


---
------
---@param self NOTYPE 
---@param Client NOTYPE 
---@param TrainerWeapon NOTYPE 
function MISSILETRAINER:_AddBearing(Client, TrainerWeapon) end


---
------
---@param self NOTYPE 
---@param Client NOTYPE 
---@param TrainerWeapon NOTYPE 
function MISSILETRAINER:_AddRange(Client, TrainerWeapon) end


---
------
---@param Client NOTYPE 
---@param self NOTYPE 
function MISSILETRAINER._Alive(Client, self) end


---
------
---@param MenuParameters NOTYPE 
function MISSILETRAINER._MenuMessages(MenuParameters) end


---
------
---@param self NOTYPE 
function MISSILETRAINER:_TrackMissiles() end



