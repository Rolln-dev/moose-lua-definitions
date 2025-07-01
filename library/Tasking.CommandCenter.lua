---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Task_Command_Center.JPG" width="100%">
---
---**Tasking** - A command center governs multiple missions, and takes care of the reporting and communications.
---
---**Features:**
---
---  * Govern multiple missions.
---  * Communicate to coalitions, groups.
---  * Assign tasks.
---  * Manage the menus.
---  * Manage reference zones.
---
---===
--- 
---### Author: **FlightControl**
---
---### Contributions: 
---
---===
---Governs multiple missions, the tasking and the reporting.
---
---![Banner Image](..\Images\deprecated.png)
--- 
---Command centers govern missions, communicates the task assignments between human players of the coalition, and manages the menu flow.
---It can assign a random task to a player when requested.
---The commandcenter provides the facilitites to communicate between human players online, executing a task.
--- 
---## 1. Create a command center object.
---
---  * #COMMANDCENTER.New(): Creates a new COMMANDCENTER object.
---
---## 2. Command center mission management.
---
---Command centers manage missions. These can be added, removed and provides means to retrieve missions.
---These methods are heavily used by the task dispatcher classes.
---
---  * #COMMANDCENTER.AddMission(): Adds a mission to the commandcenter control.
---  * #COMMANDCENTER.RemoveMission(): Removes a mission to the commandcenter control.
---  * #COMMANDCENTER.GetMissions(): Retrieves the missions table controlled by the commandcenter.
---
---## 3. Communication management between players. 
---
---Command center provide means of communication between players. 
---Because a command center is a central object governing multiple missions,  
---there are several levels at which communication needs to be done.
---Within MOOSE, communication is facilitated using the message system within the DCS simulator.
---
---Messages can be sent between players at various levels:
---
---  - On a global level, to all players.
---  - On a coalition level, only to the players belonging to the same coalition.
---  - On a group level, to the players belonging to the same group.
---  
---Messages can be sent to **all players** by the command center using the method Tasking.CommandCenter#COMMANDCENTER.MessageToAll().
---
---To send messages to **the coalition of the command center**, there are two methods available:
--- 
---  - Use the method Tasking.CommandCenter#COMMANDCENTER.MessageToCoalition() to send a specific message to the coalition, with a given message display duration.
---  - You can send a specific type of message using the method Tasking.CommandCenter#COMMANDCENTER.MessageTypeToCoalition().
---    This will send a message of a specific type to the coalition, and as a result its display duration will be flexible according the message display time selection by the human player.
---    
---To send messages **to the group** of human players, there are also two methods available:
---
---  - Use the method Tasking.CommandCenter#COMMANDCENTER.MessageToGroup() to send a specific message to a group, with a given message display duration.
---  - You can send a specific type of message using the method Tasking.CommandCenter#COMMANDCENTER.MessageTypeToGroup().
---    This will send a message of a specific type to the group, and as a result its display duration will be flexible according the message display time selection by the human player .
---    
---Messages are considered to be sometimes disturbing for human players, therefore, the settings menu provides the means to activate or deactivate messages.
---For more information on the message types and display timings that can be selected and configured using the menu, refer to the Core.Settings menu description.
---    
---## 4. Command center detailed methods.
---
---Various methods are added to manage command centers.
---
---### 4.1. Naming and description.
---
---There are 3 methods that can be used to retrieve the description of a command center:
---
---  - Use the method Tasking.CommandCenter#COMMANDCENTER.GetName() to retrieve the name of the command center. 
---    This is the name given as part of the Tasking.CommandCenter#COMMANDCENTER.New() constructor.
---    The returned name using this method, is not to be used for message communication.
---
---A textual description can be retrieved that provides the command center name to be used within message communication:
---
---  - Tasking.CommandCenter#COMMANDCENTER.GetShortText() returns the command center name as `CC [CommandCenterName]`.
---  - Tasking.CommandCenter#COMMANDCENTER.GetText() returns the command center name as `Command Center [CommandCenterName]`.
---
---### 4.2. The coalition of the command center.
---
---The method Tasking.CommandCenter#COMMANDCENTER.GetCoalition() returns the coalition of the command center.
---The return value is an enumeration of the type DCS#coalition.side, which contains the RED, BLUE and NEUTRAL coalition. 
---
---### 4.3. The command center is a real object.
---
---The command center must be represented by a live object within the DCS simulator. As a result, the command center   
---can be a Wrapper.Unit, a Wrapper.Group, an Wrapper.Airbase or a Wrapper.Static object.
---
---Using the method Tasking.CommandCenter#COMMANDCENTER.GetPositionable() you retrieve the polymorphic positionable object representing
---the command center, but just be aware that you should be able to use the representable object derivation methods.
---
---### 5. Command center reports.
---
---Because a command center giverns multiple missions, there are several reports available that are generated by command centers.
---These reports are generated using the following methods:
---
---  - Tasking.CommandCenter#COMMANDCENTER.ReportSummary(): Creates a summary report of all missions governed by the command center.
---  - Tasking.CommandCenter#COMMANDCENTER.ReportDetails(): Creates a detailed report of all missions governed by the command center.
---  - Tasking.CommandCenter#COMMANDCENTER.ReportMissionPlayers(): Creates a report listing the players active at the missions governed by the command center.
---  
---## 6. Reference Zones.
---
---Command Centers may be aware of certain Reference Zones within the battleground. These Reference Zones can refer to
---known areas, recognizable buildings or sites, or any other point of interest.
---Command Centers will use these Reference Zones to help pilots with defining coordinates in terms of navigation
---during the WWII era.
---The Reference Zones are related to the WWII mode that the Command Center will operate in.
---Use the method #COMMANDCENTER.SetModeWWII() to set the mode of communication to the WWII mode.
---
---In WWII mode, the Command Center will receive detected targets, and will select for each target the closest
---nearby Reference Zone. This allows pilots to navigate easier through the battle field readying for combat.
---
---The Reference Zones need to be set by the Mission Designer in the Mission Editor.
---Reference Zones are set by normal trigger zones. One can color the zones in a specific color, 
---and the radius of the zones doesn't matter, only the point is important. Place the center of these Reference Zones at
---specific scenery objects or points of interest (like cities, rivers, hills, crossing etc).
---The trigger zones indicating a Reference Zone need to follow a specific syntax.
---The name of each trigger zone expressing a Reference Zone need to start with a classification name of the object,
---followed by a #, followed by a symbolic name of the Reference Zone.
---A few examples:
---
---  * A church at Tskinvali would be indicated as: *Church#Tskinvali*
---  * A train station near Kobuleti would be indicated as: *Station#Kobuleti*
---  
---The COMMANDCENTER class contains a method to indicate which trigger zones need to be used as Reference Zones.
---This is done by using the method #COMMANDCENTER.SetReferenceZones().
---For the moment, only one Reference Zone class can be specified, but in the future, more classes will become possible.
---
---## 7. Tasks.
---
---### 7.1. Automatically assign tasks.
---
---One of the most important roles of the command center is the management of tasks.
---The command center can assign automatically tasks to the players using the Tasking.CommandCenter#COMMANDCENTER.SetAutoAssignTasks() method.
---When this method is used with a parameter true; the command center will scan at regular intervals which players in a slot are not having a task assigned.
---For those players; the tasking is enabled to assign automatically a task.
---An Assign Menu will be accessible for the player under the command center menu, to configure the automatic tasking to switched on or off.
---
---### 7.2. Automatically accept assigned tasks.
---
---When a task is assigned; the mission designer can decide if players are immediately assigned to the task; or they can accept/reject the assigned task.
---Use the method Tasking.CommandCenter#COMMANDCENTER.SetAutoAcceptTasks() to configure this behaviour.
---If the tasks are not automatically accepted; the player will receive a message that he needs to access the command center menu and
---choose from 2 added menu options either to accept or reject the assigned task within 30 seconds.
---If the task is not accepted within 30 seconds; the task will be cancelled and a new task will be assigned.
---
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---The COMMANDCENTER class
---@deprecated
---@class COMMANDCENTER : BASE
---@field AutoAssignMethods COMMANDCENTER.AutoAssignMethods 
---@field CommandCenterCoalition coalition 
---@field CommandCenterPositionable NOTYPE 
---@field CommunicationMode string 
---@field HQ GROUP 
---@field Missions table 
---@field private autoAssignTasksScheduleID NOTYPE 
COMMANDCENTER = {}

