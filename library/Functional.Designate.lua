---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Designation.JPG" width="100%">
---
---**Functional** - Management of target **Designation**.
---Lase, smoke and illuminate targets.
---
---===
---
---## Features:
---
---  * Faciliate the communication of detected targets to players.
---  * Designate targets using lasers, through a menu system.
---  * Designate targets using smoking, through a menu system.
---  * Designate targets using illumination, through a menu system.
---  * Auto lase targets.
---  * Refresh detection upon specified time intervals.
---  * Prioritization on threat levels.
---  * Reporting system of threats.
--- 
---===
---
---## Additional Material:
---
---* **Demo Missions:** [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Designate)
---* **YouTube videos:** None
---* **Guides:** None
---
---===
---
---Targets detected by recce will be communicated to a group of attacking players.  
---A menu system is made available that allows to: 
---
---  * **Lased** for a period of time.
---  * **Smoked**. Artillery or airplanes with Illuminatino ordonance need to be present. (WIP, but early demo ready.)
---  * **Illuminated** through an illumination bomb. Artillery or airplanes with Illuminatino ordonance need to be present. (WIP, but early demo ready.
---
---The following terminology is being used throughout this document:
---
---  * The **DesignateObject** is the object of the DESIGNATE class, which is this class explained in the document.
---  * The **DetectionObject** is the object of a DETECTION_ class (DETECTION_TYPES, DETECTION_AREAS, DETECTION_UNITS), which is executing the detection and grouping of Targets into _DetectionItems_.
---  * **TargetGroups** is the list of detected target groupings by the _DetectionObject_. Each _TargetGroup_ contains a _TargetSet_.
---  * **TargetGroup** is one element of the __TargetGroups__ list, and contains a _TargetSet_.
---  * The **TargetSet** is a SET_UNITS collection of _Targets_, that have been detected by the _DetectionObject_.
---  * A **Target** is a detected UNIT object by the _DetectionObject_.
---  * A **Threat Level** is a number from 0 to 10 that is calculated based on the threat of the Target in an Air to Ground battle scenario.
---  * The **RecceSet** is a SET_GROUP collection that contains the **RecceGroups**.
---  * A **RecceGroup** is a GROUP object containing the **Recces**.
---  * A **Recce** is a UNIT object executing the reconnaissance as part the _DetectionObject_. A Recce can be of any UNIT type.
---  * An **AttackGroup** is a GROUP object that contain _Players_.
---  * A **Player** is an active CLIENT object containing a human player.
---  * A **Designate Menu** is the menu that is dynamically created during the designation process for each _AttackGroup_.
---
---# Player Manual
---
---![Banner Image](..\Presentations\DESIGNATE\Dia3.JPG)
---
---A typical mission setup would require Recce (a Core.Set of Recce) to be detecting potential targets.
---The DetectionObject will group the detected targets based on the detection method being used.
---Possible detection methods could be by Area, by Type or by Unit.
---Each grouping will result in a **TargetGroup**, for terminology and clarity we will use this term throughout the document.
---
---**Recce** require to have Line of Sight (LOS) towards the targets.
---The **Recce** will report any detected targets to the Players (on the picture Observers).
---When targets are detected, a menu will be made available that allows those **TargetGroups** to be designated.
---Designation can be done by Lasing, Smoking and Illumination.
---Smoking is useful during the day, while illumination is recommended to be used during the night.
---Smoking can designate specific targets, but not very precise, while lasing is very accurate and allows to
---players to attack the targets using laser guided bombs or rockets.
---Illumination will lighten up the Target Area.
---
---**Recce** can be ground based or airborne. Airborne **Recce** (AFAC) can be really useful to designate a large amount of targets
---in a wide open area, as airborne **Recce** has a large LOS.
---However, ground based **Recce** are very useful to smoke or illuminate targets, as they can be much closer
---to the Target Area.
---
---It is recommended to make the **Recce** invisible and immortal using the Mission Editor in DCS World.
---This will ensure that the detection process won't be interrupted and that targets can be designated.
---However, you don't have to, so to simulate a more real-word situation or simulation, **Recce can also be destroyed**!
--- 
---## 1. Player View (Observer)
---
---![Banner Image](..\Presentations\DESIGNATE\Dia4.JPG)
---
---The RecceSet is continuously detecting for potential Targets, 
---executing its task as part of the DetectionObject.
---Once Targets have been detected, the DesignateObject will trigger the **Detect Event**.
---
---In order to prevent an overflow in the DesignateObject of detected targets, 
---there is a maximum amount of TargetGroups 
---that can be put in **scope** of the DesignateObject.
---We call this the **MaximumDesignations** term.
---
---## 2. Designate Menu
---
---![Banner Image](..\Presentations\DESIGNATE\Dia5.JPG)
---
---For each detected TargetGroup, there is:
---
---  * A **Designate Menu** are created and continuously refreshed, containing the **DesignationID** and the **Designation Status**.
---  * The RecceGroups are reporting to each AttackGroup, sending **Messages** containing the Threat Level and the TargetSet composition.
---
---A Player can then select an action from the **Designate Menu**. 
---The Designation Status is shown between the (   ).
---
---It indicates for each TargetGroup the current active designation action applied:
---
---  * An "I" for Illumnation designation.
---  * An "S" for Smoking designation.
---  * An "L" for Lasing designation.
---
---Note that multiple designation methods can be active at the same time!
---Note the **Auto Lase** option. When switched on, the available **Recce** will lase 
---Targets when detected.
---
---Targets are designated per **Threat Level**. 
---The most threatening targets from an Air to Ground perspective, are designated first!
---This is for all designation methods.
---
---![Banner Image](..\Presentations\DESIGNATE\Dia6.JPG)
---
---Each Designate Menu has a sub menu structure, which allows specific actions to be triggered:
---
---  * Lase Targets using a specific laser code.
---  * Smoke Targets using a specific smoke color.
---  * Illuminate areas.
---
---## 3. Lasing Targets
---
---![Banner Image](..\Presentations\DESIGNATE\Dia7.JPG)
---
---Lasing targets is done as expected. Each available Recce can lase only ONE target through!
---
---![Banner Image](..\Presentations\DESIGNATE\Dia8.JPG)
---
---Lasing can be done for specific laser codes. The Su-25T requires laser code 1113, while the A-10A requires laser code 1680.
---For those, specific menu options can be made available for players to lase with these codes.
---Auto Lase (as explained above), will ensure continuous lasing of available targets.
---The status report shows which targets are being designated.
---
---The following logic is executed when a TargetGroup is selected to be *lased* from the Designation Menu:
---
---  * The RecceSet is searched for any Recce that is within *designation distance* from a Target in the TargetGroup that is currently not being designated.
---  * If there is a Recce found that is currently no designating a target, and is within designation distance from the Target, then that Target will be designated.
---  * During designation, any Recce that does not have Line of Sight (LOS) and is not within disignation distance from the Target, will stop designating the Target, and a report is given.
---  * When a Recce is designating a Target, and that Target is destroyed, then the Recce will stop designating the Target, and will report the event.
---  * When a Recce is designating a Target, and that Recce is destroyed, then the Recce will be removed from the RecceSet and designation will stop without reporting.
---  * When all RecceGroups are destroyed from the RecceSet, then the DesignationObject will stop functioning, and nothing will be reported.
---  
---In this way, DESIGNATE assists players to designate ground targets for a coordinated attack!
---
---## 4. Illuminating Targets
---
---![Banner Image](..\Presentations\DESIGNATE\Dia9.JPG)
---
---Illumination bombs are fired between 500 and 700 meters altitude and will burn about 2 minutes, while slowly decending.
---Each available recce within range will fire an illumination bomb.
---Illumination bombs can be fired in while lasing targets.
---When illumination bombs are fired, it will take about 2 minutes until a sequent bomb run can be requested using the menus.
---
---## 5. Smoking Targets
---
---![Banner Image](..\Presentations\DESIGNATE\Dia10.JPG)
---
---Smoke will fire for 5 minutes.
---Each available recce within range will smoke a target.
---Smoking can be requested while lasing targets.
---Smoke will appear "around" the targets, because of accuracy limitations.
---
---
---Have FUN!
---
---===
---
---### Contributions: 
---
---  * **Ciribob**: Showing the way how to lase targets + how laser codes work!!! Explained the autolase script.
---  * **EasyEB**: Ideas and Beta Testing
---  * **Wingthor**: Beta Testing
---
---### Authors: 
---
---  * **FlightControl**: Design & Programming
---
---===
---Manage the designation of detected targets.
---
---
---# 1. DESIGNATE constructor
---  
---  * #DESIGNATE.New(): Creates a new DESIGNATE object.
---
---# 2. DESIGNATE is a FSM
---
---Designate is a finite state machine, which allows for controlled transitions of states.
---
---## 2.1 DESIGNATE States
---
---  * **Designating** ( Group ): The designation process.
---
---## 2.2 DESIGNATE Events
---
---  * **#DESIGNATE.Detect**: Detect targets.
---  * **#DESIGNATE.LaseOn**: Lase the targets with the specified Index.
---  * **#DESIGNATE.LaseOff**: Stop lasing the targets with the specified Index.
---  * **#DESIGNATE.Smoke**: Smoke the targets with the specified Index.
---  * **#DESIGNATE.Status**: Report designation status.
---
---# 3. Maximum Designations
---
---In order to prevent an overflow of designations due to many Detected Targets, there is a 
---Maximum Designations scope that is set in the DesignationObject.
---
---The method #DESIGNATE.SetMaximumDesignations() will put a limit on the amount of designations (target groups) put in scope of the DesignationObject.
---Using the menu system, the player can "forget" a designation, so that gradually a new designation can be put in scope when detected.
---
---# 4. Laser codes
---
---## 4.1. Set possible laser codes
---
---An array of laser codes can be provided, that will be used by the DESIGNATE when lasing.
---The laser code is communicated by the Recce when it is lasing a larget.
---Note that the default laser code is 1113.
---Working known laser codes are: 1113,1462,1483,1537,1362,1214,1131,1182,1644,1614,1515,1411,1621,1138,1542,1678,1573,1314,1643,1257,1467,1375,1341,1275,1237
---
---Use the method #DESIGNATE.SetLaserCodes() to set the possible laser codes to be selected from.
---One laser code can be given or an sequence of laser codes through an table...
---
---    Designate:SetLaserCodes( 1214 )
---    
---The above sets one laser code with the value 1214.
---
---    Designate:SetLaserCodes( { 1214, 1131, 1614, 1138 } )
---    
---The above sets a collection of possible laser codes that can be assigned. **Note the { } notation!**
---
---## 4.2. Auto generate laser codes
---
---Use the method #DESIGNATE.GenerateLaserCodes() to generate all possible laser codes. Logic implemented and advised by Ciribob!
---
---## 4.3. Add specific lase codes to the lase menu
---
---Certain plane types can only drop laser guided ordonnance when targets are lased with specific laser codes.
---The SU-25T needs targets to be lased using laser code 1113.
---The A-10A needs targets to be lased using laser code 1680.
---
---The method #DESIGNATE.AddMenuLaserCode() to allow a player to lase a target using a specific laser code.
---Remove such a lase menu option using #DESIGNATE.RemoveMenuLaserCode().
---
---# 5. Autolase to automatically lase detected targets.
---
---DetectionItems can be auto lased once detected by Recces. As such, there is almost no action required from the Players using the Designate Menu.
---The **auto lase** function can be activated through the Designation Menu.
---Use the method #DESIGNATE.SetAutoLase() to activate or deactivate the auto lase function programmatically.
---Note that autolase will automatically activate lasing for ALL DetectedItems. Individual items can be switched-off if required using the Designation Menu.
---
---    Designate:SetAutoLase( true )
---
---Activate the auto lasing.
---
---# 6. Target prioritization on threat level
---
---Targets can be detected of different types in one DetectionItem. Depending on the type of the Target, a different threat level applies in an Air to Ground combat context.
---SAMs are of a higher threat than normal tanks. So, if the Target type was recognized, the Recces will select those targets that form the biggest threat first,
---and will continue this until the remaining vehicles with the lowest threat have been reached.
---
---This threat level prioritization can be activated using the method #DESIGNATE.SetThreatLevelPrioritization().
---If not activated, Targets will be selected in a random order, but most like those first which are the closest to the Recce marking the Target.
---
---    Designate:SetThreatLevelPrioritization( true )
---    
---The example will activate the threat level prioritization for this the Designate object. Threats will be marked based on the threat level of the Target.
---
---# 7. Designate Menu Location for a Mission
---
---You can make DESIGNATE work for a Tasking.Mission#MISSION object. In this way, the designate menu will not appear in the root of the radio menu, but in the menu of the Mission.
---Use the method #DESIGNATE.SetMission() to set the Tasking.Mission object for the designate function.
---
---# 8. Status Report
---
---A status report is available that displays the current Targets detected, grouped per DetectionItem, and a list of which Targets are currently being marked.
---
---  * The status report can be shown by selecting "Status" -> "Report Status" from the Designation menu .
---  * The status report can be automatically flashed by selecting "Status" -> "Flash Status On".
---  * The automatic flashing of the status report can be deactivated by selecting "Status" -> "Flash Status Off".
---  * The flashing of the status menu is disabled by default.
---  * The method #DESIGNATE.SetFlashStatusMenu() can be used to enable or disable to flashing of the status menu.
---  
---    Designate:SetFlashStatusMenu( true )
---    
---The example will activate the flashing of the status menu for this Designate object.
---@class DESIGNATE 
---@field AttackSet NOTYPE 
---@field CC NOTYPE 
---@field Designating table 
---@field Detection NOTYPE 
---@field FlashDetectionMessage table 
---@field FlashStatusMenu table 
---@field LaseStart NOTYPE 
---@field LaserCodesUsed table 
---@field MarkScheduler NOTYPE 
---@field MaximumDesignations NOTYPE 
---@field MaximumDistanceAirDesignation NOTYPE 
---@field MaximumDistanceDesignations NOTYPE 
---@field MaximumDistanceGroundDesignation NOTYPE 
---@field MaximumMarkings NOTYPE 
---@field MenuLaserCodes table 
---@field Mission NOTYPE 
---@field RecceSet NOTYPE 
---@field Recces table 
---@field ThreatLevelPrioritization NOTYPE 
DESIGNATE = {}

---Add a specific lase code to the designate lase menu to lase targets with a specific laser code.
---The MenuText will appear in the lase menu.
---
------
---
---USAGE
---```
---  RecceDesignation:AddMenuLaserCode( 1113, "Lase with %d for Su-25T" )
---  RecceDesignation:AddMenuLaserCode( 1680, "Lase with %d for A-10A" )
---```
------
---@param LaserCode number The specific laser code to be added to the lase menu.
---@param MenuText string The text to be shown to the player. If you specify a %d in the MenuText, the %d will be replaced with the LaserCode specified.
---@return DESIGNATE #
function DESIGNATE:AddMenuLaserCode(LaserCode, MenuText) end

---Coordinates the Auto Lase.
---
------
---@return DESIGNATE #
function DESIGNATE:CoordinateLase() end

---Adapt the designation scope according the detected items.
---
------
---@return DESIGNATE #
function DESIGNATE:DesignationScope() end

---Detect Trigger for DESIGNATE
---
------
function DESIGNATE:Detect() end

---Generate an array of possible laser codes.
---Each new lase will select a code from this table.
---The entered value can range from 1111 - 1788,
----- but the first digit of the series must be a 1 or 2
----- and the last three digits must be between 1 and 8.
--- The range used to be bugged so its not 1 - 8 but 0 - 7.
---function below will use the range 1-7 just in case
---
------
---@return DESIGNATE #
function DESIGNATE:GenerateLaserCodes() end

---Illuminate Trigger for DESIGNATE
---
------
function DESIGNATE:Illuminate() end

---LaseOff Trigger for DESIGNATE
---
------
function DESIGNATE:LaseOff() end

---LaseOn Trigger for DESIGNATE
---
------
function DESIGNATE:LaseOn() end


---
------
---@param AutoLase NOTYPE 
function DESIGNATE:MenuAutoLase(AutoLase) end


---
------
---@param AttackGroup NOTYPE 
---@param Flash NOTYPE 
function DESIGNATE:MenuFlashStatus(AttackGroup, Flash) end


---
------
---@param Index NOTYPE 
function DESIGNATE:MenuForget(Index) end


---
------
---@param Index NOTYPE 
function DESIGNATE:MenuIlluminate(Index) end


---
------
---@param Index NOTYPE 
---@param Duration NOTYPE 
---@param LaserCode NOTYPE 
function DESIGNATE:MenuLaseCode(Index, Duration, LaserCode) end


---
------
---@param Index NOTYPE 
---@param Duration NOTYPE 
function DESIGNATE:MenuLaseOff(Index, Duration) end


---
------
---@param Index NOTYPE 
---@param Duration NOTYPE 
function DESIGNATE:MenuLaseOn(Index, Duration) end


---
------
---@param Index NOTYPE 
---@param Color NOTYPE 
function DESIGNATE:MenuSmoke(Index, Color) end


---
------
---@param AttackGroup NOTYPE 
function DESIGNATE:MenuStatus(AttackGroup) end

---DESIGNATE Constructor.
---This class is an abstract class and should not be instantiated.
---
------
---@param CC COMMANDCENTER 
---@param Detection DETECTION_BASE 
---@param AttackSet SET_GROUP The Attack collection of GROUP objects to designate and report for.
---@param Mission? MISSION (Optional) The Mission where the menu needs to be attached.
---@return DESIGNATE #
function DESIGNATE:New(CC, Detection, AttackSet, Mission) end

---Detect Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterDetect(From, Event, To) end

---Illuminate Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterIlluminate(From, Event, To) end

---LaseOff Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterLaseOff(From, Event, To) end

---LaseOn Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterLaseOn(From, Event, To) end

---Smoke Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterSmoke(From, Event, To) end

---Status Handler OnAfter for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
function DESIGNATE:OnAfterStatus(From, Event, To) end

---Detect Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeDetect(From, Event, To) end

---Illuminate Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeIlluminate(From, Event, To) end

---LaseOff Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeLaseOff(From, Event, To) end

---LaseOn Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeLaseOn(From, Event, To) end

---Smoke Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeSmoke(From, Event, To) end

---Status Handler OnBefore for DESIGNATE
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function DESIGNATE:OnBeforeStatus(From, Event, To) end

---Removes a specific lase code from the designate lase menu.
---
------
---
---USAGE
---```
---  RecceDesignation:RemoveMenuLaserCode( 1113 )
---```
------
---@param LaserCode number The specific laser code that was set to be added to the lase menu.
---@return DESIGNATE #
function DESIGNATE:RemoveMenuLaserCode(LaserCode) end

---Sends the status to the Attack Groups.
---
------
---@param AttackGroup GROUP 
---@param Duration number The time in seconds the report should be visible.
---@param MenuAttackGroup NOTYPE 
---@return DESIGNATE #
function DESIGNATE:SendStatus(AttackGroup, Duration, MenuAttackGroup) end

---Set auto lase.
---Auto lase will start lasing targets immediately when these are in range.
---
------
---@param AutoLase? boolean (optional) true sets autolase on, false off. Default is off.
---@param Message? boolean (optional) true is send message, false or nil won't send a message. Default is no message sent.
---@return DESIGNATE #
function DESIGNATE:SetAutoLase(AutoLase, Message) end

---Sets the Designate Menu for all the attack groups.
---
------
---@return DESIGNATE #
function DESIGNATE:SetDesignateMenu() end

---Set the name of the designation.
---The name will appear in the menu.
---This method can be used to control different designations for different plane types.
---
------
---@param DesignateName string 
---@return DESIGNATE #
function DESIGNATE:SetDesignateName(DesignateName) end

---Set the flashing of the new detection messages.
---
------
---
---USAGE
---```
---
----- Enable the message flashing...
---Designate:SetFlashDetectionMessages( true )
---
----- Disable the message flashing...
---Designate:SetFlashDetectionMessages()
---
----- Disable the message flashing...
---Designate:SetFlashDetectionMessages( false )
---```
------
---@param FlashDetectionMessage boolean true: The detection message will be flashed every time a new detection was done; false: no messages will be displayed.
---@return DESIGNATE #
function DESIGNATE:SetFlashDetectionMessages(FlashDetectionMessage) end

---Set the flashing of the status menu for all AttackGroups.
---
------
---
---USAGE
---```
---
----- Enable the designate status message flashing...
---Designate:SetFlashStatusMenu( true )
---
----- Disable the designate statusmessage flashing...
---Designate:SetFlashStatusMenu()
---
----- Disable the designate status message flashing...
---Designate:SetFlashStatusMenu( false )
---```
------
---@param FlashMenu boolean true: the status menu will be flashed every detection run; false: no flashing of the menu.
---@return DESIGNATE #
function DESIGNATE:SetFlashStatusMenu(FlashMenu) end

---Set the lase duration for designations.
---
------
---@param LaseDuration number The time in seconds a lase will continue to hold on target. The default is 120 seconds.
---@return DESIGNATE #
function DESIGNATE:SetLaseDuration(LaseDuration) end

---Set an array of possible laser codes.
---Each new lase will select a code from this table.
---
------
---@param LaserCodes list 
---@return DESIGNATE #
function DESIGNATE:SetLaserCodes(LaserCodes) end

---Set the maximum amount of designations (target groups).
---This will put a limit on the amount of designations in scope.
---Using the menu system, the player can "forget" a designation, so that gradually a new designation can be put in scope when detected.
---
------
---@param MaximumDesignations number 
---@return DESIGNATE #
function DESIGNATE:SetMaximumDesignations(MaximumDesignations) end

---Set the maximum air designation distance.
---
------
---@param MaximumDistanceAirDesignation number Maximum air designation distance in meters.
---@return DESIGNATE #
function DESIGNATE:SetMaximumDistanceAirDesignation(MaximumDistanceAirDesignation) end

---Set the overall maximum distance when designations can be accepted.
---
------
---@param MaximumDistanceDesignations number Maximum distance in meters to accept designations.
---@return DESIGNATE #
function DESIGNATE:SetMaximumDistanceDesignations(MaximumDistanceDesignations) end

---Set the maximum ground designation distance.
---
------
---@param MaximumDistanceGroundDesignation number Maximum ground designation distance in meters.
---@return DESIGNATE #
function DESIGNATE:SetMaximumDistanceGroundDesignation(MaximumDistanceGroundDesignation) end

---Set the maximum amount of markings FACs will do, per designated target group.
---This will limit the number of parallelly marked units of a target group.
---
------
---@param MaximumMarkings number Maximum markings FACs will do, per designated target group.
---@return DESIGNATE #
function DESIGNATE:SetMaximumMarkings(MaximumMarkings) end

---Sets the Designate Menu for one attack groups.
---
------
---@param AttackGroup NOTYPE 
---@return DESIGNATE #
function DESIGNATE:SetMenu(AttackGroup) end

---Set the MISSION object for which designate will function.
---When a MISSION object is assigned, the menu for the designation will be located at the Mission Menu.
---
------
---@param Mission MISSION The MISSION object.
---@return DESIGNATE #
function DESIGNATE:SetMission(Mission) end

---Set priorization of Targets based on the **Threat Level of the Target** in an Air to Ground context.
---
------
---@param Prioritize boolean 
---@return DESIGNATE #
function DESIGNATE:SetThreatLevelPrioritization(Prioritize) end

---Smoke Trigger for DESIGNATE
---
------
function DESIGNATE:Smoke() end

---Status Trigger for DESIGNATE
---
------
function DESIGNATE:Status() end

---Detect Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__Detect(Delay) end

---Illuminate Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__Illuminate(Delay) end

---LaseOff Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__LaseOff(Delay) end

---LaseOn Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__LaseOn(Delay) end

---Smoke Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__Smoke(Delay) end

---Status Asynchronous Trigger for DESIGNATE
---
------
---@param Delay number 
function DESIGNATE:__Status(Delay) end


---
------
---@return DESIGNATE #
---@private
function DESIGNATE:onafterDetect() end

---DoneIlluminating
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterDoneIlluminating(From, Event, To, Index) end

---DoneSmoking
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterDoneSmoking(From, Event, To, Index) end

---Illuminating
---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterIlluminate(From, Event, To, Index) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterLaseOff(From, Event, To, Index) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@param Duration NOTYPE 
---@param LaserCode NOTYPE 
---@private
function DESIGNATE:onafterLaseOn(From, Event, To, Index, Duration, LaserCode) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@param Duration NOTYPE 
---@param LaserCodeRequested NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterLasing(From, Event, To, Index, Duration, LaserCodeRequested) end


---
------
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param Index NOTYPE 
---@param Color NOTYPE 
---@return DESIGNATE #
---@private
function DESIGNATE:onafterSmoke(From, Event, To, Index, Color) end



