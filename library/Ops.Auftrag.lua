---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Auftrag.png" width="100%">
---
---**Ops** - Auftrag (mission) for Ops.
---
---## Main Features:
---
---   * Simplifies defining and executing DCS tasks
---   * Additional useful events
---   * Set mission start/stop times
---   * Set mission priority and urgency (can cancel running missions)
---   * Specific mission options for ROE, ROT, formation, etc.
---   * Compatible with OPS classes like FLIGHTGROUP, NAVYGROUP, ARMYGROUP, AIRWING, etc.
---   * FSM events when a mission is done, successful or failed
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/OPS%20-%20Auftrag).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*A warrior's mission is to foster the success of others.* -- Morihei Ueshiba
---
---===
---
---# The AUFTRAG Concept
---
---The AUFTRAG class significantly simplifies the workflow of using DCS tasks.
---
---You can think of an AUFTRAG as document, which contains the mission briefing, i.e. information about the target location, mission altitude, speed and various other parameters.
---This document can be handed over directly to a pilot (or multiple pilots) via the Ops.FlightGroup#FLIGHTGROUP class. The pilots will then execute the mission.
---
---The AUFTRAG document can also be given to an AIRWING. The airwing will then determine the best assets (pilots and payloads) available for the job.
---
---Similarly, an AUFTRAG can be given to ground or navel groups via the Ops.ArmyGroup#ARMYGROUP or Ops.NavyGroup#NAVYGROUP classes, respectively. These classes have also
---AIRWING analouges, which are called BRIGADE and FLEET. Brigades and fleets will likewise select the best assets they have available and pass on the AUFTRAG to them.
---
---
---One more up the food chain, an AUFTRAG can be passed to a COMMANDER. The commander will recruit the best assets of AIRWINGs, BRIGADEs and/or FLEETs and pass the job over to it.
---
---
---# Airborne Missions
---
---Several mission types are supported by this class.
---
---## Anti-Ship
---
---An anti-ship mission can be created with the #AUFTRAG.NewANTISHIP() function.
---
---## AWACS
---
---An AWACS mission can be created with the #AUFTRAG.NewAWACS() function.
---
---## BAI
---
---A BAI mission can be created with the #AUFTRAG.NewBAI() function.
---
---## Bombing
---
---A bombing mission can be created with the #AUFTRAG.NewBOMBING() function.
---
---## Bombing Runway
---
---A bombing runway mission can be created with the #AUFTRAG.NewBOMBRUNWAY() function.
---
---## Bombing Carpet
---
---A carpet bombing mission can be created with the #AUFTRAG.NewBOMBCARPET() function.
---
---## Strafing
---
---A strafing mission can be created with the #AUFTRAG.NewSTRAFING() function.
---
---## CAP
---
---A CAP mission can be created with the #AUFTRAG.NewCAP() function.
---
---## CAS
---
---A CAS mission can be created with the #AUFTRAG.NewCAS() function.
---
---## Escort
---
---An escort mission can be created with the #AUFTRAG.NewESCORT() function.
---
---## FACA
---
---An FACA mission can be created with the #AUFTRAG.NewFACA() function.
---
---## Ferry
---
---Not implemented yet.
---
---## Ground Escort
---
---An escort mission can be created with the #AUFTRAG.NewGROUNDESCORT() function.
---
---## Intercept
---
---An intercept mission can be created with the #AUFTRAG.NewINTERCEPT() function.
---
---## Orbit
---
---An orbit mission can be created with the #AUFTRAG.NewORBIT() function.
---
---## GCICAP
---
---An patrol mission can be created with the #AUFTRAG.NewGCICAP() function.
---
---## RECON
---
---An reconnaissance mission can be created with the #AUFTRAG.NewRECON() function.
---
---## RESCUE HELO
---
---An rescue helo mission can be created with the #AUFTRAG.NewRESCUEHELO() function.
---
---## SEAD
---
---An SEAD mission can be created with the #AUFTRAG.NewSEAD() function.
---
---## STRIKE
---
---An strike mission can be created with the #AUFTRAG.NewSTRIKE() function.
---
---## Tanker
---
---A refueling tanker mission can be created with the #AUFTRAG.NewTANKER() function.
---
---## TROOPTRANSPORT
---
---A troop transport mission can be created with the #AUFTRAG.NewTROOPTRANSPORT() function.
---
---## CARGOTRANSPORT
---
---A cargo transport mission can be created with the #AUFTRAG.NewCARGOTRANSPORT() function.
---
---## HOVER
---
---A mission for a helicoptre or VSTOL plane to Hover at a point for a certain amount of time can be created with the #AUFTRAG.NewHOVER() function.
---
---# Ground Missions
---
---## ARTY
---
---An arty mission can be created with the #AUFTRAG.NewARTY() function.
---
---## GROUNDATTACK
---
---A ground attack mission can be created with the #AUFTRAG.NewGROUNDATTACK() function.
---
---# Assigning Missions
---
---An AUFTRAG can be assigned to groups (FLIGHTGROUP, ARMYGROUP, NAVYGROUP), legions (AIRWING, BRIGADE, FLEET) or to a COMMANDER.
---
---## Group Level
---
---### Flight Group
---
---Assigning an AUFTRAG to a flight group is done via the Ops.FlightGroup#FLIGHTGROUP.AddMission function. See FLIGHTGROUP docs for details.
---
---### Army Group
---
---Assigning an AUFTRAG to an army group is done via the Ops.ArmyGroup#ARMYGROUP.AddMission function. See ARMYGROUP docs for details.
---
---### Navy Group
---
---Assigning an AUFTRAG to a navy group is done via the Ops.NavyGroup#NAVYGROUP.AddMission function. See NAVYGROUP docs for details.
---
---## Legion Level
---
---Adding an AUFTRAG to an airwing is done via the Ops.Airwing#AIRWING.AddMission function. See AIRWING docs for further details.
---Similarly, an AUFTRAG can be added to a brigade via the Ops.Brigade#BRIGADE.AddMission function.
---
---## Commander Level
---
---Assigning an AUFTRAG to a commander is done via the Ops.Commander#COMMANDER.AddMission function.
---The commander will select the best assets available from all the legions under his command. See COMMANDER docs for details.
---
---## Chief Level
---
--- Assigning an AUFTRAG to a commander is done via the Ops.Chief#CHIEF.AddMission function. The chief will simply pass on the mission to his/her commander.
--- 
---# Transportation
---
---TODO
---
---
---# Events
---
---The AUFTRAG class creates many useful (FSM) events, which can be used in the mission designers script.
---
---TODO
---
---
---# Examples
---
---TODO
---AUFTRAG class.
---@class AUFTRAG : FSM
---@field ClassName string Name of the class.
---@field Nassets number Number of requested warehouse assets.
---@field NassetsMax number Max. number of required warehouse assets.
---@field NassetsMin number Min. number of required warehouse assets.
---@field Nassigned number Number of assigned groups.
---@field NcarriersMax number Max number of required carrier assets.
---@field NcarriersMin number Min number of required carrier assets.
---@field Ncasualties number Number of own casualties during mission.
---@field Ndead number Number of assigned groups that are dead.
---@field Nelements number Number of elements (units) assigned to mission.
---@field NescortMax number Max. number of required escort assets for each group the mission is assigned to.
---@field NescortMin number Min. number of required escort assets for each group the mission is assigned to.
---@field Ngroups number 
---@field Nkills number Number of (enemy) units killed by assets of this mission.
---@field Nrepeat number Number of times the mission is repeated.
---@field NrepeatFailure number Number of times mission is repeated if failed.
---@field NrepeatSuccess number Number of times mission is repeated if successful.
---@field Texecuting number Time stamp (abs) when mission is executing. Is `#nil` on start.
---@field Tover number Mission abs. time stamp, when mission was over.
---@field Tpush number Mission push/execute time in abs. seconds.
---@field TrackAltitude  
---@field TrackFormation  
---@field TrackPoint1  
---@field TrackPoint2  
---@field TrackSpeed  
---@field Tstart number Mission start time in abs. seconds.
---@field Tstarted number Time stamp (abs) when mission is started.
---@field Tstop number Mission stop time in abs. seconds.
---@field alert5MissionType string Alert 5 mission type. This is the mission type, the alerted assets will be able to carry out.
---@field artyAltitude number Altitude in meters. Can be used for a Barrage.
---@field artyAngle number Shooting angle in degrees (for Barrage).
---@field artyHeading number Heading in degrees (for Barrage).
---@field artyRadius number Radius in meters.
---@field artyShots number Number of shots fired.
---@field assetStayAlive  
---@field auftragsnummer number Auftragsnummer.
---@field carrierCategories  
---@field chief CHIEF The CHIEF managing this mission.
---@field commander COMMANDER The COMMANDER managing this mission.
---@field conditionFailureSet boolean 
---@field conditionSuccessSet boolean 
---@field dTevaluate number Time interval in seconds before the mission result is evaluated after mission is over.
---@field duration number Mission duration in seconds.
---@field durationExe number Mission execution time in seconds.
---@field engageAltitude number Engagement altitude in meters.
---@field engageAsGroup boolean Group attack.
---@field engageDirection number Engagement direction in degrees.
---@field engageLength number Length of engage (carpet or strafing) in meters.
---@field engageMaxDistance number Max engage distance.
---@field engageQuantity number Number of times a target is engaged.
---@field engageRange  
---@field engageTarget TARGET Target data to engage.
---@field engageWeaponExpend number How many weapons are used.
---@field engageWeaponType number Weapon type used.
---@field engageZone ZONE_RADIUS *Circular* engagement zone.
---@field engagedetectedEngageZones  
---@field engagedetectedNoEngageZones  
---@field engagedetectedOn boolean 
---@field engagedetectedRmax  
---@field engagedetectedTypes  
---@field escortEngageRange number Engage range in nautical miles (NM).
---@field escortGroup GROUP The group to be escorted.
---@field escortGroupName string Name of the escorted group.
---@field escortMissionType string Escort mission type.
---@field escortVec3 Vec3 The 3D offset vector from the escorted group to the escort group.
---@field facDatalink boolean FAC datalink enabled.
---@field facDesignation number FAC designation type.
---@field facFreq number FAC radio frequency in MHz.
---@field facModu number FAC radio modulation 0=AM 1=FM.
---@field failurecondition boolean 
---@field hoverAltitude  
---@field hoverTime  
---@field icls OPSGROUP.Beacon ICLS setting.
---@field importance number Importance.
---@field legionReturn boolean If `true`, assets return to their legion (default). If `false`, they will stay alive. 
---@field lid string Class id string for output to DCS log file.
---@field marker MARKER F10 map marker.
---@field markerCoaliton number Coalition to which the marker is dispayed.
---@field markerOn boolean If true, display marker on F10 map with the AUFTRAG status.
---@field missionAltitude number Mission altitude in meters.
---@field missionEgressCoord COORDINATE Mission egress waypoint coordinate.
---@field missionEgressCoordAlt  
---@field missionFraction number Mission coordiante fraction. Default is 0.5.
---@field missionHoldingCoord  
---@field missionHoldingCoordAlt  
---@field missionIngressCoord COORDINATE Mission Ingress waypoint coordinate.
---@field missionRange number Mission range in meters. Used by LEGION classes (AIRWING, BRIGADE, ...).
---@field missionSpeed number Mission speed in km/h.
---@field missionTask string Mission task. See `ENUMS.MissionTask`.
---@field missionWaypointCoord COORDINATE Mission waypoint coordinate.
---@field missionWaypointRadius number Random radius in meters.
---@field name string Mission name.
---@field operation OPERATION Operation this mission is part of.
---@field opstransport OPSTRANSPORT OPS transport assignment.
---@field optionAlarm number Alarm state.
---@field optionCM number Counter measures.
---@field optionECM number ECM.
---@field optionEPLRS boolean EPLRS datalink.
---@field optionEmission boolean Emission is on or off.
---@field optionFormation number Formation.
---@field optionImmortal boolean Immortal is on/off.
---@field optionInvisible boolean Invisible is on/off.
---@field optionROE number ROE.
---@field optionROT number ROT.
---@field optionRTBammo number RTB on out-of-ammo.
---@field optionRTBfuel number RTB on out-of-fuel.
---@field orbitAltitude number Orbit altitude in meters.
---@field orbitDeltaR number Distance threshold in meters for moving orbit targets.
---@field orbitHeading number Orbit heading in degrees.
---@field orbitLeg number Length of orbit leg in meters.
---@field orbitOffsetVec2 Vec2 2D offset vector.
---@field orbitSpeed number Orbit speed in m/s.
---@field orbitVec2 Vec2 2D orbit vector.
---@field patroldata AIRWING.PatrolData Patrol data.
---@field prio number Mission priority.
---@field prohibitAB boolean 
---@field prohibitABExecute boolean 
---@field radio OPSGROUP.Radio Radio freq and modulation.
---@field refuelSystem number Refuel type (boom or probe) for TANKER missions.
---@field reinforce  
---@field repeated number Number of times mission was repeated.
---@field repeatedFailure number Number of times mission was repeated after a failure.
---@field repeatedSuccess number Number of times mission was repeated after a success.
---@field status string Mission status.
---@field statusChief string Mission status of the CHIEF.
---@field statusCommander string Mission status of the COMMANDER.
---@field successcondition boolean 
---@field tacan OPSGROUP.Beacon TACAN setting.
---@field targetHeading number Heading of target in degrees.
---@field teleport boolean Groups are teleported to the mission ingress waypoint.
---@field transportDeployZone ZONE Deploy zone of an OPSTRANSPORT.
---@field transportDisembarkZone ZONE Disembark zone of an OPSTRANSPORT.
---@field transportDropoff COORDINATE Coordinate where to drop off the cargo.
---@field transportGroupSet SET_GROUP Groups to be transported.
---@field transportPickup COORDINATE Coordinate where to pickup the cargo.
---@field transportPickupRadius number Radius in meters for pickup zone. Default 500 m.
---@field type string Mission type.
---@field updateDCSTask boolean If `true`, DCS task is updated at every status update of the assigned groups.
---@field urgent boolean Mission is urgent. Running missions with lower prio might be cancelled.
---@field verbose number Verbosity level.
---@field version string AUFTRAG class version.
AUFTRAG = {}