---Get all the Groups active within the command center.
---
------
---@param self COMMANDCENTER 
---@return SET_GROUP #The set of groups active within the command center.
function COMMANDCENTER:AddGroups() end

---Add a MISSION to be governed by the HQ command center.
---
------
---@param self COMMANDCENTER 
---@param Mission MISSION 
---@return MISSION #
function COMMANDCENTER:AddMission(Mission) end

---Assigns a random task to a TaskGroup.
---
------
---@param self COMMANDCENTER 
---@param TaskGroup NOTYPE 
---@return COMMANDCENTER #
function COMMANDCENTER:AssignTask(TaskGroup) end

---Automatically assigns tasks to all TaskGroups.
---
------
---@param self COMMANDCENTER 
function COMMANDCENTER:AssignTasks() end

---Gets the coalition of the command center.
---
------
---@param self COMMANDCENTER 
---@return number #Coalition of the command center.
function COMMANDCENTER:GetCoalition() end

---Gets the commandcenter menu structure governed by the HQ command center.
---
------
---@param self COMMANDCENTER 
---@param TaskGroup Group Task Group.
---@return MENU_COALITION #
function COMMANDCENTER:GetMenu(TaskGroup) end

---Get the Missions governed by the HQ command center.
---
------
---@param self COMMANDCENTER 
---@return list #
function COMMANDCENTER:GetMissions() end

