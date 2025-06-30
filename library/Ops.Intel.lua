---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_Intel.png" width="100%">
---
---**Ops** - Office of Military Intelligence.
---
---**Main Features:**
---
---   * Detect and track contacts consistently
---   * Detect and track clusters of contacts consistently
---   * Use FSM events to link functionality into your scripts
---   * Easy setup
---
---===
---
---### Author: **funkyfranky**
---Top Secret!
---
---===
---
---# The INTEL Concept
---
--- * Lightweight replacement for Functional.Detection#DETECTION
--- * Detect and track contacts consistently
--- * Detect and track clusters of contacts consistently
--- * Once detected and still alive, planes will be tracked 10 minutes, helicopters 20 minutes, ships and trains 1 hour, ground units 2 hours
--- * Use FSM events to link functionality into your scripts
---
---# Basic Usage
---
---## Set up a detection SET_GROUP
---
---    Red_DetectionSetGroup = SET_GROUP:New()
---    Red_DetectionSetGroup:FilterPrefixes( { "Red EWR" } )
---    Red_DetectionSetGroup:FilterOnce()
---
---## New Intel type detection for the red side, logname "KGB"
---
---    RedIntel = INTEL:New(Red_DetectionSetGroup, "red", "KGB")
---    RedIntel:SetClusterAnalysis(true, true)
---    RedIntel:SetVerbosity(2)
---    RedIntel:__Start(2)
---
---## Hook into new contacts found
---
---    function RedIntel:OnAfterNewContact(From, Event, To, Contact)
---      local text = string.format("NEW contact %s detected by %s", Contact.groupname, Contact.recce or "unknown")
---      MESSAGE:New(text, 15, "KGB"):ToAll()
---    end
---
--- ## And/or new clusters found
---
---    function RedIntel:OnAfterNewCluster(From, Event, To, Cluster)
---      local text = string.format("NEW cluster #%d of size %d", Cluster.index, Cluster.size)
---      MESSAGE:New(text,15,"KGB"):ToAll()
---    end
---INTEL class.
---@class INTEL : FSM
---@field ClassName string Name of the class.
---@field RadarAcceptRange boolean 
---@field RadarBlur boolean 
---@field acceptzoneset SET_ZONE Set of accept zones. If defined, only contacts in these zones are considered.
---@field alias string Name of the agency.
---@field clusteranalysis boolean If true, create clusters of detected targets.
---@field clusterarrows  
---@field clustercounter number Running number of clusters.
---@field clustermarkers boolean If true, create cluster markers on F10 map.
---@field clusterradius number Radius in meters in which groups/units are considered to belong to a cluster.
---@field coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field conflictzoneset SET_ZONE Set of conflict zones. Contacts in these zones are considered, even if they are not in accept zones or if they are in reject zones.
---@field dTforget number Time interval in seconds before a known contact which is not detected any more is forgotten.
---@field detectStatics boolean If `true`, detect STATIC objects. Default `false`.
---@field detectionset SET_GROUP Set of detection groups, aka agents.
---@field lid string Class id string for output to DCS log file.
---@field prediction number Seconds default to be used with CalcClusterFuturePosition.
---@field rejectzoneset SET_ZONE Set of reject zones. Contacts in these zones are not considered, even if they are in accept zones.
---@field statusupdate number Time interval in seconds after which the status is refreshed. Default 60 sec. Should be negative.
---@field verbose number Verbosity level.
---@field version string INTEL class version.
INTEL = {}

---Add an accept zone.
---Only contacts detected in this zone are considered.
---
------
---@param self INTEL 
---@param AcceptZone ZONE Add a zone to the accept zone set.
---@return INTEL #self
function INTEL:AddAcceptZone(AcceptZone) end

