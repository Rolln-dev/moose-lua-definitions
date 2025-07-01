---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
---**Utilities** Enumerators.
---
---An enumerator is a variable that holds a constant value. Enumerators are very useful because they make the code easier to read and to change in general.
---
---For example, instead of using the same value at multiple different places in your code, you should use a variable set to that value.
---If, for whatever reason, the value needs to be changed, you only have to change the variable once and do not have to search through you code and reset
---every value by hand.
---
---Another big advantage is that the LDT intellisense "knows" the enumerators. So you can use the autocompletion feature and do not have to keep all the
---values in your head or look them up in the docs. 
---
---DCS itself provides a lot of enumerators for various things. See [Enumerators](https://wiki.hoggitworld.com/view/Category:Enumerators) on Hoggit.
---
---Other Moose classes also have enumerators. For example, the AIRBASE class has enumerators for airbase names.
---Because ENUMS are just better practice.
---
--- The ENUMS class adds some handy variables, which help you to make your code better and more general.
---[DCS Enum world](https://wiki.hoggitworld.com/view/DCS_enum_world)
---@class ENUMS 
---@field AlarmState ENUMS.AlarmState 
---@field FARPObjectTypeNamesAndShape ENUMS.FARPObjectTypeNamesAndShape 
---@field FARPType ENUMS.FARPType 
---@field Formation ENUMS.Formation 
---@field FormationOld ENUMS.FormationOld 
---@field ISOLang ENUMS.ISOLang 
---@field Link16Power ENUMS.Link16Power 
---@field MissionTask ENUMS.MissionTask 
---@field Morse ENUMS.Morse 
---@field Phonetic ENUMS.Phonetic 
---@field ROE ENUMS.ROE 
---@field ROT ENUMS.ROT 
---@field ReportingName ENUMS.ReportingName 
---@field Storage ENUMS.Storage 
---@field WeaponFlag ENUMS.WeaponFlag 
---@field WeaponType ENUMS.WeaponType 
ENUMS = {}


---Alarm state.
---@class ENUMS.AlarmState 
---@field Auto number AI will automatically switch alarm states based on the presence of threats. The AI kind of cheats in this regard.
---@field Green number Group is not combat ready. Sensors are stowed if possible.
---@field Red number Group is combat ready and actively searching for targets. Some groups like infantry will not move in this state.
ENUMS.AlarmState = {}


---@class ENUMS.FARPObjectTypeNamesAndShape 
---@field FARP string 
---@field HELIPADSINGLE string 
---@field INVISIBLE string 
---@field PADSINGLE string 
ENUMS.FARPObjectTypeNamesAndShape = {}


---@class ENUMS.FARPType 
---@field FARP string 
---@field HELIPADSINGLE string 
---@field INVISIBLE string 
---@field PADSINGLE string 
ENUMS.FARPType = {}


---Formations (new).
---See the [Formations](https://wiki.hoggitworld.com/view/DCS_enum_formation) on hoggit wiki.
---@class ENUMS.Formation 
---@field FixedWing table 
---@field RotaryWing table 
---@field Vehicle table 
ENUMS.Formation = {}


---Formations (old).
---The old format is a simplified version of the new formation enums, which allow more sophisticated settings.
---See the [Formations](https://wiki.hoggitworld.com/view/DCS_enum_formation) on hoggit wiki.
---@class ENUMS.FormationOld 
---@field FixedWing table 
---@field RotaryWing table 
ENUMS.FormationOld = {}


---ISO (639-1) 2-letter Language Codes.
---See the [Wikipedia](https://en.wikipedia.org/wiki/List_of_ISO_639-1_codes).
---@class ENUMS.ISOLang 
---@field Arabic string 
---@field Chinese string 
---@field English string 
---@field French string 
---@field German string 
---@field Italian string 
---@field Japanese string 
---@field Russian string 
---@field Spanish string 
ENUMS.ISOLang = {}


---Enums for Link16 transmit power
---@class ENUMS.Link16Power 
---@field private high number 
---@field private low number 
---@field private medium number 
---@field private none number 
ENUMS.Link16Power = {}


---Mission tasks.
---@class ENUMS.MissionTask 
---@field AFAC string Forward Air Controller Air. Can perform the tasks: Attack Group, Attack Unit, FAC assign group, Bombing, Attack Map Object.
---@field ANTISHIPSTRIKE string Naval ops. Can perform the tasks: Attack Group, Attack Unit.
---@field AWACS string AWACS.
---@field CAP string Combat Air Patrol.
---@field CAS string Close Air Support.
---@field ESCORT string Escort another group.
---@field FIGHTERSWEEP string Fighter sweep.
---@field GROUNDATTACK string Ground attack.
---@field GROUNDESCORT string Ground escort another group.
---@field INTERCEPT string Intercept.
---@field NOTHING string No special task. Group can perform the minimal tasks: Orbit, Refuelling, Follow and Aerobatics.
---@field PINPOINTSTRIKE string Pinpoint strike.
---@field RECONNAISSANCE string Reconnaissance mission.
---@field REFUELING string Refueling mission.
---@field RUNWAYATTACK string Attack the runway of an airdrome.
---@field SEAD string Suppression of Enemy Air Defenses.
---@field TRANSPORT string Troop transport.
ENUMS.MissionTask = {}


---Morse Code.
---See the [Wikipedia](https://en.wikipedia.org/wiki/Morse_code).
---
---* Short pulse "*"
---* Long pulse "-"
---
---Pulses are separated by a blank character " ".
---@class ENUMS.Morse 
---@field   string 
---@field A string 
---@field B string 
---@field C string 
---@field D string 
---@field E string 
---@field F string 
---@field G string 
---@field H string 
---@field I string 
---@field J string 
---@field K string 
---@field L string 
---@field M string 
---@field N string 
---@field N0 string 
---@field N1 string 
---@field N2 string 
---@field N3 string 
---@field N4 string 
---@field N5 string 
---@field N6 string 
---@field N7 string 
---@field N8 string 
---@field N9 string 
---@field O string 
---@field P string 
---@field Q string 
---@field R string 
---@field S string 
---@field T string 
---@field U string 
---@field V string 
---@field W string 
---@field X string 
---@field Y string 
---@field Z string 
ENUMS.Morse = {}


---Phonetic Alphabet (NATO).
---See the [Wikipedia](https://en.wikipedia.org/wiki/NATO_phonetic_alphabet).
---@class ENUMS.Phonetic 
---@field A string 
---@field B string 
---@field C string 
---@field D string 
---@field E string 
---@field F string 
---@field G string 
---@field H string 
---@field I string 
---@field J string 
---@field K string 
---@field L string 
---@field M string 
---@field N string 
---@field O string 
---@field P string 
---@field Q string 
---@field R string 
---@field S string 
---@field T string 
---@field U string 
---@field V string 
---@field W string 
---@field X string 
---@field Y string 
---@field Z string 
ENUMS.Phonetic = {}


---Rules of Engagement.
---@class ENUMS.ROE 
---@field OpenFire number [AIR, GROUND, NAVAL] AI will engage only targets specified in its taskings.
---@field OpenFireWeaponFree number [AIR] AI will engage any enemy group it detects, but will prioritize targets specified in the groups tasking.
---@field ReturnFire number [AIR, GROUND, NAVAL] AI will only engage threats that shoot first.
---@field WeaponFree number [AIR] AI will engage any enemy group it detects. Target prioritization is based based on the threat of the target.
---@field WeaponHold number [AIR, GROUND, NAVAL] AI will hold fire under all circumstances.
ENUMS.ROE = {}


---Reaction On Threat.
---@class ENUMS.ROT 
---@field AllowAbortMission number If a threat is deemed severe enough the AI will abort its mission and return to base.
---@field BypassAndEscape number AI will attempt to avoid enemy threat zones all together. This includes attempting to fly above or around threats.
---@field EvadeFire number AI will react by performing defensive maneuvers against incoming threats. AI will also use passive defense.
---@field NoReaction number No defensive actions will take place to counter threats.
---@field PassiveDefense number AI will use jammers and other countermeasures in an attempt to defeat the threat. AI will not attempt a maneuver to defeat a threat.
ENUMS.ROT = {}


---Reporting Names (NATO).
---See the [Wikipedia](https://en.wikipedia.org/wiki/List_of_NATO_reporting_names_for_fighter_aircraft).
---DCS known aircraft types
---@class ENUMS.ReportingName 
---@field NATO table 
ENUMS.ReportingName = {}


---Enums for the STORAGE class for stores - which need to be in ""
---@class ENUMS.Storage 
---@field private weapons table 
ENUMS.Storage = {}


---Weapon types.
---See the [Weapon Flag](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag) enumerotor on hoggit wiki.
---@class ENUMS.WeaponFlag 
---@field AR_AAM number 
---@field AntiRadarMissile number 
---@field AntiRadarMissile2 number 
---@field AntiShipMissile number 
---@field AntiTankMissile number 
---@field AnyAA number 
---@field AnyAAM number 
---@field AnyAG number 
---@field AnyASM number 
---@field AnyASM2 number 
---@field AnyAutonomousMissile number 
---@field AnyBomb number 
---@field AnyGuided number 
---@field AnyMissile number 
---@field AnyRocket number 
---@field AnyUnguided number 
---@field AnyUnguidedBomb number 
---@field Auto number Even More Genral  
---@field AutoDCS number 
---@field BuiltInCannon number 
---@field CandleBomb number 
---@field CandleRocket number 
---@field Cannons number 
---@field ClusterBomb number 
---@field CruiseMissile number 
---@field Dispencer number 
---@field FAEBomb number 
---@field FireAndForgetASM number 
---@field GuidedASM number 
---@field GuidedBomb number Combinations

Bombs
---@field GunPod number Guns
---@field HEBomb number 
---@field HeavyRocket number 
---@field IR_AAM number 
---@field LGB number 
---@field LRAAM number 
---@field LaserASM number 
---@field LightRocket number 
---@field MRAAM number 
---@field MarkerRocket number 
---@field NapalmBomb number 
---@field ParachuteBomb number 
---@field Penetrator number 
---@field SAR_AAM number 
---@field SNSGB number 
---@field SRAM number 
---@field TacticalASM number 
---@field TeleASM number 
---@field Torpedo number 
---@field TvGB number 
ENUMS.WeaponFlag = {}


---Weapon types by category.
---See the [Weapon Flag](https://wiki.hoggitworld.com/view/DCS_enum_weapon_flag) enumerator on hoggit wiki.
---@class ENUMS.WeaponType 
---@field AAM table Air-to-Air missiles.
---@field Any table Combinations.
---@field Bomb table Bombs.
---@field Gun table Guns.
---@field Missile table Missiles.
---@field Rocket table Rocket.
---@field Torpedo table Torpedos.
ENUMS.WeaponType = {}



