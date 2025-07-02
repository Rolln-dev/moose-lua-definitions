---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_ATIS.png" width="100%">
---
---*It is a very sad thing that nowadays there is so little useless information.* - Oscar Wilde
---
---===
---
---![Banner Image](..\Presentations\ATIS\ATIS_Main.png)
---
---# The ATIS Concept
---
---Automatic terminal information service, or ATIS, is a continuous broadcast of recorded aeronautical information in busier terminal areas, *i.e.* airports and their immediate surroundings.
---ATIS broadcasts contain essential information, such as current weather information, active runways, and any other information required by the pilots.
---
---# DCS Limitations
---
---Unfortunately, the DCS API only allow to get the temperature, pressure as well as wind direction and speed. Therefore, some other information such as cloud coverage, base and ceiling are not available
---when dynamic weather is used.
---
---# Scripting
---
---The lua script to create an ATIS at an airport is pretty easy:
---
---    -- ATIS at Batumi Airport on 143.00 MHz AM.
---    atisBatumi=ATIS:New("Batumi", 143.00)
---    atisBatumi:Start()
---
---The #ATIS.New(*airbasename*, *frequency*) creates a new ATIS object. The parameter *airbasename* is the name of the airbase or airport. Note that this has to be spelled exactly as in the DCS mission editor.
---The parameter *frequency* is the frequency the ATIS broadcasts in MHz.
---
---Broadcasting is started via the #ATIS.Start() function. The start can be delayed by using #ATIS.__Start(*delay*), where *delay* is the delay in seconds.
---
---## Subtitles
---
---**Note** Subtitles are not displayed when using SRS. The DCS mechanic to show subtitles (top left screen), is via the function call that plays a sound file from a UNIT, hence this doesn't work here.
---
---Currently, DCS allows for displaying subtitles of radio transmissions only from airborne units, *i.e.* airplanes and helicopters. Therefore, if you want to have subtitles, it is necessary to place an
---additional aircraft on the ATIS airport and set it to uncontrolled. This unit can then function as a radio relay to transmit messages with subtitles. These subtitles will only be displayed, if the
---player has tuned in the correct ATIS frequency.
---
---Radio transmissions via an airborne unit can be set via the #ATIS.SetRadioRelayUnitName(*unitname*) function, where the parameter *unitname* is the name of the unit passed as string, *e.g.*
---
---    atisBatumi:SetRadioRelayUnitName("Radio Relay Batumi")
---
---With a unit set in the mission editor with name "Radio Relay Batumi".
---
---**Note** that you should use a different relay unit for each ATIS!
---
---By default, subtitles are displayed for 10 seconds. This can be changed using #ATIS.SetSubtitleDuration(*duration*) with *duration* being the duration in seconds.
---Setting a *duration* of 0 will completely disable all subtitles.
---
---## Active Runway
---
---By default, the currently active runway is determined automatically by analyzing the wind direction. Therefore, you should obviously set the wind speed to be greater zero in your mission.
---
---Note however, there are a few special cases, where automatic detection does not yield the correct or desired result.
---For example, there are airports with more than one runway facing in the same direction (usually denoted left and right). In this case, there is obviously no *unique* result depending on the wind vector.
---
---If the automatic runway detection fails, the active runway can be specified manually in the script via the #ATIS.SetActiveRunway(*runway*) function.
---The parameter *runway* is a string which can be used to specify the runway heading and, if applicable, whether the left or right runway is in use.
---
---For example, setting runway 21L would be
---
---    atisNellis:SetActiveRunway("21L")
---
---The script will examine the string and search for the characters "L" (left) and "R" (right).
---
---If only left or right should be set and the direction determined by the wind vector, the runway heading can be left out, *e.g.*
---
---    atisAbuDhabi:SetActiveRunway("L")
---
---The first two digits of the runway are determined by converting the *true* runway heading into its magnetic heading. The magnetic declination (or variation) is assumed to be constant on the given map.
---An explicit correction factor can be set via #ATIS.SetRunwayCorrectionMagnetic2True.
---
---## Tower Frequencies
---
---The tower frequency (or frequencies) can also be included in the ATIS information. However, there is no way to get these automatically. Therefore, it is necessary to manually specify them in the script via the
---#ATIS.SetTowerFrequencies(*frequencies*) function. The parameter *frequencies* can be a plain number if only one frequency is necessary or it can be a table of frequencies.
---
---## Nav Aids
---
---Frequencies or channels of navigation aids can be specified by the user and are then provided as additional information. Unfortunately, it is **not possible** to acquire this information via the DCS API
---we have access to.
---
---As they say, all road lead to Rome but (for me) the easiest way to obtain the available nav aids data of an airport, is to start a mission and click on an airport symbol.
---
---For example, the *AIRDROME DATA* for **Batumi** reads:
---
---   * **TACAN** *16X* - set via #ATIS.SetTACAN
---   * **VOR** *N/A* - set via #ATIS.SetVOR
---   * **RSBN** *N/A* - set via #ATIS.SetRSBN
---   * **ATC** *260.000*, *131.000*, *40.400*, *4.250* - set via #ATIS.SetTowerFrequencies
---   * **Runways** *31* and *13* - automatic but can be set manually via #ATIS.SetRunwayHeadingsMagnetic
---   * **ILS** *110.30* for runway *13* - set via #ATIS.AddILS
---   * **PRMG** *N/A* - set via #ATIS.AddPRMG
---   * **OUTER NDB** *N/A* - set via #ATIS.AddNDBouter
---   * **INNER NDB** *N/A* - set via #ATIS.AddNDBinner
---
---![Banner Image](..\Presentations\ATIS\NavAid_Batumi.png)
---
---And the *AIRDROME DATA* for **Kobuleti** reads:
---
---   * **TACAN** *67X* - set via #ATIS.SetTACAN
---   * **VOR** *N/A* - set via #ATIS.SetVOR
---   * **RSBN** *N/A* - set via #ATIS.SetRSBN
---   * **ATC** *262.000*, *133.000*, *40.800*, *4.350* - set via #ATIS.SetTowerFrequencies
---   * **Runways** *25* and *07* - automatic but can be set manually via #ATIS.SetRunwayHeadingsMagnetic
---   * **ILS** *111.50* for runway *07* - set via #ATIS.AddILS
---   * **PRMG** *N/A* - set via #ATIS.AddPRMG
---   * **OUTER NDB** *870.00* - set via #ATIS.AddNDBouter
---   * **INNER NDB** *490.00* - set via #ATIS.AddNDBinner
---
---![Banner Image](..\Presentations\ATIS\NavAid_Kobuleti.png)
---
---### TACAN
---
---The TACtical Air Navigation system [(TACAN)](https://en.wikipedia.org/wiki/Tactical_air_navigation_system) channel can be set via the #ATIS.SetTACAN(*channel*) function, where *channel* is the TACAN channel. Band is always assumed to be X-ray.
---
---### VOR
---
---The Very high frequency Omni-directional Range [(VOR)](https://en.wikipedia.org/wiki/VHF_omnidirectional_range) frequency can be set via the #ATIS.SetVOR(*frequency*) function, where *frequency* is the VOR frequency.
---
---### ILS
---
---The Instrument Landing System [(ILS)](https://en.wikipedia.org/wiki/Instrument_landing_system) frequency can be set via the #ATIS.AddILS(*frequency*, *runway*) function, where *frequency* is the ILS frequency and *runway* the two letter string of the corresponding runway, *e.g.* "31".
---If the parameter *runway* is omitted (nil) then the frequency is supposed to be valid for all runways of the airport.
---
---### NDB
---
---Inner and outer Non-Directional (radio) Beacons [NDBs](https://en.wikipedia.org/wiki/Non-directional_beacon) can be set via the #ATIS.AddNDBinner(*frequency*, *runway*) and #ATIS.AddNDBouter(*frequency*, *runway*) functions, respectively.
---
---In both cases, the parameter *frequency* is the NDB frequency and *runway* the two letter string of the corresponding runway, *e.g.* "31".
---If the parameter *runway* is omitted (nil) then the frequency is supposed to be valid for all runways of the airport.
---
---## RSBN
---
---The RSBN channel can be set via the #ATIS.SetRSBN(*channel*) function.
---
---## PRMG
---
---The PRMG channel can be set via the #ATIS.AddPRMG(*channel*, *runway*) function for each *runway*.
---
---## Unit System
---
---By default, information is given in imperial units, *i.e.* wind speed in knots, pressure in inches of mercury, visibility in Nautical miles, etc.
---
---If you prefer metric units, you can enable this via the #ATIS.SetMetricUnits() function,
---
---    atisBatumi:SetMetricUnits()
---
---With this, wind speed is given in meters per second, pressure in hectopascal (hPa, which is the same as millibar - mbar), visibility in kilometers etc.
---
---# Sound Files
---
---More than 180 individual sound files have been created using a text-to-speech program. All ATIS information is given with en-US accent.
---You can find the sound files [here](https://github.com/FlightControl-Master/MOOSE_SOUND/releases). Also check out the pinned messages in the Moose discord #ops-atis channel.
---
---To include the files, open the mission (.miz) file with, *e.g.*, 7-zip. Then just drag-n-drop the file into the miz.
---
---![Banner Image](..\Presentations\ATIS\ATIS_SoundFolder.png)
---
---**Note** that the default folder name is *ATIS Soundfiles/*. If you want to change it, you can use the #ATIS.SetSoundfilesPath(*path*), where *path* is the path of the directory. This must end with a slash "/"!
---
---# Marks on the F10 Map
---
---You can place marks on the F10 map via the #ATIS.SetMapMarks() function. These will contain info about the ATIS frequency, the currently active runway and some basic info about the weather (wind, pressure and temperature).
---
---# Text-To-Speech
---
---You can enable text-to-speech ATIS information with the #ATIS.SetSRS() function. This uses [SRS](http://dcssimpleradio.com/) (Version >= 1.9.6.0) for broadcasting.
---Advantages are that **no sound files** or radio relay units are necessary. Also the issue that FC3 aircraft hear all transmissions will be circumvented.
---
---The #ATIS.SetSRS() requires you to specify the path to the SRS install directory or more specifically the path to the DCS-SR-ExternalAudio.exe file.
---
---Unfortunately, it is not possible to determine the duration of the complete transmission. So once the transmission is finished, there might be some radio silence before
---the next iteration begins. You can fine tune the time interval between transmissions with the #ATIS.SetQueueUpdateTime() function. The default interval is 90 seconds.
---
---An SRS Setup-Guide can be found here: [Moose TTS Setup Guide](https://github.com/FlightControl-Master/MOOSE_GUIDES/blob/master/documents/Moose%20TTS%20Setup%20Guide.pdf)
---
---# Examples
---
---## Caucasus: Batumi
---
---    -- ATIS Batumi Airport on 143.00 MHz AM.
---    atisBatumi=ATIS:New(AIRBASE.Caucasus.Batumi, 143.00)
---    atisBatumi:SetRadioRelayUnitName("Radio Relay Batumi")
---    atisBatumi:Start()
---
---## Nevada: Nellis AFB
---
---    -- ATIS Nellis AFB on 270.10 MHz AM.
---    atisNellis=ATIS:New(AIRBASE.Nevada.Nellis, 270.1)
---    atisNellis:SetRadioRelayUnitName("Radio Relay Nellis")
---    atisNellis:SetActiveRunway("21L")
---    atisNellis:SetTowerFrequencies({327.000, 132.550})
---    atisNellis:SetTACAN(12)
---    atisNellis:AddILS(109.1, "21")
---    atisNellis:Start()
---
---## Persian Gulf: Abu Dhabi International Airport
---
---    -- ATIS Abu Dhabi International on 125.1 MHz AM.
---    atisAbuDhabi=ATIS:New(AIRBASE.PersianGulf.Abu_Dhabi_Intl, 125.1)
---    atisAbuDhabi:SetRadioRelayUnitName("Radio Relay Abu Dhabi International Airport")
---    atisAbuDhabi:SetMetricUnits()
---    atisAbuDhabi:SetActiveRunway("L")
---    atisAbuDhabi:SetTowerFrequencies({250.5, 119.2})
---    atisAbuDhabi:SetVOR(114.25)
---    atisAbuDhabi:Start()
---
---## SRS
---
---    atis=ATIS:New("Batumi", 305, radio.modulation.AM)
---    atis:SetSRS("D:\\DCS\\_SRS\\", "male", "en-US")
---    atis:Start()
---
---This uses a male voice with US accent. It requires SRS to be installed in the `D:\DCS\_SRS\` directory. Note that backslashes need to be escaped or simply use slashes (as in linux).
---
---### SRS can use multiple frequencies:
---
---    atis=ATIS:New("Batumi", {305,103.85}, {radio.modulation.AM,radio.modulation.FM})
---    atis:SetSRS("D:\\DCS\\_SRS\\", "male", "en-US")
---    atis:Start()
---
---### SRS Localization
---
--- You can localize the SRS output, all you need is to provide a table of translations and set the `locale` of your instance. You need to provide the translations in your script **before you instantiate your ATIS**.
--- The German localization (already provided in the code) e.g. looks like follows:
---
---         ATIS.Messages.DE =
---           {
---             HOURS = "Uhr",
---             TIME = "Zeit",
---             NOCLOUDINFO = "Informationen über Wolken nicht verfuegbar",
---             OVERCAST = "Geschlossene Wolkendecke",
---             BROKEN = "Stark bewoelkt",
---             SCATTERED = "Bewoelkt",
---             FEWCLOUDS = "Leicht bewoelkt",
---             NOCLOUDS = "Klar",
---             AIRPORT = "Flughafen",
---             INFORMATION ="Information",
---             SUNRISEAT = "Sonnenaufgang um %s lokaler Zeit",
---             SUNSETAT = "Sonnenuntergang um %s lokaler Zeit",
---             WINDFROMMS = "Wind aus %s mit %s m/s",
---             WINDFROMKNOTS = "Wind aus %s mit %s Knoten",
---             GUSTING = "boeig",
---             VISIKM = "Sichtweite %s km",
---             VISISM = "Sichtweite %s Meilen",
---             RAIN = "Regen",
---             TSTORM = "Gewitter",
---             SNOW = "Schnee",
---             SSTROM = "Schneesturm",
---             FOG = "Nebel",
---             DUST = "Staub",
---             PHENOMENA = "Wetter Phaenomene",
---             CLOUDBASEM = "Wolkendecke von %s bis %s Meter",
---             CLOUDBASEFT = "Wolkendecke von %s bis %s Fuß",
---             TEMPERATURE = "Temperatur",
---             DEWPOINT = "Taupunkt",
---             ALTIMETER = "Hoehenmesser",
---             ACTIVERUN = "Aktive Startbahn",
---             ACTIVELANDING = "Aktive Landebahn",
---             LEFT = "Links",
---             RIGHT = "Rechts",
---             RWYLENGTH = "Startbahn",
---             METERS = "Meter",
---             FEET = "Fuß",
---             ELEVATION = "Hoehe",
---             TOWERFREQ = "Kontrollturm Frequenz",
---             ILSFREQ = "ILS Frequenz",
---             OUTERNDB = "Aeussere NDB Frequenz",
---             INNERNDB = "Innere NDB Frequenz",
---             VORFREQ = "VOR Frequenz",
---             VORFREQTTS = "V O R Frequenz",
---             TACANCH = "TACAN Kanal %d Xaver",
---             RSBNCH = "RSBN Kanal",
---             PRMGCH = "PRMG Kanal",
---             ADVISE = "Hinweis bei Erstkontakt, Sie haben Informationen",
---             STATUTE = "englische Meilen",
---             DEGREES = "Grad Celsius",
---             FAHRENHEIT = "Grad Fahrenheit",
---             INCHHG = "Inches H G",
---             MMHG = "Millimeter H G",
---             HECTO = "Hektopascal",
---             METERSPER = "Meter pro Sekunde",
---             TACAN = "Tackan",
---             FARP = "Farp",
---             DELIMITER = "Komma", -- decimal delimiter
---           }
---
---Then set up your ATIS and set the locale:
---
---         atis=ATIS:New("Batumi", 305, radio.modulation.AM)
---         atis:SetSRS("D:\\DCS\\_SRS\\", "female", "de_DE")
---         atis:SetLocale("de") -- available locales from source are "en", "de" and "es"
---         atis:Start()
---
---## FARPS
---
---ATIS is working with FARPS, but this requires the usage of SRS. The airbase name for the `New()-method` is the UNIT name of the FARP:
---
---     atis = ATIS:New("FARP Gold",119,radio.modulation.AM)
---     atis:SetMetricUnits()
---     atis:SetTransmitOnlyWithPlayers(true)
---     atis:SetReportmBar(true)
---     atis:SetTowerFrequencies(127.50)
---     atis:SetSRS("D:\\DCS\\_SRS\\", "male", "en-US",nil,5002)
---     atis:SetAdditionalInformation("Welcome to the Jungle!")
---     atis:__Start(3)
---ATIS class.
---@class ATIS : FSM
---@field ATISforFARPs boolean Will be set to true if the base given is a FARP/Helipad
---@field AdditionalInformation NOTYPE 
---@field Alphabet ATIS.Alphabet 
---@field ClassName string Name of the class.
---@field ICAOPhraseology ATIS.ICAOPhraseology 
---@field Messages table 
---@field PmmHg boolean If true, give pressure in millimeters of Mercury. Default is inHg for imperial and hectopascal (hPa, which is the same as millibar - mbar) for metric units.
---@field ReportmBar boolean Report mBar/hpa even if not metric, i.e. for Mirage flights
---@field RunwayM2T ATIS.RunwayM2T 
---@field SRSText string Text of the complete SRS message (if done at least once, else nil)
---@field Sound ATIS.Sound 
---@field TDegF boolean If true, give temperature in degrees Fahrenheit. Default is in degrees Celsius independent of chosen unit system.
---@field TransmitOnlyWithPlayers boolean For SRS - If true, only transmit if there are alive Players.
---@field private activerunway string The active runway specified by the user.
---@field private airbase AIRBASE The airbase object.
---@field private airbasename string The name of the airbase.
---@field private altimeterQNH boolean Report altimeter QNH.
---@field private dTQueueCheck number Time interval to check the radio queue. Default 5 sec or 90 sec if SRS is used.
---@field private elevation boolean If true, give info on airfield elevation.
---@field private frequency number Radio frequency in MHz.
---@field private gettext TEXTANDSOUND Gettext for localization
---@field private ils table Table of ILS frequencies (can be runway specific).
---@field private lid string Class id string for output to DCS log file.
---@field private locale string Current locale
---@field private magvar number Magnetic declination/variation at the airport in degrees.
---@field private markerid number Numerical ID of the F10 map mark point.
---@field private metric boolean If true, use metric units. If false, use imperial (default).
---@field private modulation number Radio modulation 0=AM or 1=FM.
---@field private msrs MSRS Moose SRS object.
---@field private msrsQ NOTYPE 
---@field private ndbinner table Table of inner NDB frequencies (can be runway specific).
---@field private ndbouter table Table of outer NDB frequencies (can be runway specific).
---@field private power number Radio power in Watts. Default 100 W.
---@field private prmg table PRMG channels (can be runway specific).
---@field private qnhonly boolean If true, suppresses reporting QFE. Default is to report both QNH and QFE.
---@field private radioqueue RADIOQUEUE Radio queue for broadcasing messages.
---@field private relHumidity number Relative humidity (used to approximately calculate the dew point).
---@field private relayunitname string Name of the radio relay unit.
---@field private rsbn number RSBN channel.
---@field private runwaym2t number Optional correction for magnetic to true runway heading conversion (and vice versa) in degrees.
---@field private runwaymag table Table of magnetic runway headings.
---@field private rwylength boolean If true, give info on runway length.
---@field private soundpath string Path to sound files.
---@field private soundpathAirports string Path to airport names sound files.
---@field private soundpathNato string Path to NATO alphabet sound files.
---@field private subduration number Duration how long subtitles are displayed in seconds.
---@field private tacan number TACAN channel.
---@field private theatre string DCS map name.
---@field private towerfrequency table Table with tower frequencies.
---@field private useSRS boolean If true, use SRS for transmission.
---@field private usemarker boolean Use mark on the F10 map.
---@field private version string ATIS class version.
---@field private vor number VOR frequency.
---@field private windtrue boolean Report true (from) heading of wind. Default is magnetic.
---@field private zuludiff number Time difference local vs. zulu in hours.
---@field private zulutimeonly boolean If true, suppresses report of local time, sunrise, and sunset.
ATIS = {}

---Add ILS station.
---Note that this can be runway specific.
---
------
---@param frequency number ILS frequency in MHz.
---@param runway? string (Optional) Runway for which the given ILS frequency applies. Default all (*nil*).
---@return ATIS #self
function ATIS:AddILS(frequency, runway) end

---Add inner NDB.
---Note that this can be runway specific.
---
------
---@param frequency number NDB frequency in MHz.
---@param runway? string (Optional) Runway for which the given NDB frequency applies. Default all (*nil*).
---@return ATIS #self
function ATIS:AddNDBinner(frequency, runway) end

---Add outer NDB.
---Note that this can be runway specific.
---
------
---@param frequency number NDB frequency in MHz.
---@param runway? string (Optional) Runway for which the given NDB frequency applies. Default all (*nil*).
---@return ATIS #self
function ATIS:AddNDBouter(frequency, runway) end

---Add PRMG channel.
---Note that this can be runway specific.
---
------
---@param channel number PRMG channel.
---@param runway? string (Optional) Runway for which the given PRMG channel applies. Default all (*nil*).
---@return ATIS #self
function ATIS:AddPRMG(channel, runway) end

---Triggers the FSM event "Broadcast".
---
------
function ATIS:Broadcast() end

---Triggers the FSM event "CheckQueue".
---
------
function ATIS:CheckQueue() end

---Get active runway runway.
---
------
---@param Takeoff boolean If `true`, get runway for takeoff. Default is for landing.
---@return string #Active runway, e.g. "31" for 310 deg.
---@return boolean #Use Left=true, Right=false, or nil.
function ATIS:GetActiveRunway(Takeoff) end

---Get the coalition of the associated airbase.
---
------
---@return number #Coalition of the associated airbase.
function ATIS:GetCoalition() end

---Get runway from user supplied magnetic heading.
---
------
---@param windfrom number Wind direction (from) in degrees.
---@return string #Runway magnetic heading divided by ten (and rounded). Eg, "13" for 130°.
function ATIS:GetMagneticRunway(windfrom) end

---Get weather of this mission from env.mission.weather variable.
---
------
---@return table #Clouds table which has entries "thickness", "density", "base", "iprecptns".
---@return number #Visibility distance in meters.
---@return number #Ground turbulence in m/s.
---@return table #Fog table, which has entries "thickness", "visibility" or nil if fog is disabled in the mission.
---@return number #Dust density or nil if dust is disabled in the mission.
---@return boolean #static If true, static weather is used. If false, dynamic weather is used.
function ATIS:GetMissionWeather() end

---Get nav aid data.
---
------
---@param navpoints table Nav points data table.
---@param runway string (Active) runway, *e.g.* "31".
---@param left boolean If *true*, left runway, if *false, right, else does not matter.
---@return ATIS.NavPoint #Nav point data table.
function ATIS:GetNavPoint(navpoints, runway, left) end

---Get info if left or right runway is active.
---
------
---@param runway string Runway heading, *e.g.* "31L".
---@return boolean #If *true*, left runway is active. If *false*, right runway. If *nil*, neither applies.
function ATIS:GetRunwayLR(runway) end

---Get runway heading without left or right info.
---
------
---@param runway string Runway heading, *e.g.* "31L".
---@return string #Runway heading without left or right, *e.g.* "31".
function ATIS:GetRunwayWithoutLR(runway) end

---Return the complete SRS Text block, if at least generated once.
---Else nil.
---
------
---@return string #SRSText
function ATIS:GetSRSText() end

---Place marks with runway data on the F10 map.
---
------
---@param markall boolean If true, mark all runways of the map. By default only the current ATIS runways are marked.
function ATIS:MarkRunways(markall) end

---Create a new ATIS class object for a specific airbase.
---
------
---@param AirbaseName string Name of the airbase.
---@param Frequency number Radio frequency in MHz. Default 143.00 MHz. When using **SRS** this can be passed as a table of multiple frequencies.
---@param Modulation number Radio modulation: 0=AM, 1=FM. Default 0=AM. See `radio.modulation.AM` and `radio.modulation.FM` enumerators. When using **SRS** this can be passed as a table of multiple modulations.
---@return ATIS #self
function ATIS:New(AirbaseName, Frequency, Modulation) end

---On after "Report" event user function.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Text string Report text.
function ATIS:OnAfterReport(From, Event, To, Text) end

---Base captured
---
------
---@param EventData EVENTDATA Event data.
function ATIS:OnEventBaseCaptured(EventData) end

---Triggers the FSM event "Report".
---
------
---@param Text string Report text.
function ATIS:Report(Text) end

---Suppresses QFE readout.
---Default is to report both QNH and QFE.
---
------
---@return ATIS #self
function ATIS:ReportQNHOnly() end

---Suppresses local time, sunrise, and sunset.
---Default is to report all these times.
---
------
---@return ATIS #self
function ATIS:ReportZuluTimeOnly() end

---Set active runway for **landing** operations.
---This can be used if the automatic runway determination via the wind direction gives incorrect results.
---For example, use this if there are two runways with the same directions.
---
------
---@param runway string Active runway, *e.g.* "31L".
---@return ATIS #self
function ATIS:SetActiveRunway(runway) end

---Set the active runway for landing.
---
------
---@param runway string : Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param preferleft boolean : If true, perfer the left runway. If false, prefer the right runway. If nil (default), do not care about left or right.
---@return ATIS #self
function ATIS:SetActiveRunwayLanding(runway, preferleft) end

---Set the active runway for take-off.
---
------
---@param runway string : Name of the runway, e.g. "31" or "02L" or "90R". If not given, the runway is determined from the wind direction.
---@param preferleft boolean : If true, perfer the left runway. If false, prefer the right runway. If nil (default), do not care about left or right.
---@return ATIS #self
function ATIS:SetActiveRunwayTakeoff(runway, preferleft) end

---Additionally report free text, only working with SRS(!)
---
------
---@param text string The text to report at the end of the ATIS message, e.g. runway closure, warnings, etc.
---@return ATIS #self
function ATIS:SetAdditionalInformation(text) end

---Report altimeter QNH.
---
------
---@param switch boolean If true or nil, report altimeter QHN. If false, report QFF.
---@return ATIS #self
function ATIS:SetAltimeterQNH(switch) end

---Give information on airfield elevation
---
------
---@return ATIS #self
function ATIS:SetElevation() end

---Set unit system to imperial units.
---
------
---@return ATIS #self
function ATIS:SetImperialUnits() end

---Set locale for localized text-to-sound output via SRS, defaults to "en".
---
------
---@param locale string Locale for localized text-to-sound output via SRS, defaults to "en".
---@return ATIS #self
function ATIS:SetLocale(locale) end

---Set magnetic declination/variation at the airport.
---
---Default is per map:
---
---* Caucasus +6 (East), year ~ 2011
---* NTTR +12 (East), year ~ 2011
---* Normandy -10 (West), year ~ 1944
---* Persian Gulf +2 (East), year ~ 2011
---
---To get *true* from *magnetic* heading one has to add easterly or substract westerly variation, e.g
---
---A magnetic heading of 180° corresponds to a true heading of
---
---  * 186° on the Caucaus map
---  * 192° on the Nevada map
---  * 170° on the Normandy map
---  * 182° on the Persian Gulf map
---
---Likewise, to convert *true* into *magnetic* heading, one has to substract easterly and add westerly variation.
---
---Or you make your life simple and just include the sign so you don't have to bother about East/West.
---
------
---@param magvar number Magnetic variation in degrees. Positive for easterly and negative for westerly variation. Default is magnatic declinaton of the used map, c.f. @{Utilities.Utils#UTILS.GetMagneticDeclination}.
---@return ATIS #self
function ATIS:SetMagneticDeclination(magvar) end

---Use F10 map mark points.
---
------
---@param switch boolean If *true* or *nil*, marks are placed on F10 map. If *false* this feature is set to off (default).
---@return ATIS #self
function ATIS:SetMapMarks(switch) end

---Set unit system to metric units.
---
------
---@return ATIS #self
function ATIS:SetMetricUnits() end

---Set pressure unit to millimeters of mercury (mmHg).
---Default is inHg for imperial and hPa (=mBar) for metric units.
---
------
---@return ATIS #self
function ATIS:SetPressureMillimetersMercury() end

---Set the time interval between radio queue updates.
---
------
---@param TimeInterval number Interval in seconds. Default 5 sec.
---@return ATIS #self
function ATIS:SetQueueUpdateTime(TimeInterval) end

---Set RSBN channel.
---
------
---@param channel number RSBN channel.
---@return ATIS #self
function ATIS:SetRSBN(channel) end

---Set radio power.
---Note that this only applies if no relay unit is used.
---
------
---@param power number Radio power in Watts. Default 100 W.
---@return ATIS #self
function ATIS:SetRadioPower(power) end

---Set airborne unit (airplane or helicopter), used to transmit radio messages including subtitles.
---Best is to place the unit on a parking spot of the airbase and set it to *uncontrolled* in the mission editor.
---
------
---@param unitname string Name of the unit.
---@return ATIS #self
function ATIS:SetRadioRelayUnitName(unitname) end

---Set relative humidity.
---This is used to approximately calculate the dew point.
---Note that the dew point is only an artificial information as DCS does not have an atmospheric model that includes humidity (yet).
---
------
---@param Humidity number Relative Humidity, i.e. a number between 0 and 100 %. Default is 50 %.
---@return ATIS #self
function ATIS:SetRelativeHumidity(Humidity) end

---Set wind direction (from) to be reported as *true* heading.
---Default is magnetic.
---
------
---@return ATIS #self
function ATIS:SetReportWindTrue() end

---Additionally report altimeter QNH/QFE in hPa, even if not set to metric.
---
------
---@param switch boolean If true or nil, report mBar/hPa in addition.
---@return ATIS #self
function ATIS:SetReportmBar(switch) end

---Explicitly set correction of magnetic to true heading for runways.
---
------
---@param correction number Correction of magnetic to true heading for runways in degrees.
---@return ATIS #self
function ATIS:SetRunwayCorrectionMagnetic2True(correction) end

---Set magnetic runway headings as depicted on the runway, *e.g.* "13" for 130° or "25L" for the left runway with magnetic heading 250°.
---
------
---@param headings table Magnetic headings. Inverse (-180°) headings are added automatically. You only need to specify one heading per runway direction. "L"eft and "R" right can also be appended.
---@return ATIS #self
function ATIS:SetRunwayHeadingsMagnetic(headings) end

---Give information on runway length.
---
------
---@return ATIS #self
function ATIS:SetRunwayLength() end

---Use SRS Simple-Text-To-Speech for transmissions.
---No sound files necessary.`SetSRS()` will try to use as many attributes configured with Sound.SRS#MSRS.LoadConfigFile() as possible.
---
------
---@param PathToSRS string Path to SRS directory (only necessary if SRS exe backend is used).
---@param Gender string Gender: "male" or "female" (default).
---@param Culture string Culture, e.g. "en-GB" (default).
---@param Voice string Specific voice. Overrides `Gender` and `Culture`.
---@param Port number SRS port. Default 5002.
---@param GoogleKey string Path to Google JSON-Key (SRS exe backend) or Google API key (DCS-gRPC backend).
---@return ATIS #self
function ATIS:SetSRS(PathToSRS, Gender, Culture, Voice, Port, GoogleKey) end

---Set an alternative provider to the one set in your MSRS configuration file.
---
------
---@param Provider string The provider to use. Known providers are: `MSRS.Provider.WINDOWS` and `MSRS.Provider.GOOGLE`
---@return ATIS #self
function ATIS:SetSRSProvider(Provider) end

---Set the path to the csv file that contains information about the used sound files.
---The parameter file has to be located on your local disk (**not** inside the miz file).
---
------
---@param csvfile string Full path to the csv file on your local disk.
---@return ATIS #self
function ATIS:SetSoundfilesInfo(csvfile) end

---Set sound files folder within miz file (not your local hard drive!).
---
------
---@param pathMain string Path to folder containing main sound files. Default "ATIS Soundfiles/". Mind the slash "/" at the end!
---@param pathAirports string Path folder containing the airport names sound files. Default is `"ATIS Soundfiles/<Map Name>"`, *e.g.* `"ATIS Soundfiles/Caucasus/"`.
---@param pathNato string Path folder containing the NATO alphabet sound files. Default is "ATIS Soundfiles/NATO Alphabet/".
---@return ATIS #self
function ATIS:SetSoundfilesPath(pathMain, pathAirports, pathNato) end

---Set duration how long subtitles are displayed.
---
------
---@param duration number Duration in seconds. Default 10 seconds.
---@return ATIS #self
function ATIS:SetSubtitleDuration(duration) end

---Set TACAN channel.
---
------
---@param channel number TACAN channel.
---@return ATIS #self
function ATIS:SetTACAN(channel) end

---Set temperature to be given in degrees Fahrenheit.
---
------
---@return ATIS #self
function ATIS:SetTemperatureFahrenheit() end

---Set tower frequencies.
---
------
---@param freqs table Table of frequencies in MHz. A single frequency can be given as a plain number (*i.e.* must not be table).
---@return ATIS #self
function ATIS:SetTowerFrequencies(freqs) end

---For SRS - Switch to only transmit if there are players on the server.
---
------
---@param Switch boolean If true, only send SRS if there are alive Players.
---@return ATIS #self
function ATIS:SetTransmitOnlyWithPlayers(Switch) end

---Set VOR station.
---
------
---@param frequency number VOR frequency.
---@return ATIS #self
function ATIS:SetVOR(frequency) end

---Set time local difference with respect to Zulu time.
---Default is per map:
---
---   * Caucasus +4
---   * Nevada -8
---   * Normandy 0
---   * Persian Gulf +4
---   * The Channel +2 (should be 0)
---
------
---@param delta number Time difference in hours.
---@return ATIS #self
function ATIS:SetZuluTimeDifference(delta) end

---Play all audio files.
---
------
function ATIS:SoundCheck() end

---Triggers the FSM event "Start".
---Starts the ATIS.
---
------
function ATIS:Start() end

---Triggers the FSM event "Status".
---
------
function ATIS:Status() end

---Triggers the FSM event "Stop".
---Stops the ATIS.
---
------
function ATIS:Stop() end

---Transmission via RADIOQUEUE.
---
------
---@param sound ATIS.Soundfile ATIS sound object.
---@param interval number Interval in seconds after the last transmission finished.
---@param subtitle string Subtitle of the transmission.
---@param path string Path to sound file. Default `self.soundpath`.
function ATIS:Transmission(sound, interval, subtitle, path) end

---Update F10 map marker.
---
------
---@param information string Information tag text.
---@param runact string Active runway text.
---@param wind string Wind text.
---@param altimeter string Altimeter text.
---@param temperature string Temperature text.
---@return number #Marker ID.
function ATIS:UpdateMarker(information, runact, wind, altimeter, temperature) end

---Get thousands of a number.
---
------
---@param n number Number, *e.g.* 4359.
---@return string #Thousands of n, *e.g.* "4" for 4359.
---@return string #Hundreds of n, *e.g.* "4" for 4359 because its rounded.
function ATIS:_GetThousandsAndHundreds(n) end

---[Internal] Init localization
---
------
---@return ATIS #self
function ATIS:_InitLocalization() end

---Triggers the FSM event "Broadcast" after a delay.
---
------
---@param delay number Delay in seconds.
function ATIS:__Broadcast(delay) end

---Triggers the FSM event "CheckQueue" after a delay.
---
------
---@param delay number Delay in seconds.
function ATIS:__CheckQueue(delay) end

---Triggers the FSM event "Report" after a delay.
---
------
---@param delay number Delay in seconds.
---@param Text string Report text.
function ATIS:__Report(delay, Text) end

---Triggers the FSM event "Start" after a delay.
---
------
---@param delay number Delay in seconds.
function ATIS:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param delay number Delay in seconds.
function ATIS:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---
------
---@param delay number Delay in seconds.
function ATIS:__Stop(delay) end

---Broadcast ATIS radio message.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ATIS:onafterBroadcast(From, Event, To) end

---Check if radio queue is empty.
---If so, start broadcasting the message again.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ATIS:onafterCheckQueue(From, Event, To) end

---Text report of ATIS information.
---Information delimitor is a semicolon ";" and a line break "\n".
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Text string Report text.
---@private
function ATIS:onafterReport(From, Event, To, Text) end

---Start ATIS FSM.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ATIS:onafterStart(From, Event, To) end

---Update status.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function ATIS:onafterStatus(From, Event, To) end


---Whether ICAO phraseology is used for ATIS broadcasts.
---@class ATIS.ICAOPhraseology 
---@field Afghanistan boolean true.
---@field Caucasus boolean true.
---@field Falklands boolean true.
---@field GermanyCW boolean true.
---@field Iraq boolean true.
---@field Kola boolean true.
---@field MarianaIslands boolean true.
---@field Nevada boolean false.
---@field Normandy boolean true.
---@field PersianGulf boolean true.
---@field SinaiMap boolean true.
---@field Syria boolean true.
---@field TheChannel boolean true.
ATIS.ICAOPhraseology = {}


---Nav point data.
---@class ATIS.NavPoint 
---@field private frequency number Nav point frequency.
---@field private leftright boolean If true, runway has left "L" and right "R" runways.
---@field private runway string Runway, *e.g.* "21".
ATIS.NavPoint = {}


---Runway correction for converting true to magnetic heading.
---@class ATIS.RunwayM2T 
---@field Afghanistan number +3° (East).
---@field Caucasus number 0° (East).
---@field Falklands number 
---@field GermanyCW number +0.1° (East).
---@field Iraq number +4.4° (East).
---@field Kola number +15° (East).
---@field MarianaIslands number +2° (East).
---@field Nevada number +12° (East).
---@field Normandy number -10° (West).
---@field PersianGulf number +2° (East).
---@field SinaiMap number +5° (East).
---@field Syria number +5° (East).
---@field TheChannel number -10° (West).
ATIS.RunwayM2T = {}


---Sound files.
---@class ATIS.Sound 
---@field ActiveRunway ATIS.Soundfile 
---@field ActiveRunwayArrival table 
---@field ActiveRunwayDeparture table 
---@field AdviceOnInitial ATIS.Soundfile 
---@field Airport ATIS.Soundfile 
---@field Altimeter ATIS.Soundfile 
---@field At ATIS.Soundfile 
---@field CloudBase ATIS.Soundfile 
---@field CloudCeiling ATIS.Soundfile 
---@field CloudsBroken ATIS.Soundfile 
---@field CloudsFew ATIS.Soundfile 
---@field CloudsNo ATIS.Soundfile 
---@field CloudsNotAvailable ATIS.Soundfile 
---@field CloudsOvercast ATIS.Soundfile 
---@field CloudsScattered ATIS.Soundfile 
---@field Decimal ATIS.Soundfile 
---@field DegreesCelsius ATIS.Soundfile 
---@field DegreesFahrenheit ATIS.Soundfile 
---@field DewPoint ATIS.Soundfile 
---@field Dust ATIS.Soundfile 
---@field Elevation ATIS.Soundfile 
---@field EndOfInformation ATIS.Soundfile 
---@field Feet ATIS.Soundfile 
---@field Fog ATIS.Soundfile 
---@field Gusting ATIS.Soundfile 
---@field HectoPascal ATIS.Soundfile 
---@field Hundred ATIS.Soundfile 
---@field ILSFrequency ATIS.Soundfile 
---@field InchesOfMercury ATIS.Soundfile 
---@field Information ATIS.Soundfile 
---@field InnerNDBFrequency ATIS.Soundfile 
---@field Kilometers ATIS.Soundfile 
---@field Knots ATIS.Soundfile 
---@field Left ATIS.Soundfile 
---@field MegaHertz ATIS.Soundfile 
---@field Meters ATIS.Soundfile 
---@field MetersPerSecond ATIS.Soundfile 
---@field Miles ATIS.Soundfile 
---@field MillimetersOfMercury ATIS.Soundfile 
---@field Minus table 
---@field N0 ATIS.Soundfile 
---@field N1 ATIS.Soundfile 
---@field N2 ATIS.Soundfile 
---@field N3 ATIS.Soundfile 
---@field N4 ATIS.Soundfile 
---@field N5 ATIS.Soundfile 
---@field N6 ATIS.Soundfile 
---@field N7 ATIS.Soundfile 
---@field N8 ATIS.Soundfile 
---@field N9 ATIS.Soundfile 
---@field NauticalMiles ATIS.Soundfile 
---@field None ATIS.Soundfile 
---@field OuterNDBFrequency ATIS.Soundfile 
---@field PRMGChannel ATIS.Soundfile 
---@field QFE ATIS.Soundfile 
---@field QNH ATIS.Soundfile 
---@field RSBNChannel ATIS.Soundfile 
---@field Rain ATIS.Soundfile 
---@field Right ATIS.Soundfile 
---@field RunwayLength ATIS.Soundfile 
---@field Snow ATIS.Soundfile 
---@field SnowStorm ATIS.Soundfile 
---@field StatuteMiles table 
---@field SunriseAt ATIS.Soundfile 
---@field SunsetAt ATIS.Soundfile 
---@field TACANChannel ATIS.Soundfile 
---@field Temperature ATIS.Soundfile 
---@field Thousand ATIS.Soundfile 
---@field ThunderStorm ATIS.Soundfile 
---@field TimeLocal ATIS.Soundfile 
---@field TimeZulu ATIS.Soundfile 
---@field TowerFrequency ATIS.Soundfile 
---@field VORFrequency ATIS.Soundfile 
---@field Visibilty ATIS.Soundfile 
---@field WeatherPhenomena ATIS.Soundfile 
---@field WindFrom ATIS.Soundfile 
---@field Zulu table 
ATIS.Sound = {}


---Sound file data.
---@class ATIS.Soundfile 
---@field private duration number Duration in seconds.
---@field private filename string Name of the file
ATIS.Soundfile = {}



