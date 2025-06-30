---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Usersound.JPG" width="100%">
---
---**Sound** - Manage user sound.
---
---===
---
---## Features:
---
---  * Play sounds wihtin running missions.
---
---===
---
---Management of DCS User Sound.
---
---===
---
---### Author: **FlightControl**
---
---===
---Management of DCS User Sound.
---
---## USERSOUND constructor
---  
---  * #USERSOUND.New(): Creates a new USERSOUND object.
---@class USERSOUND 
---@field UserSoundFileName  
USERSOUND = {}

---USERSOUND Constructor.
---
------
---@param self USERSOUND 
---@param UserSoundFileName string The filename of the usersound.
---@return USERSOUND #
function USERSOUND:New(UserSoundFileName) end

---Set usersound filename.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  BlueVictory:SetFileName( "BlueVictoryLoud.ogg" ) -- Set the BlueVictory to change the file name to play a louder sound.
---```
------
---@param self USERSOUND 
---@param UserSoundFileName string The filename of the usersound.
---@return USERSOUND #The usersound instance.
function USERSOUND:SetFileName(UserSoundFileName) end

---Play the usersound to all players.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  BlueVictory:ToAll() -- Play the sound that Blue has won.
---```
------
---@param self USERSOUND 
---@return USERSOUND #The usersound instance.
function USERSOUND:ToAll() end

---Play the usersound to the given Wrapper.Client.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  local PlayerUnit = CLIENT:FindByPlayerName("Karl Heinz")-- Search for the active client with playername "Karl Heinz", a human player.
---  BlueVictory:ToClient( PlayerUnit ) -- Play the victory sound to the player unit.
---```
------
---@param self USERSOUND 
---@param The CLIENT @{Wrapper.Client} to play the usersound to.
---@param Delay number (Optional) Delay in seconds, before the sound is played. Default 0.
---@param Client NOTYPE 
---@return USERSOUND #The usersound instance.
function USERSOUND:ToClient(The, Delay, Client) end

---Play the usersound to the given coalition.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  BlueVictory:ToCoalition( coalition.side.BLUE ) -- Play the sound that Blue has won to the blue coalition.
---```
------
---@param self USERSOUND 
---@param Coalition coalition The coalition to play the usersound to.
---@return USERSOUND #The usersound instance.
function USERSOUND:ToCoalition(Coalition) end

---Play the usersound to the given country.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  BlueVictory:ToCountry( country.id.USA ) -- Play the sound that Blue has won to the USA country.
---```
------
---@param self USERSOUND 
---@param Country country The country to play the usersound to.
---@return USERSOUND #The usersound instance.
function USERSOUND:ToCountry(Country) end

---Play the usersound to the given Wrapper.Group.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  local PlayerGroup = GROUP:FindByName( "PlayerGroup" ) -- Search for the active group named "PlayerGroup", that contains a human player.
---  BlueVictory:ToGroup( PlayerGroup ) -- Play the victory sound to the player group.
---```
------
---@param self USERSOUND 
---@param Group GROUP The @{Wrapper.Group} to play the usersound to.
---@param Delay number (Optional) Delay in seconds, before the sound is played. Default 0.
---@return USERSOUND #The usersound instance.
function USERSOUND:ToGroup(Group, Delay) end

---Play the usersound to the given Wrapper.Unit.
---
------
---
---USAGE
---```
---  local BlueVictory = USERSOUND:New( "BlueVictory.ogg" )
---  local PlayerUnit = UNIT:FindByName( "PlayerUnit" ) -- Search for the active unit named "PlayerUnit", a human player.
---  BlueVictory:ToUnit( PlayerUnit ) -- Play the victory sound to the player unit.
---```
------
---@param self USERSOUND 
---@param Unit UNIT The @{Wrapper.Unit} to play the usersound to.
---@param Delay number (Optional) Delay in seconds, before the sound is played. Default 0.
---@return USERSOUND #The usersound instance.
function USERSOUND:ToUnit(Unit, Delay) end



