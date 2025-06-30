---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Message.JPG" width="100%">
---
---**Core** - Informs the players using messages during a simulation.
---
---===
---
---## Features:
---
---  * A more advanced messaging system using the DCS message system.
---  * Time messages.
---  * Send messages based on a message type, which has a pre-defined duration that can be tweaked in SETTINGS.
---  * Send message to all players.
---  * Send messages to a coalition.
---  * Send messages to a specific group.
---  * Send messages to a specific unit or client.
---
---===
---Message System to display Messages to Clients, Coalitions or All.
---Messages are shown on the display panel for an amount of seconds, and will then disappear.
---Messages can contain a category which is indicating the category of the message.
---
---## MESSAGE construction
---
---Messages are created with #MESSAGE.New. Note that when the MESSAGE object is created, no message is sent yet.
---To send messages, you need to use the To functions.
---
---## Send messages to an audience
---
---Messages are sent:
---
---  * To a Wrapper.Client using #MESSAGE.ToClient().
---  * To a Wrapper.Group using #MESSAGE.ToGroup()
---  * To a Wrapper.Unit using #MESSAGE.ToUnit()
---  * To a coalition using #MESSAGE.ToCoalition().
---  * To the red coalition using #MESSAGE.ToRed().
---  * To the blue coalition using #MESSAGE.ToBlue().
---  * To all Players using #MESSAGE.ToAll().
---
---## Send conditionally to an audience
---
---Messages can be sent conditionally to an audience (when a condition is true):
---
---  * To all players using #MESSAGE.ToAllIf().
---  * To a coalition using #MESSAGE.ToCoalitionIf().
---
---===
---
---### Author: **FlightControl**
---### Contributions: **Applevangelist**
---
---===
---The MESSAGE class
---@class MESSAGE : BASE
---@field ClearScreen boolean 
---@field CoalitionSide  
---@field MessageCategory string 
---@field MessageDuration  
MESSAGE = {}

---Clears all previous messages from the screen before the new message is displayed.
---Not that this must come before all functions starting with ToX(), e.g. ToAll(), ToGroup() etc.
---
------
---@param self MESSAGE 
---@return MESSAGE #
function MESSAGE:Clear() end

---Creates a new MESSAGE object.
---Note that these MESSAGE objects are not yet displayed on the display panel. You must use the functions #MESSAGE.ToClient or #MESSAGE.ToCoalition or #MESSAGE.ToAll to send these Messages to the respective recipients.
---
------
---
---USAGE
---```
---
---  -- Create a series of new Messages.
---  -- MessageAll is meant to be sent to all players, for 25 seconds, and is classified as "Score".
---  -- MessageRED is meant to be sent to the RED players only, for 10 seconds, and is classified as "End of Mission", with ID "Win".
---  -- MessageClient1 is meant to be sent to a Client, for 25 seconds, and is classified as "Score", with ID "Score".
---  -- MessageClient1 is meant to be sent to a Client, for 25 seconds, and is classified as "Score", with ID "Score".
---  MessageAll = MESSAGE:New( "To all Players: BLUE has won! Each player of BLUE wins 50 points!",  25, "End of Mission" )
---  MessageRED = MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty" )
---  MessageClient1 = MESSAGE:New( "Congratulations, you've just hit a target",  25, "Score" )
---  MessageClient2 = MESSAGE:New( "Congratulations, you've just killed a target", 25, "Score")
---```
------
---@param self NOTYPE 
---@param Text string is the text of the Message.
---@param Duration number Duration in seconds how long the message text is shown.
---@param Category string (Optional) String expressing the "category" of the Message. The category will be shown as the first text in the message followed by a ": ".
---@param ClearScreen boolean (optional) Clear all previous messages if true.
---@return MESSAGE #self
function MESSAGE:New(Text, Duration, Category, ClearScreen) end

---Creates a new MESSAGE object of a certain type.
---Note that these MESSAGE objects are not yet displayed on the display panel.
---You must use the functions Core.Message#ToClient or Core.Message#ToCoalition or Core.Message#ToAll to send these Messages to the respective recipients.
---The message display times are automatically defined based on the timing settings in the Core.Settings menu.
---
------
---
---USAGE
---```
---
---  MessageAll = MESSAGE:NewType( "To all Players: BLUE has won! Each player of BLUE wins 50 points!", MESSAGE.Type.Information )
---  MessageRED = MESSAGE:NewType( "To the RED Players: You receive a penalty because you've killed one of your own units", MESSAGE.Type.Information )
---  MessageClient1 = MESSAGE:NewType( "Congratulations, you've just hit a target", MESSAGE.Type.Update )
---  MessageClient2 = MESSAGE:NewType( "Congratulations, you've just killed a target", MESSAGE.Type.Update )
---```
------
---@param self NOTYPE 
---@param MessageText string is the text of the Message.
---@param MessageType MESSAGE.Type The type of the message.
---@param ClearScreen boolean (optional) Clear all previous messages.
---@return MESSAGE #
function MESSAGE:NewType(MessageText, MessageType, ClearScreen) end

