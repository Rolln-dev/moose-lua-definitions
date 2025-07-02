---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Utilities** - Derived utilities taken from the MIST framework, added helpers from the MOOSE community.
---
---### Authors:
---
---  * Grimes : Design & Programming of the MIST framework.
---
---### Contributions:
---
---  * FlightControl : Rework to OO framework.
---  * And many more
---Big smoke preset enum.
---@class BIGSMOKEPRESET 
---@field HugeSmoke number Huge smoke (8)
---@field HugeSmokeAndFire number Huge smoke and fire (4)
---@field LargeSmoke number Large smoke (7)
---@field LargeSmokeAndFire number Large smoke and fire (3)
---@field MediumSmoke number Medium smoke (6)
---@field MediumSmokeAndFire number Medium smoke and fire (2)
---@field SmallSmoke number Small smoke (5)
---@field SmallSmokeAndFire number Small moke and fire (1)
BIGSMOKEPRESET = {}


---See [DCS_enum_callsigns](https://wiki.hoggitworld.com/view/DCS_enum_callsigns)
---@class CALLSIGN 
---@field AH64 table 
---@field AWACS table 
---@field Aircraft table 
---@field B1B table 
---@field B52 table 
---@field F15E table 
---@field F16 table 
---@field F18 table 
---@field FARP table 
---@field JTAC table 
---@field Kiowa table 
---@field Tanker table 
---@field TransportAircraft table 
CALLSIGN = {}


---DCS map as returned by `env.mission.theatre`.
---@class DCSMAP 
---@field Afghanistan string Afghanistan map
---@field Caucasus string Caucasus map.
---@field Falklands string South Atlantic map.
---@field GermanyCW string Germany Cold War map
---@field Iraq string Iraq map
---@field Kola string Kola map.
---@field MarianaIslands string Mariana Islands map.
---@field NTTR string Nevada Test and Training Range map.
---@field Normandy string Normandy map.
---@field PersianGulf string Persian Gulf map.
---@field Sinai string Sinai map.
---@field Syria string Syria map.
---@field TheChannel string The Channel map.
DCSMAP = {}


---Flare colur enum `trigger.flareColor`.
---@class FLARECOLOR 
---@field Green number (0)
---@field Red number Red flare (1)
---@field White number White flare (2)
---@field Yellow number Yellow flare (3)
FLARECOLOR = {}


---Smoke color enum `trigger.smokeColor`.
---@class SMOKECOLOR 
---@field Blue number Blue smoke (4)
---@field Green number Green smoke (0)
---@field Orange number Orange smoke (3)
---@field Red number Red smoke (1)
---@field White number White smoke (2)
SMOKECOLOR = {}


---Utilities static class.
---@class UTILS 
---@field Weather UTILS.Weather 
---@field _MarkID number Marker index counter. Running number when marker is added.
---@field private lcg table 
UTILS = {}

---Checks if a given angle (heading) is between 2 other angles.
---Min and max have to be given in clockwise order For example:
---- UTILS.AngleBetween(350, 270, 15) would return True
---- UTILS.AngleBetween(22, 95, 20) would return False
---
------
---@param min number Max value to remap from
---@param max number Max value to remap from
---@return boolean #
function UTILS.AngleBetween(angle, min, max) end

---Basic serialize (porting in Slmod's "safestring" basic serialize).
---
------
function UTILS.BasicSerialize(s) end

---Heading Degrees (0-360) to Cardinal
---
------
---@return string #Cardinal, e.g. "NORTH"
function UTILS.BearingToCardinal(Heading) end

---Beaufort scale: returns Beaufort number and wind description as a function of wind speed in m/s.
---
------
---@return number #Beaufort number.
---@return string #Beauford wind description.
function UTILS.BeaufortScale(speed) end

---Convert temperature from Celsius to Fahrenheit.
---
------
---@return number #Temperature in degrees Fahrenheit.
function UTILS.CelsiusToFahrenheit(Celcius) end

---Function to check if a file exists.
---
------
---@param Filename string The name of the file.
---@return boolean #outcome True if reading is possible, else false.
function UTILS.CheckFileExists(Path, Filename) end

---Checks the current memory usage collectgarbage("count").
---Info is printed to the DCS log file. Time stamp is the current mission runtime.
---
------
---@return number #Memory usage in kByte.
function UTILS.CheckMemory(output) end

---Easy to read one liner to clamp a value
---
------
---@param min number Minimal value that should be respected
---@param max number Maximal value that should be respected
---@return number #Clamped value
function UTILS.Clamp(value, min, max) end

---Clamp an angle so that it's always between 0 and 360 while still being correct
---
------
---@return number #Clamped value
function UTILS.ClampAngle(value) end

---Get the clock position from a relative heading
---
------
---
---USAGE
---```
---Display the range and clock distance of a BTR in relation to REAPER 1-1's heading:
---
---         myUnit = UNIT:FindByName( "REAPER 1-1" )
---         myTarget = GROUP:FindByName( "BTR-1" )
---
---         coordUnit = myUnit:GetCoordinate()
---         coordTarget = myTarget:GetCoordinate()
---
---         hdgUnit = myUnit:GetHeading()
---         hdgTarget = coordUnit:HeadingTo( coordTarget )
---         distTarget = coordUnit:Get3DDistance( coordTarget )
---
---         clockString = UTILS.ClockHeadingString( hdgUnit, hdgTarget )
---
---         -- Will show this message to REAPER 1-1 in-game: Contact BTR at 3 o'clock for 1134m!
---         MESSAGE:New("Contact BTR at " .. clockString .. " for " .. distTarget  .. "m!):ToUnit( myUnit )
---```
------
---@param tgtHdg number The absolute heading from the reference object to the target object/point in 0-360
---@return string #text Text in clock heading such as "4 O'CLOCK"
function UTILS.ClockHeadingString(refHdg, tgtHdg) end

---Convert clock time from hours, minutes and seconds to seconds.
---
------
---@return number #Seconds. Corresponds to what you cet from timer.getAbsTime() function.
function UTILS.ClockToSeconds(clock) end

---Combines two time strings to give you a new time.
---For example "15:16:32" and "02:06:24" would return "17:22:56"
---
------
---@param time_string_02 string Time string like "08:11:27"
---@return string #Result of the two time string combined
function UTILS.CombineTimeStrings(time_string_01, time_string_02) end

---Convert a decimal to octal
---
------
---@return number #Octal
function UTILS.DecimalToOctal(Number) end

---Deep copy a table.
---See http://lua-users.org/wiki/CopyTable
---
------
---@return table #Copy of the input table.
function UTILS.DeepCopy(object) end

---Display clock and mission time on screen as a message to all.
---
------
function UTILS.DisplayMissionTime(duration) end

---Executes the given string.
---borrowed from Slmod
---
------
---@return boolean #`true` if successfully executed, `false` otherwise.
function UTILS.DoString(s) end

---Ensure the passed object is a table.
---
------
---@param ReturnNil boolean If `true`, return `#nil` if `Object` is nil. Otherwise an empty table `{}` is returned.
---@return table #The object that now certainly *is* a table.
function UTILS.EnsureTable(Object, ReturnNil) end


---
------
function UTILS.FeetToMeters(feet) end

---Checks if a file exists or not.
---This requires **io** to be desanitized.
---
------
---@return boolean #True if the file exists, false if the file does not exist or nil if the io module is not available and the check could not be performed.
function UTILS.FileExists(file) end

---Get the time difference between GMT and local time.
---
------
---@return number #Local time difference in hours compared to GMT. E.g. Dubai is GMT+4 ==> +4 is returned.
function UTILS.GMTToLocalTimeDifference() end

---Dumps the global table _G.
---This dumps the global table _G to a file in the DCS\Logs directory.
---This function requires you to disable script sanitization in $DCS_ROOT\Scripts\MissionScripting.lua to access lfs and io libraries.
---
------
function UTILS.Gdump(fname) end

---Function to generate valid FM frequencies in mHz for radio beacons (FM).
---
------
---@return table #Table of frequencies.
function UTILS.GenerateFMFrequencies() end

---Function to generate valid laser codes for JTAC.
---
------
---@return table #Laser Codes.
function UTILS.GenerateLaserCodes() end

---Function to generate valid UHF Frequencies in mHz (AM).
---Can be between 220 and 399 mHz. 243 is auto-excluded.
---
------
---@param End? NOTYPE (Optional) Avoid frequencies between Start and End in mHz, e.g. 320
---@return table #UHF Frequencies
function UTILS.GenerateUHFrequencies(Start, End) end

---Function to generate valid VHF frequencies in kHz for radio beacons (FM).
---
------
---@return table #VHFrequencies
function UTILS.GenerateVHFrequencies() end

---Get the callsign name from its enumerator value
---
------
---@return string #The callsign name or "Ghostrider".
function UTILS.GetCallsignName(Callsign) end

---Get a table of all characters in a string.
---
------
---@return table #Individual characters.
function UTILS.GetCharacters(str) end

---Get the enemy coalition for a given coalition.
---
------
---@param Neutral boolean Include neutral as enemy.
---@return table #Enemy coalition table.
function UTILS.GetCoalitionEnemy(Coalition, Neutral) end

---Get the coalition name from its numerical ID, e.g.
---coalition.side.RED.
---
------
---@return string #The coalition name, i.e. "Neutral", "Red" or "Blue" (or "Unknown").
function UTILS.GetCoalitionName(Coalition) end

---Function to obtain a table of typenames from the group given with the number of units of the same type in the group.
---
------
---@return table #Table of typnames and typename counts, e.g. `{["KAMAZ Truck"]=3,["ATZ-5"]=1}`
function UTILS.GetCountPerTypeName(Group) end

---Returns the DCS map/theatre as optained by `env.mission.theatre`.
---
------
---@return string #DCS map name.
function UTILS.GetDCSMap() end

---Returns the mission date.
---This is the date the mission **started**.
---
------
---@return string #Mission date in yyyy/mm/dd format.
---@return number #The year anno domini.
---@return number #The month.
---@return number #The day.
function UTILS.GetDCSMissionDate() end

---Convert time in seconds to a DHMS table `{d = days, h = hours, m = minutes, s = seconds}`
---
------
---@return table #Table with DHMS data
function UTILS.GetDHMS(timeInSec) end

---Get the day of the year.
---Counting starts on 1st of January.
---
------
---@param Month number The month.
---@param Day number The day.
---@return number #The day of the year.
function UTILS.GetDayOfYear(Year, Month, Day) end

---Returns heading-error corrected direction in radians.
---True-north corrected direction from point along vector vec.
---
------
---@param point NOTYPE Vec2 Direction
---@return NOTYPE #direction corrected direction from point.
function UTILS.GetDirectionRadians(vec, point) end

---Returns the magnetic declination of the map.
---Returned values for the current maps are:
---
---* Caucasus +6 (East), year ~ 2011
---* NTTR +12 (East), year ~ 2011
---* Normandy -10 (West), year ~ 1944
---* Persian Gulf +2 (East), year ~ 2011
---* The Cannel Map -10 (West)
---* Syria +5 (East)
---* Mariana Islands +2 (East)
---* Falklands +12 (East) - note there's a LOT of deviation across the map, as we're closer to the South Pole
---* Sinai +4.8 (East)
---* Kola +15 (East) - note there is a lot of deviation across the map (-1° to +24°), as we are close to the North pole
---* Afghanistan +3 (East) - actually +3.6 (NW) to +2.3 (SE)
---* Iraq +4.4 (East)
---* Germany Cold War +0.1 (East) - near Fulda
---
------
---@return number #Declination in degrees.
function UTILS.GetMagneticDeclination(map) end


---
------
function UTILS.GetMarkID() end

---Returns the day of the mission.
---
------
---@return number #Day of the mission. Mission starts on day 0.
function UTILS.GetMissionDay(Time) end

---Returns the current day of the year of the mission.
---
------
---@return number #Current day of year of the mission. For example, January 1st returns 0, January 2nd returns 1 etc.
function UTILS.GetMissionDayOfYear(Time) end

---Get the modulation name from its numerical value.
---
------
---@return string #The modulation name, i.e. "AM"=0 or "FM"=1. Anything else will return "Unknown".
function UTILS.GetModulationName(Modulation) end

---Get the correction needed for true north in radians
---
------
---@return NOTYPE #number correction
function UTILS.GetNorthCorrection(gPoint) end

---Get OS time.
---Needs os to be desanitized!
---
------
---@return number #Os time in seconds.
function UTILS.GetOSTime() end

--- Get a random element of a table.
---
------
---@param replace boolean If `true`, the drawn element is replaced, i.e. not deleted.
---@return number #Table element.
function UTILS.GetRandomTableElement(t, replace) end

---Get the NATO reporting name of a unit type name
---
------
---@return string #The Reporting name or "Bogey".
function UTILS.GetReportingName(Typename) end

---Get sunrise or sun set of a specific day of the year at a specific location.
---
------
---@param Latitude number Latitude.
---@param Longitude number Longitude.
---@param Rising boolean If true, calc sun rise, or sun set otherwise.
---@param Tlocal number Local time offset in hours. E.g. +4 for a location which has GMT+4.
---@return number #Sun rise/set in seconds of the day.
function UTILS.GetSunRiseAndSet(DayOfYear, Latitude, Longitude, Rising, Tlocal) end

---Get sun rise of a specific day of the year at a specific location.
---
------
---@param Month number Month of the year.
---@param Year number Year.
---@param Latitude number Latitude.
---@param Longitude number Longitude.
---@param Rising boolean If true, calc sun rise, or sun set otherwise.
---@param Tlocal number Local time offset in hours. E.g. +4 for a location which has GMT+4. Default 0.
---@return number #Sun rise in seconds of the day.
function UTILS.GetSunrise(Day, Month, Year, Latitude, Longitude, Rising, Tlocal) end

---Get sun set of a specific day of the year at a specific location.
---
------
---@param Month number Month of the year.
---@param Year number Year.
---@param Latitude number Latitude.
---@param Longitude number Longitude.
---@param Rising boolean If true, calc sun rise, or sun set otherwise.
---@param Tlocal number Local time offset in hours. E.g. +4 for a location which has GMT+4. Default 0.
---@return number #Sun rise in seconds of the day.
function UTILS.GetSunset(Day, Month, Year, Latitude, Longitude, Rising, Tlocal) end

---Get the properties names and values of properties set up on a Zone in the Mission Editor.
---- This doesn't work for any zones created in MOOSE
---
------
---@return table #with all the properties on a zone
function UTILS.GetZoneProperties(zone_name) end

---Calculate the difference between two "heading", i.e.
---angles in [0,360) deg.
---
------
---@param h2 number Heading two.
---@return number #Heading difference in degrees.
function UTILS.HdgDiff(h1, h2) end

---Returns the heading from one vec3 to another vec3.
---
------
---@param b Vec3 To vec3.
---@return number #Heading in degrees.
function UTILS.HdgTo(a, b) end

---HexToRGBA
---
------
---@return table #R, G, B, A
function UTILS.HexToRGBA(hex_string) end

---Convert indicated airspeed (IAS) to true airspeed (TAS) for a given altitude above main sea level.
---The conversion is based on the approximation that TAS is ~2% higher than IAS with every 1000 ft altitude above sea level.
---
------
---@param altitude number Altitude above main sea level in meters.
---@param oatcorr? number (Optional) Outside air temperature correction factor. Default 0.017.
---@return number #True airspeed in the same unit the IAS has been given.
function UTILS.IasToTas(ias, altitude, oatcorr) end

---Check if any object of multiple given objects is contained in a table.
---
------
---@param Objects table The objects to check.
---@param Key? string (Optional) Key to check.
---@return boolean #Returns `true` if object is in table.
function UTILS.IsAnyInTable(Table, Objects, Key) end


---
------
---@param Vec2 NOTYPE 
---@param Radius NOTYPE 
function UTILS.IsInRadius(InVec2, Vec2, Radius) end


---
------
---@param Vec3 NOTYPE 
---@param Radius NOTYPE 
function UTILS.IsInSphere(InVec3, Vec3, Radius) end

---Check if an object is contained in a table.
---
------
---@param Object table The object to check.
---@param Key? string (Optional) Key to check. By default, the object itself is checked.
---@return boolean #Returns `true` if object is in table.
function UTILS.IsInTable(Table, Object, Key) end

---Function to infer instance of an object
---
---### Examples:
---
---   * UTILS.IsInstanceOf( 'some text', 'string' ) will return true
---   * UTILS.IsInstanceOf( some_function, 'function' ) will return true
---   * UTILS.IsInstanceOf( 10, 'number' ) will return true
---   * UTILS.IsInstanceOf( false, 'boolean' ) will return true
---   * UTILS.IsInstanceOf( nil, 'nil' ) will return true
---
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', ZONE ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'ZONE' ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'zone' ) will return true
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'BASE' ) will return true
---
---   * UTILS.IsInstanceOf( ZONE:New( 'some zone', 'GROUP' ) will return false
---
------
---@param className NOTYPE is the name of the class to evaluate (can be either a string or a Moose class)
---@return boolean #
function UTILS.IsInstanceOf(object, className) end

--- (Helicopter) Check if one loading door is open.
---
------
---@return boolean #Outcome - true if a (loading door) is open, false if not, nil if none exists.
function UTILS.IsLoadingDoorOpen(unit_name) end

---Raycasting a point in polygon.
---Code from http://softsurfer.com/Archive/algorithm_0103/algorithm_0103.htm
---
------
---@param poly table Polygon Table of Vec2/3 point forming the Polygon
---@param maxalt? number Altitude limit (optional)
---@param outcome boolean 
function UTILS.IsPointInPolygon(point, poly, maxalt, outcome) end


---
------
function UTILS.KiloMetersToFeet(kilometers) end


---
------
function UTILS.KiloMetersToNM(kilometers) end


---
------
function UTILS.KiloMetersToSM(kilometers) end


---
------
function UTILS.KmphToKnots(knots) end


---
------
function UTILS.KmphToMps(kmph) end

---Convert knots to altitude corrected KIAS, e.g.
---for tankers.
---
------
---@param altitude number Altitude in feet
---@return number #Corrected KIAS
function UTILS.KnotsToAltKIAS(knots, altitude) end


---
------
function UTILS.KnotsToKmph(knots) end

---Convert knots to meters per second.
---
------
---@return number #Speed in m/s.
function UTILS.KnotsToMps(knots) end

---Return a pseudo-random number using the LCG algorithm.
---
------
---@return number #Random number between 0 and 1.
function UTILS.LCGRandom() end

---Seed the LCG random number generator.
---
------
function UTILS.LCGRandomSeed(seed) end

---Function to load an object from a file.
---
------
---@param Filename string The name of the file.
---@return boolean #outcome True if reading is possible and successful, else false.
---@return table #data The data read from the filesystem (table of lines of text). Each line is one single #string!
function UTILS.LoadFromFile(Path, Filename) end

---Load back a SET of groups from file.
---
------
---@param Filename string The name of the file.
---@param Spawn boolean If set to false, do not re-spawn the groups loaded in location and reduce to size.
---@param Structured boolean (Optional, needs Spawn=true)If true, and the data has been saved as structure before, remove the correct unit types as per the saved list.
---@param Cinematic boolean (Optional, needs Structured=true) If true, place a fire/smoke effect on the dead static position.
---@param Effect number (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density number (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@return SET_GROUP #Set of GROUP objects. Returns nil when file cannot be read. Returns a table of data entries if Spawn is false: `{ groupname=groupname, size=size, coordinate=coordinate, template=template }`
---@return table #When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )`
function UTILS.LoadSetOfGroups(Path, Filename, Spawn, Structured, Cinematic, Effect, Density) end

---Load back a #OPSGROUP (ARMYGROUP) data from file for use with Ops.Brigade#BRIGADE.LoadBackAssetInPosition()
---
------
---@param Filename string The name of the file.
---@return table #Returns a table of data entries: `{ groupname=groupname, size=size, coordinate=coordinate, template=template, structure=structure, legion=legion, alttemplate=alttemplate }` Returns nil when the file cannot be read.
function UTILS.LoadSetOfOpsGroups(Path, Filename) end

---Load back a SET of statics from file.
---
------
---@param Filename string The name of the file.
---@return SET_STATIC #Set SET_STATIC containing the static objects.
function UTILS.LoadSetOfStatics(Path, Filename) end

---Load back a stationary list of groups from file.
---
------
---@param Filename string The name of the file.
---@param Reduce boolean If false, existing loaded groups will not be reduced to fit the saved number.
---@param Structured boolean (Optional, needs Reduce = true) If true, and the data has been saved as structure before, remove the correct unit types as per the saved list.
---@param Cinematic boolean (Optional, needs Structured = true) If true, place a fire/smoke effect on the dead static position.
---@param Effect number (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density number (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@return table #Table of data objects (tables) containing groupname, coordinate and group object. Returns nil when file cannot be read.
---@return table #When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )`
function UTILS.LoadStationaryListOfGroups(Path, Filename, Reduce, Structured, Cinematic, Effect, Density) end

---Load back a stationary list of statics from file.
---
------
---@param Filename string The name of the file.
---@param Reduce boolean If false, do not destroy the units with size=0.
---@param Dead boolean (Optional, needs Reduce = true) If Dead is true, re-spawn the dead object as dead and do not just delete it.
---@param Cinematic boolean (Optional, needs Dead = true) If true, place a fire/smoke effect on the dead static position.
---@param Effect number (Optional for Cinematic) What effect to use. Defaults to a random effect. Smoke presets are: 1=small smoke and fire, 2=medium smoke and fire, 3=large smoke and fire, 4=huge smoke and fire, 5=small smoke, 6=medium smoke, 7=large smoke, 8=huge smoke.
---@param Density number (Optional for Cinematic) What smoke density to use, can be 0 to 1. Defaults to 0.5.
---@return table #Table of data objects (tables) containing staticname, size (0=dead else 1), coordinate and the static object. Dead objects will have coordinate points `{x=0,y=0,z=0}`
---@return table #When using Cinematic: table of names of smoke and fire objects, so they can be extinguished with `COORDINATE.StopBigSmokeAndFire( name )` Returns nil when file cannot be read.
function UTILS.LoadStationaryListOfStatics(Path, Filename, Reduce, Dead, Cinematic, Effect, Density) end

---Get a NATO abbreviated MGRS text for SRS use, optionally with prosody slow tag
---
------
---@param Slow boolean Optional - add slow tags
---@return string #Output for (Slow) spelling in SRS TTS e.g. "MGRS;<prosody rate="slow">4;Quebec;Foxtrot;Juliett;1;2;3;4;5;6;7;8;niner;zero;</prosody>"
function UTILS.MGRSStringToSRSFriendly(Text, Slow) end


---
------
function UTILS.MetersToFeet(meters) end


---
------
function UTILS.MetersToNM(meters) end


---
------
function UTILS.MetersToSM(meters) end


---
------
function UTILS.MiphToMps(miph) end


---
------
function UTILS.MpsToKmph(mps) end

---Convert meters per second to knots.
---
------
---@return number #Speed in knots.
function UTILS.MpsToKnots(mps) end

---Convert meters per second to miles per hour.
---
------
---@return number #Speed in miles per hour.
function UTILS.MpsToMiph(mps) end


---
------
function UTILS.NMToKiloMeters(NM) end


---
------
function UTILS.NMToMeters(NM) end

---Convert an octal to decimal
---
------
---@return number #Decimal
function UTILS.OctalToDecimal(Number) end

---Serialize a given table.
---
------
---@return string #Table as a string.
function UTILS.OneLineSerialize(tbl) end

---Easy to read one line to roll the dice on something.
---1% is very unlikely to happen, 99% is very likely to happen
---
------
---@return boolean #True if the dice roll was within the given percentage chance of happening
function UTILS.PercentageChance(chance) end

---Helper function to plot a racetrack on the F10 Map - curtesy of Buur.
---
------
---@param Altitude number Altitude in feet
---@param Speed number Speed in knots
---@param Heading number Heading in degrees
---@param Leg number Leg in NM
---@param Coalition number Coalition side, e.g. coaltion.side.RED or coaltion.side.BLUE
---@param Color table Color of the line in RGB, e.g. {1,0,0} for red
---@param Alpha number Transparency factor, between 0.1 and 1
---@param LineType number Line type to be used, line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly boolean 
function UTILS.PlotRacetrack(Coordinate, Altitude, Speed, Heading, Leg, Coalition, Color, Alpha, LineType, ReadOnly) end

---Print a table to log in a nice format
---
------
---@param indent number Number of indents
---@param noprint boolean Don't log but return text
---@return string #text Text created on the fly of the log output
function UTILS.PrintTableToLog(table, indent, noprint) end

---Generate a Gaussian pseudo-random number.
---
------
---@param sigma? number (Optional) Standard deviation. Default 10.
---@param xmin? number (Optional) Lower cut-off value.
---@param xmax? number (Optional) Upper cut-off value.
---@param imax? number (Optional) Max number of tries to get a value between xmin and xmax (if specified). Default 100.
---@return number #Gaussian random number.
function UTILS.RandomGaussian(x0, sigma, xmin, xmax, imax) end

---Given a triangle made out of 3 vector 2s, return a vec2 that is a random number in this triangle
---
------
---@param pt2 Vec2 Max value to remap from
---@param pt3 Vec2 Max value to remap from
---@return Vec2 #Random point in triangle
function UTILS.RandomPointInTriangle(pt1, pt2, pt3) end

---Randomize a value by a certain amount.
---
------
---
---USAGE
---```
---UTILS.Randomize(100, 0.1) returns a value between 90 and 110, i.e. a plus/minus ten percent variation.
---```
------
---@param fac number Randomization factor.
---@param lower? number (Optional) Lower limit of the returned value.
---@param upper? number (Optional) Upper limit of the returned value.
---@return number #Randomized value.
function UTILS.Randomize(value, fac, lower, upper) end

---Read csv file and convert it to a lua table.
---The csv must have a header specifing the names of the columns. The column names are used as table keys.
---
------
---@return table #The table filled with data from the csv file.
function UTILS.ReadCSV(filename) end

---Easy to read one liner to read a JSON file.
---- json.lua exists in the DCS install Scripts folder
---
------
---@return table #
function UTILS.ReadJSON(file_path) end

---Remap an input to a new value in a given range.
---For example:
---- UTILS.RemapValue(20, 10, 30, 0, 200) would return 100
---- 20 is 50% between 10 and 30
---- 50% between 0 and 200 is 100
---
------
---@param old_min number Min value to remap from
---@param old_max number Max value to remap from
---@param new_min number Min value to remap to
---@param new_max number Max value to remap to
---@return number #Remapped value
function UTILS.RemapValue(value, old_min, old_max, new_min, new_max) end

---Remove an object (marker, circle, arrow, text, quad, ...) on the F10 map.
---
------
---@param Delay? number (Optional) Delay in seconds before the mark is removed.
function UTILS.RemoveMark(MarkID, Delay) end

---Replace illegal characters [<>|/?*:\\] in a string.
---
------
---@param ReplaceBy string Replace illegal characters by this character or string. Default underscore "_".
---@return string #The input text with illegal chars replaced.
function UTILS.ReplaceIllegalCharacters(Text, ReplaceBy) end

---Rotate 3D vector in the 2D (x,z) plane.
---y-component (usually altitude) unchanged.
---
------
---@param angle number Rotation angle in degrees.
---@return Vec3 #Vector rotated in the (x,z) plane.
function UTILS.Rotate2D(a, angle) end

---Rotates a point around another point with a given angle.
---Useful if you're loading in groups or
---- statics but you want to rotate them all as a collection. You can get the center point of everything
---- and then rotate all the positions of every object around this center point.
---
------
---@param pivot Vec2 Pivot point of the rotation
---@param angle number How many degrees the point should be rotated
---@return Vec2 #Rotated point
function UTILS.RotatePointAroundPivot(point, pivot, angle) end


---
------
---@param idp NOTYPE 
function UTILS.Round(num, idp) end

---Function to save the state of a set of Wrapper.Group#GROUP objects.
---
------
---
---USAGE
---```
---We will go through the set and find the corresponding group and save the current group size and current position.
---The idea is to respawn the groups **spawned during an earlier run of the mission** at the given location and reduce
---the number of units in the group when reloading the data again to restart the saved mission. Note that *dead* groups
---cannot be covered with this.
---**Note** Do NOT use dashes or hashes in group template names (-,#)!
---The data will be a simple comma separated list of groupname and size, with one header line.
---The current task/waypoint/etc cannot be restored.
---```
------
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@param Structured boolean Append the data with a list of typenames in the group plus their count.
---@return boolean #outcome True if saving is successful, else false.
function UTILS.SaveSetOfGroups(Set, Path, Filename, Structured) end

---Function to save the position of a set of #OPSGROUP (ARMYGROUP) objects.
---
------
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@param Structured boolean Append the data with a list of typenames in the group plus their count.
---@return boolean #outcome True if saving is successful, else false.
function UTILS.SaveSetOfOpsGroups(Set, Path, Filename, Structured) end

---Function to save the state of a set of Wrapper.Static#STATIC objects.
---
------
---
---USAGE
---```
---We will go through the set and find the corresponding static and save the current name and postion when alive.
---The data will be a simple comma separated list of name and state etc, with one header line.
---```
------
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@return boolean #outcome True if saving is successful, else false.
function UTILS.SaveSetOfStatics(Set, Path, Filename) end

---Function to save the state of a list of groups found by name
---
------
---
---USAGE
---```
---We will go through the list and find the corresponding group and save the current group size (0 when dead).
---These groups are supposed to be put on the map in the ME and have *not* moved (e.g. stationary SAM sites).
---Position is still saved for your usage.
---The idea is to reduce the number of units when reloading the data again to restart the saved mission.
---The data will be a simple comma separated list of groupname and size, with one header line.
---```
------
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@param Structured boolean Append the data with a list of typenames in the group plus their count.
---@return boolean #outcome True if saving is successful, else false.
function UTILS.SaveStationaryListOfGroups(List, Path, Filename, Structured) end

---Function to save the state of a list of statics found by name
---
------
---
---USAGE
---```
---We will go through the list and find the corresponding static and save the current alive state as 1 (0 when dead).
---Position is saved for your usage. **Note** this works on UNIT-name level.
---The idea is to reduce the number of units when reloading the data again to restart the saved mission.
---The data will be a simple comma separated list of name and state etc, with one header line.
---```
------
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@return boolean #outcome True if saving is successful, else false.
function UTILS.SaveStationaryListOfStatics(List, Path, Filename) end

---Function to save an object to a file
---
------
---@param Filename string The name of the file. Existing file will be overwritten.
---@param Data string The data structure to save. This will be e.g. a string of text lines with an \\n at the end of each line.
---@return boolean #outcome True if saving is possible, else false.
function UTILS.SaveToFile(Path, Filename, Data) end

---Vector scalar multiplication.
---
------
---@param mult number scalar multiplicator
---@return NOTYPE #Vec3 new vector multiplied with the given scalar
function UTILS.ScalarMult(vec, mult) end

---Seconds of today.
---
------
---@return number #Seconds passed since last midnight.
function UTILS.SecondsOfToday() end

---Convert time in seconds to hours, minutes and seconds.
---
------
---@param short? boolean (Optional) If true, use short output, i.e. (HH:)MM:SS without day.
---@return string #Time in format Hours:Minutes:Seconds+Days (HH:MM:SS+D).
function UTILS.SecondsToClock(seconds, short) end

---Cound seconds until next midnight.
---
------
---@return number #Seconds to midnight.
function UTILS.SecondsToMidnight() end

--- Shuffle a table accoring to Fisher Yeates algorithm
---
------
---@return table #Shuffled table.
function UTILS.ShuffleTable(t) end

---Spawns a new FARP of a defined type and coalition and functional statics (fuel depot, ammo storage, tent, windsock) around that FARP to make it operational.
---Adds vehicles from template if given. Fills the FARP warehouse with liquids and known materiels.
---References: [DCS Forum Topic](https://forum.dcs.world/topic/282989-farp-equipment-to-run-it)
---
------
---@param Coordinate COORDINATE Where to spawn the FARP.
---@param FARPType string Type of FARP, can be one of the known types ENUMS.FARPType.FARP, ENUMS.FARPType.INVISIBLE, ENUMS.FARPType.HELIPADSINGLE, ENUMS.FARPType.PADSINGLE. Defaults to ENUMS.FARPType.FARP.
---@param Coalition number Coalition of this FARP, i.e. coalition.side.BLUE or coalition.side.RED, defaults to coalition.side.BLUE.
---@param Country number Country of this FARP, defaults to country.id.USA (blue) or country.id.RUSSIA (red).
---@param CallSign number Callsign of the FARP ATC, defaults to CALLSIGN.FARP.Berlin.
---@param Frequency number Frequency of the FARP ATC Radio, defaults to 127.5 (MHz).
---@param Modulation number Modulation of the FARP ATC Radio, defaults to radio.modulation.AM.
---@param ADF number ADF Beacon (FM) Frequency in KHz, e.g. 428. If not nil, creates an VHF/FM ADF Beacon for this FARP. Requires a sound called "beacon.ogg" to be in the mission (trigger "sound to" ...)
---@param SpawnRadius number Radius of the FARP, i.e. where the FARP objects will be placed in meters, not more than 150m away. Defaults to 100.
---@param VehicleTemplate string  template name for additional vehicles. Can be nil for no additional vehicles.
---@param Liquids number Tons of fuel to be added initially to the FARP. Defaults to 10 (tons). Set to 0 for no fill.
---@param Equipment number Number of equipment items per known item to be added initially to the FARP. Defaults to 10 (items). Set to 0 for no fill.
---@return list #Table of spawned objects and vehicle object (if given).
---@return string #ADFBeaconName Name of the ADF beacon, to be able to remove/stop it later.
function UTILS.SpawnFARPAndFunctionalStatics(Name, Coordinate, FARPType, Coalition, Country, CallSign, Frequency, Modulation, ADF, SpawnRadius, VehicleTemplate, Liquids, Equipment) end

---Split string at separators.
---C.f. [split-string-in-lua](http://stackoverflow.com/questions/1426954/split-string-in-lua).
---
------
---@param sep string Separator for split.
---@return table #Split text.
function UTILS.Split(str, sep) end

---Subtracts two time string to give you a new time.
---For example "15:16:32" and "02:06:24" would return "13:10:08"
---
------
---@param time_string_02 string Time string like "08:11:27"
---@return string #Result of the two time string subtracted
function UTILS.SubtractTimeStrings(time_string_01, time_string_02) end

---Converts a TACAN Channel/Mode couple into a frequency in Hz.
---
------
---@param TACANMode string The TACAN mode, i.e. the "X" in "10X".
---@return number #Frequency in Hz or #nil if parameters are invalid.
function UTILS.TACANToFrequency(TACANChannel, TACANMode) end

---Counts the number of elements in a table.
---
------
---@return number #Number of elements in the table
function UTILS.TableLength(T) end

---Returns table in a easy readable string representation.
---
------
---@param loc NOTYPE 
---@param indent NOTYPE 
---@param tableshow_tbls NOTYPE 
---@return NOTYPE #Human readable string representation of given table.
function UTILS.TableShow(tbl, loc, indent, tableshow_tbls) end

---Convert true airspeed (TAS) to indicated airspeed (IAS) for a given altitude above main sea level.
---The conversion is based on the approximation that TAS is ~2% higher than IAS with every 1000 ft altitude above sea level.
---
------
---@param altitude number Altitude above main sea level in meters.
---@param oatcorr? number (Optional) Outside air temperature correction factor. Default 0.017.
---@return number #Indicated airspeed in the same unit the TAS has been given.
function UTILS.TasToIas(tas, altitude, oatcorr) end

---Check if the current time is before time_string.
---
------
---@param time_string NOTYPE 
---@return boolean #False if later, True if before
function UTILS.TimeBefore(start_time, time_string) end

---Checks if the current time is in between start_time and end_time
---
------
---@param time_string_02 string Time string like "08:11:27"
---@param start_time NOTYPE 
---@param end_time NOTYPE 
---@return boolean #True if it is, False if it's not
function UTILS.TimeBetween(time_string_01, time_string_02, start_time, end_time) end

---Given 2 "nice" time string, returns the difference between the two in seconds
---
------
---@param end_time string Time string like "08:11:27"
---@return number #Seconds between start_time and end_time
function UTILS.TimeDifferenceInSeconds(start_time, end_time) end

---Check if the current time is later than time_string.
---
------
---@param time_string NOTYPE 
---@return boolean #True if later, False if before
function UTILS.TimeLaterThan(start_time, time_string) end

---Get the current time in a "nice" format like 21:01:15
---
------
---@return string #Returns string with the current time
function UTILS.TimeNow() end


---
------
function UTILS.ToDegree(angle) end


---
------
function UTILS.ToRadian(angle) end

---Create a BRAA NATO call string BRAA between two GROUP objects
---
------
---@param ToGrp GROUP GROUP object
---@return string #Formatted BRAA NATO call
function UTILS.ToStringBRAANATO(FromGrp, ToGrp) end

---Makes a string semi-unique by attaching a random number between 0 and 1 million to it
---
------
---@return string #Unique string
function UTILS.UniqueName(base) end

---Calculate the total vector of two 2D vectors by adding the x,y components of each other.
---
------
---@param b Vec2 Vector in 2D with x, y components.
---@return Vec2 #Vector c=a+b with c(i)=a(i)+b(i), i=x,y.
function UTILS.Vec2Add(a, b) end

---Calculate the [dot product](https://en.wikipedia.org/wiki/Dot_product) of two 2D vectors.
---The result is a number.
---
------
---@param b Vec2 Vector in 2D with x, y components.
---@return number #Scalar product of the two vectors a*b.
function UTILS.Vec2Dot(a, b) end

---Calculate "heading" of a 2D vector in the X-Y plane.
---
------
---@return number #Heading in degrees in [0,360).
function UTILS.Vec2Hdg(a) end

---Calculate the [euclidean norm](https://en.wikipedia.org/wiki/Euclidean_distance) (length) of a 2D vector.
---
------
---@return number #Norm of the vector.
function UTILS.Vec2Norm(a) end

---Rotate 2D vector in the 2D (x,z) plane.
---
------
---@param angle number Rotation angle in degrees.
---@return Vec2 #Vector rotated in the (x,y) plane.
function UTILS.Vec2Rotate2D(a, angle) end

---Calculate the difference between two 2D vectors by substracting the x,y components from each other.
---
------
---@param b Vec2 Vector in 2D with x, y components.
---@return Vec2 #Vector c=a-b with c(i)=a(i)-b(i), i=x,y.
function UTILS.Vec2Substract(a, b) end


---
------
---@param b NOTYPE 
function UTILS.Vec2Subtract(a, b) end

---Translate 2D vector in the 2D (x,z) plane.
---
------
---@param distance number The distance to translate.
---@param angle number Rotation angle in degrees.
---@return Vec2 #Translated vector.
function UTILS.Vec2Translate(a, distance, angle) end

---Converts a Vec2 to a Vec3.
---
------
---@param y NOTYPE optional new y axis (altitude) value. If omitted it's 0.
function UTILS.Vec2toVec3(vec, y) end

---Calculate the total vector of two 3D vectors by adding the x,y,z components of each other.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return Vec3 #Vector c=a+b with c(i)=a(i)+b(i), i=x,y,z.
function UTILS.VecAdd(a, b) end

---Calculate the angle between two 3D vectors.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return number #Angle alpha between and b in degrees. alpha=acos(a*b)/(|a||b|), (* denotes the dot product).
function UTILS.VecAngle(a, b) end

---Calculate the [cross product](https://en.wikipedia.org/wiki/Cross_product) of two 3D vectors.
---The result is a 3D vector.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return Vec3 #Vector
function UTILS.VecCross(a, b) end

---Calculate the distance between two 2D vectors.
---
------
---@param b Vec2 Vector in 2D with x, y components.
---@return number #Distance between the vectors.
function UTILS.VecDist2D(a, b) end

---Calculate the distance between two 3D vectors.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return number #Distance between the vectors.
function UTILS.VecDist3D(a, b) end

---Calculate the [dot product](https://en.wikipedia.org/wiki/Dot_product) of two vectors.
---The result is a number.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return number #Scalar product of the two vectors a*b.
function UTILS.VecDot(a, b) end

---Calculate "heading" of a 3D vector in the X-Z plane.
---
------
---@return number #Heading in degrees in [0,360).
function UTILS.VecHdg(a) end

---Calculate the [euclidean norm](https://en.wikipedia.org/wiki/Euclidean_distance) (length) of a 3D vector.
---
------
---@return number #Norm of the vector.
function UTILS.VecNorm(a) end

---Calculate the difference between two 3D vectors by substracting the x,y,z components from each other.
---
------
---@param b Vec3 Vector in 3D with x, y, z components.
---@return Vec3 #Vector c=a-b with c(i)=a(i)-b(i), i=x,y,z.
function UTILS.VecSubstract(a, b) end


---
------
---@param b NOTYPE 
function UTILS.VecSubtract(a, b) end

---Translate 3D vector in the 2D (x,z) plane.
---y-component (usually altitude) unchanged.
---
------
---@param distance number The distance to translate.
---@param angle number Rotation angle in degrees.
---@return Vec3 #Vector rotated in the (x,z) plane.
function UTILS.VecTranslate(a, distance, angle) end

---Easy to read one liner to write a JSON file.
---Everything in @data should be serializable
---- json.lua exists in the DCS install Scripts folder
---
------
---@param file_path string File path
function UTILS.WriteJSON(data, file_path) end

---Serialize a table to a single line string.
---
------
---@return string #string containing serialized table.
function UTILS._OneLineSerialize(tbl) end

---Convert pressure from hecto Pascal (hPa) to inches of mercury (inHg).
---
------
---@return number #Pressure in inHg.
---@private
function UTILS.hPa2inHg(hPa) end

---Convert pressure from hecto Pascal (hPa) to millimeters of mercury (mmHg).
---
------
---@return number #Pressure in mmHg.
---@private
function UTILS.hPa2mmHg(hPa) end

---Convert kilo gramms (kg) to pounds (lbs).
---
------
---@return number #Mass in lbs.
---@private
function UTILS.kg2lbs(kg) end

---Here is a customized version of pairs, which I called kpairs because it iterates over the table in a sorted order, based on a function that will determine the keys as reference first.
---
------
---
---USAGE
---```
---           for key,value in UTILS.kpairs(mytable, getkeyfunc) do
---               -- your code here
---           end
---```
------
---@param getkey string The function to determine the keys for sorting
---@param order? string (Optional) The sorting function itself
---@return string #key The index key
---@return string #value The value at the indexed key
---@private
function UTILS.kpairs(t, getkey, order) end

---Here is a customized version of pairs, which I called rpairs because it iterates over the table in a random order.
---
------
---
---USAGE
---```
---           for key,value in UTILS.rpairs(mytable) do
---               -- your code here
---           end
---```
------
---@return string #key The index key
---@return string #value The value at the indexed key
---@private
function UTILS.rpairs(t) end

---Here is a customized version of pairs, which I called spairs because it iterates over the table in a sorted order.
---
------
---
---USAGE
---```
---           for key,value in UTILS.spairs(mytable) do
---               -- your code here
---           end
---```
------
---@param order? string (Optional) The sorting function
---@return string #key The index key
---@return string #value The value at the indexed key
---@private
function UTILS.spairs(t, order) end


---
------
---@param lon NOTYPE 
---@param acc NOTYPE 
---@param DMS NOTYPE 
---@private
function UTILS.tostringLL(lat, lon, acc, DMS) end


---
------
---@param lon NOTYPE 
---@param acc NOTYPE 
---@private
function UTILS.tostringLLM2KData(lat, lon, acc) end


---
------
---@param acc NOTYPE 
---@private
function UTILS.tostringMGRS(MGRS, acc) end


---Utilities weather class for fog mainly.
---@class UTILS.Weather 
UTILS.Weather = {}


---
------
function UTILS.Weather.GetFogThickness() end


---
------
function UTILS.Weather.GetFogVisibilityDistanceMax() end


---
------
function UTILS.Weather.RemoveFog() end

--- Uses data from the passed table to change the fog visibility and thickness over a desired timeframe.
---This allows for a gradual increase/decrease of fog values rather than abruptly applying the values.
---Animation Key Format: {time, visibility, thickness}
---
------
---
---USAGE
---```
---Time: in seconds 0 to infinity
---Time is relative to when the function was called. Time value for each key must be larger than the previous key. If time is set to 0 then the fog will be applied to the corresponding visibility and thickness values at that key. Any time value greater than 0 will result in the current fog being inherited and changed to the first key.
---Visibility: in meters 100 to 100000
---Thickness: in meters 100 to 5000
---The speed at which the visibility and thickness changes is based on the time between keys and the values that visibility and thickness are being set to.
---
---When the function is passed an empty table {} or nil the fog animation will be discarded and whatever the current thickness and visibility are set to will remain.
---
---The following will set the fog in the mission to disappear in 1 minute.
---
---           UTILS.Weather.SetFogAnimation({ {60, 0, 0} })
---
---The following will take 1 hour to get to the first fog setting, it will maintain that fog setting for another hour, then lightly removes the fog over the 2nd and 3rd hour, the completely removes the fog after 3 hours and 3 minutes from when the function was called.
---
---           UTILS.Weather.SetFogAnimation({
---             {3600, 10000, 3000},    -- one hour to get to that fog setting
---             {7200, 10000, 3000},    -- will maintain for 2 hours
---             {10800, 20000, 2000},   -- at 3 hours visibility will have been increased while thickness decreases slightly
---             {12600, 0, 0},          -- at 3:30 after the function was called the fog will be completely removed. 
---           })
---```
------
function UTILS.Weather.SetFogAnimation(AnimationKeys) end

---Sets the fog to the desired thickness in meters at sea level.
---
------
function UTILS.Weather.SetFogThickness(Thickness) end

---Sets the maximum visibility at sea level in meters.
---
------
function UTILS.Weather.SetFogVisibilityDistance(Thickness) end


---
------
function UTILS.Weather.StopFogAnimation() end