---Gets the name of the HQ command center.
---
------
---@param self COMMANDCENTER 
---@return string #
function COMMANDCENTER:GetName() end

---Gets the POSITIONABLE of the HQ command center.
---
------
---@param self COMMANDCENTER 
---@return POSITIONABLE #
function COMMANDCENTER:GetPositionable() end

---Gets the short text string of the HQ command center.
---
------
---@param self COMMANDCENTER 
---@return string #
function COMMANDCENTER:GetShortText() end

---Gets the text string of the HQ command center.
---
------
---@param self COMMANDCENTER 
---@return string #
function COMMANDCENTER:GetText() end

---Checks of the command center has the given MissionGroup.
---
------
---@param self COMMANDCENTER 
---@param MissionGroup GROUP The group active within one of the missions governed by the command center.
---@return boolean #
function COMMANDCENTER:HasGroup(MissionGroup) end

---Checks of the TaskGroup has a Task.
---
------
---@param self COMMANDCENTER 
---@param TaskGroup NOTYPE 
---@return boolean #When true, the TaskGroup has a Task, otherwise the returned value will be false.
function COMMANDCENTER:IsGroupAssigned(TaskGroup) end

---Returns if the commandcenter operations is in WWII mode
---
------
---@param self COMMANDCENTER 
---@return boolean #true if in WWII mode.
function COMMANDCENTER:IsModeWWII() end

---Let the command center send a Message to all players.
---
------
---@param self COMMANDCENTER 
---@param Message string The message text.
function COMMANDCENTER:MessageToAll(Message) end

---Let the command center send a message to the coalition of the command center.
---
------
---@param self COMMANDCENTER 
---@param Message string The message text.
function COMMANDCENTER:MessageToCoalition(Message) end

---Let the command center send a message to the MessageGroup.
---
------
---@param self COMMANDCENTER 
---@param Message string The message text.
---@param MessageGroup GROUP The group to receive the message.
function COMMANDCENTER:MessageToGroup(Message, MessageGroup) end

---Let the command center send a message of a specified type to the coalition of the command center.
---
------
---@param self COMMANDCENTER 
---@param Message string The message text.
---@param MessageType MESSAGE.MessageType The type of the message, resulting in automatic time duration and prefix of the message.
function COMMANDCENTER:MessageTypeToCoalition(Message, MessageType) end

---Let the command center send a message to the MessageGroup.
---
------
---@param self COMMANDCENTER 
---@param Message string The message text.
---@param MessageGroup GROUP The group to receive the message.
---@param MessageType MESSAGE.MessageType The type of the message, resulting in automatic time duration and prefix of the message.
function COMMANDCENTER:MessageTypeToGroup(Message, MessageGroup, MessageType) end

---The constructor takes an IDENTIFIABLE as the HQ command center.
---
------
---@param self COMMANDCENTER 
---@param CommandCenterPositionable POSITIONABLE 
---@param CommandCenterName string 
---@return COMMANDCENTER #
function COMMANDCENTER:New(CommandCenterPositionable, CommandCenterName) end

---Removes a MISSION to be governed by the HQ command center.
---The given Mission is not nilified.
---
------
---@param self COMMANDCENTER 
---@param Mission MISSION 
---@return MISSION #
function COMMANDCENTER:RemoveMission(Mission) end

---Let the command center send a report of the status of a task to a group.
---Report the details of a Mission, listing the Mission, and all the Task details.
---
------
---@param self COMMANDCENTER 
---@param ReportGroup GROUP The group to receive the report.
---@param Task TASK The task to be reported.
function COMMANDCENTER:ReportDetails(ReportGroup, Task) end

---Let the command center send a report of the players of all missions to a group.
---Each Mission is listed, with an indication how many Tasks are still to be completed.
---
------
---@param self COMMANDCENTER 
---@param ReportGroup GROUP The group to receive the report.
function COMMANDCENTER:ReportMissionsPlayers(ReportGroup) end

---Let the command center send a report of the status of all missions to a group.
---Each Mission is listed, with an indication how many Tasks are still to be completed.
---
------
---@param self COMMANDCENTER 
---@param ReportGroup GROUP The group to receive the report.
function COMMANDCENTER:ReportSummary(ReportGroup) end