---Set up MESSAGE generally to allow Text-To-Speech via SRS and TTS functions.
---`SetMSRS()` will try to use as many attributes configured with Sound.SRS#MSRS.LoadConfigFile() as possible.
---
------
---
---USAGE
---```
---         -- Mind the dot here, not using the colon this time around!
---         -- Needed once only
---         MESSAGE.SetMSRS("D:\\Program Files\\DCS-SimpleRadio-Standalone",5012,nil,127,radio.modulation.FM,"female","en-US",nil,coalition.side.BLUE)
---         -- later on in your code
---         MESSAGE:New("Test message!",15,"SPAWN"):ToSRS()
---```
------
---@param PathToSRS string (optional) Path to SRS Folder, defaults to "C:\\\\Program Files\\\\DCS-SimpleRadio-Standalone" or your configuration file setting.
---@param Port number Port (optional) number of SRS, defaults to 5002 or your configuration file setting.
---@param PathToCredentials string (optional) Path to credentials file for Google.
---@param Frequency number Frequency in MHz. Can also be given as a #table of frequencies.
---@param Modulation number Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations.
---@param Gender string (optional) Gender, i.e. "male" or "female", defaults to "female" or your configuration file setting.
---@param Culture string (optional) Culture, e.g. "en-US", defaults to "en-GB" or your configuration file setting.
---@param Voice string (optional) Voice. Will override gender and culture settings, e.g. MSRS.Voices.Microsoft.Hazel or MSRS.Voices.Google.Standard.de_DE_Standard_D. Hint on Microsoft voices - working voices are limited to Hedda, Hazel, David, Zira and Hortense. **Must** be installed on your Desktop or Server!
---@param Coalition number (optional) Coalition, can be coalition.side.RED, coalition.side.BLUE or coalition.side.NEUTRAL. Defaults to coalition.side.NEUTRAL.
---@param Volume number (optional) Volume, can be between 0.0 and 1.0 (loudest).
---@param Label string (optional) Label, defaults to "MESSAGE" or the Message Category set.
---@param Coordinate COORDINATE (optional) Coordinate this messages originates from.
---@param Backend string (optional) Backend to be used, can be MSRS.Backend.SRSEXE or MSRS.Backend.GRPC
function MESSAGE.SetMSRS(PathToSRS, Port, PathToCredentials, Frequency, Modulation, Gender, Culture, Voice, Coalition, Volume, Label, Coordinate, Backend) end

---Sends a MESSAGE to all players.
---
------
---
---USAGE
---```
---
---  -- Send a message created to all players.
---  MessageAll = MESSAGE:New( "To all Players: BLUE has won! Each player of BLUE wins 50 points!", 25, "End of Mission"):ToAll()
---  or
---  MESSAGE:New( "To all Players: BLUE has won! Each player of BLUE wins 50 points!", 25, "End of Mission"):ToAll()
---  or
---  MessageAll = MESSAGE:New( "To all Players: BLUE has won! Each player of BLUE wins 50 points!", 25, "End of Mission")
---  MessageAll:ToAll()
---```
------
---@param self MESSAGE 
---@param Settings Settings (Optional) Settings for message display.
---@param Delay number (Optional) Delay in seconds before the message is send. Default instantly (`nil`).
---@return MESSAGE #self
function MESSAGE:ToAll(Settings, Delay) end

---Sends a MESSAGE to all players if the given Condition is true.
---
------
---@param self MESSAGE 
---@param Condition boolean 
---@return MESSAGE #
function MESSAGE:ToAllIf(Condition) end

---Sends a MESSAGE to the Blue coalition.
---
------
---
---USAGE
---```
---
---  -- Send a message created with the @{New} method to the BLUE coalition.
---  MessageBLUE = MESSAGE:New( "To the BLUE Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToBlue()
---  or
---  MESSAGE:New( "To the BLUE Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToBlue()
---  or
---  MessageBLUE = MESSAGE:New( "To the BLUE Players: You receive a penalty because you've killed one of your own units", 25, "Penalty")
---  MessageBLUE:ToBlue()
---```
------
---@param self MESSAGE 
---@return MESSAGE #
function MESSAGE:ToBlue() end