---Add a group to the detection set.
---
------
---@param self INTEL 
---@param AgentGroup GROUP Group of agents. Can also be an @{Ops.OpsGroup#OPSGROUP} object.
---@return INTEL #self
function INTEL:AddAgent(AgentGroup) end

---Add a conflict zone.
---Contacts detected in this zone are conflicted and not reported by the detection.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---
------
---@param self INTEL 
---@param ConflictZone ZONE Add a zone to the conflict zone set.
---@return INTEL #self
function INTEL:AddConflictZone(ConflictZone) end

---Add a contact to our list.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact to be added.
---@return INTEL #self
function INTEL:AddContact(Contact) end

---Add a contact to the cluster.
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@param cluster INTEL.Cluster The cluster.
function INTEL:AddContactToCluster(contact, cluster) end

---Add a Mission (Auftrag) to a cluster for tracking.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster
---@param Mission AUFTRAG The mission connected with this cluster
---@return INTEL #self
function INTEL:AddMissionToCluster(Cluster, Mission) end

---Add a Mission (Auftrag) to a contact for tracking.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact
---@param Mission AUFTRAG The mission connected with this contact
---@return INTEL #self
function INTEL:AddMissionToContact(Contact, Mission) end

---Add a reject zone.
---Contacts detected in this zone are rejected and not reported by the detection.
---Note that reject zones overrule accept zones, i.e. if a unit is inside an accept zone and inside a reject zone, it is rejected.
---
------
---@param self INTEL 
---@param RejectZone ZONE Add a zone to the reject zone set.
---@return INTEL #self
function INTEL:AddRejectZone(RejectZone) end

---Calculate cluster heading.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return number #Heading average of all groups in the cluster.
function INTEL:CalcClusterDirection(cluster) end

---Calculate cluster future position after given seconds.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@param seconds number Time interval in seconds. Default is `self.prediction`.
---@return COORDINATE #Calculated future position of the cluster.
function INTEL:CalcClusterFuturePosition(cluster, seconds) end

---Calculate cluster speed.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return number #Speed average of all groups in the cluster in MPS.
function INTEL:CalcClusterSpeed(cluster) end

---Calculate cluster threat level average.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return number #Average of all threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelAverage(cluster) end

---Calculate max cluster threat level.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return number #Max threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelMax(cluster) end

---Calculate cluster threat level sum.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return number #Sum of all threat levels of all groups in the cluster.
function INTEL:CalcClusterThreatlevelSum(cluster) end

---Calculate cluster velocity vector.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster of contacts.
---@return Vec3 #Velocity vector in m/s.
function INTEL:CalcClusterVelocityVec3(cluster) end

---Check if contact is in any known cluster.
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@return boolean #If true, contact is in clusters
function INTEL:CheckContactInClusters(contact) end

---Count number of alive units in cluster.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster
---@return number #unitcount
function INTEL:ClusterCountUnits(Cluster) end

---Count number of alive units in contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return number #unitcount
function INTEL:ContactCountUnits(Contact) end

---Create detected items.
---
------
---@param self INTEL 
---@param DetectedGroups table Table of detected Groups.
---@param DetectedStatics table Table of detected Statics.
---@param RecceDetecting table Table of detecting recce names.
function INTEL:CreateDetectedItems(DetectedGroups, DetectedStatics, RecceDetecting) end

---Filter group categories.
---Valid categories are:
---
---* Group.Category.AIRPLANE
---* Group.Category.HELICOPTER
---* Group.Category.GROUND
---* Group.Category.SHIP
---* Group.Category.TRAIN
---
------
---@param self INTEL 
---@param GroupCategories table Filter categories, e.g. `{Group.Category.AIRPLANE, Group.Category.HELICOPTER}`.
---@return INTEL #self
function INTEL:FilterCategoryGroup(GroupCategories) end

---Get the altitude of a cluster.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster.
---@param Update boolean If `true`, update the altitude. Default is to just return the last stored altitude.
---@return number #The average altitude (ASL) of this cluster in meters.
function INTEL:GetClusterAltitude(Cluster, Update) end

---Get the coordinate of a cluster.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster.
---@param Update boolean If `true`, update the coordinate. Default is to just return the last stored position.
---@return COORDINATE #The coordinate of this cluster.
function INTEL:GetClusterCoordinate(Cluster, Update) end

---Get the cluster this contact belongs to (if any).
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@return INTEL.Cluster #The cluster this contact belongs to or nil.
function INTEL:GetClusterOfContact(contact) end

---Get table of #INTEL.Cluster objects
---
------
---@param self INTEL 
---@return table #Clusters or nil if not running
function INTEL:GetClusterTable() end

---Get a contact by name.
---
------
---@param self INTEL 
---@param groupname string Name of the contact group.
---@return INTEL.Contact #The contact.
function INTEL:GetContactByName(groupname) end

---Get category name of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return string #Category name.
function INTEL:GetContactCategoryName(Contact) end

---Get coordinate of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return COORDINATE #Coordinates.
function INTEL:GetContactCoordinate(Contact) end

---Get group of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return GROUP #Group object.
function INTEL:GetContactGroup(Contact) end

---Get name of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return string #Name of the contact.
function INTEL:GetContactName(Contact) end

---Get table of #INTEL.Contact objects
---
------
---@param self INTEL 
---@return table #Contacts or nil if not running
function INTEL:GetContactTable() end

---Get threatlevel of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return number #Threat level.
function INTEL:GetContactThreatlevel(Contact) end

---Get type name of a contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return string #Type name.
function INTEL:GetContactTypeName(Contact) end

---(Internal) Return the detected target groups of the controllable as a Core.Set#SET_GROUP.
---The optional parameters specify the detection methods that can be applied.
---If no detection method is given, the detection will use all the available methods by default.
---
------
---@param self INTEL 
---@param Unit UNIT The unit detecting.
---@param DetectedUnits table Table of detected units to be filled.
---@param RecceDetecting table Table of recce per unit to be filled.
---@param DetectVisual boolean (Optional) If *false*, do not include visually detected targets.
---@param DetectOptical boolean (Optional) If *false*, do not include optically detected targets.
---@param DetectRadar boolean (Optional) If *false*, do not include targets detected by radar.
---@param DetectIRST boolean (Optional) If *false*, do not include targets detected by IRST.
---@param DetectRWR boolean (Optional) If *false*, do not include targets detected by RWR.
---@param DetectDLINK boolean (Optional) If *false*, do not include targets detected by data link.
function INTEL:GetDetectedUnits(Unit, DetectedUnits, RecceDetecting, DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Get the contact with the highest threat level from the cluster.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster.
---@return INTEL.Contact #the contact or nil if none
function INTEL:GetHighestThreatContact(Cluster) end

---Check if contact is close to any other contact this cluster.
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@param cluster INTEL.Cluster The cluster the check.
---@return boolean #If `true`, contact is connected to this cluster.
---@return number #Distance to cluster in meters.
function INTEL:IsContactConnectedToCluster(contact, cluster) end

---Check if contact is close to any contact of known clusters.
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@return INTEL.Cluster #The cluster this contact is part of or nil otherwise.
function INTEL:IsContactPartOfAnyClusters(contact) end

---Make the INTEL aware of a object that was not detected (yet).
---This will add the object to the contacts table and trigger a `NewContact` event.
---
------
---@param self INTEL 
---@param Positionable POSITIONABLE Group or static object.
---@param RecceName string Name of the recce group that detected this object.
---@param Tdetected number Abs. mission time in seconds, when the object is detected. Default now.
---@return INTEL #self
function INTEL:KnowObject(Positionable, RecceName, Tdetected) end

---Triggers the FSM event "LostCluster" after a delay.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
---@param Cluster INTEL.Cluster Lost cluster.
---@param Mission AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:LostCluster(delay, Cluster, Mission) end

---Triggers the FSM event "LostContact" after a delay.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
---@param Contact INTEL.Contact Lost contact.
function INTEL:LostContact(delay, Contact) end

---Create a new INTEL object and start the FSM.
---
------
---@param self INTEL 
---@param DetectionSet SET_GROUP Set of detection groups.
---@param Coalition number Coalition side. Can also be passed as a string "red", "blue" or "neutral".
---@param Alias string An *optional* alias how this object is called in the logs etc.
---@return INTEL #self
function INTEL:New(DetectionSet, Coalition, Alias) end

---Triggers the FSM event "NewCluster" after a delay.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
---@param Cluster INTEL.Cluster Detected cluster.
function INTEL:NewCluster(delay, Cluster) end

---Triggers the FSM event "NewContact" after a delay.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
---@param Contact INTEL.Contact Detected contact.
function INTEL:NewContact(delay, Contact) end

---On After "LostCluster" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cluster INTEL.Cluster Lost cluster.
---@param Mission AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:OnAfterLostCluster(From, Event, To, Cluster, Mission) end

---On After "LostContact" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Contact INTEL.Contact Lost contact.
function INTEL:OnAfterLostContact(From, Event, To, Contact) end

---On After "NewCluster" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cluster INTEL.Cluster Detected cluster.
function INTEL:OnAfterNewCluster(From, Event, To, Cluster) end

---On After "NewContact" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Contact INTEL.Contact Detected contact.
function INTEL:OnAfterNewContact(From, Event, To, Contact) end

---[Internal] Paint picture of the battle field.
---Does Cluster analysis and updates clusters. Sets markers if markers are enabled.
---
------
---@param self INTEL 
function INTEL:PaintPicture() end

---Remove an accept zone from the accept zone set.
---
------
---@param self INTEL 
---@param AcceptZone ZONE Remove a zone from the accept zone set.
---@return INTEL #self
function INTEL:RemoveAcceptZone(AcceptZone) end

---Remove a conflict zone from the conflict zone set.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---
------
---@param self INTEL 
---@param ConflictZone ZONE Remove a zone from the conflict zone set.
---@return INTEL #self
function INTEL:RemoveConflictZone(ConflictZone) end

---Remove a contact from our list.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact to be removed.
function INTEL:RemoveContact(Contact) end

---Remove a contact from a cluster.
---
------
---@param self INTEL 
---@param contact INTEL.Contact The contact.
---@param cluster INTEL.Cluster The cluster.
function INTEL:RemoveContactFromCluster(contact, cluster) end

---Remove a reject zone from the reject zone set.
---
------
---@param self INTEL 
---@param RejectZone ZONE Remove a zone from the reject zone set.
---@return INTEL #self
function INTEL:RemoveRejectZone(RejectZone) end

---Set the accept range in kilometers from each of the recce.
---Only object closer than this range will be detected.
---
------
---@param self INTEL 
---@param Range number Range in kilometers
---@return INTEL #self
function INTEL:SetAcceptRange(Range) end

---Set accept zones.
---Only contacts detected in this/these zone(s) are considered.
---
------
---@param self INTEL 
---@param AcceptZoneSet SET_ZONE Set of accept zones.
---@return INTEL #self
function INTEL:SetAcceptZones(AcceptZoneSet) end

---Enable or disable cluster analysis of detected targets.
---Targets will be grouped in coupled clusters.
---
------
---@param self INTEL 
---@param Switch boolean If true, enable cluster analysis.
---@param Markers boolean If true, place markers on F10 map.
---@param Arrows boolean If true, draws arrows on F10 map.
---@return INTEL #self
function INTEL:SetClusterAnalysis(Switch, Markers, Arrows) end

---Change radius of the Clusters.
---
------
---@param self INTEL 
---@param radius number The radius of the clusters in kilometers. Default 15 km.
---@return INTEL #self
function INTEL:SetClusterRadius(radius) end

---Set conflict zones.
---Contacts detected in this/these zone(s) are reported by the detection.
---Note that conflict zones overrule all other zones, i.e. if a unit is outside of an accept zone and inside a reject zone, it is still reported if inside a conflict zone.
---
------
---@param self INTEL 
---@param ConflictZoneSet SET_ZONE Set of conflict zone(s).
---@return INTEL #self
function INTEL:SetConflictZones(ConflictZoneSet) end

---Set whether STATIC objects are detected.
---
------
---@param self INTEL 
---@param Switch boolean If `true`, statics are detected.
---@return INTEL #self
function INTEL:SetDetectStatics(Switch) end

---Set detection types for this #INTEL - all default to true.
---
------
---@param self INTEL 
---@param DetectVisual boolean Visual detection
---@param DetectOptical boolean Optical detection
---@param DetectRadar boolean Radar detection
---@param DetectIRST boolean IRST detection
---@param DetectRWR boolean RWR detection
---@param DetectDLINK boolean Data link detection
---@return  #self
function INTEL:SetDetectionTypes(DetectVisual, DetectOptical, DetectRadar, DetectIRST, DetectRWR, DetectDLINK) end

---Filter unit categories.
---Valid categories are:
---
---* Unit.Category.AIRPLANE
---* Unit.Category.HELICOPTER
---* Unit.Category.GROUND_UNIT
---* Unit.Category.SHIP
---* Unit.Category.STRUCTURE
---
------
---@param self INTEL 
---@param Categories table Filter categories, e.g. {Unit.Category.AIRPLANE, Unit.Category.HELICOPTER}.
---@return INTEL #self
function INTEL:SetFilterCategory(Categories) end

---**OBSOLETE, will be removed in next version!**  Set forget contacts time interval.
---Previously known contacts that are not detected any more, are "lost" after this time.
---This avoids fast oscillations between a contact being detected and undetected.
---
------
---@param self INTEL 
---@param TimeInterval number Time interval in seconds. Default is 120 sec.
---@return INTEL #self
function INTEL:SetForgetTime(TimeInterval) end

---Method to make the radar detection less accurate, e.g.
---for WWII scenarios.
---
------
---@param self INTEL 
---@param minheight number Minimum flight height to be detected, in meters AGL (above ground)
---@param thresheight number Threshold to escape the radar if flying below minheight, defaults to 90 (90% escape chance)
---@param thresblur number Threshold to be detected by the radar overall, defaults to 85 (85% chance to be found)
---@param closing number Closing-in in km - the limit of km from which on it becomes increasingly difficult to escape radar detection if flying towards the radar position. Should be about 1/3 of the radar detection radius in kilometers, defaults to 20.
---@return INTEL #self
function INTEL:SetRadarBlur(minheight, thresheight, thresblur, closing) end

---Set reject zones.
---Contacts detected in this/these zone(s) are rejected and not reported by the detection.
---Note that reject zones overrule accept zones, i.e. if a unit is inside an accept zone and inside a reject zone, it is rejected.
---
------
---@param self INTEL 
---@param RejectZoneSet SET_ZONE Set of reject zone(s).
---@return INTEL #self
function INTEL:SetRejectZones(RejectZoneSet) end

---Set verbosity level for debugging.
---
------
---@param self INTEL 
---@param Verbosity number The higher, the noisier, e.g. 0=off, 2=debug
---@return INTEL #self
function INTEL:SetVerbosity(Verbosity) end

---Triggers the FSM event "Start".
---Starts the INTEL. Initializes parameters and starts event handlers.
---
------
---@param self INTEL 
function INTEL:Start() end

---Triggers the FSM event "Status".
---
------
---@param self INTEL 
function INTEL:Status() end

---Update cluster F10 marker.
---
------
---@param self INTEL 
---@param cluster INTEL.Cluster The cluster.
---@return INTEL #self
function INTEL:UpdateClusterMarker(cluster) end

---Update detected items.
---
------
---@param self INTEL 
function INTEL:UpdateIntel() end

---Add cluster to table.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster to add.
function INTEL:_AddCluster(Cluster) end

---Check if the coorindate of the cluster changed.
---
------
---@param self INTEL 
---@param Cluster INTEL.Cluster The cluster.
---@param Threshold number in meters. Default 100 m.
---@param Coordinate COORDINATE Reference coordinate. Default is the last known coordinate of the cluster.
---@return boolean #If `true`, the coordinate changed by more than the given threshold.
function INTEL:_CheckClusterCoordinateChanged(Cluster, Threshold, Coordinate) end

---Check if a contact was lost.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact to be removed.
---@return boolean #If true, contact was not detected for at least *dTforget* seconds.
function INTEL:_CheckContactLost(Contact) end

---Create a new cluster.
---
------
---@param self INTEL 
---@return INTEL.Cluster #cluster The cluster.
function INTEL:_CreateCluster() end

---Create a new cluster from a first contact.
---The contact is automatically added to the cluster.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The first contact.
---@return INTEL.Cluster #cluster The cluster.
function INTEL:_CreateClusterFromContact(Contact) end

---Create an #INTEL.Contact item from a given GROUP or STATIC object.
---
------
---@param self INTEL 
---@param Positionable POSITIONABLE The GROUP or STATIC object.
---@param RecceName string The name of the recce group that has detected this contact.
---@return INTEL.Contact #The contact.
function INTEL:_CreateContact(Positionable, RecceName) end

---Get closest cluster of contact.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@return INTEL.Cluster #The cluster this contact is part of or `#nil` otherwise.
---@return number #Distance to cluster in meters.
function INTEL:_GetClosestClusterOfContact(Contact) end

---Get distance to cluster.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact.
---@param Cluster INTEL.Cluster The cluster to which the distance is calculated.
---@return number #Distance in meters.
function INTEL:_GetDistContactToCluster(Contact, Cluster) end

---Check if a Contact is already known.
---It is checked, whether the contact is in the contacts table.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact The contact to be added.
---@return boolean #If `true`, contact is already known.
function INTEL:_IsContactKnown(Contact) end

---Update coordinates of the known clusters.
---
------
---@param self INTEL 
function INTEL:_UpdateClusterPositions() end

---Update an #INTEL.Contact item.
---
------
---@param self INTEL 
---@param Contact INTEL.Contact Contact.
---@return INTEL.Contact #The contact.
function INTEL:_UpdateContact(Contact) end

---Triggers the FSM event "Start" after a delay.
---Starts the INTEL. Initializes parameters and starts event handlers.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
function INTEL:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
function INTEL:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the INTEL and all its event handlers.
---
------
---@param self INTEL 
---@param delay number Delay in seconds.
function INTEL:__Stop(delay) end

---On after "LostCluster" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cluster INTEL.Cluster Lost cluster.
---@param Mission AUFTRAG The Auftrag connected with this cluster or `nil`.
function INTEL:onafterLostCluster(From, Event, To, Cluster, Mission) end

---On after "LostContact" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Contact INTEL.Contact Lost contact.
function INTEL:onafterLostContact(From, Event, To, Contact) end

---On after "NewCluster" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Cluster INTEL.Cluster Detected cluster.
function INTEL:onafterNewCluster(From, Event, To, Cluster) end

---On after "NewContact" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Contact INTEL.Contact Detected contact.
function INTEL:onafterNewContact(From, Event, To, Contact) end

---On after Start event.
---Starts the FLIGHTGROUP FSM and event handlers.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function INTEL:onafterStart(From, Event, To) end

---On after "Status" event.
---
------
---@param self INTEL 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function INTEL:onafterStatus(From, Event, To) end


---Cluster info.
---@class INTEL.Cluster 
---@field altitude number [AIR] Average flight altitude of the cluster in meters.
---@field coordinate COORDINATE Coordinate of the cluster.
---@field ctype string Cluster type of #INTEL.Ctype.
---@field index number Cluster index.
---@field marker MARKER F10 marker.
---@field markerID number Marker ID.
---@field mission AUFTRAG The current Auftrag attached to this cluster.
---@field size number Number of groups in the cluster.
---@field threatlevelAve number Average of threat levels.
---@field threatlevelMax number Max threat level of cluster.
---@field threatlevelSum number Sum of threat levels.
INTEL.Cluster = {}


---Detected item info.
---@class INTEL.Contact 
---@field Tdetected number Time stamp in abs. mission time seconds when this item was last detected.
---@field altitude number [AIR] Flight altitude of the contact in meters.
---@field attribute string Generalized attribute.
---@field category number Category number.
---@field categoryname string Category name.
---@field ctype string Contact type of #INTEL.Ctype.
---@field group GROUP The contact group.
---@field groupname string Name of the group.
---@field heading number [AIR] Heading of the contact, if available.
---@field isStatic boolean If `true`, contact is a STATIC object.
---@field isground boolean If `true`, contact is a ground group.
---@field ishelo boolean If `true`, contact is a helo group.
---@field isship boolean If `true`, contact is a naval group.
---@field maneuvering boolean [AIR] Contact has changed direction by >10 deg.
---@field mission AUFTRAG The current Auftrag attached to this contact.
---@field platform string [AIR] Contact platform name, e.g. Foxbat, Flanker_E, defaults to Bogey if unknown
---@field position COORDINATE Last known position of the item.
---@field recce string The name of the recce unit that detected this contact.
---@field speed number Last known speed in m/s.
---@field target TARGET The Target attached to this contact.
---@field threatlevel number Threat level of this item.
---@field typename string Type name of detected item.
---@field velocity Vec3 3D velocity vector. Components x,y and z in m/s.
INTEL.Contact = {}


---Contact or cluster type.
---@class INTEL.Ctype 
---@field AIRCRAFT string Airpane or helicopter.
---@field GROUND string Ground.
---@field NAVAL string Ship.
---@field STRUCTURE string Static structure.
INTEL.Ctype = {}


---INTEL_DLINK data aggregator
---INTEL_DLINK class.
---@class INTEL_DLINK : FSM
---@field ClassName string Name of the class.
---@field alias string Alias name for logging.
---@field cachetime number Number of seconds to keep an object.
---@field interval number Number of seconds between collection runs.
---@field lid string Class id string for output to DCS log file.
---@field verbose number Make the logging verbose.
---@field version string Version string
INTEL_DLINK = {}

---Function to add an #INTEL object to the aggregator
---
------
---@param self INTEL_DLINK 
---@param Intel INTEL the #INTEL object to add
---@return INTEL_DLINK #self
function INTEL_DLINK:AddIntel(Intel) end

---Triggers the FSM event "Collect".
---Used internally to collect all data.
---
------
---@param self INTEL_DLINK 
function INTEL_DLINK:Collect() end

---Function to query the detected clusters
---
------
---@param self INTEL_DLINK 
---@return table #Table of #INTEL.Cluster clusters
function INTEL_DLINK:GetClusterTable() end

---Function to query the detected contacts
---
------
---@param self INTEL_DLINK 
---@return table #Table of #INTEL.Contact contacts
function INTEL_DLINK:GetContactTable() end

---Function to query the detected contact coordinates
---
------
---@param self INTEL_DLINK 
---@return table #Table of the contacts' Core.Point#COORDINATE objects.
function INTEL_DLINK:GetDetectedItemCoordinates() end

---Function to instantiate a new object
---
------
---
---USAGE
---```
---Use #INTEL_DLINK if you want to merge data from a number of #INTEL objects into one. This might be useful to simulate a
---Data Link, e.g. for Russian-tech based EWR, realising a Star Topology @{https://en.wikipedia.org/wiki/Network_topology#Star}
---in a basic setup. It will collect the contacts and clusters from the #INTEL objects.
---Contact duplicates are removed. Clusters might contain duplicates (Might fix that later, WIP).
---
---Basic setup:
---
---    local datalink = INTEL_DLINK:New({myintel1,myintel2}), "FSB", 20, 300)
---    datalink:__Start(2)
---
---Add an Intel while running:
---
---    datalink:AddIntel(myintel3)
---
---Gather the data:
---
---    datalink:GetContactTable() -- #table of #INTEL.Contact contacts.
---    datalink:GetClusterTable() -- #table of #INTEL.Cluster clusters.
---    datalink:GetDetectedItemCoordinates() -- #table of contact coordinates, to be compatible with @{Functional.Detection#DETECTION}.
---
---Gather data with the event function:
---
---    function datalink:OnAfterCollected(From, Event, To, Contacts, Clusters)
---      ... <your code here> ...
---    end
---```
------
---@param self INTEL_DLINK 
---@param Intels table Table of Ops.Intel#INTEL objects.
---@param Alias string (optional) Name of this instance. Default "SPECTRE"
---@param Interval number (optional) When to query #INTEL objects for detected items (default 20 seconds).
---@param Cachetime number (optional) How long to cache detected items (default 300 seconds).
function INTEL_DLINK:New(Intels, Alias, Interval, Cachetime) end

---On After "Collected" event.
---Data tables have been refreshed.
---
------
---@param self INTEL_DLINK 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Contacts table Table of #INTEL.Contact Contacts.
---@param Clusters table Table of #INTEL.Cluster Clusters.
function INTEL_DLINK:OnAfterCollected(From, Event, To, Contacts, Clusters) end

---Function to set how long INTEL DLINK remembers contacts.
---
------
---@param self INTEL_DLINK 
---@param seconds number Remember this many seconds. Defaults to 180.
---@return INTEL_DLINK #self
function INTEL_DLINK:SetDLinkCacheTime(seconds) end

---Pseudo Functions
-----------------------------------------------------------------------------------------------
---- Triggers the FSM event "Start".
---Starts the INTEL_DLINK.
---
------
---@param self INTEL_DLINK 
function INTEL_DLINK:Start() end

---Triggers the FSM event "Start" after a delay.
---Starts the INTEL_DLINK.
---
------
---@param self INTEL_DLINK 
---@param delay number Delay in seconds.
function INTEL_DLINK:__Start(delay) end

---Triggers the FSM event "Collect" after a delay.
---
------
---@param self INTEL_DLINK 
---@param delay number Delay in seconds.
function INTEL_DLINK:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the INTEL_DLINK.
---
------
---@param self INTEL_DLINK 
---@param delay number Delay in seconds.
function INTEL_DLINK:__Stop(delay) end

---Function to start the work.
---
------
---@param self INTEL_DLINK 
---@param From string The From state
---@param Event string The Event triggering this call
---@param To string The To state
---@return INTEL_DLINK #self
function INTEL_DLINK:onafterStart(From, Event, To) end

---Function to stop
---
------
---@param self INTEL_DLINK 
---@param From string The From state
---@param Event string The Event triggering this call
---@param To string The To state
---@return INTEL_DLINK #self
function INTEL_DLINK:onafterStop(From, Event, To) end

---Function to collect data from the various #INTEL
---
------
---@param self INTEL_DLINK 
---@param From string The From state
---@param Event string The Event triggering this call
---@param To string The To state
---@return INTEL_DLINK #self
function INTEL_DLINK:onbeforeCollect(From, Event, To) end

---Function called after collection is done
---
------
---@param self INTEL_DLINK 
---@param From string The From state
---@param Event string The Event triggering this call
---@param To string The To state
---@param Contacts table The table of collected #INTEL.Contact contacts
---@param Clusters table The table of collected #INTEL.Cluster clusters
---@return INTEL_DLINK #self
function INTEL_DLINK:onbeforeCollected(From, Event, To, Contacts, Clusters) end



