---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Client.JPG" width="100%">
---
---**Wrapper** - CLIENT wraps DCS Unit objects acting as a __Client__ or __Player__ within a mission.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**
---
---===
---Wrapper class of those **Units** defined within the Mission Editor that have the skillset defined as __Client__ or __Player__.
---
---Note that clients are NOT the same as Units, they are NOT necessarily alive.
---The CLIENT class is a wrapper class to handle the DCS Unit objects that have the skillset defined as __Client__ or __Player__:
---
--- * Wraps the DCS Unit objects with skill level set to Player or Client.
--- * Support all DCS Unit APIs.
--- * Enhance with Unit specific APIs not in the DCS Group API set.
--- * When player joins Unit, execute alive init logic.
--- * Handles messages to players.
--- * Manage the "state" of the DCS Unit.
---
---Clients are being used by the Tasking.Mission#MISSION class to follow players and register their successes.
--- 
---## CLIENT reference methods
---
---For each DCS Unit having skill level Player or Client, a CLIENT wrapper object (instance) will be created within the global _DATABASE object (an instance of Core.Database#DATABASE).
---This is done at the beginning of the mission (when the mission starts).
--- 
---The CLIENT class does not contain a :New() method, rather it provides :Find() methods to retrieve the object reference
---using the DCS Unit or the DCS UnitName.
---
---Another thing to know is that CLIENT objects do not "contain" the DCS Unit object. 
---The CLIENT methods will reference the DCS Unit object by name when it is needed during API execution.
---If the DCS Unit object does not exist or is nil, the CLIENT methods will return nil and log an exception in the DCS.log file.
--- 
---The CLIENT class provides the following functions to retrieve quickly the relevant CLIENT instance:
---
--- * #CLIENT.Find(): Find a CLIENT instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Unit object.
--- * #CLIENT.FindByName(): Find a CLIENT instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Unit name.
--- 
---**IMPORTANT: ONE SHOULD NEVER SANITIZE these CLIENT OBJECT REFERENCES! (make the CLIENT object references nil).**
---The CLIENT class
---@class CLIENT : UNIT
---@field AliveCheckScheduler NOTYPE 
---@field ClassName string Name of the class.
---@field ClientAlive boolean Client alive.
---@field ClientAlive2 boolean Client alive 2.
---@field ClientBriefing string Briefing.
---@field ClientBriefingShown boolean 
---@field ClientCallBack function Callback function.
---@field ClientGroupID number Group ID of the client.
---@field ClientGroupName string Group name.
---@field ClientName string Name of the client.
---@field ClientParameters table Parameters of the callback function.
---@field ClientTransport boolean 
---@field MessageSwitch boolean 
---@field Players table Player table.
---@field SpawnCoord COORDINATE Spawn coordinate from the template.
---@field _Menus table 
CLIENT = {}

---Adds a briefing to a CLIENT when a player joins a mission.
---
------
---@param ClientBriefing string is the text defining the Mission briefing.
---@return CLIENT #self
function CLIENT:AddBriefing(ClientBriefing) end

---Add player name.
---
------
---@param PlayerName string Name of the player.
---@return CLIENT #self
function CLIENT:AddPlayer(PlayerName) end

---Checks for a client alive event and calls a function on a continuous basis.
---Does **NOT** work for dynamic spawn client slots!
---
------
---@param CallBackFunction function Create a function that will be called when a player joins the slot.
---@param ...? NOTYPE (Optional) Arguments for callback function as comma separated list.
---@return CLIENT #
function CLIENT:Alive(CallBackFunction, ...) end

---Get number of associated players.
---
------
---@return number #Count
function CLIENT:CountPlayers() end

---Finds a CLIENT from the _DATABASE using the relevant DCS Unit.
---
------
---@param DCSUnit Unit The DCS unit of the client.
---@param Error boolean Throw an error message.
---@return CLIENT #The CLIENT found in the _DATABASE.
function CLIENT:Find(DCSUnit, Error) end

---Finds a CLIENT from the _DATABASE using the relevant Client Unit Name.
---As an optional parameter, a briefing text can be given also.
---
------
---
---USAGE
---```
----- Create new Clients.
--- local Mission = MISSIONSCHEDULER.AddMission( 'Russia Transport Troops SA-6', 'Operational', 'Transport troops from the control center to one of the SA-6 SAM sites to activate their operation.', 'Russia' )
--- Mission:AddGoal( DeploySA6TroopsGoal )
---
--- Mission:AddClient( CLIENT:FindByName( 'RU MI-8MTV2*HOT-Deploy Troops 1' ):Transport() )
--- Mission:AddClient( CLIENT:FindByName( 'RU MI-8MTV2*RAMP-Deploy Troops 3' ):Transport() )
--- Mission:AddClient( CLIENT:FindByName( 'RU MI-8MTV2*HOT-Deploy Troops 2' ):Transport() )
--- Mission:AddClient( CLIENT:FindByName( 'RU MI-8MTV2*RAMP-Deploy Troops 4' ):Transport() )
---```
------
---@param ClientName string Name of the DCS **Unit** as defined within the Mission Editor.
---@param ClientBriefing string Text that describes the briefing of the mission when a Player logs into the Client.
---@param Error boolean A flag that indicates whether an error should be raised if the CLIENT cannot be found. By default an error will be raised.
---@return CLIENT #
function CLIENT:FindByName(ClientName, ClientBriefing, Error) end

---Finds a CLIENT from the _DATABASE using the relevant player name.
---
------
---@param Name string Name of the player
---@return CLIENT #or nil if not found
function CLIENT:FindByPlayerName(Name) end

---Returns the DCSUnit of the CLIENT.
---
------
---@return Unit #
function CLIENT:GetClientGroupDCSUnit() end

---Get the group ID of the client.
---
------
---@return number #DCS#Group ID.
function CLIENT:GetClientGroupID() end

---Get the name of the group of the client.
---
------
---@return string #
function CLIENT:GetClientGroupName() end

---Returns the UNIT of the CLIENT.
---
------
---@return UNIT #The client UNIT or `nil`.
function CLIENT:GetClientGroupUnit() end

---Return the DCSGroup of a Client.
---This function is modified to deal with a couple of bugs in DCS 1.5.3
---
------
---@return Group #The group of the Client.
function CLIENT:GetDCSGroup() end

---Get name of player.
---
------
---@return string #Player name or `nil`.
function CLIENT:GetPlayer() end

---[Multi-Player Server] Return a table of attributes from CLIENT.
---If optional attribute is present, only that value is returned.
---
------
---
---USAGE
---```
---Returned table holds these attributes:
---
---         'id'    : player ID
---         'name'  : player name
---         'side'  : 0 - spectators, 1 - red, 2 - blue
---         'slot'  : slot ID of the player or 
---         'ping'  : ping of the player in ms
---         'ipaddr': IP address of the player, SERVER ONLY
---         'ucid'  : Unique Client Identifier, SERVER ONLY
---```
------
---@param Attribute? string (Optional) The attribute to obtain. List see below.
---@return table #PlayerInfo or nil if it cannot be found
function CLIENT:GetPlayerInfo(Attribute) end

---Get player name(s).
---
------
---@return table #List of player names or an empty table `{}`.
function CLIENT:GetPlayers() end

---[Multi-Player Server] Get UCID from a CLIENT.
---
------
---@return string #UCID
function CLIENT:GetUCID() end

---Checks if the CLIENT is a multi-seated UNIT.
---
------
---@return boolean #true if multi-seated.
function CLIENT:IsMultiSeated() end

---Evaluates if the CLIENT is a transport.
---
------
---@return boolean #true is a transport.
function CLIENT:IsTransport() end

---The main message driver for the CLIENT.
---This function displays various messages to the Player logged into the CLIENT through the DCS World Messaging system.
---
------
---@param Message string is the text describing the message.
---@param MessageDuration number is the duration in seconds that the Message should be displayed.
---@param MessageCategory string is the category of the message (the title).
---@param MessageInterval number is the interval in seconds between the display of the @{Core.Message#MESSAGE} when the CLIENT is in the air.
---@param MessageID string is the identifier of the message when displayed with intervals.
function CLIENT:Message(Message, MessageDuration, MessageCategory, MessageInterval, MessageID) end

---Transport defines that the Client is a Transport.
---Transports show cargo.
---
------
---@param ClientName string Name of the client unit.
---@return CLIENT #self
function CLIENT:Register(ClientName) end

---Remove player.
---
------
---@param PlayerName string Name of the player.
---@return CLIENT #self
function CLIENT:RemovePlayer(PlayerName) end

---Remove all players.
---
------
---@return CLIENT #self
function CLIENT:RemovePlayers() end

---Resets a CLIENT.
---
------
---@param ClientName string Name of the Group as defined within the Mission Editor. The Group must have a Unit with the type Client.
function CLIENT:Reset(ClientName) end

---Show the briefing of a CLIENT.
---
------
---@return CLIENT #self
function CLIENT:ShowBriefing() end

---Shows the AI.AI_Cargo#CARGO contained within the CLIENT to the player as a message.
---The AI.AI_Cargo#CARGO is shown using the Core.Message#MESSAGE distribution system.
---
------
function CLIENT:ShowCargo() end

---Show the mission briefing of a MISSION to the CLIENT.
---
------
---@param MissionBriefing string 
---@return CLIENT #self
function CLIENT:ShowMissionBriefing(MissionBriefing) end

---Transport defines that the Client is a Transport.
---Transports show cargo.
---
------
---@return CLIENT #self
function CLIENT:Transport() end


---
------
---@param SchedulerName NOTYPE 
function CLIENT:_AliveCheckScheduler(SchedulerName) end