---Add asset to mission.
---
------
---@param self AUFTRAG 
---@param Asset WAREHOUSE.Assetitem The asset to be added to the mission.
---@return AUFTRAG #self
function AUFTRAG:AddAsset(Asset) end

---Add failure condition.
---
------
---@param self AUFTRAG 
---@param ConditionFunction function If this function returns `true`, the mission is cancelled.
---@param ... NOTYPE Condition function arguments if any.
---@return AUFTRAG #self
function AUFTRAG:AddConditionFailure(ConditionFunction, ...) end

---Add push condition.
---
------
---@param self AUFTRAG 
---@param ConditionFunction function If this function returns `true`, the mission is executed.
---@param ... NOTYPE Condition function arguments if any.
---@return AUFTRAG #self
function AUFTRAG:AddConditionPush(ConditionFunction, ...) end

---Add start condition.
---
------
---@param self AUFTRAG 
---@param ConditionFunction function Function that needs to be true before the mission can be started. Must return a #boolean.
---@param ... NOTYPE Condition function arguments if any.
---@return AUFTRAG #self
function AUFTRAG:AddConditionStart(ConditionFunction, ...) end

---Add success condition.
---
------
---@param self AUFTRAG 
---@param ConditionFunction function If this function returns `true`, the mission is cancelled.
---@param ... NOTYPE Condition function arguments if any.
---@return AUFTRAG #self
function AUFTRAG:AddConditionSuccess(ConditionFunction, ...) end

---Add LEGION to mission.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
---@return AUFTRAG #self
function AUFTRAG:AddLegion(Legion) end

---Add a Ops group to the mission.
---
------
---@param self AUFTRAG 
---@param OpsGroup OPSGROUP The OPSGROUP object.
---@return AUFTRAG #self
function AUFTRAG:AddOpsGroup(OpsGroup) end

---Add a required payload for this mission.
---Only these payloads will be used for this mission. If they are not available, the mission cannot start. Only available for use with an AIRWING.
---
------
---@param self AUFTRAG 
---@param Payload AIRWING.Payload Required payload.
---@return AUFTRAG #self
function AUFTRAG:AddRequiredPayload(Payload) end

---Add carriers for a transport of mission assets.
---
------
---@param self AUFTRAG 
---@param Carriers SET_OPSGROUP Set of carriers. Can also be a single group.
---@return AUFTRAG #self
function AUFTRAG:AddTransportCarriers(Carriers) end

---**[LEGION, COMMANDER, CHIEF]** Assign a legion cohort to the mission.
---Only these cohorts will be considered for the job.
---
------
---@param self AUFTRAG 
---@param Cohort COHORT The cohort.
---@return AUFTRAG #self
function AUFTRAG:AssignCohort(Cohort) end

---**[LEGION, COMMANDER, CHIEF]** Assign an escort cohort.
---
------
---@param self AUFTRAG 
---@param Cohort Cohort The cohort.
function AUFTRAG:AssignEscortCohort(Cohort) end

---**[LEGION, COMMANDER, CHIEF]** Add an escort Legion.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
function AUFTRAG:AssignEscortLegion(Legion) end

---**[LEGION, COMMANDER, CHIEF]** Assign a legion to the mission.
---Only cohorts of this legion will be considered for the job. You can assign multiple legions.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
---@return AUFTRAG #self
function AUFTRAG:AssignLegion(Legion) end

---**[LEGION, COMMANDER, CHIEF]** Assign airwing squadron(s) to the mission.
---Only these squads will be considered for the job.
---
------
---@param self AUFTRAG 
---@param Squadrons table A table of SQUADRON(s). **Has to be a table {}** even if a single squad is given.
---@return AUFTRAG #self
function AUFTRAG:AssignSquadrons(Squadrons) end

---**[LEGION, COMMANDER, CHIEF]** Assign a transport cohort.
---
------
---@param self AUFTRAG 
---@param Cohort Cohort The cohort.
function AUFTRAG:AssignTransportCohort(Cohort) end

---**[LEGION, COMMANDER, CHIEF]** Assign a transport Legion.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
function AUFTRAG:AssignTransportLegion(Legion) end

---Triggers the FSM event "Cancel".
---
------
---@param self AUFTRAG 
function AUFTRAG:Cancel() end

---Check if all groups are done with their mission (or dead).
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, all groups are done with the mission.
function AUFTRAG:CheckGroupsDone() end

---Check if a mission type is contained in a list of possible capabilities.
---
------
---@param MissionTypes table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@param All boolean If `true`, given mission type must be includedin ALL capabilities. If `false` or `nil`, it must only match one.
---@return boolean #If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapability(MissionTypes, Capabilities, All) end

---Check if a mission type is contained in a list of possible capabilities.
---
------
---@param MissionTypes table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@return boolean #If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapabilityAll(MissionTypes, Capabilities) end

---Check if a mission type is contained in a list of possible capabilities.
---
------
---@param MissionTypes table The requested mission type. Can also be passed as a single mission type `#string`.
---@param Capabilities table A table with possible capabilities `Ops.Auftrag#AUFTRAG.Capability`.
---@return boolean #If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionCapabilityAny(MissionTypes, Capabilities) end

---Checks if a mission type is contained in a table of possible types.
---
------
---@param MissionType string The requested mission type.
---@param PossibleTypes table A table with possible mission types.
---@return boolean #If true, the requested mission type is part of the possible mission types.
function AUFTRAG.CheckMissionType(MissionType, PossibleTypes) end

---Count alive mission targets.
---
------
---@param self AUFTRAG 
---@return number #Number of alive target units.
function AUFTRAG:CountMissionTargets() end

---Count alive OPS groups assigned for this mission.
---
------
---@param self AUFTRAG 
---@return number #Number of alive OPS groups.
function AUFTRAG:CountOpsGroups() end

---Count OPS groups in a certain status.
---
------
---@param self AUFTRAG 
---@param Status string Status of group, e.g. `AUFTRAG.GroupStatus.EXECUTING`.
---@return number #Number of alive OPS groups.
function AUFTRAG:CountOpsGroupsInStatus(Status) end

---Delete asset from mission.
---
------
---@param self AUFTRAG 
---@param Asset WAREHOUSE.Assetitem  The asset to be removed.
---@return AUFTRAG #self
function AUFTRAG:DelAsset(Asset) end

---Remove an Ops group from the mission.
---
------
---@param self AUFTRAG 
---@param OpsGroup OPSGROUP The OPSGROUP object.
---@return AUFTRAG #self
function AUFTRAG:DelOpsGroup(OpsGroup) end

---Triggers the FSM event "Done".
---
------
---@param self AUFTRAG 
function AUFTRAG:Done() end

---Check if all given condition are true.
---
------
---@param self AUFTRAG 
---@param Conditions table Table of conditions.
---@return boolean #If true, all conditions were true. Returns false if at least one condition returned false.
function AUFTRAG:EvalConditionsAll(Conditions) end

---Check if any of the given conditions is true.
---
------
---@param self AUFTRAG 
---@param Conditions table Table of conditions.
---@return boolean #If true, at least one condition is true.
function AUFTRAG:EvalConditionsAny(Conditions) end

---Evaluate mission outcome - success or failure.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:Evaluate() end

---Triggers the FSM event "Executing".
---
------
---@param self AUFTRAG 
function AUFTRAG:Executing() end

---Triggers the FSM event "Failed".
---
------
---@param self AUFTRAG 
function AUFTRAG:Failed() end

---Get asset by its spawn group name.
---
------
---@param self AUFTRAG 
---@param Name string Asset spawn group name.
---@return WAREHOUSE.Assetitem #Asset.
function AUFTRAG:GetAssetByName(Name) end

---Get asset data table.
---
------
---@param self AUFTRAG 
---@param AssetName string Name of the asset.
---@return AUFTRAG.GroupData #Group data or *nil* if OPS group does not exist.
function AUFTRAG:GetAssetDataByName(AssetName) end

---Get casualties, *i.e.* number of own units that died during this mission.
---
------
---@param self AUFTRAG 
---@return number #Number of dead units.
function AUFTRAG:GetCasualties() end

---Get DCS task table for the given mission.
---
------
---@param self AUFTRAG 
---@return Task #The DCS task table. If multiple tasks are necessary, this is returned as a combo task.
function AUFTRAG:GetDCSMissionTask() end

---Get flight data table.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The flight group.
---@return AUFTRAG.GroupData #Flight data or nil if opsgroup does not exist.
function AUFTRAG:GetGroupData(opsgroup) end

---Get Egress waypoint UID of OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@return number #Waypoint UID.
function AUFTRAG:GetGroupEgressWaypointUID(opsgroup) end

