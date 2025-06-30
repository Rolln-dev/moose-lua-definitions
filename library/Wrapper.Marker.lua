---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE_Core.JPG" width="100%">
---
---**Wrapper** - Markers On the F10 map.
---
---**Main Features:**
---
---   * Convenient handling of markers via multiple user API functions.
---   * Update text and position of marker easily via scripting.
---   * Delay creation and removal of markers via (optional) parameters.
---   * Retrieve data such as text and coordinate.
---   * Marker specific FSM events when a marker is added, removed or changed.
---   * Additional FSM events when marker text or position is changed.
---
---===
---
---### Author: **funkyfranky**
---Just because...
---
---===
---
---# The MARKER Class Idea
---
---The MARKER class simplifies creating, updating and removing of markers on the F10 map.
---
---# Create a Marker
---
---    -- Create a MARKER object at Batumi with a trivial text.
---    local Coordinate = AIRBASE:FindByName( "Batumi" ):GetCoordinate()
---    mymarker = MARKER:New( Coordinate, "I am Batumi Airfield" )
---
---Now this does **not** show the marker yet. We still need to specify to whom it is shown. There are several options, i.e.
---show the marker to everyone, to a specific coalition only, or only to a specific group.
---
---## For Everyone
---
---If the marker should be visible to everyone, you can use the :ToAll() function.
---
---    mymarker = MARKER:New( Coordinate, "I am Batumi Airfield" ):ToAll()
---
---## For a Coalition
---
---If the maker should be visible to a specific coalition, you can use the :ToCoalition() function.
---
---    mymarker = MARKER:New( Coordinate , "I am Batumi Airfield" ):ToCoalition( coalition.side.BLUE )
---    
---This would show the marker only to the Blue coalition.
---
---## For a Group
---
---    mymarker = MARKER:New( Coordinate , "Target Location" ):ToGroup( tankGroup )
---
---# Removing a Marker
---    mymarker:Remove(60)
---This removes the marker after 60 seconds
---
---# Updating a Marker
---
---The marker text and coordinate can be updated easily as shown below.
---
---However, note that **updating involves to remove and recreate the marker if either text or its coordinate is changed**.
---*This is a DCS scripting engine limitation.*
---
---## Update Text
---
---If you created a marker "mymarker" as shown above, you can update the displayed test by
---
---    mymarker:UpdateText( "I am the new text at Batumi" )
---
---The update can also be delayed by, e.g. 90 seconds, using
---
---    mymarker:UpdateText( "I am the new text at Batumi", 90 )
---
---## Update Coordinate
---
---If you created a marker "mymarker" as shown above, you can update its coordinate on the F10 map by
---
---    mymarker:UpdateCoordinate( NewCoordinate )
---
---The update can also be delayed by, e.g. 60 seconds, using
---
---    mymarker:UpdateCoordinate( NewCoordinate , 60 )
---
---# Retrieve Data
---
---The important data as the displayed text and the coordinate of the marker can be retrieved easily.
---
---## Text
---
---    local text  =mymarker:GetText()
---    env.info( "Marker Text = " .. text )
---
---## Coordinate
---
---    local Coordinate = mymarker:GetCoordinate()
---    env.info( "Marker Coordinate LL DSM = " .. Coordinate:ToStringLLDMS() )
---
---
---# FSM Events
---
---Moose creates additional events, so called FSM event, when markers are added, changed, removed, and text or the coordinate is updated.
---
---These events can be captured and used for processing via OnAfter functions as shown below.
---
---## Added
---
---## Changed
---
---## Removed
---
---## TextUpdate
---
---## CoordUpdate
---
---
---# Examples
---Marker class.
---@class MARKER : FSM
---@field ClassName string Name of the class.
---@field Debug boolean Debug mode. Messages to all about status.
---@field coalition number Coalition to which the marker is displayed.
---@field coordinate COORDINATE Coordinate of the mark.
---@field lid string Class id string for output to DCS log file.
---@field message string Message displayed when the mark is added.
---@field mid number Marker ID.
---@field myid  
---@field readonly boolean Marker is read-only.
---@field shown boolean 
---@field text string Text displayed in the mark panel.
---@field toall boolean 
---@field tocoalition boolean 
---@field togroup boolean 
---@field version string Marker class version.
MARKER = {}

---Triggers the FSM event "Added".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:Added(EventData) end

---Triggers the FSM event "Changed".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:Changed(EventData) end

---Triggers the FSM event "CoordUpdate".
---
------
---@param self MARKER 
---@param Coordinate COORDINATE The new Coordinate.
function MARKER:CoordUpdate(Coordinate) end

---Get position of the marker.
---
------
---@param self MARKER 
---@return COORDINATE #The coordinate of the marker.
function MARKER:GetCoordinate() end

---Get text that is displayed in the marker panel.
---
------
---@param self MARKER 
---@return string #Marker text.
function MARKER:GetText() end

---Check if marker is currently invisible on the F10 map.
---
------
---@param self MARKER 
---@return  #
function MARKER:IsInvisible() end

---Check if marker is currently visible on the F10 map.
---
------
---@param self MARKER 
---@return boolean #True if the marker is currently visible.
function MARKER:IsVisible() end

