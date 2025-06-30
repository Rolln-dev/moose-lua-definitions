---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_FlightControl.png" width="100%">
---
---**OPS** - Air Traffic Control for AI and human players.
---
---**Main Features:**
---
---   * Manage aircraft departure and arrival
---   * Handles AI and human players
---   * Limit number of AI groups taxiing, taking off and landing simultaneously
---   * Immersive voice overs via SRS text-to-speech
---   * Define holding patterns for airdromes
---    
---===
---
---## Example Missions:
---
---Demo missions: None
---
---===
---
---### Author: **funkyfranky**
---
---===
---**Ground Control**: Airliner X, Good news, you are clear to taxi to the active.
--- **Pilot**: Roger, What's the bad news?
--- **Ground Control**: No bad news at the moment, but you probably want to get gone before I find any.
---
---===
---
---# The FLIGHTCONTROL Concept
---
---This class implements an ATC for human and AI controlled aircraft. It gives permission for take-off and landing based on a sophisticated queueing system.
---Therefore, it solves (or reduces) a lot of common problems with the DCS implementation.
---
---You might be familiar with the `AIRBOSS` class. This class is the analogue for land based airfields. One major difference is that no pre-recorded sound files are 
---necessary. The radio transmissions use the SRS text-to-speech feature.
---
---## Prerequisites
---
---* SRS is used for radio communications
---
---## Limitations
---
---Some (DCS) limitations you should be aware of:
---
---* As soon as AI aircraft taxi or land, we completely loose control. All is governed by the internal DCS AI logic.
---* We have no control over the active runway or which runway is used by the AI if there are multiple.
---* Only one player/client per group as we can create menus only for a group and not for a specific unit.
---* Only FLIGHTGROUPS are controlled. This means some older classes, *e.g.* RAT are not supported (yet).
---* So far only airdromes are handled, *i.e.* no FARPs or ships.
---* Helicopters are not treated differently from fixed wing aircraft until now.
---* The active runway can only be determined by the wind direction. So at least set a very light wind speed in your mission.
---
---# Basic Usage
---
---A flight control for a given airdrome can be created with the #FLIGHTCONTROL.New(*AirbaseName, Frequency, Modulation, PathToSRS*) function. You need to specify the name of the airbase, the 
---tower radio frequency, its modulation and the path, where SRS is located on the machine that is running this mission.
---
---For the FC to be operating, it needs to be started with the #FLIGHTCONTROL.Start() function.
---
---## Simple Script
---
---The simplest script looks like
---
---     local FC_BATUMI=FLIGHTCONTROL:New(AIRBASE.Caucasus.Batumi, 251, nil, "D:\\SomeDirectory\\_SRS")
---     FC_BATUMI:Start()
---
---This will start the FC for at the Batumi airbase with tower frequency 251 MHz AM. SRS needs to be in the given directory.
---
---Like this, a default holding pattern (see below) is parallel to the direction of the active runway.
---
---# Holding Patterns
---
---Holding pattern are air spaces where incoming aircraft are guided to and have to hold until they get landing clearance.
---
---You can add a holding pattern with the #FLIGHTCONTROL.AddHoldingPattern(*ArrivalZone, Heading, Length, FlightlevelMin, FlightlevelMax, Prio*) function, where
---
---* `ArrivalZone` is the zone where the aircraft enter the pattern.
---* `Heading` is the direction into which the aircraft have to fly from the arrival zone.
---* `Length` is the length of the pattern.
---* `FlightLevelMin` is the lowest altitude at which aircraft can hold.
---* `FlightLevelMax` is the highest altitude at which aircraft can hold.
---* `Prio` is the priority of this holding stacks. If multiple patterns are defined, patterns with higher prio will be filled first.
---
---# Parking Guard
---
---A "parking guard" is a group or static object, that is spawned in front of parking aircraft. This is useful to stop AI groups from taxiing if they are spawned with hot engines.
---It is also handy to forbid human players to taxi until they ask for clearance.
---
---You can activate the parking guard with the #FLIGHTCONTROL.SetParkingGuard(*GroupName*) function, where the parameter `GroupName` is the name of a late activated template group.
---This should consist of only *one* unit, *e.g.* a single infantry soldier.
---
---You can also use static objects as parking guards with the #FLIGHTCONTROL.SetParkingGuardStatic(*StaticName*), where the parameter `StaticName` is the name of a static object placed
---somewhere in the mission editor.
---
---# Limits for Inbound and Outbound Flights
---
---You can define limits on how many aircraft are simultaneously landing and taking off. This avoids (DCS) problems where taxiing aircraft cause a "traffic jam" on the taxi way(s)
---and bring the whole airbase effectively to a stand still.
---
---## Landing Limits
---
---The number of groups getting landing clearance can be set with the #FLIGHTCONTROL.SetLimitLanding(*Nlanding, Ntakeoff*) function. 
---The first parameter, `Nlanding`, defines how many groups get clearance simultaneously.
---
---The second parameter, `Ntakeoff`, sets a limit on how many flights can take off whilst inbound flights still get clearance. By default, this is set to zero because the runway can only be used for takeoff *or*
---landing. So if you have a flight taking off, inbound fights will have to wait until the runway is clear. 
---If you have an airport with more than one runway, *e.g.* Nellis AFB, you can allow simultanious landings and takeoffs by setting this number greater zero.
---
---The time interval between clerances can be set with the #FLIGHTCONTROL.SetLandingInterval(`dt`) function, where the parameter `dt` specifies the time interval in seconds before 
---the next flight get clearance. This only has an effect if `Nlanding` is greater than one.
---
---## Taxiing/Takeoff Limits
---
---The number of AI flight groups getting clearance to taxi to the runway can be set with the #FLIGHTCONTROL.SetLimitTaxi(*Nlanding, Ntakeoff*) function. 
---The first parameter, `Ntaxi`, defines how many groups are allowed to taxi to the runway simultaneously. Note that once the AI starts to taxi, we loose complete control over it.
---They will follow their internal logic to get the the runway and take off. Therefore, giving clearance to taxi is equivalent to giving them clearance for takeoff.
---
---By default, the parameter only counts the number of flights taxiing *to* the runway. If you set the second parameter, `IncludeInbound`, to `true`, this will also count the flights
---that are taxiing to their parking spot(s) after they landed.
---
---The third parameter, `Nlanding`, defines how many aircraft can land whilst outbound fights still get taxi/takeoff clearance. By default, this is set to zero because the runway
---can only be used for takeoff *or* landing. If you have an airport with more than one runway, *e.g.* Nellis AFB, you can allow aircraft to taxi to the runway while other flights are landing
---by setting this number greater zero.  
---
---Note that the limits here are only affecting **AI** aircraft groups. *Human players* are assumed to be a lot more well behaved and capable as they are able to taxi around obstacles, *e.g.*
---other aircraft etc. Therefore, players will get taxi clearance independent of the number of inbound and/or outbound flights. Players will, however, still need to ask for takeoff clearance once
---they are holding short of the runway.
---
---# Speeding Violations
---
---You can set a speed limit for taxiing players with the #FLIGHTCONTROL.SetSpeedLimitTaxi(*SpeedLimit*) function, where the parameter `SpeedLimit` is the max allowed speed in knots.
---If players taxi faster, they will get a radio message. Additionally, the FSM event `PlayerSpeeding` is triggered and can be captured with the `OnAfterPlayerSpeeding` function.
---For example, this can be used to kick players that do not behave well.
---
---# Runway Destroyed
---
---Once a runway is damaged, DCS AI will stop taxiing. Therefore, this class monitors if a runway is destroyed. If this is the case, all AI taxi and landing clearances will be suspended for
---one hour. This is the hard coded time in DCS until the runway becomes operational again. If that ever changes, you can manually set the repair time with the 
---#FLIGHTCONTROL.SetRunwayRepairtime function.
---
---Note that human players we still get taxi, takeoff and landing clearances.
---
---If the runway is destroyed, the FSM event `RunwayDestroyed` is triggered and can be captured with the #FLIGHTCONTROL.OnAfterRunwayDestroyed function.
---
---If the runway is repaired, the FSM event `RunwayRepaired` is triggered and can be captured with the #FLIGHTCONTROL.OnAfterRunwayRepaired function.
---
---# SRS
---
---SRS text-to-speech is used to send radio messages from the tower and pilots.
---
---## Tower
---
---You can set the options for the tower SRS voice with the #FLIGHTCONTROL.SetSRSTower() function.
---
---## Pilot
---
---You can set the options for the pilot SRS voice with the #FLIGHTCONTROL.SetSRSPilot() function.
---
---# Runways
---
---First note, that we have extremely limited control over which runway the DCS AI groups use. The only parameter we can adjust is the direction of the wind. In many cases, the AI will try to takeoff and land
---against the wind, which therefore determines the active runway. There are, however, cases where this does not hold true. For example, at Nellis AFB the runway for takeoff is `03L` while the runway for
---landing is `21L`.
---
---By default, the runways for landing and takeoff are determined from the wind direction as described above. For cases where this gives wrong results, you can set the active runways manually. This is
---done via Wrapper.Airbase#AIRBASE class.
---
---More specifically, you can use the Wrapper.Airbase#AIRBASE.SetActiveRunwayLanding function to set the landing runway and the Wrapper.Airbase#AIRBASE.SetActiveRunwayTakeoff function to set
---the runway for takeoff.
---
---## Example for Nellis AFB
---
---For Nellis, you can use:
---
---    -- Nellis AFB.
---    local Nellis=AIRBASE:FindByName(AIRBASE.Nevada.Nellis_AFB)
---    Nellis:SetActiveRunwayLanding("21L")
---    Nellis:SetActiveRunwayTakeoff("03L")
---
---# DCS ATC
---
---You can disable the DCS ATC with the Wrapper.Airbase#AIRBASE.SetRadioSilentMode(*true*). This does not remove the DCS ATC airbase from the F10 menu but makes the ATC unresponsive.
---
---
---# Examples
---
---In this section, you find examples for different airdromes.
---
---## Nellis AFB
---    
---    -- Create a new FLIGHTCONTROL object at Nellis AFB. The tower frequency is 251 MHz AM. Path to SRS has to be adjusted. 
---    local atcNellis=FLIGHTCONTROL:New(AIRBASE.Nevada.Nellis_AFB, 251, nil, "D:\\My SRS Directory")
---    -- Set a parking guard from a static named "Static Generator F Template".
---    atcNellis:SetParkingGuardStatic("Static Generator F Template")
---    -- Set taxi speed limit to 25 knots.
---    atcNellis:SetSpeedLimitTaxi(25)
---    -- Set that max 3 groups are allowed to taxi simultaneously.
---    atcNellis:SetLimitTaxi(3, false, 1)
---    -- Set that max 2 groups are allowd to land simultaneously and unlimited number (99) groups can land, while other groups are taking off.
---    atcNellis:SetLimitLanding(2, 99)
---    -- Use Google for text-to-speech.
---    atcNellis:SetSRSTower(nil, nil, "en-AU-Standard-A", nil, nil, "D:\\Path To Google\\GoogleCredentials.json")
---    atcNellis:SetSRSPilot(nil, nil, "en-US-Wavenet-I",  nil, nil, "D:\\Path To Google\\GoogleCredentials.json")
---    -- Define two holding zones.
---    atcNellis:AddHoldingPattern(ZONE:New("Nellis Holding Alpha"), 030, 15, 6, 10, 10)
---    atcNellis:AddHoldingPattern(ZONE:New("Nellis Holding Bravo"), 090, 15, 6, 10, 20)
---    -- Start the ATC.
---    atcNellis:Start()
---FLIGHTCONTROL class.
---@class FLIGHTCONTROL : FSM
---@field CallsignTranslations  
---@field ClassName string Name of the class.
---@field NlandingTakeoff number Max number of groups taking off to allow landing clearance.
---@field NlandingTot number Max number of aircraft groups in the landing pattern.
---@field Nparkingspots number Total number of parking spots.
---@field Nplayers number Number of human players. Updated at each StatusUpdate call.
---@field NtaxiInbound boolean Include inbound taxiing groups.
---@field NtaxiLanding number Max number of aircraft landing for groups taxiing to runway for takeoff.
---@field NtaxiTot number Max number of aircraft groups taxiing to runway for takeoff.
---@field ShortCallsign boolean 
---@field Tlanding number Time stamp (abs.) when last flight got landing clearance.
---@field Tlastmessage number Time stamp (abs.) of last radio transmission.
---@field airbase AIRBASE Airbase object.
---@field airbasename string Name of airbase.
---@field airbasetype number Type of airbase.
---@field alias string Radio alias, e.g. "Batumi Tower".
---@field atis ATIS ATIS object.
---@field dTlanding number Time interval in seconds between landing clearance.
---@field dTmessage number Time interval between messages.
---@field frequency number ATC radio frequency in MHz.
---@field holdingBackup  
---@field hpcounter number Counter for holding zones.
---@field lid string Class id string for output to DCS log file.
---@field markPatterns boolean If `true`, park holding pattern.
---@field markerParking boolean If `true`, occupied parking spots are marked.
---@field modulation number ATC radio modulation, *e.g.* `radio.modulation.AM`.
---@field msrsPilot MSRS Moose SRS wrapper.
---@field msrsTower MSRS Moose SRS wrapper.
---@field msrsqueue MSRSQUEUE Queue for TTS transmissions using MSRS class.
---@field nosubs boolean If `true`, SRS TTS is without subtitles.
---@field parkingGuard SPAWN Parking guard spawner.
---@field radioOnlyIfPlayers boolean Activate to limit transmissions only if players are active at the airbase.
---@field runwaydestroyed number Time stamp (abs), when runway was destroyed. If `nil`, runway is operational.
---@field runwayrepairtime number Time in seconds until runway will be repaired after it was destroyed. Default is 3600 sec (one hour).
---@field speedLimitTaxi number Taxi speed limit in m/s.
---@field theatre string The DCS map used in the mission.
---@field verbose boolean Verbosity level.
---@field version string FlightControl class version.
---@field zoneAirbase ZONE Zone around the airbase.
FLIGHTCONTROL = {}

