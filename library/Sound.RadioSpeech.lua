---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Radio.JPG" width="100%">
---
---**Core** - Makes the radio talk.
---
---===
---
---## Features:
---
---  * Send text strings using a vocabulary that is converted in spoken language.
---  * Possiblity to implement multiple language.
---
---===
---
---### Authors: FlightControl
---Makes the radio speak.
---
---# RADIOSPEECH usage
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class RADIOSPEECH : RADIOQUEUE
---@field ClassName string 
---@field Language string 
---@field Speech table 
---@field Vocabulary table 
RADIOSPEECH = {}

---Add Sentence to the Speech collection.
---
------
---@param self RADIOSPEECH 
---@param RemainingSentence string The remaining sentence during recursion.
---@param Speech table The speech node.
---@param Sentence string The full sentence.
---@param Data string The speech data.
---@return RADIOSPEECH #self The RADIOSPEECH object.
function RADIOSPEECH:AddSentenceToSpeech(RemainingSentence, Speech, Sentence, Data) end

---Build the tree structure based on the language words, in order to find the correct sentences and to ignore incomprehensible words.
---
------
---@param self RADIOSPEECH 
---@return RADIOSPEECH #self The RADIOSPEECH object.
function RADIOSPEECH:BuildTree() end

---Create a new RADIOSPEECH object for a given radio frequency/modulation.
---
------
---@param self RADIOSPEECH 
---@param frequency number The radio frequency in MHz.
---@param modulation? number (Optional) The radio modulation. Default radio.modulation.AM.
---@return RADIOSPEECH #self The RADIOSPEECH object.
function RADIOSPEECH:New(frequency, modulation) end


---
------
---@param self NOTYPE 
---@param Langauge NOTYPE 
function RADIOSPEECH:SetLanguage(Langauge) end

---Speak a sentence.
---
------
---@param self RADIOSPEECH 
---@param Sentence string The sentence to be spoken.
---@param Language NOTYPE 
function RADIOSPEECH:Speak(Sentence, Language) end

---Speak a sentence.
---
------
---@param self RADIOSPEECH 
---@param Sentence string The sentence to be spoken.
---@param Speech NOTYPE 
---@param Langauge NOTYPE 
function RADIOSPEECH:SpeakDigits(Sentence, Speech, Langauge) end

---Speak a sentence.
---
------
---@param self RADIOSPEECH 
---@param Sentence string The sentence to be spoken.
---@param Speech NOTYPE 
---@param Language NOTYPE 
function RADIOSPEECH:SpeakWords(Sentence, Speech, Language) end



