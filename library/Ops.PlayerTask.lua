---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_PlayerTask.jpg" width="100%">
---
---**Ops** - PlayerTask (mission) for Players.
---
---## Main Features:
---
---   * Simplifies defining and executing Player tasks
---   * FSM events when a mission is added, done, successful or failed, replanned
---   * Ready to use SRS and localization
---   * Mission locations can be smoked, flared, illuminated and marked on the map
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/PlayerTask).
---
---===
---
---### Author: **Applevangelist**
---### Special thanks to: Streakeagle
---
---===
---PLAYERTASK class.
---@class PLAYERTASK : FSM
---@field ClassName string Name of the class.
---@field Clients FIFO FiFo of Wrapper.Client#CLIENT planes executing this task
---@field FinalState string 
---@field FlareColor number 
---@field Freetext string 
---@field FreetextTTS string 
---@field NextTaskFailure table 
---@field NextTaskSuccess table 
---@field PlayerTaskNr number (Globally unique) Number of the task.
---@field PreviousCount number 
---@field Repeat boolean 
---@field RepeatNo number 
---@field SmokeColor number 
---@field Target TARGET The target for this Task
---@field TargetMarker MARKER 
---@field TaskController PLAYERTASKCONTROLLER 
---@field TaskSubType string 
---@field Type AUFTRAG.Type The type of the task
---@field TypeName string 
---@field private coalition number 
---@field private conditionFailure table 
---@field private conditionSuccess table 
---@field private lastsmoketime number 
---@field private lid string Class id string for output to DCS log file.
---@field private repeats number 
---@field private timestamp number 
---@field private verbose boolean Switch verbosity.
---@field private version string PLAYERTASK class version.
PLAYERTASK = {}

---[User] Add a client to this task
---
------
---@param self PLAYERTASK 
---@param Client CLIENT 
---@return PLAYERTASK #self
function PLAYERTASK:AddClient(Client) end

---[User] Add failure condition.
---
------
---@param self PLAYERTASK 
---@param ConditionFunction function If this function returns `true`, the task is cancelled.
---@param ... NOTYPE Condition function arguments if any.
---@return PLAYERTASK #self
function PLAYERTASK:AddConditionFailure(ConditionFunction, ...) end

---[User] Add success condition.
---
------
---@param self PLAYERTASK 
---@param ConditionFunction function If this function returns `true`, the mission is cancelled.
---@param ... NOTYPE Condition function arguments if any.
---@return PLAYERTASK #self
function PLAYERTASK:AddConditionSuccess(ConditionFunction, ...) end

---[USER] Add a free text description to this task.
---
------
---@param self PLAYERTASK 
---@param Text string 
---@return PLAYERTASK #self
function PLAYERTASK:AddFreetext(Text) end

---[USER] Add a free text description for TTS to this task.
---
------
---@param self PLAYERTASK 
---@param TextTTS string 
---@return PLAYERTASK #self
function PLAYERTASK:AddFreetextTTS(TextTTS) end

---[USER] Add a task to be assigned to same clients when task was a failure.
---
------
---@param self PLAYERTASK 
---@param Task PLAYERTASK 
---@return PLAYERTASK #self
function PLAYERTASK:AddNextTaskAfterFailure(Task) end

---[USER] Add a task to be assigned to same clients when task was a success.
---
------
---@param self PLAYERTASK 
---@param Task PLAYERTASK 
---@return PLAYERTASK #self
function PLAYERTASK:AddNextTaskAfterSuccess(Task) end

---[USER] Adds task success condition for AUFTRAG.Type.CAPTUREZONE for OpsZone or OpsZone set target object.
---- At least one of the task clients and one capture group need to be inside the zone in order for the capture to be successful.
---
------
---
---USAGE
---```
----- We can use either STATIC, SET_STATIC, SCENERY or SET_SCENERY as target objects.
---local opsZone = OPSZONE:New(zone, coalition.side.RED)
---
---...
---
----- We can use either OPSZONE or SET_OPSZONE.
---local mytask = PLAYERTASK:NewFromTarget(opsZone, true, 50, "Capture the zone")
---mytask:SetMenuName("Capture the ops zone")
---mytask:AddFreetext("Transport capture squad to the ops zone.")
---
----- We set CaptureSquadGroupNamePrefix the group name prefix as set in the ME or the spawn of the group that need to be present at the OpsZone like a capture squad,
----- and set the capturing Coalition in order to trigger a successful task.
---mytask:AddOpsZoneCaptureSuccessCondition("capture-squad", coalition.side.BLUE, false)
---
---playerTaskManager:AddPlayerTaskToQueue(mytask)
---```
------
---@param self PLAYERTASK 
---@param CaptureSquadGroupNamePrefix SET_BASE The prefix of the group name that needs to capture the zone.
---@param Coalition number The coalition that needs to capture the zone.
---@param CheckClientInZone boolean If true, a CLIENT assigned to this task also needs to be in the zone for the task to be successful.
---@return PLAYERTASK #self
function PLAYERTASK:AddOpsZoneCaptureSuccessCondition(CaptureSquadGroupNamePrefix, Coalition, CheckClientInZone) end

---[USER] Adds task success condition for AUFTRAG.Type.RECON when a client is at a certain LOS distance from the target.
---
------
---
---USAGE
---```
----- target can be any object that has a `GetCoordinate()` function like STATIC, GROUP, ZONE...
---local mytask = PLAYERTASK:New(AUFTRAG.Type.RECON, ZONE:New("WF Zone"), true, 50, "Deep Earth")
---mytask:SetMenuName("Recon weapon factory")
---mytask:AddFreetext("Locate and investigate underground weapons factory near Kovdor.")
---
----- We set the MinDistance (optional) in meters for the client to be in LOS from the target in order to trigger a successful task.
---mytask:AddReconSuccessCondition(10000) -- 10 km (default is 5 NM if not set)
---
---playerTaskManager:AddPlayerTaskToQueue(mytask)
---```
------
---@param self PLAYERTASK 
---@param MinDistance? number (Optional) Minimum distance in meters from client to target in LOS for success condition. (Default 5 NM)
---@return PLAYERTASK #self
function PLAYERTASK:AddReconSuccessCondition(MinDistance) end

---[USER] Adds task success condition for dead STATIC, SET_STATIC, SCENERY or SET_SCENERY target object.
---
------
---
---USAGE
---```
----- We can use either STATIC, SET_STATIC, SCENERY or SET_SCENERY as target objects.
---local mytask = PLAYERTASK:NewFromTarget(static, true, 50, "Destroy the target")
---mytask:SetMenuName("Destroy Power Plant")
---mytask:AddFreetext("Locate and destroy the power plant near Olenya.")
---mytask:AddStaticObjectSuccessCondition()
---
---playerTaskManager:AddPlayerTaskToQueue(mytask)
---```
------
---@param self NOTYPE 
---@return PLAYERTASK #self
function PLAYERTASK:AddStaticObjectSuccessCondition() end

---[USER] Adds a time limit for the task to be completed.
---
------
---
---USAGE
---```
---local mytask = PLAYERTASK:New(AUFTRAG.Type.RECON, ZONE:New("WF Zone"), true, 50, "Deep Earth")
---mytask:SetMenuName("Recon weapon factory")
---mytask:AddFreetext("Locate and investigate underground weapons factory near Kovdor.")
---mytask:AddReconSuccessCondition(10000) -- 10 km
---
----- We set the TimeLimit to 10 minutes (600 seconds) from the moment the task is started, once the time has passed and the task is not yet successful it will trigger a failure.
---mytask:AddTimeLimitFailureCondition(600)
---
---playerTaskManager:AddPlayerTaskToQueue(mytask)
---```
------
---@param self PLAYERTASK 
---@param TimeLimit number Time limit in seconds for the task to be completed. (Default 0 = no time limit)
---@return PLAYERTASK #self
function PLAYERTASK:AddTimeLimitFailureCondition(TimeLimit) end

