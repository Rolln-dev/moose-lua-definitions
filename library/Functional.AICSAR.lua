---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Functional** - AI CSAR system.
---
---===
---
---## Features:
---
---   * Send out helicopters to downed pilots
---   * Rescues players and AI alike
---   * Coalition specific
---   * Starting from a FARP or Airbase
---   * Dedicated MASH zone
---   * Some FSM functions to include in your mission scripts
---   * Limit number of available helos
---   * SRS voice output via TTS or soundfiles
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Functional/AICSAR).
---
---===
---
---### Author: **Applevangelist**
---Last Update Sept 2023
---
---===
---*I once donated a pint of my finest red corpuscles to the great American Red Cross and the doctor opined my blood was very helpful; contained so much alcohol they could use it to sterilize their instruments.*    
--- W.C.Fields
---
---===
---
---# AICSAR Concept
---
---For an AI or human pilot landing with a parachute, a rescue mission will be spawned.
---The helicopter will fly to the pilot, pick him or her up,
---and fly back to a designated MASH (medical) zone, drop the pilot and then return to base.
---Operational maxdistance can be set as well as the landing radius around the downed pilot.
---Keep in mind that AI helicopters cannot hover-load at the time of writing, so rescue operations over water or in the mountains might not
---work.
---Optionally, if you have a CSAR operation with human pilots in your mission, you can set AICSAR to ignore missions when human helicopter
---pilots are around.
---
---## Setup
---
---Setup is a one-liner:
---           
---           -- @param #string Alias Name of this instance.
---           -- @param #number Coalition Coalition as in coalition.side.BLUE, can also be passed as "blue", "red" or "neutral"
---           -- @param #string Pilottemplate Pilot template name.
---           -- @param #string Helotemplate Helicopter template name. Set the template to "cold start". Hueys work best.
---           -- @param Wrapper.Airbase#AIRBASE FARP FARP object or Airbase from where to start.
---           -- @param Core.Zone#ZONE MASHZone Zone where to drop pilots after rescue.
---           local my_aicsar=AICSAR:New("Luftrettung",coalition.side.BLUE,"Downed Pilot","Rescue Helo",AIRBASE:FindByName("Test FARP"),ZONE:New("MASH"))
---
---## Options are
--- 
---           my_aicsar.maxdistance -- maximum operational distance in meters. Defaults to 50NM or 92.6km
---           my_aicsar.rescuezoneradius -- landing zone around downed pilot. Defaults to 200m
---           my_aicsar.autoonoff -- stop operations when human helicopter pilots are around. Defaults to true.
---           my_aicsar.verbose -- text messages to own coalition about ongoing operations. Defaults to true.
---           my_aicsar.limithelos -- limit available number of helos going on mission (defaults to true)
---           my_aicsar.helonumber -- number of helos available (default: 3)
---           my_aicsar.verbose -- boolean, set to `true`for message output on-screen
---
---## Radio output options
---
---Radio messages, soundfile names and (for SRS) lengths are defined in three enumerators, so you can customize, localize messages and soundfiles to your liking:
---
---Defaults are:
---
---           AICSAR.Messages = {
---             EN = {
---             INITIALOK = "Roger, Pilot, we hear you. Stay where you are, a helo is on the way!",
---             INITIALNOTOK = "Sorry, Pilot. You're behind maximum operational distance! Good Luck!",
---             PILOTDOWN = "Mayday, mayday, mayday! Pilot down at ", -- note that this will be appended with the position in MGRS
---             PILOTKIA = "Pilot KIA!",
---             HELODOWN = "CSAR Helo Down!",
---             PILOTRESCUED = "Pilot rescued!",
---             PILOTINHELO = "Pilot picked up!",
---             },
---           }
---
---Correspondingly, sound file names are defined as these defaults:
---
---           AICSAR.RadioMessages = {
---             EN = {
---             INITIALOK = "initialok.ogg",
---             INITIALNOTOK = "initialnotok.ogg",
---             PILOTDOWN = "pilotdown.ogg",
---             PILOTKIA = "pilotkia.ogg", 
---             HELODOWN = "helodown.ogg", 
---             PILOTRESCUED = "pilotrescued.ogg", 
---             PILOTINHELO = "pilotinhelo.ogg",
---             }, 
---           }
---
---and these default transmission lengths in seconds:
---
---           AICSAR.RadioLength = {
---             EN = {
---             INITIALOK = 4.1,
---             INITIALNOTOK = 4.6, 
---             PILOTDOWN = 2.6,
---             PILOTKIA = 1.1,
---             HELODOWN = 2.1,
---             PILOTRESCUED = 3.5,
---             PILOTINHELO = 2.6,
---             },
---           }
---
---## Radio output via SRS and Text-To-Speech (TTS)
---
---Radio output can be done via SRS and Text-To-Speech. No extra sound files required! 
---[Initially, Have a look at the guide on setting up SRS TTS for Moose](https://github.com/FlightControl-Master/MOOSE_GUIDES/blob/master/documents/Moose%20TTS%20Setup%20Guide.pdf).
---The text from the `AICSAR.Messages` table above is converted on the fly to an .ogg-file, which is then played back via SRS on the selected frequency and mdulation.
---Hint - the small black window popping up shortly is visible in Single-Player only. 
---
---To set up AICSAR for SRS TTS output, add e.g. the following to your script:
---             
---             -- setup for google TTS, radio 243 AM, SRS server port 5002 with a google standard-quality voice (google cloud account required)
---             my_aicsar:SetSRSTTSRadio(true,"C:\\Program Files\\DCS-SimpleRadio-Standalone",243,radio.modulation.AM,5002,MSRS.Voices.Google.Standard.en_US_Standard_D,"en-US","female","C:\\Program Files\\DCS-SimpleRadio-Standalone\\google.json")
---             
---             -- alternatively for MS Desktop TTS (voices need to be installed locally first!)
---             my_aicsar:SetSRSTTSRadio(true,"C:\\Program Files\\DCS-SimpleRadio-Standalone",243,radio.modulation.AM,5002,MSRS.Voices.Microsoft.Hazel,"en-GB","female")
---             
---             -- define a different voice for the downed pilot(s)
---             my_aicsar:SetPilotTTSVoice(MSRS.Voices.Google.Standard.en_AU_Standard_D,"en-AU","male")
---             
---             -- define another voice for the operator
---             my_aicsar:SetOperatorTTSVoice(MSRS.Voices.Google.Standard.en_GB_Standard_A,"en-GB","female")
---
---## Radio output via preproduced soundfiles
---
---The easiest way to add a soundfile to your mission is to use the "Sound to..." trigger in the mission editor. This will effectively 
---save your sound file inside of the .miz mission file. [Example soundfiles are located on github](https://github.com/FlightControl-Master/MOOSE_SOUND/tree/master/AICSAR)
---
---To customize or localize your texts and sounds, you can take e.g. the following approach to add a German language version:
---
---          -- parameters are: locale, ID, text, soundfilename, duration
---          my_aicsar.gettext:AddEntry("de","INITIALOK","Copy, Pilot, wir hören Sie. Bleiben Sie, wo Sie sind, ein Hubschrauber sammelt Sie auf!","okneu.ogg",5.0)
---          my_aicsar.locale = "de" -- plays and shows the defined German language texts and sound. Fallback is "en", if something is undefined.
---          
---Switch on radio transmissions via **either** SRS **or** "normal" DCS radio e.g. like so:
---
---         my_aicsar:SetSRSRadio(true,"C:\\Program Files\\DCS-SimpleRadio-Standalone",270,radio.modulation.AM,nil,5002)
---        
---or         
---         
---         my_aicsar:SetDCSRadio(true,300,radio.modulation.AM,GROUP:FindByName("FARP-Radio"))
---
---See the function documentation for parameter details.
---                   
---===
---AI CSAR class.
---@class AICSAR : FSM
---@field Altitude number Default altitude setting for the helicopter FLIGHTGROUP 1500ft.
---@field ClassName string Name of this class.
---@field DCSRadioGroup NOTYPE 
---@field DCSRadioQueue NOTYPE 
---@field Delay number In case of UseEventEject wait this long until we spawn a landed pilot.
---@field MGRS_Accuracy NOTYPE 
---@field Messages table 
---@field PilotStore FIFO 
---@field RadioLength table 
---@field RadioMessages table 
---@field SRS NOTYPE 
---@field SRSGoogle boolean 
---@field SRSOperator NOTYPE 
---@field SRSOperatorVoice boolean 
---@field SRSPilot NOTYPE 
---@field SRSPilotVoice boolean 
---@field SRSQ NOTYPE 
---@field SRSTTSRadio boolean 
---@field Speed number Default speed setting for the helicopter FLIGHTGROUP is 100kn.
---@field UseEventEject boolean In case Event LandingAfterEjection isn't working, use set this to true.
---@field private alias string Alias Name.
---@field private autoonoff boolean Only send a helo when no human heli pilots are available.
---@field private coalition number Colition side.
---@field private farp AIRBASE FARP object from where to start.
---@field private farpzone ZONE MASH zone to drop rescued pilots.
---@field private gettext NOTYPE 
---@field private helonumber number number of helos available (default: 3)
---@field private helos table Table of Ops.FlightGroup#FLIGHTGROUP objects
---@field private helotemplate string Template for CSAR helo.
---@field private lid string LID for log entries.
---@field private limithelos boolean limit available number of helos going on mission (defaults to true)
---@field private locale string 
---@field private maxdistance number Max distance to go for a rescue.
---@field private pilotindex number Table index to bind pilot to helo.
---@field private pilotqueue table Queue of pilots to rescue.
---@field private playerset SET_CLIENT Track if alive heli pilots are available.
---@field private rescued table Track number of rescued pilot.
---@field private rescuezoneradius number Radius around downed pilot for the helo to land in.
---@field private template string Template for pilot.
---@field private verbose boolean Switch more output.
---@field private version string Versioning.
AICSAR = {}

---[Internal] Sound output via non-SRS Radio.
---Add message files (.ogg) via "Sound to..." in the ME.
---
------
---@param Soundfile string Name of the soundfile
---@param Duration number Duration of the sound
---@param Subtitle string Text to display
---@return AICSAR #self
function AICSAR:DCSRadioBroadcast(Soundfile, Duration, Subtitle) end

---[Internal] Create the Moose TextAndSoundEntries
---
------
---@return AICSAR #self
function AICSAR:InitLocalization() end

---Function to create a new AICSAR object
---
------
---@param Alias string Name of this instance.
---@param Coalition number Coalition as in coalition.side.BLUE, can also be passed as "blue", "red" or "neutral"
---@param Pilottemplate string Pilot template name.
---@param Helotemplate string Helicopter template name.
---@param FARP AIRBASE FARP object or Airbase from where to start.
---@param MASHZone ZONE Zone where to drop pilots after rescue.
---@return AICSAR #self
function AICSAR:New(Alias, Coalition, Pilottemplate, Helotemplate, FARP, MASHZone) end

---On after "HeloDown" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Helo FLIGHTGROUP 
---@param Index number 
function AICSAR:OnAfterHeloDown(From, Event, To, Helo, Index) end

---On after "HeloOnDuty" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Helo GROUP Helo group object
function AICSAR:OnAfterHeloOnDuty(From, Event, To, Helo) end

---On after "PilotDown" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE Location of the pilot.
---@param InReach boolean True if in maxdistance else false. 
function AICSAR:OnAfterPilotDown(From, Event, To, Coordinate, InReach) end

---On after "PilotKIA" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state. 
function AICSAR:OnAfterPilotKIA(From, Event, To) end

---On after "PilotPickedUp" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Helo FLIGHTGROUP 
---@param CargoTable table of Ops.OpsGroup#OPSGROUP Cargo objects
---@param Index number  
function AICSAR:OnAfterPilotPickedUp(From, Event, To, Helo, CargoTable, Index) end

---On after "PilotRescued" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param PilotName string 
function AICSAR:OnAfterPilotRescued(From, Event, To, PilotName) end

---On after "PilotUnloaded" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Helo FLIGHTGROUP 
---@param OpsGroup OPSGROUP  
function AICSAR:OnAfterPilotUnloaded(From, Event, To, Helo, OpsGroup) end

---[User] Switch sound output on and use normale (DCS) radio
---
------
---@param OnOff boolean Switch on (true) or off (false).
---@param Frequency number Defaults to 243 (guard).
---@param Modulation number Radio modulation. Defaults to radio.modulation.AM.
---@param Group GROUP The group to use as sending station.
---@return AICSAR #self
function AICSAR:SetDCSRadio(OnOff, Frequency, Modulation, Group) end

---[User] Set default helo altitudeAGL.
---Note - AI might have other ideas. Defaults to 1500ft.
---
------
---@param Feet number AGL set in feet.
---@return AICSAR #self
function AICSAR:SetDefaultAltitude(Feet) end

---[User] Set default helo speed.
---Note - AI might have other ideas. Defaults to 100kn.
---
------
---@param Knots number Speed in knots.
---@return AICSAR #self
function AICSAR:SetDefaultSpeed(Knots) end

---[User] Set SRS TTS Voice of the rescue operator.
---`AICSAR:SetSRSTTSRadio()` needs to be set first!
---
------
---@param Voice string The voice to be used, e.g. `MSRS.Voices.Google.Standard.en_US_Standard_J` for Google or `MSRS.Voices.Microsoft.David` for Microsoft. Specific voices override culture and gender!
---@param Culture? string (Optional) The culture to be used, defaults to "en-GB"
---@param Gender? string (Optional)  The gender to be used, defaults to "female"
---@return AICSAR #self
function AICSAR:SetOperatorTTSVoice(Voice, Culture, Gender) end

---[User] Set SRS TTS Voice of downed pilot.
---`AICSAR:SetSRSTTSRadio()` needs to be set first!
---
------
---@param Voice string The voice to be used, e.g. `MSRS.Voices.Google.Standard.en_US_Standard_J` for Google or `MSRS.Voices.Microsoft.David` for Microsoft.  Specific voices override culture and gender!
---@param Culture? string (Optional) The culture to be used, defaults to "en-US"
---@param Gender? string (Optional)  The gender to be used, defaults to "male"
---@return AICSAR #self
function AICSAR:SetPilotTTSVoice(Voice, Culture, Gender) end

---[User] Switch sound output on and use SRS output for sound files.
---
------
---@param OnOff boolean Switch on (true) or off (false).
---@param Path string Path to your SRS Server Component, e.g. "C:\\\\Program Files\\\\DCS-SimpleRadio-Standalone"
---@param Frequency number Defaults to 243 (guard)
---@param Modulation number Radio modulation. Defaults to radio.modulation.AM
---@param SoundPath string Where to find the audio files. Defaults to nil, i.e. add messages via "Sound to..." in the Mission Editor.
---@param Port number Port of the SRS, defaults to 5002.
---@return AICSAR #self
function AICSAR:SetSRSRadio(OnOff, Path, Frequency, Modulation, SoundPath, Port) end

---[User] Switch sound output on and use SRS-TTS output.
---The voice will be used across all outputs, unless you define an extra voice for downed pilots and/or the operator.
---See `AICSAR:SetPilotTTSVoice()` and `AICSAR:SetOperatorTTSVoice()`
---
------
---@param OnOff boolean Switch on (true) or off (false).
---@param Path string Path to your SRS Server Component, e.g. "E:\\\\Program Files\\\\DCS-SimpleRadio-Standalone"
---@param Frequency? number (Optional) Defaults to 243 (guard)
---@param Modulation? number (Optional) Radio modulation. Defaults to radio.modulation.AM
---@param Port? number (Optional) Port of the SRS, defaults to 5002.
---@param Voice? string (Optional) The voice to be used.
---@param Culture? string (Optional) The culture to be used, defaults to "en-GB"
---@param Gender? string (Optional)  The gender to be used, defaults to "male"
---@param GoogleCredentials? string (Optional) Path to google credentials
---@return AICSAR #self
function AICSAR:SetSRSTTSRadio(OnOff, Path, Frequency, Modulation, Port, Voice, Culture, Gender, GoogleCredentials) end

---Triggers the FSM event "Status".
---
------
function AICSAR:Status() end

---Triggers the FSM event "Stop".
---
------
function AICSAR:Stop() end

---[Internal] Check helo queue
---
------
---@return AICSAR #self
function AICSAR:_CheckHelos() end

---[Internal] Check if pilot arrived in rescue zone (MASH)
---
------
---@param Pilot GROUP The pilot to be rescued.
---@return boolean #outcome
function AICSAR:_CheckInMashZone(Pilot) end

---[Internal] Check pilot queue for next mission
---
------
---@param OpsGroup OPSGROUP 
---@return AICSAR #self
function AICSAR:_CheckQueue(OpsGroup) end

---[Internal] Count helos queue
---
------
---@return number #Number of helos on mission
function AICSAR:_CountHelos() end

---[Internal] Spawn a pilot
---
------
---@param _LandingPos COORDINATE Landing Postion
---@param _coalition number Coalition side
---@return AICSAR #self
function AICSAR:_DelayedSpawnPilot(_LandingPos, _coalition) end

---[Internal] Catch the ejection and save the pilot name
---
------
---@param EventData EVENTDATA 
---@return AICSAR #self
function AICSAR:_EjectEventHandler(EventData) end

---[Internal] Catch the landing after ejection and spawn a pilot in situ.
---
------
---@param EventData EVENTDATA 
---@param FromEject boolean 
---@return AICSAR #self
function AICSAR:_EventHandler(EventData, FromEject) end

---[Internal] Get FlightGroup
---
------
---@return FLIGHTGROUP #The FlightGroup
function AICSAR:_GetFlight() end

---[Internal] Create a new rescue mission
---
------
---@param Pilot GROUP The pilot to be rescued.
---@param Index number Index number of this pilot
---@return AICSAR #self
function AICSAR:_InitMission(Pilot, Index) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.
function AICSAR:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param delay number Delay in seconds.
function AICSAR:__Stop(delay) end

---[Internal] onafterHeloDown
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Helo FLIGHTGROUP 
---@param Index number 
---@return AICSAR #self
---@private
function AICSAR:onafterHeloDown(From, Event, To, Helo, Index) end

---[Internal] onafterPilotDown
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Coordinate COORDINATE Location of the pilot.
---@param InReach boolean True if in maxdistance else false.
---@return AICSAR #self
---@private
function AICSAR:onafterPilotDown(From, Event, To, Coordinate, InReach) end

---[Internal] onafterPilotKIA
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AICSAR #self
---@private
function AICSAR:onafterPilotKIA(From, Event, To) end

---[Internal] onafterPilotPickedUp
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Helo FLIGHTGROUP 
---@param CargoTable table of Ops.OpsGroup#OPSGROUP Cargo objects
---@param Index number 
---@return AICSAR #self
---@private
function AICSAR:onafterPilotPickedUp(From, Event, To, Helo, CargoTable, Index) end

---[Internal] onafterPilotRescued
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param PilotName string 
---@return AICSAR #self
---@private
function AICSAR:onafterPilotRescued(From, Event, To, PilotName) end

---[Internal] onafterPilotUnloaded
---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Helo FLIGHTGROUP 
---@param OpsGroup OPSGROUP 
---@return AICSAR #self
---@private
function AICSAR:onafterPilotUnloaded(From, Event, To, Helo, OpsGroup) end

---[Internal] onafterStart
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AICSAR #self
---@private
function AICSAR:onafterStart(From, Event, To) end

---[Internal] onafterStatus
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AICSAR #self
---@private
function AICSAR:onafterStatus(From, Event, To) end

---[Internal] onafterStop
---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AICSAR #self
---@private
function AICSAR:onafterStop(From, Event, To) end



