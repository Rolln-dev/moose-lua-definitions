---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Utilities** - Socket.
---
---**Main Features:**
---
---   * Creates UDP Sockets
---   * Send messages to Discord
---   * Compatible with [FunkMan](https://github.com/funkyfranky/FunkMan)
---   * Compatible with [DCSServerBot](https://github.com/Special-K-s-Flightsim-Bots/DCSServerBot)
---
---===
---
---### Author: **funkyfranky**
---**At times I feel like a socket that remembers its tooth.** -- Saul Bellow
---
---===
---
---# The SOCKET Concept
---
---Create a UDP socket server.
---It enables you to send messages to discord servers via discord bots.
---
---**Note** that you have to **de-sanitize** `require` and `package` in your `MissionScripting.lua` file, which is in your `DCS/Scripts` folder.
---SOCKET class.
---@class SOCKET : FSM
---@field ClassName string Name of the class.
---@field DataType SOCKET.DataType 
---@field UDPSendSocket NOTYPE 
---@field private host string The host.
---@field private json table JSON.
---@field private lid string Class id string for output to DCS log file.
---@field private port number The port.
---@field private socket table The socket.
---@field private verbose number Verbosity level.
---@field private version string SOCKET class version.
SOCKET = {}

---Create a new SOCKET object.
---
------
---@param Port number UDP port. Default `10042`.
---@param Host string Host. Default `"127.0.0.1"`.
---@return SOCKET #self
function SOCKET:New(Port, Host) end

---Send a table.
---
------
---@param Table table Table to send.
---@return SOCKET #self
function SOCKET:SendTable(Table) end

---Send a text message.
---
------
---@param Text string Text message.
---@return SOCKET #self
function SOCKET:SendText(Text) end

---Send a text-to-speech message.
---
------
---@param Text string The text message to speek.
---@param Provider number The TTS provider: 0=Microsoft (default), 1=Google.
---@param Voice string The specific voice to use, e.g. `"Microsoft David Desktop"` or "`en-US-Standard-A`". If not set, the service will choose a voice based on the other parameters such as culture and gender.
---@param Culture string The Culture or language code, *e.g.* `"en-US"`.
---@param Gender string The Gender, *i.e.* "male", "female". Default "female".
---@param Volume number The volume. Microsoft: [0,100] default 50, Google: [-96, 10] default 0.
---@return SOCKET #self
function SOCKET:SendTextToSpeech(Text, Provider, Voice, Culture, Gender, Volume) end

---Set host.
---
------
---@param Host string Host. Default `"127.0.0.1"`.
---@return SOCKET #self
function SOCKET:SetHost(Host) end

---Set port.
---
------
---@param Port number Port. Default 10042.
---@return SOCKET #self
function SOCKET:SetPort(Port) end


---Data type.
---This is the keyword the socket listener uses.
---@class SOCKET.DataType 
---@field BOMBRESULT string Range bombing.
---@field LSOGRADE string Airboss LSO grade.
---@field STRAFERESULT string Range strafeing result.
---@field TEXT string Plain text.
---@field TTS string Text-To-Speech.
SOCKET.DataType = {}



