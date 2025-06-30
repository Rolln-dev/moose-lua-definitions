---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_OpsZone.png" width="100%">
---
---**Ops** - Strategic Zone.
---
---**Main Features:**
---
---   * Monitor if a zone is captured
---   * Monitor if an airbase is captured
---   * Define conditions under which zones are captured/held
---   * Supports circular and polygon zone shapes
---
---===
---
---### Author: **funkyfranky**
---*Gentlemen, when the enemy is committed to a mistake we must not interrupt him too soon.* --- Horation Nelson
---
---===
---
---# The OPSZONE Concept
---
---An OPSZONE is a strategically important area.

---OPSZONE class.
---@class OPSZONE : FSM
---@field ClassName string Name of the class.
---@field HitTimeLast  
---@field Nblu number Number of blue units in the zone.
---@field Nnut number Number of neutral units in the zone.
---@field Nred number Number of red units in the zone.
---@field ScanGroupSet SET_GROUP Set of scanned groups.
---@field ScanUnitSet SET_UNIT Set of scanned units.
---@field Tattacked number Abs. mission time stamp when an attack was started.
---@field Tblu number Threat level of blue units in the zone.
---@field Tcaptured number Time stamp (abs.) when the attacker destroyed all owning troops.
---@field TminCaptured number Time interval in seconds how long an attacker must have troops inside the zone to capture.
---@field Tnut number Threat level of neutral units in the zone.
---@field Tred number Threat level of red units in the zone.
---@field UpdateSeconds number Run status every this many seconds.
---@field airbase AIRBASE The airbase that is monitored.
---@field airbaseName string Name of the airbase that is monitored.
---@field dTCapture number Time interval in seconds until a zone is captured.
---@field drawZone boolean If `true`, draw the zone on the F10 map.
---@field drawZoneForCoalition boolean 
---@field isContested boolean 
---@field lid string DCS log ID string.
---@field markZone boolean If `true`, mark the zone on the F10 map.
---@field marker MARKER Marker on the F10 map.
---@field markerText string Text shown in the maker.
---@field neutralCanCapture boolean Neutral units can capture. Default `false`.
---@field nunitsCapture number Number of units necessary to capture a zone.
---@field ownerCurrent number Coalition of the current owner of the zone.
---@field ownerPrevious number Coalition of the previous owner of the zone.
---@field threatlevelCapture number Threat level necessary to capture a zone.
---@field timerStatus TIMER Timer for calling the status update.
---@field verbose number Verbosity of output.
---@field version string OPSZONE class version.
---@field zone ZONE The zone.
---@field zoneCircular ZONE_RADIUS The circular zone.
---@field zoneName string Name of the zone.
---@field zoneRadius number Radius of the zone in meters.
---@field zoneType  
OPSZONE = {}

---Triggers the FSM event "Attacked".
---
------
---@param self OPSZONE 
---@param AttackerCoalition number Coalition side that is attacking the zone.
function OPSZONE:Attacked(AttackerCoalition) end

---Triggers the FSM event "Captured".
---
------
---@param self OPSZONE 
---@param Coalition number Coalition side that captured the zone.
function OPSZONE:Captured(Coalition) end

---Triggers the FSM event "Defeated".
---
------
---@param self OPSZONE 
---@param DefeatedCoalition number Coalition side that was defeated.
function OPSZONE:Defeated(DefeatedCoalition) end

---Triggers the FSM event "Empty".
---
------
---@param self OPSZONE 
function OPSZONE:Empty() end

---Evaluate zone.
---
------
---@param self OPSZONE 
---@return OPSZONE #self
function OPSZONE:EvaluateZone() end

---Triggers the FSM event "Evaluated".
---
------
---@param self OPSZONE 
function OPSZONE:Evaluated() end

---Find an OPSZONE using the Zone Name.
---
------
---@param self OPSZONE 
---@param ZoneName string The zone name.
---@return OPSZONE #The OPSZONE or nil if not found.
function OPSZONE:FindByName(ZoneName) end

---Get duration of the current attack.
---
------
---@param self OPSZONE 
---@return number #Duration in seconds since when the last attack began. Is `nil` if the zone is not under attack currently.
function OPSZONE:GetAttackDuration() end

---Get coordinate of zone.
---
------
---@param self OPSZONE 
---@return COORDINATE #Coordinate of the zone.
function OPSZONE:GetCoordinate() end

---Get zone name.
---
------
---@param self OPSZONE 
---@return string #Name of the zone.
function OPSZONE:GetName() end

---Get current owner of the zone.
---
------
---@param self OPSZONE 
---@return number #Owner coalition.
function OPSZONE:GetOwner() end

