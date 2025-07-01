---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Radio.JPG" width="100%">
---
---**Sound** - Queues Radio Transmissions.
---
---===
---
---## Features:
---
---  * Manage Radio Transmissions
---
---===
---
---### Authors: funkyfranky
---Manages radio transmissions.
---
---The main goal of the RADIOQUEUE class is to string together multiple sound files to play a complete sentence.
---The underlying problem is that radio transmissions in DCS are not queued but played "on top" of each other.
---Therefore, to achive the goal, it is vital to know the precise duration how long it takes to play the sound file.
---@class RADIOQUEUE : BASE
---@field ClassName string Name of the class "RADIOQUEUE".
---@field Debugmode boolean Debug mode. More info.
---@field RQid string The radio queue scheduler ID.
---@field Tlast number Time (abs) when the last transmission finished.
---@field private alias string Name of the radio.
---@field private checking boolean Scheduler is checking the radio queue. 
---@field private delay number Time delay before starting the radio queue. 
---@field private dt number Time interval in seconds for checking the radio queue.
---@field private frequency number The radio frequency in Hz.
---@field private lid string ID for dcs.log.
---@field private modulation number The radio modulation. Either radio.modulation.AM or radio.modulation.FM.
---@field private msrs MSRS Moose SRS class.
---@field private numbers table Table of number transmission parameters.
---@field private power number Power of radio station in Watts. Default 100 W.
---@field private queue table The queue of transmissions.
---@field private schedonce boolean Call ScheduleOnce instead of normal scheduler.
---@field private scheduler SCHEDULER The scheduler.
---@field private sendercoord COORDINATE Coordinate from where transmissions are broadcasted.
---@field private senderinit boolean Set frequency was initialized.
---@field private sendername number Name of the sending unit or static.
RADIOQUEUE = {}

---Add a SOUNDFILE to the radio queue.
---
------
---@param self RADIOQUEUE 
---@param soundfile SOUNDFILE Sound file object to be added.
---@param tstart number Start time (abs) seconds. Default now.
---@param interval number Interval in seconds after the last transmission finished.
---@return RADIOQUEUE #self
function RADIOQUEUE:AddSoundFile(soundfile, tstart, interval) end

---Add a SOUNDTEXT to the radio queue.
---
------
---@param self RADIOQUEUE 
---@param soundtext SOUNDTEXT Text-to-speech text.
---@param tstart number Start time (abs) seconds. Default now.
---@param interval number Interval in seconds after the last transmission finished.
---@return RADIOQUEUE #self
function RADIOQUEUE:AddSoundText(soundtext, tstart, interval) end

---Add a transmission to the radio queue.
---
------
---@param self RADIOQUEUE 
---@param transmission RADIOQUEUE.Transmission The transmission data table. 
---@return RADIOQUEUE #self
function RADIOQUEUE:AddTransmission(transmission) end

---Broadcast radio message.
---
------
---@param self RADIOQUEUE 
---@param transmission RADIOQUEUE.Transmission The transmission.
function RADIOQUEUE:Broadcast(transmission) end

---Create a new RADIOQUEUE object for a given radio frequency/modulation.
---
------
---@param self RADIOQUEUE 
---@param frequency number The radio frequency in MHz.
---@param modulation? number (Optional) The radio modulation. Default `radio.modulation.AM` (=0).
---@param alias? string (Optional) Name of the radio queue.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:New(frequency, modulation, alias) end

---Create a new transmission and add it to the radio queue.
---
------
---@param self RADIOQUEUE 
---@param filename string Name of the sound file. Usually an ogg or wav file type.
---@param duration number Duration in seconds the file lasts.
---@param path number Directory path inside the miz file where the sound file is located. Default "l10n/DEFAULT/".
---@param tstart number Start time (abs) seconds. Default now.
---@param interval number Interval in seconds after the last transmission finished.
---@param subtitle string Subtitle of the transmission.
---@param subduration number Duration [sec] of the subtitle being displayed. Default 5 sec.
---@return RADIOQUEUE.Transmission #Radio transmission table.
function RADIOQUEUE:NewTransmission(filename, duration, path, tstart, interval, subtitle, subduration) end