---[User] Client has aborted task this task
---
------
---@param self PLAYERTASK 
---@param Client? CLIENT (optional)
---@return PLAYERTASK #self
function PLAYERTASK:ClientAbort(Client) end

---[User] Count clients
---
------
---@param self PLAYERTASK 
---@return number #clientcount
function PLAYERTASK:CountClients() end

---[User] Flare Target
---
------
---@param self PLAYERTASK 
---@param Color number  defaults to FLARECOLOR.Red
---@return PLAYERTASK #self
function PLAYERTASK:FlareTarget(Color) end

---[User] Get #CLIENT objects assigned as table
---
------
---@param self PLAYERTASK 
---@return table #clients
---@return number #clientcount
function PLAYERTASK:GetClientObjects() end

---[User] Get client names assigned as table of #strings
---
------
---@param self PLAYERTASK 
---@return table #clients
---@return number #clientcount
function PLAYERTASK:GetClients() end

---[User] Get the coalition side for this task
---
------
---@param self PLAYERTASK 
---@return number #Coalition Coaltion side, e.g. coalition.side.BLUE, or nil if not set
function PLAYERTASK:GetCoalition() end

---[USER] Get the free text description from this task.
---
------
---@param self PLAYERTASK 
---@return string #Text
function PLAYERTASK:GetFreetext() end

---[USER] Get the free text TTS description from this task.
---
------
---@param self PLAYERTASK 
---@return string #Text
function PLAYERTASK:GetFreetextTTS() end

---[USER] Get task sub type description from this task.
---
------
---@param self PLAYERTASK 
---@return string #Type or nil
function PLAYERTASK:GetSubType() end

---[User] Get the Ops.Target#TARGET object for this task
---
------
---@param self PLAYERTASK 
---@return TARGET #Target
function PLAYERTASK:GetTarget() end

---[User] Check if PLAYERTASK has clients assigned to it.
---
------
---@param self PLAYERTASK 
---@return boolean #hasclients
function PLAYERTASK:HasClients() end

---[USER] Query if a task has free text description.
---
------
---@param self PLAYERTASK 
---@return PLAYERTASK #self
function PLAYERTASK:HasFreetext() end

---[USER] Query if a task has free text TTS description.
---
------
---@param self PLAYERTASK 
---@return PLAYERTASK #self
function PLAYERTASK:HasFreetextTTS() end

---[User] Check if a player name is assigned to this task
---
------
---@param self PLAYERTASK 
---@param Name string 
---@return boolean #HasName
function PLAYERTASK:HasPlayerName(Name) end

---[User] Illuminate Target Area
---
------
---@param self PLAYERTASK 
---@param Power number Power of illumination bomb in Candela. Default 1000 cd.
---@param Height number Height above target used to release the bomb, default 150m.
---@return PLAYERTASK #self
function PLAYERTASK:IlluminateTarget(Power, Height) end

---[User] Check if task is done
---
------
---@param self PLAYERTASK 
---@return boolean #done
function PLAYERTASK:IsDone() end

---[User] Check if task is NOT done
---
------
---@param self PLAYERTASK 
---@return boolean #done
function PLAYERTASK:IsNotDone() end

---[User] Create target mark on F10 map
---
------
---@param self PLAYERTASK 
---@param Text? string (optional) Text to show on the marker
---@param Coalition? number (optional) Coalition this marker is for. Default = All.
---@param ReadOnly? boolean (optional) Make target marker read-only. Default = false.
---@return PLAYERTASK #self
function PLAYERTASK:MarkTargetOnF10Map(Text, Coalition, ReadOnly) end

---Constructor
---
------
---@param self PLAYERTASK 
---@param Type AUFTRAG.Type Type of this task
---@param Target TARGET Target for this task
---@param Repeat boolean Repeat this task if true (default = false)
---@param Times number Repeat on failure this many times if Repeat is true (default = 1)
---@param TTSType string TTS friendly task type name
---@return PLAYERTASK #self
function PLAYERTASK:New(Type, Target, Repeat, Times, TTSType) end

---Constructor that automatically determines the task type based on the target.
---
------
---@param self PLAYERTASK 
---@param Target TARGET Target for this task
---@param Repeat boolean Repeat this task if true (default = false)
---@param Times number Repeat on failure this many times if Repeat is true (default = 1)
---@param TTSType string TTS friendly task type name
---@return PLAYERTASK #self
function PLAYERTASK:NewFromTarget(Target, Repeat, Times, TTSType) end

---On After "Cancel" event.
---Task has been cancelled.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterCancel(From, Event, To) end

---On After "ClientAborted" event.
---A client has aborted the task.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterClientAborted(From, Event, To) end

---On After "ClientAdded" event.
---Client has been added to the task.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Client CLIENT 
function PLAYERTASK:OnAfterClientAdded(From, Event, To, Client) end

---On After "ClientRemoved" event.
---Client has been removed from the task.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterClientRemoved(From, Event, To) end

---On After "Done" event.
---Task is done.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterDone(From, Event, To) end

---On After "Executing" event.
---Task is executed by the 1st client.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterExecuting(From, Event, To) end

---On After "Failed" event.
---Task has been a failure.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterFailed(From, Event, To) end

---On After "Planned" event.
---Task has been planned.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterPilotPlanned(From, Event, To) end

---On After "Planned" event.
---Task has been planned.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterPlanned(From, Event, To) end

---On After "Requested" event.
---Task has been Requested.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterRequested(From, Event, To) end

---On After "Success" event.
---Task has been a success.
---
------
---@param self PLAYERTASK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function PLAYERTASK:OnAfterSuccess(From, Event, To) end

---[User] Remove a client from this task
---
------
---@param self PLAYERTASK 
---@param Client CLIENT 
---@param Name string Name of the client
---@return PLAYERTASK #self
function PLAYERTASK:RemoveClient(Client, Name) end

---[User] Set a coalition side for this task
---
------
---@param self PLAYERTASK 
---@param Coalition number Coaltion side to add, e.g. coalition.side.BLUE
---@return PLAYERTASK #self
function PLAYERTASK:SetCoalition(Coalition) end

---[USER] Add a short free text description for the menu entry of this task.
---
------
---@param self PLAYERTASK 
---@param Text string 
---@return PLAYERTASK #self
function PLAYERTASK:SetMenuName(Text) end

---[USER] Set a task sub type description to this task.
---
------
---@param self PLAYERTASK 
---@param Type string 
---@return PLAYERTASK #self
function PLAYERTASK:SetSubType(Type) end

---[User] Smoke Target
---
------
---@param self PLAYERTASK 
---@param Color number  defaults to SMOKECOLOR.Red
---@return PLAYERTASK #self
function PLAYERTASK:SmokeTarget(Color) end

---[Internal] Check OpsZone capture success condition.
---
------
---@param self PLAYERTASK 
---@param OpsZone OPSZONE The OpsZone target object.
---@param CaptureSquadGroupNamePrefix string The prefix of the group name that needs to capture the zone.
---@param Coalition number The coalition that needs to capture the zone.
---@param CheckClientInZone boolean Check if any of the clients are in zone.
---@return PLAYERTASK #self
function PLAYERTASK:_CheckCaptureOpsZoneSuccess(OpsZone, CaptureSquadGroupNamePrefix, Coalition, CheckClientInZone) end

---[Internal] Check if any of the given conditions is true.
---
------
---@param self PLAYERTASK 
---@param Conditions table Table of conditions.
---@return boolean #If true, at least one condition is true.
function PLAYERTASK:_EvalConditionsAny(Conditions) end

---[Internal] Determines AUFTRAG type based on the target characteristics.
---
------
---@param self PLAYERTASK 
---@param Target TARGET Target for this task
---@return string #AUFTRAG.Type 
function PLAYERTASK:_GetTaskTypeForTarget(Target) end

