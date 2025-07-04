---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Sound_SoundOutput.png" width="100%">
---
---**Sound** - Sound output classes.
---
---===
---
---## Features:
---
---  * Create a SOUNDFILE object (mp3 or ogg) to be played via DCS or SRS transmissions
---  * Create a SOUNDTEXT object for text-to-speech output vis SRS Simple-Text-To-Speech (MSRS)
---
---===
---
---### Author: **funkyfranky**
---
---===
---
---There are two classes, SOUNDFILE and SOUNDTEXT, defined in this section that deal with playing
---sound files or arbitrary text (via SRS Simple-Text-To-Speech), respectively.
---
---The SOUNDFILE and SOUNDTEXT objects can be defined and used in other MOOSE classes.
---Basic sound output inherited by other classes suche as SOUNDFILE and SOUNDTEXT.
---
---This class is **not** meant to be used by "ordinary" users.
---@class SOUNDBASE 
SOUNDBASE = {}

---Function returns estimated speech time in seconds.
---Assumptions for time calc: 100 Words per min, avarage of 5 letters for english word so
---
---  * 5 chars * 100wpm = 500 characters per min = 8.3 chars per second
---  
---So lengh of msg / 8.3 = number of seconds needed to read it. rounded down to 8 chars per sec map function:
---
---* (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
---
------
---@param Speed number Speed factor. Default 1.
---@param isGoogle boolean If true, google text-to-speech is used.
---@param self NOTYPE 
---@param length NOTYPE 
---@param speed NOTYPE 
function SOUNDBASE.GetSpeechTime(Text, Speed, isGoogle, self, length, speed) end

---Constructor to create a new SOUNDBASE object.
---
------
---@return SOUNDBASE #self
function SOUNDBASE:New() end


---Sound files used by other classes.
---
---# The SOUNDFILE Concept
---  
---A SOUNDFILE object hold the important properties that are necessary to play the sound file, e.g. its file name, path, duration.
---
---It can be created with the #SOUNDFILE.New(*FileName*, *Path*, *Duration*) function:
---
---    local soundfile=SOUNDFILE:New("My Soundfile.ogg", "Sound File/", 3.5)
---
---## SRS
---
---If sound files are supposed to be played via SRS, you need to use the #SOUNDFILE.SetPlayWithSRS() function.
---
---# Location/Path
---
---## DCS
---
---DCS can only play sound files that are located inside the mission (.miz) file. In particular, DCS cannot make use of files that are stored on
---your hard drive.
---
---The default location where sound files are stored in DCS is the directory "l10n/DEFAULT/". This is where sound files are placed, if they are
---added via the mission editor (TRIGGERS-->ACTIONS-->SOUND TO ALL). Note however, that sound files which are not added with a trigger command,
---will be deleted each time the mission is saved! Therefore, this directory is not ideal to be used especially if many sound files are to
---be included since for each file a trigger action needs to be created. Which is cumbersome, to say the least.
---
---The recommended way is to create a new folder inside the mission (.miz) file (a miz file is essentially zip file and can be opened, e.g., with 7-Zip)
---and to place the sound files in there. Sound files in these folders are not wiped out by DCS on the next save.
---
---## SRS
---
---SRS sound files need to be located on your local drive (not inside the miz). Therefore, you need to specify the full path.
---@class SOUNDFILE 
---@field private useSRS boolean 
SOUNDFILE = {}

---Get duration how long the sound file takes to play.
---
------
---@return number #Duration in seconds.
function SOUNDFILE:GetDuration() end

---Get the sound file name.
---
------
---@return string #Name of the soud file. This does *not* include its path.
function SOUNDFILE:GetFileName() end

---Get the complete sound file name inlcuding its path.
---
------
---@return string #Name of the sound file.
function SOUNDFILE:GetName() end

---Get path of the directory, where the sound file is located.
---
------
---@return string #Path.
function SOUNDFILE:GetPath() end

---Constructor to create a new SOUNDFILE object.
---
------
---@param FileName string The name of the sound file, e.g. "Hello World.ogg".
---@param Path string The path of the directory, where the sound file is located. Default is "l10n/DEFAULT/" within the miz file.
---@param Duration number Duration in seconds, how long it takes to play the sound file. Default is 3 seconds.
---@param UseSrs boolean Set if SRS should be used to play this file. Default is false.
---@return SOUNDFILE #self
function SOUNDFILE:New(FileName, Path, Duration, UseSrs) end

---Set duration how long it takes to play the sound file.
---
------
---@param Duration string Duration in seconds. Default 3 seconds.
---@return SOUNDFILE #self
function SOUNDFILE:SetDuration(Duration) end

---Set sound file name.
---This must be a .ogg or .mp3 file!
---
------
---@param FileName string Name of the file. Default is "Hello World.mp3".
---@return SOUNDFILE #self
function SOUNDFILE:SetFileName(FileName) end

---Set path, where the sound file is located.
---
------
---@param Path string Path to the directory, where the sound file is located. In case this is nil, it defaults to the DCS mission temp directory.
---@return SOUNDFILE #self
function SOUNDFILE:SetPath(Path) end

---Set whether sound files should be played via SRS.
---
------
---@param Switch boolean If true or nil, use SRS. If false, use DCS transmission.
---@return SOUNDFILE #self
function SOUNDFILE:SetPlayWithSRS(Switch) end


---Text-to-speech objects for other classes.
---
---# The SOUNDTEXT Concept
---
---A SOUNDTEXT object holds all necessary information to play a general text via SRS Simple-Text-To-Speech.
---
---It can be created with the #SOUNDTEXT.New(*Text*, *Duration*) function.
---  
---  * #SOUNDTEXT.New(*Text, Duration*): Creates a new SOUNDTEXT object.
---
---# Options
---
---## Gender
---
---You can choose a gender ("male" or "femal") with the #SOUNDTEXT.SetGender(*Gender*) function.
---Note that the gender voice needs to be installed on your windows machine for the used culture (see below).
---
---## Culture
---
---You can choose a "culture" (accent) with the #SOUNDTEXT.SetCulture(*Culture*) function, where the default (SRS) culture is "en-GB".
---
---Other examples for culture are: "en-US" (US accent), "de-DE" (German), "it-IT" (Italian), "ru-RU" (Russian), "zh-CN" (Chinese).
---
---Note that the chosen culture needs to be installed on your windows machine. 
---
---## Specific Voice
---
---You can use a specific voice for the transmission with the #SOUNDTEXT.SetVoice(*VoiceName*) function. Here are some examples
---
---* Name: Microsoft Hazel Desktop, Culture: en-GB,  Gender: Female, Age: Adult, Desc: Microsoft Hazel Desktop - English (Great Britain)
---* Name: Microsoft David Desktop, Culture: en-US,  Gender: Male, Age: Adult, Desc: Microsoft David Desktop - English (United States)
---* Name: Microsoft Zira Desktop, Culture: en-US,  Gender: Female, Age: Adult, Desc: Microsoft Zira Desktop - English (United States)
---* Name: Microsoft Hedda Desktop, Culture: de-DE,  Gender: Female, Age: Adult, Desc: Microsoft Hedda Desktop - German
---* Name: Microsoft Helena Desktop, Culture: es-ES,  Gender: Female, Age: Adult, Desc: Microsoft Helena Desktop - Spanish (Spain)
---* Name: Microsoft Hortense Desktop, Culture: fr-FR,  Gender: Female, Age: Adult, Desc: Microsoft Hortense Desktop - French
---* Name: Microsoft Elsa Desktop, Culture: it-IT,  Gender: Female, Age: Adult, Desc: Microsoft Elsa Desktop - Italian (Italy)
---* Name: Microsoft Irina Desktop, Culture: ru-RU,  Gender: Female, Age: Adult, Desc: Microsoft Irina Desktop - Russian
---* Name: Microsoft Huihui Desktop, Culture: zh-CN,  Gender: Female, Age: Adult, Desc: Microsoft Huihui Desktop - Chinese (Simplified)
---
---Note that this must be installed on your windos machine. Also note that this overrides any culture and gender settings.
---@class SOUNDTEXT 
---@field private voice NOTYPE 
SOUNDTEXT = {}

---Constructor to create a new SOUNDTEXT object.
---
------
---@param Text string The text to speak.
---@param Duration number Duration in seconds, how long it takes to play the text. Default is 3 seconds.
---@return SOUNDTEXT #self
function SOUNDTEXT:New(Text, Duration) end

---Set TTS culture - local for the voice.
---
------
---@param Culture string TTS culture. Default "en-GB".
---@return SOUNDTEXT #self
function SOUNDTEXT:SetCulture(Culture) end

---Set duration, how long it takes to speak the text.
---
------
---@param Duration number Duration in seconds. Default 3 seconds.
---@return SOUNDTEXT #self
function SOUNDTEXT:SetDuration(Duration) end

---Set gender.
---
------
---@param Gender string Gender: "male" or "female" (default).
---@return SOUNDTEXT #self
function SOUNDTEXT:SetGender(Gender) end

---Set text.
---
------
---@param Text string Text to speak. Default "Hello World!".
---@return SOUNDTEXT #self
function SOUNDTEXT:SetText(Text) end

---Set to use a specific voice name.
---See the list from `DCS-SR-ExternalAudio.exe --help` or if using google see [google voices](https://cloud.google.com/text-to-speech/docs/voices).
---
------
---@param VoiceName string Voice name. Note that this will overrule `Gender` and `Culture`.
---@return SOUNDTEXT #self
function SOUNDTEXT:SetVoice(VoiceName) end