---Get coalition name of current owner of the zone.
---
------
---@param self OPSZONE 
---@return string # Owner coalition.
function OPSZONE:GetOwnerName() end

---Get previous owner of the zone.
---
------
---@param self OPSZONE 
---@return number #Previous owner coalition.
function OPSZONE:GetPreviousOwner() end

---Returns a random coordinate in the zone.
---
------
---@param self OPSZONE 
---@param inner number (Optional) Minimal distance from the center of the zone in meters. Default is 0 m.
---@param outer number (Optional) Maximal distance from the outer edge of the zone in meters. Default is the radius of the zone.
---@param surfacetypes table (Optional) Table of surface types. Can also be a single surface type. We will try max 1000 times to find the right type!
---@return COORDINATE #The random coordinate.
function OPSZONE:GetRandomCoordinate(inner, outer, surfacetypes) end

---Get scanned groups inside the zone.
---
------
---@param self OPSZONE 
---@return SET_GROUP #Set of groups inside the zone.
function OPSZONE:GetScannedGroupSet() end

---Get scanned units inside the zone.
---
------
---@param self OPSZONE 
---@return SET_UNIT #Set of units inside the zone.
function OPSZONE:GetScannedUnitSet() end

---Get the zone object.
---
------
---@param self OPSZONE 
---@return ZONE #The zone.
function OPSZONE:GetZone() end

---Triggers the FSM event "Guarded".
---
------
---@param self OPSZONE 
function OPSZONE:Guarded() end

---Check if zone is being attacked by the opposite coalition.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is being attacked.
function OPSZONE:IsAttacked() end

---Check if the blue coalition is currently owning the zone.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is blue.
function OPSZONE:IsBlue() end

---Check if a certain coalition is currently owning the zone.
---
------
---@param self OPSZONE 
---@param Coalition number The Coalition that is supposed to own the zone.
---@return boolean #If `true`, zone is owned by the given coalition.
function OPSZONE:IsCoalition(Coalition) end

---Check if zone is contested.
---Contested here means red *and* blue units are present in the zone.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is contested.
function OPSZONE:IsContested() end

---Check if zone is empty.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is empty.
function OPSZONE:IsEmpty() end

---Check if zone is guarded.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is guarded.
function OPSZONE:IsGuarded() end

---Check if the neutral coalition is currently owning the zone.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is neutral.
function OPSZONE:IsNeutral() end

---Check if the red coalition is currently owning the zone.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is red.
function OPSZONE:IsRed() end

---Check if zone is started (not stopped).
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is started.
function OPSZONE:IsStarted() end

---Check if zone is stopped.
---
------
---@param self OPSZONE 
---@return boolean #If `true`, zone is stopped.
function OPSZONE:IsStopped() end

---Create a new OPSZONE class object.
---
------
---
---USAGE
---```
---myopszone = OPSZONE:New(ZONE:FindByName("OpsZoneOne"), coalition.side.RED) -- base zone from the mission editor
---myopszone = OPSZONE:New(ZONE_RADIUS:New("OpsZoneTwo", mycoordinate:GetVec2(),5000),coalition.side.BLUE) -- radius zone of 5km at a coordinate
---myopszone = OPSZONE:New(ZONE_RADIUS:New("Batumi")) -- airbase zone from Batumi Airbase, ca 2500m radius
---myopszone = OPSZONE:New(ZONE_AIRBASE:New("Batumi",6000),coalition.side.BLUE) -- airbase zone from Batumi Airbase, but with a specific radius of 6km
---```
------
---@param self OPSZONE 
---@param Zone ZONE The zone. Can be passed as ZONE\_RADIUS, ZONE_POLYGON, ZONE\_AIRBASE or simply as the name of the airbase.
---@param CoalitionOwner number Initial owner of the coaliton. Default `coalition.side.NEUTRAL`.
---@return OPSZONE #self
function OPSZONE:New(Zone, CoalitionOwner) end

---On after "Attacked" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackerCoalition number Coalition side that is attacking the zone.
function OPSZONE:OnAfterAttacked(From, Event, To, AttackerCoalition) end

---On after "Captured" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition number Coalition side that captured the zone.
function OPSZONE:OnAfterCaptured(From, Event, To, Coalition) end

---On after "Defeated" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DefeatedCoalition number Coalition side that was defeated.
function OPSZONE:OnAfterDefeated(From, Event, To, DefeatedCoalition) end

---On after "Empty" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.  
function OPSZONE:OnAfterEmpty(From, Event, To) end

---On after "Evaluated" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSZONE:OnAfterEvaluated(From, Event, To) end

---On after "Guarded" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.  
function OPSZONE:OnAfterGuarded(From, Event, To) end

