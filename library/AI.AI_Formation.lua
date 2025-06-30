---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Large_Formations.JPG" width="100%">
---
---**AI** - Build large airborne formations of aircraft.
---
---**Features:**
---
---  * Build in-air formations consisting of more than 40 aircraft as one group.
---  * Build different formation types.
---  * Assign a group leader that will guide the large formation path.
---
---===
---
---## Additional Material:
---
---* **Demo Missions:** [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_Formation)
---* **YouTube videos:** [Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl0bFIJ9jIdYM22uaWmIN4oz)
---* **Guides:** None
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---===
---Build large formations, make AI follow a Wrapper.Client#CLIENT (player) leader or a Wrapper.Unit#UNIT (AI) leader.
---
---![Banner Image](..\Images\deprecated.png)
---
---AI_FORMATION makes AI Wrapper.Group#GROUPs fly in formation of various compositions.
---The AI_FORMATION class models formations in a different manner than the internal DCS formation logic!!!
---The purpose of the class is to:
---
---  * Make formation building a process that can be managed while in flight, rather than a task.
---  * Human players can guide formations, consisting of larget planes.
---  * Build large formations (like a large bomber field).
---  * Form formations that DCS does not support off the shelve.
---
---A few remarks:
---
---  * Depending on the type of plane, the change in direction by the leader may result in the formation getting disentangled while in flight and needs to be rebuild.
---  * Formations are vulnerable to collissions, but is depending on the type of plane, the distance between the planes and the speed and angle executed by the leader.
---  * Formations may take a while to build up.
---
---As a result, the AI_FORMATION is not perfect, but is very useful to:
---
---  * Model large formations when flying straight line. You can build close formations when doing this.
---  * Make humans guide a large formation, when the planes are wide from each other.
---  
---## AI_FORMATION construction
---
---Create a new SPAWN object with the #AI_FORMATION.New method:
---
---  * #AI_FORMATION.New(): Creates a new AI_FORMATION object from a Wrapper.Group#GROUP for a Wrapper.Client#CLIENT or a Wrapper.Unit#UNIT, with an optional briefing text.
---
---## Formation methods
---
---The following methods can be used to set or change the formation:
---
--- * #AI_FORMATION.FormationLine(): Form a line formation (core formation function).
--- * #AI_FORMATION.FormationTrail(): Form a trail formation.
--- * #AI_FORMATION.FormationLeftLine(): Form a left line formation.
--- * #AI_FORMATION.FormationRightLine(): Form a right line formation.
--- * #AI_FORMATION.FormationRightWing(): Form a right wing formation.
--- * #AI_FORMATION.FormationLeftWing(): Form a left wing formation.
--- * #AI_FORMATION.FormationCenterWing(): Form a center wing formation.
--- * #AI_FORMATION.FormationCenterVic(): Form a Vic formation (same as CenterWing.
--- * #AI_FORMATION.FormationCenterBoxed(): Form a center boxed formation.
--- 
---## Randomization
---
---Use the method AI.AI_Formation#AI_FORMATION.SetFlightRandomization() to simulate the formation flying errors that pilots make while in formation. Is a range set in meters.
---AI_FORMATION class
---@deprecated
---@class AI_FORMATION : FSM_SET
---@field FlightRandomization  
---@field FollowDistance number The current follow distance.
---@field FollowGroupSet SET_GROUP 
---@field FollowName string 
---@field FollowScheduler SCHEDULER The instance of the SCHEDULER class.
---@field FollowUnit UNIT 
---@field OptionReactionOnThreat AI.Option.Air.val.REACTION_ON_THREAT Which REACTION_ON_THREAT is set to the FollowGroup.
---@field ReportTargets boolean If true, nearby targets are reported.
---@field dtFollow number Time step between position updates.
AI_FORMATION = {}