---Convert a number (as string) into a radio transmission.
---E.g. for board number or headings.
---
------
---@param self RADIOQUEUE 
---@param number string Number string, e.g. "032" or "183".
---@param delay number Delay before transmission in seconds.
---@param interval number Interval between the next call.
---@return number #Duration of the call in seconds.
function RADIOQUEUE:Number2Transmission(number, delay, interval) end

---Set parameters of a digit.
---
------
---@param self RADIOQUEUE 
---@param digit number The digit 0-9.
---@param filename string The name of the sound file.
---@param duration number The duration of the sound file in seconds.
---@param path string The directory within the miz file where the sound is located. Default "l10n/DEFAULT/".
---@param subtitle string Subtitle of the transmission.
---@param subduration number Duration [sec] of the subtitle being displayed. Default 5 sec.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:SetDigit(digit, filename, duration, path, subtitle, subduration) end

---Set radio power.
---Note that this only applies if no relay unit is used.
---
------
---@param self RADIOQUEUE 
---@param power number Radio power in Watts. Default 100 W.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:SetRadioPower(power) end

---Set SRS.
---
------
---@param self RADIOQUEUE 
---@param PathToSRS string Path to SRS.
---@param Port number SRS port. Default 5002.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:SetSRS(PathToSRS, Port) end

---Set coordinate from where the transmission is broadcasted.
---
------
---@param self RADIOQUEUE 
---@param coordinate COORDINATE Coordinate of the sender.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:SetSenderCoordinate(coordinate) end

---Set name of unit or static from which transmissions are made.
---
------
---@param self RADIOQUEUE 
---@param name string Name of the unit or static used for transmissions.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:SetSenderUnitName(name) end

---Start the radio queue.
---
------
---@param self RADIOQUEUE 
---@param delay? number (Optional) Delay in seconds, before the radio queue is started. Default 1 sec.
---@param dt? number (Optional) Time step in seconds for checking the queue. Default 0.01 sec.
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:Start(delay, dt) end

---Stop the radio queue.
---Stop scheduler and delete queue.
---
------
---@param self RADIOQUEUE 
---@return RADIOQUEUE #self The RADIOQUEUE object.
function RADIOQUEUE:Stop() end

---Broadcast radio message.
---
------
---@param self RADIOQUEUE 
---@param transmission RADIOQUEUE.Transmission The transmission.
function RADIOQUEUE:_BroadcastSRS(transmission) end

---Check radio queue for transmissions to be broadcasted.
---
------
---@param self RADIOQUEUE 
function RADIOQUEUE:_CheckRadioQueue() end

---Start checking the radio queue.
---
------
---@param self RADIOQUEUE 
---@param delay number Delay in seconds before checking.
function RADIOQUEUE:_CheckRadioQueueDelayed(delay) end

---Get unit from which we want to transmit a radio message.
---This has to be an aircraft for subtitles to work.
---
------
---@param self RADIOQUEUE 
---@return UNIT #Sending unit or nil if was not setup, is not an aircraft or ground unit or is not alive.
function RADIOQUEUE:_GetRadioSender() end

---Get unit from which we want to transmit a radio message.
---This has to be an aircraft or ground unit for subtitles to work.
---
------
---@param self RADIOQUEUE 
---@return Vec3 #Vector 3D.
function RADIOQUEUE:_GetRadioSenderCoord() end


---Radio queue transmission data.
---@class RADIOQUEUE.Transmission 
---@field Tplay number Mission time (abs) in seconds when the transmission should be played.
---@field Tstarted number Mission time (abs) in seconds when the transmission started.
---@field private duration number Duration in seconds.
---@field private filename string Name of the file to be transmitted.
---@field private interval number Interval in seconds before next transmission.
---@field private isplaying boolean If true, transmission is currently playing.
---@field private path string Path in miz file where the file is located.
---@field private soundfile SOUNDFILE Sound file object to play via SRS.
---@field private soundtext SOUNDTEXT Sound TTS object to play via SRS.
---@field private subduration number Duration of the subtitle being displayed.
---@field private subtitle string Subtitle of the transmission.
RADIOQUEUE.Transmission = {}