---Set message that is displayed on screen if the marker is added.
---
------
---@param self MARKER 
---@param Text string Message displayed when the marker is added.
---@return MARKER #self
function MARKER:Message(Text) end

---Create a new MARKER class object.
---
------
---@param self MARKER 
---@param Coordinate COORDINATE Coordinate where to place the marker.
---@param Text string Text displayed on the mark panel.
---@return MARKER #self
function MARKER:New(Coordinate, Text) end

---On after "Added" event user function.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:OnAfterAdded(From, Event, To, EventData) end

---On after "Changed" event user function.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:OnAfterChanged(From, Event, To, EventData) end

---On after "CoordUpdate" event user function.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE The updated Coordinate.
function MARKER:OnAfterCoordUpdate(From, Event, To, Coordinate) end

---On after "Removed" event user function.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:OnAfterRemoved(From, Event, To, EventData) end

---On after "TextUpdate" event user function.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Text string The new text.
function MARKER:OnAfterTextUpdate(From, Event, To, Text) end

---Event function when a MARKER is added.
---
------
---@param self MARKER 
---@param EventData EVENTDATA 
function MARKER:OnEventMarkAdded(EventData) end

---Event function when a MARKER changed.
---
------
---@param self MARKER 
---@param EventData EVENTDATA 
function MARKER:OnEventMarkChange(EventData) end

---Event function when a MARKER is removed.
---
------
---@param self MARKER 
---@param EventData EVENTDATA 
function MARKER:OnEventMarkRemoved(EventData) end

---Marker is readonly.
---Text cannot be changed and marker cannot be removed. The will not update the marker in the game, Call MARKER:Refresh to update state.
---
------
---@param self MARKER 
---@return MARKER #self
function MARKER:ReadOnly() end

---Marker is read and write.
---Text cannot be changed and marker cannot be removed. The will not update the marker in the game, Call MARKER:Refresh to update state.
---
------
---@param self MARKER 
---@return MARKER #self
function MARKER:ReadWrite() end

---Refresh the marker.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:Refresh(Delay) end

---Remove a marker.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is removed.
---@return MARKER #self
function MARKER:Remove(Delay) end

---Triggers the FSM event "Removed".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:Removed(EventData) end

---Set text that is displayed in the marker panel.
---Note this does not show the marker.
---
------
---@param self MARKER 
---@param Text string Marker text. Default is an empty string "".
---@return MARKER #self
function MARKER:SetText(Text) end

---Triggers the FSM event "TextUpdate".
---
------
---@param self MARKER 
---@param Text string The new text.
function MARKER:TextUpdate(Text) end

---Place marker visible for everyone.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToAll(Delay) end

---Place marker visible for the blue coalition only.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToBlue(Delay) end

---Place marker visible for a specific coalition only.
---
------
---@param self MARKER 
---@param Coalition number Coalition 1=Red, 2=Blue, 0=Neutral. See `coalition.side.RED`.
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToCoalition(Coalition, Delay) end

---Place marker visible for a specific group only.
---
------
---@param self MARKER 
---@param Group GROUP The group to which the marker is displayed.
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToGroup(Group, Delay) end

---Place marker visible for the neutral coalition only.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToNeutral(Delay) end

---Place marker visible for the blue coalition only.
---
------
---@param self MARKER 
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:ToRed(Delay) end

---Update the coordinate where the marker is displayed.
---
------
---@param self MARKER 
---@param Coordinate COORDINATE The new coordinate.
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:UpdateCoordinate(Coordinate, Delay) end

---Update the text displayed on the mark panel.
---
------
---@param self MARKER 
---@param Text string Updated text.
---@param Delay number (Optional) Delay in seconds, before the marker is created.
---@return MARKER #self
function MARKER:UpdateText(Text, Delay) end

---Triggers the delayed FSM event "Added".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:__Added(EventData) end

---Triggers the delayed FSM event "Changed".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:__Changed(EventData) end

---Triggers the delayed FSM event "CoordUpdate".
---
------
---@param self MARKER 
---@param Coordinate COORDINATE The updated Coordinate.
function MARKER:__CoordUpdate(Coordinate) end

---Triggers the delayed FSM event "Removed".
---
------
---@param self MARKER 
---@param EventData EVENTDATA Event data table.
function MARKER:__Removed(EventData) end

---Triggers the delayed FSM event "TextUpdate".
---
------
---@param self MARKER 
---@param Text string The new text.
function MARKER:__TextUpdate(Text) end

---On after "Added" event.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:onafterAdded(From, Event, To, EventData) end

---On after "Changed" event.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:onafterChanged(From, Event, To, EventData) end

---On after "CoordUpdate" event.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coordinate COORDINATE The updated coordinates.
function MARKER:onafterCoordUpdate(From, Event, To, Coordinate) end

---On after "Removed" event.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param EventData EVENTDATA Event data table.
function MARKER:onafterRemoved(From, Event, To, EventData) end

---On after "TextUpdate" event.
---
------
---@param self MARKER 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Text string The updated text, displayed in the mark panel.
function MARKER:onafterTextUpdate(From, Event, To, Text) end