---Add a holding pattern.
---This is a zone where the aircraft...
---
------
---@param self FLIGHTCONTROL 
---@param ArrivalZone ZONE Zone where planes arrive.
---@param Heading number Heading in degrees.
---@param Length number Length in nautical miles. Default 15 NM.
---@param FlightlevelMin number Min flight level. Default 5.
---@param FlightlevelMax number Max flight level. Default 15.
---@param Prio number Priority. Lower is higher. Default 50.
---@return FLIGHTCONTROL.HoldingPattern #Holding pattern table.
function FLIGHTCONTROL:AddHoldingPattern(ArrivalZone, Heading, Length, FlightlevelMin, FlightlevelMax, Prio) end

---Count flights in a given status.
---
------
---@param self FLIGHTCONTROL 
---@param Status string Return only flights in this status.
---@param GroupStatus string Count only flights in this FSM status, e.g. `OPSGROUP.GroupStatus.TAXIING`.
---@param AI boolean If `true` only AI flights are counted. If `false`, only flights with clients are counted. If `nil` (default), all flights are counted.
---@return number #Number of flights.
function FLIGHTCONTROL:CountFlights(Status, GroupStatus, AI) end

---Count number of parking spots.
---
------
---@param self FLIGHTCONTROL 
---@param SpotStatus string (Optional) Status of spot.
---@return number #Number of parking spots.
function FLIGHTCONTROL:CountParking(SpotStatus) end

