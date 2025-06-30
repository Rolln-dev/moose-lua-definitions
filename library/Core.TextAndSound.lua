---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Core** - A Moose GetText system.
---
---===
---
---## Main Features:
---
---   * A GetText for Moose
---   * Build a set of localized text entries, alongside their sounds and subtitles
---   * Aimed at class developers to offer localizable language support
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/).
---      
---===
---
---### Author: **applevangelist**
---## Date: April 2022
---
---===
---Text and Sound class.
---@class TEXTANDSOUND : BASE
---@field ClassName string Name of this class.
---@field lid string LID for log entries.
---@field locale string Default locale of this object.
---@field textclass string Name of the class the texts belong to.
---@field version string Versioning.
TEXTANDSOUND = {}

---Add an entry
---
------
---@param self TEXTANDSOUND 
---@param Locale string Locale to set for this entry, e.g. "de".
---@param ID string Unique(!) ID of this entry under this locale (i.e. use the same ID to get localized text for the entry in another language).
---@param Text string Text for this entry.
---@param Soundfile string (Optional) Sound file name for this entry.
---@param Soundlength number (Optional) Length of the sound file in seconds.
---@param Subtitle string (Optional) Subtitle to be used alongside the sound file.
---@return TEXTANDSOUND #self
function TEXTANDSOUND:AddEntry(Locale, ID, Text, Soundfile, Soundlength, Subtitle) end

---Flush all entries to the log
---
------
---@param self TEXTANDSOUND 
---@return TEXTANDSOUND #self
function TEXTANDSOUND:FlushToLog() end

---Get the default locale of this object
---
------
---@param self TEXTANDSOUND 
---@return string #locale
function TEXTANDSOUND:GetDefaultLocale() end

---Get an entry
---
------
---@param self TEXTANDSOUND 
---@param ID string The unique ID of the data to be retrieved.
---@param Locale string (Optional) The locale of the text to be retrieved - defauls to default locale set with `New()`.
---@return string #Text Text or nil if not found and no fallback.
---@return string #Soundfile Filename or nil if not found and no fallback.
---@return string #Soundlength Length of the sound or 0 if not found and no fallback.
---@return string #Subtitle Text for subtitle or nil if not found and no fallback.
function TEXTANDSOUND:GetEntry(ID, Locale) end

---Check if a locale exists
---
------
---@param self TEXTANDSOUND 
---@param Locale NOTYPE 
---@return boolean #outcome
function TEXTANDSOUND:HasLocale(Locale) end

---Instantiate a new object
---
------
---@param self TEXTANDSOUND 
---@param ClassName string Name of the class this instance is providing texts for.
---@param Defaultlocale string (Optional) Default locale of this instance, defaults to "en". 
---@return TEXTANDSOUND #self
function TEXTANDSOUND:New(ClassName, Defaultlocale) end

---Set default locale of this object
---
------
---@param self TEXTANDSOUND 
---@param locale string 
---@return TEXTANDSOUND #self 
function TEXTANDSOUND:SetDefaultLocale(locale) end


---Text and Sound data
---@class TEXTANDSOUND.Data 
---@field ID string ID of this entry for retrieval.
---@field Soundfile string (optional) Soundfile File name of the corresponding sound file.
---@field Soundlength number (optional)  Length of the sound file in seconds.
---@field Subtitle string (optional)  Subtitle for the sound file.
---@field Text string Text of this entry.
TEXTANDSOUND.Data = {}


---Text and Sound entry.
---@class TEXTANDSOUND.Entry 
---@field Classname string Name of the class this entry is for.
---@field Locale string Locale of this entry, defaults to "en".
TEXTANDSOUND.Entry = {}