---Sends a MESSAGE to a Client Group.
---Note that the Group needs to be defined within the ME with the skillset "Client" or "Player".
---
------
---
---USAGE
---```
---
---  -- Send the 2 messages created with the @{New} method to the Client Group.
---  -- Note that the Message of MessageClient2 is overwriting the Message of MessageClient1.
---  Client = CLIENT:FindByName("NameOfClientUnit")
---
---  MessageClient1 = MESSAGE:New( "Congratulations, you've just hit a target", 25, "Score" ):ToClient( Client )
---  MessageClient2 = MESSAGE:New( "Congratulations, you've just killed a target", 25, "Score" ):ToClient( Client )
---  or
---  MESSAGE:New( "Congratulations, you've just hit a target", 25, "Score"):ToClient( Client )
---  MESSAGE:New( "Congratulations, you've just killed a target", 25, "Score"):ToClient( Client )
---  or
---  MessageClient1 = MESSAGE:New( "Congratulations, you've just hit a target", 25, "Score")
---  MessageClient2 = MESSAGE:New( "Congratulations, you've just killed a target", 25, "Score")
---  MessageClient1:ToClient( Client )
---  MessageClient2:ToClient( Client )
---```
------
---@param self MESSAGE 
---@param Client CLIENT is the Group of the Client.
---@param Settings SETTINGS used to display the message.
---@return MESSAGE #
function MESSAGE:ToClient(Client, Settings) end