---Get the active runway based on current wind direction.
---
------
---@param self FLIGHTCONTROL 
---@return AIRBASE.Runway #Active runway.
function FLIGHTCONTROL:GetActiveRunway() end

---Get the active runway for landing.
---
------
---@param self FLIGHTCONTROL 
---@return AIRBASE.Runway #Active runway.
function FLIGHTCONTROL:GetActiveRunwayLanding() end

---Get the active runway for takeoff.
---
------
---@param self FLIGHTCONTROL 
---@return AIRBASE.Runway #Active runway.
function FLIGHTCONTROL:GetActiveRunwayTakeoff() end

---Get the name of the active runway.
---
------
---@param self FLIGHTCONTROL 
---@param Takeoff boolean If true, return takeoff runway name. Default is landing.
---@return string #Runway text, e.g. "31L" or "09".
function FLIGHTCONTROL:GetActiveRunwayText(Takeoff) end

---Get closest parking spot.
---
------
---@param self FLIGHTCONTROL 
---@param Coordinate COORDINATE Reference coordinate.
---@param TerminalType number (Optional) Check only this terminal type.
---@param Status boolean (Optional) Only consider spots that have this status.
---@return FLIGHTCONTROL.ParkingSpot #Closest parking spot.
function FLIGHTCONTROL:GetClosestParkingSpot(Coordinate, TerminalType, Status) end