---[Internal] Add a PLAYERTASKCONTROLLER for this task
---
------
---@param self PLAYERTASK 
---@param Controller PLAYERTASKCONTROLLER 
---@return PLAYERTASK #self
function PLAYERTASK:_SetController(Controller) end

---[Internal] On after cancel call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterCancel(From, Event, To) end

---[Internal] On after client added call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@param Client CLIENT 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterClientAdded(From, Event, To, Client) end

---[Internal] On after done call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterDone(From, Event, To) end

---[Internal] On after executing call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterExecuting(From, Event, To) end

---[Internal] On after failed call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterFailed(From, Event, To) end

---[Internal] On after planned call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterPlanned(From, Event, To) end

---[Internal] On after progress call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@param TargetCount number 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterProgress(From, Event, To, TargetCount) end

---[Internal] On after requested call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterRequested(From, Event, To) end

---[Internal] On after status call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterStatus(From, Event, To) end

---[Internal] On after status call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterStop(From, Event, To) end

---[Internal] On after success call
---
------
---@param self PLAYERTASK 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASK #self
---@private
function PLAYERTASK:onafterSuccess(From, Event, To) end


---Generic task condition.
---@class PLAYERTASK.Condition 
---@field private arg table Optional arguments passed to the condition callback function.
---@field private func function Callback function to check for a condition. Should return a #boolean.
PLAYERTASK.Condition = {}


