---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Suppression.JPG" width="100%">
---
---**Functional** - Suppress fire of ground units when they get hit.
---
---===
---
---## Features:
---
---  * Hold fire of attacked units when being fired upon.
---  * Retreat to a user defined zone.
---  * Fall back on hits.
---  * Take cover on hits.
---  * Gaussian distribution of suppression time.
---
---===
---
---## Missions:
---
---## [MOOSE - ALL Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS)
---
---=== 
---
---When ground units get hit by (suppressive) enemy fire, they will not be able to shoot back for a certain amount of time.
---
---The implementation is based on an idea and script by MBot. See the [DCS forum threat](https://forums.eagle.ru/showthread.php?t=107635) for details.
---
---In addition to suppressing the fire, conditions can be specified, which let the group retreat to a defined zone, move away from the attacker
---or hide at a nearby scenery object.
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
---### Contributions: FlightControl
---
---===
---Mimic suppressive enemy fire and let groups flee or retreat.
---
---## Suppression Process
---
---![Process](..\Presentations\SUPPRESSION\Suppression_Process.png)
---
---The suppression process can be described as follows.
---
---### CombatReady
---
---A group starts in the state **CombatReady**. In this state the group is ready to fight. The ROE is set to either "Weapon Free" or "Return Fire".
---The alarm state is set to either "Auto" or "Red".
---
---### Event Hit
---The most important event in this scenario is the **Hit** event. This is an event of the FSM and triggered by the DCS event hit.
---
---### Suppressed
---After the **Hit** event the group changes its state to **Suppressed**. Technically, the ROE of the group is changed to "Weapon Hold".
---The suppression of the group will last a certain amount of time. It is randomized an will vary each time the group is hit.
---The expected suppression time is set to 15 seconds by default. But the actual value is sampled from a Gaussian distribution.
--- 
---![Process](..\Presentations\SUPPRESSION\Suppression_Gaussian.png)
---
---The graph shows the distribution of suppression times if a group would be hit 100,000 times. As can be seen, on most hits the group gets
---suppressed for around 15 seconds. Other values are also possible but they become less likely the further away from the "expected" suppression time they are.
---Minimal and maximal suppression times can also be specified. By default these are set to 5 and 25 seconds, respectively. This can also be seen in the graph
---because the tails of the Gaussian distribution are cut off at these values.
---
---### Event Recovered
---After the suppression time is over, the event **Recovered** is initiated and the group becomes **CombatReady** again.
---The ROE of the group will be set to "Weapon Free".
---
---Of course, it can also happen that a group is hit again while it is still suppressed. In that case a new random suppression time is calculated.
---If the new suppression time is longer than the remaining suppression of the previous hit, then the group recovers when the suppression time of the last
---hit has passed.
---If the new suppression time is shorter than the remaining suppression, the group will recover after the longer time of the first suppression has passed.
---
---For example:
---
---* A group gets hit the first time and is suppressed for - let's say - 15 seconds.
---* After 10 seconds, i.e. when 5 seconds of the old suppression are left, the group gets hit a again.
---* A new suppression time is calculated which can be smaller or larger than the remaining 5 seconds.
---* If the new suppression time is smaller, e.g. three seconds, than five seconds, the group will recover after the 5 remaining seconds of the first suppression have passed.
---* If the new suppression time is longer than last suppression time, e.g. 10 seconds, then the group will recover after the 10 seconds of the new hit have passed.
---
---Generally speaking, the suppression times are not just added on top of each other. Because this could easily lead to the situation that a group 
---never becomes CombatReady again before it gets destroyed.
---
---The mission designer can capture the event **Recovered** by the function #SUPPRESSION.OnAfterRecovered().
---
---## Flee Events and States
---Apart from being suppressed the groups can also flee from the enemy under certain conditions.
---
---### Event Retreat
---The first option is a retreat. This can be enabled by setting a retreat zone, i.e. a trigger zone defined in the mission editor.
---
---If the group takes a certain amount of damage, the event **Retreat** will be called and the group will start to move to the retreat zone.
---The group will be in the state **Retreating**, which means that its ROE is set to "Weapon Hold" and the alarm state is set to "Green".
---Setting the alarm state to green is necessary to enable the group to move under fire.
---
---When the group has reached the retreat zone, the event **Retreated** is triggered and the state will change to **Retreated** (note that both the event and
---the state of the same name in this case). ROE and alarm state are
---set to "Return Fire" and "Auto", respectively. The group will stay in the retreat zone and not actively participate in the combat any more.
---
---If no option retreat zone has been specified, the option retreat is not available.
---
---The mission designer can capture the events **Retreat** and **Retreated** by the functions #SUPPRESSION.OnAfterRetreat() and #SUPPRESSION.OnAfterRetreated().
---
---### Fallback
---
---If a group is attacked by another ground group, it has the option to fall back, i.e. move away from the enemy. The probability of the event **FallBack** to
---happen depends on the damage of the group that was hit. The more a group gets damaged, the more likely **FallBack** event becomes.
---
---If the group enters the state **FallingBack** it will move 100 meters in the opposite direction of the attacking unit. ROE and alarmstate are set to "Weapon Hold"
---and "Green", respectively.
---
---At the fallback point the group will wait for 60 seconds before it resumes its normal mission.
---
---The mission designer can capture the event **FallBack** by the function #SUPPRESSION.OnAfterFallBack().
---
---### TakeCover
---
---If a group is hit by either another ground or air unit, it has the option to "take cover" or "hide". This means that the group will move to a random
---scenery object in it vicinity.
---
---Analogously to the fall back case, the probability of a **TakeCover** event to occur, depends on the damage of the group. The more a group is damaged, the more
---likely it becomes that a group takes cover.
---
---When a **TakeCover** event occurs an area with a radius of 300 meters around the hit group is searched for an arbitrary scenery object.
---If at least one scenery object is found, the group will move there. One it has reached its "hideout", it will wait there for two minutes before it resumes its
---normal mission.
---
---If more than one scenery object is found, the group will move to a random one.
---If no scenery object is near the group the **TakeCover** event is rejected and the group will not move.
---
---The mission designer can capture the event **TakeCover** by the function #SUPPRESSION.OnAfterTakeCover().
---
---### Choice of FallBack or TakeCover if both are enabled?
---
---If both **FallBack** and **TakeCover** events are enabled by the functions #SUPPRESSION.Fallback() and #SUPPRESSION.Takecover() the algorithm does the following:
---
---* If the attacking unit is a ground unit, then the **FallBack** event is executed.
---* Otherwise, i.e. if the attacker is *not* a ground unit, then the **TakeCover** event is triggered.
---
---### FightBack
---
---When a group leaves the states **TakingCover** or **FallingBack** the event **FightBack** is triggered. This changes the ROE and the alarm state back to their default values.
---
---The mission designer can capture the event **FightBack** by the function #SUPPRESSION.OnAfterFightBack()
---
---# Examples
---
---## Simple Suppression
---This example shows the basic steps to use suppressive fire for a group.
---
---![Process](..\Presentations\SUPPRESSION\Suppression_Example_01.png)
---
---
---# Customization and Fine Tuning
---The following user functions can be used to change the default values
---
---* #SUPPRESSION.SetSuppressionTime() can be used to set the time a goup gets suppressed.
---* #SUPPRESSION.SetRetreatZone() sets the retreat zone and enables the possiblity for the group to retreat.
---* #SUPPRESSION.SetFallbackDistance() sets a value how far the unit moves away from the attacker after the fallback event.
---* #SUPPRESSION.SetFallbackWait() sets the time after which the group resumes its mission after a FallBack event.
---* #SUPPRESSION.SetTakecoverWait() sets the time after which the group resumes its mission after a TakeCover event.
---* #SUPPRESSION.SetTakecoverRange() sets the radius in which hideouts are searched.
---* #SUPPRESSION.SetTakecoverPlace() explicitly sets the place where the group will run at a TakeCover event.
---* #SUPPRESSION.SetMinimumFleeProbability() sets the minimum probability that a group flees (FallBack or TakeCover) after a hit. Note taht the probability increases with damage.
---* #SUPPRESSION.SetMaximumFleeProbability() sets the maximum probability that a group flees (FallBack or TakeCover) after a hit. Default is 90%.
---* #SUPPRESSION.SetRetreatDamage() sets the damage a group/unit can take before it is ordered to retreat.
---* #SUPPRESSION.SetRetreatWait() sets the time a group waits in the retreat zone after a retreat.
---* #SUPPRESSION.SetDefaultAlarmState() sets the alarm state a group gets after it becomes CombatReady again.
---* #SUPPRESSION.SetDefaultROE() set the rules of engagement a group gets after it becomes CombatReady again.
---* #SUPPRESSION.FlareOn() is mainly for debugging. A flare is fired when a unit is hit, gets suppressed, recovers, dies.
---* #SUPPRESSION.SmokeOn() is mainly for debugging. Puts smoke on retreat zone, hideouts etc.
---* #SUPPRESSION.MenuON() is mainly for debugging. Activates a radio menu item where certain functions like retreat etc. can be triggered manually.
---SUPPRESSION class
---@class SUPPRESSION : FSM_CONTROLLABLE
---@field AlarmState SUPPRESSION.AlarmState 
---@field AutoEngage boolean 
---@field BattleZone ZONE 
---@field ClassName string Name of the class.
---@field Controllable CONTROLLABLE Controllable of the FSM. Must be a ground group.
---@field CurrentAlarmState string Alam state the group is currently in.
---@field CurrentROE string ROE the group currently has.
---@field DCSdesc NOTYPE 
---@field Debug boolean Write Debug messages to DCS log file and send Debug messages to all players.
---@field DefaultAlarmState string Alarm state the group will go to when it is changed back from another state. Default is "Auto".
---@field DefaultROE string ROE the group will get once suppression is over. Default is "Free".
---@field FallbackDist number Distance in meters the unit will fall back.
---@field FallbackHeading number Heading in degrees to which the group should fall back. Default is directly away from the attacking unit.
---@field FallbackON boolean If true, group can fall back, i.e. move away from the attacking unit.
---@field FallbackWait number Time in seconds the unit will wait at the fall back point before it resumes its mission.
---@field Formation string Formation which will be used when falling back, taking cover or retreating. Default "Vee".
---@field IniGroupStrength number Number of units in a group at start.
---@field IsInfantry boolean True if group has attribute Infantry.
---@field MenuF10 string Main F10 menu for suppresion, i.e.
---@field MenuON boolean If true creates a entry in the F10 menu.
---@field Nhit number Number of times the group was hit.
---@field PmaxFlee number Maximum probability in percent that a group will flee (fall back or take cover) at each hit event. Default is 90 %.
---@field PminFlee number Minimum probability in percent that a group will flee (fall back or take cover) at each hit event. Default is 10 %.
---@field ROE SUPPRESSION.ROE 
---@field RetreatDamage number Damage in percent at which the group will be ordered to retreat.
---@field RetreatWait number Time in seconds the group will wait in the retreat zone before it resumes its mission. Default two hours. 
---@field RetreatZone ZONE Zone to which a group retreats.
---@field Speed number Speed the unit will use when falling back, taking cover or retreating. Default 999.
---@field SpeedMax number Maximum speed of group in km/h.
---@field TakecoverON boolean If true, group can hide at a nearby scenery object.
---@field TakecoverRange number Range in which the group will search for scenery objects to hide at.
---@field TakecoverWait number Time in seconds the group will hide before it will resume its mission.
---@field Tsuppress_ave number Average time in seconds a group gets suppressed. Actual value is sampled randomly from a Gaussian distribution.
---@field Tsuppress_max number Maximum time in seconds the group gets suppressed.
---@field Tsuppress_min number Minimum time in seconds the group gets suppressed.
---@field TsuppressionOver number Time at which the suppression will be over.
---@field Type string Type of the group.
---@field private eventmoose boolean If true, events are handled by MOOSE. If false, events are handled directly by DCS eventhandler. Default true.
---@field private flare boolean Flare units when they get hit or die.
---@field private hideout COORDINATE Coordinate/place where the group will try to take cover.
---@field private lid string String for DCS log file.
---@field private smoke boolean Smoke places to which the group retreats, falls back or hides.
---@field private version number PSEUDOATC version.
---@field private waypoints table Waypoints of the group as defined in the ME.
SUPPRESSION = {}

---Trigger "Dead" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:Dead() end

---Turn Debug mode on.
---Enables messages and more output to DCS log file.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:DebugOn() end

---Trigger "FallBack" event.
---
------
---@param self SUPPRESSION 
---@param AttackUnit UNIT Attacking unit. We will move away from this.
function SUPPRESSION:FallBack(AttackUnit) end

---Enable fall back if a group is hit.
---
------
---@param self SUPPRESSION 
---@param switch boolean Enable=true or disable=false fall back of group.
function SUPPRESSION:Fallback(switch) end

---Trigger "FightBack" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:FightBack() end

---Flare units when they are hit, die or recover from suppression.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:FlareOn() end

---Trigger "Hit" event.
---
------
---@param self SUPPRESSION 
---@param Unit UNIT Unit that was hit.
---@param AttackUnit UNIT Unit that attacked.
function SUPPRESSION:Hit(Unit, AttackUnit) end

---Create an F10 menu entry for the suppressed group.
---The menu is mainly for Debugging purposes.
---
------
---@param self SUPPRESSION 
---@param switch boolean Enable=true or disable=false menu group. Default is true.
function SUPPRESSION:MenuOn(switch) end

---Creates a new AI_suppression object.
---
------
---@param self SUPPRESSION 
---@param group GROUP The GROUP object for which suppression should be applied.
---@return SUPPRESSION #self
function SUPPRESSION:New(group) end

---User function for OnAfter "Dead" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterDead(Controllable, From, Event, To) end

---User function for OnAfter "FallBack" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackUnit UNIT Attacking unit. We will move away from this.
function SUPPRESSION:OnAfterFallBack(Controllable, From, Event, To, AttackUnit) end

---User function for OnAfter "FlightBack" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterFightBack(Controllable, From, Event, To) end

---User function for OnAfter "Hit" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit UNIT Unit that was hit.
---@param AttackUnit UNIT Unit that attacked.
function SUPPRESSION:OnAfterHit(Controllable, From, Event, To, Unit, AttackUnit) end

---User function for OnAfter "OutOfAmmo" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterOutOfAmmo(Controllable, From, Event, To) end

---User function for OnAfter "Recovered" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterRecovered(Controllable, From, Event, To) end

---User function for OnAfter "Retreat" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterRetreat(Controllable, From, Event, To) end

---User function for OnAfter "Retreated" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterRetreated(Controllable, From, Event, To) end

---User function for OnAfter "Status" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function SUPPRESSION:OnAfterStatus(Controllable, From, Event, To) end

---User function for OnAfter "TakeCover" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Hideout COORDINATE Place where the group will hide.
function SUPPRESSION:OnAfterTakeCover(Controllable, From, Event, To, Hideout) end

---User function for OnBefore "FallBack" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackUnit UNIT Attacking unit. We will move away from this.
---@return boolean #
function SUPPRESSION:OnBeforeFallBack(Controllable, From, Event, To, AttackUnit) end

---User function for OnBefore "FlightBack" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #
function SUPPRESSION:OnBeforeFightBack(Controllable, From, Event, To) end

---User function for OnBefore "Hit" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit UNIT Unit that was hit.
---@param AttackUnit UNIT Unit that attacked.
---@return boolean #
function SUPPRESSION:OnBeforeHit(Controllable, From, Event, To, Unit, AttackUnit) end

---User function for OnBefore "Recovered" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean # 
function SUPPRESSION:OnBeforeRecovered(Controllable, From, Event, To) end

---User function for OnBefore "Retreat" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #
function SUPPRESSION:OnBeforeRetreat(Controllable, From, Event, To) end

---User function for OnBefore "Retreated" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #
function SUPPRESSION:OnBeforeRetreated(Controllable, From, Event, To) end

---User function for OnBefore "TakeCover" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Hideout COORDINATE Place where the group will hide.
---@return boolean #
function SUPPRESSION:OnBeforeTakeCover(Controllable, From, Event, To, Hideout) end

---Order group to fall back between 100 and 150 meters in a random direction.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:OrderFallBack() end

---Order group to retreat to a pre-defined zone.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:OrderRetreat() end

---Order group to take cover at a nearby scenery object.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:OrderTakeCover() end

---Trigger "OutOfAmmo" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:OutOfAmmo() end

---Trigger "Recovered" event after a delay.
---
------
---@param Delay number Delay in seconds. 
---@param self SUPPRESSION 
function SUPPRESSION.Recovered(Delay, self) end

---Trigger "Retreat" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:Retreat() end

---Trigger "Retreated" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:Retreated() end

---Set alarm state a group will get after it returns from a fall back or take cover.
---
------
---@param self SUPPRESSION 
---@param alarmstate string Alarm state. Possible "Auto", "Green", "Red". Default is "Auto".
function SUPPRESSION:SetDefaultAlarmState(alarmstate) end

---Set Rules of Engagement (ROE) a group will get when it recovers from suppression.
---
------
---@param self SUPPRESSION 
---@param roe string ROE after suppression. Possible "Free", "Hold" or "Return". Default "Free".
function SUPPRESSION:SetDefaultROE(roe) end

---Set distance a group will fall back when it gets hit.
---
------
---@param self SUPPRESSION 
---@param distance number Distance in meters.
function SUPPRESSION:SetFallbackDistance(distance) end

---Set time a group waits at its fall back position before it resumes its normal mission.
---
------
---@param self SUPPRESSION 
---@param time number Time in seconds.
function SUPPRESSION:SetFallbackWait(time) end

---Set the formation a group uses for fall back, hide or retreat.
---
------
---@param self SUPPRESSION 
---@param formation string Formation of the group. Default "Vee".
function SUPPRESSION:SetFormation(formation) end

---Set maximum probability that a group flees (falls back or takes cover) after a hit event.
---Default is 90%.
---
------
---@param self SUPPRESSION 
---@param probability number Probability in percent.
function SUPPRESSION:SetMaximumFleeProbability(probability) end

---Set minimum probability that a group flees (falls back or takes cover) after a hit event.
---Default is 10%.
---
------
---@param self SUPPRESSION 
---@param probability number Probability in percent.
function SUPPRESSION:SetMinimumFleeProbability(probability) end

---Set damage threshold before a group is ordered to retreat if a retreat zone was defined.
---If the group consists of only a singe unit, this referrs to the life of the unit.
---If the group consists of more than one unit, this referrs to the group strength relative to its initial strength.
---
------
---@param self SUPPRESSION 
---@param damage number Damage in percent. If group gets damaged above this value, the group will retreat. Default 50 %.
function SUPPRESSION:SetRetreatDamage(damage) end

---Set time a group waits in the retreat zone before it resumes its mission.
---Default is two hours.
---
------
---@param self SUPPRESSION 
---@param time number Time in seconds. Default 7200 seconds = 2 hours.
function SUPPRESSION:SetRetreatWait(time) end

---Set the zone to which a group retreats after being damaged too much.
---
------
---@param self SUPPRESSION 
---@param zone ZONE MOOSE zone object.
function SUPPRESSION:SetRetreatZone(zone) end

---Set speed a group moves at for fall back, hide or retreat.
---
------
---@param self SUPPRESSION 
---@param speed number Speed in km/h of group. Default max speed the group can do.
function SUPPRESSION:SetSpeed(speed) end

---Set average, minimum and maximum time a unit is suppressed each time it gets hit.
---
------
---@param self SUPPRESSION 
---@param Tave number Average time [seconds] a group will be suppressed. Default is 15 seconds.
---@param Tmin? number (Optional) Minimum time [seconds] a group will be suppressed. Default is 5 seconds.
---@param Tmax? number (Optional) Maximum time a group will be suppressed. Default is 25 seconds.
function SUPPRESSION:SetSuppressionTime(Tave, Tmin, Tmax) end

---Set hideout place explicitly.
---
------
---@param self SUPPRESSION 
---@param Hideout COORDINATE Place where the group will hide after the TakeCover event.
function SUPPRESSION:SetTakecoverPlace(Hideout) end

---Set distance a group searches for hideout places.
---
------
---@param self SUPPRESSION 
---@param range number Search range in meters.
function SUPPRESSION:SetTakecoverRange(range) end

---Set time a group waits at its hideout position before it resumes its normal mission.
---
------
---@param self SUPPRESSION 
---@param time number Time in seconds.
function SUPPRESSION:SetTakecoverWait(time) end

---Smoke positions where units fall back to, hide or retreat.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:SmokeOn() end

---Trigger "Status" event.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:Status() end

---Status of group.
---Current ROE, alarm state, life.
---
------
---@param self SUPPRESSION 
---@param message boolean Send message to all players.
function SUPPRESSION:StatusReport(message) end

---Trigger "TakeCover" event.
---
------
---@param self SUPPRESSION 
---@param Hideout COORDINATE Place where the group will hide.
function SUPPRESSION:TakeCover(Hideout) end

---Enable take cover option if a unit is hit.
---
------
---@param self SUPPRESSION 
---@param switch boolean Enable=true or disable=false fall back of group.
function SUPPRESSION:Takecover(switch) end

---Create F10 main menu, i.e.
---F10/Suppression. The menu is mainly for Debugging purposes.
---
------
---@param self SUPPRESSION 
function SUPPRESSION:_CreateMenuGroup() end

---Print event-from-to string to DCS log file.
---
------
---@param self SUPPRESSION 
---@param BA string Before/after info.
---@param Event string Event.
---@param From string From state.
---@param To string To state.
function SUPPRESSION:_EventFromTo(BA, Event, From, To) end

---Get (relative) life in percent of a group.
---Function returns the value of the units with the smallest and largest life. Also the average value of all groups is returned.
---
------
---@param self SUPPRESSION 
---@return number #Smallest life value of all units.
---@return number #Largest life value of all units.
---@return number #Average life value of all alife groups
---@return number #Average life value of all groups including already dead ones.
---@return number #Relative group strength.
function SUPPRESSION:_GetLife() end

--- Heading from point a to point b in degrees.
---
------
---@param self SUPPRESSION 
---@param a COORDINATE Coordinate.
---@param b COORDINATE Coordinate.
---@return number #angle Angle from a to b in degrees.
function SUPPRESSION:_Heading(a, b) end

---Event handler for Dead event of suppressed groups.
---
------
---@param self SUPPRESSION 
---@param EventData EVENTDATA 
function SUPPRESSION:_OnEventDead(EventData) end

---Event handler for Dead event of suppressed groups.
---
------
---@param self SUPPRESSION 
---@param EventData EVENTDATA 
function SUPPRESSION:_OnEventHit(EventData) end

--- Function called when group is passing a waypoint.
---At the last waypoint we set the group back to CombatReady.
---
------
---@param group GROUP Group which is passing a waypoint.
---@param Fsm SUPPRESSION The suppression object.
---@param i number Waypoint number that has been reached.
---@param final boolean True if it is the final waypoint. Start Fightback.
function SUPPRESSION._Passing_Waypoint(group, Fsm, i, final) end

---Generate Gaussian pseudo-random numbers.
---
------
---@param self SUPPRESSION 
---@param x0 number Expectation value of distribution.
---@param sigma? number (Optional) Standard deviation. Default 10.
---@param xmin? number (Optional) Lower cut-off value.
---@param xmax? number (Optional) Upper cut-off value.
---@return number #Gaussian random number.
function SUPPRESSION:_Random_Gaussian(x0, sigma, xmin, xmax) end

--- Make group run/drive to a certain point.
---We put in several intermediate waypoints because sometimes the group stops before it arrived at the desired point.
---
------
---@param self SUPPRESSION 
---@param fin COORDINATE Coordinate where we want to go.
---@param speed number Speed of group. Default is 20.
---@param formation string Formation of group. Default is "Vee".
---@param wait number Time the group will wait/hold at final waypoint. Default is 30 seconds.
function SUPPRESSION:_Run(fin, speed, formation, wait) end

--- Search a place to hide.
---This is any scenery object in the vicinity.
---
------
---@param self SUPPRESSION 
---@return COORDINATE #Coordinate of the hideout place.
---@return  #nil If no scenery object is within search radius.
function SUPPRESSION:_SearchHideout() end

---Sets the alarm state of the group and updates the current alarm state variable.
---
------
---@param self SUPPRESSION 
---@param state string Alarm state the group will get. Possible "Auto", "Green", "Red". Default is self.DefaultAlarmState.
function SUPPRESSION:_SetAlarmState(state) end

---Sets the ROE for the group and updates the current ROE variable.
---
------
---@param self SUPPRESSION 
---@param roe string ROE the group will get. Possible "Free", "Hold", "Return". Default is self.DefaultROE.
function SUPPRESSION:_SetROE(roe) end

---Suppress fire of a unit by setting its ROE to "Weapon Hold".
---
------
---@param self SUPPRESSION 
function SUPPRESSION:_Suppress() end

---Trigger "Dead" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
function SUPPRESSION:__Dead(Delay) end

---Trigger "FallBack" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
---@param AttackUnit UNIT Attacking unit. We will move away from this.
function SUPPRESSION:__FallBack(Delay, AttackUnit) end

---Trigger "FightBack" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
function SUPPRESSION:__FightBack(Delay) end

---Trigger "Hit" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
---@param Unit UNIT Unit that was hit.
---@param AttackUnit UNIT Unit that attacked.
function SUPPRESSION:__Hit(Delay, Unit, AttackUnit) end

---Trigger "OutOfAmmo" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
function SUPPRESSION:__OutOfAmmo(Delay) end

---Trigger "Retreat" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
function SUPPRESSION:__Retreat(Delay) end

---Trigger "Retreated" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
function SUPPRESSION:__Retreated(Delay) end

---Trigger "Status" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds.
function SUPPRESSION:__Status(Delay) end

---Trigger "TakeCover" event after a delay.
---
------
---@param self SUPPRESSION 
---@param Delay number Delay in seconds. 
---@param Hideout COORDINATE Place where the group will hide.
function SUPPRESSION:__TakeCover(Delay, Hideout) end

--- Event handler for suppressed groups.
---
------
---@param self SUPPRESSION 
---@param Event NOTYPE 
---@private
function SUPPRESSION:onEvent(Event) end

---After "Dead" event, when a unit has died.
---When all units of a group are dead, FSM is stopped and eventhandler removed.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterDead(Controllable, From, Event, To) end

---After "FallBack" event.
---We get the heading away from the attacker and route the group a certain distance in that direction.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackUnit UNIT Attacking unit. We will move away from this.
---@private
function SUPPRESSION:onafterFallBack(Controllable, From, Event, To, AttackUnit) end

---After "FightBack" event.
---ROE and Alarm state are set back to default.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterFightBack(Controllable, From, Event, To) end

---After "Hit" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Unit UNIT Unit that was hit.
---@param AttackUnit UNIT Unit that attacked.
---@private
function SUPPRESSION:onafterHit(Controllable, From, Event, To, Unit, AttackUnit) end

---After "OutOfAmmo" event.
---Triggered when group is completely out of ammo.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterOutOfAmmo(Controllable, From, Event, To) end

---After "Recovered" event.
---Group has recovered and its ROE is set back to the "normal" unsuppressed state. Optionally the group is flared green.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterRecovered(Controllable, From, Event, To) end

---After "Retreat" event.
---Find a random point in the retreat zone and route the group there.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterRetreat(Controllable, From, Event, To) end

---After "Retreateded" event.
---Group has reached the retreat zone. Set ROE to return fire and alarm state to auto.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterRetreated(Controllable, From, Event, To) end

---After "Start" event.
---Initialized ROE and alarm state. Starts the event handler.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterStart(Controllable, From, Event, To) end

---After "Status" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterStatus(Controllable, From, Event, To) end

---After "Stop" event.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onafterStop(Controllable, From, Event, To) end

---After "TakeCover" event.
---Group will run to a nearby scenery object and "hide" there for a certain time.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Hideout COORDINATE Place where the group will hide.
---@private
function SUPPRESSION:onafterTakeCover(Controllable, From, Event, To, Hideout) end

---Before "FallBack" event.
---We check that group is not already falling back.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackUnit UNIT Attacking unit. We will move away from this.
---@return boolean #
---@private
function SUPPRESSION:onbeforeFallBack(Controllable, From, Event, To, AttackUnit) end

---Before "Recovered" event.
---Check if suppression time is over.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #
---@private
function SUPPRESSION:onbeforeRecovered(Controllable, From, Event, To) end

---Before "Retreat" event.
---We check that the group is not already retreating.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return boolean #True if transition is allowed, False if transition is forbidden.
---@private
function SUPPRESSION:onbeforeRetreat(Controllable, From, Event, To) end

---Before "Retreateded" event.
---Check that the group is really in the retreat zone.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function SUPPRESSION:onbeforeRetreated(Controllable, From, Event, To) end

---Before "TakeCover" event.
---Search an area around the group for possible scenery objects where the group can hide.
---
------
---@param self SUPPRESSION 
---@param Controllable CONTROLLABLE Controllable of the group.
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Hideout COORDINATE Place where the group will hide.
---@return boolean #
---@private
function SUPPRESSION:onbeforeTakeCover(Controllable, From, Event, To, Hideout) end


---Enumerator of possible alarm states.
---@class SUPPRESSION.AlarmState 
---@field Auto string Automatic.
---@field Green string Green.
---@field Red string Red.
SUPPRESSION.AlarmState = {}


---Enumerator of possible rules of engagement.
---@class SUPPRESSION.ROE 
---@field Free string Weapon fire.
---@field Hold string Hold fire.
---@field Return string Return fire.
SUPPRESSION.ROE = {}