---Get coalition of the airbase.
---
------
---@param self FLIGHTCONTROL 
---@return number #Coalition ID.
function FLIGHTCONTROL:GetCoalition() end

---Get coordinate of the airbase.
---
------
---@param self FLIGHTCONTROL 
---@return COORDINATE #Coordinate of the airbase.
function FLIGHTCONTROL:GetCoordinate() end

---Get country of the airbase.
---
------
---@param self FLIGHTCONTROL 
---@return number #Country ID.
function FLIGHTCONTROL:GetCountry() end

---Get flight status.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@return string #Flight status
function FLIGHTCONTROL:GetFlightStatus(flight) end

---Get flights.
---
------
---@param self FLIGHTCONTROL 
---@param Status string Return only flights in this flightcontrol status, e.g. `FLIGHTCONTROL.Status.XXX`.
---@param GroupStatus string Return only flights in this FSM status, e.g. `OPSGROUP.GroupStatus.TAXIING`.
---@param AI boolean If `true` only AI flights are returned. If `false`, only flights with clients are returned. If `nil` (default), all flights are returned.
---@return table #Table of flights.
function FLIGHTCONTROL:GetFlights(Status, GroupStatus, AI) end

---Get parking spot by its Terminal ID.
---
------
---@param self FLIGHTCONTROL 
---@param TerminalID number 
---@return FLIGHTCONTROL.ParkingSpot #Parking spot data table.
function FLIGHTCONTROL:GetParkingSpotByID(TerminalID) end

---Check if runway is operational.
---
------
---@param self FLIGHTCONTROL 
---@return number #Time in seconds until the runway is repaired. Will return 0 if runway is repaired.
function FLIGHTCONTROL:GetRunwayRepairtime() end

---Check if FC has control over this flight.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@return boolean #
function FLIGHTCONTROL:IsControlling(flight) end

---Check if coordinate is on runway.
---
------
---@param self FLIGHTCONTROL 
---@param Coordinate COORDINATE 
---@return boolean #If `true`, coordinate is on a runway.
function FLIGHTCONTROL:IsCoordinateRunway(Coordinate) end

---Is flight in queue of this flightcontrol.
---
------
---@param self FLIGHTCONTROL 
---@param Flight FLIGHTGROUP Flight group.
---@return boolean #If `true`, flight is in queue.
function FLIGHTCONTROL:IsFlight(Flight) end

---Check if parking spot is free.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot Parking spot data.
---@return boolean #If true, parking spot is free.
function FLIGHTCONTROL:IsParkingFree(spot) end

---Check if a parking spot is reserved by a flight group.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot Parking spot to check.
---@return string #Name of element or nil.
function FLIGHTCONTROL:IsParkingOccupied(spot) end

---Check if a parking spot is reserved by a flight group.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot Parking spot to check.
---@return string #Name of element or *nil*.
function FLIGHTCONTROL:IsParkingReserved(spot) end

---Check if runway is destroyed.
---
------
---@param self FLIGHTCONTROL 
---@return boolean #If `true`, runway is destroyed.
function FLIGHTCONTROL:IsRunwayDestroyed() end

---Check if runway is operational.
---
------
---@param self FLIGHTCONTROL 
---@return boolean #If `true`, runway is operational.
function FLIGHTCONTROL:IsRunwayOperational() end

---Create a new FLIGHTCONTROL class object for an associated airbase.
---
------
---@param self FLIGHTCONTROL 
---@param AirbaseName string Name of the airbase.
---@param Frequency number Radio frequency in MHz. Default 143.00 MHz. Can also be given as a `#table` of multiple frequencies.
---@param Modulation number Radio modulation: 0=AM (default), 1=FM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. Can also be given as a `#table` of multiple modulations.
---@param PathToSRS string Path to the directory, where SRS is located.
---@param Port number Port of SRS Server, defaults to 5002
---@param GoogleKey string Path to the Google JSON-Key.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:New(AirbaseName, Frequency, Modulation, PathToSRS, Port, GoogleKey) end

---On after "PlayerSpeeding" event.
---
------
---@param self FLIGHTCONTROL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Player FLIGHTGROUP.PlayerData data.
function FLIGHTCONTROL:OnAfterPlayerSpeeding(From, Event, To, Player) end

---On after "RunwayDestroyed" event.
---
------
---@param self FLIGHTCONTROL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function FLIGHTCONTROL:OnAfterRunwayDestroyed(From, Event, To) end

---On after "RunwayRepaired" event.
---
------
---@param self FLIGHTCONTROL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function FLIGHTCONTROL:OnAfterRunwayRepaired(From, Event, To) end

---Event handler for event birth.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventBirth(EventData) end

---Event handling function.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA Event data.
function FLIGHTCONTROL:OnEventCrashOrDead(EventData) end

---Event handler for event engine shutdown.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventEngineShutdown(EventData) end

---Event handler for event engine startup.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventEngineStartup(EventData) end

---Event handler for event kill.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventKill(EventData) end

---Event handler for event land.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventLand(EventData) end

---Event handler for event takeoff.
---
------
---@param self FLIGHTCONTROL 
---@param EventData EVENTDATA 
function FLIGHTCONTROL:OnEventTakeoff(EventData) end

