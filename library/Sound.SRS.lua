---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Sound_MSRS.png" width="100%">
---
---**Sound** - Simple Radio Standalone (SRS) Integration and Text-to-Speech.
---
---===
---
---**Main Features:**
---
---   * Incease immersion of your missions with more sound output
---   * Play sound files via SRS
---   * Play text-to-speech via SRS
---
---===
---
---## Youtube Videos: None yet
---
---===
---
---## Example Missions: [GitHub](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Sound/MSRS).
---
---===
---
---## Sound files: [MOOSE Sound Files](https://github.com/FlightControl-Master/MOOSE_SOUND/releases)
---
---===
---
---The goal of the [SRS](https://github.com/ciribob/DCS-SimpleRadioStandalone) project is to bring VoIP communication into DCS and to make communication as frictionless as possible.
---
---===
---
---### Author: **funkyfranky**
---*It is a very sad thing that nowadays there is so little useless information.* - Oscar Wilde
---
---===
---
---# The MSRS Concept
---
---This class allows to broadcast sound files or text via Simple Radio Standalone (SRS).
---
---## Prerequisites
---
---* This script needs SRS version >= 1.9.6
---* You need to de-sanitize os, io and lfs in the missionscripting.lua
---* Optional: DCS-gRPC as backend to communicate with SRS (vide infra)
---
---## Knwon Issues
---
---### Pop-up Window
---
---The text-to-speech conversion of SRS is done via an external exe file. When this file is called, a windows `cmd` window is briefly opended. That puts DCS out of focus, which is annoying,
---expecially in VR but unavoidable (if you have a solution, please feel free to share!).
---
---NOTE that this is not an issue if the mission is running on a server.
---Also NOTE that using DCS-gRPC as backend will avoid the pop-up window.
---
---# Play Sound Files
---
---    local soundfile=SOUNDFILE:New("My Soundfile.ogg", "D:\\Sounds For DCS")
---    local msrs=MSRS:New("C:\\Path To SRS", 251, radio.modulation.AM)
---    msrs:PlaySoundFile(soundfile)
---
---# Play Text-To-Speech
---
---Basic example:
---
---    -- Create a SOUNDTEXT object.
---    local text=SOUNDTEXT:New("All Enemies destroyed")
---
---    -- MOOSE SRS
---    local msrs=MSRS:New("D:\\DCS\\_SRS\\", 305, radio.modulation.AM)
---
---    -- Text-to speech with default voice after 2 seconds.
---    msrs:PlaySoundText(text, 2)
---
---## Set Gender
---
---Use a specific gender with the #MSRS.SetGender function, e.g. `SetGender("male")` or `:SetGender("female")`.
---
---## Set Culture
---
---Use a specific "culture" with the #MSRS.SetCulture function, e.g. `:SetCulture("en-US")` or `:SetCulture("de-DE")`.
---
---## Set Voice
---
---Use a specific voice with the #MSRS.SetVoice function, e.g, `:SetVoice("Microsoft Hedda Desktop")`.
---Note that this must be installed on your windows system.
---
---Note that you can set voices for each provider via the #MSRS.SetVoiceProvider function. Also shortcuts are available, *i.e.*
---#MSRS.SetVoiceWindows, #MSRS.SetVoiceGoogle, #MSRS.SetVoiceAzure and #MSRS.SetVoiceAmazon.
---
---For voices there are enumerators in this class to help you out on voice names:
---
---    MSRS.Voices.Microsoft -- e.g. MSRS.Voices.Microsoft.Hedda - the Microsoft enumerator contains all voices known to work with SRS
---    MSRS.Voices.Google -- e.g. MSRS.Voices.Google.Standard.en_AU_Standard_A or MSRS.Voices.Google.Wavenet.de_DE_Wavenet_C - The Google enumerator contains voices for EN, DE, IT, FR and ES.
---
---## Set Coordinate
---
---Use #MSRS.SetCoordinate to define the origin from where the transmission is broadcasted.
---Note that this is only a factor if SRS server has line-of-sight and/or distance limit enabled.
---
---## Set SRS Port
---
---Use #MSRS.SetPort to define the SRS port. Defaults to 5002.
---
---## Set SRS Volume
---
---Use #MSRS.SetVolume to define the SRS volume. Defaults to 1.0. Allowed values are between 0.0 and 1.0, from silent to loudest.
---
---## Config file for many variables, auto-loaded by Moose
---
---See #MSRS.LoadConfigFile for details on how to set this up.
---
---## TTS Providers
---
---The default provider for generating speech from text is the native Windows TTS service. Note that you need to install the voices you want to use.
---
---**Pro-Tip** - use the command line with power shell to call `DCS-SR-ExternalAudio.exe` - it will tell you what is missing
---and also the Google Console error, in case you have missed a step in setting up your Google TTS.
---For example, `.\DCS-SR-ExternalAudio.exe -t "Text Message" -f 255 -m AM -c 2 -s 2 -z -G "Path_To_You_Google.Json"`
---plays a message on 255 MHz AM for the blue coalition in-game.
---
---### Google
---
---In order to use Google Cloud for TTS you need to use #MSRS.SetProvider and #MSRS.SetProviderOptionsGoogle functions:
---
---    msrs:SetProvider(MSRS.Provider.GOOGLE)
---    msrs:SetProviderOptionsGoogle(CredentialsFile, AccessKey)
---
---The parameter `CredentialsFile` is used with the default 'DCS-SR-ExternalAudio.exe' backend and must be the full path to the credentials JSON file.
---The `AccessKey` parameter is used with the DCS-gRPC backend (see below).
---
---You can set the voice to use with Google via #MSRS.SetVoiceGoogle.
---
---When using Google it also allows you to utilize SSML in your text for more flexibility.
---For more information on setting up a cloud account, visit: https://cloud.google.com/text-to-speech
---Google's supported SSML reference: https://cloud.google.com/text-to-speech/docs/ssml
---
---### Amazon Web Service [Only DCS-gRPC backend]
---
---In order to use Amazon Web Service (AWS) for TTS you need to use #MSRS.SetProvider and #MSRS.SetProviderOptionsAmazon functions:
---
---    msrs:SetProvider(MSRS.Provider.AMAZON)
---    msrs:SetProviderOptionsAmazon(AccessKey, SecretKey, Region)
---    
---The parameters `AccessKey` and `SecretKey` are your AWS access and secret keys, respectively. The parameter `Region` is your [AWS region](https://docs.aws.amazon.com/general/latest/gr/pol.html).
---
---You can set the voice to use with AWS via #MSRS.SetVoiceAmazon.
---
---### Microsoft Azure [Only DCS-gRPC backend]
---
---In order to use Microsoft Azure for TTS you need to use #MSRS.SetProvider and #MSRS.SetProviderOptionsAzure functions:
---
---    msrs:SetProvider(MSRS.Provider.AZURE)
---    msrs:SetProviderOptionsAmazon(AccessKey, Region)
---
---The parameter `AccessKey` is your Azure access key. The parameter `Region` is your [Azure region](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/regions).
---
---You can set the voice to use with Azure via #MSRS.SetVoiceAzure.
---
---## Backend
---
---The default interface to SRS is via calling the 'DCS-SR-ExternalAudio.exe'. As noted above, this has the unavoidable drawback that a pop-up briefly appears
---and DCS might be put out of focus.
---
---## DCS-gRPC as an alternative to 'DCS-SR-ExternalAudio.exe' for TTS
---
---Another interface to SRS is [DCS-gRPC](https://github.com/DCS-gRPC/rust-server). This does not call an exe file and therefore avoids the annoying pop-up window.
---In addition to Windows and Google cloud, it also offers Microsoft Azure and Amazon Web Service as providers for TTS.
---
---Use #MSRS.SetDefaultBackendGRPC to enable [DCS-gRPC](https://github.com/DCS-gRPC/rust-server) as an alternate backend for transmitting text-to-speech over SRS.
---This can be useful if 'DCS-SR-ExternalAudio.exe' cannot be used in the environment or to use Azure or AWS clouds for TTS.  Note that DCS-gRPC does not (yet?) support
---all of the features and options available with 'DCS-SR-ExternalAudio.exe'. Of note, only text-to-speech is supported and it it cannot be used to transmit audio files.
---
---DCS-gRPC must be installed and configured per the [DCS-gRPC documentation](https://github.com/DCS-gRPC/rust-server) and already running via either the 'autostart' mechanism
---or a Lua call to 'GRPC.load()' prior to use of the alternate DCS-gRPC backend. If a cloud TTS provider is being used, the API key must be set via the 'Config\dcs-grpc.lua'
---configuration file prior DCS-gRPC being started. DCS-gRPC can be used both with DCS dedicated server and regular DCS installations.
---
---To use the default local Windows TTS with DCS-gRPC, Windows 2019 Server (or newer) or Windows 10/11 are required.  Voices for non-local languages and dialects may need to
---be explicitly installed.
---
---To set the MSRS class to use the DCS-gRPC backend for all future instances, call the function `MSRS.SetDefaultBackendGRPC()`.
---
---**Note** - When using other classes that use MSRS with the alternate DCS-gRPC backend, pass them strings instead of nil values for non-applicable fields with filesystem paths,
---such as the SRS path or Google credential path. This will help maximize compatibility with other classes that were written for the default backend.
---
---Basic Play Text-To-Speech example using alternate DCS-gRPC backend (DCS-gRPC not previously started):
---
---    -- Start DCS-gRPC
---    GRPC.load()
---    -- Select the alternate DCS-gRPC backend for new MSRS instances
---    MSRS.SetDefaultBackendGRPC()
---    -- Create a SOUNDTEXT object.
---    local text=SOUNDTEXT:New("All Enemies destroyed")
---    -- MOOSE SRS
---    local msrs=MSRS:New('', 305.0)
---    -- Text-to speech with default voice after 30 seconds.
---    msrs:PlaySoundText(text, 30)
---
---Basic example of using another class (ATIS) with SRS and the DCS-gRPC backend (DCS-gRPC not previously started):
---
---    -- Start DCS-gRPC
---    GRPC.load()
---    -- Select the alternate DCS-gRPC backend for new MSRS instances
---    MSRS.SetDefaultBackendGRPC()
---    -- Create new ATIS as usual
---    atis=ATIS:New("Nellis", 251, radio.modulation.AM)
---    -- ATIS:SetSRS() expects a string for the SRS path even though it is not needed with DCS-gRPC
---    atis:SetSRS('')
---    -- Start ATIS
---    atis:Start()
---MSRS class.
---@class MSRS : BASE
---@field ClassName string Name of the class.
---@field ConfigFileName string Name of the standard config file.
---@field ConfigFilePath string Path to the standard config file.
---@field ConfigLoaded boolean If `true` if config file was loaded.
---@field Label string Label showing up on the SRS radio overlay. Default is "ROBOT". No spaces allowed.
---@field UsePowerShell boolean Use PowerShell to execute the command and not cmd.exe
---@field backend string Backend used as interface to SRS (MSRS.Backend.SRSEXE or MSRS.Backend.GRPC).
---@field coalition number Coalition of the transmission.
---@field coordinate COORDINATE Coordinate from where the transmission is send.
---@field culture string Culture. Default "en-GB".
---@field gender string Gender. Default "female".
---@field lid string Class id string for output to DCS log file.
---@field name string Name. Default "MSRS".
---@field path string Path to the SRS exe.
---@field port number Port. Default 5002.
---@field provider string Provider of TTS (win, gcloud, azure, amazon).
---@field version string MSRS class version.
---@field voice string Specific voice. Only used if no explicit provider voice specified.
---@field volume number Volume between 0 (min) and 1 (max). Default 1.
MSRS = {}

---Add frequencies.
---
------
---@param self MSRS 
---@param Frequencies table Frequencies in MHz. Can also be given as a #number if only one frequency should be used.
---@return MSRS #self
function MSRS:AddFrequencies(Frequencies) end

---Add modulations.
---
------
---@param self MSRS 
---@param Modulations table Modulations. Can also be given as a #number if only one modulation should be used.
---@return MSRS #self
function MSRS:AddModulations(Modulations) end

---Get currently set backend.
---
------
---@param self MSRS 
---@return string #Backend.
function MSRS:GetBackend() end

---Get coalition.
---
------
---@param self MSRS 
---@return number #Coalition.
function MSRS:GetCoalition() end

---Get frequencies.
---
------
---@param self MSRS 
---@return table #Frequencies in MHz.
function MSRS:GetFrequencies() end

---Get label.
---
------
---@param self MSRS 
---@return number #Label.
function MSRS:GetLabel() end

---Get modulations.
---
------
---@param self MSRS 
---@return table #Modulations.
function MSRS:GetModulations() end

---Get path to SRS directory.
---
------
---@param self MSRS 
---@return string #Path to the directory. This includes the final slash "/".
function MSRS:GetPath() end

---Get port.
---
------
---@param self MSRS 
---@return number #Port.
function MSRS:GetPort() end

---Get provider.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:GetProvider() end

---Get provider options.
---
------
---@param self MSRS 
---@param Provider string Provider. Default is as set via @{#MSRS.SetProvider}.
---@return MSRS.ProviderOptions #Provider options.
function MSRS:GetProviderOptions(Provider) end

---Get voice.
---
------
---@param self MSRS 
---@param Provider string Provider. Default is the currently set provider (`self.provider`).
---@return string #Voice.
function MSRS:GetVoice(Provider) end

---Get SRS volume.
---
------
---@param self MSRS 
---@return number #Volume Volume - 1.0 is max, 0.0 is silence
function MSRS:GetVolume() end

---Print SRS help to DCS log file.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:Help() end

---Get central SRS configuration to be able to play tts over SRS radio using the `DCS-SR-ExternalAudio.exe`.
---
------
---
---USAGE
---```
--- 0) Benefits: Centralize configuration of SRS, keep paths and keys out of the mission source code, making it safer and easier to move missions to/between servers,
--- and also make config easier to use in the code.
--- 1) Create a config file named "Moose_MSRS.lua" at this location "C:\Users\<yourname>\Saved Games\DCS\Config" (or wherever your Saved Games folder resides).
--- 2) The file needs the following structure:
---
---    -- Moose MSRS default Config
---    MSRS_Config = {
---      Path = "C:\\Program Files\\DCS-SimpleRadio-Standalone", -- Path to SRS install directory.
---      Port = 5002,            -- Port of SRS server. Default 5002.
---      Backend = "srsexe",     -- Interface to SRS: "srsexe" or "grpc".
---      Frequency = {127, 243}, -- Default frequences. Must be a table 1..n entries!
---      Modulation = {0,0},     -- Default modulations. Must be a table, 1..n entries, one for each frequency!
---      Volume = 1.0,           -- Default volume [0,1].
---      Coalition = 0,          -- 0 = Neutral, 1 = Red, 2 = Blue (only a factor if SRS server has encryption enabled).
---      Coordinate = {0,0,0},   -- x, y, alt (only a factor if SRS server has line-of-sight and/or distance limit enabled).
---      Culture = "en-GB",
---      Gender = "male",
---      Voice = "Microsoft Hazel Desktop", -- Voice that is used if no explicit provider voice is specified.
---      Label = "MSRS",   
---      Provider = "win", --Provider for generating TTS (win, gcloud, azure, aws).      
---      -- Windows
---      win = {
---        voice = "Microsoft Hazel Desktop",
---      },
---      -- Google Cloud
---      gcloud = {
---        voice = "en-GB-Standard-A", -- The Google Cloud voice to use (see https://cloud.google.com/text-to-speech/docs/voices).
---        credentials="C:\\Program Files\\DCS-SimpleRadio-Standalone\\yourfilename.json", -- Full path to credentials JSON file (only for SRS-TTS.exe backend)
---        key="Your access Key", -- Google API access key (only for DCS-gRPC backend)
---      },
---      -- Amazon Web Service
---      aws = {
---        voice = "Brian", -- The default AWS voice to use (see https://docs.aws.amazon.com/polly/latest/dg/voicelist.html).
---        key="Your access Key",  -- Your AWS key.
---        secret="Your secret key", -- Your AWS secret key.
---        region="eu-central-1", -- Your AWS region (see https://docs.aws.amazon.com/general/latest/gr/pol.html).
---      },
---      -- Microsoft Azure
---      azure = {
---        voice="en-US-AriaNeural",  --The default Azure voice to use (see https://learn.microsoft.com/azure/cognitive-services/speech-service/language-support).
---        key="Your access key", -- Your Azure access key.
---        region="westeurope", -- The Azure region to use (see https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/regions).
---      },
---    }
---
--- 3) The config file is automatically loaded when Moose starts. You can also load the config into the MSRS raw class manually before you do anything else:
---
---        MSRS.LoadConfigFile() -- Note the "." here
---
--- Optionally, your might want to provide a specific path and filename:
---
---        MSRS.LoadConfigFile(nil,MyPath,MyFilename) -- Note the "." here
---
--- This will populate variables for the MSRS raw class and all instances you create with e.g. `mysrs = MSRS:New()`
--- Optionally you can also load this per **single instance** if so needed, i.e.
---
---    mysrs:LoadConfigFile(Path,Filename)
---
--- 4) Use the config in your code like so, variable names are basically the same as in the config file, but all lower case, examples:
---
---        -- Needed once only
---        MESSAGE.SetMSRS(MSRS.path,MSRS.port,nil,127,rado.modulation.FM,nil,nil,nil,nil,nil,"TALK")
---
---        -- later on in your code
---
---        MESSAGE:New("Test message!",15,"SPAWN"):ToSRS(243,radio.modulation.AM,nil,nil,MSRS.Voices.Google.Standard.fr_FR_Standard_C)
---
---        -- Create new ATIS as usual
---        atis=ATIS:New(AIRBASE.Caucasus.Batumi, 123, radio.modulation.AM)
---        atis:SetSRS(nil,nil,nil,MSRS.Voices.Google.Standard.en_US_Standard_H)
---        --Start ATIS
---        atis:Start()
---```
------
---@param self MSRS 
---@param Path string Path to config file, defaults to "C:\Users\<yourname>\Saved Games\DCS\Config"
---@param Filename string File to load, defaults to "Moose_MSRS.lua"
---@return boolean #success
function MSRS:LoadConfigFile(Path, Filename) end

---Create a new MSRS object.
---Required argument is the frequency and modulation.
---Other parameters are read from the `Moose_MSRS.lua` config file. If you do not have that file set up you must set up and use the `DCS-SR-ExternalAudio.exe` (not DCS-gRPC) as backend, you need to still
---set the path to the exe file via #MSRS.SetPath.
---
------
---@param self MSRS 
---@param Path string Path to SRS directory. Default `C:\\Program Files\\DCS-SimpleRadio-Standalone`.
---@param Frequency number Radio frequency in MHz. Default 143.00 MHz. Can also be given as a #table of multiple frequencies.
---@param Modulation number Radio modulation: 0=AM (default), 1=FM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. Can also be given as a #table of multiple modulations.
---@param Backend string Backend used: `MSRS.Backend.SRSEXE` (default) or `MSRS.Backend.GRPC`.
---@return MSRS #self
function MSRS:New(Path, Frequency, Modulation, Backend) end

---Play sound file (ogg or mp3) via SRS.
---
------
---@param self MSRS 
---@param Soundfile SOUNDFILE Sound file to play.
---@param Delay number Delay in seconds, before the sound file is played.
---@return MSRS #self
function MSRS:PlaySoundFile(Soundfile, Delay) end

---Play a SOUNDTEXT text-to-speech object.
---
------
---@param self MSRS 
---@param SoundText SOUNDTEXT Sound text.
---@param Delay number Delay in seconds, before the sound file is played.
---@return MSRS #self
function MSRS:PlaySoundText(SoundText, Delay) end

---Play text message via MSRS.
---
------
---@param self MSRS 
---@param Text string Text message.
---@param Delay number Delay in seconds, before the message is played.
---@param Coordinate COORDINATE Coordinate.
---@return MSRS #self
function MSRS:PlayText(Text, Delay, Coordinate) end

---Play text message via MSRS with explicitly specified options.
---
------
---@param self MSRS 
---@param Text string Text message.
---@param Delay number Delay in seconds, before the message is played.
---@param Frequencies table Radio frequencies.
---@param Modulations table Radio modulations.
---@param Gender string Gender.
---@param Culture string Culture.
---@param Voice string Voice.
---@param Volume number Volume.
---@param Label string Label.
---@param Coordinate COORDINATE Coordinate.
---@return MSRS #self
function MSRS:PlayTextExt(Text, Delay, Frequencies, Modulations, Gender, Culture, Voice, Volume, Label, Coordinate) end

---Play text file via MSRS.
---
------
---@param self MSRS 
---@param TextFile string Full path to the file.
---@param Delay number Delay in seconds, before the message is played.
---@return MSRS #self
function MSRS:PlayTextFile(TextFile, Delay) end

---Set backend to communicate with SRS.
---There are two options:
---
---- `MSRS.Backend.SRSEXE`: This is the default and uses the `DCS-SR-ExternalAudio.exe`.
---- `MSRS.Backend.GRPC`: Via DCS-gRPC.
---
------
---@param self MSRS 
---@param Backend string Backend used. Default is `MSRS.Backend.SRSEXE`.
---@return MSRS #self
function MSRS:SetBackend(Backend) end

---Set DCS-gRPC as backend to communicate with SRS.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetBackendGRPC() end

---Set `DCS-SR-ExternalAudio.exe` as backend to communicate with SRS.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetBackendSRSEXE() end

---Set coalition.
---
------
---@param self MSRS 
---@param Coalition number Coalition. Default 0.
---@return MSRS #self
function MSRS:SetCoalition(Coalition) end

---Set the coordinate from which the transmissions will be broadcasted.
---Note that this is only a factor if SRS has line-of-sight or distance enabled.
---
------
---@param self MSRS 
---@param Coordinate COORDINATE Origin of the transmission.
---@return MSRS #self
function MSRS:SetCoordinate(Coordinate) end

---Set culture.
---
------
---@param self MSRS 
---@param Culture string Culture, *e.g.* "en-GB".
---@return MSRS #self
function MSRS:SetCulture(Culture) end

---Set the default backend.
---
------
---@param Backend string 
function MSRS.SetDefaultBackend(Backend) end

---Set DCS-gRPC to be the default backend.
---
------
---@param self MSRS 
function MSRS:SetDefaultBackendGRPC() end

---Set frequencies.
---
------
---@param self MSRS 
---@param Frequencies table Frequencies in MHz. Can also be given as a #number if only one frequency should be used.
---@return MSRS #self
function MSRS:SetFrequencies(Frequencies) end

---Set gender.
---
------
---@param self MSRS 
---@param Gender string Gender: "male" or "female" (default).
---@return MSRS #self
function MSRS:SetGender(Gender) end

---**[Deprecated]** Use google text-to-speech credentials.
---Also sets Google as default TTS provider.
---
------
---@param self MSRS 
---@param PathToCredentials string Full path to the google credentials JSON file, e.g. "C:\Users\username\Downloads\service-account-file.json". Can also be the Google API key.
---@return MSRS #self
function MSRS:SetGoogle(PathToCredentials) end

---**[Deprecated]** Use google text-to-speech set the API key (only for DCS-gRPC).
---
------
---@param self MSRS 
---@param APIKey string API Key, usually a string of length 40 with characters and numbers.
---@return MSRS #self
function MSRS:SetGoogleAPIKey(APIKey) end

---Set label.
---
------
---@param self MSRS 
---@param Label number  Default "ROBOT"
---@return MSRS #self
function MSRS:SetLabel(Label) end

---Set modulations.
---
------
---@param self MSRS 
---@param Modulations table Modulations. Can also be given as a #number if only one modulation should be used.
---@return MSRS #self
function MSRS:SetModulations(Modulations) end

---Set path to SRS install directory.
---More precisely, path to where the `DCS-SR-ExternalAudio.exe` is located.
---
------
---@param self MSRS 
---@param Path string Path to the directory, where the sound file is located. Default is `C:\\Program Files\\DCS-SimpleRadio-Standalone`.
---@return MSRS #self
function MSRS:SetPath(Path) end

---Set port.
---
------
---@param self MSRS 
---@param Port number Port. Default 5002.
---@return MSRS #self
function MSRS:SetPort(Port) end

---Set provider used to generate text-to-speech.
---These options are available:
---
---- `MSRS.Provider.WINDOWS`: Microsoft Windows (default)
---- `MSRS.Provider.GOOGLE`: Google Cloud
---- `MSRS.Provider.AZURE`: Microsoft Azure (only with DCS-gRPC backend)
---- `MSRS.Provier.AMAZON`: Amazon Web Service (only with DCS-gRPC backend)
---
---Note that all providers except Microsoft Windows need as additonal information the credentials of your account.
---
------
---@param self MSRS 
---@param Provider string 
---@return MSRS #self
function MSRS:SetProvider(Provider) end

---Set provider options and credentials.
---
------
---@param self MSRS 
---@param Provider string Provider.
---@param CredentialsFile string Full path to your credentials file. For Google this is the path to a JSON file.
---@param AccessKey string Your API access key.
---@param SecretKey string Your secret key.
---@param Region string Region to use.
---@return MSRS.ProviderOptions #Provider optionas table.
function MSRS:SetProviderOptions(Provider, CredentialsFile, AccessKey, SecretKey, Region) end

---Set provider options and credentials for Amazon Web Service (AWS).
---Only supported in combination with DCS-gRPC as backend.
---
------
---@param self MSRS 
---@param AccessKey string Your API access key.
---@param SecretKey string Your secret key.
---@param Region string Your AWS [region](https://docs.aws.amazon.com/general/latest/gr/pol.html).
---@return MSRS #self
function MSRS:SetProviderOptionsAmazon(AccessKey, SecretKey, Region) end

---Set provider options and credentials for Microsoft Azure.
---Only supported in combination with DCS-gRPC as backend.
---
------
---@param self MSRS 
---@param AccessKey string Your API access key.
---@param Region string Your Azure [region](https://learn.microsoft.com/en-us/azure/cognitive-services/speech-service/regions).
---@return MSRS #self
function MSRS:SetProviderOptionsAzure(AccessKey, Region) end

---Set provider options and credentials for Google Cloud.
---
------
---@param self MSRS 
---@param CredentialsFile string Full path to your credentials file. For Google this is the path to a JSON file. This is used if `DCS-SR-ExternalAudio.exe` is used as backend.
---@param AccessKey string Your API access key. This is necessary if DCS-gRPC is used as backend.
---@return MSRS #self
function MSRS:SetProviderOptionsGoogle(CredentialsFile, AccessKey) end

---Use Amazon Web Service (AWS) to provide text-to-speech.
---Only supported if used in combination with DCS-gRPC as backend.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetTTSProviderAmazon() end

---Use Microsoft Azure to provide text-to-speech.
---Only supported if used in combination with DCS-gRPC as backend.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetTTSProviderAzure() end

---Use Google to provide text-to-speech.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetTTSProviderGoogle() end

---Use Microsoft to provide text-to-speech.
---
------
---@param self MSRS 
---@return MSRS #self
function MSRS:SetTTSProviderMicrosoft() end

---Set to use a specific voice.
---Note that this will override any gender and culture settings as a voice already has a certain gender/culture.
---
------
---@param self MSRS 
---@param Voice string Voice.
---@return MSRS #self
function MSRS:SetVoice(Voice) end

---Set to use a specific voice if Amazon Web Service is use as provider (only DCS-gRPC backend).
---Note that this will override any gender and culture settings.
---
------
---@param self MSRS 
---@param Voice string [AWS Voice](https://docs.aws.amazon.com/polly/latest/dg/voicelist.html). Default `"Brian"`.
---@return MSRS #self
function MSRS:SetVoiceAmazon(Voice) end

---Set to use a specific voice if Microsoft Azure is use as provider (only DCS-gRPC backend).
---Note that this will override any gender and culture settings.
---
------
---@param self MSRS 
---@param Voice string [Azure Voice](https://learn.microsoft.com/azure/cognitive-services/speech-service/language-support). Default `"en-US-AriaNeural"`.
---@return MSRS #self
function MSRS:SetVoiceAzure(Voice) end

---Set to use a specific voice if Google is use as provider.
---Note that this will override any gender and culture settings.
---
------
---@param self MSRS 
---@param Voice string Voice. Default `MSRS.Voices.Google.Standard.en_GB_Standard_A`.
---@return MSRS #self
function MSRS:SetVoiceGoogle(Voice) end

---Set to use a specific voice for a given provider.
---Note that this will override any gender and culture settings.
---
------
---@param self MSRS 
---@param Voice string Voice.
---@param Provider string Provider. Default is as set by @{#MSRS.SetProvider}, which itself defaults to `MSRS.Provider.WINDOWS` if not set.
---@return MSRS #self
function MSRS:SetVoiceProvider(Voice, Provider) end

---Set to use a specific voice if Microsoft Windows' native TTS is use as provider.
---Note that this will override any gender and culture settings.
---
------
---@param self MSRS 
---@param Voice string Voice. Default `"Microsoft Hazel Desktop"`.
---@return MSRS #self
function MSRS:SetVoiceWindows(Voice) end

---Set SRS volume.
---
------
---@param self MSRS 
---@param Volume number Volume - 1.0 is max, 0.0 is silence
---@return MSRS #self
function MSRS:SetVolume(Volume) end

---Create MSRS.ProviderOptions.
---
------
---@param Provider string Provider.
---@param CredentialsFile string Full path to your credentials file. For Google this is the path to a JSON file.
---@param AccessKey string Your API access key.
---@param SecretKey string Your secret key.
---@param Region string Region to use.
---@return MSRS.ProviderOptions #Provider optionas table.
function MSRS._CreateProviderOptions(Provider, CredentialsFile, AccessKey, SecretKey, Region) end

---Make DCS-gRPC API call to transmit text-to-speech over SRS.
---
------
---@param self MSRS 
---@param Text string Text of message to transmit (can also be SSML).
---@param Frequencies table Radio frequencies to transmit on. Can also accept a number in MHz.
---@param Gender string Gender.
---@param Culture string Culture.
---@param Voice string Voice.
---@param Volume number Volume.
---@param Label string Label.
---@param Coordinate COORDINATE Coordinate.
---@return MSRS #self
function MSRS:_DCSgRPCtts(Text, Frequencies, Gender, Culture, Voice, Volume, Label, Coordinate) end

---Execute SRS command to play sound using the `DCS-SR-ExternalAudio.exe`.
---
------
---@param self MSRS 
---@param command string Command to executer
---@return number #Return value of os.execute() command.
function MSRS:_ExecCommand(command) end

---Get SRS command to play sound using the `DCS-SR-ExternalAudio.exe`.
---
------
---@param self MSRS 
---@param freqs table Frequencies in MHz.
---@param modus table Modulations.
---@param coal number Coalition.
---@param gender string Gender.
---@param voice string Voice.
---@param culture string Culture.
---@param volume number Volume.
---@param speed number Speed.
---@param port number Port.
---@param label string Label, defaults to "ROBOT" (displayed sender name in the radio overlay of SRS) - No spaces allowed!
---@param coordinate COORDINATE Coordinate.
---@return string #Command.
function MSRS:_GetCommand(freqs, modus, coal, gender, voice, culture, volume, speed, port, label, coordinate) end

---Get lat, long and alt from coordinate.
---
------
---@param self MSRS 
---@param Coordinate Coordinate Coordinate. Can also be a DCS#Vec3.
---@return number #Latitude (or 0 if no input coordinate was given).
---@return number #Longitude (or 0 if no input coordinate was given).
---@return number #Altitude (or 0 if no input coordinate was given).
function MSRS:_GetLatLongAlt(Coordinate) end

---Function returns estimated speech time in seconds.
---Assumptions for time calc: 100 Words per min, average of 5 letters for english word so
---
---  * 5 chars * 100wpm = 500 characters per min = 8.3 chars per second
---
---So length of msg / 8.3 = number of seconds needed to read it. rounded down to 8 chars per sec map function:
---
---* (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
---
------
---@param length number can also be passed as #string
---@param speed number Defaults to 1.0
---@param isGoogle boolean We're using Google TTS
function MSRS.getSpeechTime(length, speed, isGoogle) end


---
------
function MSRS.uuid() end


---Backend options to communicate with SRS.
---@class MSRS.Backend 
---@field GRPC string Use DCS-gRPC.
---@field SRSEXE string Use `DCS-SR-ExternalAudio.exe`.
MSRS.Backend = {}


---GRPC options.
---@class MSRS.GRPCOptions 
---@field DefaultProvider string 
---@field coalition string 
---@field plaintext string 
---@field srsClientName string 
MSRS.GRPCOptions = {}


---Text-to-speech providers.
---These are compatible with the DCS-gRPC conventions.
---@class MSRS.Provider 
---@field AMAZON string Amazon Web Service (`aws`). Only possible with DCS-gRPC backend.
---@field AZURE string Microsoft Azure (`azure`). Only possible with DCS-gRPC backend.
---@field GOOGLE string Google (`gcloud`).
---@field WINDOWS string Microsoft windows (`win`).
MSRS.Provider = {}


---Provider options.
---@class MSRS.ProviderOptions 
---@field credentials string Google credentials JSON file (full path).
---@field defaultVoice string Default voice (not used).
---@field key string Access key (DCS-gRPC with Google, AWS, AZURE as provider).
---@field provider string Provider.
---@field region string Region.
---@field secret string Secret key (DCS-gRPC with AWS as provider)
---@field voice string Voice used.
MSRS.ProviderOptions = {}


---Voices
---@class MSRS.Voices 
MSRS.Voices = {}


---Manages radio transmissions.
---
---The purpose of the MSRSQUEUE class is to manage SRS text-to-speech (TTS) messages using the MSRS class.
---This can be used to submit multiple TTS messages and the class takes care that they are transmitted one after the other (and not overlapping).
---@class MSRSQUEUE : BASE
---@field ClassName string Name of the class "MSRSQUEUE".
---@field Tlast number Time (abs) when the last transmission finished.
---@field TransmitOnlyWithPlayers  
---@field alias string Name of the radio queue.
---@field checking boolean If `true`, the queue update function is scheduled to be called again.
---@field dt number Time interval in seconds for checking the radio queue.
---@field lid string ID for dcs.log.
MSRSQUEUE = {}

---Add a transmission to the radio queue.
---
------
---@param self MSRSQUEUE 
---@param transmission MSRSQUEUE.Transmission The transmission data table.
---@return MSRSQUEUE #self
function MSRSQUEUE:AddTransmission(transmission) end

---Broadcast radio message.
---
------
---@param self MSRSQUEUE 
---@param transmission MSRSQUEUE.Transmission The transmission.
function MSRSQUEUE:Broadcast(transmission) end

---Calculate total transmission duration of all transmission in the queue.
---
------
---@param self MSRSQUEUE 
---@return number #Total transmission duration.
function MSRSQUEUE:CalcTransmisstionDuration() end

---Clear the radio queue.
---
------
---@param self MSRSQUEUE 
---@return MSRSQUEUE #self The MSRSQUEUE object.
function MSRSQUEUE:Clear() end

---Create a new MSRSQUEUE object for a given radio frequency/modulation.
---
------
---@param self MSRSQUEUE 
---@param alias string (Optional) Name of the radio queue.
---@return MSRSQUEUE #self The MSRSQUEUE object.
function MSRSQUEUE:New(alias) end

---Create a new transmission and add it to the radio queue.
---
------
---@param self MSRSQUEUE 
---@param text string Text to play.
---@param duration number Duration in seconds the file lasts. Default is determined by number of characters of the text message.
---@param msrs MSRS MOOSE SRS object.
---@param tstart number Start time (abs) seconds. Default now.
---@param interval number Interval in seconds after the last transmission finished.
---@param subgroups table Groups that should receive the subtiltle.
---@param subtitle string Subtitle displayed when the message is played.
---@param subduration number Duration [sec] of the subtitle being displayed. Default 5 sec.
---@param frequency number Radio frequency if other than MSRS default.
---@param modulation number Radio modulation if other then MSRS default.
---@param gender string Gender of the voice
---@param culture string Culture of the voice
---@param voice string Specific voice
---@param volume number Volume setting
---@param label string Label to be used
---@param coordinate COORDINATE Coordinate to be used
---@return MSRSQUEUE.Transmission #Radio transmission table.
function MSRSQUEUE:NewTransmission(text, duration, msrs, tstart, interval, subgroups, subtitle, subduration, frequency, modulation, gender, culture, voice, volume, label, coordinate) end

---Switch to only transmit if there are players on the server.
---
------
---@param self MSRSQUEUE 
---@param Switch boolean If true, only send SRS if there are alive Players.
---@return MSRSQUEUE #self
function MSRSQUEUE:SetTransmitOnlyWithPlayers(Switch) end

---Check radio queue for transmissions to be broadcasted.
---
------
---@param self MSRSQUEUE 
---@param delay number Delay in seconds before checking.
function MSRSQUEUE:_CheckRadioQueue(delay) end


---Radio queue transmission data.
---@class MSRSQUEUE.Transmission 
---@field PlayerSet SET_CLIENT PlayerSet created when TransmitOnlyWithPlayers == true
---@field Tplay number Mission time (abs) in seconds when the transmission should be played.
---@field TransmitOnlyWithPlayers boolean If true, only transmit if there are alive Players.
---@field Tstarted number Mission time (abs) in seconds when the transmission started.
---@field coordinate COORDINATE Coordinate for this transmission
---@field culture string Voice culture
---@field duration number Duration in seconds.
---@field frequency number Frequency.
---@field gender string Voice gender
---@field interval number Interval in seconds before next transmission.
---@field isplaying boolean If true, transmission is currently playing.
---@field label string Label to be used
---@field modulation number Modulation.
---@field msrs MSRS MOOSE SRS object.
---@field subduration number Duration of the subtitle being displayed.
---@field subtitle string Subtitle of the transmission.
---@field text string Text to be transmitted.
---@field voice string Voice if any
---@field volume number Volume
MSRSQUEUE.Transmission = {}