---Get ops group mission status.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@return string #The group status.
function AUFTRAG:GetGroupStatus(opsgroup) end

---Get mission (ingress) waypoint coordinate of OPS group
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@return COORDINATE #Waypoint Coordinate.
function AUFTRAG:GetGroupWaypointCoordinate(opsgroup) end

---Get mission (ingress) waypoint UID of OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@return number #Waypoint UID.
function AUFTRAG:GetGroupWaypointIndex(opsgroup) end

---Get mission waypoint task of OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@return OPSGROUP.Task #task Waypoint task. Waypoint task.
function AUFTRAG:GetGroupWaypointTask(opsgroup) end

---Get mission importance.
---
------
---@param self AUFTRAG 
---@return number #Importance. Smaller is higher.
function AUFTRAG:GetImportance() end

---Get kills, i.e.
---number of units that were destroyed by assets of this mission.
---
------
---@param self AUFTRAG 
---@return number #Number of units destroyed.
function AUFTRAG:GetKills() end

---Get LEGION mission status.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
---@return string #status Current status.
function AUFTRAG:GetLegionStatus(Legion) end

---Get the mission egress coordinate if this was defined.
---
------
---@param self AUFTRAG 
---@return COORDINATE #Coordinate Coordinate or nil.
function AUFTRAG:GetMissionEgressCoord() end

---Get the mission holding coordinate if this was defined.
---
------
---@param self AUFTRAG 
---@return COORDINATE #Coordinate Coordinate or nil.
function AUFTRAG:GetMissionHoldingCoord() end

---Get the mission ingress coordinate if this was defined.
---
------
---@param self AUFTRAG 
---@return COORDINATE #Coordinate Coordinate or nil.
function AUFTRAG:GetMissionIngressCoord() end

---Get DCS task table for an attack group or unit task.
---
------
---@param self AUFTRAG 
---@param MissionType string Mission (AUFTAG) type.
---@return string #DCS mission task for the auftrag type.
function AUFTRAG:GetMissionTaskforMissionType(MissionType) end

---Get coordinate of target.
---First unit/group of the set is used.
---
------
---@param self AUFTRAG 
---@param MissionTypes table A table of mission types.
---@return string #Comma separated list of mission types.
function AUFTRAG:GetMissionTypesText(MissionTypes) end

---Get coordinate of target.
---First unit/group of the set is used.
---
------
---@param self AUFTRAG 
---@param group GROUP Group.
---@param randomradius number Random radius in meters.
---@param surfacetypes table Surface types of random zone.
---@return COORDINATE #Coordinate where the mission is executed.
function AUFTRAG:GetMissionWaypointCoord(group, randomradius, surfacetypes) end

---Get mission name.
---
------
---@param self AUFTRAG 
---@return string #Mission name, e.g. "Auftrag Nr.1".
function AUFTRAG:GetName() end

---Get number of required assets.
---
------
---@param self AUFTRAG 
---@return number #Numer of required assets.
function AUFTRAG:GetNumberOfRequiredAssets() end

---Get mission objective object.
---Could be many things depending on the mission type.
---
------
---@param self AUFTRAG 
---@param RefCoordinate COORDINATE (Optional) Reference coordinate from which the closest target is determined.
---@param Coalitions table (Optional) Only consider targets of the given coalition(s). 
---@return POSITIONABLE #The target object. Could be many things.
function AUFTRAG:GetObjective(RefCoordinate, Coalitions) end

---Get all OPS groups.
---
------
---@param self AUFTRAG 
---@return table #Table of Ops.OpsGroup#OPSGROUP or {}.
function AUFTRAG:GetOpsGroups() end

---Get the attach OPS transport of the mission.
---
------
---@param self AUFTRAG 
---@return OPSTRANSPORT #The OPS transport assignment attached to the mission.
function AUFTRAG:GetOpsTransport() end

---Get mission priority.
---
------
---@param self AUFTRAG 
---@return number #Priority. Smaller is higher.
function AUFTRAG:GetPriority() end

---**[LEGION, COMMANDER, CHIEF]** Get number of required assets.
---
------
---@param self AUFTRAG 
---@return number #Min. number of required assets.
---@return number #Max. number of required assets.
function AUFTRAG:GetRequiredAssets() end

---Get coordinate of target.
---
------
---@param self AUFTRAG 
---@return COORDINATE #The target coordinate or *nil*.
function AUFTRAG:GetTargetCoordinate() end

---Get target damage.
---
------
---@param self AUFTRAG 
---@return number #Damage in percent.
function AUFTRAG:GetTargetDamage() end

---Get target.
---
------
---@param self AUFTRAG 
---@return TARGET #The target object. Could be many things.
function AUFTRAG:GetTargetData() end

---Get distance to target.
---
------
---@param self AUFTRAG 
---@param FromCoord COORDINATE The coordinate from which the distance is measured.
---@return number #Distance in meters or 0.
function AUFTRAG:GetTargetDistance(FromCoord) end

---Get heading of target.
---
------
---@param self AUFTRAG 
---@return number #Heading of target in degrees.
function AUFTRAG:GetTargetHeading() end

---Get target life points.
---
------
---@param self AUFTRAG 
---@return number #Number of initial life points when mission was planned.
function AUFTRAG:GetTargetInitialLife() end

---Get initial number of targets.
---
------
---@param self AUFTRAG 
---@return number #Number of initial life points when mission was planned.
function AUFTRAG:GetTargetInitialNumber() end

---Get target life points.
---
------
---@param self AUFTRAG 
---@return number #Life points of target.
function AUFTRAG:GetTargetLife() end

---Get name of the target.
---
------
---@param self AUFTRAG 
---@return string #Name of the target or "N/A".
function AUFTRAG:GetTargetName() end

---Get type of target.
---
------
---@param self AUFTRAG 
---@return string #The target type.
function AUFTRAG:GetTargetType() end

---Get 2D vector of target.
---
------
---@param self AUFTRAG 
---@return VEC2 #The target 2D vector or *nil*.
function AUFTRAG:GetTargetVec2() end

---Get mission type.
---
------
---@param self AUFTRAG 
---@return string #Mission type, e.g. "BAI".
function AUFTRAG:GetType() end

---Check if mission is for aircarft (airplanes and/or helicopters).
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is for aircraft.
function AUFTRAG:IsAircraft() end

---Check if mission is for airplanes.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is for airplanes.
function AUFTRAG:IsAirplane() end

---Check if mission was cancelled.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission was cancelled.
function AUFTRAG:IsCancelled() end

---Check if mission is done.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is done.
function AUFTRAG:IsDone() end

---Check if mission is EXECUTING.
---The first OPSGROUP has reached the mission execution waypoint and is not executing the mission task.
---
------
---@param self AUFTRAG 
---@param AllGroups boolean (Optional) Check that all groups are currently executing the mission.
---@return boolean #If true, mission is currently executing.
function AUFTRAG:IsExecuting(AllGroups) end

---Check if mission is for ground units.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is for ground units.
function AUFTRAG:IsGround() end

---Check if mission is for helicopters.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is for helicopters.
function AUFTRAG:IsHelicopters() end

---Check if mission is for naval units.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is for naval units.
function AUFTRAG:IsNaval() end

---Check if mission is NOT over.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is NOT over yet.
function AUFTRAG:IsNotOver() end

---Check if mission is over.
---This could be state DONE, CANCELLED, SUCCESS, FAILED.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is over.
function AUFTRAG:IsOver() end

---Check if mission is PLANNED.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is in the planning state.
function AUFTRAG:IsPlanned() end

---Check if mission is QUEUED at a LEGION mission queue.
---
------
---@param self AUFTRAG 
---@param Legion LEGION (Optional) Check if mission is queued at this legion.
---@return boolean #If true, mission is queued.
function AUFTRAG:IsQueued(Legion) end

---Check if mission is ready to be cancelled.
---* Mission stop already passed.
---* Any stop condition is true.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission should be cancelled.
function AUFTRAG:IsReadyToCancel() end

---Check if mission is ready to be started.
---* Mission start time passed.
---* Mission stop time did not pass already.
---* All start conditions are true.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission can be started.
function AUFTRAG:IsReadyToGo() end

---Check if mission is ready to be pushed.
---* Mission push time already passed.
---* **All** push conditions are true.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission groups can push.
function AUFTRAG:IsReadyToPush() end

---Check if mission is REQUESTED.
---The mission request out to the WAREHOUSE.
---
------
---@param self AUFTRAG 
---@param Legion LEGION (Optional) Check if mission is requested at this legion.
---@return boolean #If true, mission is requested.
function AUFTRAG:IsRequested(Legion) end

---Check if mission is SCHEDULED.
---The first OPSGROUP has been assigned.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is queued.
function AUFTRAG:IsScheduled() end

---Check if mission is STARTED.
---The first OPSGROUP is on its way to the mission execution waypoint.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission is started.
function AUFTRAG:IsStarted() end

---Check if mission was a success.
---
------
---@param self AUFTRAG 
---@return boolean #If true, mission was successful.
function AUFTRAG:IsSuccess() end

---Check if mission is "urgent".
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, mission is "urgent".
function AUFTRAG:IsUrgent() end

---Create a new generic AUFTRAG object.
---
------
---@param self AUFTRAG 
---@param Type string Mission type.
---@return AUFTRAG #self
function AUFTRAG:New(Type) end

---**[GROUND, NAVAL]** Create an AIRDEFENSE mission.
---
------
---@param self AUFTRAG 
---@param Zone ZONE Zone where the air defense group(s) should be stationed.
---@return AUFTRAG #self
function AUFTRAG:NewAIRDEFENSE(Zone) end

---**[AIR]** Create an ALERT 5 mission.
---Aircraft will be spawned uncontrolled and wait for an assignment. You must specify **one** mission type which is performed.
---This determines the payload and the DCS mission task which are used when the aircraft is spawned.
---
------
---@param self AUFTRAG 
---@param MissionType string Mission type `AUFTRAG.Type.XXX`. Determines payload and mission task (intercept, ground attack, etc.).
---@return AUFTRAG #self
function AUFTRAG:NewALERT5(MissionType) end

---**[GROUND]** Create a AMMO SUPPLY mission.
---
------
---@param self AUFTRAG 
---@param Zone ZONE The zone, where supply units go.
---@return AUFTRAG #self
function AUFTRAG:NewAMMOSUPPLY(Zone) end