---Follow me.
---
------
---@param self AI_FORMATION 
---@param FollowGroup GROUP Follow group.
---@param ClientUnit UNIT Client Unit.
---@param CT1 Time Time
---@param CV1 Vec3 Vec3
---@param CT2 Time Time
---@param CV2 Vec3 Vec3
function AI_FORMATION:FollowMe(FollowGroup, ClientUnit, CT1, CV1, CT2, CV2) end

---FormationBox Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
function AI_FORMATION:FormationBox(XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationCenterWing Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationCenterWing(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLeftLine Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationLeftLine(XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationLeftWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLine Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationLine(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationRightLine Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationRightLine(XStart, YStart, ZStart, ZSpace) end

---FormationRightWing Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationRightWing(XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationStack Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
function AI_FORMATION:FormationStack(XStart, XSpace, YStart, YSpace) end

---FormationTrail Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
function AI_FORMATION:FormationTrail(XStart, XSpace, YStart) end

---FormationVic Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:FormationVic(XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---Gets your escorts to flight mode.
---
------
---@param self AI_FORMATION 
---@param FollowGroup GROUP FollowGroup.
---@return AI_FORMATION #
function AI_FORMATION:GetFlightMode(FollowGroup) end

---AI_FORMATION class constructor for an AI group
---
------
---@param self AI_FORMATION 
---@param FollowUnit UNIT The UNIT leading the FolllowGroupSet.
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param FollowName string Name of the escort.
---@param FollowBriefing string Briefing.
---@return AI_FORMATION #self
function AI_FORMATION:New(FollowUnit, FollowGroupSet, FollowName, FollowBriefing) end

---FormationBox Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
function AI_FORMATION:OnAfterFormationBox(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationCenterWing Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationCenterWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLeftLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationLeftLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationLeftWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationLine(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationRightLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationRightLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationRightWing Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationStack Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationStack(From, Event, To, XStart, XSpace, YStart, YSpace) end

---FormationTrail Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
function AI_FORMATION:OnAfterFormationTrail(From, Event, To, XStart, XSpace, YStart) end

---FormationVic Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:OnAfterFormationVic(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationBox Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
---@return boolean #
function AI_FORMATION:OnBeforeFormationBox(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationCenterWing Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationCenterWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLeftLine Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationLeftLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationLeftWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLine Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationLine(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationRightLine Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationRightLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationRightWing Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationStack Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationStack(From, Event, To, XStart, XSpace, YStart, YSpace) end

---FormationTrail Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationTrail(From, Event, To, XStart, XSpace, YStart) end

---FormationVic Handler OnBefore for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return boolean #
function AI_FORMATION:OnBeforeFormationVic(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---This sets your escorts to execute an attack.
---
------
---@param self AI_FORMATION 
---@param FollowGroup GROUP FollowGroup.
---@return AI_FORMATION #
function AI_FORMATION:SetFlightModeAttack(FollowGroup) end

---This sets your escorts to fly in a formation.
---
------
---@param self AI_FORMATION 
---@param FollowGroup GROUP FollowGroup.
---@return AI_FORMATION #
function AI_FORMATION:SetFlightModeFormation(FollowGroup) end

---This sets your escorts to fly a mission.
---
------
---@param self AI_FORMATION 
---@param FollowGroup GROUP FollowGroup.
---@return AI_FORMATION #
function AI_FORMATION:SetFlightModeMission(FollowGroup) end

---Use the method AI.AI_Formation#AI_FORMATION.SetFlightRandomization() to make the air units in your formation randomize their flight a bit while in formation.
---
------
---@param self AI_FORMATION 
---@param FlightRandomization number The formation flying errors that pilots can make while in formation. Is a range set in meters.
---@return AI_FORMATION #
function AI_FORMATION:SetFlightRandomization(FlightRandomization) end

---Set time interval between updates of the formation.
---
------
---@param self AI_FORMATION 
---@param dt number Time step in seconds between formation updates. Default is every 0.5 seconds.
---@return AI_FORMATION #
function AI_FORMATION:SetFollowTimeInterval(dt) end

---This function is for test, it will put on the frequency of the FollowScheduler a red smoke at the direction vector calculated for the escort to fly to.
---This allows to visualize where the escort is flying to.
---
------
---@param self AI_FORMATION 
---@param SmokeDirection boolean If true, then the direction vector will be smoked.
---@return AI_FORMATION #
function AI_FORMATION:TestSmokeDirectionVector(SmokeDirection) end

---FormationBox Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
function AI_FORMATION:__FormationBox(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels) end

---FormationCenterWing Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationCenterWing(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLeftLine Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationLeftLine(Delay, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationLeftWing(Delay, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLine Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationLine(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationRightLine Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationRightLine(Delay, XStart, YStart, ZStart, ZSpace) end

---FormationRightWing Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationRightWing(Delay, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationStack Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
function AI_FORMATION:__FormationStack(Delay, XStart, XSpace, YStart, YSpace) end

---FormationTrail Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
function AI_FORMATION:__FormationTrail(Delay, XStart, XSpace, YStart) end

---FormationVic Asynchronous Trigger for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param Delay number 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:__FormationVic(Delay, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationBox Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param ZLevels number The amount of levels on the Z-axis.
---@param FollowGroupSet NOTYPE 
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationBox(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, ZLevels, FollowGroupSet) end

---FormationCenterWing Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:onafterFormationCenterWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace) end

---FormationLeftLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationLeftLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end

---FormationLeftWing Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
function AI_FORMATION:onafterFormationLeftWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param Formation NOTYPE 
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationLine(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, Formation) end

---FormationRightLine Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationRightLine(FollowGroupSet, From, Event, To, XStart, YStart, ZStart, ZSpace) end


---
------
---@param self NOTYPE 
---@param FollowGroupSet NOTYPE 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param XStart NOTYPE 
---@param XSpace NOTYPE 
---@param YStart NOTYPE 
---@param ZStart NOTYPE 
---@param ZSpace NOTYPE 
function AI_FORMATION:onafterFormationRightWing(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, ZStart, ZSpace) end

---FormationStack Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationStack(FollowGroupSet, From, Event, To, XStart, XSpace, YStart, YSpace) end

---FormationTrail Handler OnAfter for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The group AI escorting the FollowUnit.
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationTrail(FollowGroupSet, From, Event, To, XStart, XSpace, YStart) end

---FormationVic Handle for AI_FORMATION
---
------
---@param self AI_FORMATION 
---@param From string 
---@param Event string 
---@param To string 
---@param XStart number The start position on the X-axis in meters for the first group.
---@param XSpace number The space between groups on the X-axis in meters for each sequent group.
---@param YStart number The start position on the Y-axis in meters for the first group.
---@param YSpace number The space between groups on the Y-axis in meters for each sequent group.
---@param ZStart number The start position on the Z-axis in meters for the first group.
---@param ZSpace number The space between groups on the Z-axis in meters for each sequent group.
---@param FollowGroupSet NOTYPE 
---@return AI_FORMATION #
function AI_FORMATION:onafterFormationVic(From, Event, To, XStart, XSpace, YStart, YSpace, ZStart, ZSpace, FollowGroupSet) end

---Stop function.
---Formation will not be updated any more.
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The following set of groups.
---@param From string From state.
---@param Event string Event.
---@param To string The to state.
function AI_FORMATION:onafterStop(FollowGroupSet, From, Event, To) end

---Follow event fuction.
---Check if coming from state "stopped". If so the transition is rejected.
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The following set of groups.
---@param From string From state.
---@param Event string Event.
---@param To string The to state.
function AI_FORMATION:onbeforeFollow(FollowGroupSet, From, Event, To) end

---Enter following state.
---
------
---@param self AI_FORMATION 
---@param FollowGroupSet SET_GROUP The following set of groups.
---@param From string From state.
---@param Event string Event.
---@param To string The to state.
function AI_FORMATION:onenterFollowing(FollowGroupSet, From, Event, To) end