---Automatically accept tasks for all TaskGroups.
---When a task is assigned; the mission designer can decide if players are immediately assigned to the task; or they can accept/reject the assigned task.
---If the tasks are not automatically accepted; the player will receive a message that he needs to access the command center menu and
---choose from 2 added menu options either to accept or reject the assigned task within 30 seconds.
---If the task is not accepted within 30 seconds; the task will be cancelled and a new task will be assigned.
---
------
---@param self COMMANDCENTER 
---@param AutoAccept boolean true for ON and false or nil for OFF.
function COMMANDCENTER:SetAutoAcceptTasks(AutoAccept) end

---Define the method to be used to assign automatically a task from the available tasks in the mission.
---There are 3 types of methods that can be applied for the moment:
---
---  1. Random - assigns a random task in the mission to the player.
---  2. Distance - assigns a task based on a distance evaluation from the player. The closest are to be assigned first.
---  3. Priority - assigns a task based on the priority as defined by the mission designer, using the SetTaskPriority parameter.
---  
---The different task classes implement the logic to determine the priority of automatic task assignment to a player, depending on one of the above methods.
---The method Tasking.Task#TASK.GetAutoAssignPriority calculate the priority of the tasks to be assigned.
---
------
---@param self COMMANDCENTER 
---@param AutoAssignMethod COMMANDCENTER.AutoAssignMethods A selection of an assign method from the COMMANDCENTER.AutoAssignMethods enumeration.
function COMMANDCENTER:SetAutoAssignMethod(AutoAssignMethod) end

---Automatically assigns tasks to all TaskGroups.
---One of the most important roles of the command center is the management of tasks.
---When this method is used with a parameter true; the command center will scan at regular intervals which players in a slot are not having a task assigned.
---For those players; the tasking is enabled to assign automatically a task.
---An Assign Menu will be accessible for the player under the command center menu, to configure the automatic tasking to switched on or off.
---
------
---@param self COMMANDCENTER 
---@param AutoAssign boolean true for ON and false or nil for OFF.
function COMMANDCENTER:SetAutoAssignTasks(AutoAssign) end

---Sets the menu of the command center.
---This command is called within the :New() method.
---
------
---@param self COMMANDCENTER 
function COMMANDCENTER:SetCommandMenu() end

---Let the command center flash a report of the status of the subscribed task to a group.
---
------
---@param self COMMANDCENTER 
---@param Flash NOTYPE #boolean
function COMMANDCENTER:SetFlashStatus(Flash) end

---Sets the menu structure of the Missions governed by the HQ command center.
---
------
---@param self COMMANDCENTER 
function COMMANDCENTER:SetMenu() end

---Duration a command center message is shown.
---
------
---@param self COMMANDCENTER 
---@param seconds NOTYPE #number
function COMMANDCENTER:SetMessageDuration(seconds) end

---Set the commandcenter operations in WWII mode
---This will disable LL, MGRS, BRA, BULLS navigatin messages sent by the Command Center, 
---and will be replaced by a navigation using Reference Zones.
---It will also disable the settings at the settings menu for these.
---
------
---@param self COMMANDCENTER 
---@return COMMANDCENTER #
function COMMANDCENTER:SetModeWWII() end

---Set special Reference Zones known by the Command Center to guide airborne pilots during WWII.
---
---These Reference Zones are normal trigger zones, with a special naming.
---The Reference Zones need to be set by the Mission Designer in the Mission Editor.
---Reference Zones are set by normal trigger zones. One can color the zones in a specific color, 
---and the radius of the zones doesn't matter, only the center of the zone is important. Place the center of these Reference Zones at
---specific scenery objects or points of interest (like cities, rivers, hills, crossing etc).
---The trigger zones indicating a Reference Zone need to follow a specific syntax.
---The name of each trigger zone expressing a Reference Zone need to start with a classification name of the object,
---followed by a #, followed by a symbolic name of the Reference Zone.
---A few examples:
---
---  * A church at Tskinvali would be indicated as: *Church#Tskinvali*
---  * A train station near Kobuleti would be indicated as: *Station#Kobuleti*
---
---Taking the above example, this is how this method would be used:
---
---    CC:SetReferenceZones( "Church" )
---    CC:SetReferenceZones( "Station" )
---
------
---@param self COMMANDCENTER 
---@param ReferenceZonePrefix string The name before the #-mark indicating the class of the Reference Zones.
---@return COMMANDCENTER #
function COMMANDCENTER:SetReferenceZones(ReferenceZonePrefix) end


---@class COMMANDCENTER.AutoAssignMethods 
---@field Distance number 
---@field Priority number 
---@field Random number 
COMMANDCENTER.AutoAssignMethods = {}