---Monitor base captured events.
---
------
---@param self OPSZONE 
---@param EventData EVENTDATA The event data.
function OPSZONE:OnEventBaseCaptured(EventData) end

---Monitor hit events.
---
------
---@param self OPSZONE 
---@param EventData EVENTDATA The event data.
function OPSZONE:OnEventHit(EventData) end

---Scan zone.
---
------
---@param self OPSZONE 
---@return OPSZONE #self
function OPSZONE:Scan() end

---Set how many units must be present in a zone to capture it.
---By default, one unit is enough.
---
------
---@param self OPSZONE 
---@param Nunits number Number of units. Default 1.
---@return OPSZONE #self
function OPSZONE:SetCaptureNunits(Nunits) end

---Set threat level threshold that the offending units must have to capture a zone.
---The reason why you might want to set this is that unarmed units (*e.g.* fuel trucks) should not be able to capture a zone as they do not pose a threat.
---
------
---@param self OPSZONE 
---@param Threatlevel number Threat level threshold. Default 0.
---@return OPSZONE #self
function OPSZONE:SetCaptureThreatlevel(Threatlevel) end

---Set time how long an attacking coalition must have troops inside a zone before it captures the zone.
---
------
---@param self OPSZONE 
---@param Tcapture number Time in seconds. Default 0.
---@return OPSZONE #self
function OPSZONE:SetCaptureTime(Tcapture) end

---Set if zone is drawn on the F10 map.
---Color will change depending on current owning coalition.
---
------
---@param self OPSZONE 
---@param Switch boolean If `true` or `nil`, draw zone. If `false`, zone is not drawn.
---@return OPSZONE #self
function OPSZONE:SetDrawZone(Switch) end

---Set if zone is drawn on the F10 map for the owner coalition only.
---
------
---@param self OPSZONE 
---@param Switch boolean If `false` or `nil`, draw zone for all coalitions. If `true`, zone is drawn for the owning coalition only if drawZone is true.
---@return OPSZONE #self
function OPSZONE:SetDrawZoneForCoalition(Switch) end

---Set if a marker on the F10 map shows the current zone status.
---
------
---@param self OPSZONE 
---@param Switch boolean If `true`, zone is marked. If `false` or `nil`, zone is not marked.
---@param ReadOnly boolean If `true` or `nil` then mark is read only.
---@return OPSZONE #self
function OPSZONE:SetMarkZone(Switch, ReadOnly) end

---Set whether *neutral* units can capture the zone.
---
------
---@param self OPSZONE 
---@param CanCapture boolean If `true`, neutral units can.
---@return OPSZONE #self
function OPSZONE:SetNeutralCanCapture(CanCapture) end

---Set categories of objects that can capture or hold the zone.
---
---* Default is {Object.Category.UNIT, Object.Category.STATIC} so units and statics can capture and hold zones.
---* Set to `{Object.Category.UNIT}` if only units should be able to capture and hold zones
---
---Which units can capture zones can be further refined by `:SetUnitCategories()`.
---
------
---@param self OPSZONE 
---@param Categories table Object categories. Default is `{Object.Category.UNIT, Object.Category.STATIC}`.
---@return OPSZONE #self
function OPSZONE:SetObjectCategories(Categories) end

