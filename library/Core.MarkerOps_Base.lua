---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE_Core.JPG" width="100%">
---
---**Core** - Tap into markers added to the F10 map by users.
---
---**Main Features:**
---
---   * Create an easy way to tap into markers added to the F10 map by users.
---   * Recognize own tag and list of keywords.
---   * Matched keywords are handed down to functions.
---##Listen for your tag
---   myMarker = MARKEROPS_BASE:New("tag", {}, false)
---   function myMarker:OnAfterMarkChanged(From, Event, To, Text, Keywords, Coord, idx)
---
---   end
---Make sure to use the "MarkChanged" event as "MarkAdded" comes in right after the user places a blank marker and your callback will never be called.
---
---===
---
---### Author: **Applevangelist**
---
---Date: 5 May 2021
---Last Update: Mar 2023
---
---===
---*Fiat lux.* -- Latin proverb.
---
---===
---
---# The MARKEROPS_BASE Concept
---
---This class enable scripting text-based actions from markers.
---MARKEROPS_BASE class.
---@class MARKEROPS_BASE : FSM
---@field Casesensitive boolean Enforce case when identifying the Tag, i.e. tag ~= Tag
---@field ClassName string Name of the class.
---@field Keywords table Table of keywords to recognize.
---@field Tag string Tag to identify commands.
---@field private debug boolean 
---@field private lid NOTYPE 
---@field private version string Version of #MARKEROPS_BASE.
MARKEROPS_BASE = {}

---Function to instantiate a new #MARKEROPS_BASE object.
---
------
---@param Tagname string Name to identify us from the event text.
---@param Keywords table Table of keywords  recognized from the event text.
---@param Casesensitive? boolean (Optional) Switch case sensitive identification of Tagname. Defaults to true.
---@return MARKEROPS_BASE #self
function MARKEROPS_BASE:New(Tagname, Keywords, Casesensitive) end

---On after "MarkAdded" event.
---Triggered when a Marker is added to the F10 map.
---
------
---@param From string The From state.
---@param Event string The Event called.
---@param To string The To state.
---@param Text string The text on the marker.
---@param Keywords table Table of matching keywords found in the Event text.
---@param Coord COORDINATE Coordinate of the marker.
---@param MarkerID number Id of this marker.
---@param CoalitionNumber number Coalition of the marker creator.
---@param PlayerName string Name of the player creating/changing the mark. nil if it cannot be obtained. 
---@param EventData EVENTDATA the event data table. 
function MARKEROPS_BASE:OnAfterMarkAdded(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber, PlayerName, EventData) end

---On after "MarkChanged" event.
---Triggered when a Marker is changed on the F10 map.
---
------
---@param From string The From state.
---@param Event string The Event called.
---@param To string The To state.
---@param Text string The text on the marker.
---@param Keywords table Table of matching keywords found in the Event text.
---@param Coord COORDINATE Coordinate of the marker.
---@param MarkerID number Id of this marker.
---@param CoalitionNumber number Coalition of the marker creator.
---@param PlayerName string Name of the player creating/changing the mark. nil if it cannot be obtained. 
---@param EventData EVENTDATA the event data table
function MARKEROPS_BASE:OnAfterMarkChanged(From, Event, To, Text, Keywords, Coord, MarkerID, CoalitionNumber, PlayerName, EventData) end

---On after "MarkDeleted" event.
---Triggered when a Marker is deleted from the F10 map.
---
------
---@param From string The From state
---@param Event string The Event called
---@param To string The To state
function MARKEROPS_BASE:OnAfterMarkDeleted(From, Event, To) end

---(internal) Handle events.
---
------
---@param Event EVENTDATA 
function MARKEROPS_BASE:OnEventMark(Event) end

---"Stop" trigger.
---Used to stop the function an unhandle events
---
------
function MARKEROPS_BASE.Stop() end

---(internal) Match keywords table.
---
------
---@param Eventtext string Text added to the marker.
---@return table #
function MARKEROPS_BASE:_MatchKeywords(Eventtext) end

---(internal) Match tag.
---
------
---@param Eventtext string Text added to the marker.
---@return boolean #
function MARKEROPS_BASE:_MatchTag(Eventtext) end

---On before "MarkAdded" event.
---Triggered when a Marker is added to the F10 map.
---
------
---@param From string The From state
---@param Event string The Event called
---@param To string The To state
---@param Text string The text on the marker
---@param Keywords table Table of matching keywords found in the Event text
---@param MarkerID number Id of this marker
---@param CoalitionNumber number Coalition of the marker creator
---@param Coord COORDINATE Coordinate of the marker.
---@private
function MARKEROPS_BASE:onbeforeMarkAdded(From, Event, To, Text, Keywords, MarkerID, CoalitionNumber, Coord) end

---On before "MarkChanged" event.
---Triggered when a Marker is changed on the F10 map.
---
------
---@param From string The From state
---@param Event string The Event called
---@param To string The To state
---@param Text string The text on the marker
---@param Keywords table Table of matching keywords found in the Event text
---@param MarkerID number Id of this marker
---@param CoalitionNumber number Coalition of the marker creator
---@param Coord COORDINATE Coordinate of the marker.
---@private
function MARKEROPS_BASE:onbeforeMarkChanged(From, Event, To, Text, Keywords, MarkerID, CoalitionNumber, Coord) end

---On before "MarkDeleted" event.
---Triggered when a Marker is removed from the F10 map.
---
------
---@param From string The From state
---@param Event string The Event called
---@param To string The To state
---@private
function MARKEROPS_BASE:onbeforeMarkDeleted(From, Event, To) end

---On enter "Stopped" event.
---Unsubscribe events.
---
------
---@param From string The From state
---@param Event string The Event called
---@param To string The To state
---@private
function MARKEROPS_BASE:onenterStopped(From, Event, To) end



