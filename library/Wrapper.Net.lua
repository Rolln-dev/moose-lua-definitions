---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Utils_Profiler.jpg" width="100%">
---
---**Wrapper** - DCS net functions.
---
---Encapsules **multiplayer server** environment scripting functions from [net](https://wiki.hoggitworld.com/view/DCS_singleton_net)
---
---===
---
---### Author: **Applevangelist**
---# Last Update Oct 2023
---
---===
---Encapsules multiplayer environment scripting functions from [net](https://wiki.hoggitworld.com/view/DCS_singleton_net)
---with some added FSM functions and options to block/unblock players in MP environments.
---The NET class
---@class NET : FSM
---@field BlockMessage string 
---@field BlockTime number 
---@field BlockedPilots table 
---@field BlockedSides table 
---@field BlockedSlots table 
---@field BlockedUCIDs table 
---@field ClassName string 
---@field KnownPilots table 
---@field UnblockMessage string 
---@field Version string 
---@field private lid string 
NET = {}

---Block a player.
---
------
---@param Client CLIENT CLIENT object.
---@param PlayerName? string (optional) Name of the player.
---@param Seconds? number (optional) Number of seconds the player has to wait before rejoining.
---@param Message? string (optional) Message to be sent via chat.
---@return NET #self
function NET:BlockPlayer(Client, PlayerName, Seconds, Message) end

---Block a SET_CLIENT of players
---
------
---@param PlayerSet SET_CLIENT The SET to block.
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@param Message? string (optional) Message to be sent via chat.
---@return NET #self
function NET:BlockPlayerSet(PlayerSet, Seconds, Message) end

---Block a specific coalition side, does NOT automatically kick all players of that side or kick out joined players
---
------
---@param Side number The side to block - 1 : Red, 2 : Blue
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET #self
function NET:BlockSide(Side, Seconds) end

---Block a specific player slot, does NOT automatically kick a player in that slot or kick out joined players
---
------
---@param slot string The slot to block
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@param Slot NOTYPE 
---@return NET #self
function NET:BlockSlot(slot, Seconds, Slot) end

---Block a specific UCID of a player, does NOT automatically kick the player with the UCID if already joined.
---
------
---@param ucid string 
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@return NET #self
function NET:BlockUCID(ucid, Seconds) end

---Executes a lua string in a given lua environment in the game.
---
------
---
---USAGE
---```
---States are:
---'config': the state in which $INSTALL_DIR/Config/main.cfg is executed, as well as $WRITE_DIR/Config/autoexec.cfg  - used for configuration settings
---'mission': holds current mission
---'export': runs $WRITE_DIR/Scripts/Export.lua and the relevant export API
---```
------
---@param State string The state in which to execute - see below.
---@param DoString string The lua string to be executed.
---@return string #Output
function NET:DoStringIn(State, DoString) end

---Force the slot for a specific client.
---If this returns false, it didn't work via `net` (which is ALWAYS the case as of Nov 2024)!
---
------
---@param Client CLIENT The client
---@param SideID number i.e. 0 : spectators, 1 : Red, 2 : Blue
---@param SlotID number Slot number
---@return boolean #Success
function NET:ForceSlot(Client, SideID, SlotID) end

--- Get some data of pilots who have currently joined
---
------
---@param Client CLIENT Provide either the client object whose data to find **or**
---@param Name string The player name whose data to find 
---@return table #Table of #NET.PlayerData or nil if not found
function NET:GetKnownPilotData(Client, Name) end

---Returns the playerID of the local player.
---Always returns 1 for server.
---
------
---@return number #ID
function NET:GetMyPlayerID() end

---Return the name of a given client.
---Effectively the same as CLIENT:GetPlayerName().
---
------
---@param Client CLIENT The client
---@return string #Name or nil if not obtainable
function NET:GetName(Client) end

---Find the PlayerID by name
---
------
---@param Name string The player name whose ID to find
---@return number #PlayerID or nil
function NET:GetPlayerIDByName(Name) end

---Find the PlayerID from a CLIENT object.
---
------
---@param Client CLIENT The client
---@return number #PlayerID or nil
function NET:GetPlayerIDFromClient(Client) end

---Return a table of attributes for a given client.
---If optional attribute is present, only that value is returned.
---
------
---
---USAGE
---```
---Table holds these attributes:
---
---         'id'    : playerID
---         'name'  : player name
---         'side'  : 0 - spectators, 1 - red, 2 - blue
---         'slot'  : slotID of the player or 
---         'ping'  : ping of the player in ms
---         'ipaddr': IP address of the player, SERVER ONLY
---         'ucid'  : Unique Client Identifier, SERVER ONLY
---```
------
---@param Client CLIENT The client.
---@param Attribute? string (Optional) The attribute to obtain. List see below.
---@return table #PlayerInfo or nil if it cannot be found
function NET:GetPlayerInfo(Client, Attribute) end

---Return a table of players currently connected to the server.

---
------
---@return table #PlayerList
function NET:GetPlayerList() end

---Return a statistic for a given client.

---
------
---
---USAGE
---```
---StatisticIDs are:
---
---net.PS_PING  (0) - ping (in ms)
---net.PS_CRASH (1) - number of crashes
---net.PS_CAR   (2) - number of destroyed vehicles
---net.PS_PLANE (3) - ... planes/helicopters
---net.PS_SHIP  (4) - ... ships
---net.PS_SCORE (5) - total score
---net.PS_LAND  (6) - number of landings
---net.PS_EJECT (7) - of ejects
---
---         mynet:GetPlayerStatistic(Client,7) -- return number of ejects
---```
------
---@param Client CLIENT The client
---@param StatisticID number The statistic to obtain
---@return number #Statistic or nil
function NET:GetPlayerStatistic(Client, StatisticID) end

---Get player UCID from player CLIENT object or player name.
---Provide either one.
---
------
---@param Client CLIENT The client object to be used.
---@param Name string Player name to be used.
---@return boolean #success
function NET:GetPlayerUCID(Client, Name) end

---Returns the playerID of the server.
---Currently always returns 1.
---
------
---@return number #ID
function NET:GetServerID() end

---Returns the SideId and SlotId of a given client.
---
------
---@param Client CLIENT The client
---@return number #SideID i.e. 0 : spectators, 1 : Red, 2 : Blue
---@return number #SlotID
function NET:GetSlot(Client) end

---[Internal] Check any blockers
---
------
---@param UCID string 
---@param Name string 
---@param PlayerID number 
---@param PlayerSide number 
---@param PlayerSlot string 
---@return boolean #IsBlocked
function NET:IsAnyBlocked(UCID, Name, PlayerID, PlayerSide, PlayerSlot) end

---Converts a JSON string to a lua value.
---
------
---@return table #Lua
function NET.Json2Lua(Json) end

---Kicks a player from the server.
---Can display a message to the user.
---
------
---@param Client CLIENT The client
---@param Message? string (Optional) The message to send.
---@return boolean #success
function NET:Kick(Client, Message) end

--- Write an "INFO" entry to the DCS log file, with the message Message.
---
------
---@param Message string The message to be logged.
---@return NET #self
function NET:Log(Message) end

---Converts a lua value to a JSON string.
---
------
---@return table #Json
function NET.Lua2Json(Lua) end

---Instantiate a new NET object.
---
------
---@return NET #self
function NET:New() end

---FSM Function OnAfterPlayerBlocked.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT Client Object, might be nil.
---@param Name string Name of blocked Pilot.
---@param Seconds number Blocked for this number of seconds
---@return NET #self
function NET:OnAfterPlayerBlocked(From, Event, To, Client, Name, Seconds) end

---FSM Function OnAfterPlayerDied.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client UNIT Unit Object, might be nil.
---@param Name string Name of dead Pilot.
---@return NET #self
function NET:OnAfterPlayerDied(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerEjected.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client UNIT Unit Object, might be nil.
---@param Name string Name of leaving Pilot.
---@return NET #self
function NET:OnAfterPlayerEjected(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerJoined.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT Object.
---@param Name string Name of joining Pilot.
---@return NET #self
function NET:OnAfterPlayerJoined(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerLeft.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client UNIT Unit Object, might be nil.
---@param Name string Name of leaving Pilot.
---@return NET #self
function NET:OnAfterPlayerLeft(From, Event, To, Client, Name) end

---FSM Function OnAfterPlayerUnblocked.
---
------
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Client CLIENT Client Object, might be nil.
---@param Name string Name of unblocked Pilot.
---@return NET #self
function NET:OnAfterPlayerUnblocked(From, Event, To, Client, Name) end

---Force a client back to spectators.
---If this returns false, it didn't work via `net` (which is ALWAYS the case as of Nov 2024)!
---
------
---@param Client CLIENT The client
---@return boolean #Succes
function NET:ReturnToSpectators(Client) end

---Send chat message.
---
------
---@param Message string Message to send
---@param ToAll? boolean (Optional)
---@return NET #self
function NET:SendChat(Message, ToAll) end

---Send chat message to a specific player using the CLIENT object.
---
------
---@param Message string The text message
---@param ToClient CLIENT Client receiving the message
---@param FromClient? CLIENT (Optional) Client sending the message
---@return NET #self
function NET:SendChatToClient(Message, ToClient, FromClient) end

---Send chat message to a specific player using the player name
---
------
---@param Message string The text message
---@param ToPlayer string Player receiving the message
---@param FromPlayer string Optional) Player sending the message
---@return NET #self
function NET:SendChatToPlayer(Message, ToPlayer, FromPlayer) end

---Set block chat message.
---
------
---@param Text string The message
---@return NET #self
function NET:SetBlockMessage(Text) end

---Set block time in seconds.
---
------
---@param Seconds number Numnber of seconds this block will last. Defaults to 600.
---@return NET #self
function NET:SetBlockTime(Seconds) end

---Set unblock chat message.
---
------
---@param Text string The message
---@return NET #self
function NET:SetUnblockMessage(Text) end

---Unblock a player.
---
------
---@param Client CLIENT CLIENT object
---@param PlayerName? string (optional) Name of the player.
---@param Message? string (optional) Message to be sent via chat.
---@return NET #self
function NET:UnblockPlayer(Client, PlayerName, Message) end

---Unblock a SET_CLIENT of players
---
------
---@param PlayerSet SET_CLIENT The SET to unblock.
---@param Message? string (optional) Message to be sent via chat.
---@return NET #self
function NET:UnblockPlayerSet(PlayerSet, Message) end

---Unblock a specific coalition side.
---Does NOT unblock specifically blocked playernames or UCIDs.
---
------
---@param Seconds? number Seconds (optional) Number of seconds the player has to wait before rejoining.
---@param self NOTYPE 
---@param Side NOTYPE 
---@return NET #self
function NET.UnblockSide(side, Seconds, self, Side) end

---Unblock a specific slot.
---
------
---@param self NOTYPE 
---@param Slot NOTYPE 
---@return NET #self
function NET.UnblockSlot(slot, self, Slot) end

---Unblock a specific UCID of a player
---
------
---@param ucid string 
---@return NET #self
function NET:UnblockUCID(ucid) end

---[Internal] Event Handler
---
------
---@param EventData EVENTDATA 
---@return NET #self
function NET:_EventHandler(EventData) end

--- Stop the event functions
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return NET #self
---@private
function NET:onafterRun(From, Event, To) end

--- Status - housekeeping
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return NET #self
---@private
function NET:onafterStatus(From, Event, To) end

--- Stop the event functions
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return NET #self
---@private
function NET:onafterStop(From, Event, To) end


---@class NET.PlayerData 
---@field private id number 
---@field private name string 
---@field private side number 
---@field private slot number 
---@field private timestamp numner 
---@field private ucid string 
NET.PlayerData = {}



