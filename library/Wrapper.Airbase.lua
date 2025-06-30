---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Airbase.JPG" width="100%">
---
---**Wrapper** - AIRBASE is a wrapper class to handle the DCS Airbase objects.
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: **funkyfranky**
---
---===
---Wrapper class to handle the DCS Airbase objects:
---
--- * Support all DCS Airbase APIs.
--- * Enhance with Airbase specific APIs not in the DCS Airbase API set.
---
---## AIRBASE reference methods
---
---For each DCS Airbase object alive within a running mission, a AIRBASE wrapper object (instance) will be created within the global _DATABASE object (an instance of Core.Database#DATABASE).
---This is done at the beginning of the mission (when the mission starts).
---
---The AIRBASE class **does not contain a :New()** method, rather it provides **:Find()** methods to retrieve the object reference
---using the DCS Airbase or the DCS AirbaseName.
---
---Another thing to know is that AIRBASE objects do not "contain" the DCS Airbase object.
---The AIRBASE methods will reference the DCS Airbase object by name when it is needed during API execution.
---If the DCS Airbase object does not exist or is nil, the AIRBASE methods will return nil and log an exception in the DCS.log file.
---
---The AIRBASE class provides the following functions to retrieve quickly the relevant AIRBASE instance:
---
--- * #AIRBASE.Find(): Find a AIRBASE instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Airbase object.
--- * #AIRBASE.FindByName(): Find a AIRBASE instance from the global _DATABASE object (an instance of Core.Database#DATABASE) using a DCS Airbase name.
---
---IMPORTANT: ONE SHOULD NEVER SANITIZE these AIRBASE OBJECT REFERENCES! (make the AIRBASE object references nil).
---
---## DCS Airbase APIs
---
---The DCS Airbase APIs are used extensively within MOOSE. The AIRBASE class has for each DCS Airbase API a corresponding method.
---To be able to distinguish easily in your code the difference between a AIRBASE API call and a DCS Airbase API call,
---the first letter of the method is also capitalized. So, by example, the DCS Airbase method DCSWrapper.Airbase#Airbase.getName()
---is implemented in the AIRBASE class as #AIRBASE.GetName().
---
---## Note on the "H" heli pads in the Syria map:
---
---As of the time of writing (Oct 2024, DCS DCS 2.9.8.1107), these 143 objects have the **same name and object ID**, which makes them unusable in Moose, e.g. you cannot find a specific one for spawning etc.
---Waiting for Ugra and ED to fix this issue.
---@class AIRBASE : POSITIONABLE
---@field AirbaseID number Airbase ID.
---@field AirbaseName string Name of the airbase.
---@field AirbaseZone ZONE Circular zone around the airbase with a radius of 2500 meters. For ships this is a ZONE_UNIT object.
---@field ClassName string Name of the class, i.e. "AIRBASE".
---@field NparkingTotal number 
---@field category number Airbase category.
---@field isAirdrome boolean Airbase is an airdrome.
---@field isHelipad boolean Airbase is a helipad.
---@field isShip boolean Airbase is a ship.
---@field storage STORAGE The DCS warehouse storage.
AIRBASE = {}

---Function that checks if at leat one unit of a group has been spawned close to a spawn point on the runway.
---
------
---@param self AIRBASE 
---@param group GROUP Group to be checked.
---@param radius number Radius around the spawn point to be checked. Default is 50 m.
---@param despawn boolean If true, the group is destroyed.
---@return boolean #True if group is within radius around spawn points on runway.
function AIRBASE:CheckOnRunWay(group, radius, despawn) end

---Finds a AIRBASE from the _DATABASE using a DCSAirbase object.
---
------
---@param self AIRBASE 
---@param DCSAirbase Airbase An existing DCS Airbase object reference.
---@return AIRBASE #self
function AIRBASE:Find(DCSAirbase) end

---Find a AIRBASE in the _DATABASE by its ID.
---
------
---@param self AIRBASE 
---@param id number Airbase ID.
---@return AIRBASE #self
function AIRBASE:FindByID(id) end

---Find a AIRBASE in the _DATABASE using the name of an existing DCS Airbase.
---
------
---@param self AIRBASE 
---@param AirbaseName string The Airbase Name.
---@return AIRBASE #self
function AIRBASE:FindByName(AirbaseName) end

---Seach unoccupied parking spots at the airbase for a specific group of aircraft.
---The routine also optionally checks for other unit, static and scenery options in a certain radius around the parking spot.
---The dimension of the spawned aircraft and of the potential obstacle are taken into account. Note that the routine can only return so many spots that are free.
---
------
---@param self AIRBASE 
---@param group GROUP Aircraft group for which the parking spots are requested.
---@param terminaltype AIRBASE.TerminalType (Optional) Only search spots at a specific terminal type. Default is all types execpt on runway.
---@param scanradius number (Optional) Radius in meters around parking spot to scan for obstacles. Default 50 m.
---@param scanunits boolean (Optional) Scan for units as obstacles. Default true.
---@param scanstatics boolean (Optional) Scan for statics as obstacles. Default true.
---@param scanscenery boolean (Optional) Scan for scenery as obstacles. Default false. Can cause problems with e.g. shelters.
---@param verysafe boolean (Optional) If true, wait until an aircraft has taken off until the parking spot is considered to be free. Defaul false.
---@param nspots number (Optional) Number of freeparking spots requested. Default is the number of aircraft in the group.
---@param parkingdata table (Optional) Parking spots data table. If not given it is automatically derived from the GetParkingSpotsTable() function.
---@return table #Table of coordinates and terminal IDs of free parking spots. Each table entry has the elements .Coordinate and .TerminalID.
function AIRBASE:FindFreeParkingSpotForAircraft(group, terminaltype, scanradius, scanunits, scanstatics, scanscenery, verysafe, nspots, parkingdata) end

---Get the active runways.
---
------
---@param self AIRBASE 
---@return AIRBASE.Runway #The active runway for landing.
---@return AIRBASE.Runway #The active runway for takeoff.
function AIRBASE:GetActiveRunway() end

---Get the active runway for landing.
---
------
---@param self AIRBASE 
---@return AIRBASE.Runway #The active runway for landing.
function AIRBASE:GetActiveRunwayLanding() end

---Get the active runway for takeoff.
---
------
---@param self AIRBASE 
---@return AIRBASE.Runway #The active runway for takeoff.
function AIRBASE:GetActiveRunwayTakeoff() end

---Get category of airbase.
---
------
---@param self AIRBASE 
---@return number #Category of airbase from GetDesc().category.
function AIRBASE:GetAirbaseCategory() end

---Get all airbase names of the current map.
---This includes ships and FARPS.
---
------
---@param coalition Coalition (Optional) Return only airbases belonging to the specified coalition. By default, all airbases of the map are returned.
---@param category number (Optional) Return only airbases of a certain category, e.g. `Airbase.Category.HELIPAD`.
---@return table #Table containing all airbase names of the current map.
function AIRBASE.GetAllAirbaseNames(coalition, category) end

---Get all airbases of the current map.
---This includes ships and FARPS.
---
------
---@param coalition Coalition (Optional) Return only airbases belonging to the specified coalition. By default, all airbases of the map are returned.
---@param category number (Optional) Return only airbases of a certain category, e.g. Airbase.Category.FARP
---@return table #Table containing all airbase objects of the current map.
function AIRBASE.GetAllAirbases(coalition, category) end

---Get category of airbase.
---
------
---@param self AIRBASE 
---@return number #Category of airbase from GetDesc().category.
function AIRBASE:GetCategory() end

---Get category name of airbase.
---
------
---@param self AIRBASE 
---@return string #Category of airbase, i.e. Airdrome, Ship, or Helipad
function AIRBASE:GetCategoryName() end

---Get the DCS object of an airbase
---
------
---@param self AIRBASE 
---@return Airbase #DCS airbase object.
function AIRBASE:GetDCSObject() end

---Get the coordinates of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type.
---@param allowTOAC boolean If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return table #Table of coordinates of the free parking spots.
function AIRBASE:GetFreeParkingSpotsCoordinates(termtype, allowTOAC) end

---Get number of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type.
---@param allowTOAC boolean If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return number #Number of free parking spots at this airbase.
function AIRBASE:GetFreeParkingSpotsNumber(termtype, allowTOAC) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type.
---@param allowTOAC boolean If true, spots are considered free even though TO_AC is true. Default is off which is saver to avoid spawning aircraft on top of each other. Option might be enabled for FARPS and ships.
---@return table #Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetFreeParkingSpotsTable(termtype, allowTOAC) end

---Get ID of the airbase.
---
------
---@param self AIRBASE 
---@param unique boolean (Optional) If true, ships will get a negative sign as the unit ID might be the same as an airbase ID. Default off!
---@return number #The airbase ID.
function AIRBASE:GetID(unique) end

---Returns a table of parking data for a given airbase.
---If the optional parameter *available* is true only available parking will be returned, otherwise all parking at the base is returned. Term types have the following enumerated values:
---
---* 16 : Valid spawn points on runway
---* 40 : Helicopter only spawn
---* 68 : Hardened Air Shelter
---* 72 : Open/Shelter air airplane only
---* 104: Open air spawn
---
---Note that only Caucuses will return 68 as it is the only map currently with hardened air shelters.
---104 are also generally larger, but does not guarantee a large aircraft like the B-52 or a C-130 are capable of spawning there.
---
---Table entries:
---
---* Term_index is the id for the parking
---* vTerminal pos is its vec3 position in the world
---* fDistToRW is the distance to the take-off position for the active runway from the parking.
---
------
---@param self AIRBASE 
---@param available boolean If true, only available parking spots will be returned.
---@return table #Table with parking data. See https://wiki.hoggitworld.com/view/DCS_func_getParking
function AIRBASE:GetParkingData(available) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param TerminalID number The terminal ID of the parking spot.
---@return AIRBASE.ParkingSpot #Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetParkingSpotData(TerminalID) end

---Get the coordinates of all parking spots at an airbase.
---Optionally only those of a specific terminal type. Spots on runways are excluded if not explicitly requested by terminal type.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType (Optional) Terminal type. Default all.
---@return table #Table of coordinates of parking spots.
function AIRBASE:GetParkingSpotsCoordinates(termtype) end

---Get number of parking spots at an airbase.
---Optionally, a specific terminal type can be requested.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type of which the number of spots is counted. Default all spots but spawn points on runway.
---@return number #Number of parking spots at this airbase.
function AIRBASE:GetParkingSpotsNumber(termtype) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type.
---@return table #Table free parking spots. Table has the elements ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
function AIRBASE:GetParkingSpotsTable(termtype) end

---Check whether or not the airbase has been silenced.
---
------
---@param self AIRBASE 
---@return boolean #If `true`, silent mode is enabled.
function AIRBASE:GetRadioSilentMode() end

---Get runway by its name.
---
------
---@param self AIRBASE 
---@param Name string Name of the runway, e.g. "31" or "21L".
---@return AIRBASE.Runway #Runway data.
function AIRBASE:GetRunwayByName(Name) end

---Get runways data.
---Only for airdromes!
---
------
---@param self AIRBASE 
---@param magvar number (Optional) Magnetic variation in degrees.
---@param mark boolean (Optional) Place markers with runway data on F10 map.
---@return table #Runway data.
function AIRBASE:GetRunwayData(magvar, mark) end

---Get the runway where aircraft would be taking of or landing into the direction of the wind.
---NOTE that this requires the wind to be non-zero as set in the mission editor.
---
------
---@param self AIRBASE 
---@param PreferLeft boolean If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway #Active runway data table.
function AIRBASE:GetRunwayIntoWind(PreferLeft) end

---Get name of a given runway, e.g.
---"31L".
---
------
---@param self AIRBASE 
---@param Runway AIRBASE.Runway The runway. Default is the active runway.
---@param LongLeftRight boolean If `true`, return "Left" or "Right" instead of "L" or "R".
---@return string #Name of the runway or "XX" if it could not be found.
function AIRBASE:GetRunwayName(Runway, LongLeftRight) end

---Get runways.
---
------
---@param self AIRBASE 
---@return table #Runway data.
function AIRBASE:GetRunways() end

---Get the warehouse storage of this airbase.
---The returned `STORAGE` object is the wrapper of the DCS warehouse.
---This allows you to add and remove items such as aircraft, liquids, weapons and other equipment.
---
------
---@param self AIRBASE 
---@return STORAGE #The storage.
function AIRBASE:GetStorage() end

---Get the DCS warehouse.
---
------
---@param self AIRBASE 
---@return Warehouse #The DCS warehouse object.
function AIRBASE:GetWarehouse() end

---Get the airbase zone.
---
------
---@param self AIRBASE 
---@return ZONE_RADIUS #The zone radius of the airbase.
function AIRBASE:GetZone() end

---Check if airbase is an airdrome.
---
------
---@param self AIRBASE 
---@return boolean #If true, airbase is an airdrome.
function AIRBASE:IsAirdrome() end

---Returns whether auto capturing of the airbase is on or off.
---
------
---@param self AIRBASE 
---@return boolean #Returns `true` if auto capturing is on, `false` if off and `nil` if the airbase object cannot be retrieved.
function AIRBASE:IsAutoCapture() end

---Check if airbase is a helipad.
---
------
---@param self AIRBASE 
---@return boolean #If true, airbase is a helipad.
function AIRBASE:IsHelipad() end

---Check if airbase is a ship.
---
------
---@param self AIRBASE 
---@return boolean #If true, airbase is a ship.
function AIRBASE:IsShip() end

---Place markers of parking spots on the F10 map.
---
------
---@param self AIRBASE 
---@param termtype AIRBASE.TerminalType Terminal type for which marks should be placed.
---@param mark boolean If false, do not place markers but only give output to DCS.log file. Default true.
function AIRBASE:MarkParkingSpots(termtype, mark) end

---Create a new AIRBASE from DCSAirbase.
---
------
---@param self AIRBASE 
---@param AirbaseName string The name of the airbase.
---@return AIRBASE #self
function AIRBASE:Register(AirbaseName) end

---Set the active runway for landing and takeoff.
---
------
---@param self AIRBASE 
---@param Name string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft boolean If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
function AIRBASE:SetActiveRunway(Name, PreferLeft) end

---Set the active runway for landing.
---
------
---@param self AIRBASE 
---@param Name string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft boolean If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway #The active runway for landing.
function AIRBASE:SetActiveRunwayLanding(Name, PreferLeft) end

---Set the active runway for takeoff.
---
------
---@param self AIRBASE 
---@param Name string Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param PreferLeft boolean If `true`, perfer the left runway. If `false`, prefer the right runway. If `nil` (default), do not care about left or right.
---@return AIRBASE.Runway #The active runway for landing.
function AIRBASE:SetActiveRunwayTakeoff(Name, PreferLeft) end

---Enables or disables automatic capturing of the airbase.
---
------
---@param self AIRBASE 
---@param Switch boolean If `true`, enable auto capturing. If `false`, disable it.
---@return AIRBASE #self
function AIRBASE:SetAutoCapture(Switch) end

---Disables automatic capturing of the airbase.
---
------
---@param self AIRBASE 
---@return AIRBASE #self
function AIRBASE:SetAutoCaptureOFF() end

---Enables automatic capturing of the airbase.
---
------
---@param self AIRBASE 
---@return AIRBASE #self
function AIRBASE:SetAutoCaptureON() end

---Sets the coalition of the airbase.
---
------
---@param self AIRBASE 
---@param Coal number Coalition that the airbase should have (0=Neutral, 1=Red, 2=Blue).
---@return AIRBASE #self
function AIRBASE:SetCoalition(Coal) end

---Set parking spot blacklist.
---These parking spots will *not* be used for spawning.
---Black listed spots overrule white listed spots.
---**NOTE** that terminal IDs are not necessarily the same as those displayed in the mission editor!
---
------
---
---USAGE
---```
---AIRBASE:FindByName("Batumi"):SetParkingSpotBlacklist({2, 3, 4}) --Forbit terminal IDs 2, 3, 4
---```
------
---@param self AIRBASE 
---@param TerminalIdBlacklist table Table of black listed terminal IDs.
---@return AIRBASE #self
function AIRBASE:SetParkingSpotBlacklist(TerminalIdBlacklist) end

---Set parking spot whitelist.
---Only these spots will be considered for spawning.
---Black listed spots overrule white listed spots.
---**NOTE** that terminal IDs are not necessarily the same as those displayed in the mission editor!
---
------
---
---USAGE
---```
---AIRBASE:FindByName("Batumi"):SetParkingSpotWhitelist({2, 3, 4}) --Only allow terminal IDs 2, 3, 4
---```
------
---@param self AIRBASE 
---@param TerminalIdWhitelist table Table of white listed terminal IDs.
---@return AIRBASE #self
function AIRBASE:SetParkingSpotWhitelist(TerminalIdWhitelist) end

---Sets the ATC belonging to an airbase object to be silent and unresponsive.
---This is useful for disabling the award winning ATC behavior in DCS.
---Note that this DOES NOT remove the airbase from the list. It just makes it unresponsive and silent to any radio calls to it.
---
------
---@param self AIRBASE 
---@param Silent boolean If `true`, enable silent mode. If `false` or `nil`, disable silent mode.
---@return AIRBASE #self
function AIRBASE:SetRadioSilentMode(Silent) end

---Check black and white lists.
---
------
---@param self AIRBASE 
---@param TerminalID number Terminal ID to check.
---@return boolean #`true` if this is a valid spot.
function AIRBASE:_CheckParkingLists(TerminalID) end

---Helper function to check for the correct terminal type including "artificial" ones.
---
------
---@param Term_Type number Terminal type from getParking routine.
---@param termtype AIRBASE.TerminalType Terminal type from AIRBASE.TerminalType enumerator.
---@return boolean #True if terminal types match.
function AIRBASE._CheckTerminalType(Term_Type, termtype) end

---Get the category of this airbase.
---This is only a debug function because DCS 2.9 incorrectly returns heliports as airdromes.
---
------
---@param self AIRBASE 
function AIRBASE:_GetCategory() end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@param TerminalID number Terminal ID.
---@return AIRBASE.ParkingSpot #Parking spot.
function AIRBASE:_GetParkingSpotByID(TerminalID) end

---Get a table containing the coordinates, terminal index and terminal type of free parking spots at an airbase.
---
------
---@param self AIRBASE 
---@return AIRBASE #self
function AIRBASE:_InitParkingSpots() end

---Init runways.
---
------
---@param self AIRBASE 
---@param IncludeInverse boolean If `true` or `nil`, include inverse runways.
---@return table #Runway data.
function AIRBASE:_InitRunways(IncludeInverse) end


---AIRBASE.ParkingSpot ".Coordinate, ".TerminalID", ".TerminalType", ".TOAC", ".Free", ".TerminalID0", ".DistToRwy".
---@class AIRBASE.ParkingSpot 
---@field AirbaseName string Name of the airbase.
---@field ClientName string Client unit name of this spot.
---@field ClientSpot string If `true`, this is a parking spot of a client aircraft.
---@field Coordinate COORDINATE Coordinate of the parking spot.
---@field DistToRwy number Distance to runway in meters. Currently bugged and giving the same number as the TerminalID.
---@field Free boolean This spot is currently free, i.e. there is no alive aircraft on it at the present moment.
---@field Marker MARKER The marker on the F10 map.
---@field MarkerID number Numerical ID of marker placed at parking spot.
---@field OccupiedBy string Name of the aircraft occupying the spot or "unknown". Can be *nil* if spot is not occupied.
---@field ReservedBy string Name of the aircraft for which this spot is reserved. Can be *nil* if spot is not reserved.
---@field Status string Status of spot e.g. `AIRBASE.SpotStatus.FREE`.
---@field TOAC boolean Takeoff or landing aircarft. I.e. this stop is occupied currently by an aircraft until it took of or until it landed.
---@field TerminalID number Terminal ID of the spot. Generally, this is not the same number as displayed in the mission editor.
---@field TerminalID0 number Unknown what this means. If you know, please tell us!
---@field Vec3  
AIRBASE.ParkingSpot = {}


---Runway data.
---@class AIRBASE.Runway 
---@field center COORDINATE Center of the runway.
---@field endpoint COORDINATE End point of runway.
---@field heading number True heading of the runway in degrees.
---@field idx string Runway ID: heading 070° ==> idx="07".
---@field isLeft boolean If `true`, this is the left of two parallel runways. If `false`, this is the right of two runways. If `nil`, no parallel runway exists.
---@field length number Length of runway in meters.
---@field magheading number Magnetic heading of the runway in degrees. This is what is marked on the runway.
---@field name string Runway name.
---@field position COORDINATE Position of runway start.
---@field width number Width of runway in meters.
---@field zone ZONE_POLYGON Runway zone.
AIRBASE.Runway = {}


---Status of a parking spot.
---@class AIRBASE.SpotStatus 
---@field FREE string Spot is free.
---@field OCCUPIED string Spot is occupied.
---@field RESERVED string Spot is reserved.
AIRBASE.SpotStatus = {}


---Terminal Types of parking spots.
---See also https://wiki.hoggitworld.com/view/DCS_func_getParking
---
---Supported types are:
---
---* AIRBASE.TerminalType.Runway = 16: Valid spawn points on runway.
---* AIRBASE.TerminalType.HelicopterOnly = 40: Special spots for Helicopers.
---* AIRBASE.TerminalType.Shelter = 68: Hardened Air Shelter. Currently only on Caucaus map.
---* AIRBASE.TerminalType.OpenMed = 72: Open/Shelter air airplane only.
---* AIRBASE.TerminalType.OpenBig = 104: Open air spawn points. Generally larger but does not guarantee large aircraft are capable of spawning there.
---* AIRBASE.TerminalType.OpenMedOrBig = 176: Combines OpenMed and OpenBig spots.
---* AIRBASE.TerminalType.HelicopterUsable = 216: Combines HelicopterOnly, OpenMed and OpenBig.
---* AIRBASE.TerminalType.FighterAircraft = 244: Combines Shelter. OpenMed and OpenBig spots. So effectively all spots usable by fixed wing aircraft.
---@class AIRBASE.TerminalType 
---@field FighterAircraft number 244: Combines Shelter, OpenMed and OpenBig spots. So effectively all spots usable by fixed wing aircraft.
---@field FighterAircraftSmall number 344: Combines Shelter, SmallsizeFighter, OpenMed and OpenBig spots. So effectively all spots usable by small fixed wing aircraft.
---@field HelicopterOnly number 40: Special spots for Helicopers.
---@field HelicopterUsable number 216: Combines HelicopterOnly, OpenMed and OpenBig.
---@field OpenBig number 104: Open air spawn points. Generally larger but does not guarantee large aircraft are capable of spawning there.
---@field OpenMed number 72: Open/Shelter air airplane only.
---@field OpenMedOrBig number 176: Combines OpenMed and OpenBig spots.
---@field Runway number 16: Valid spawn points on runway.
---@field Shelter number 68: Hardened Air Shelter. Currently only on Caucaus map.
---@field SmallSizeFigher number 100: Tight spots for smaller type fixed wing aircraft, like the F-16. Example of these spots: 04, 05, 06 on Muwaffaq_Salti. A Viper sized plane can spawn here, but an A-10 or Strike Eagle can't
---@field SmallSizeFighter number 
AIRBASE.TerminalType = {}