---
---*It is our attitude at the beginning of a difficult task which, more than anything else, which will affect its successful outcome.* (William James)
---
---===
---
---# PLAYERTASKCONTROLLER 
---
---   * Simplifies defining, executing and controlling of Player tasks
---   * FSM events when a mission is added, done, successful or failed, replanned
---   * Ready to use SRS and localization
---   * Mission locations can be smoked, flared and marked on the map
---
---## 1 Overview
---
---PLAYERTASKCONTROLLER is used to auto-create (optional) and control tasks for players.
---It can be set up as Air-to-Ground (A2G, main focus), Air-to-Ship (A2S) or Air-to-Air (A2A) controller.
---For the latter task type, also have a look at the Ops.AWACS#AWACS class which allows for more complex scenarios.
---One task at a time can be joined by the player from the F10 menu. A task can be joined by multiple players. Once joined, task information is available via the F10 menu, the task location
---can be marked on the map and for A2G/S targets, the target can be marked with smoke and flares.
---
---For the mission designer, tasks can be auto-created by means of detection with the integrated Ops.Intel#INTEL class setup, or be manually added to the task queue.
---
---## 2 Task Types
---
---Targets can be of types GROUP, SET\_GROUP, UNIT, SET\_UNIT, STATIC, SET\_STATIC, SET\_SCENERY, AIRBASE, ZONE or COORDINATE. The system will auto-create tasks for players from these targets.
---Tasks are created as Ops.PlayerTask#PLAYERTASK objects, which leverage Ops.Target#TARGET for the management of the actual target. The system creates these task types
---from the target objects:  
---
--- * A2A - AUFTRAG.Type.INTERCEPT
--- * A2S - AUFTRAG.Type.ANTISHIP
--- * A2G - AUFTRAG.Type.CAS, AUFTRAG.Type.BAI, AUFTRAG.Type.SEAD, AUFTRAG.Type.BOMBING, AUFTRAG.Type.PRECISIONBOMBING, AUFTRAG.Type.BOMBRUNWAY
--- * A2GS - A2S and A2G combined
---
---Task types are derived from Ops.Auftrag#AUFTRAG:   
--- 
--- * CAS - Close air support, created to attack ground units, where friendly ground units are around the location in a bespoke radius (default: 500m/1km diameter)
--- * BAI - Battlefield air interdiction, same as above, but no friendlies around
--- * SEAD - Same as CAS, but the enemy ground units field AAA, SAM or EWR units
--- * Bombing - Against static targets
--- * Precision Bombing - (if enabled) Laser-guided bombing, against **static targets** and **high-value (non-SAM) ground targets (MBTs etc)**
--- * Bomb Runway - Against Airbase runways (in effect, drop bombs over the runway)
--- * ZONE and COORDINATE - Targets will be scanned for GROUND or STATIC enemy units and tasks created from these
--- * Intercept - Any airborne targets, if the controller is of type "A2A"
--- * Anti-Ship - Any ship targets, if the controller is of type "A2S"
--- * CTLD - Combat transport and logistics deployment
--- * CSAR - Combat search and rescue
--- * RECON - Identify targets
--- * CAPTUREZONE - Capture an Ops.OpsZone#OPSZONE
--- * Any #string name can be passed as Auftrag type, but then you need to make sure to define a success condition, and possibly also add the task type to the standard scoring list: `PLAYERTASKCONTROLLER.Scores["yournamehere"]=100`
--- 
---## 3 Task repetition
--- 
---On failure, tasks will be replanned by default for a maximum of 5 times.
---
---## 3.1 Pre-configured success conditions
---
---Pre-configured success conditions for #PLAYERTASK tasks are available as follows:
---
---`mytask:AddStaticObjectSuccessCondition()` -- success if static object is at least 80% dead
---
---`mytask:AddOpsZoneCaptureSuccessCondition(CaptureSquadGroupNamePrefix,Coalition)`  -- success if a squad of the given (partial) name and coalition captures the OpsZone
---
---`mytask:AddReconSuccessCondition(MinDistance)`  -- success if object is in line-of-sight with the given min distance in NM
---
---`mytask:AddTimeLimitSuccessCondition(TimeLimit)` -- failure if the task is not completed within the time limit in seconds given
---
---## 3.2 Task chaining
---
---You can create chains of tasks, which will depend on success or failure of the previous task with the following commands:
---
---`mytask:AddNextTaskAfterSuccess(FollowUpTask)` and  
---
---`mytask:AddNextTaskAfterFailure(FollowUpTask)`
---
---## 4 SETTINGS, SRS and language options (localization)
---
---The system can optionally communicate to players via SRS. Also localization is available, both "en" and "de" has been build in already.
---Player and global Core.Settings#SETTINGS for coordinates will be observed.
--- 
---## 5 Setup  
---
---A basic setup is very simple:
---
---           -- Settings - we want players to have a settings menu, be on imperial measures, and get directions as BR
---           _SETTINGS:SetPlayerMenuOn()
---           _SETTINGS:SetImperial()
---           _SETTINGS:SetA2G_BR()
---
---           -- Set up the A2G task controller for the blue side named "82nd Airborne"
---           local taskmanager = PLAYERTASKCONTROLLER:New("82nd Airborne",coalition.side.BLUE,PLAYERTASKCONTROLLER.Type.A2G)
---           
---           -- set locale to English
---           taskmanager:SetLocale("en")
---           
---           -- Set up detection with grup names *containing* "Blue Recce", these will add targets to our controller via detection. Can be e.g. a drone.
---           taskmanager:SetupIntel("Blue Recce")
---           
---           -- Add a single Recce group name "Blue Humvee"
---           taskmanager:AddAgent(GROUP:FindByName("Blue Humvee"))
---           
---           -- Set the callsign for SRS and Menu name to be "Groundhog"
---           taskmanager:SetMenuName("Groundhog")
---           
---           -- Add accept- and reject-zones for detection
---           -- Accept zones are handy to limit e.g. the engagement to a certain zone. The example is a round, mission editor created zone named "AcceptZone"
---           taskmanager:AddAcceptZone(ZONE:New("AcceptZone"))
---           
---           -- Reject zones are handy to create borders. The example is a ZONE_POLYGON, created in the mission editor, late activated with waypoints, 
---           -- named "AcceptZone#ZONE_POLYGON"
---           taskmanager:AddRejectZone(ZONE:FindByName("RejectZone"))
---           
---           -- Set up using SRS for messaging
---           local hereSRSPath = "C:\\Program Files\\DCS-SimpleRadio-Standalone"
---           local hereSRSPort = 5002
---           -- local hereSRSGoogle = "C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourkey.json"
---           taskmanager:SetSRS({130,255},{radio.modulation.AM,radio.modulation.AM},hereSRSPath,"female","en-GB",hereSRSPort,"Microsoft Hazel Desktop",0.7,hereSRSGoogle)
---           
---           -- Controller will announce itself under these broadcast frequencies, handy to use cold-start frequencies here of your aircraft
---           taskmanager:SetSRSBroadcast({127.5,305},{radio.modulation.AM,radio.modulation.AM})
---           
---           -- Example: Manually add an AIRBASE as a target
---           taskmanager:AddTarget(AIRBASE:FindByName(AIRBASE.Caucasus.Senaki_Kolkhi))
---           
---           -- Example: Manually add a COORDINATE as a target
---           taskmanager:AddTarget(GROUP:FindByName("Scout Coordinate"):GetCoordinate())
---           
---           -- Set a whitelist for tasks, e.g. skip SEAD tasks
---           taskmanager:SetTaskWhiteList({AUFTRAG.Type.CAS, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY})
---           
---           -- Set target radius
---           taskmanager:SetTargetRadius(1000)
---
---## 6 Localization
---
---Localization for English and German texts are build-in. Default setting is English. Change with #PLAYERTASKCONTROLLER.SetLocale()
---
---### 6.1 Adding Localization
---
---A list of fields to be defined follows below. **Note** that in some cases `string.format()` is used to format texts for screen and SRS. 
---Hence, the `%d`, `%s` and `%f` special characters need to appear in the exact same amount and order of appearance in the localized text or it will create errors.
---To add a localization, the following texts need to be translated and set in your mission script **before** #PLAYERTASKCONTROLLER.New():   
---
---           PLAYERTASKCONTROLLER.Messages = {
---             EN = {
---               TASKABORT = "Task aborted!",
---               NOACTIVETASK = "No active task!",
---               FREQUENCIES = "frequencies ",
---               FREQUENCY = "frequency %.3f",
---               BROADCAST = "%s, %s, switch to %s for task assignment!",
---               CASTTS = "close air support",
---               SEADTTS = "suppress air defense",
---               BOMBTTS = "bombing",
---               PRECBOMBTTS = "precision bombing",
---               BAITTS = "battle field air interdiction",
---               ANTISHIPTTS = "anti-ship",
---               INTERCEPTTS = "intercept",
---               BOMBRUNWAYTTS = "bomb runway",
---               HAVEACTIVETASK = "You already have one active task! Complete it first!",
---               PILOTJOINEDTASK = "%s, %s. You have been assigned %s task %03d",
---               TASKNAME = "%s Task ID %03d",
---               TASKNAMETTS = "%s Task ID %03d",
---               THREATHIGH = "high",
---               THREATMEDIUM = "medium",
---               THREATLOW = "low",
---               THREATTEXT = "%s\nThreat: %s\nTargets left: %d\nCoord: %s",
---               THREATTEXTTTS = "%s, %s. Target information for %s. Threat level %s. Targets left %d. Target location %s.",
---               MARKTASK = "%s, %s, copy, task %03d location marked on map!",
---               SMOKETASK = "%s, %s, copy, task %03d location smoked!",
---               FLARETASK = "%s, %s, copy, task %03d location illuminated!",
---               ABORTTASK = "All stations, %s, %s has aborted %s task %03d!",
---               UNKNOWN = "Unknown",
---               MENUTASKING = " Tasking ",
---               MENUACTIVE = "Active Task",
---               MENUINFO = "Info",
---               MENUMARK = "Mark on map",
---               MENUSMOKE = "Smoke",
---               MENUFLARE = "Flare",
---               MENUILLU = "Illuminate",
---               MENUABORT = "Abort",
---               MENUJOIN = "Join Task",
---               MENUTASKINFO = Task Info",
---               MENUTASKNO = "TaskNo",
---               MENUNOTASKS = "Currently no tasks available.",
---               TASKCANCELLED = "Task #%03d %s is cancelled!",
---               TASKCANCELLEDTTS = "%s, task %03d %s is cancelled!",
---               TASKSUCCESS = "Task #%03d %s completed successfully!",
---               TASKSUCCESSTTS = "%s, task %03d %s completed successfully!",
---               TASKFAILED = "Task #%03d %s was a failure!",
---               TASKFAILEDTTS = "%s, task %03d %s was a failure!",
---               TASKFAILEDREPLAN = "Task #%03d %s was a failure! Replanning!",
---               TASKFAILEDREPLANTTS = "%s, task %03d %s was a failure! Replanning!",
---               TASKADDED = "%s has a new task %s available!",
---               PILOTS = "\nPilot(s): ",
---               PILOTSTTS = ". Pilot(s): ",
---               YES = "Yes",
---               NO = "No",
---               NONE = "None",
---               POINTEROVERTARGET = "%s, %s, pointer in reach for task %03d, lasing!",
---               POINTERTARGETREPORT = "\nPointer in reach: %s\nLasing: %s",
---               RECCETARGETREPORT = "\nRecce %s in reach: %s\nLasing: %s",
---               POINTERTARGETLASINGTTS = ". Pointer in reach and lasing.",
---               TARGET = "Target",
---               FLASHON = "%s - Flashing directions is now ON!",
---               FLASHOFF = "%s - Flashing directions is now OFF!",
---               FLASHMENU = "Flash Directions Switch",
---               BRIEFING = "Briefing",
---               TARGETLOCATION ="Target location",
---               COORDINATE = "Coordinate",
---               INFANTRY = "Infantry",
---               TECHNICAL = "Technical",
---               ARTILLERY = "Artillery",
---               TANKS = "Tanks",
---               AIRDEFENSE = "Airdefense",
---               SAM = "SAM",
---               GROUP = "Group",
---               ELEVATION = "\nTarget Elevation: %s %s",
---               METER = "meter",
---               FEET = "feet",
---             },
---
---e.g.
---
---           taskmanager.Messages = {
---             FR = {
---               TASKABORT = "Tâche abandonnée!",
---               NOACTIVETASK = "Aucune tâche active!",
---               FREQUENCIES = "fréquences ",
---               FREQUENCY = "fréquence %.3f",
---               BROADCAST = "%s, %s, passer au %s pour l'attribution des tâches!",
---               ...
---               TASKADDED = "%s a créé une nouvelle tâche %s",
---               PILOTS = "\nPilote(s): ",
---               PILOTSTTS = ". Pilote(s): ",
---             },
--- 
---and then `taskmanager:SetLocale("fr")` **after** #PLAYERTASKCONTROLLER.New() in your script.
---
---If you just want to replace a **single text block** in the table, you can do this like so:
---
---           mycontroller.Messages.EN.NOACTIVETASK = "Choose a task first!"   
---           mycontroller.Messages.FR.YES = "Oui" 
---
---## 7 Events
---
--- The class comes with a number of FSM-based events that missions designers can use to shape their mission.
--- These are:
--- 
---### 7.1 TaskAdded. 
---     
---The event is triggered when a new task is added to the controller. Use #PLAYERTASKCONTROLLER.OnAfterTaskAdded() to link into this event:
---     
---             function taskmanager:OnAfterTaskAdded(From, Event, To, Task)
---               ... your code here ...
---             end
---
---### 7.2 TaskDone. 
---     
---The event is triggered when a task has ended. Use #PLAYERTASKCONTROLLER.OnAfterTaskDone() to link into this event:
---     
---             function taskmanager:OnAfterTaskDone(From, Event, To, Task)
---               ... your code here ...
---             end
---         
---### 7.3 TaskCancelled. 
---     
---The event is triggered when a task was cancelled manually. Use #PLAYERTASKCONTROLLER.OnAfterTaskCancelled()` to link into this event:
---     
---             function taskmanager:OnAfterTaskCancelled(From, Event, To, Task)
---               ... your code here ...
---             end
---         
---### 7.4 TaskSuccess. 
---     
---The event is triggered when a task completed successfully. Use #PLAYERTASKCONTROLLER.OnAfterTaskSuccess() to link into this event:
---     
---             function taskmanager:OnAfterTaskSuccess(From, Event, To, Task)
---               ... your code here ...
---             end
---         
---### 7.5 TaskFailed. 
---     
---The event is triggered when a task failed, no repeats. Use #PLAYERTASKCONTROLLER.OnAfterTaskFailed() to link into this event:
---     
---             function taskmanager:OnAfterTaskFailed(From, Event, To, Task)
---               ... your code here ...
---             end
---         
---### 7.6 TaskRepeatOnFailed. 
---     
---The event is triggered when a task failed and is re-planned for execution. Use #PLAYERTASKCONTROLLER.OnAfterRepeatOnFailed() to link into this event:
---     
---             function taskmanager:OnAfterRepeatOnFailed(From, Event, To, Task)
---               ... your code here ...
---             end
---
---## 8 Using F10 map markers to create new targets
---
---You can use F10 map markers to create new target points for player tasks.  
---Enable this option with e.g., setting the tag to be used to "TARGET":
---
---           taskmanager:EnableMarkerOps("TARGET")
---           
---Set a marker on the map and add the following text to create targets from it: "TARGET". This is effectively the same as adding a COORDINATE object as target.
---The marker can be deleted any time.
---        
---## 9 Discussion
---
---If you have questions or suggestions, please visit the [MOOSE Discord](https://discord.gg/AeYAkHP) #ops-playertask channel.  
---
---PLAYERTASKCONTROLLER class.
---@class PLAYERTASKCONTROLLER : FSM
---@field AccessKey NOTYPE 
---@field ActiveClientSet SET_CLIENT 
---@field ActiveInfoMenu CLIENTMENU 
---@field ActiveTaskMenuTemplate CLIENTMENUMANAGER 
---@field ActiveTopMenu CLIENTMENU 
---@field AllowFlash boolean Flashing directions for players allowed
---@field BCFrequency NOTYPE 
---@field BCModulation NOTYPE 
---@field BlackList table 
---@field CallsignCustomFunc NOTYPE 
---@field CallsignTranslations table 
---@field ClassName string Name of the class.
---@field ClientFilter string 
---@field ClientSet SET_CLIENT 
---@field ClusterRadius number 
---@field Coalition number 
---@field CoalitionName NOTYPE 
---@field FlashPlayer table List of player who switched Flashing Direction Info on
---@field InfoHasCoordinate boolean 
---@field InfoHasLLDDM boolean 
---@field InformationMenu boolean Show Radio Info Menu
---@field Intel NOTYPE 
---@field IsClientSet boolean 
---@field JoinInfoMenu CLIENTMENU 
---@field JoinMenu CLIENTMENU 
---@field JoinTaskMenuTemplate CLIENTMENUMANAGER 
---@field JoinTopMenu CLIENTMENU 
---@field Keepnumber boolean 
---@field LasingDrone FLIGHTGROUP 
---@field LasingDroneSet NOTYPE 
---@field MarkerOps MARKEROPS_BASE 
---@field MarkerReadOnly boolean 
---@field MenuName string 
---@field MenuNoTask CLIENTMENU 
---@field MenuParent MENU_MISSION 
---@field Messages table 
---@field Name string 
---@field NoScreenOutput boolean 
---@field PathToGoogleKey NOTYPE 
---@field PlayerFlashMenu table 
---@field PlayerInfoMenu table 
---@field PlayerJoinMenu table 
---@field PlayerMenu table 
---@field PlayerMenuTag table 
---@field PlayerRecce PLAYERRECCE 
---@field PrecisionTasks FIFO 
---@field RecceSet NOTYPE 
---@field SRS NOTYPE 
---@field SRSQueue NOTYPE 
---@field Scores Scores 
---@field Scoring SCORING 
---@field SeadAttributes NOTYPE 
---@field ShortCallsign boolean 
---@field ShowMagnetic boolean Also show magnetic angles
---@field TargetQueue FIFO 
---@field TargetRadius number 
---@field TaskInfoDuration number How long to show the briefing info on the screen
---@field TaskQueue FIFO 
---@field TasksPerPlayer FIFO 
---@field TransmitOnlyWithPlayers boolean 
---@field Type string 
---@field UseBlackList boolean 
---@field UseGroupNames boolean 
---@field UseSRS boolean 
---@field UseTypeNames boolean 
---@field UseWhiteList boolean 
---@field WhiteList table 
---@field private activehasinfomenu boolean 
---@field private buddylasing boolean 
---@field private customcallsigns table 
---@field private gettext TEXTANDSOUND 
---@field private holdmenutime number 
---@field private illumenu boolean 
---@field private lasttaskcount NOTYPE 
---@field private lid string Class id string for output to DCS log file.
---@field private locale string 
---@field private menuitemlimit number 
---@field private noflaresmokemenu boolean 
---@field private precisionbombing boolean 
---@field private repeatonfailed boolean 
---@field private taskinfomenu boolean 
---@field private usecluster boolean 
---@field private verbose boolean Switch verbosity.
---@field private version string PLAYERTASK class version.
PLAYERTASKCONTROLLER = {}

---[User] Add an accept zone to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param AcceptZone ZONE Add a zone to the accept zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddAcceptZone(AcceptZone) end

---[User] Add an accept SET_ZONE to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param AcceptZoneSet SET_ZONE Add a SET_ZONE to the accept zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddAcceptZoneSet(AcceptZoneSet) end

---[User] Add agent group to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Recce GROUP Group of agents. Can also be an @{Ops.OpsGroup#OPSGROUP} object.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddAgent(Recce) end

---[User] Add agent SET_GROUP to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param RecceSet SET_GROUP SET_GROUP of agents.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddAgentSet(RecceSet) end

---[User] Add a conflict zone to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param ConflictZone ZONE Add a zone to the conflict zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddConflictZone(ConflictZone) end

---[User] Add a conflict SET_ZONE to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param ConflictZoneSet SET_ZONE Add a zone to the conflict zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddConflictZoneSet(ConflictZoneSet) end

---[User] Add a PLAYERTASK object to the list of (open) tasks
---
------
---
---USAGE
---```
---Example to create a PLAYERTASK of type CTLD and give Players 10 minutes to complete:
---
---       local newtask = PLAYERTASK:New(AUFTRAG.Type.CTLD,ZONE:Find("Unloading"),false,0,"Combat Transport")
---       newtask.Time0 = timer.getAbsTime()    -- inject a timestamp for T0
---       newtask:AddFreetext("Transport crates to the drop zone and build a vehicle in the next 10 minutes!")
---       
---       -- add a condition for failure - fail after 10 minutes
---       newtask:AddConditionFailure(
---         function()
---           local Time = timer.getAbsTime()
---           if Time - newtask.Time0 > 600 then
---             return true
---           end 
---           return false
---         end
---         )  
---         
---       taskmanager:AddPlayerTaskToQueue(PlayerTask)
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param PlayerTask PLAYERTASK 
---@param Silent boolean If true, make no "has new task" announcement
---@param TaskFilter boolean If true, apply the white/black-list task filters here, also
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddPlayerTaskToQueue(PlayerTask, Silent, TaskFilter) end

---[User] Convenience function - add done or ground allowing precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---
------
---@param self PLAYERTASKCONTROLLER 
---@param FlightGroup FLIGHTGROUP The FlightGroup (e.g. drone) to be used for lasing (one unit in one group only). Can optionally be handed as Ops.ArmyGroup#ARMYGROUP - **Note** might not find an LOS spot or get lost on the way. Cannot island-hop.
---@param LaserCode number The lasercode to be used. Defaults to 1688.
---@param HoldingPoint? COORDINATE (Optional) Point where the drone should initially circle. If not set, defaults to BullsEye of the coalition.
---@param Alt? number (Optional) Altitude in feet. Only applies if using a FLIGHTGROUP object! Defaults to 10000.
---@param Speed? number (Optional) Speed in knots. Only applies if using a FLIGHTGROUP object! Defaults to 120.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddPrecisionBombingOpsGroup(FlightGroup, LaserCode, HoldingPoint, Alt, Speed) end

---[User] Add a reject zone to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param RejectZone ZONE Add a zone to the reject zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddRejectZone(RejectZone) end

---[User] Add a reject SET_ZONE to INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param RejectZoneSet SET_ZONE Add a zone to the reject zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddRejectZoneSet(RejectZoneSet) end

---[User] Add a target object to the target queue
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Target POSITIONABLE The target GROUP, SET\_GROUP, UNIT, SET\_UNIT, STATIC, SET\_STATIC, AIRBASE, ZONE or COORDINATE.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:AddTarget(Target) end

---[User] Manually cancel a specific task
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Task PLAYERTASK The task to be cancelled
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:CancelTask(Task) end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc) with player units lasing.
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:DisableBuddyLasing() end

---[User] Disable precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---
------
---@param self PLAYERTASKCONTROLLER 
---@param FlightGroup NOTYPE 
---@param LaserCode NOTYPE 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:DisablePrecisionBombing(FlightGroup, LaserCode) end

---[User] Remove the SCORING object from this taskcontroller
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:DisableScoring() end

---[User] Disable extra menu to show task detail information before joining
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:DisableTaskInfoMenu() end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc) with player units lasing.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Recce? PLAYERRECCE (Optional) The PLAYERRECCE object governing the lasing players.
---@return PLAYERTASKCONTROLLER #self 
function PLAYERTASKCONTROLLER:EnableBuddyLasing(Recce) end

---[User] Allow addition of targets with user F10 map markers.
---
------
---
---USAGE
---```
---Enable the function like so:
---         mycontroller:EnableMarkerOps("TASK")
---Then as a player in a client slot, you can add a map marker on the F10 map. Next edit the text
---in the marker to make it identifiable, e.g
---
---TASK Name=Tanks Sochi, Text=Destroy tank group located near Sochi!
---
---Where **TASK** is the tag that tells the controller this mark is a target location (must).
---**Name=** ended by a comma **,** tells the controller the supposed menu entry name (optional). No extra spaces! End with a comma!
---**Text=** tells the controller the supposed free text task description (optional, only taken if **Name=** is present first). No extra spaces!
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param Tag? string (Optional) The tagname to use to identify commands, defaults to "TASK"
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:EnableMarkerOps(Tag) end

---[User] Allow precision laser-guided bombing on statics and "high-value" ground units (MBT etc)
---
------
---
---USAGE
---```
----- Set up precision bombing, FlightGroup as lasing unit
---       local FlightGroup = FLIGHTGROUP:New("LasingUnit")
---       FlightGroup:Activate()
---       taskmanager:EnablePrecisionBombing(FlightGroup,1688)
---
----- Alternatively, set up precision bombing, ArmyGroup as lasing unit
---       local ArmyGroup = ARMYGROUP:New("LasingUnit")
---       ArmyGroup:SetDefaultROE(ENUMS.ROE.WeaponHold)
---       ArmyGroup:SetDefaultInvisible(true)
---       ArmyGroup:Activate()
---       taskmanager:EnablePrecisionBombing(ArmyGroup,1688)
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param FlightGroup FLIGHTGROUP The FlightGroup (e.g. drone) to be used for lasing (one unit in one group only). Can optionally be handed as Ops.ArmyGroup#ARMYGROUP - **Note** might not find an LOS spot or get lost on the way. Cannot island-hop.
---@param LaserCode number The lasercode to be used. Defaults to 1688.
---@param HoldingPoint? COORDINATE (Optional) Point where the drone should initially circle. If not set, defaults to BullsEye of the coalition.
---@param Alt? number (Optional) Altitude in feet. Only applies if using a FLIGHTGROUP object! Defaults to 10000.
---@param Speed? number (Optional) Speed in knots. Only applies if using a FLIGHTGROUP object! Defaults to 120.
---@param MaxTravelDist? number (Optional) Max distance to travel to traget. Only applies if using a FLIGHTGROUP object! Defaults to 100 NM.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:EnablePrecisionBombing(FlightGroup, LaserCode, HoldingPoint, Alt, Speed, MaxTravelDist) end

---[User] Set or create a SCORING object for this taskcontroller
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Scoring? SCORING (optional) the Scoring object
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:EnableScoring(Scoring) end

---[User] Enable extra menu to show task detail information before joining
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:EnableTaskInfoMenu() end

---Create and run a new TASKCONTROLLER instance.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Name string Name of this controller
---@param Coalition number of this controller, e.g. coalition.side.BLUE
---@param Type string Type of the tasks controlled, defaults to PLAYERTASKCONTROLLER.Type.A2G
---@param ClientFilter? string (optional) Additional prefix filter for the SET_CLIENT. Can be handed as @{Core.Set#SET_CLIENT} also.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:New(Name, Coalition, Type, ClientFilter) end

---On After "PlayerAbortedTask" event.
---Player aborted a task.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP The player group object
---@param Client CLIENT The player client object
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterPlayerAbortedTask(From, Event, To, Group, Client, Task) end

---On After "PlayerJoinedTask" event.
---Player joined a task.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Group GROUP The player group object
---@param Client CLIENT The player client object
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterPlayerJoinedTask(From, Event, To, Group, Client, Task) end

---On After "TaskAdded" event.
---Task has been added.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskAdded(From, Event, To, Task) end

---On After "TaskCancelled" event.
---Task has been cancelled.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskCancelled(From, Event, To, Task) end

---On After "TaskDone" event.
---Task is done.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskDone(From, Event, To, Task) end

---On After "TaskFailed" event.
---Task has failed.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskFailed(From, Event, To, Task) end

---On After "TaskProgress" event.
---Task target count has been reduced.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK The current Task.
---@param TargetCount number Targets left over
function PLAYERTASKCONTROLLER:OnAfterTaskProgress(From, Event, To, Task, TargetCount) end

---On After "TaskRepeatOnFailed" event.
---Task has failed and will be repeated.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskRepeatOnFailed(From, Event, To, Task) end

---On After "TaskSuccess" event.
---Task has been a success.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskSuccess(From, Event, To, Task) end

---On After "TaskTargetFlared" event.
---Task flared.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskTargetFlared(From, Event, To, Task) end

---On After "TaskTargetIlluminated" event.
---Task illuminated.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskTargetIlluminated(From, Event, To, Task) end

---On After "TaskTargetSmoked" event.
---Task smoked.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Task PLAYERTASK 
function PLAYERTASKCONTROLLER:OnAfterTaskTargetSmoked(From, Event, To, Task) end

---[User] Remove an accept zone from INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param AcceptZone ZONE Remove this zone from the accept zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:RemoveAcceptZone(AcceptZone) end

---[User] Remove a conflict zone from INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param ConflictZone ZONE Remove this zone from the conflict zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:RemoveConflictZone(ConflictZone) end

---[User] Remove a reject zone from INTEL detection.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param RejectZone ZONE Remove this zone from the reject zone set.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:RemoveRejectZone(RejectZone) end

---[User] Set flash directions option for player (player based info)
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean Set to `true` to switch on and `false` to switch off. Default is OFF.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetAllowFlashDirection(OnOff) end

---[User] Set how long the briefing is shown on screen.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Seconds number Duration in seconds. Defaults to 30 seconds.
---@return PLAYERTASKCONTROLLER #self 
function PLAYERTASKCONTROLLER:SetBriefingDuration(Seconds) end

---[User] Set callsign options for TTS output.
---See Wrapper.Group#GROUP.GetCustomCallSign() on how to set customized callsigns.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param ShortCallsign boolean If true, only call out the major flight number
---@param Keepnumber boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers.
---@param CallsignTranslations? table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@param CallsignCustomFunc? func (Optional) For player names only(!). If given, this function will return the callsign. Needs to take the groupname and the playername as first two arguments.
---@param ...? arg (Optional) Comma separated arguments to add to the custom function call after groupname and playername.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations, CallsignCustomFunc, ...) end

---[User] Set the cluster radius if you want to use target clusters rather than single group detection.
---Note that for a controller type A2A target clustering is on by default. Also remember that the diameter of the resulting zone is double the radius.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Radius number Target cluster radius in kilometers. Default is 0.5km.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetClusterRadius(Radius) end

---[User] Do not show menu entries to illuminate targets.
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetDisableIlluminateTask() end

---[User] Do not show menu entries to smoke or flare targets
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetDisableSmokeFlareTask() end

---[User] Do not show target menu entries of type names for GROUND targets
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetDisableUseTypeNames() end

---[User] Show menu entries to illuminate targets.
---Needs smoke/flare enabled.
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetEnableIlluminateTask() end

---[User] Show menu entries to smoke or flare targets (on by default!)
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetEnableSmokeFlareTask() end

---[User] Show target menu entries of type names for GROUND targets (off by default!), e.g.
---"Tank Group..."
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetEnableUseTypeNames() end

---[User] Show info text on screen with a coordinate info in any case (OFF by default)
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean Switch on = true or off = false
---@param LLDDM boolean Show LLDDM = true or LLDMS = false
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetInfoShowsCoordinate(OnOff, LLDDM) end

---[User] Set locale for localization.
---Defaults to "en"
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Locale string The locale to use
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetLocale(Locale) end

---[User] Allow F10 markers to be deleted by pilots.
---Note: Marker will auto-delete when the undelying task is done.
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetMarkerDeleteable() end

---[User] Forbid F10 markers to be deleted by pilots.
---Note: Marker will auto-delete when the undelying task is done.
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetMarkerReadOnly() end

---[User] Set the top menu name to a custom string.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Name string The name to use as the top menu designation.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetMenuName(Name) end

---[User] Set menu build fine-tuning options
---
------
---@param self PLAYERTASKCONTROLLER 
---@param InfoMenu boolean If `true` this option will allow to show the Task Info-Menu also when a player has an active task.  Since the menu isn't refreshed if a player holds an active task, the info in there might be stale.
---@param ItemLimit number Number of items per task type to show, default 5. 
---@param HoldTime number Minimum number of seconds between menu refreshes (called every 30 secs) if a player has **no active task**.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetMenuOptions(InfoMenu, ItemLimit, HoldTime) end

---[User] Set the top menu to be a sub-menu of another MENU entry.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Menu MENU_MISSION 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetParentMenu(Menu) end

---[User] Change the list of attributes, which are considered on GROUP or SET\_GROUP level of a target to create SEAD player tasks.
---
------
---
---USAGE
---```
---Default attribute types are: GROUP.Attribute.GROUND_SAM, GROUP.Attribute.GROUND_AAA, and GROUP.Attribute.GROUND_EWR.
---If you want to e.g. exclude AAA, so target groups with this attribute are assigned CAS or BAI tasks, and not SEAD, use this function as follows:
---
---           `mycontroller:SetSEADAttributes({GROUP.Attribute.GROUND_SAM, GROUP.Attribute.GROUND_EWR})`
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param Attributes table Table of attribute types considered to lead to a SEAD type player task.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetSEADAttributes(Attributes) end

---[User] Set SRS TTS details - see Sound.SRS for details.`SetSRS()` will try to use as many attributes configured with Sound.SRS#MSRS.LoadConfigFile() as possible.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Frequency number Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 271 or {127,251}. There needs to be exactly the same number of modulations!
---@param Modulation number Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}. There needs to be exactly the same number of frequencies!
---@param PathToSRS string Defaults to "C:\\Program Files\\DCS-SimpleRadio-Standalone"
---@param Gender? string (Optional) Defaults to "male"
---@param Culture? string (Optional) Defaults to "en-US"
---@param Port? number (Optional) Defaults to 5002
---@param Voice? string (Optional) Use a specifc voice with the @{Sound.SRS#SetVoice} function, e.g, `:SetVoice("Microsoft Hedda Desktop")`. Note that this must be installed on your windows system. Can also be Google voice types, if you are using Google TTS.
---@param Volume? number (Optional) Volume - between 0.0 (silent) and 1.0 (loudest)
---@param PathToGoogleKey? string (Optional) Path to your google key if you want to use google TTS; if you use a config file for MSRS, hand in nil here.
---@param AccessKey? string (Optional) Your Google API access key. This is necessary if DCS-gRPC is used as backend; if you use a config file for MSRS, hand in nil here.
---@param Coordinate COORDINATE Coordinate from which the controller radio is sending
---@param Backend? string (Optional) MSRS Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC; if you use a config file for MSRS, hand in nil here.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetSRS(Frequency, Modulation, PathToSRS, Gender, Culture, Port, Voice, Volume, PathToGoogleKey, AccessKey, Coordinate, Backend) end

---[User] Set SRS Broadcast - for the announcement to joining players which SRS frequency, modulation to use.
---Use in case you want to set this differently to the standard SRS.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Frequency number Frequency to be used. Can also be given as a table of multiple frequencies, e.g. 271 or {127,251}.  There needs to be exactly the same number of modulations!
---@param Modulation number Modulation to be used. Can also be given as a table of multiple modulations, e.g. radio.modulation.AM or {radio.modulation.FM,radio.modulation.AM}.  There needs to be exactly the same number of frequencies!
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetSRSBroadcast(Frequency, Modulation) end

---[User] Set to show a menu entry to retrieve the radio frequencies used.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean Set to `true` to switch on and `false` to switch off. Default is OFF.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetShowRadioInfoMenu(OnOff) end

---[User] Set target radius.
---Determines the zone radius to distinguish CAS from BAI tasks and to find enemies if the TARGET object is a COORDINATE.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Radius number Radius to use in meters. Defaults to 500 meters.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetTargetRadius(Radius) end

---[User] Set up a (negative) blacklist of forbidden task types.
---These types will **not** be generated.
---
------
---
---USAGE
---```
---Currently, the following task types will be generated, if detection has been set up:
---A2A - AUFTRAG.Type.INTERCEPT
---A2S - AUFTRAG.Type.ANTISHIP
---A2G - AUFTRAG.Type.CAS, AUFTRAG.Type.BAI, AUFTRAG.Type.SEAD, AUFTRAG.Type.BOMBING, AUFTRAG.Type.PRECISIONBOMBING, AUFTRAG.Type.BOMBRUNWAY
---A2GS - A2G + A2S
---If you don't want SEAD tasks generated, use as follows where "mycontroller" is your PLAYERTASKCONTROLLER object:
---
---           `mycontroller:SetTaskBlackList({AUFTRAG.Type.SEAD})`
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param BlackList table Table of task types that cannot be generated. Use to restrict available types.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetTaskBlackList(BlackList) end

---[User] Set repetition options for tasks.
---
------
---
---USAGE
---```
---`taskmanager:SetTaskRepetition(true, 5)`
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean Set to `true` to switch on and `false` to switch off (defaults to true)
---@param Repeats number Number of repeats (defaults to 5)
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetTaskRepetition(OnOff, Repeats) end

---[User] Set up a (positive) whitelist of allowed task types.
---Only these types will be generated.
---
------
---
---USAGE
---```
---Currently, the following task types will be generated, if detection has been set up:
---A2A - AUFTRAG.Type.INTERCEPT
---A2S - AUFTRAG.Type.ANTISHIP
---A2G - AUFTRAG.Type.CAS, AUFTRAG.Type.BAI, AUFTRAG.Type.SEAD, AUFTRAG.Type.BOMBING, AUFTRAG.Type.PRECISIONBOMBING, AUFTRAG.Type.BOMBRUNWAY
---A2GS - A2G + A2S
---If you don't want SEAD tasks generated, use as follows where "mycontroller" is your PLAYERTASKCONTROLLER object:
---
---           `mycontroller:SetTaskWhiteList({AUFTRAG.Type.CAS, AUFTRAG.Type.BAI, AUFTRAG.Type.BOMBING, AUFTRAG.Type.BOMBRUNWAY})`
---```
------
---@param self PLAYERTASKCONTROLLER 
---@param WhiteList table Table of task types that can be generated. Use to restrict available types.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetTaskWhiteList(WhiteList) end

---[User] For SRS - Switch to only transmit if there are players on the server.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Switch boolean If true, only send SRS if there are alive Players.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetTransmitOnlyWithPlayers(Switch) end

---[User] Set up INTEL detection
---
------
---@param self PLAYERTASKCONTROLLER 
---@param RecceName string This name will be used to build a detection group set. All groups with this string somewhere in their group name will be added as Recce.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SetupIntel(RecceName) end

---[User] Switch screen output.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean  Switch screen output off (true) or on (false)
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SuppressScreenOutput(OnOff) end

---[User] Set up detection of STATIC objects.
---You need to set up detection with #PLAYERTASKCONTROLLER.SetupIntel() **before** using this.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean Set to `true`for on and `false`for off.
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SwitchDetectStatics(OnOff) end

---[User] Switch showing additional magnetic angles
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean If true, set to on (default), if nil or false, set to off
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SwitchMagenticAngles(OnOff) end

---[User] Switch usage of target names for menu entries on or off
---
------
---@param self PLAYERTASKCONTROLLER 
---@param OnOff boolean If true, set to on (default), if nil or false, set to off
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:SwitchUseGroupNames(OnOff) end

---[Internal] Abort Task
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_AbortTask(Group, Client) end

---[Internal] Show active task info
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Task PLAYERTASK 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_ActiveTaskInfo(Task, Group, Client) end

---[Internal] Add a task to the task queue
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Target TARGET 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_AddTask(Target) end

---[Internal] Check task queue for a specific player name
---
------
---@param self PLAYERTASKCONTROLLER 
---@param PlayerName NOTYPE 
---@return boolean #outcome
function PLAYERTASKCONTROLLER:_CheckPlayerHasTask(PlayerName) end

---[Internal] Check precision task queue
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_CheckPrecisionTasks() end

---[Internal] Check target queue
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_CheckTargetQueue() end

---[Internal] Check task queue
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_CheckTaskQueue() end

---[Internal] Check for allowed task type, if there is a (positive) whitelist
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Type string 
---@return boolean #Outcome
function PLAYERTASKCONTROLLER:_CheckTaskTypeAllowed(Type) end

---[Internal] Check for allowed task type, if there is a (negative) blacklist
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Type string 
---@return boolean #Outcome
function PLAYERTASKCONTROLLER:_CheckTaskTypeDisallowed(Type) end

---[Internal] _CreateActiveTaskMenuTemplate
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_CreateActiveTaskMenuTemplate() end

---[Internal] _CreateJoinMenuTemplate
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_CreateJoinMenuTemplate() end

---[Internal] Event handling
---
------
---@param self PLAYERTASKCONTROLLER 
---@param EventData EVENTDATA 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_EventHandler(EventData) end

---[Internal] Find matching drone for precision bombing task, if any is assigned.
---
------
---@param self PLAYERTASKCONTROLLER 
---@param ID number Task ID to look for
---@return OPSGROUP #Drone
function PLAYERTASKCONTROLLER:_FindLasingDroneForTaskID(ID) end

---[Internal] Flare task location
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_FlareTask(Group, Client) end

---[Internal] Flashing directional info for a client
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_FlashInfo() end

---[Internal] Get task types for the menu
---
------
---@param self PLAYERTASKCONTROLLER 
---@return table #TaskTypes
function PLAYERTASKCONTROLLER:_GetAvailableTaskTypes() end

---[Internal] Get player name
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Client CLIENT 
---@return string #playername
---@return string #ttsplayername
function PLAYERTASKCONTROLLER:_GetPlayerName(Client) end

---[Internal] Get task per type for the menu
---
------
---@param self PLAYERTASKCONTROLLER 
---@return table #TasksPerTypes
function PLAYERTASKCONTROLLER:_GetTasksPerType() end

---[Internal] Get text for text-to-speech.
---Numbers are spaced out, e.g. "Heading 180" becomes "Heading 1 8 0 ".
---
------
---@param self PLAYERTASKCONTROLLER 
---@param text string Original text.
---@return string #Spoken text.
function PLAYERTASKCONTROLLER:_GetTextForSpeech(text) end

---[Internal] Illuminate task location
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_IlluminateTask(Group, Client) end

---[Internal] Init localization
---
------
---@param self PLAYERTASKCONTROLLER 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_InitLocalization() end

---[Internal] Function the check against SeadAttributes
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Attribute string 
---@return boolean #IsSead
function PLAYERTASKCONTROLLER:_IsAttributeSead(Attribute) end

---[Internal] Join a player to a task
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Task PLAYERTASK 
---@param Force boolean Assign task even if client already has one
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_JoinTask(Task, Force, Group, Client) end

---[Internal] Mark task on F10 map
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_MarkTask(Group, Client) end

---[Internal] _RemoveMenuEntriesForTask
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Task PLAYERTASK 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_RemoveMenuEntriesForTask(Task, Client) end

---[Internal] Send message to SET_CLIENT of players
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Text string the text to be send
---@param Seconds? number (optional) Seconds to show, default 10
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_SendMessageToClients(Text, Seconds) end


---
------
---@param self NOTYPE 
---@param Group NOTYPE 
---@param Client NOTYPE 
function PLAYERTASKCONTROLLER:_ShowRadioInfo(Group, Client) end

---[Internal] Smoke task location
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_SmokeTask(Group, Client) end

---[Internal] Switch flashing info for a client
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Group GROUP 
---@param Client CLIENT 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_SwitchFlashing(Group, Client) end

---[Internal] _SwitchMenuForClient
---
------
---@param self PLAYERTASKCONTROLLER 
---@param Client CLIENT The client
---@param MenuType string 
---@param Delay number 
---@return PLAYERTASKCONTROLLER #self
function PLAYERTASKCONTROLLER:_SwitchMenuForClient(Client, MenuType, Delay) end


---
------
---@param self NOTYPE 
function PLAYERTASKCONTROLLER:_UpdateJoinMenuTemplate() end

---[Internal] On after start call
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterStart(From, Event, To) end

---[Internal] On after Status call
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterStatus(From, Event, To) end

---[Internal] On after Stop call
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterStop(From, Event, To) end

---[Internal] On after task added
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskAdded(From, Event, To, Task) end

---[Internal] On after task cancelled
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskCancelled(From, Event, To, Task) end

---[Internal] On after task done
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskDone(From, Event, To, Task) end

---[Internal] On after task failed
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskFailed(From, Event, To, Task) end

---[Internal] On after task failed, repeat planned
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskRepeatOnFailed(From, Event, To, Task) end

---[Internal] On after task success
---
------
---@param self PLAYERTASKCONTROLLER 
---@param From string 
---@param Event string 
---@param To string 
---@param Task PLAYERTASK 
---@return PLAYERTASKCONTROLLER #self
---@private
function PLAYERTASKCONTROLLER:onafterTaskSuccess(From, Event, To, Task) end


---@class SeadAttributes 
---@field AAA number GROUP.Attribute.GROUND_AAA
---@field EWR number GROUP.Attribute.GROUND_EWR 
---@field SAM number GROUP.Attribute.GROUND_SAM 
SeadAttributes = {}


---@class Type 
---@field A2A string Air-to-Air Controller
---@field A2G string Air-to-Ground Controller
---@field A2GS string Air-to-Ground-and-Ship Controller
---@field A2S string Air-to-Ship Controller
Type = {}