---Triggers the FSM event "PlayerSpeeding".
---
------
---@param self FLIGHTCONTROL 
---@param Player FLIGHTGROUP.PlayerData data.
function FLIGHTCONTROL:PlayerSpeeding(Player) end

---Remove a holding pattern.
---
------
---@param self FLIGHTCONTROL 
---@param HoldingPattern FLIGHTCONTROL.HoldingPattern Holding pattern to be removed.
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:RemoveHoldingPattern(HoldingPattern, self) end

---Remove parking guard.
---
------
---@param self FLIGHTCONTROL 
---@param spot FLIGHTCONTROL.ParkingSpot 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:RemoveParkingGuard(spot, delay) end

---Triggers the FSM event "RunwayDestroyed".
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:RunwayDestroyed() end

---Triggers the FSM event "RunwayRepaired".
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:RunwayRepaired() end

---Set ATIS.
---
------
---@param self FLIGHTCONTROL 
---@param Atis ATIS ATIS.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetATIS(Atis) end

---[User] Set callsign options for TTS output.
---See Wrapper.Group#GROUP.GetCustomCallSign() on how to set customized callsigns.
---
------
---@param self FLIGHTCONTROL 
---@param ShortCallsign boolean If true, only call out the major flight number. Default = `true`.
---@param Keepnumber boolean If true, keep the **customized callsign** in the #GROUP name for players as-is, no amendments or numbers. Default = `true`.
---@param CallsignTranslations table (optional) Table to translate between DCS standard callsigns and bespoke ones. Does not apply if using customized callsigns from playername or group name.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetCallSignOptions(ShortCallsign, Keepnumber, CallsignTranslations) end

---Set flight status.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@param status string New status.
function FLIGHTCONTROL:SetFlightStatus(flight, status) end

---Set the tower frequency.
---
------
---@param self FLIGHTCONTROL 
---@param Frequency number Frequency in MHz. Default 305 MHz.
---@param Modulation number Modulation `radio.modulation.AM`=0, `radio.modulation.FM`=1. Default `radio.modulation.AM`.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetFrequency(Frequency, Modulation) end

---Set time interval between landing clearance of groups.
---
------
---@param self FLIGHTCONTROL 
---@param dt number Time interval in seconds. Default 180 sec (3 min).
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetLandingInterval(dt) end

---Set the number of aircraft groups, that are allowed to land simultaneously.
---Note that this restricts AI and human players.
---
---By default, up to two groups get landing clearance. They are spaced out in time, i.e. after the first one got cleared, the second has to wait a bit.
---This
---
---By default, landing clearance is only given when **no** other flight is taking off. You can adjust this for airports with more than one runway or 
---in cases where simultaneous takeoffs and landings are unproblematic. Note that only because there are multiple runways, it does not mean the AI uses them.
---
------
---@param self FLIGHTCONTROL 
---@param Nlanding number Max number of aircraft landing simultaneously. Default 2.
---@param Ntakeoff number Allowed number of aircraft taking off for groups to get landing clearance. Default 0. 
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetLimitLanding(Nlanding, Ntakeoff) end

---Set the number of **AI** aircraft groups, that are allowed to taxi simultaneously.
---If the limit is reached, other AI groups not get taxi clearance to taxi to the runway.
---
---By default, this only counts the number of AI that taxi from their parking position to the runway.
---You can also include inbound AI that taxi from the runway to their parking position.
---This can be handy for problematic (usually smaller) airdromes, where there is only one taxiway inbound and outbound flights.
---
---By default, AI will not get cleared for taxiing if at least one other flight is currently landing. If this is an unproblematic airdrome, you can 
---also allow groups to taxi if planes are landing, *e.g.* if there are two separate runways.
---
---NOTE that human players are *not* restricted as they should behave better (hopefully) than the AI.
---
------
---@param self FLIGHTCONTROL 
---@param Ntaxi number Max number of groups allowed to taxi. Default 2.
---@param IncludeInbound boolean If `true`, the above
---@param Nlanding number Max number of landing flights. Default 0.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetLimitTaxi(Ntaxi, IncludeInbound, Nlanding) end

---Set to mark the holding patterns on the F10 map.
---
------
---@param self FLIGHTCONTROL 
---@param Switch boolean If `true` (or `nil`), mark holding patterns.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetMarkHoldingPattern(Switch) end

---Set parking spot to FREE and update F10 marker.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot The parking spot data table.
function FLIGHTCONTROL:SetParkingFree(spot) end

---Set the parking guard group.
---This group is used to block (AI) aircraft from taxiing until they get clearance. It should contain of only one unit, *e.g.* a simple soldier.
---
------
---@param self FLIGHTCONTROL 
---@param TemplateGroupName string Name of the template group.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetParkingGuard(TemplateGroupName) end

---Set the parking guard static.
---This static is used to block (AI) aircraft from taxiing until they get clearance.
---
------
---@param self FLIGHTCONTROL 
---@param TemplateStaticName string Name of the template static.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetParkingGuardStatic(TemplateStaticName) end

---Set parking spot to OCCUPIED and update F10 marker.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot The parking spot data table.
---@param unitname string Name of the unit occupying the spot. Default "unknown".
function FLIGHTCONTROL:SetParkingOccupied(spot, unitname) end

---Set parking spot to RESERVED and update F10 marker.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot The parking spot data table.
---@param unitname string Name of the unit occupying the spot. Default "unknown". 
function FLIGHTCONTROL:SetParkingReserved(spot, unitname) end

---Limit radio transmissions only if human players are registered at the airbase.
---This can be used to reduce TTS messages on heavy missions.
---
------
---@param self FLIGHTCONTROL 
---@param Switch boolean If `true` or `nil` no transmission if there are no players. Use `false` enable TTS with no players.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetRadioOnlyIfPlayers(Switch) end