---Sends a MESSAGE to a Coalition.
---
------
---
---USAGE
---```
---
---  -- Send a message created with the @{New} method to the RED coalition.
---  MessageRED = MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToCoalition( coalition.side.RED )
---  or
---  MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToCoalition( coalition.side.RED )
---  or
---  MessageRED = MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty")
---  MessageRED:ToCoalition( coalition.side.RED )
---```
------
---@param self MESSAGE 
---@param CoalitionSide coalition.side @{#DCS.coalition.side} to which the message is displayed.
---@param Settings SETTINGS (Optional) Settings for message display.
---@return MESSAGE #Message object.
function MESSAGE:ToCoalition(CoalitionSide, Settings) end

---Sends a MESSAGE to a Coalition if the given Condition is true.
---
------
---@param self MESSAGE 
---@param CoalitionSide NOTYPE needs to be filled out by the defined structure of the standard scripting engine @{#DCS.coalition.side}.
---@param Condition boolean Sends the message only if the condition is true.
---@return MESSAGE #self
function MESSAGE:ToCoalitionIf(CoalitionSide, Condition) end

---Sends a MESSAGE to a Country.
---
------
---@param self MESSAGE 
---@param Country number to which the message is displayed, e.g. country.id.GERMANY. For all country numbers see here: [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@param Settings Settings (Optional) Settings for message display.
---@return MESSAGE #Message object.
function MESSAGE:ToCountry(Country, Settings) end

---Sends a MESSAGE to a Country.
---
------
---@param self MESSAGE 
---@param Country number to which the message is displayed, , e.g. country.id.GERMANY. For all country numbers see here: [Hoggit Wiki](https://wiki.hoggitworld.com/view/DCS_enum_country)
---@param Condition boolean Sends the message only if the condition is true.
---@param Settings Settings (Optional) Settings for message display.
---@return MESSAGE #Message object.
function MESSAGE:ToCountryIf(Country, Condition, Settings) end

---Sends a MESSAGE to a Group.
---
------
---@param self MESSAGE 
---@param Group GROUP to which the message is displayed.
---@param Settings Settings (Optional) Settings for message display.
---@return MESSAGE #Message object.
function MESSAGE:ToGroup(Group, Settings) end

---Sends a MESSAGE to DCS log file.
---
------
---@param self MESSAGE 
---@return MESSAGE #self
function MESSAGE:ToLog() end

---Sends a MESSAGE to DCS log file if the given Condition is true.
---
------
---@param self MESSAGE 
---@param Condition NOTYPE 
---@return MESSAGE #self
function MESSAGE:ToLogIf(Condition) end

---Sends a MESSAGE to the Red Coalition.
---
------
---
---USAGE
---```
---
---  -- Send a message created with the @{New} method to the RED coalition.
---  MessageRED = MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToRed()
---  or
---  MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty"):ToRed()
---  or
---  MessageRED = MESSAGE:New( "To the RED Players: You receive a penalty because you've killed one of your own units", 25, "Penalty")
---  MessageRED:ToRed()
---```
------
---@param self MESSAGE 
---@return MESSAGE #
function MESSAGE:ToRed() end

---Sends a message via SRS.
---`ToSRS()` will try to use as many attributes configured with Core.Message#MESSAGE.SetMSRS() and Sound.SRS#MSRS.LoadConfigFile() as possible.
---
------
---
---USAGE
---```
---         -- Mind the dot here, not using the colon this time around!
---         -- Needed once only
---         MESSAGE.SetMSRS("D:\\Program Files\\DCS-SimpleRadio-Standalone",5012,nil,127,radio.modulation.FM,"female","en-US",nil,coalition.side.BLUE)
---         -- later on in your code
---         MESSAGE:New("Test message!",15,"SPAWN"):ToSRS()
---```
------
---@param self MESSAGE 
---@param frequency number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture string (optional) Culture, e.g. "en-US". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coalition number (optional) Coalition, can be coalition.side.RED, coalition.side.BLUE or coalition.side.NEUTRAL. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE #self
function MESSAGE:ToSRS(frequency, modulation, gender, culture, voice, coalition, volume, coordinate) end

---Sends a message via SRS to all - via the neutral coalition side.
---
------
---
---USAGE
---```
---         -- Mind the dot here, not using the colon this time around!
---         -- Needed once only
---         MESSAGE.SetMSRS("D:\\Program Files\\DCS-SimpleRadio-Standalone",5012,nil,127,radio.modulation.FM,"female","en-US",nil,coalition.side.NEUTRAL)
---         -- later on in your code
---         MESSAGE:New("Test message!",15,"SPAWN"):ToSRSAll()
---```
------
---@param self MESSAGE 
---@param frequency number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE #self
function MESSAGE:ToSRSAll(frequency, modulation, gender, culture, voice, volume, coordinate) end

---Sends a message via SRS on the blue coalition side.
---
------
---
---USAGE
---```
---         -- Mind the dot here, not using the colon this time around!
---         -- Needed once only
---         MESSAGE.SetMSRS("D:\\Program Files\\DCS-SimpleRadio-Standalone",5012,nil,127,radio.modulation.FM,"female","en-US",nil,coalition.side.BLUE)
---         -- later on in your code
---         MESSAGE:New("Test message!",15,"SPAWN"):ToSRSBlue()
---```
------
---@param self MESSAGE 
---@param frequency number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE #self
function MESSAGE:ToSRSBlue(frequency, modulation, gender, culture, voice, volume, coordinate) end

---Sends a message via SRS on the red coalition side.
---
------
---
---USAGE
---```
---         -- Mind the dot here, not using the colon this time around!
---         -- Needed once only
---         MESSAGE.SetMSRS("D:\\Program Files\\DCS-SimpleRadio-Standalone",5012,nil,127,radio.modulation.FM,"female","en-US",nil,coalition.side.RED)
---         -- later on in your code
---         MESSAGE:New("Test message!",15,"SPAWN"):ToSRSRed()
---```
------
---@param self MESSAGE 
---@param frequency number (optional) Frequency in MHz. Can also be given as a #table of frequencies. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param modulation number (optional) Modulation, i.e. radio.modulation.AM  or radio.modulation.FM. Can also be given as a #table of modulations. Only needed if you want to override defaults set with `MESSAGE.SetMSRS()` for this one setting.
---@param gender string (optional) Gender, i.e. "male" or "female". Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param culture string (optional) Culture, e.g. "en-US. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param voice string (optional) Voice. Will override gender and culture settings. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param volume number (optional) Volume, can be between 0.0 and 1.0 (loudest). Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@param coordinate COORDINATE (optional) Coordinate this messages originates from. Only needed if you want to change defaults set with `MESSAGE.SetMSRS()`.
---@return MESSAGE #self
function MESSAGE:ToSRSRed(frequency, modulation, gender, culture, voice, volume, coordinate) end

---Sends a MESSAGE to a Unit.
---
------
---@param self MESSAGE 
---@param Unit UNIT to which the message is displayed.
---@param Settings Settings (Optional) Settings for message display.
---@return MESSAGE #Message object.
function MESSAGE:ToUnit(Unit, Settings) end


---Message Types
---@class MESSAGE.Type 
---@field Briefing string 
---@field Detailed string 
---@field Information string 
---@field Overview string 
---@field Update string 
MESSAGE.Type = {}