---Set categories of units that can capture or hold the zone.
---See [DCS Class Unit](https://wiki.hoggitworld.com/view/DCS_Class_Unit).
---
------
---@param self OPSZONE 
---@param Categories table Table of unit categories. Default `{Unit.Category.GROUND_UNIT}`.
---@return OPSZONE #self
function OPSZONE:SetUnitCategories(Categories) end

---Set verbosity level.
---
------
---@param self OPSZONE 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return OPSZONE #self
function OPSZONE:SetVerbosity(VerbosityLevel) end

---Set custom RGB color of zone depending on current owner.
---
------
---@param self OPSZONE 
---@param Neutral table Color is a table of RGB values 0..1 for Red, Green, and Blue respectively, e.g. {1,0,0} for red.
---@param Blue table Color is a table of RGB values 0..1 for Red, Green, and Blue respectively, e.g. {0,1,0} for green.
---@param Red table Color is a table of RGB values 0..1 for Red, Green, and Blue respectively, e.g. {0,0,1} for blue.
---@return OPSZONE #self
function OPSZONE:SetZoneColor(Neutral, Blue, Red) end

---Triggers the FSM event "Start".
---
------
---@param self OPSZONE 
function OPSZONE:Start() end

---Update status.
---
------
---@param self OPSZONE 
function OPSZONE:Status() end

---Triggers the FSM event "Stop".
---
------
---@param self OPSZONE 
function OPSZONE:Stop() end

---Add a chief that monitors this zone.
---Chief will be informed about capturing etc.
---
------
---@param self OPSZONE 
---@param Chief CHIEF The chief.
---@return table #RGB color.
function OPSZONE:_AddChief(Chief) end

---Add an entry to the OpsZone mission table
---
------
---@param self OPSZONE 
---@param Coalition number Coalition of type e.g. coalition.side.NEUTRAL
---@param Type string Type of mission, e.g. AUFTRAG.Type.CAS
---@param Auftrag AUFTRAG The Auftrag itself
---@return OPSZONE #self
function OPSZONE:_AddMission(Coalition, Type, Auftrag) end

---Clean mission table from missions that are over.
---
------
---@param self OPSZONE 
---@return OPSZONE #self
function OPSZONE:_CleanMissionTable() end

---Add an entry to the OpsZone mission table.
---
------
---@param self OPSZONE 
---@param Coalition number Coalition of type e.g. `coalition.side.NEUTRAL`.
---@param Type string Type of mission, e.g. `AUFTRAG.Type.CAS`.
---@return boolean #found True if we have that kind of mission, else false.
---@return table #Missions Table of `Ops.Auftrag#AUFTRAG` entries.
function OPSZONE:_FindMissions(Coalition, Type) end

---Get marker text.
---
------
---@param self OPSZONE 
---@return string #Marker text.
function OPSZONE:_GetMarkerText() end

---Get the OpsZone mission table.
---#table of #OPSZONE.MISSION entries
---
------
---@param self OPSZONE 
---@return table #Missions
function OPSZONE:_GetMissions() end

---Get RGB color of zone depending on current owner.
---
------
---@param self OPSZONE 
---@return table #RGB color.
function OPSZONE:_GetZoneColor() end

---Update marker on the F10 map.
---
------
---@param self OPSZONE 
function OPSZONE:_UpdateMarker() end

---Triggers the FSM event "Attacked" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
---@param AttackerCoalition number Coalition side that is attacking the zone.
function OPSZONE:__Attacked(delay, AttackerCoalition) end

---Triggers the FSM event "Captured" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
---@param Coalition number Coalition side that captured the zone.
function OPSZONE:__Captured(delay, Coalition) end

---Triggers the FSM event "Defeated" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
---@param DefeatedCoalition number Coalition side that was defeated.
function OPSZONE:__Defeated(delay, DefeatedCoalition) end

---Triggers the FSM event "Empty" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
function OPSZONE:__Empty(delay) end

---Triggers the FSM event "Evaluated" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
function OPSZONE:__Evaluated(delay) end

---Triggers the FSM event "Guarded" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
function OPSZONE:__Guarded(delay) end

---Triggers the FSM event "Start" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
function OPSZONE:__Start(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param self OPSZONE 
---@param delay number Delay in seconds.
function OPSZONE:__Stop(delay) end

---On after "Attacked" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackerCoalition number Coalition of the attacking ground troops.
function OPSZONE:onafterAttacked(From, Event, To, AttackerCoalition) end

---On after "Captured" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param NewOwnerCoalition number Coalition of the new owner.
function OPSZONE:onafterCaptured(From, Event, To, NewOwnerCoalition) end

---On after "Defeated" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param DefeatedCoalition number Coalition side that was defeated.
function OPSZONE:onafterDefeated(From, Event, To, DefeatedCoalition) end

---On after "Empty" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSZONE:onafterEmpty(From, Event, To) end

---Start OPSZONE FSM.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@return OPSZONE #self
function OPSZONE:onafterStart(From, Event, To) end

---Stop OPSZONE FSM.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSZONE:onafterStop(From, Event, To) end

---On before "Captured" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param NewOwnerCoalition number Coalition of the new owner.
function OPSZONE:onbeforeCaptured(From, Event, To, NewOwnerCoalition) end

---On enter "Attacked" state.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param AttackerCoalition number Coalition of the attacking ground troops.
function OPSZONE:onenterAttacked(From, Event, To, AttackerCoalition) end

---On enter "Empty" event.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSZONE:onenterEmpty(From, Event, To) end

---On enter "Guarded" state.
---
------
---@param self OPSZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function OPSZONE:onenterGuarded(From, Event, To) end


---OPSZONE.MISSION
---@class OPSZONE.MISSION 
---@field Coalition number Coalition
---@field Mission AUFTRAG The actual attached mission
---@field Type string Type of mission
OPSZONE.MISSION = {}


---Type of zone we are dealing with.
---@class OPSZONE.ZoneType 
---@field Circular string Zone is circular.
---@field Polygon string Zone is a polygon.
OPSZONE.ZoneType = {}