---Set the time until the runway(s) of an airdrome are repaired after it has been destroyed.
---Note that this is the time, the DCS engine uses not something we can control on a user level or we could get via scripting.
---You need to input the value. On the DCS forum it was stated that this is currently one hour. Hence this is the default value.
---
------
---@param self FLIGHTCONTROL 
---@param RepairTime number Time in seconds until the runway is repaired. Default 3600sec (one hour).
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetRunwayRepairtime(RepairTime) end

---Set SRS options for pilot voice.
---
------
---@param self FLIGHTCONTROL 
---@param Gender string Gender: "male" (default) or "female".
---@param Culture string Culture, e.g. "en-US" (default).
---@param Voice string Specific voice. Overrides `Gender` and `Culture`.
---@param Volume number Volume. Default 1.0.
---@param Label string Name under which SRS transmits. Default "Pilot".
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetSRSPilot(Gender, Culture, Voice, Volume, Label) end

---Set the SRS server port.
---
------
---@param self FLIGHTCONTROL 
---@param Port number Port to be used. Defaults to 5002.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetSRSPort(Port) end

---Set SRS options for tower voice.
---
------
---@param self FLIGHTCONTROL 
---@param Gender string Gender: "male" or "female" (default).
---@param Culture string Culture, e.g. "en-GB" (default).
---@param Voice string Specific voice. Overrides `Gender` and `Culture`. See [Google Voices](https://cloud.google.com/text-to-speech/docs/voices).
---@param Volume number Volume. Default 1.0.
---@param Label string Name under which SRS transmits. Default `self.alias`.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetSRSTower(Gender, Culture, Voice, Volume, Label) end

---Set speed limit for taxiing.
---
------
---@param self FLIGHTCONTROL 
---@param SpeedLimit number Speed limit in knots. If `nil`, no speed limit.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetSpeedLimitTaxi(SpeedLimit) end

---Set whether to only transmit TTS messages if there are players on the server.
---
------
---@param self FLIGHTCONTROL 
---@param Switch boolean If `true`, only send TTS messages if there are alive Players. If `false` or `nil`, transmission are done also if no players are on the server.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetTransmitOnlyWithPlayers(Switch) end

---Set verbosity level.
---
------
---@param self FLIGHTCONTROL 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SetVerbosity(VerbosityLevel) end

---Add parking guard in front of a parking aircraft.
---
------
---@param self FLIGHTCONTROL 
---@param unit UNIT The aircraft.
function FLIGHTCONTROL:SpawnParkingGuard(unit) end

---Triggers the FSM event "Start".
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:Start() end

---Triggers the FSM event "StatusUpdate".
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:StatusUpdate() end

---Triggers the FSM event "Stop".
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:Stop() end

---Set subtitles to appear on SRS TTS messages.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SwitchSubtitlesOff() end

---Set subtitles to appear on SRS TTS messages.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:SwitchSubtitlesOn() end

---Text message to group.
---
------
---@param self FLIGHTCONTROL 
---@param Text string The text to transmit.
---@param Flight FLIGHTGROUP The flight.
---@param Duration number Duration in seconds. Default 5.
---@param Clear boolean Clear screen.
---@param Delay number Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TextMessageToFlight(Text, Flight, Duration, Clear, Delay) end

---Radio transmission.
---
------
---@param self FLIGHTCONTROL 
---@param Text string The text to transmit.
---@param Flight FLIGHTGROUP The flight.
---@param Delay number Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TransmissionPilot(Text, Flight, Delay) end

---Radio transmission from tower.
---
------
---@param self FLIGHTCONTROL 
---@param Text string The text to transmit.
---@param Flight FLIGHTGROUP The flight.
---@param Delay number Delay in seconds before the text is transmitted. Default 0 sec.
function FLIGHTCONTROL:TransmissionTower(Text, Flight, Delay) end

---Update parking markers.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot The parking spot data table.
function FLIGHTCONTROL:UpdateParkingMarker(spot) end

---Add a holding pattern.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTCONTROL.HoldingPattern #Holding pattern table.
function FLIGHTCONTROL:_AddHoldingPatternBackup() end

---Check if a flight can get clearance for taxi/takeoff.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight..
---@return boolean #If true, flight can.
function FLIGHTCONTROL:_CheckFlightLanding(flight) end

---Check if a flight can get clearance for taxi/takeoff.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight..
---@return boolean #If true, flight can.
function FLIGHTCONTROL:_CheckFlightTakeoff(flight) end

---Check status of all registered flights and do some sanity checks.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:_CheckFlights() end

---Check holding pattern markers.
---Draw if they should exists and remove if they should not.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:_CheckMarkHoldingPatterns() end

---Check status of all registered flights and do some sanity checks.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:_CheckParking() end

---Check takeoff and landing queues.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:_CheckQueues() end

---Clean text.
---Remove control sequences.
---
------
---@param self FLIGHTCONTROL 
---@param Text string The text.
---@param Cleaned string text.
function FLIGHTCONTROL:_CleanText(Text, Cleaned) end

---Count flights in holding pattern.
---
------
---@param self FLIGHTCONTROL 
---@param Pattern FLIGHTCONTROL.HoldingPattern The pattern.
---@return FLIGHTCONTROL.HoldingStack #Holding point.
function FLIGHTCONTROL:_CountFlightsInPattern(Pattern) end

---Create a new flight group.
---
------
---@param self FLIGHTCONTROL 
---@param group GROUP Aircraft group.
---@return FLIGHTGROUP #Flight group.
function FLIGHTCONTROL:_CreateFlightGroup(group) end

---Create player menu.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@param mainmenu MENU_GROUP ATC root menu table.
function FLIGHTCONTROL:_CreatePlayerMenu(flight, mainmenu) end

---AI flight on final.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:_FlightOnFinal(flight) end

---Get callsign name of a given flight.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@return string #Callsign or "Ghostrider 1-1".
function FLIGHTCONTROL:_GetCallsignName(flight) end

---Get element of flight from its unit name.
---
------
---@param self FLIGHTCONTROL 
---@param unitname string Name of the unit.
---@return OPSGROUP.Element #Element of the flight or nil.
---@return number #Element index or nil.
---@return FLIGHTGROUP #The Flight group or nil.
function FLIGHTCONTROL:_GetFlightElement(unitname) end

---Get flight from group.
---
------
---@param self FLIGHTCONTROL 
---@param group GROUP Group that will be removed from queue.
---@param queue table The queue from which the group will be removed.
---@return FLIGHTGROUP #Flight group or nil.
---@return number #Queue index or nil.
function FLIGHTCONTROL:_GetFlightFromGroup(group, queue) end

---Get free parking spots.
---
------
---@param self FLIGHTCONTROL 
---@param terminal number Terminal type or nil.
---@return number #Number of free spots. Total if terminal=nil or of the requested terminal type.
---@return table #Table of free parking spots of data type #FLIGHCONTROL.ParkingSpot.
function FLIGHTCONTROL:_GetFreeParkingSpots(terminal) end

---Get holding stack.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@return FLIGHTCONTROL.HoldingStack #Holding point.
function FLIGHTCONTROL:_GetHoldingStack(flight) end

---Get next flight waiting for landing clearance.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTGROUP #Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function FLIGHTCONTROL:_GetNextFightHolding() end

---Get next flight waiting for taxi and takeoff clearance.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTGROUP #Marshal flight next in line and ready to enter the pattern. Or nil if no flight is ready.
function FLIGHTCONTROL:_GetNextFightParking() end

---Get next flight in line, either waiting for landing or waiting for takeoff.
---
------
---@param self FLIGHTCONTROL 
---@return FLIGHTGROUP #Flight next in line and ready to enter the pattern. Or nil if no flight is ready.
---@return boolean #If true, flight is holding and waiting for landing, if false, flight is parking and waiting for takeoff.
---@return table #Parking data for holding flights or nil.
function FLIGHTCONTROL:_GetNextFlight() end

---Get parking spot this player was initially spawned on.
---
------
---@param self FLIGHTCONTROL 
---@param UnitName string Name of the player unit.
---@return FLIGHTCONTROL.ParkingSpot #Player spot or nil.
function FLIGHTCONTROL:_GetPlayerSpot(UnitName) end

---Returns the unit of a player and the player name.
---If the unit does not belong to a player, nil is returned.
---
------
---@param self FLIGHTCONTROL 
---@param unitName string Name of the player unit.
---@return UNIT #Unit of player or nil.
---@return string #Name of the player or nil.
function FLIGHTCONTROL:_GetPlayerUnitAndName(unitName) end

---Get text for text-to-speech.
---Numbers are spaced out, e.g. "Heading 180" becomes "Heading 1 8 0 ".
---
------
---@param self FLIGHTCONTROL 
---@param text string Original text.
---@return string #Spoken text.
function FLIGHTCONTROL:_GetTextForSpeech(text) end

---Check if a group is in a queue.
---
------
---@param self FLIGHTCONTROL 
---@param queue table The queue to check.
---@param group GROUP The group to be checked.
---@return boolean #If true, group is in the queue. False otherwise.
function FLIGHTCONTROL:_InQueue(queue, group) end

---Init parking spots.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:_InitParkingSpots() end

---Check if a flight is on a runway
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP 
---@param Runway AIRBASE.Runway or nil.
function FLIGHTCONTROL:_IsFlightOnRunway(flight, Runway) end

---Tell AI to land at the airbase.
---Flight is added to the landing queue.
---
------
---@param self FLIGHTCONTROL 
---@param flight FLIGHTGROUP Flight group.
---@param parking table Free parking spots table.
function FLIGHTCONTROL:_LandAI(flight, parking) end

---Draw marks of holding pattern (if they do not exist.
---
------
---@param self FLIGHTCONTROL 
---@param Pattern FLIGHTCONTROL.HoldingPattern Holding pattern table.
function FLIGHTCONTROL:_MarkHoldingPattern(Pattern) end

---Player aborts holding.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortHolding(groupname) end

---Player aborts inbound.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortInbound(groupname) end

---Player aborts landing.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortLanding(groupname) end

---Player wants to abort takeoff.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortTakeoff(groupname) end

---Player aborts taxi.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerAbortTaxi(groupname) end

---Player arrived at parking position.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerArrived(groupname) end

---Player cancels parking spot reservation.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerCancelParking(groupname) end

---Player confirms landing.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerConfirmLanding(groupname) end

---Player confirm status.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerConfirmStatus(groupname) end

---Player calls holding.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerHolding(groupname) end

---Player info about ATIS.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoATIS(groupname) end

---Player info about airbase.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoAirbase(groupname) end

---Player info about traffic.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerInfoTraffic(groupname) end

---Player menu not implemented.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerNotImplemented(groupname) end

---Player radio check.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRadioCheck(groupname) end

---Player request direct approach.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestDirectLanding(groupname) end

---Player calls inbound.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestInbound(groupname) end

---Player reserves a parking spot.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestParking(groupname) end

---Player requests takeoff.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestTakeoff(groupname) end

---Player requests taxi.
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerRequestTaxi(groupname) end

---Player vector to inbound
---
------
---@param self FLIGHTCONTROL 
---@param groupname string Name of the flight group.
function FLIGHTCONTROL:_PlayerVectorInbound(groupname) end

---Print queue.
---
------
---@param self FLIGHTCONTROL 
---@param queue table Queue to print.
---@param name string Queue name.
---@return string #Queue text.
function FLIGHTCONTROL:_PrintQueue(queue, name) end

---Remove flight from all queues.
---
------
---@param self FLIGHTCONTROL 
---@param Flight FLIGHTGROUP The flight to be removed.
function FLIGHTCONTROL:_RemoveFlight(Flight) end

---Set SRS options for a given MSRS object.
---
------
---@param self FLIGHTCONTROL 
---@param msrs MSRS Moose SRS object.
---@param Gender string Gender: "male" or "female" (default).
---@param Culture string Culture, e.g. "en-GB" (default).
---@param Voice string Specific voice. Overrides `Gender` and `Culture`.
---@param Volume number Volume. Default 1.0.
---@param Label string Name under which SRS transmits.
---@param PathToGoogleCredentials string Path to google credentials json file.
---@param Port number Server port for SRS
---@return FLIGHTCONTROL #self
function FLIGHTCONTROL:_SetSRSOptions(msrs, Gender, Culture, Voice, Volume, Label, PathToGoogleCredentials, Port) end

---[INTERNAL] Add parking guard in front of a parking aircraft - delayed for MP.
---
------
---@param self FLIGHTCONTROL 
---@param unit UNIT The aircraft.
function FLIGHTCONTROL:_SpawnParkingGuard(unit) end

---Removem markers of holding pattern (if they exist).
---
------
---@param self FLIGHTCONTROL 
---@param Pattern FLIGHTCONTROL.HoldingPattern Holding pattern table.
function FLIGHTCONTROL:_UnMarkHoldingPattern(Pattern) end

---Set parking spot to FREE and update F10 marker.
---
------
---@param self FLIGHTCONTROL 
---@param spot AIRBASE.ParkingSpot The parking spot data table.
---@param status string New status.
---@param unitname string Name of the unit.
function FLIGHTCONTROL:_UpdateSpotStatus(spot, status, unitname) end

---Triggers the FSM event "PlayerSpeeding" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
---@param Player FLIGHTGROUP.PlayerData data.
function FLIGHTCONTROL:__PlayerSpeeding(delay, Player) end

---Triggers the FSM event "RunwayDestroyed" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:__RunwayDestroyed(delay) end

---Triggers the FSM event "RunwayRepaired" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:__RunwayRepaired(delay) end

---Triggers the FSM event "Start" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:__Start(delay) end

---Triggers the FSM event "StatusUpdate" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:__StatusUpdate(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param self FLIGHTCONTROL 
---@param delay number Delay in seconds.
function FLIGHTCONTROL:__Stop(delay) end

---On after "RunwayDestroyed" event.
---
------
---@param self FLIGHTCONTROL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function FLIGHTCONTROL:onafterRunwayDestroyed(From, Event, To) end

---On after "RunwayRepaired" event.
---
------
---@param self FLIGHTCONTROL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function FLIGHTCONTROL:onafterRunwayRepaired(From, Event, To) end

---Start FLIGHTCONTROL FSM.
---Handle events.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:onafterStart() end

---Update status.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:onafterStatusUpdate() end

---Stop FLIGHTCONTROL FSM.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:onafterStop() end

---On Before Update status.
---
------
---@param self FLIGHTCONTROL 
function FLIGHTCONTROL:onbeforeStatusUpdate() end


---Flight status.
---@class FLIGHTCONTROL.FlightStatus 
---@field ARRIVED string Flight arrived at parking spot.
---@field HOLDING string Flight is holding.
---@field INBOUND string Flight is inbound.
---@field LANDING string Flight is landing.
---@field PARKING string 
---@field READYTO string Flight is ready for takeoff.
---@field READYTX string Flight is ready to taxi.
---@field TAKEOFF string Flight is taking off.
---@field TAXIINB string Flight is taxiing to parking area.
---@field TAXIOUT string Flight is taxiing to runway for takeoff.
---@field UNKNOWN string Flight is unknown.
FLIGHTCONTROL.FlightStatus = {}


---Holding point.
---Contains holding stacks.
---@class FLIGHTCONTROL.HoldingPattern 
---@field angelsmax number Largest holding alitude in angels.
---@field angelsmin number Smallest holding altitude in angels.
---@field arrivalzone ZONE Zone where aircraft should arrive.
---@field markArrival number Marker ID of the arrival zone.
---@field markArrow number Marker ID of the direction.
---@field name string Name of the zone, which is <zonename>-<uid>.
---@field pos0 COORDINATE First position of racetrack holding pattern.
---@field pos1 COORDINATE Second position of racetrack holding pattern.
---@field uid number Unique ID.
FLIGHTCONTROL.HoldingPattern = {}


---Holding stack.
---@class FLIGHTCONTROL.HoldingStack 
---@field angels number Holding altitude in Angels.
---@field flightgroup FLIGHTGROUP Flight group of this stack.
---@field heading number Heading.
---@field pos0 COORDINATE First position of racetrack holding pattern.
---@field pos1 COORDINATE Second position of racetrack holding pattern.
FLIGHTCONTROL.HoldingStack = {}


---Parking spot data.
---@class FLIGHTCONTROL.ParkingSpot : AIRBASE.ParkingSpot
---@field ParkingGuard GROUP Parking guard for this spot.
FLIGHTCONTROL.ParkingSpot = {}



