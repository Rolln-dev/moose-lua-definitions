---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Radio.JPG" width="100%">
---
---**Sound** - Radio transmissions.
---
---===
---
---## Features:
---
---  * Provide radio functionality to broadcast radio transmissions.
---
---What are radio communications in DCS?
---
---  * Radio transmissions consist of **sound files** that are broadcasted on a specific **frequency** (e.g. 115MHz) and **modulation** (e.g. AM),
---  * They can be **subtitled** for a specific **duration**, the **power** in Watts of the transmitter's antenna can be set, and the transmission can be **looped**.
---
---How to supply DCS my own Sound Files?
---
---  * Your sound files need to be encoded in **.ogg** or .wav,
---  * Your sound files should be **as tiny as possible**. It is suggested you encode in .ogg with low bitrate and sampling settings,
---  * They need to be added in .\l10n\DEFAULT\ in you .miz file (which can be decompressed like a .zip file),
---  * For simplicity sake, you can **let DCS' Mission Editor add the file** itself, by creating a new Trigger with the action "Sound to Country", and choosing your sound file and a country you don't use in your mission.
---
---Due to weird DCS quirks, **radio communications behave differently** if sent by a Wrapper.Unit#UNIT or a Wrapper.Group#GROUP or by any other Wrapper.Positionable#POSITIONABLE
---
---  * If the transmitter is a Wrapper.Unit#UNIT or a Wrapper.Group#GROUP, DCS will set the power of the transmission automatically,
---  * If the transmitter is any other Wrapper.Positionable#POSITIONABLE, the transmisison can't be subtitled or looped.
---
---Note that obviously, the **frequency** and the **modulation** of the transmission are important only if the players are piloting an **Advanced System Modelling** enabled aircraft,
---like the A10C or the Mirage 2000C. They will **hear the transmission** if they are tuned on the **right frequency and modulation** (and if they are close enough - more on that below).
---If an FC3 aircraft is used, it will **hear every communication, whatever the frequency and the modulation** is set to. The same is true for TACAN beacons. If your aircraft isn't compatible,
---you won't hear/be able to use the TACAN beacon information.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Sound/Radio)
---
---===
---
---### Authors: Hugues "Grey_Echo" Bousquet, funkyfranky
---*It's not true I had nothing on, I had the radio on.* -- Marilyn Monroe
---
---# RADIO usage
---
---There are 3 steps to a successful radio transmission.
---
---  * First, you need to **"add a #RADIO object** to your Wrapper.Positionable#POSITIONABLE. This is done using the Wrapper.Positionable#POSITIONABLE.GetRadio() function,
---  * Then, you will **set the relevant parameters** to the transmission (see below),
---  * When done, you can actually **broadcast the transmission** (i.e. play the sound) with the #RADIO.Broadcast() function.
---
---Methods to set relevant parameters for both a Wrapper.Unit#UNIT or a Wrapper.Group#GROUP or any other Wrapper.Positionable#POSITIONABLE
---
---  * #RADIO.SetFileName() : Sets the file name of your sound file (e.g. "Noise.ogg"),
---  * #RADIO.SetFrequency() : Sets the frequency of your transmission.
---  * #RADIO.SetModulation() : Sets the modulation of your transmission.
---  * #RADIO.SetLoop() : Choose if you want the transmission to be looped. If you need your transmission to be looped, you might need a #BEACON instead...
---
---Additional Methods to set relevant parameters if the transmitter is a Wrapper.Unit#UNIT or a Wrapper.Group#GROUP
---
---  * #RADIO.SetSubtitle() : Set both the subtitle and its duration,
---  * #RADIO.NewUnitTransmission() : Shortcut to set all the relevant parameters in one method call
---
---Additional Methods to set relevant parameters if the transmitter is any other Wrapper.Positionable#POSITIONABLE
---
---  * #RADIO.SetPower() : Sets the power of the antenna in Watts
---  * #RADIO.NewGenericTransmission() : Shortcut to set all the relevant parameters in one method call
---
---What is this power thing?
---
---  * If your transmission is sent by a Wrapper.Positionable#POSITIONABLE other than a Wrapper.Unit#UNIT or a Wrapper.Group#GROUP, you can set the power of the antenna,
---  * Otherwise, DCS sets it automatically, depending on what's available on your Unit,
---  * If the player gets **too far** from the transmitter, or if the antenna is **too weak**, the transmission will **fade** and **become noisyer**,
---  * This an automated DCS calculation you have no say on,
---  * For reference, a standard VOR station has a 100 W antenna, a standard AA TACAN has a 120 W antenna, and civilian ATC's antenna usually range between 300 and 500 W,
---  * Note that if the transmission has a subtitle, it will be readable, regardless of the quality of the transmission.
---@class RADIO : BASE
---@field ClassName string 
---@field FileName string Name of the sound file played.
---@field Frequency number Frequency of the transmission in Hz.
---@field Loop boolean Transmission is repeated (default true).
---@field Modulation number Modulation of the transmission (either radio.modulation.AM or radio.modulation.FM).
---@field Positionable CONTROLLABLE The @{#CONTROLLABLE} that will transmit the radio calls.
---@field Power number Power of the antenna is Watts.
---@field Subtitle string Subtitle of the transmission.
---@field SubtitleDuration number Duration of the Subtitle in seconds.
---@field private alias string Name of the radio transmitter.
---@field private moduhasbeenset boolean 
RADIO = {}

---Broadcast the transmission.
---* The Radio has to be populated with the new transmission before broadcasting.
---* Please use RADIO setters or either #RADIO.NewGenericTransmission or #RADIO.NewUnitTransmission
---* This class is in fact pretty smart, it determines the right DCS function to use depending on the type of POSITIONABLE
---* If the POSITIONABLE is not a UNIT or a GROUP, we use the generic (but limited) trigger.action.radioTransmission()
---* If the POSITIONABLE is a UNIT or a GROUP, we use the "TransmitMessage" Command
---* If your POSITIONABLE is a UNIT or a GROUP, the Power is ignored.
---* If your POSITIONABLE is not a UNIT or a GROUP, the Subtitle, SubtitleDuration are ignored
---
------
---@param self RADIO 
---@param viatrigger boolean Use trigger.action.radioTransmission() in any case, i.e. also for UNITS and GROUPS.
---@return RADIO #self
function RADIO:Broadcast(viatrigger) end

---Get alias of the transmitter.
---
------
---@param self RADIO 
---@return string #Name of the transmitter.
function RADIO:GetAlias() end

---Create a new RADIO Object.
---This doesn't broadcast a transmission, though, use #RADIO.Broadcast to actually broadcast.
---If you want to create a RADIO, you probably should use Wrapper.Positionable#POSITIONABLE.GetRadio() instead.
---
------
---@param self RADIO 
---@param Positionable POSITIONABLE The @{Wrapper.Positionable#POSITIONABLE} that will receive radio capabilities.
---@return RADIO #The RADIO object or #nil if Positionable is invalid.
function RADIO:New(Positionable) end

---Create a new transmission, that is to say, populate the RADIO with relevant data
---In this function the data is especially relevant if the broadcaster is anything but a UNIT or a GROUP,
---but it will work with a UNIT or a GROUP anyway.
---Only the #RADIO and the Filename are mandatory
---
------
---@param self RADIO 
---@param FileName string Name of the sound file that will be transmitted.
---@param Frequency number Frequency in MHz.
---@param Modulation number Modulation of frequency, which is either radio.modulation.AM or radio.modulation.FM.
---@param Power number Power in W.
---@param Loop NOTYPE 
---@return RADIO #self
function RADIO:NewGenericTransmission(FileName, Frequency, Modulation, Power, Loop) end

---Create a new transmission, that is to say, populate the RADIO with relevant data
---In this function the data is especially relevant if the broadcaster is a UNIT or a GROUP,
---but it will work for any Wrapper.Positionable#POSITIONABLE.
---Only the RADIO and the Filename are mandatory.
---
------
---@param self RADIO 
---@param FileName string Name of sound file.
---@param Subtitle string Subtitle to be displayed with sound file.
---@param SubtitleDuration number Duration of subtitle display in seconds.
---@param Frequency number Frequency in MHz.
---@param Modulation number Modulation which can be either radio.modulation.AM or radio.modulation.FM
---@param Loop boolean If true, loop message.
---@return RADIO #self
function RADIO:NewUnitTransmission(FileName, Subtitle, SubtitleDuration, Frequency, Modulation, Loop) end

---Set alias of the transmitter.
---
------
---@param self RADIO 
---@param alias string Name of the radio transmitter.
---@return RADIO #self
function RADIO:SetAlias(alias) end

---Set the file name for the radio transmission.
---
------
---@param self RADIO 
---@param FileName string File name of the sound file (i.e. "Noise.ogg")
---@return RADIO #self
function RADIO:SetFileName(FileName) end

---Set the frequency for the radio transmission.
---If the transmitting positionable is a unit or group, this also set the command "SetFrequency" with the defined frequency and modulation.
---
------
---@param self RADIO 
---@param Frequency number Frequency in MHz.
---@return RADIO #self
function RADIO:SetFrequency(Frequency) end

---Set message looping on or off.
---
------
---@param self RADIO 
---@param Loop boolean If true, message is repeated indefinitely.
---@return RADIO #self
function RADIO:SetLoop(Loop) end

---Set AM or FM modulation of the radio transmitter.
---Set this before you set a frequency!
---
------
---@param self RADIO 
---@param Modulation number Modulation is either radio.modulation.AM or radio.modulation.FM.
---@return RADIO #self
function RADIO:SetModulation(Modulation) end

---Check validity of the power passed and sets RADIO.Power
---
------
---@param self RADIO 
---@param Power number Power in W.
---@return RADIO #self
function RADIO:SetPower(Power) end

---Check validity of the subtitle and the subtitleDuration  passed and sets RADIO.subtitle and RADIO.subtitleDuration
---Both parameters are mandatory, since it wouldn't make much sense to change the Subtitle and not its duration
---
------
---
---USAGE
---```
----- create the broadcaster and attaches it a RADIO
---local MyUnit = UNIT:FindByName("MyUnit")
---local MyUnitRadio = MyUnit:GetRadio()
---
----- add a subtitle for the next transmission, which will be up for 10s
---MyUnitRadio:SetSubtitle("My Subtitle, 10)
---```
------
---@param self RADIO 
---@param Subtitle string 
---@param SubtitleDuration number in s
---@return RADIO #self
function RADIO:SetSubtitle(Subtitle, SubtitleDuration) end

---Stops a transmission
---This function is especially useful to stop the broadcast of looped transmissions
---
------
---@param self RADIO 
---@return RADIO #self
function RADIO:StopBroadcast() end