---**[AIR]** Create an ANTI-SHIP mission.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE The target to attack. Can be passed as a @{Wrapper.Group#GROUP} or @{Wrapper.Unit#UNIT} object.
---@param Altitude number Engage altitude in feet. Default 2000 ft.
---@return AUFTRAG #self
function AUFTRAG:NewANTISHIP(Target, Altitude) end

---**[OBSOLETE]** Create a ARMORATTACK mission.
---** Note that this is actually creating a GROUNDATTACK mission!**
---
------
---@param self AUFTRAG 
---@param Target TARGET The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Speed number Speed in knots.
---@param Formation string The attack formation, e.g. "Wedge", "Vee" etc.
---@return AUFTRAG #self
function AUFTRAG:NewARMORATTACK(Target, Speed, Formation) end

---**[GROUND]** Create an ARMORED ON GUARD mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Coordinate, where to stand guard.
---@param Formation string Formation to take, e.g. "On Road", "Vee" etc.
---@return AUFTRAG #self
function AUFTRAG:NewARMOREDGUARD(Coordinate, Formation) end

---**[GROUND, NAVAL]** Create an ARTY mission ("Fire at point" task).
---
---If the group has more than one weapon type supporting the "Fire at point" task, the employed weapon type can be set via the `AUFTRAG:SetWeaponType()` function.
---
---**Note** that it is recommended to set the weapon range via the `OPSGROUP:AddWeaponRange()` function as this cannot be retrieved from the DCS API.
---
------
---@param self AUFTRAG 
---@param Target COORDINATE Center of the firing solution.
---@param Nshots number Number of shots to be fired. Default `#nil`.
---@param Radius number Radius of the shells in meters. Default 100 meters.
---@param Altitude number Altitude in meters. Can be used to setup a Barrage. Default `#nil`.
---@return AUFTRAG #self
function AUFTRAG:NewARTY(Target, Nshots, Radius, Altitude) end

---Create a mission to attack a group.
---Mission type is automatically chosen from the group category.
---
------
---@param self AUFTRAG 
---@param EngageGroup GROUP Group to be engaged.
---@return AUFTRAG #self
function AUFTRAG:NewAUTO(EngageGroup) end

---**[AIR]** Create a AWACS mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to orbit. Altitude is also taken from the coordinate.
---@param Altitude number Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed number Orbit speed in knots. Default 350 kts.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 10 NM.
---@return AUFTRAG #self
function AUFTRAG:NewAWACS(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR]** Create a BAI mission.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Altitude number Engage altitude in feet. Default 5000 ft.
---@return AUFTRAG #self
function AUFTRAG:NewBAI(Target, Altitude) end

---**[GROUND, NAVAL]** Create an BARRAGE mission.
---Assigned groups will move to a random coordinate within a given zone and start firing into the air.
---
------
---@param self AUFTRAG 
---@param Zone ZONE The zone where the unit will go.
---@param Heading number Heading in degrees. Default random heading [0, 360).
---@param Angle number Shooting angle in degrees. Default random [45, 85].
---@param Radius number Radius of the shells in meters. Default 100 meters.
---@param Altitude number Altitude in meters. Default 500 m.
---@param Nshots number Number of shots to be fired. Default is until ammo is empty (`#nil`).
---@return AUFTRAG #self
function AUFTRAG:NewBARRAGE(Zone, Heading, Angle, Radius, Altitude, Nshots) end

---**[AIR]** Create a CARPET BOMBING mission.
---
------
---@param self AUFTRAG 
---@param Target COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT or STATIC object.
---@param Altitude number Engage altitude in feet. Default 25000 ft.
---@param CarpetLength number Length of bombing carpet in meters. Default 500 m.
---@return AUFTRAG #self
function AUFTRAG:NewBOMBCARPET(Target, Altitude, CarpetLength) end

---**[AIR]** Create a BOMBING mission.
---Flight will drop bombs a specified coordinate.
---See [DCS task bombing](https://wiki.hoggitworld.com/view/DCS_task_bombing).
---
------
---@param self AUFTRAG 
---@param Target COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT, STATIC, SET_GROUP, SET_UNIT, SET_STATIC or TARGET object.
---@param Altitude number Engage altitude in feet. Default 25000 ft.
---@param EngageWeaponType number Which weapon to use. Defaults to auto, ie ENUMS.WeaponFlag.Auto. See ENUMS.WeaponFlag for options.
---@return AUFTRAG #self
function AUFTRAG:NewBOMBING(Target, Altitude, EngageWeaponType) end

---**[AIR]** Create a BOMBRUNWAY mission.
---
------
---@param self AUFTRAG 
---@param Airdrome AIRBASE The airbase to bomb. This must be an airdrome (not a FARP or ship) as these do not have a runway.
---@param Altitude number Engage altitude in feet. Default 25000 ft.
---@return AUFTRAG #self
function AUFTRAG:NewBOMBRUNWAY(Airdrome, Altitude) end

---**[AIR]** Create a CAP mission.
---
------
---@param self AUFTRAG 
---@param ZoneCAP ZONE_RADIUS Circular CAP zone. Detected targets in this zone will be engaged.
---@param Altitude number Altitude at which to orbit in feet. Default is 10,000 ft.
---@param Speed number Orbit speed in knots. Default 350 kts.
---@param Coordinate COORDINATE Where to orbit. Default is the center of the CAP zone.
---@param Heading number Heading of race-track pattern in degrees. If not specified, a simple circular orbit is performed.
---@param Leg number Length of race-track in NM. If not specified, a simple circular orbit is performed.
---@param TargetTypes table Table of target types. Default {"Air"}.
---@return AUFTRAG #self
function AUFTRAG:NewCAP(ZoneCAP, Altitude, Speed, Coordinate, Heading, Leg, TargetTypes) end

---**[AIR]** Create a CAP mission over a (moving) group.
---
------
---@param self AUFTRAG 
---@param Grp GROUP The grp to perform the CAP over.
---@param Altitude number Orbit altitude in feet. Default is 6,000 ft.
---@param Speed number Orbit speed in knots. Default 250 KIAS.
---@param RelHeading number Relative heading [0, 360) of race-track pattern in degrees wrt heading of the carrier. Default is heading of the carrier.
---@param Leg number Length of race-track in NM. Default 14 NM.
---@param OffsetDist number Relative distance of the first race-track point wrt to the carrier. Default 6 NM.
---@param OffsetAngle number Relative angle of the first race-track point wrt. to the carrier. Default 180 (behind the boat).
---@param UpdateDistance number Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@param TargetTypes table (Optional) Table of target types. Default `{"Air"}`.
---@param EngageRange number Max range in nautical miles that the escort group(s) will engage enemies. Default 32 NM (60 km).
---@return AUFTRAG #self
function AUFTRAG:NewCAPGROUP(Grp, Altitude, Speed, RelHeading, Leg, OffsetDist, OffsetAngle, UpdateDistance, TargetTypes, EngageRange) end

---**[AIR, GROUND, NAVAL]** Create a CAPTUREZONE mission.
---Group(s) will go to the zone and patrol it randomly.
---
------
---@param self AUFTRAG 
---@param OpsZone OPSZONE The OPS zone to capture.
---@param Coalition number The coalition which should capture the zone for the mission to be successful.
---@param Speed number Speed in knots.
---@param Altitude number Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Formation string Formation used by ground units during patrol. Default "Off Road".
---@return AUFTRAG #self
function AUFTRAG:NewCAPTUREZONE(OpsZone, Coalition, Speed, Altitude, Formation) end

---**[AIR ROTARY]** Create a CARGO TRANSPORT mission.
---**Important Note:**
---The dropoff zone has to be a zone defined in the Mission Editor. This is due to a restriction in the used DCS task, which takes the zone ID as input.
---Only ME zones have an ID that can be referenced.
---
------
---@param self AUFTRAG 
---@param StaticCargo STATIC Static cargo object.
---@param DropZone ZONE Zone where to drop off the cargo. **Has to be a zone defined in the ME!**
---@return AUFTRAG #self
function AUFTRAG:NewCARGOTRANSPORT(StaticCargo, DropZone) end

---**[AIR]** Create a CAS mission.
---
------
---@param self AUFTRAG 
---@param ZoneCAS ZONE_RADIUS Circular CAS zone. Detected targets in this zone will be engaged.
---@param Altitude number Altitude at which to orbit. Default is 10,000 ft.
---@param Speed number Orbit speed in knots. Default 350 KIAS.
---@param Coordinate COORDINATE Where to orbit. Default is the center of the CAS zone.
---@param Heading number Heading of race-track pattern in degrees. If not specified, a simple circular orbit is performed.
---@param Leg number Length of race-track in NM. If not specified, a simple circular orbit is performed.
---@param TargetTypes table (Optional) Table of target types. Default `{"Helicopters", "Ground Units", "Light armed ships"}`.
---@return AUFTRAG #self
function AUFTRAG:NewCAS(ZoneCAS, Altitude, Speed, Coordinate, Heading, Leg, TargetTypes) end

---**[AIR]** Create a CASENHANCED mission.
---Group(s) will go to the zone and patrol it randomly.
---
------
---@param self AUFTRAG 
---@param CasZone ZONE The CAS zone.
---@param Altitude number Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Speed number Speed in knots.
---@param RangeMax number Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@param NoEngageZoneSet SET_ZONE Set of zones in which targets are *not* engaged. Default is nowhere.
---@param TargetTypes table Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default `{"Helicopters", "Ground Units", "Light armed ships"}`.
---@return AUFTRAG #self
function AUFTRAG:NewCASENHANCED(CasZone, Altitude, Speed, RangeMax, NoEngageZoneSet, TargetTypes) end

---**[AIR]** Create an ESCORT (or FOLLOW) mission.
---Flight will escort another group and automatically engage certain target types.
---
------
---@param self AUFTRAG 
---@param EscortGroup GROUP The group to escort.
---@param OffsetVector Vec3 A table with x, y and z components specifying the offset of the flight to the escorted group. Default {x=-100, y=0, z=200} for z=200 meters to the right, same alitude (y=0), x=-100 meters behind.
---@param EngageMaxDistance number Max engage distance of targets in nautical miles. Default auto 32 NM.
---@param TargetTypes table Types of targets to engage automatically. Default is {"Air"}, i.e. all enemy airborne units. Use an empty set {} for a simple "FOLLOW" mission.
---@return AUFTRAG #self
function AUFTRAG:NewESCORT(EscortGroup, OffsetVector, EngageMaxDistance, TargetTypes) end

---**[GROUND]** Create an EWR mission.
---
------
---@param self AUFTRAG 
---@param Zone ZONE Zone where the Early Warning Radar group(s) should be stationed.
---@return AUFTRAG #self
function AUFTRAG:NewEWR(Zone) end

---**[AIR, GROUND]** Create a FAC mission.
---Group(s) will go to the zone and patrol it randomly and act as FAC for detected units.
---
------
---@param self AUFTRAG 
---@param FacZone ZONE The FAC zone (or name of zone) where to patrol.
---@param Speed number Speed in knots.
---@param Altitude number Altitude in feet. Only for airborne units. Default 2000 feet ASL. 
---@param Frequency number Frequency in MHz.
---@param Modulation number Modulation.
---@return AUFTRAG #self
function AUFTRAG:NewFAC(FacZone, Speed, Altitude, Frequency, Modulation) end

---**[AIR]** Create a FACA mission.
---
------
---@param self AUFTRAG 
---@param Target GROUP Target group. Must be a GROUP object.
---@param Designation string Designation of target. See `AI.Task.Designation`. Default `AI.Task.Designation.AUTO`.
---@param DataLink boolean Enable data link. Default `true`.
---@param Frequency number Radio frequency in MHz the FAC uses for communication. Default is 133 MHz.
---@param Modulation number Radio modulation band. Default 0=AM. Use 1 for FM. See radio.modulation.AM or radio.modulaton.FM.
---@return AUFTRAG #self
function AUFTRAG:NewFACA(Target, Designation, DataLink, Frequency, Modulation) end

---**[GROUND]** Create a FUEL SUPPLY mission.
---
------
---@param self AUFTRAG 
---@param Zone ZONE The zone, where supply units go.
---@return AUFTRAG #self
function AUFTRAG:NewFUELSUPPLY(Zone) end

---Create a mission to attack a TARGET object.
---
------
---@param self AUFTRAG 
---@param Target TARGET The target.
---@param MissionType string The mission type.
---@return AUFTRAG #self
function AUFTRAG:NewFromTarget(Target, MissionType) end

---**[AIR]** Create a Ground Controlled CAP (GCICAP) mission.
---Flights with this task are considered for A2A INTERCEPT missions by the CHIEF class. They will perform a combat air patrol but not engage by
---themselfs. They wait for the CHIEF to tell them whom to engage.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to orbit.
---@param Altitude number Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading number Heading of race-track pattern in degrees. Default random in [0, 360) degrees.
---@param Leg number Length of race-track in NM. Default 10 NM.
---@return AUFTRAG #self
function AUFTRAG:NewGCICAP(Coordinate, Altitude, Speed, Heading, Leg) end

---**[GROUND]** Create a GROUNDATTACK mission.
---Ground group(s) will go to a target object and attack.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE The target to attack. Can be a GROUP, UNIT or STATIC object.
---@param Speed number Speed in knots. Default max.
---@param Formation string The attack formation, e.g. "Wedge", "Vee" etc. Default `ENUMS.Formation.Vehicle.Vee`.
---@return AUFTRAG #self
function AUFTRAG:NewGROUNDATTACK(Target, Speed, Formation) end

---**[AIR/HELO]** Create a GROUNDESCORT (or FOLLOW) mission.
---Helo will escort a **ground** group and automatically engage certain target types.
---
------
---@param self AUFTRAG 
---@param EscortGroup GROUP The ground group to escort.
---@param OrbitDistance number Orbit to/from the lead unit this many NM. Defaults to 1.5 NM.
---@param TargetTypes table Types of targets to engage automatically. Default is {"Ground vehicles"}, i.e. all enemy ground units. Use an empty set {} for a simple "FOLLOW" mission.
---@return AUFTRAG #self
function AUFTRAG:NewGROUNDESCORT(EscortGroup, OrbitDistance, TargetTypes) end

---**[AIR ROTARY]** Create an HOVER mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to hover.
---@param Altitude number Hover altitude in feet AGL. Default is 50 feet above ground.
---@param Time number Time in seconds to hold the hover. Default 300 seconds.
---@param Speed number Speed in knots to fly to the target coordinate. Default 150kn.
---@param MissionAlt number Altitude to fly towards the mission in feet AGL. Default 1000ft.
---@return AUFTRAG #self
function AUFTRAG:NewHOVER(Coordinate, Altitude, Time, Speed, MissionAlt) end

---**[AIR]** Create an INTERCEPT mission.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE The target to intercept. Can also be passed as simple @{Wrapper.Group#GROUP} or @{Wrapper.Unit#UNIT} object.
---@return AUFTRAG #self
function AUFTRAG:NewINTERCEPT(Target) end

---**[AIR ROTARY]** Create an LANDATCOORDINATE mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to land.
---@param OuterRadius number (Optional) Vary the coordinate by this many feet, e.g. get a new random coordinate between OuterRadius and (optionally) avoiding InnerRadius of the coordinate.
---@param InnerRadius number (Optional) Vary the coordinate by this many feet, e.g. get a new random coordinate between OuterRadius and (optionally) avoiding InnerRadius of the coordinate.
---@param Time number Time in seconds to stay. Default 300 seconds.
---@param Speed number Speed in knots to fly to the target coordinate. Default 150kn.
---@param MissionAlt number Altitude to fly towards the mission in feet AGL. Default 1000ft.
---@param CombatLanding boolean (Optional) If true, set the Combat Landing option.
---@param DirectionAfterLand number (Optional) Heading after landing in degrees.
---@return AUFTRAG #self
function AUFTRAG:NewLANDATCOORDINATE(Coordinate, OuterRadius, InnerRadius, Time, Speed, MissionAlt, CombatLanding, DirectionAfterLand) end

---**[GROUND, NAVAL]** Create a mission to do NOTHING.
---
------
---@param self AUFTRAG 
---@param RelaxZone ZONE Zone where the assets are supposed to do nothing.
---@return AUFTRAG #self
function AUFTRAG:NewNOTHING(RelaxZone) end

---**[GROUND, NAVAL]** Create an ON GUARD mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Coordinate, where to stand guard.
---@return AUFTRAG #self
function AUFTRAG:NewONGUARD(Coordinate) end

---**[AIR]** Create an ORBIT mission, which can be either a circular orbit or a race-track pattern.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to orbit.
---@param Altitude number Orbit altitude in feet above sea level. Default is y component of `Coordinate`.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading number Heading of race-track pattern in degrees. If not specified, a circular orbit is performed.
---@param Leg number Length of race-track in NM. If not specified, a circular orbit is performed.
---@return AUFTRAG #self
function AUFTRAG:NewORBIT(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR]** Create an ORBIT mission, where the aircraft will go in a circle around the specified coordinate.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Position where to orbit around.
---@param Altitude number Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@return AUFTRAG #self
function AUFTRAG:NewORBIT_CIRCLE(Coordinate, Altitude, Speed) end

---**[AIR]** Create an ORBIT mission, where the aircraft will fly a circular or race-track pattern over a given group or unit.
---
------
---@param self AUFTRAG 
---@param Group GROUP Group where to orbit around. Can also be a UNIT object.
---@param Altitude number Orbit altitude in feet. Default is 6,000 ft.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Leg number Length of race-track in NM. Default nil.
---@param Heading number Heading of race-track pattern in degrees. Default is heading of the group.
---@param OffsetVec2 Vec2 Offset 2D-vector {x=0, y=0} in NM with respect to the group. Default directly overhead. Can also be given in polar coordinates `{r=5, phi=45}`.
---@param Distance number Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@return AUFTRAG #self
function AUFTRAG:NewORBIT_GROUP(Group, Altitude, Speed, Leg, Heading, OffsetVec2, Distance) end

---**[AIR]** Create an ORBIT mission, where the aircraft will fly a race-track pattern.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to orbit.
---@param Altitude number Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading number Heading of race-track pattern in degrees. Default random in [0, 360) degrees.
---@param Leg number Length of race-track in NM. Default 10 NM.
---@return AUFTRAG #self
function AUFTRAG:NewORBIT_RACETRACK(Coordinate, Altitude, Speed, Heading, Leg) end

---**[AIR, GROUND, NAVAL]** Create a PATROLZONE mission.
---Group(s) will go to the zone and patrol it randomly.
---
------
---@param self AUFTRAG 
---@param Zone ZONE The patrol zone.
---@param Speed number Speed in knots.
---@param Altitude number Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Formation string Formation used by ground units during patrol. Default "Off Road".
---@return AUFTRAG #self
function AUFTRAG:NewPATROLZONE(Zone, Speed, Altitude, Formation) end

---**[AIR]** Create an enhanced orbit race track mission.
---Planes will keep closer to the track.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to start the race track.
---@param Altitude number (Optional) Altitude in feet. Defaults to 20,000ft ASL.
---@param Speed number (Optional) Speed in knots. Defaults to 300kn TAS.
---@param Heading number (Optional) Heading in degrees, 0 to 360. Defaults to 90 degree (East).
---@param Leg number (Optional) Leg of the race track in NM. Defaults to 10nm.
---@param Formation number (Optional) Formation to take, e.g. ENUMS.Formation.FixedWing.Trail.Close, also see [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_option_formation).
---@return AUFTRAG #self
function AUFTRAG:NewPATROL_RACETRACK(Coordinate, Altitude, Speed, Heading, Leg, Formation) end

---**[GROUND]** Create a REARMING mission.
---
------
---@param self AUFTRAG 
---@param Zone ZONE The zone, where units go and look for ammo supply.
---@return AUFTRAG #self
function AUFTRAG:NewREARMING(Zone) end

---**[AIR, GROUND, NAVAL]** Create a RECON mission.
---
------
---@param self AUFTRAG 
---@param ZoneSet SET_ZONE The recon zones.
---@param Speed number Speed in knots.
---@param Altitude number Altitude in feet. Only for airborne units. Default 2000 feet ASL.
---@param Adinfinitum boolean If `true`, the group will start over again after reaching the final zone.
---@param Randomly boolean If `true`, the group will select a random zone.
---@param Formation string Formation used during recon route.
---@return AUFTRAG #self
function AUFTRAG:NewRECON(ZoneSet, Speed, Altitude, Adinfinitum, Randomly, Formation) end

---**[AIRPANE]** Create a RECOVERY TANKER mission.
---
------
---@param self AUFTRAG 
---@param Carrier UNIT The carrier unit.
---@param Altitude number Orbit altitude in feet. Default is 6,000 ft.
---@param Speed number Orbit speed in knots. Default 250 KIAS.
---@param Leg number Length of race-track in NM. Default 14 NM.
---@param RelHeading number Relative heading [0, 360) of race-track pattern in degrees wrt heading of the carrier. Default is heading of the carrier.
---@param OffsetDist number Relative distance of the first race-track point wrt to the carrier. Default 6 NM.
---@param OffsetAngle number Relative angle of the first race-track point wrt. to the carrier. Default 180 (behind the boat).
---@param UpdateDistance number Threshold distance in NM before orbit pattern is updated. Default 5 NM.
---@return AUFTRAG #self
function AUFTRAG:NewRECOVERYTANKER(Carrier, Altitude, Speed, Leg, RelHeading, OffsetDist, OffsetAngle, UpdateDistance) end

---**[AIR ROTARY]** Create a RESCUE HELO mission.
---
------
---@param self AUFTRAG 
---@param Carrier UNIT The carrier unit.
---@return AUFTRAG #self
function AUFTRAG:NewRESCUEHELO(Carrier) end

---**[AIR]** Create a SEAD mission.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE The target to attack. Can be a GROUP or UNIT object.
---@param Altitude number Engage altitude in feet. Default 25000 ft.
---@return AUFTRAG #self
function AUFTRAG:NewSEAD(Target, Altitude) end

---**[AIR]** Create a STRAFING mission.
---Assigns a point on the ground for which the AI will do a strafing run with guns or rockets.
---See [DCS task strafing](https://wiki.hoggitworld.com/view/DCS_task_strafing).
---
------
---@param self AUFTRAG 
---@param Target COORDINATE Target coordinate. Can also be specified as a GROUP, UNIT, STATIC or TARGET object.
---@param Altitude number Engage altitude in feet. Default 1000 ft.
---@param Length number The total length of the strafing target in meters. Default `nil`.
---@return AUFTRAG #self
function AUFTRAG:NewSTRAFING(Target, Altitude, Length) end

---**[AIR]** Create a STRIKE mission.
---Flight will attack the closest map object to the specified coordinate.
---
------
---@param self AUFTRAG 
---@param Target COORDINATE The target coordinate. Can also be given as a GROUP, UNIT, STATIC, SET_GROUP, SET_UNIT, SET_STATIC or TARGET object.
---@param Altitude number Engage altitude in feet. Default 2000 ft.
---@param EngageWeaponType number Which weapon to use. Defaults to auto, ie ENUMS.WeaponFlag.Auto. See ENUMS.WeaponFlag for options.
---@return AUFTRAG #self
function AUFTRAG:NewSTRIKE(Target, Altitude, EngageWeaponType) end

---**[AIR]** Create a TANKER mission.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Where to orbit.
---@param Altitude number Orbit altitude in feet. Default is y component of `Coordinate`.
---@param Speed number Orbit indicated airspeed in knots at the set altitude ASL. Default 350 KIAS.
---@param Heading number Heading of race-track pattern in degrees. Default 270 (East to West).
---@param Leg number Length of race-track in NM. Default 10 NM.
---@param RefuelSystem number Refueling system (0=boom, 1=probe). This info is *only* for AIRWINGs so they launch the right tanker type.
---@return AUFTRAG #self
function AUFTRAG:NewTANKER(Coordinate, Altitude, Speed, Heading, Leg, RefuelSystem) end

---**[AIR ROTARY, GROUND]** Create a TROOP TRANSPORT mission.
---
------
---@param self AUFTRAG 
---@param TransportGroupSet SET_GROUP The set group(s) to be transported.
---@param DropoffCoordinate COORDINATE Coordinate where the helo will land drop off the the troops.
---@param PickupCoordinate COORDINATE Coordinate where the helo will land to pick up the the cargo. Default is the first transport group.
---@param PickupRadius number Radius around the pickup coordinate in meters. Default 100 m.
---@return AUFTRAG #self
function AUFTRAG:NewTROOPTRANSPORT(TransportGroupSet, DropoffCoordinate, PickupCoordinate, PickupRadius) end

---On after "Cancel" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterCancel(From, Event, To) end

---On after "Done" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterDone(From, Event, To) end

---On after "Executing" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterExecuting(From, Event, To) end

---On after "Failed" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterFailed(From, Event, To) end

---On after "Planned" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterPlanned(From, Event, To) end

---On after "Queued" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterQueued(From, Event, To) end

---On after "Repeat" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterRepeat(From, Event, To) end

---On after "Requested" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterRequested(From, Event, To) end

---On after "Scheduled" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterScheduled(From, Event, To) end

---On after "Started" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterStarted(From, Event, To) end

---On after "Success" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:OnAfterSuccess(From, Event, To) end

---Unit lost event.
---
------
---@param self AUFTRAG 
---@param EventData EVENTDATA Event data.
function AUFTRAG:OnEventUnitLost(EventData) end

---Triggers the FSM event "Planned".
---
------
---@param self AUFTRAG 
function AUFTRAG:Planned() end

---Triggers the FSM event "Queued".
---
------
---@param self AUFTRAG 
function AUFTRAG:Queued() end

---Remove LEGION from mission.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
---@return AUFTRAG #self
function AUFTRAG:RemoveLegion(Legion) end

---Triggers the FSM event "Repeat".
---
------
---@param self AUFTRAG 
function AUFTRAG:Repeat() end

---Triggers the FSM event "Requested".
---
------
---@param self AUFTRAG 
function AUFTRAG:Requested() end

---Triggers the FSM event "Scheduled".
---
------
---@param self AUFTRAG 
function AUFTRAG:Scheduled() end

---Set alarm state for this mission.
---
------
---@param self AUFTRAG 
---@param Alarmstate number Alarm state 0=Auto, 1=Green, 2=Red.
---@return AUFTRAG #self
function AUFTRAG:SetAlarmstate(Alarmstate) end

---Set that (jet) aircraft are generally allowed to use afterburner.
---Default is use of afterburner is allowed.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:SetAllowAfterburner() end

---Set that (jet) aircraft are allowed to use afterburner in mission execution phase.
---Default is use of afterburner is allowed.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:SetAllowAfterburnerExecutePhase() end

---**[LEGION, COMMANDER, CHIEF]** Set that only alive (spawned) assets are considered.
---
------
---@param self AUFTRAG 
---@param Switch boolean If true or nil, only active assets. If false
---@return AUFTRAG #self
function AUFTRAG:SetAssetsStayAlive(Switch) end

---Set time how long the mission is executed.
---Once this time limit has passed, the mission is cancelled.
---
------
---@param self AUFTRAG 
---@param Duration number Duration in seconds.
---@return AUFTRAG #self
function AUFTRAG:SetDuration(Duration) end

---Set EPLRS datalink setting for this mission.
---
------
---@param self AUFTRAG 
---@param OnOffSwitch boolean If `true` or `nil`, EPLRS is on. If `false`, EPLRS is off.
---@return AUFTRAG #self
function AUFTRAG:SetEPLRS(OnOffSwitch) end

---Set emission setting for this mission.
---
------
---@param self AUFTRAG 
---@param OnOffSwitch boolean If `true` or `nil`, emission is on. If `false`, emission is off.
---@return AUFTRAG #self
function AUFTRAG:SetEmission(OnOffSwitch) end

---Enable markers, which dispay the mission status on the F10 map.
---
------
---@param self AUFTRAG 
---@param Coalition number The coaliton side to which the markers are dispayed. Default is to all.
---@return AUFTRAG #self
function AUFTRAG:SetEnableMarkers(Coalition) end

---Set engage altitude.
---This is the altitude passed to the DCS task. In the ME it is the tickbox ALTITUDE ABOVE.
---
------
---@param self AUFTRAG 
---@param Altitude string Altitude in feet. Default 6000 ft.
---@return AUFTRAG #self
function AUFTRAG:SetEngageAltitude(Altitude) end

---Set whether target will be attack as group.
---
------
---@param self AUFTRAG 
---@param Switch boolean If true or nil, engage as group. If false, not.
---@return AUFTRAG #self
function AUFTRAG:SetEngageAsGroup(Switch) end

---Enable to automatically engage detected targets.
---
------
---@param self AUFTRAG 
---@param RangeMax number Max range in NM. Only detected targets within this radius from the group will be engaged. Default is 25 NM.
---@param TargetTypes table Types of target attributes that will be engaged. See [DCS enum attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). Default "All".
---@param EngageZoneSet SET_ZONE Set of zones in which targets are engaged. Default is anywhere.
---@param NoEngageZoneSet SET_ZONE Set of zones in which targets are *not* engaged. Default is nowhere.
---@return AUFTRAG #self
function AUFTRAG:SetEngageDetected(RangeMax, TargetTypes, EngageZoneSet, NoEngageZoneSet) end

---Set time interval between mission done and success/failure evaluation.
---
------
---@param self AUFTRAG 
---@param Teval number Time in seconds before the mission result is evaluated. Default depends on mission type.
---@return AUFTRAG #self
function AUFTRAG:SetEvaluationTime(Teval) end

---Set formation for this mission.
---
------
---@param self AUFTRAG 
---@param Formation number Formation.
---@return AUFTRAG #self
function AUFTRAG:SetFormation(Formation) end

---Set Egress waypoint UID for OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@param waypointindex number Waypoint UID.
---@return AUFTRAG #self
function AUFTRAG:SetGroupEgressWaypointUID(opsgroup, waypointindex) end

---Set opsgroup mission status.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The flight group.
---@param status string New status.
---@return AUFTRAG #self
function AUFTRAG:SetGroupStatus(opsgroup, status) end

---Set mission (ingress) waypoint coordinate for OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@param coordinate COORDINATE Waypoint Coordinate.
---@return AUFTRAG #self
function AUFTRAG:SetGroupWaypointCoordinate(opsgroup, coordinate) end

---Set mission (ingress) waypoint UID for OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@param waypointindex number Waypoint UID.
---@return AUFTRAG #self
function AUFTRAG:SetGroupWaypointIndex(opsgroup, waypointindex) end

---Set mission waypoint task for OPS group.
---
------
---@param self AUFTRAG 
---@param opsgroup OPSGROUP The OPS group.
---@param task OPSGROUP.Task Waypoint task.
function AUFTRAG:SetGroupWaypointTask(opsgroup, task) end

---Set ICLS beacon channel and Morse code for this mission.
---
------
---@param self AUFTRAG 
---@param Channel number ICLS channel.
---@param Morse string Morse code. Default "XXX".
---@param UnitName string Name of the unit in the group for which acts as ICLS beacon. Default is the first unit in the group.
---@return AUFTRAG #self
function AUFTRAG:SetICLS(Channel, Morse, UnitName) end

---Set immortality setting for this mission.
---
------
---@param self AUFTRAG 
---@param OnOffSwitch boolean If `true` or `nil`, immortal is on. If `false`, immortal is off.
---@return AUFTRAG #self
function AUFTRAG:SetImmortal(OnOffSwitch) end

---[Air] Set mission (ingress) waypoint coordinate for FLIGHT group.
---
------
---@param self AUFTRAG 
---@param coordinate COORDINATE Waypoint Coordinate.
---@return AUFTRAG #self
function AUFTRAG:SetIngressCoordinate(coordinate) end

---Set invisibility setting for this mission.
---
------
---@param self AUFTRAG 
---@param OnOffSwitch boolean If `true` or `nil`, invisible is on. If `false`, invisible is off.
---@return AUFTRAG #self
function AUFTRAG:SetInvisible(OnOffSwitch) end

---Set LEGION mission status.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion.
---@param Status string New status.
---@return AUFTRAG #self
function AUFTRAG:SetLegionStatus(Legion, Status) end

---Set mission altitude.
---This is the altitude of the waypoint create where the DCS task is executed.
---
------
---@param self AUFTRAG 
---@param Altitude string Altitude in feet.
---@return AUFTRAG #self
function AUFTRAG:SetMissionAltitude(Altitude) end

---Set the mission egress coordinate.
---This is the coordinate where the assigned group will go once the mission is finished.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Egrees coordinate.
---@param Altitude number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed number (Optional) Speed in knots to reach this waypoint. Defaults to mission speed.
---@return AUFTRAG #self
function AUFTRAG:SetMissionEgressCoord(Coordinate, Altitude, Speed) end

---[Air] Set the mission holding coordinate.
---This is the coordinate where the assigned group will fly before the actual mission execution starts. Do not forget to add a push condition, too!
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Holding coordinate.
---@param Altitude number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed number (Optional) Speed in knots to reach this waypoint and hold there. Defaults to mission speed.
---@param Duration number (Optional) Duration in seconds on how long to hold, defaults to 15 minutes. Mission continues if either a push condition is met or the time is up.
---@return AUFTRAG #self
function AUFTRAG:SetMissionHoldingCoord(Coordinate, Altitude, Speed, Duration) end

---[Air] Set the mission ingress coordinate.
---This is the coordinate where the assigned group will fly before the actual mission coordinate.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Ingrees coordinate.
---@param Altitude number (Optional) Altitude in feet. Default is y component of coordinate.
---@param Speed number (Optional) Speed in knots to reach this waypoint. Defaults to mission speed.
---@return AUFTRAG #self
function AUFTRAG:SetMissionIngressCoord(Coordinate, Altitude, Speed) end

---Set max mission range.
---Only applies if the AUFTRAG is handled by an AIRWING or CHIEF. This is the max allowed distance from the airbase to the target.
---
------
---@param self AUFTRAG 
---@param Range number Max range in NM. Default 100 NM.
---@return AUFTRAG #self
function AUFTRAG:SetMissionRange(Range) end

---Set mission speed.
---That is the speed the group uses to get to the mission waypoint.
---
------
---@param self AUFTRAG 
---@param Speed string Mission speed in knots.
---@return AUFTRAG #self
function AUFTRAG:SetMissionSpeed(Speed) end

---[NON-AIR] Set the mission waypoint coordinate from where the mission is executed.
---Note that altitude is set via `:SetMissionAltitude`.
---
------
---@param self AUFTRAG 
---@param Coordinate COORDINATE Coordinate where the mission is executed.
---@return AUFTRAG #self
function AUFTRAG:SetMissionWaypointCoord(Coordinate) end

---Set randomization of the mission waypoint coordinate.
---Each assigned group will get a random ingress coordinate, where the mission is executed.
---
------
---@param self AUFTRAG 
---@param Radius number Distance in meters. Default `#nil`.
---@return AUFTRAG #self
function AUFTRAG:SetMissionWaypointRandomization(Radius) end

---Set mission name.
---
------
---@param self AUFTRAG 
---@param Name string Name of the mission. Default is "Auftrag Nr. X", where X is a running number, which is automatically increased.
---@return AUFTRAG #self
function AUFTRAG:SetName(Name) end

---Attach OPS transport to the mission.
---Mission assets will be transported before the mission is started at the OPSGROUP level.
---
------
---@param self AUFTRAG 
---@param OpsTransport OPSTRANSPORT The OPS transport assignment attached to the mission.
---@return AUFTRAG #self
function AUFTRAG:SetOpsTransport(OpsTransport) end

---Set mission priority and (optional) urgency.
---Urgent missions can cancel other running missions.
---
------
---@param self AUFTRAG 
---@param Prio number Priority 1=high, 100=low. Default 50.
---@param Urgent boolean If *true*, another running mission might be cancelled if it has a lower priority.
---@param Importance number Number 1-10. If missions with lower value are in the queue, these have to be finished first. Default is `nil`.
---@return AUFTRAG #self
function AUFTRAG:SetPriority(Prio, Urgent, Importance) end

---Set that (jet) aircraft are generally **not** allowed to use afterburner.
---Default is use of afterburner is allowed.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:SetProhibitAfterburner() end

---Set that (jet) aircraft are **not** allowed to use afterburner in mission execution phase.
---Default is use of afterburner is allowed.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:SetProhibitAfterburnerExecutePhase() end

---Set mission push time.
---This is the time the mission is executed. If the push time is not passed, the group will wait at the mission execution waypoint.
---
------
---@param self AUFTRAG 
---@param ClockPush string Time the mission is executed, e.g. "05:00" for 5 am. Can also be given as a `#number`, where it is interpreted as relative push time in seconds.
---@return AUFTRAG #self
function AUFTRAG:SetPushTime(ClockPush) end

---Set Rules of Engagement (ROE) for this mission.
---
------
---@param self AUFTRAG 
---@param roe number Mission ROE, e.g. `ENUMS.ROE.ReturnFire` (whiche equals 3)
---@return AUFTRAG #self
function AUFTRAG:SetROE(roe) end

---Set Reaction on Threat (ROT) for this mission.
---
------
---@param self AUFTRAG 
---@param rot number Mission ROT, e.g. `ENUMS.ROT.NoReaction` (whiche equals 0)
---@return AUFTRAG #self
function AUFTRAG:SetROT(rot) end

---Set radio frequency and modulation for this mission.
---
------
---@param self AUFTRAG 
---@param Frequency number Frequency in MHz.
---@param Modulation number Radio modulation. Default 0=AM.
---@return AUFTRAG #self
function AUFTRAG:SetRadio(Frequency, Modulation) end

---**[LEGION, COMMANDER, CHIEF]** Set that mission assets get reinforced if their number drops below the minimum number of required assets of the mission (*c.f.* SetRequiredAssets() function).
---
---**Note** that reinforcement groups are only recruited from the legion (airwing, brigade, fleet) the mission was assigned to. If the legion does not have any more of these assets, 
---no reinforcement can take place, even if the mission is submitted to a COMMANDER or CHIEF.
---
------
---@param self AUFTRAG 
---@param Nreinforce number Number of max asset groups used to reinforce.
---@return AUFTRAG #self
function AUFTRAG:SetReinforce(Nreinforce) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated.
---Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---
------
---@param self AUFTRAG 
---@param Nrepeat number Number of repeats. Default 0.
---@return AUFTRAG #self
function AUFTRAG:SetRepeat(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated if it fails.
---Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---
------
---@param self AUFTRAG 
---@param Nrepeat number Number of repeats. Default 0.
---@return AUFTRAG #self
function AUFTRAG:SetRepeatOnFailure(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Set how many times the mission is repeated if it was successful.
---Only valid if the mission is handled by a LEGION (AIRWING, BRIGADE, FLEET) or higher level.
---
------
---@param self AUFTRAG 
---@param Nrepeat number Number of repeats. Default 0.
---@return AUFTRAG #self
function AUFTRAG:SetRepeatOnSuccess(Nrepeat) end

---**[LEGION, COMMANDER, CHIEF]** Define how many assets are required to do the job.
---Only used if the mission is handled by a **LEGION** (AIRWING, BRIGADE, ...) or higher level.
---
------
---@param self AUFTRAG 
---@param NassetsMin number Minimum number of asset groups. Default 1.
---@param NassetsMax number Maximum Number of asset groups. Default is same as `NassetsMin`.
---@return AUFTRAG #self
function AUFTRAG:SetRequiredAssets(NassetsMin, NassetsMax) end

---**[LEGION, COMMANDER, CHIEF]** Set required attribute(s) the assets must have.
---
------
---@param self AUFTRAG 
---@param Attributes table Generalized attribute(s).
---@return AUFTRAG #self
function AUFTRAG:SetRequiredAttribute(Attributes) end

---**[LEGION, COMMANDER, CHIEF]** Set number of required carrier groups if an OPSTRANSPORT assignment is required.
---
------
---@param self AUFTRAG 
---@param NcarriersMin number Number of carriers *at least* required. Default 1.
---@param NcarriersMax number Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@param Categories table Group categories.
---@param Attributes table Group attributes. See `GROUP.Attribute.`
---@param Properties table DCS attributes.
---@return AUFTRAG #self
function AUFTRAG:SetRequiredCarriers(NcarriersMin, NcarriersMax, Categories, Attributes, Properties) end

---**[LEGION, COMMANDER, CHIEF]** Define how many assets are required that escort the mission assets.
---Only used if the mission is handled by a **LEGION** (AIRWING, BRIGADE, FLEET) or higher level.
---
------
---@param self AUFTRAG 
---@param NescortMin number Minimum number of asset groups. Default 1.
---@param NescortMax number Maximum Number of asset groups. Default is same as `NassetsMin`.
---@param MissionType string Mission type assets will be optimized for and payload selected, *e.g.* `AUFTRAG.Type.SEAD`. Default nil.
---@param TargetTypes table Target Types that will be engaged by the escort group(s). Default `{"Air"}` for aircraft and `{"Ground Units"}` for helos. Set, *e.g.*, `{"Air Defence"}` for SEAD.
---@param EngageRange number Max range in nautical miles that the escort group(s) will engage enemies. Default 32 NM (60 km).
---@return AUFTRAG #self
function AUFTRAG:SetRequiredEscorts(NescortMin, NescortMax, MissionType, TargetTypes, EngageRange) end

---**[LEGION, COMMANDER, CHIEF]** Set required property or properties the assets must have.
---These are [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes).
---
------
---@param self AUFTRAG 
---@param Properties table Property or table of properties.
---@return AUFTRAG #self
function AUFTRAG:SetRequiredProperty(Properties) end

---**[LEGION, COMMANDER, CHIEF]** Attach OPS transport to the mission.
---Mission assets will be transported before the mission is started at the OPSGROUP level.
---
------
---@param self AUFTRAG 
---@param DeployZone ZONE Zone where assets are deployed.
---@param NcarriersMin number Number of carriers *at least* required. Default 1.
---@param NcarriersMax number Number of carriers *at most* used for transportation. Default is same as `NcarriersMin`.
---@param DisembarkZone ZONE Zone where assets are disembarked to.
---@param Categories table Group categories.
---@param Attributes table Generalizes group attributes.
---@param Properties table DCS attributes.
---@return AUFTRAG #self
function AUFTRAG:SetRequiredTransport(DeployZone, NcarriersMin, NcarriersMax, DisembarkZone, Categories, Attributes, Properties) end

---**[LEGION, COMMANDER, CHIEF]** Set whether assigned assets return to their legion once the mission is over.
---This is only applicable to **army** and **navy** groups, *i.e.* aircraft 
---will always return.
---
------
---@param self AUFTRAG 
---@param Switch boolean If `true`, assets will return. If `false`, assets will not return and stay where it finishes its last mission. If `nil`, let asset decide.
---@return AUFTRAG #self
function AUFTRAG:SetReturnToLegion(Switch) end

---Set TACAN beacon channel and Morse code for this mission.
---
------
---@param self AUFTRAG 
---@param Channel number TACAN channel.
---@param Morse string Morse code. Default "XXX".
---@param UnitName string Name of the unit in the group for which acts as TACAN beacon. Default is the first unit in the group.
---@param Band string Tacan channel mode ("X" or "Y"). Default is "X" for ground/naval and "Y" for aircraft.
---@return AUFTRAG #self
function AUFTRAG:SetTACAN(Channel, Morse, UnitName, Band) end

---Set that mission assets are teleported to the mission execution waypoint.
---
------
---@param self AUFTRAG 
---@param Switch boolean If `true` or `nil`, teleporting is on. If `false`, teleporting is off.
---@return AUFTRAG #self
function AUFTRAG:SetTeleport(Switch) end

---Set mission start and stop time.
---
------
---@param self AUFTRAG 
---@param ClockStart string Time the mission is started, e.g. "05:00" for 5 am. If specified as a #number, it will be relative (in seconds) to the current mission time. Default is 5 seconds after mission was added.
---@param ClockStop string (Optional) Time the mission is stopped, e.g. "13:00" for 1 pm. If mission could not be started at that time, it will be removed from the queue. If specified as a #number it will be relative (in seconds) to the current mission time.
---@return AUFTRAG #self
function AUFTRAG:SetTime(ClockStart, ClockStop) end

---Set verbosity level.
---
------
---@param self AUFTRAG 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return AUFTRAG #self
function AUFTRAG:SetVerbosity(VerbosityLevel) end

---Set number of weapons to expend.
---
------
---@param self AUFTRAG 
---@param WeaponExpend number How much of the weapon load is expended during the attack, e.g. `AI.Task.WeaponExpend.ALL`. Default "Auto".
---@return AUFTRAG #self
function AUFTRAG:SetWeaponExpend(WeaponExpend) end

---Set weapon type used for the engagement.
---
------
---@param self AUFTRAG 
---@param WeaponType number Weapon type. Default is `ENUMS.WeaponFlag.Auto`.
---@return AUFTRAG #self
function AUFTRAG:SetWeaponType(WeaponType) end

---Triggers the FSM event "Started".
---
------
---@param self AUFTRAG 
function AUFTRAG:Started() end

---Triggers the FSM event "Status".
---
------
---@param self AUFTRAG 
function AUFTRAG:Status() end

---Triggers the FSM event "Stop".
---
------
---@param self AUFTRAG 
function AUFTRAG:Stop() end

---Triggers the FSM event "Success".
---
------
---@param self AUFTRAG 
function AUFTRAG:Success() end

---Update mission F10 map marker.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:UpdateMarker() end

---Add assets to mission.
---
------
---@param self AUFTRAG 
---@param Assets table List of assets.
---@return AUFTRAG #self
function AUFTRAG:_AddAssets(Assets) end

---Create a mission to attack a group.
---Mission type is automatically chosen from the group category.
---
------
---@param self AUFTRAG 
---@param Target POSITIONABLE Target object.
---@return string #Auftrag type, e.g. `AUFTRAG.Type.BAI` (="BAI").
function AUFTRAG:_DetermineAuftragType(Target) end

---Get DCS task table for an attack group or unit task.
---
------
---@param self AUFTRAG 
---@param Target TARGET Target data.
---@param DCStasks table DCS DCS tasks table to which the task is added.
---@return Task #The DCS task table.
function AUFTRAG:_GetDCSAttackTask(Target, DCStasks) end

---Get coordinate which was set as mission waypoint coordinate.
---
------
---@param self AUFTRAG 
---@return COORDINATE #Coordinate where the mission is executed or `#nil`.
function AUFTRAG:_GetMissionWaypointCoordSet() end

---Get request from legion this mission requested assets from.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion from which to get the request ID.
---@return WAREHOUSE.PendingItem #Request.
function AUFTRAG:_GetRequest(Legion) end

---Get request ID from legion this mission requested assets from
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion from which to get the request ID.
---@return number #Request ID (if any).
function AUFTRAG:_GetRequestID(Legion) end

---Check if reinforcement is done.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, reinforcing is over.
function AUFTRAG:_IsNotReinforcing() end

---Check if reinforcement is still ongoing.
---
------
---@param self AUFTRAG 
---@return boolean #If `true`, reinforcing is ongoing.
function AUFTRAG:_IsReinforcing() end

---**[PRIVATE, AIR, GROUND, NAVAL]** Create a mission to relocate all cohort assets to another LEGION.
---
------
---@param self AUFTRAG 
---@param Legion LEGION The new legion.
---@param Cohort COHORT The cohort to be relocated.
---@return AUFTRAG #self
function AUFTRAG:_NewRELOCATECOHORT(Legion, Cohort) end

---Set log ID string.
---
------
---@param self AUFTRAG 
---@return AUFTRAG #self
function AUFTRAG:_SetLogID() end

---Set request ID from legion this mission requested assets from
---
------
---@param self AUFTRAG 
---@param Legion LEGION The legion from which to get the request ID.
---@param RequestID number Request ID.
---@return AUFTRAG #self
function AUFTRAG:_SetRequestID(Legion, RequestID) end

---Create target data from a given object.
---
------
---@param self AUFTRAG 
---@param Object POSITIONABLE The target GROUP, UNIT, STATIC.
function AUFTRAG:_TargetFromObject(Object) end

---Triggers the FSM event "Cancel" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Cancel(delay) end

---Triggers the FSM event "Done" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Done(delay) end

---Triggers the FSM event "Executing" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Executing(delay) end

---Triggers the FSM event "Failed" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Failed(delay) end

---Triggers the FSM event "Planned" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Planned(delay) end

---Triggers the FSM event "Queued" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Queued(delay) end

---Triggers the FSM event "Repeat" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Repeat(delay) end

---Triggers the FSM event "Requested" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Requested(delay) end

---Triggers the FSM event "Scheduled" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Scheduled(delay) end

---Triggers the FSM event "Started" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Started(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Stop(delay) end

---Triggers the FSM event "Success" after a delay.
---
------
---@param self AUFTRAG 
---@param delay number Delay in seconds.
function AUFTRAG:__Success(delay) end

---On after "AssetDead" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Asset WAREHOUSE.Assetitem The asset.
function AUFTRAG:onafterAssetDead(From, Event, To, Asset) end

---On after "Assign" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterAssign(From, Event, To) end

---On after "Cancel" event.
---Cancells the mission.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterCancel(From, Event, To) end

---On after "Done" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterDone(From, Event, To) end

---On after "ElementDestroyed" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The ops group to which the element belongs.
---@param Element OPSGROUP.Element The element that got destroyed.
function AUFTRAG:onafterElementDestroyed(From, Event, To, OpsGroup, Element) end

---On after "Execute" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterExecuting(From, Event, To) end

---On after "Failed" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterFailed(From, Event, To) end

---On after "GroupDead" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param OpsGroup OPSGROUP The ops group that is dead now.
function AUFTRAG:onafterGroupDead(From, Event, To, OpsGroup) end

---On after "Planned" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterPlanned(From, Event, To) end

---On after "Queue" event.
---Mission is added to the mission queue of a LEGION.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Airwing NOTYPE 
function AUFTRAG:onafterQueued(From, Event, To, Airwing) end

---On after "Repeat" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterRepeat(From, Event, To) end

---On after "Requested" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterRequested(From, Event, To) end

---On after "Schedule" event.
---Mission is added to the mission queue of an OPSGROUP.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterScheduled(From, Event, To) end

---On after "Start" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterStarted(From, Event, To) end

---On after "Status" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterStatus(From, Event, To) end

---On after "Stop" event.
---Remove mission from LEGION and OPSGROUP mission queues.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterStop(From, Event, To) end

---On after "Success" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onafterSuccess(From, Event, To) end

---On before "Repeat" event.
---
------
---@param self AUFTRAG 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function AUFTRAG:onbeforeRepeat(From, Event, To) end


---Mission capability.
---@class AUFTRAG.Capability 
---@field MissionType string Type of mission.
---@field Performance number Number describing the performance level. The higher the better.
AUFTRAG.Capability = {}


---Mission category.
---@class AUFTRAG.Category 
---@field AIRCRAFT string Airplanes and helicopters.
---@field AIRPLANE string Airplanes.
---@field ALL string 
---@field GROUND string Ground troops.
---@field HELICOPTER string Helicopter.
---@field NAVAL string Naval grous.
AUFTRAG.Category = {}


---Generic mission condition.
---@class AUFTRAG.Condition 
---@field func function Callback function to check for a condition. Should return a #boolean.
AUFTRAG.Condition = {}


---Group specific data.
---Each ops group subscribed to this mission has different data for this.
---@class AUFTRAG.GroupData 
---@field asset WAREHOUSE.Assetitem The warehouse asset.
---@field opsgroup OPSGROUP The OPS group.
---@field status string Group mission status.
---@field waypointEgressUID number Egress Waypoint UID.
---@field waypointcoordinate COORDINATE Ingress waypoint coordinate.
---@field waypointindex number Mission (ingress) Waypoint UID.
---@field waypointtask OPSGROUP.Task Waypoint task.
---@field wpegresscoordinate COORDINATE Egress waypoint coordinate.
AUFTRAG.GroupData = {}


---Mission status of an assigned group.
---@class AUFTRAG.GroupStatus 
---@field CANCELLED string Mission was cancelled.
---@field DONE string Mission task of the Ops group is done.
---@field EXECUTING string Ops group is executing this mission.
---@field PAUSED string Ops group has paused this mission, e.g. for refuelling.
---@field SCHEDULED string Mission is scheduled in a FLIGHGROUP queue waiting to be started.
---@field STARTED string Ops group started this mission but it is not executed yet.
AUFTRAG.GroupStatus = {}


---Special task description.
---@class AUFTRAG.SpecialTask 
---@field AIRDEFENSE string Air defense.
---@field ALERT5 string Alert 5 task.
---@field AMMOSUPPLY string Ammo Supply.
---@field ARMORATTACK string 
---@field ARMOREDGUARD string On guard with armor.
---@field BARRAGE string Barrage.
---@field CAPTUREZONE string Capture OPS zone.
---@field EWR string Early Warning Radar.
---@field FERRY string Ferry mission.
---@field FORMATION string AI formation task.
---@field FUELSUPPLY string Fuel Supply.
---@field GROUNDATTACK string Ground attack.
---@field HOVER string Hover.
---@field NOTHING string Nothing.
---@field ONGUARD string On guard.
---@field PATROLRACETRACK string Patrol Racetrack.
---@field PATROLZONE string Patrol zone task.
---@field REARMING string Rearming.
---@field RECON string Recon task.
---@field RECOVERYTANKER string Recovery tanker.
---@field RELOCATECOHORT string Relocate cohort.
AUFTRAG.SpecialTask = {}


---Mission status.
---@class AUFTRAG.Status 
---@field CANCELLED string Mission was cancelled.
---@field DONE string Mission is over.
---@field EXECUTING string Mission is being executed.
---@field FAILED string Mission failed.
---@field PLANNED string Mission is at the early planning stage and has not been added to any queue.
---@field QUEUED string Mission is queued at a LEGION.
---@field REQUESTED string Mission assets were requested from the warehouse.
---@field SCHEDULED string Mission is scheduled in an OPSGROUP queue waiting to be started.
---@field STARTED string Mission has started but is not executed yet.
---@field SUCCESS string Mission was a success.
AUFTRAG.Status = {}


---Mission success.
---@class AUFTRAG.Success 
---@field DAMAGED string Target was damaged.
---@field DESTROYED string Target was destroyed.
---@field ENGAGED string Target was engaged.
---@field SURVIVED string Group did survive.
AUFTRAG.Success = {}


---Target data.
---@class AUFTRAG.TargetData 
---@field Lifepoints number Total life points.
---@field Lifepoints0 number Inital life points.
---@field Name string Target name.
---@field Ninital number Number of initial targets.
---@field Target POSITIONABLE Target Object.
---@field Type string Target type: "Group", "Unit", "Static", "Coordinate", "Airbase", "SetGroup", "SetUnit".
AUFTRAG.TargetData = {}


---Target type.
---@class AUFTRAG.TargetType 
---@field AIRBASE string Target is an AIRBASE.
---@field COORDINATE string Target is a COORDINATE.
---@field GROUP string Target is a GROUP object.
---@field SETGROUP string Target is a SET of GROUPs.
---@field SETUNIT string Target is a SET of UNITs.
---@field STATIC string Target is a STATIC object.
---@field UNIT string Target is a UNIT object.
AUFTRAG.TargetType = {}


---Mission types.
---@class AUFTRAG.Type 
---@field AIRDEFENSE string Air defense.
---@field ALERT5 string Alert 5.
---@field AMMOSUPPLY string Ammo supply.
---@field ANTISHIP string Anti-ship mission.
---@field ARMORATTACK string Armor attack.
---@field ARMOREDGUARD string On guard - with armored groups.
---@field ARTY string Fire at point.
---@field AWACS string AWACS mission.
---@field BAI string Battlefield Air Interdiction.
---@field BARRAGE string Barrage.
---@field BOMBCARPET string Carpet bombing.
---@field BOMBING string Bombing mission.
---@field BOMBRUNWAY string Bomb runway of an airbase.
---@field CAP string Combat Air Patrol.
---@field CAPTUREZONE string Capture zone mission.
---@field CARGOTRANSPORT string Cargo transport.
---@field CAS string Close Air Support.
---@field CASENHANCED string Enhanced CAS.
---@field ESCORT string Escort mission.
---@field EWR string Early Warning Radar.
---@field FAC string Forward AirController mission.
---@field FACA string Forward AirController airborne mission.
---@field FERRY string Ferry mission.
---@field FUELSUPPLY string Fuel supply.
---@field GCICAP string Similar to CAP but no auto engage targets.
---@field GROUNDATTACK string Ground attack.
---@field GROUNDESCORT string Ground escort mission.
---@field HOVER string Hover.
---@field INTERCEPT string Intercept mission.
---@field LANDATCOORDINATE string Land at coordinate.
---@field NOTHING string Nothing.
---@field ONGUARD string On guard.
---@field OPSTRANSPORT string Ops transport.
---@field ORBIT string Orbit mission.
---@field PATROLRACETRACK string Patrol Racetrack.
---@field PATROLZONE string Patrol a zone.
---@field REARMING string Rearming mission.
---@field RECON string Recon mission.
---@field RECOVERYTANKER string Recovery tanker.
---@field RELOCATECOHORT string Relocate a cohort from one legion to another.
---@field RESCUEHELO string Rescue helo.
---@field SEAD string Suppression/destruction of enemy air defences.
---@field STRAFING string Strafing run.
---@field STRIKE string Strike mission.
---@field TANKER string Tanker mission.
---@field TROOPTRANSPORT string Troop transport mission.
AUFTRAG.Type = {}



