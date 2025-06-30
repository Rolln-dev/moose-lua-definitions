---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/OPS_CTLD.jpg" width="100%">
---
---**Ops** - Combat Troops & Logistics Department.
---
---===
---
---**CTLD** - MOOSE based Helicopter CTLD Operations.
---
---===
---
---## Missions:
---
---### [CTLD - Combat Troop & Logistics Deployment](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Ops/CTLD)
---
---===
---
---**Main Features:**
---
---   * MOOSE-based Helicopter CTLD Operations for Players.
---
---===
---
---### Author: **Applevangelist** (Moose Version), ***Ciribob*** (original), Thanks to: Shadowze, Cammel (testing), bbirchnz (additional code!!)
---### Repack addition for crates: **Raiden**
---### Additional cool features: **Lekaa**
---*Combat Troop & Logistics Deployment (CTLD): Everyone wants to be a POG, until there\'s POG stuff to be done.* (Mil Saying)
---
---===
---
---![Banner Image](../Images/OPS_CTLD.jpg)
---
---# CTLD Concept
---
--- * MOOSE-based CTLD for Players.
--- * Object oriented refactoring of Ciribob\'s fantastic CTLD script.
--- * No need for extra MIST loading. 
--- * Additional events to tailor your mission.
--- * ANY late activated group can serve as cargo, either as troops, crates, which have to be build on-location, or static like ammo chests.
--- * Option to persist (save&load) your dropped troops, crates and vehicles.
--- * Weight checks on loaded cargo.
---
---## 0. Prerequisites
---
---You need to load an .ogg soundfile for the pilot\'s beacons into the mission, e.g. "beacon.ogg", use a once trigger, "sound to country" for that.
---Create the late-activated troops, vehicles, that will make up your deployable forces.
---
---Example sound files are here: [Moose Sound](https://github.com/FlightControl-Master/MOOSE_SOUND/tree/master/CTLD%20CSAR)
---
---## 1. Basic Setup
---
---## 1.1 Create and start a CTLD instance
---
---A basic setup example is the following:
---       
---       -- Instantiate and start a CTLD for the blue side, using helicopter groups named "Helicargo" and alias "Lufttransportbrigade I"
---       local my_ctld = CTLD:New(coalition.side.BLUE,{"Helicargo"},"Lufttransportbrigade I")
---       my_ctld:__Start(5)
---
---## 1.2 Add cargo types available
---       
---Add *generic* cargo types that you need for your missions, here infantry units, vehicles and a FOB. These need to be late-activated Wrapper.Group#GROUP objects:
---       
---       -- add infantry unit called "Anti-Tank Small" using template "ATS", of type TROOP with size 3
---       -- infantry units will be loaded directly from LOAD zones into the heli (matching number of free seats needed)
---       my_ctld:AddTroopsCargo("Anti-Tank Small",{"ATS"},CTLD_CARGO.Enum.TROOPS,3)
---       -- if you want to add weight to your Heli, troops can have a weight in kg **per person**. Currently no max weight checked. Fly carefully.
---       my_ctld:AddTroopsCargo("Anti-Tank Small",{"ATS"},CTLD_CARGO.Enum.TROOPS,3,80)
---       
---       -- add infantry unit called "Anti-Tank" using templates "AA" and "AA"", of type TROOP with size 4. No weight. We only have 2 in stock:
---       my_ctld:AddTroopsCargo("Anti-Air",{"AA","AA2"},CTLD_CARGO.Enum.TROOPS,4,nil,2)
---       
---       -- add an engineers unit called "Wrenches" using template "Engineers", of type ENGINEERS with size 2. Engineers can be loaded, dropped,
---       -- and extracted like troops. However, they will seek to build and/or repair crates found in a given radius. Handy if you can\'t stay
---       -- to build or repair or under fire.
---       my_ctld:AddTroopsCargo("Wrenches",{"Engineers"},CTLD_CARGO.Enum.ENGINEERS,4)
---       myctld.EngineerSearch = 2000 -- teams will search for crates in this radius.
---       
---       -- add vehicle called "Humvee" using template "Humvee", of type VEHICLE, size 2, i.e. needs two crates to be build
---       -- vehicles and FOB will be spawned as crates in a LOAD zone first. Once transported to DROP zones, they can be build into the objects
---       my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2)
---       -- if you want to add weight to your Heli, crates can have a weight in kg **per crate**. Fly carefully.
---       my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2,2775)
---       -- if you want to limit your stock, add a number (here: 10) as parameter after weight. No parameter / nil means unlimited stock.
---       my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2,2775,10)
---       -- additionally, you can limit **where** the stock is available (one location only!) - this one is available in a zone called "Vehicle Store".
---       my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2,2775,10,nil,nil,"Vehicle Store")
---       
---       -- add infantry unit called "Forward Ops Base" using template "FOB", of type FOB, size 4, i.e. needs four crates to be build:
---       my_ctld:AddCratesCargo("Forward Ops Base",{"FOB"},CTLD_CARGO.Enum.FOB,4)
---       
---       -- add crates to repair FOB or VEHICLE type units - the 2nd parameter needs to match the template you want to repair,
---       -- e.g. the "Humvee" here refers back to the "Humvee" crates cargo added above (same template!)
---       my_ctld:AddCratesRepair("Humvee Repair","Humvee",CTLD_CARGO.Enum.REPAIR,1)
---       my_ctld.repairtime = 300 -- takes 300 seconds to repair something
---
---       -- add static cargo objects, e.g ammo chests - the name needs to refer to a STATIC object in the mission editor, 
---       -- here: it\'s the UNIT name (not the GROUP name!), the second parameter is the weight in kg.
---       my_ctld:AddStaticsCargo("Ammunition",500)
---       
---## 1.3 Add logistics zones
--- 
--- Add (normal, round!)  zones for loading troops and crates and dropping, building crates
--- 
---       -- Add a zone of type LOAD to our setup. Players can load any troops and crates here as defined in 1.2 above.
---       -- "Loadzone" is the name of the zone from the ME. Players can load, if they are inside the zone.
---       -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
---       my_ctld:AddCTLDZone("Loadzone",CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
---       
---       -- Add a zone of type DROP. Players can drop crates here.
---       -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
---       -- NOTE: Troops can be unloaded anywhere, also when hovering in parameters.
---       my_ctld:AddCTLDZone("Dropzone",CTLD.CargoZoneType.DROP,SMOKECOLOR.Red,true,true)
---       
---       -- Add two zones of type MOVE. Dropped troops and vehicles will move to the nearest one. See options.
---       -- Smoke and Flare color for this zone is blue, it is active (can be used) and has a radio beacon.
---       my_ctld:AddCTLDZone("Movezone",CTLD.CargoZoneType.MOVE,SMOKECOLOR.Orange,false,false)
---       
---       my_ctld:AddCTLDZone("Movezone2",CTLD.CargoZoneType.MOVE,SMOKECOLOR.White,true,true)
---       
---       -- Add a zone of type SHIP to our setup. Players can load troops and crates from this ship
---       -- "Tarawa" is the unitname (callsign) of the ship from the ME. Players can load, if they are inside the zone.
---       -- The ship is 240 meters long and 20 meters wide.
---       -- Note that you need to adjust the max hover height to deck height plus 5 meters or so for loading to work.
---       -- When the ship is moving, avoid forcing hoverload.
---       my_ctld:AddCTLDZone("Tarawa",CTLD.CargoZoneType.SHIP,SMOKECOLOR.Blue,true,true,240,20)
---
---## 2. Options
---
---The following options are available (with their defaults). Only set the ones you want changed:
---
---         my_ctld.useprefix = true -- (DO NOT SWITCH THIS OFF UNLESS YOU KNOW WHAT YOU ARE DOING!) Adjust **before** starting CTLD. If set to false, *all* choppers of the coalition side will be enabled for CTLD.
---         my_ctld.CrateDistance = 35 -- List and Load crates in this radius only.
---         my_ctld.PackDistance = 35 -- Pack crates in this radius only
---         my_ctld.dropcratesanywhere = false -- Option to allow crates to be dropped anywhere.
---         my_ctld.dropAsCargoCrate = false -- Hercules only: Parachuted herc cargo is not unpacked automatically but placed as crate to be unpacked. Needs a cargo with the same name defined like the cargo that was dropped.
---         my_ctld.maximumHoverHeight = 15 -- Hover max this high to load in meters.
---         my_ctld.minimumHoverHeight = 4 -- Hover min this low to load in meters.
---         my_ctld.forcehoverload = true -- Crates (not: troops) can **only** be loaded while hovering.
---         my_ctld.hoverautoloading = true -- Crates in CrateDistance in a LOAD zone will be loaded automatically if space allows.
---         my_ctld.smokedistance = 2000 -- Smoke or flares can be request for zones this far away (in meters).
---         my_ctld.movetroopstowpzone = true -- Troops and vehicles will move to the nearest MOVE zone...
---         my_ctld.movetroopsdistance = 5000 -- .. but only if this far away (in meters)
---         my_ctld.smokedistance = 2000 -- Only smoke or flare zones if requesting player unit is this far away (in meters)
---         my_ctld.suppressmessages = false -- Set to true if you want to script your own messages.
---         my_ctld.repairtime = 300 -- Number of seconds it takes to repair a unit.
---         my_ctld.buildtime = 300 -- Number of seconds it takes to build a unit. Set to zero or nil to build instantly.
---         my_ctld.cratecountry = country.id.GERMANY -- ID of crates. Will default to country.id.RUSSIA for RED coalition setups.
---         my_ctld.allowcratepickupagain = true  -- allow re-pickup crates that were dropped.
---         my_ctld.enableslingload = false -- allow cargos to be slingloaded - might not work for all cargo types
---         my_ctld.pilotmustopendoors = false -- force opening of doors
---         my_ctld.SmokeColor = SMOKECOLOR.Red -- default color to use when dropping smoke from heli 
---         my_ctld.FlareColor = FLARECOLOR.Red -- color to use when flaring from heli
---         my_ctld.basetype = "container_cargo" -- default shape of the cargo container
---         my_ctld.droppedbeacontimeout = 600 -- dropped beacon lasts 10 minutes
---         my_ctld.usesubcats = false -- use sub-category names for crates, adds an extra menu layer in "Get Crates", useful if you have > 10 crate types.
---         my_ctld.placeCratesAhead = false -- place crates straight ahead of the helicopter, in a random way. If true, crates are more neatly sorted.
---         my_ctld.nobuildinloadzones = true -- forbid players to build stuff in LOAD zones if set to `true`
---         my_ctld.movecratesbeforebuild = true -- crates must be moved once before they can be build. Set to false for direct builds.
---         my_ctld.surfacetypes = {land.SurfaceType.LAND,land.SurfaceType.ROAD,land.SurfaceType.RUNWAY,land.SurfaceType.SHALLOW_WATER} -- surfaces for loading back objects.
---         my_ctld.nobuildmenu = false -- if set to true effectively enforces to have engineers build/repair stuff for you.
---         my_ctld.RadioSound = "beacon.ogg" -- -- this sound will be hearable if you tune in the beacon frequency. Add the sound file to your miz.
---         my_ctld.RadioSoundFC3 = "beacon.ogg" -- this sound will be hearable by FC3 users (actually all UHF radios); change to something like "beaconsilent.ogg" and add the sound file to your miz if you don't want to annoy FC3 pilots.
---         my_ctld.enableChinookGCLoading = true -- this will effectively suppress the crate load and drop for CTLD_CARGO.Enum.STATIC types for CTLD for the Chinook
---         my_ctld.TroopUnloadDistGround = 5 -- If hovering, spawn dropped troops this far away in meters from the helo
---         my_ctld.TroopUnloadDistHover = 1.5 -- If grounded, spawn dropped troops this far away in meters from the helo
---         my_ctld.TroopUnloadDistGroundHerc = 25 -- On the ground, unload troops this far behind the Hercules
---         my_ctld.TroopUnloadDistGroundHook = 15 -- On the ground, unload troops this far behind the Chinook
---         my_ctld.TroopUnloadDistHoverHook = 5 -- When hovering, unload troops this far behind the Chinook
---         my_ctld.showstockinmenuitems = false -- When set to true, the menu lines will also show the remaining items in stock (that is, if you set any), downside is that the menu for all will be build every 30 seconds anew.
---         my_ctld.onestepmenu = false -- When set to true, the menu will create Drop and build, Get and load, Pack and remove, Pack and load, Pack. it will be a 1 step solution.
---
---## 2.1 CH-47 Chinook support
---
---The Chinook comes with the option to use the ground crew menu to load and unload cargo into the Helicopter itself for better immersion. As well, it can sling-load cargo from ground. The cargo you can actually **create**
---from this menu is limited to contain items from the airbase or FARP's resources warehouse and can take a number of shapes (static shapes in the category of cargo) independent of their contents. If you unload this
---kind of cargo with the ground crew, the contents will be "absorbed" into the airbase or FARP you landed at, and the cargo static will be removed after ca 2 mins. 
---
---## 2.1.1 Moose CTLD created crate cargo
---
---Given the correct shape, Moose created cargo can theoretically be either loaded with the ground crew or via the F10 CTLD menu. **It is strongly stated to avoid using shapes with 
---CTLD which can be Ground Crew loaded.**
---Static shapes loadable *into* the Chinook and thus to **be avoided for CTLD** are at the time of writing:
---
---     * Ammo box (type "ammo_crate")
---     * M117 bomb crate (type name "m117_cargo")
---     * Dual shell fuel barrels (type name "barrels")
---     * UH-1H net (type name "uh1h_cargo")
---     
---All other kinds of cargo can be sling-loaded.
---     
---## 2.1.2 Recommended settings
---         
---         my_ctld.basetype = "container_cargo" -- **DO NOT** change this to a base type which could also be loaded by F8/GC to avoid logic problems!
---         my_ctld.forcehoverload = false -- no hover autoload, leads to cargo complications with ground crew created cargo items
---         my_ctld.pilotmustopendoors = true -- crew must open back loading door 50% (horizontal) or more - watch out for NOT adding a back door gunner!
---         my_ctld.enableslingload = true -- will set cargo items as sling-loadable.
---         my_ctld.enableChinookGCLoading = true -- this will effectively suppress the crate load and drop for CTLD_CARGO.Enum.STATIC types for CTLD for the Chinook.
---         my_ctld.movecratesbeforebuild = true -- leave as is at the pain of building crate still **inside** of the Hook.
---         my_ctld.nobuildinloadzones = true -- don't build where you load.
---         my_ctld.ChinookTroopCircleRadius = 5 -- Radius for troops dropping in a nice circle. Adjust to your planned squad size for the Chinook.
---         
---## 2.2 User functions
---
---### 2.2.1 Adjust or add chopper unit-type capabilities
--- 
---Use this function to adjust what a heli type can or cannot do:
---
---       -- E.g. update unit capabilities for testing. Please stay realistic in your mission design.
---       -- Make a Gazelle into a heavy truck, this type can load both crates and troops and eight of each type, up to 4000 kgs:
---       my_ctld:SetUnitCapabilities("SA342L", true, true, 8, 8, 12, 4000)
---       
---       -- Default unit type capabilities are: 
---       ["SA342Mistral"] = {type="SA342Mistral", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 12, cargoweightlimit = 400},
---       ["SA342L"] = {type="SA342L", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 12, cargoweightlimit = 400},
---       ["SA342M"] = {type="SA342M", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 12, cargoweightlimit = 400},
---       ["SA342Minigun"] = {type="SA342Minigun", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 12, cargoweightlimit = 400},
---       ["UH-1H"] = {type="UH-1H", crates=true, troops=true, cratelimit = 1, trooplimit = 8, length = 15, cargoweightlimit = 700},
---       ["Mi-8MT"] = {type="Mi-8MT", crates=true, troops=true, cratelimit = 2, trooplimit = 12, length = 15, cargoweightlimit = 3000},
---       ["Mi-8MTV2"] = {type="Mi-8MTV2", crates=true, troops=true, cratelimit = 2, trooplimit = 12, length = 15, cargoweightlimit = 3000},
---       ["Ka-50"] = {type="Ka-50", crates=false, troops=false, cratelimit = 0, trooplimit = 0, length = 15, cargoweightlimit = 0},
---       ["Mi-24P"] = {type="Mi-24P", crates=true, troops=true, cratelimit = 2, trooplimit = 8, length = 18, cargoweightlimit = 700},
---       ["Mi-24V"] = {type="Mi-24V", crates=true, troops=true, cratelimit = 2, trooplimit = 8, length = 18, cargoweightlimit = 700},
---       ["Hercules"] = {type="Hercules", crates=true, troops=true, cratelimit = 7, trooplimit = 64, length = 25, cargoweightlimit = 19000},
---       ["UH-60L"] = {type="UH-60L", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500},
---       ["AH-64D_BLK_II"] = {type="AH-64D_BLK_II", crates=false, troops=true, cratelimit = 0, trooplimit = 2, length = 17, cargoweightlimit = 200}, 
---       ["MH-60R"] = {type="MH-60R", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500}, -- 4t cargo, 20 (unsec) seats
---       ["SH-60B"] = {type="SH-60B", crates=true, troops=true, cratelimit = 2, trooplimit = 20, length = 16, cargoweightlimit = 3500}, -- 4t cargo, 20 (unsec) seats
---       ["Bronco-OV-10A"] = {type="Bronco-OV-10A", crates= false, troops=true, cratelimit = 0, trooplimit = 5, length = 13, cargoweightlimit = 1450},
---       ["OH-6A"] = {type="OH-6A", crates=false, troops=true, cratelimit = 0, trooplimit = 4, length = 7, cargoweightlimit = 550},
---       ["OH58D"] = {type="OH58D", crates=false, troops=false, cratelimit = 0, trooplimit = 0, length = 14, cargoweightlimit = 400},
---       ["CH-47Fbl1"] = {type="CH-47Fbl1", crates=true, troops=true, cratelimit = 4, trooplimit = 31, length = 20, cargoweightlimit = 8000},
---       
---### 2.2.2 Activate and deactivate zones
---
---Activate a zone:
---
---       -- Activate zone called Name of type #CTLD.CargoZoneType ZoneType:
---       my_ctld:ActivateZone(Name,CTLD.CargoZoneType.MOVE)
---
---Deactivate a zone:
---
---       -- Deactivate zone called Name of type #CTLD.CargoZoneType ZoneType:
---       my_ctld:DeactivateZone(Name,CTLD.CargoZoneType.DROP)
---
---## 2.2.3 Limit and manage available resources
--- 
--- When adding generic cargo types, you can effectively limit how many units can be dropped/build by the players, e.g.
--- 
---             -- if you want to limit your stock, add a number (here: 10) as parameter after weight. No parameter / nil means unlimited stock.
---             my_ctld:AddCratesCargo("Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,2,2775,10)
--- 
--- You can manually add or remove the available stock like so:
---           
---             -- Crates
---             my_ctld:AddStockCrates("Humvee", 2)
---             my_ctld:RemoveStockCrates("Humvee", 2)
---             
---             -- Troops
---             my_ctld:AddStockTroops("Anti-Air", 2)
---             my_ctld:RemoveStockTroops("Anti-Air", 2)
--- 
--- Notes:
--- Troops dropped back into a LOAD zone will effectively be added to the stock. Crates lost in e.g. a heli crash are just that - lost.
--- 
---## 2.2.4 Create own SET_GROUP to manage CTLD Pilot groups
---
---             -- Parameter: Set The SET_GROUP object created by the mission designer/user to represent the CTLD pilot groups.
---             -- Needs to be set before starting the CTLD instance.
---             local myset = SET_GROUP:New():FilterPrefixes("Helikopter"):FilterCoalitions("red"):FilterStart()
---             my_ctld:SetOwnSetPilotGroups(myset)
---
---## 3. Events
---
--- The class comes with a number of FSM-based events that missions designers can use to shape their mission.
--- These are:
---
---## 3.1 OnAfterTroopsPickedUp
---
---  This function is called when a player has loaded Troops:
---
---       function my_ctld:OnAfterTroopsPickedUp(From, Event, To, Group, Unit, Cargo)
---         ... your code here ...
---       end
---
---## 3.2 OnAfterCratesPickedUp
---
---   This function is called when a player has picked up crates:
---
---       function my_ctld:OnAfterCratesPickedUp(From, Event, To, Group, Unit, Cargo)
---         ... your code here ...
---       end
--- 
---## 3.3 OnAfterTroopsDeployed
--- 
---   This function is called when a player has deployed troops into the field:
---
---       function my_ctld:OnAfterTroopsDeployed(From, Event, To, Group, Unit, Troops)
---         ... your code here ...
---       end
---       
---## 3.4 OnAfterTroopsExtracted
--- 
---   This function is called when a player has re-boarded already deployed troops from the field:
---
---       function my_ctld:OnAfterTroopsExtracted(From, Event, To, Group, Unit, Troops, Troopname)
---         ... your code here ...
---       end
--- 
---## 3.5 OnAfterCratesDropped
--- 
---   This function is called when a player has deployed crates:
---
---       function my_ctld:OnAfterCratesDropped(From, Event, To, Group, Unit, Cargotable)
---         ... your code here ...
---       end
---
---- ## 3.6 OnAfterHelicopterLost
--- 
---   This function is called when a player has deployed left a unit or crashed/died:
---
---       function my_ctld:OnAfterHelicopterLost(From, Event, To, Unitname, Cargotable)
---         ... your code here ...
---       end  
--- 
---## 3.6 OnAfterCratesBuild, OnAfterCratesRepaired
--- 
---   This function is called when a player has build a vehicle or FOB:
---
---       function my_ctld:OnAfterCratesBuild(From, Event, To, Group, Unit, Vehicle)
---         ... your code here ...
---       end
---       
---       function my_ctld:OnAfterCratesRepaired(From, Event, To, Group, Unit, Vehicle)
---         ... your code here ...
---       end
--- 
---## 3.7 A simple SCORING example:
--- 
---   To award player with points, using the SCORING Class (SCORING: my_Scoring, CTLD: CTLD_Cargotransport)
---
---       my_scoring = SCORING:New("Combat Transport")
---
---       function CTLD_Cargotransport:OnAfterCratesDropped(From, Event, To, Group, Unit, Cargotable)
---           local points = 10
---           if Unit then
---             local PlayerName = Unit:GetPlayerName()
---             my_scoring:_AddPlayerFromUnit( Unit )
---             my_scoring:AddGoalScore(Unit, "CTLD", string.format("Pilot %s has been awarded %d points for transporting cargo crates!", PlayerName, points), points)
---           end
---       end
---       
---       function CTLD_Cargotransport:OnAfterCratesBuild(From, Event, To, Group, Unit, Vehicle)
---         local points = 5
---         if Unit then
---         local PlayerName = Unit:GetPlayerName()
---         my_scoring:_AddPlayerFromUnit( Unit )
---         my_scoring:AddGoalScore(Unit, "CTLD", string.format("Pilot %s has been awarded %d points for the construction of Units!", PlayerName, points), points)
---         end
---        end
--- 
---## 4. F10 Menu structure
---
---CTLD management menu is under the F10 top menu and called "CTLD"
---
---## 4.1 Manage Crates
---
---Use this entry to get, load, list nearby, drop, build and repair crates. Also see options.
---
---## 4.2 Manage Troops
---
---Use this entry to load, drop and extract troops. NOTE - with extract you can only load troops from the field that were deployed prior. 
---Currently limited CTLD_CARGO troops, which are build from **one** template. Also, this will heal/complete your units as they are respawned.
---
---## 4.3 List boarded cargo
---
---Lists what you have loaded. Shows load capabilities for number of crates and number of seats for troops.
---
---## 4.4 Smoke & Flare zones nearby or drop smoke, beacon or flare from Heli
---
---Does what it says.
---
---## 4.5 List active zone beacons
---
---Lists active radio beacons for all zones, where zones are both active and have a beacon. @see `CTLD:AddCTLDZone()`
---
---## 4.6 Show hover parameters
---
---Lists hover parameters and indicates if these are curently fulfilled. Also @see options on hover heights.
---
---## 4.7 List Inventory
---
---Lists inventory of available units to drop or build.
---
---## 5. Support for fixed wings
---
---Basic support for the Hercules mod By Anubis has been build into CTLD, as well as Bronco and Mosquito - that is you can load/drop/build the same way and for the same objects as 
---the helicopters (main method). 
---To cover objects and troops which can be loaded from the groud crew Rearm/Refuel menu (F8), you need to use #CTLD_HERCULES.New() and link
---this object to your CTLD setup (alternative method). In this case, do **not** use the `Hercules_Cargo.lua` or `Hercules_Cargo_CTLD.lua` which are part of the mod 
---in your mission!
---
---### 5.1 Create an own CTLD instance and allow the usage of the Hercules mod (main method)
---
---             local my_ctld = CTLD:New(coalition.side.BLUE,{"Helicargo", "Hercules"},"Lufttransportbrigade I")
---
---Enable these options for Hercules support:
--- 
---             my_ctld.enableFixedWing = true
---             my_ctld.FixedMinAngels = 155 -- for troop/cargo drop via chute in meters, ca 470 ft
---             my_ctld.FixedMaxAngels = 2000 -- for troop/cargo drop via chute in meters, ca 6000 ft
---             my_ctld.FixedMaxSpeed = 77 -- 77mps or 270kph or 150kn
---
---Hint: you can **only** airdrop from the Hercules if you are "in parameters", i.e. at or below `FixedMaxSpeed` and in the AGLFixedMinAngelseen
---`FixedMinAngels` and `FixedMaxAngels`!
---
---Also, the following options need to be set to `true`:
---
---             my_ctld.useprefix = true -- this is true by default and MUST BE ON. 
---
---### 5.2 Integrate Hercules ground crew (F8 Menu) loadable objects (alternative method, use either the above OR this method, NOT both!)
---
---Taking another approach, integrate to your CTLD instance like so, where `my_ctld` is a previously created CTLD instance:
---           
---           my_ctld.enableFixedWing = false -- avoid dual loading via CTLD F10 and F8 ground crew
---           local herccargo = CTLD_HERCULES:New("blue", "Hercules Test", my_ctld)
---           
---You also need: 
---
---* A template called "Infantry" for 10 Paratroopers (as set via herccargo.infantrytemplate).   
---* Depending on what you are loading with the help of the ground crew, there are 42 more templates for the various vehicles that are loadable.   
---
---There's a **quick check output in the `dcs.log`** which tells you what's there and what not.
---E.g.:   
---
---           ...Checking template for APC BTR-82A Air [24998lb] (BTR-82A) ... MISSING)   
---           ...Checking template for ART 2S9 NONA Skid [19030lb] (SAU 2-C9) ... MISSING)   
---           ...Checking template for EWR SBORKA Air [21624lb] (Dog Ear radar) ... MISSING)   
---           ...Checking template for Transport Tigr Air [15900lb] (Tigr_233036) ... OK)   
---
---Expected template names are the ones in the rounded brackets.
---
---### 5.2.1 Hints
---
---The script works on the EVENTS.Shot trigger, which is used by the mod when you **drop cargo from the Hercules while flying**. Unloading on the ground does
---not achieve anything here. If you just want to unload on the ground, use the normal Moose CTLD (see 5.1).
---
---DO NOT use the "splash damage" script together with this method! Your cargo will explode on the ground!
---
---There are two ways of airdropping: 
---  
---1) Very low and very slow (>5m and <10m AGL) - here you can drop stuff which has "Skid" at the end of the cargo name (loaded via F8 Ground Crew menu)   
---2) Higher up and slow (>100m AGL) - here you can drop paratroopers and cargo which has "Air" at the end of the cargo name (loaded via F8 Ground Crew menu)   
---
---Standard transport capabilities as per the real Hercules are:
---
---              ["Hercules"] = {type="Hercules", crates=true, troops=true, cratelimit = 7, trooplimit = 64}, -- 19t cargo, 64 paratroopers
--- 
---### 5.3 Don't automatically unpack dropped cargo but drop as CTLD_CARGO
---
---Cargo can be defined to be automatically dropped as crates.
---             my_ctld.dropAsCargoCrate = true -- default is false
---
---The idea is, to have those crate behave like brought in with a helo. So any unpack restictions apply.
---To enable those cargo drops, the cargo types must be added manually in the CTLD configuration. So when the above defined template for "Vulcan" should be used
---as CTLD_Cargo, the following line has to be added. NoCrates, PerCrateMass, Stock, SubCategory can be configured freely.
---             my_ctld:AddCratesCargo("Vulcan",      {"Vulcan"}, CTLD_CARGO.Enum.VEHICLE, 6, 2000, nil, "SAM/AAA")
---
---So if the Vulcan in the example now needs six crates to complete, you have to bring two Hercs with three Vulcan crates each and drop them very close together...
---
---## 6. Save and load back units - persistance
---
---You can save and later load back units dropped or build to make your mission persistent.
---For this to work, you need to de-sanitize **io** and **lfs** in your MissionScripting.lua, which is located in your DCS installtion folder under Scripts.
---There is a risk involved in doing that; if you do not know what that means, this is possibly not for you.
---
---Use the following options to manage your saves:
---
---             my_ctld.enableLoadSave = true -- allow auto-saving and loading of files
---             my_ctld.saveinterval = 600 -- save every 10 minutes
---             my_ctld.filename = "missionsave.csv" -- example filename
---             my_ctld.filepath = "C:\\Users\\myname\\Saved Games\\DCS\Missions\\MyMission" -- example path
---             my_ctld.eventoninject = true -- fire OnAfterCratesBuild and OnAfterTroopsDeployed events when loading (uses Inject functions)
---             my_ctld.useprecisecoordloads = true -- Instead if slightly varyiing the group position, try to maintain it as is
--- 
--- Then use an initial load at the beginning of your mission:
--- 
---           my_ctld:__Load(10)
---           
---**Caveat:**
---If you use units build by multiple templates, they will effectively double on loading. Dropped crates are not saved. Current stock is not saved.
---
---## 7. Complex example - Build a complete FARP from a CTLD crate drop
---
---Prerequisites - you need to add a cargo of type FOB to your CTLD instance, for simplification reasons we call it FOB:
---
---           my_ctld:AddCratesCargo("FARP",{"FOB"},CTLD_CARGO.Enum.FOB,2)
---           
---The following code will build a FARP at the coordinate the FOB was dropped and built (the UTILS function used below **does not** need a template for the statics):
---           
---         -- FARP Radio. First one has 130AM name London, next 131 name Dallas, and so forth. 
---         local FARPFreq = 129
---         local FARPName = 1  --numbers 1..10
---
---         local FARPClearnames = {
---           [1]="London",
---           [2]="Dallas",
---           [3]="Paris",
---           [4]="Moscow",
---           [5]="Berlin",
---           [6]="Rome",
---           [7]="Madrid",
---           [8]="Warsaw",
---           [9]="Dublin",
---           [10]="Perth",
---           }
---
---         function BuildAFARP(Coordinate)
---           local coord = Coordinate  --Core.Point#COORDINATE
---
---           local FarpNameNumber = ((FARPName-1)%10)+1 -- make sure 11 becomes 1 etc
---           local FName = FARPClearnames[FarpNameNumber] -- get clear namee
--- 
---           FARPFreq = FARPFreq + 1
---           FARPName = FARPName + 1
--- 
---           FName = FName .. " FAT COW "..tostring(FARPFreq).."AM" -- make name unique
--- 
---           -- Get a Zone for loading 
---           local ZoneSpawn = ZONE_RADIUS:New("FARP "..FName,Coordinate:GetVec2(),150,false)
--- 
---           -- Spawn a FARP with our little helper and fill it up with resources (10t fuel each type, 10 pieces of each known equipment)
---           UTILS.SpawnFARPAndFunctionalStatics(FName,Coordinate,ENUMS.FARPType.INVISIBLE,my_ctld.coalition,country.id.USA,FarpNameNumber,FARPFreq,radio.modulation.AM,nil,nil,nil,10,10)
---
---           -- add a loadzone to CTLD
---           my_ctld:AddCTLDZone("FARP "..FName,CTLD.CargoZoneType.LOAD,SMOKECOLOR.Blue,true,true)
---           local m  = MESSAGE:New(string.format("FARP %s in operation!",FName),15,"CTLD"):ToBlue() 
---         end
---
---         function my_ctld:OnAfterCratesBuild(From,Event,To,Group,Unit,Vehicle)
---           local name = Vehicle:GetName()
---           if string.find(name,"FOB",1,true) then
---             local Coord = Vehicle:GetCoordinate()
---             Vehicle:Destroy(false)
---             BuildAFARP(Coord) 
---           end
---         end
---
---## 8. Transport crates and troops with CA (Combined Arms) trucks
---
---You can optionally also allow to CTLD with CA trucks and other vehicles:
---
---         -- Create a SET_CLIENT to capture CA vehicles steered by players
---         local truckers = SET_CLIENT:New():HandleCASlots():FilterCoalitions("blue"):FilterPrefixes("Truck"):FilterStart()
---         -- Allow CA transport
---         my_ctld:AllowCATransport(true,truckers)
---         -- Set truck capability by typename
---         my_ctld:SetUnitCapabilities("M 818", true, true, 2, 12, 9, 4500)
---         -- Alternatively set truck capability with a UNIT object
---         local GazTruck = UNIT:FindByName("GazTruck-1-1")
---         my_ctld:SetUnitCapabilities(GazTruck, true, true, 2, 12, 9, 4500)
---- **CTLD** class, extends Core.Base#BASE, Core.Fsm#FSM
---@class CTLD : FSM
---@field CATransportSet SET_CLIENT 
---@field ChinookTroopCircleRadius number 
---@field ClassName string Name of the class.
---@field CrateDistance number 
---@field CtldUnits  
---@field DroppedTroops  
---@field EngineerSearch number 
---@field EngineersInField  
---@field ExtractFactor number 
---@field FixedMaxAngels number 
---@field FixedMaxSpeed number 
---@field FixedMinAngels number 
---@field FlareColor  
---@field FreeFMFrequencies  
---@field PackDistance number 
---@field PlayerTaskQueue  
---@field RadioPath  
---@field RadioSound string 
---@field RadioSoundFC3 string 
---@field SmokeColor  
---@field UserSetGroup  
---@field alias  
---@field allowCATransport boolean 
---@field allowcratepickupagain boolean 
---@field basetype string 
---@field buildtime number 
---@field coalition number Coalition side number, e.g. `coalition.side.RED`.
---@field coalitiontxt  
---@field cratecountry  
---@field debug boolean 
---@field dropAsCargoCrate boolean 
---@field dropcratesanywhere boolean 
---@field droppedbeacontimeout number 
---@field enableChinookGCLoading boolean 
---@field enableFixedWing boolean 
---@field enableHercules boolean 
---@field enableLoadSave boolean 
---@field enableslingload boolean 
---@field eventoninject boolean 
---@field filename  
---@field forcehoverload boolean 
---@field hoverautoloading boolean 
---@field keeploadtable boolean 
---@field lid string Class id string for output to DCS log file.
---@field maximumHoverHeight number 
---@field minimumHoverHeight number 
---@field movecratesbeforebuild boolean 
---@field movetroopsdistance number 
---@field movetroopstowpzone boolean 
---@field nobuildinloadzones boolean 
---@field nobuildmenu boolean 
---@field pilotmustopendoors boolean 
---@field placeCratesAhead boolean 
---@field repairtime number 
---@field saveinterval number 
---@field showstockinmenuitems boolean 
---@field smokedistance number 
---@field suppressmessages boolean 
---@field troopdropzoneradius  
---@field useprecisecoordloads boolean 
---@field useprefix boolean 
---@field usesubcats boolean 
---@field verbose number Verbosity level.
---@field version string CTLD class version.
CTLD = {}

---User function - Activate Name #CTLD.CargoZone.Type ZoneType for this CTLD instance.
---
------
---@param self CTLD 
---@param Name string Name of the zone to change in the ME.
---@param ZoneType CTLD.CargoZoneType Type of zone this belongs to.
---@param NewState boolean (Optional) Set to true to activate, false to switch off.
function CTLD:ActivateZone(Name, ZoneType, NewState) end

---(User) Add a new fixed wing type to the list of allowed types.
---
------
---@param self CTLD 
---@param typename string The typename to add. Can be handed as Wrapper.Unit#UNIT object. Do NOT forget to `myctld:SetUnitCapabilities()` for this type!
---@return CTLD #self
function CTLD:AddAllowedFixedWingType(typename) end

---User function - Creates and adds a #CTLD.CargoZone zone for this CTLD instance.
--- Zones of type LOAD: Players load crates and troops here.  
--- Zones of type DROP: Players can drop crates here. Note that troops can be unloaded anywhere.  
--- Zone of type MOVE: Dropped troops and vehicles will start moving to the nearest zone of this type (also see options).
---
------
---@param self CTLD 
---@param Name string Name of this zone, as in Mission Editor.
---@param Type string Type of this zone, #CTLD.CargoZoneType
---@param Color number Smoke/Flare color e.g. #SMOKECOLOR.Red
---@param Active string Is this zone currently active?
---@param HasBeacon string Does this zone have a beacon if it is active?
---@param Shiplength number Length of Ship for shipzones
---@param Shipwidth number Width of Ship for shipzones
---@return CTLD #self
function CTLD:AddCTLDZone(Name, Type, Color, Active, HasBeacon, Shiplength, Shipwidth) end

---User function - Creates and adds a #CTLD.CargoZone zone for this CTLD instance from an Airbase or FARP name.
--- Zones of type LOAD: Players load crates and troops here.  
--- Zones of type DROP: Players can drop crates here. Note that troops can be unloaded anywhere.  
--- Zone of type MOVE: Dropped troops and vehicles will start moving to the nearest zone of this type (also see options).
---
------
---@param self CTLD 
---@param AirbaseName string Name of the Airbase, can be e.g. AIRBASE.Caucasus.Beslan or "Beslan". For FARPs, this will be the UNIT name.
---@param Type string Type of this zone, #CTLD.CargoZoneType
---@param Color number Smoke/Flare color e.g. #SMOKECOLOR.Red
---@param Active string Is this zone currently active?
---@param HasBeacon string Does this zone have a beacon if it is active?
---@return CTLD #self
function CTLD:AddCTLDZoneFromAirbase(AirbaseName, Type, Color, Active, HasBeacon) end

---User function - Add *generic* crate-type loadable as cargo.
---This type will create crates that need to be loaded, moved, dropped and built.
---
------
---@param self CTLD 
---@param Name string Unique name of this type of cargo. E.g. "Humvee".
---@param Templates table Table of #string names of late activated Wrapper.Group#GROUP building this cargo.
---@param Type CTLD_CARGO.Enum Type of cargo. I.e. VEHICLE or FOB. VEHICLE will move to destination zones when dropped/build, FOB stays put.
---@param NoCrates number Number of crates needed to build this cargo.
---@param PerCrateMass number Mass in kg of each crate
---@param Stock number Number of buildable groups in stock. Nil for unlimited.
---@param SubCategory string Name of sub-category (optional).
---@param DontShowInMenu boolean (optional) If set to "true" this won't show up in the menu.
---@param Location ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}.
---@param Category string Static category name (optional). If set, spawn cargo crate with an alternate category type, e.g. "Cargos".
---@param TypeName string Static type name (optional). If set, spawn cargo crate with an alternate type shape, e.g. "iso_container".
---@param ShapeName string Static shape name (optional). If set, spawn cargo crate with an alternate type sub-shape, e.g. "iso_container_cargo".
---@return CTLD #self
function CTLD:AddCratesCargo(Name, Templates, Type, NoCrates, PerCrateMass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, TypeName, ShapeName) end

---User function - Add *generic* repair crates loadable as cargo.
---This type will create crates that need to be loaded, moved, dropped and built.
---
------
---@param self CTLD 
---@param Name string Unique name of this type of cargo. E.g. "Humvee".
---@param Template string Template of VEHICLE or FOB cargo that this can repair. MUST be the same as given in `AddCratesCargo(..)`!
---@param Type CTLD_CARGO.Enum Type of cargo, here REPAIR.
---@param NoCrates number Number of crates needed to build this cargo.
---@param PerCrateMass number Mass in kg of each crate
---@param Stock number Number of groups in stock. Nil for unlimited.
---@param SubCategory string Name of the sub-category (optional).
---@param DontShowInMenu boolean (optional) If set to "true" this won't show up in the menu.
---@param Location ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@param UnitTypes string Unit type names (optional). If set, only these unit types can pick up the cargo, e.g. "UH-1H" or {"UH-1H","OH58D"}
---@param Category string Static category name (optional). If set, spawn cargo crate with an alternate category type, e.g. "Cargos".
---@param TypeName string Static type name (optional). If set, spawn cargo crate with an alternate type shape, e.g. "iso_container".
---@param ShapeName string Static shape name (optional). If set, spawn cargo crate with an alternate type sub-shape, e.g. "iso_container_cargo".
---@return CTLD #self
function CTLD:AddCratesRepair(Name, Template, Type, NoCrates, PerCrateMass, Stock, SubCategory, DontShowInMenu, Location, UnitTypes, Category, TypeName, ShapeName) end

---(User) Add a PLAYERTASK - FSM events will check success
---
------
---@param self CTLD 
---@param PlayerTask PLAYERTASK 
---@return CTLD #self
function CTLD:AddPlayerTask(PlayerTask) end

---User function - Add *generic* static-type loadable as cargo.
---This type will create cargo that needs to be loaded, moved and dropped.
---
------
---@param self CTLD 
---@param Name string Unique name of this type of cargo as set in the mission editor (note: UNIT name!), e.g. "Ammunition-1".
---@param Mass number Mass in kg of each static in kg, e.g. 100.
---@param Stock number Number of groups in stock. Nil for unlimited.
---@param SubCategory string Name of sub-category (optional).
---@param DontShowInMenu boolean (optional) If set to "true" this won't show up in the menu.
---@param Location ZONE (optional) If set, the cargo item is **only** available here. Can be a #ZONE object or the name of a zone as #string.
---@return CTLD_CARGO #CargoObject
function CTLD:AddStaticsCargo(Name, Mass, Stock, SubCategory, DontShowInMenu, Location) end

---User - function to add stock of a certain crates type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:AddStockCrates(Name, Number) end

---User - function to add stock of a certain crates type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:AddStockStatics(Name, Number) end

---User - function to add stock of a certain troops type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:AddStockTroops(Name, Number) end

---User function - Add *generic* troop type loadable as cargo.
---This type will load directly into the heli without crates.
---
------
---@param self CTLD 
---@param Name string Unique name of this type of troop. E.g. "Anti-Air Small".
---@param Templates table Table of #string names of late activated Wrapper.Group#GROUP making up this troop.
---@param Type CTLD_CARGO.Enum Type of cargo, here TROOPS - these will move to a nearby destination zone when dropped/build.
---@param NoTroops number Size of the group in number of Units across combined templates (for loading).
---@param PerTroopMass number Mass in kg of each soldier
---@param Stock number Number of groups in stock. Nil for unlimited.
---@param SubCategory string Name of sub-category (optional).
function CTLD:AddTroopsCargo(Name, Templates, Type, NoTroops, PerTroopMass, Stock, SubCategory) end

---User function - Add a #CTLD.CargoZoneType zone for this CTLD instance.
---
------
---@param self CTLD 
---@param Zone CTLD.CargoZone Zone #CTLD.CargoZone describing the zone.
function CTLD:AddZone(Zone) end

---(User) Function to allow transport via Combined Arms Trucks.
---
------
---@param self CTLD 
---@param OnOff boolean Switch on (true) or off (false).
---@param ClientSet SET_CLIENT The CA handling client set for ground transport.
---@return CTLD #self
function CTLD:AllowCATransport(OnOff, ClientSet) end

---(Internal) Autoload if we can do crates, have capacity free and are in a load zone.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return CTLD #self
function CTLD:AutoHoverLoad(Unit) end

---(Internal) Check if a unit is in a load zone and is hovering in parameters.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:CanHoverLoad(Unit) end

---(Internal) Run through all pilots and see if we autoload.
---
------
---@param self CTLD 
---@return CTLD #self
function CTLD:CheckAutoHoverload() end

---(Internal) Housekeeping dropped beacons.
---
------
---@param self CTLD 
---@return CTLD #self
function CTLD:CheckDroppedBeacons() end

---(Internal) Run through DroppedTroops and capture alive units
---
------
---@param self CTLD 
---@return CTLD #self
function CTLD:CleanDroppedTroops() end

---User function - Deactivate Name #CTLD.CargoZoneType ZoneType for this CTLD instance.
---
------
---@param self CTLD 
---@param Name string Name of the zone to change in the ME.
---@param ZoneType CTLD.CargoZoneType Type of zone this belongs to.
function CTLD:DeactivateZone(Name, ZoneType) end

---(Internal) Function to create a dropped beacon
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return CTLD #self
function CTLD:DropBeaconNow(Unit) end

---(User) Get a generic #CTLD_CARGO entry from a group name, works for Troops and Vehicles, FOB, i.e.
---everything that is spawned as a GROUP object.
---
------
---@param self CTLD 
---@param GroupName string The name to use for the search
---@return CTLD_CARGO #The cargo object or nil if not found
function CTLD:GetGenericCargoObjectFromGroupName(GroupName) end

---User - Query the cargo loaded from a specific unit
---
------
---@param self CTLD 
---@param Unit UNIT The (client) unit to query.
---@return number #Troopsloaded
---@return number #Cratesloaded
---@return table #Cargo Table of #CTLD_CARGO objects
function CTLD:GetLoadedCargo(Unit) end

---User function - Get a *generic* static-type loadable as #CTLD_CARGO object.
---
------
---@param self CTLD 
---@param Name string Unique Unit(!) name of this type of cargo as set in the mission editor (not: GROUP name!), e.g. "Ammunition-1".
---@param Mass number Mass in kg of each static in kg, e.g. 100.
---@return CTLD_CARGO #Cargo object
function CTLD:GetStaticsCargoFromTemplate(Name, Mass) end

---User - function to get a table of crates in stock
---
------
---@param self CTLD 
---@return table #Table Table of Stock, indexed by cargo type name
function CTLD:GetStockCrates() end

---User - function to get a table of statics cargo in stock
---
------
---@param self CTLD 
---@return table #Table Table of Stock, indexed by cargo type name
function CTLD:GetStockStatics() end

---User - function to get a table of troops in stock
---
------
---@param self CTLD 
---@return table #Table Table of Stock, indexed by cargo type name
function CTLD:GetStockTroops() end

---(User) Inject static cargo objects.
---
------
---@param self CTLD 
---@param Zone ZONE Zone to spawn in. Will be a somewhat random coordinate.
---@param Template string Unit(!) name of the static cargo object to be used as template.
---@param Mass number Mass of the static in kg.
---@return CTLD #self
function CTLD:InjectStaticFromTemplate(Zone, Template, Mass) end

---(Internal) Inject crates and static cargo objects.
---
------
---@param self CTLD 
---@param Zone ZONE Zone to spawn in.
---@param Cargo CTLD_CARGO The cargo type to spawn.
---@param RandomCoord boolean Randomize coordinate.
---@param FromLoad boolean Create only **one** crate per cargo type, as we are re-creating dropped crates that CTLD has saved prior.
---@return CTLD #self
function CTLD:InjectStatics(Zone, Cargo, RandomCoord, FromLoad) end

---(User) Pre-populate troops in the field.
---
------
---
---USAGE
---```
---Use this function to pre-populate the field with Troops or Engineers at a random coordinate in a zone:
---           -- create a matching #CTLD_CARGO type
---           local InjectTroopsType = CTLD_CARGO:New(nil,"Infantry",{"Inf12"},CTLD_CARGO.Enum.TROOPS,true,true,12,nil,false,80)
---           -- get a #ZONE object
---           local dropzone = ZONE:New("InjectZone") -- Core.Zone#ZONE
---           -- and go:
---           my_ctld:InjectTroops(dropzone,InjectTroopsType,{land.SurfaceType.LAND})
---```
------
---@param self CTLD 
---@param Zone ZONE The zone where to drop the troops.
---@param Cargo CTLD_CARGO The #CTLD_CARGO object to spawn.
---@param Surfacetypes table (Optional) Table of surface types. Can also be a single surface type. We will try max 1000 times to find the right type!
---@param PreciseLocation boolean (Optional) Don't try to get a random position in the zone but use the dead center. Caution not to stack up stuff on another!
---@param Structure string (Optional) String object describing the current structure of the injected group; mainly for load/save to keep current state setup.
---@param TimeStamp number (Optional) Timestamp used internally on re-loading from disk.
---@return CTLD #self
function CTLD:InjectTroops(Zone, Cargo, Surfacetypes, PreciseLocation, Structure, TimeStamp) end

---(User) Pre-populate vehicles in the field.
---
------
---
---USAGE
---```
---Use this function to pre-populate the field with Vehicles or FOB at a random coordinate in a zone:
---           -- create a matching #CTLD_CARGO type
---           local InjectVehicleType = CTLD_CARGO:New(nil,"Humvee",{"Humvee"},CTLD_CARGO.Enum.VEHICLE,true,true,1,nil,false,1000)
---           -- get a #ZONE object
---           local dropzone = ZONE:New("InjectZone") -- Core.Zone#ZONE
---           -- and go:
---           my_ctld:InjectVehicles(dropzone,InjectVehicleType)
---```
------
---@param self CTLD 
---@param Zone ZONE The zone where to drop the troops.
---@param Cargo CTLD_CARGO The #CTLD_CARGO object to spawn.
---@param Surfacetypes table (Optional) Table of surface types. Can also be a single surface type. We will try max 1000 times to find the right type!
---@param PreciseLocation boolean (Optional) Don't try to get a random position in the zone but use the dead center. Caution not to stack up stuff on another!
---@param Structure string (Optional) String object describing the current structure of the injected group; mainly for load/save to keep current state setup.
---@param TimeStamp number (Optional) Timestamp used internally on re-loading from disk.
---@return CTLD #self
function CTLD:InjectVehicles(Zone, Cargo, Surfacetypes, PreciseLocation, Structure, TimeStamp) end

---(Internal) Check if a Hercules is flying *in parameters* for air drops.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:IsCorrectFlightParameters(Unit) end

---(Internal) Check if a unit is hovering *in parameters*.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:IsCorrectHover(Unit) end

---(Internal) Function to check if a unit is an allowed fixed wing.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:IsFixedWing(Unit) end

---(Internal) Function to check if a unit is a CH-47
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:IsHook(Unit) end

---(Internal) Check if a unit is above ground.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD:IsUnitInAir(Unit) end

---(Internal) Function to see if a unit is in a specific zone type.
---
------
---@param self CTLD 
---@param Unit UNIT Unit
---@param Zonetype CTLD.CargoZoneType Zonetype
---@return boolean #Outcome Is in zone or not
---@return string #name Closest zone name
---@return ZONE #zone Closest Core.Zone#ZONE object
---@return number #distance Distance to closest zone
---@return number #width Radius of zone or width of ship
function CTLD:IsUnitInZone(Unit, Zonetype) end

---Triggers the FSM event "Save".
---
------
---@param self CTLD 
function CTLD:Load() end

---Instantiate a new CTLD.
---
------
---@param self CTLD 
---@param Coalition string Coalition of this CTLD. I.e. coalition.side.BLUE or coalition.side.RED or coalition.side.NEUTRAL
---@param Prefixes table Table of pilot prefixes.
---@param Alias string Alias of this CTLD for logging.
---@return CTLD #self
function CTLD:New(Coalition, Prefixes, Alias) end

---FSM Function OnAfterCratesBuild.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD #self
function CTLD:OnAfterCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnAfterCratesBuildStarted.
---Info event that a build has been started.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param CargoName NOTYPE The name of the cargo being built.
---@return CTLD #self
function CTLD:OnAfterCratesBuildStarted(From, Event, To, Group, Unit, CargoName) end

---FSM Function OnAfterCratesDropped.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargotable table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD #self
function CTLD:OnAfterCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnAfterCratesPickedUp.
---
------
---@param self CTLD 
---@param From string State .
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo crate. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew loaded!
---@return CTLD #self
function CTLD:OnAfterCratesPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnAfterCratesRepairStarted.
---Info event that a repair has been started.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@return CTLD #self
function CTLD:OnAfterCratesRepairStarted(From, Event, To, Group, Unit) end

---FSM Function OnAfterCratesRepaired.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB repaired.
---@return CTLD #self
function CTLD:OnAfterCratesRepaired(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnAfterHelicopterLost.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Unitname string The name of the unit lost.
---@param LostCargo table Table of #CTLD_CARGO object which were aboard the helicopter/transportplane lost. Can be an empty table!
function CTLD:OnAfterHelicopterLost(From, Event, To, Unitname, LostCargo) end

---FSM Function OnAfterLoad.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:OnAfterLoad(From, Event, To, path, filename) end

---FSM Function OnAfterLoaded.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param LoadedGroups table Table of loaded groups, each entry is a table with three values: Group, TimeStamp and CargoType.
function CTLD:OnAfterLoaded(From, Event, To, LoadedGroups) end

---FSM Function OnAfterSave.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename string (Optional) File name for saving. Default is "CTLD_<alias>_Persist.csv".
function CTLD:OnAfterSave(From, Event, To, path, filename) end

---FSM Function OnAfterTroopsDeployed.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP Troops #GROUP Object.
---@return CTLD #self
function CTLD:OnAfterTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---FSM Function OnAfterTroopsExtracted.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP extracted.
---@param Troopname string Name of the extracted group.
---@return CTLD #self
function CTLD:OnAfterTroopsExtracted(From, Event, To, Group, Unit, Troops, Troopname) end

---FSM Function OnAfterTroopsPickedUp.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo troops.
---@return CTLD #self
function CTLD:OnAfterTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnAfterTroopsRTB.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
function CTLD:OnAfterTroopsRTB(From, Event, To, Group, Unit) end

---FSM Function OnBeforeCratesBuild.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD #self
function CTLD:OnBeforeCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnBeforeCratesBuildStarted.
---Info event that a build has been started.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@return CTLD #self
function CTLD:OnBeforeCratesBuildStarted(From, Event, To, Group, Unit) end

---FSM Function OnBeforeCratesDropped.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargotable table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD #self
function CTLD:OnBeforeCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---FSM Function OnBeforeCratesPickedUp.
---
------
---@param self CTLD 
---@param From string State .
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo crate. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew loaded!
---@return CTLD #self
function CTLD:OnBeforeCratesPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnBeforeCratesRepairStarted.
---Info event that a repair has been started.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@return CTLD #self
function CTLD:OnBeforeCratesRepairStarted(From, Event, To, Group, Unit) end

---FSM Function OnBeforeCratesRepaired.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB repaired.
---@return CTLD #self
function CTLD:OnBeforeCratesRepaired(From, Event, To, Group, Unit, Vehicle) end

---FSM Function OnBeforeHelicopterLost.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Unitname string The name of the unit lost.
---@param LostCargo table Table of #CTLD_CARGO object which were aboard the helicopter/transportplane lost. Can be an empty table!
function CTLD:OnBeforeHelicopterLost(From, Event, To, Unitname, LostCargo) end

---FSM Function OnBeforeTroopsDeployed.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP Troops #GROUP Object.
---@return CTLD #self
function CTLD:OnBeforeTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---FSM Function OnBeforeTroopsExtracted.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP extracted.
---@param Troopname string Name of the extracted group.
---@return CTLD #self
function CTLD:OnBeforeTroopsExtracted(From, Event, To, Group, Unit, Troops, Troopname) end

---FSM Function OnBeforeTroopsPickedUp.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo troops.
---@return CTLD #self
function CTLD:OnBeforeTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---FSM Function OnBeforeTroopsRTB.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param ZoneName string Name of the Zone where the Troops have been RTB'd.
---@param ZoneObject ZONE_Radius of the Zone where the Troops have been RTB'd.
function CTLD:OnBeforeTroopsRTB(From, Event, To, Group, Unit, ZoneName, ZoneObject) end

---(User) Pre-load crates into a helo, e.g.
---for airstart. Unit **must** be alive in-game, i.e. player has taken the slot!
---
------
---
---USAGE
---```
---         local client = UNIT:FindByName("Helo-1-1")
---         if client and client:IsAlive() then
---           myctld:PreloadCrates(client,"Humvee")
---         end
---```
------
---@param self CTLD 
---@param Unit UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Cratesname string The name of the cargo to be loaded. Must be created prior in the CTLD setup!
---@param NumberOfCrates number (Optional) Number of crates to be loaded. Default - all necessary to build this object. Might overload the helo!
---@return CTLD #self
function CTLD:PreloadCrates(Unit, Cratesname, NumberOfCrates) end

---(User) Pre-load troops into a helo, e.g.
---for airstart. Unit **must** be alive in-game, i.e. player has taken the slot!
---
------
---
---USAGE
---```
---         local client = UNIT:FindByName("Helo-1-1")
---         if client and client:IsAlive() then
---           myctld:PreloadTroops(client,"Infantry")
---         end
---```
------
---@param self CTLD 
---@param Unit UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Troopname string The name of the Troops to be loaded. Must be created prior in the CTLD setup!
---@return CTLD #self
function CTLD:PreloadTroops(Unit, Troopname) end

---User - function to remove stock of a certain crates type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:RemoveStockCrates(Name, Number) end

---User - function to remove stock of a certain statics type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:RemoveStockStatics(Name, Number) end

---User - function to remove stock of a certain troops type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to add.
---@return CTLD #self
function CTLD:RemoveStockTroops(Name, Number) end

---User - Function to add onw SET_GROUP Set-up for pilot filtering and assignment.
---Needs to be set before starting the CTLD instance.
---
------
---@param self CTLD 
---@param Set SET_GROUP The SET_GROUP object created by the mission designer/user to represent the CTLD pilot groups.
---@return CTLD #self 
function CTLD:SetOwnSetPilotGroups(Set) end

---Set folder path where the CTLD sound files are located **within you mission (miz) file**.
---The default path is "l10n/DEFAULT/" but sound files simply copied there will be removed by DCS the next time you save the mission.
---However, if you create a new folder inside the miz file, which contains the sounds, it will not be deleted and can be used.
---
------
---@param self CTLD 
---@param FolderPath string The path to the sound files, e.g. "CTLD_Soundfiles/".
---@return CTLD #self
function CTLD:SetSoundfilesFolder(FolderPath) end

---User - function to set the stock of a certain crates type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to be available. Nil equals unlimited
---@return CTLD #self
function CTLD:SetStockCrates(Name, Number) end

---User - function to set the stock of a certain statics type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to be available. Nil equals unlimited
---@return CTLD #self
function CTLD:SetStockStatics(Name, Number) end

---User - function to set the stock of a certain troops type
---
------
---@param self CTLD 
---@param Name string Name as defined in the generic cargo.
---@param Number number Number of units/groups to be available. Nil equals unlimited
---@return CTLD #self
function CTLD:SetStockTroops(Name, Number) end

---(User) Set drop zone radius for troop drops in meters.
---Minimum distance is 25m for security reasons.
---
------
---@param self CTLD 
---@param Radius number The radius to use.
function CTLD:SetTroopDropZoneRadius(Radius) end

---User - Function to add/adjust unittype capabilities.
---
------
---@param self CTLD 
---@param Unittype string The unittype to adjust. If passed as Wrapper.Unit#UNIT, it will search for the unit in the mission.
---@param Cancrates boolean Unit can load crates. Default false.
---@param Cantroops boolean Unit can load troops. Default false.
---@param Cratelimit number Unit can carry number of crates. Default 0.
---@param Trooplimit number Unit can carry number of troops. Default 0.
---@param Length number Unit lenght (in metres) for the load radius. Default 20.
---@param Maxcargoweight number Maxmimum weight in kgs this helo can carry. Default 500.
function CTLD:SetUnitCapabilities(Unittype, Cancrates, Cantroops, Cratelimit, Trooplimit, Length, Maxcargoweight) end

---User function - Drop a smoke or flare at current location.
---
------
---@param self CTLD 
---@param Unit UNIT The Unit.
---@param Flare boolean If true, flare instead.
---@param SmokeColor number Color enumerator for smoke, e.g. SMOKECOLOR.Red
function CTLD:SmokePositionNow(Unit, Flare, SmokeColor) end

---User function - Start smoke/flare in a zone close to the Unit.
---
------
---@param self CTLD 
---@param Unit UNIT The Unit.
---@param Flare boolean If true, flare instead.
function CTLD:SmokeZoneNearBy(Unit, Flare) end

---Triggers the FSM event "Start".
---Starts the CTLD. Initializes parameters and starts event handlers.
---
------
---@param self CTLD 
function CTLD:Start() end

---Triggers the FSM event "Status".
---
------
---@param self CTLD 
function CTLD:Status() end

---Triggers the FSM event "Stop".
---Stops the CTLD and all its event handlers.
---
------
---@param self CTLD 
function CTLD:Stop() end

---[Deprecated] - Function to add/adjust unittype capabilities.
---Has been replaced with `SetUnitCapabilities()` - pls use the new one going forward!
---
------
---@param self CTLD 
---@param Unittype string The unittype to adjust. If passed as Wrapper.Unit#UNIT, it will search for the unit in the mission.
---@param Cancrates boolean Unit can load crates. Default false.
---@param Cantroops boolean Unit can load troops. Default false.
---@param Cratelimit number Unit can carry number of crates. Default 0.
---@param Trooplimit number Unit can carry number of troops. Default 0.
---@param Length number Unit lenght (in metres) for the load radius. Default 20.
---@param Maxcargoweight number Maxmimum weight in kgs this helo can carry. Default 500.
function CTLD:UnitCapabilities(Unittype, Cancrates, Cantroops, Cratelimit, Trooplimit, Length, Maxcargoweight) end

---(Internal) Add radio beacon to zone.
---Runs 30 secs.
---
------
---@param self CTLD 
---@param Name string Name of zone.
---@param Sound string Name of soundfile.
---@param Mhz number Frequency in Mhz.
---@param Modulation number Modulation AM or FM.
---@param IsShip boolean If true zone is a ship.
---@param IsDropped boolean If true, this isn't a zone but a dropped beacon
function CTLD:_AddRadioBeacon(Name, Sound, Mhz, Modulation, IsShip, IsDropped) end

---(Internal) Function to build nearby crates.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Engineering boolean If true build is by an engineering team.
---@param MultiDrop boolean If true and not engineering or FOB, vary position a bit.
function CTLD:_BuildCrates(Group, Unit, Engineering, MultiDrop) end

---(Internal) Function to actually SPAWN buildables in the mission.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Build CTLD.Buildable 
---@param Repair boolean If true this is a repair and not a new build
---@param RepairLocation COORDINATE Location for repair (e.g. where the destroyed unit was)
---@param MultiDrop boolean if true and not a repair, vary location a bit if not a FOB
function CTLD:_BuildObjectFromCrates(Group, Unit, Build, Repair, RepairLocation, MultiDrop) end

---(Internal) Check on engineering teams
---
------
---@param self CTLD 
---@return CTLD #self
function CTLD:_CheckEngineers() end

---[Internal] Function to check if a template exists in the mission.
---
------
---@param self CTLD 
---@param temptable table Table of string names
---@return boolean #outcome
function CTLD:_CheckTemplates(temptable) end

---(Internal) Housekeeping - Cleanup crates when build
---
------
---@param self CTLD 
---@param Crates table Table of #CTLD_CARGO objects near the unit.
---@param Build CTLD.Buildable Table build object.
---@param Number number Number of objects in Crates (found) to limit search.
function CTLD:_CleanUpCrates(Crates, Build, Number) end

---(Internal) Function to clean up tracked cargo crates
---
------
---@param self CTLD 
---@param crateIdsToRemove NOTYPE 
---@return  #self
function CTLD:_CleanupTrackedCrates(crateIdsToRemove) end

---User - Count both the stock and groups in the field for available cargo types.
---Counts only limited cargo items and only troops and vehicle/FOB crates!
---
------
---
---USAGE
---```
---     The index is the unique cargo name.
---     Each entry in the returned table contains a table with the following entries:
---     
---     {
---         Stock0 -- number of original stock when the cargo entry was created.
---         Stock -- number of currently available stock.
---         StockR -- relative number of available stock, e.g. 75 (percent).
---         Infield -- number of groups alive in the field of this kind.
---         Inhelo -- number of troops/crates in any helo alive. Can be with decimals < 1 if e.g. you have cargo that need 4 crates, but you have 2 loaded.
---         Sum -- sum is stock + infield + inhelo.
---         GenericCargo -- this filed holds the generic CTLD_CARGO object which drives the available stock. Only populated if Restock is true.
---       }
---```
------
---@param self CTLD 
---@param Restock boolean If true, restock the cargo and troop items.
---@param Threshold number Percentage below which to restock, used in conjunction with Restock (must be true). Defaults to 75 (percent).
---@return table #Table A table of contents with numbers.
function CTLD:_CountStockPlusInHeloPlusAliveGroups(Restock, Threshold) end

---(Internal) Helper - Drop **all** loaded crates nearby and build them.
---
------
---@param Group GROUP The calling group
---@param Unit UNIT  The calling unit
---@param self NOTYPE 
function CTLD._DropAndBuild(Group, Unit, self) end

---(Internal) Helper - Drop a **single** crate set and build it.
---
------
---@param Group GROUP     The calling group
---@param Unit UNIT       The calling unit
---@param number NOTYPE             setIndex   Index of the crate-set to drop
---@param self NOTYPE 
---@param setIndex NOTYPE 
function CTLD._DropSingleAndBuild(Group, Unit, number, self, setIndex) end

---(Internal) Event handler function
---
------
---@param self CTLD 
---@param EventData EVENTDATA 
function CTLD:_EventHandler(EventData) end

---(Internal) Function to extract (load from the field) troops into a heli.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_ExtractTroops(Group, Unit) end

---(Internal) Find a crates CTLD_CARGO object in stock
---
------
---@param self CTLD 
---@param Name string of the object
---@return CTLD_CARGO #Cargo object, nil if it cannot be found
function CTLD:_FindCratesCargoObject(Name) end

---(Internal) Function to find and return nearby crates.
---
------
---@param self CTLD 
---@param _group GROUP Group
---@param _unit UNIT Unit
---@param _dist number Distance
---@param _ignoreweight boolean Find everything in range, ignore loadable weight
---@param ignoretype boolean Find everything in range, ignore loadable type name
---@return table #Crates Table of crates
---@return number #Number Number of crates found
---@return table #CratesGC Table of crates possibly loaded by GC
---@return number #NumberGC Number of crates possibly loaded by GC
function CTLD:_FindCratesNearby(_group, _unit, _dist, _ignoreweight, ignoretype) end


---
------
---@param self NOTYPE 
---@param Group NOTYPE 
---@param Unit NOTYPE 
---@param Repairtype NOTYPE 
function CTLD:_FindRepairNearby(Group, Unit, Repairtype) end

---(Internal) Find a troops CTLD_CARGO object in stock
---
------
---@param self CTLD 
---@param Name string of the object
---@return CTLD_CARGO #Cargo object, nil if it cannot be found
function CTLD:_FindTroopsCargoObject(Name) end

---(Internal) Function to generate valid FM Frequencies
---
------
---@param self CTLD 
function CTLD:_GenerateFMFrequencies() end

---(Internal) Function to generate valid UHF Frequencies
---
------
---@param self CTLD 
function CTLD:_GenerateUHFrequencies() end

---(Internal) Populate table with available VHF beacon frequencies.
---
------
---@param self CTLD 
function CTLD:_GenerateVHFrequencies() end


---
------
---@param self NOTYPE 
---@param Group NOTYPE 
---@param Unit NOTYPE 
function CTLD:_GetAllAndLoad(Group, Unit) end

---(Internal) Helper - get and load in one step
---
------
---@param Group GROUP  The calling group
---@param Unit UNIT    The calling unit
---@param self NOTYPE 
---@param cargoObj NOTYPE 
function CTLD._GetAndLoad(Group, Unit, self, cargoObj) end

---(Internal) Function to spawn crates in front of the heli.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Cargo CTLD_CARGO 
---@param number number Number of crates to generate (for dropping)
---@param drop boolean If true we\'re dropping from heli rather than loading.
---@param pack boolean If true we\'re packing crates from a template rather than loading or dropping
function CTLD:_GetCrates(Group, Unit, Cargo, number, drop, pack) end

---(Internal) Return distance in meters between two coordinates.
---
------
---@param self CTLD 
---@param _point1 COORDINATE Coordinate one
---@param _point2 COORDINATE Coordinate two
---@return number #Distance in meters
function CTLD:_GetDistance(_point1, _point2) end

---(Internal) Function to obtain a valid FM frequency.
---
------
---@param self CTLD 
---@param Name string Name of zone.
---@return CTLD.ZoneBeacon #Beacon Beacon table.
function CTLD:_GetFMBeacon(Name) end

---(Internal) Function to calculate max loadable mass left over.
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return number #maxloadable Max loadable mass in kg
function CTLD:_GetMaxLoadableMass(Unit) end

---(Internal) Function to obtain a valid UHF frequency.
---
------
---@param self CTLD 
---@param Name string Name of zone.
---@return CTLD.ZoneBeacon #Beacon Beacon table.
function CTLD:_GetUHFBeacon(Name) end

---(Internal) Function to get capabilities of a chopper
---
------
---@param self CTLD 
---@param Unit UNIT The unit
---@return table #Capabilities Table of caps
function CTLD:_GetUnitCapabilities(Unit) end

---(Internal) Function to get current loaded mass
---
------
---@param self CTLD 
---@param Unit UNIT 
---@return number #mass in kgs
function CTLD:_GetUnitCargoMass(Unit) end

---(Internal) Function to set troops positions of a template to a nice circle
---
------
---@param self CTLD 
---@param Coordinate COORDINATE Start coordinate to use
---@param Radius number Radius to be used
---@param Heading number Heading starting with
---@param Template string The group template name
---@return table #Positions The positions table
function CTLD:_GetUnitPositions(Coordinate, Radius, Heading, Template) end

---(Internal) Function to obtain a valid VHF frequency.
---
------
---@param self CTLD 
---@param Name string Name of zone.
---@return CTLD.ZoneBeacon #Beacon Beacon table.
function CTLD:_GetVHFBeacon(Name) end

---(Internal) Function to list loaded cargo.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@return CTLD #self
function CTLD:_ListCargo(Group, Unit) end

---(Internal) Function to find and list nearby crates.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param _group NOTYPE 
---@param _unit NOTYPE 
---@return CTLD #self
function CTLD:_ListCratesNearby(Group, Unit, _group, _unit) end

---(Internal) Function to list loaded cargo.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@return CTLD #self
function CTLD:_ListInventory(Group, Unit) end

---(Internal) Function to show list of radio beacons
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_ListRadioBeacons(Group, Unit) end

---(Internal) Function to get and load nearby crates.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@return CTLD #self
function CTLD:_LoadCratesNearby(Group, Unit) end

---Loads exactly `CratesNeeded` crates for one cargoName in range.
---If "Ammo Truck" needs 2 crates, we pick up 2 if available.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param cargoName string The cargo name, e.g. "Ammo Truck"
function CTLD:_LoadSingleCrateSet(Group, Unit, cargoName) end

---(Internal) Function to load troops into a heli.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Cargotype CTLD_CARGO 
---@param Inject boolean 
function CTLD:_LoadTroops(Group, Unit, Cargotype, Inject) end

---(Internal) Function to move group to WP zone.
---
------
---@param self CTLD 
---@param Group GROUP The Group to move.
function CTLD:_MoveGroupToZone(Group) end

---(Internal) Helper - Pack crates near the unit and load them.
---
------
---@param Group GROUP  The calling group
---@param Unit UNIT    The calling unit
---@param self NOTYPE 
function CTLD._PackAndLoad(Group, Unit, self) end

---(Internal) Helper - Pack crates near the unit and then remove them.
---
------
---@param Group GROUP  The calling group
---@param Unit UNIT    The calling unit
---@param self NOTYPE 
function CTLD._PackAndRemove(Group, Unit, self) end


---
------
---@param self NOTYPE 
---@param Group NOTYPE 
---@param Unit NOTYPE 
function CTLD:_PackCratesNearby(Group, Unit) end

---(Internal) Pre-load crates into a helo.
---Do not use standalone!
---
------
---@param self CTLD 
---@param Group GROUP The group to load into, can be handed as Wrapper.Client#CLIENT object
---@param Unit UNIT The unit to load into, can be handed as Wrapper.Client#CLIENT object
---@param Cargo CTLD_CARGO The Cargo crate object to load
---@param NumberOfCrates number (Optional) Number of crates to be loaded. Default - all necessary to build this object. Might overload the helo!
---@return CTLD #self
function CTLD:_PreloadCrates(Group, Unit, Cargo, NumberOfCrates) end

---(Internal) Function to refresh the menu for a single unit after crates dropped.
---
------
---@param self CTLD 
---@param Group GROUP The calling group.
---@param Unit UNIT The calling unit.
---@return CTLD #self
function CTLD:_RefreshDropCratesMenu(Group, Unit) end

---(Internal) Function to refresh menu for troops on drop for a specific unit
---
------
---@param self CTLD 
---@param Group GROUP The requesting group.
---@param Unit UNIT The requesting unit.
---@return CTLD #self
function CTLD:_RefreshDropTroopsMenu(Group, Unit) end

---(Internal) Housekeeping - Function to refresh F10 menus.
---
------
---@param self CTLD 
---@return CTLD #self
function CTLD:_RefreshF10Menus() end

---(Internal) Function to refresh the menu for load crates.
---Triggered from land/getcrate/pack and more
---
------
---@param self CTLD 
---@param Group GROUP The calling group.
---@param Unit UNIT The calling unit.
---@return CTLD #self
function CTLD:_RefreshLoadCratesMenu(Group, Unit) end

---(Internal) Function to refresh radio beacons
---
------
---@param self CTLD 
function CTLD:_RefreshRadioBeacons() end


---
------
---@param self NOTYPE 
---@param _group NOTYPE 
---@param _unit NOTYPE 
function CTLD:_RemoveCratesNearby(_group, _unit) end

---(Internal) Function to repair nearby vehicles / FOBs
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Engineering boolean If true, this is an engineering role
function CTLD:_RepairCrates(Group, Unit, Engineering) end

---(Internal) Function to repair an object.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
---@param Crates table Table of #CTLD_CARGO objects near the unit.
---@param Build CTLD.Buildable Table build object.
---@param Number number Number of objects in Crates (found) to limit search.
---@param Engineering boolean If true it is an Engineering repair.
function CTLD:_RepairObjectFromCrates(Group, Unit, Crates, Build, Number, Engineering) end

---(Internal) Function to message a group.
---
------
---@param self CTLD 
---@param Text string The text to display.
---@param Time number Number of seconds to display the message.
---@param Clearscreen boolean Clear screen or not.
---@param Group GROUP The group receiving the message.
function CTLD:_SendMessage(Text, Time, Clearscreen, Group) end

---(Internal) List if a Herc unit is flying *in parameters*.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_ShowFlightParams(Group, Unit) end

---(Internal) List if a unit is hovering *in parameters*.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_ShowHoverParams(Group, Unit) end

---(Internal) Function to unload crates from heli.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_UnloadCrates(Group, Unit) end

---(Internal) Function to unload a single crate
---
------
---@param self CTLD 
---@param Group GROUP The calling group.
---@param Unit UNIT The calling unit.
---@param setIndex string The name of the crate to unload
---@return CTLD #self
function CTLD:_UnloadSingleCrateSet(Group, Unit, setIndex) end

---(Internal) Function to unload a single Troop group by ID.
---
------
---@param self CTLD 
---@param Group GROUP The calling group.
---@param Unit UNIT The calling unit.
---@param chunkID number the Cargo ID
---@return CTLD #self
function CTLD:_UnloadSingleTroopByID(Group, Unit, chunkID) end

---(Internal) Function to unload troops from heli.
---
------
---@param self CTLD 
---@param Group GROUP 
---@param Unit UNIT 
function CTLD:_UnloadTroops(Group, Unit) end

---(Internal) Function to calculate and set Unit internal cargo mass
---
------
---@param self CTLD 
---@param Unit UNIT 
function CTLD:_UpdateUnitCargoMass(Unit) end

---Triggers the FSM event "Load" after a delay.
---
------
---@param self CTLD 
---@param delay number Delay in seconds.
function CTLD:__Load(delay) end

---Triggers the FSM event "Save" after a delay.
---
------
---@param self CTLD 
---@param delay number Delay in seconds.
function CTLD:__Save(delay) end

---Triggers the FSM event "Start" after a delay.
---Starts the CTLD. Initializes parameters and starts event handlers.
---
------
---@param self CTLD 
---@param delay number Delay in seconds.
function CTLD:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---
------
---@param self CTLD 
---@param delay number Delay in seconds.
function CTLD:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the CTLD and all its event handlers.
---
------
---@param self CTLD 
---@param delay number Delay in seconds.
function CTLD:__Stop(delay) end

---(Internal) FSM Function onafterCratesBuild.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD #self
function CTLD:onafterCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---On after "Load" event.
---Loads dropped units from file.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onafterLoad(From, Event, To, path, filename) end

---On after "Save" event.
---Player data is saved to file.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. If nil, file is saved in the DCS root installtion directory or your "Saved Games" folder if lfs was desanitized.
---@param filename string (Optional) File name for saving. Default is Default is "CTLD_<alias>_Persist.csv".
function CTLD:onafterSave(From, Event, To, path, filename) end

---(Internal) FSM Function onafterStart.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@return CTLD #self
function CTLD:onafterStart(From, Event, To) end

---(Internal) FSM Function onafterStatus.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@return CTLD #self
function CTLD:onafterStatus(From, Event, To) end

---(Internal) FSM Function onafterStop.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@return CTLD #self
function CTLD:onafterStop(From, Event, To) end

---(Internal) FSM Function onafterTroopsDeployed.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP Troops #GROUP Object.
---@param Type CTLD.CargoZoneType Type of Cargo deployed
---@return CTLD #self
function CTLD:onafterTroopsDeployed(From, Event, To, Group, Unit, Troops, Type) end

---(Internal) FSM Function onbeforeCratesBuild.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Vehicle GROUP The #GROUP object of the vehicle or FOB build.
---@return CTLD #self
function CTLD:onbeforeCratesBuild(From, Event, To, Group, Unit, Vehicle) end

---(Internal) FSM Function onbeforeCratesDropped.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargotable table Table of #CTLD_CARGO objects dropped. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew unloaded!
---@return CTLD #self
function CTLD:onbeforeCratesDropped(From, Event, To, Group, Unit, Cargotable) end

---(Internal) FSM Function onbeforeCratesPickedUp.
---
------
---@param self CTLD 
---@param From string State .
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo crate. Can be a Wrapper.DynamicCargo#DYNAMICCARGO object, if ground crew loaded!
---@return CTLD #self
function CTLD:onbeforeCratesPickedUp(From, Event, To, Group, Unit, Cargo) end

---On before "Load" event.
---Checks if io and lfs and the file are available.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string (Optional) Path where the file is located. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename string (Optional) File name for loading. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onbeforeLoad(From, Event, To, path, filename) end

---On before "Save" event.
---Checks if io and lfs are available.
---
------
---@param self CTLD 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string (Optional) Path where the file is saved. Default is the DCS root installation folder or your "Saved Games\\DCS" folder if the lfs module is desanitized.
---@param filename string (Optional) File name for saving. Default is "CTLD_<alias>_Persist.csv".
function CTLD:onbeforeSave(From, Event, To, path, filename) end

---(Internal) FSM Function onbeforeStatus.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@return CTLD #self
function CTLD:onbeforeStatus(From, Event, To) end

---(Internal) FSM Function onbeforeTroopsDeployed.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP Troops #GROUP Object.
---@return CTLD #self
function CTLD:onbeforeTroopsDeployed(From, Event, To, Group, Unit, Troops) end

---(Internal) FSM Function onbeforeTroopsExtracted.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Troops GROUP Troops #GROUP Object.
---@param Groupname string Name of the extracted #GROUP.
---@return CTLD #self
function CTLD:onbeforeTroopsExtracted(From, Event, To, Group, Unit, Troops, Groupname) end

---(Internal) FSM Function onbeforeTroopsPickedUp.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param Cargo CTLD_CARGO Cargo crate.
---@return CTLD #self
function CTLD:onbeforeTroopsPickedUp(From, Event, To, Group, Unit, Cargo) end

---(Internal) FSM Function onbeforeTroopsRTB.
---
------
---@param self CTLD 
---@param From string State.
---@param Event string Trigger.
---@param To string State.
---@param Group GROUP Group Object.
---@param Unit UNIT Unit Object.
---@param ZoneName string Name of the Zone where the Troops have been RTB'd.
---@param ZoneObject ZONE_Radius of the Zone where the Troops have been RTB'd.
---@return CTLD #self
function CTLD:onbeforeTroopsRTB(From, Event, To, Group, Unit, ZoneName, ZoneObject) end


---Buildable table info.
---@class CTLD.Buildable 
---@field CanBuild boolean Is buildable or not.
---@field Coord  
---@field Found number Found crates.
---@field Name string Name of the object.
---@field Required number Required crates.
CTLD.Buildable = {}


---Zone Info.
---@class CTLD.CargoZone 
---@field active boolean Active or not.
---@field color string Smoke color for zone, e.g. SMOKECOLOR.Red.
---@field hasbeacon boolean Create and run radio beacons if active.
---@field name string Name of Zone.
---@field shiplength number For ships - length of ship
---@field shipwidth number For ships - width of ship
---@field timestamp number For dropped beacons - time this was created
---@field type string Type of zone, i.e. load,drop,move,ship
CTLD.CargoZone = {}


---Zone Type Info.
---@class CTLD.CargoZoneType 
---@field BEACON string 
---@field DROP string 
---@field LOAD string 
---@field MOVE string 
---@field SHIP string 
CTLD.CargoZoneType = {}


---Allowed Fixed Wing Types
---@class CTLD.FixedWingTypes 
---@field Bronco string 
---@field Hercules string 
---@field Mosquito string 
CTLD.FixedWingTypes = {}


---Loaded Cargo
---@class CTLD.LoadedCargo 
---@field Cratesloaded number 
---@field Troopsloaded number 
CTLD.LoadedCargo = {}


---Radio Modulation
---@class CTLD.RadioModulation 
---@field AM number 
---@field FM number 
CTLD.RadioModulation = {}


---Unit capabilities.
---@class CTLD.UnitTypeCapabilities 
---@field cargoweightlimit number Max loadable kgs of cargo.
---@field cratelimit number Number of crates transportable.
---@field crates boolean Can transport crate.
---@field length number 
---@field trooplimit number Number of troop units transportable.
---@field troops boolean Can transport troops.
---@field type string Unit type.
CTLD.UnitTypeCapabilities = {}


---Radio Beacons
---@class CTLD.ZoneBeacon 
---@field frequency number -- in mHz
---@field modulation number -- i.e.CTLD.RadioModulation.FM or CTLD.RadioModulation.AM
---@field name string -- Name of zone for the coordinate
CTLD.ZoneBeacon = {}


---- **CTLD_CARGO** class, extends Core.Base#BASE
---@class CTLD_CARGO : BASE
---@field CargoType string Enumerator of Type.
---@field ClassName string Class name.
---@field CratesNeeded number Crates needed to build.
---@field DontShowInMenu boolean Show this item in menu or not.
---@field HasBeenDropped boolean True if dropped from heli.
---@field HasBeenMoved boolean Flag for moving.
---@field ID number ID of this cargo.
---@field LoadDirectly boolean Flag for direct loading.
---@field Location ZONE Location (if set) where to get this cargo item.
---@field Name string Name for menu.
---@field PerCrateMass number Mass in kg.
---@field Positionable POSITIONABLE Representation of cargo in the mission.
---@field StaticCategory string Individual static category if set.
---@field StaticShape string Individual shape if set.
---@field StaticType string Individual type if set.
---@field Stock number Number of builds available, -1 for unlimited.
---@field Stock0 number Initial stock, if any given.
---@field Subcategory string Sub-category name.
CTLD_CARGO = {}

---Add mark
---
------
---@param self CTLD_CARGO 
---@param Mark NOTYPE 
---@return CTLD_CARGO #self
function CTLD_CARGO:AddMark(Mark) end

---Add Stock.
---
------
---@param self CTLD_CARGO 
---@param Number number to add, none if nil.
---@return CTLD_CARGO #self
function CTLD_CARGO:AddStock(Number) end

---Add specific unit types to this CARGO (restrict what types can pick this up).
---
------
---@param self CTLD_CARGO 
---@param UnitTypes string Unit type name, can also be a #list<#string> table of unit type names.
---@return CTLD_CARGO #self
function CTLD_CARGO:AddUnitTypeName(UnitTypes) end

---Query directly loadable.
---
------
---@param self CTLD_CARGO 
---@return boolean #loadable
function CTLD_CARGO:CanLoadDirectly() end

---Query number of crates or troopsize.
---
------
---@param self CTLD_CARGO 
---@return number #Crates or size of troops.
function CTLD_CARGO:GetCratesNeeded() end

---Query ID.
---
------
---@param self CTLD_CARGO 
---@return number #ID
function CTLD_CARGO:GetID() end

---Query Location.
---
------
---@param self CTLD_CARGO 
---@return ZONE #location or `nil` if not set
function CTLD_CARGO:GetLocation() end

---Get mark
---
------
---@param self CTLD_CARGO 
---@param Mark NOTYPE 
---@return string #Mark
function CTLD_CARGO:GetMark(Mark) end

---Query Mass.
---
------
---@param self CTLD_CARGO 
---@return number #Mass in kg
function CTLD_CARGO:GetMass() end

---Query Name.
---
------
---@param self CTLD_CARGO 
---@return string #Name
function CTLD_CARGO:GetName() end

---Get overall mass of a cargo object, i.e.
---crates needed x mass per crate
---
------
---@param self CTLD_CARGO 
---@return number #mass
function CTLD_CARGO:GetNetMass() end

---Query type.
---
------
---@param self CTLD_CARGO 
---@return POSITIONABLE #Positionable
function CTLD_CARGO:GetPositionable() end

---Get relative Stock.
---
------
---@param self CTLD_CARGO 
---@return number #Stock Percentage like 75, or -1 if unlimited.
function CTLD_CARGO:GetRelativeStock() end

---Get Resource Map information table
---
------
---@param self CTLD_CARGO 
---@return table #ResourceMap
function CTLD_CARGO:GetStaticResourceMap() end

---Get the specific static type and shape from this CARGO if set.
---
------
---@param self CTLD_CARGO 
---@return string #Category
---@return string #TypeName
---@return string #ShapeName
function CTLD_CARGO:GetStaticTypeAndShape() end

---Get Stock.
---
------
---@param self CTLD_CARGO 
---@return number #Stock or -1 if unlimited.
function CTLD_CARGO:GetStock() end

---Get Stock0.
---
------
---@param self CTLD_CARGO 
---@return number #Stock0 or -1 if unlimited.
function CTLD_CARGO:GetStock0() end

---Query Subcategory
---
------
---@param self CTLD_CARGO 
---@return string #SubCategory
function CTLD_CARGO:GetSubCat() end

---Query Templates.
---
------
---@param self CTLD_CARGO 
---@return table #Templates
function CTLD_CARGO:GetTemplates() end

---Query type.
---
------
---@param self CTLD_CARGO 
---@return CTLD_CARGO.Enum #Type
function CTLD_CARGO:GetType() end

---Query has moved.
---
------
---@param self CTLD_CARGO 
---@return boolean #Has moved
function CTLD_CARGO:HasMoved() end

---Query crate type for REPAIR
---
------
---@param self CTLD_CARGO 
function CTLD_CARGO:IsRepair() end

---Query crate type for STATIC
---
------
---@param self CTLD_CARGO 
---@return boolean #
function CTLD_CARGO:IsStatic() end

---Query if cargo has been loaded.
---
------
---@param self CTLD_CARGO 
---@param loaded boolean 
function CTLD_CARGO:Isloaded(loaded) end

---Function to create new CTLD_CARGO object.
---
------
---@param self CTLD_CARGO 
---@param ID number ID of this #CTLD_CARGO
---@param Name string Name for menu.
---@param Templates table Table of #POSITIONABLE objects.
---@param Sorte CTLD_CARGO.Enum Enumerator of Type.
---@param HasBeenMoved boolean Flag for moving.
---@param LoadDirectly boolean Flag for direct loading.
---@param CratesNeeded number Crates needed to build.
---@param Positionable POSITIONABLE Representation of cargo in the mission.
---@param Dropped boolean Cargo/Troops have been unloaded from a chopper.
---@param PerCrateMass number Mass in kg
---@param Stock number Number of builds available, nil for unlimited
---@param Subcategory string Name of subcategory, handy if using > 10 types to load.
---@param DontShowInMenu boolean Show this item in menu or not (default: false == show it).
---@param Location ZONE (optional) Where the cargo is available (one location only).
---@return CTLD_CARGO #self
function CTLD_CARGO:New(ID, Name, Templates, Sorte, HasBeenMoved, LoadDirectly, CratesNeeded, Positionable, Dropped, PerCrateMass, Stock, Subcategory, DontShowInMenu, Location) end

---Remove Stock.
---
------
---@param self CTLD_CARGO 
---@param Number number to reduce, none if nil.
---@return CTLD_CARGO #self
function CTLD_CARGO:RemoveStock(Number) end

---Set HasMoved.
---
------
---@param self CTLD_CARGO 
---@param moved boolean 
function CTLD_CARGO:SetHasMoved(moved) end

---Add Resource Map information table
---
------
---@param self CTLD_CARGO 
---@param ResourceMap table 
---@return CTLD_CARGO #self
function CTLD_CARGO:SetStaticResourceMap(ResourceMap) end

---Add specific static type and shape to this CARGO.
---
------
---@param self CTLD_CARGO 
---@param TypeName string 
---@param ShapeName string 
---@param Category NOTYPE 
---@return CTLD_CARGO #self
function CTLD_CARGO:SetStaticTypeAndShape(TypeName, ShapeName, Category) end

---Set Stock.
---
------
---@param self CTLD_CARGO 
---@param Number number to set, nil means unlimited.
---@return CTLD_CARGO #self
function CTLD_CARGO:SetStock(Number) end

---Set WasDropped.
---
------
---@param self CTLD_CARGO 
---@param dropped boolean 
function CTLD_CARGO:SetWasDropped(dropped) end

---Check if a specific unit can carry this CARGO (restrict what types can pick this up).
---
------
---@param self CTLD_CARGO 
---@param Unit UNIT 
---@return boolean #Outcome
function CTLD_CARGO:UnitCanCarry(Unit) end

---Query was dropped.
---
------
---@param self CTLD_CARGO 
---@return boolean #Has been dropped.
function CTLD_CARGO:WasDropped() end

---Wipe mark
---
------
---@param self CTLD_CARGO 
---@return CTLD_CARGO #self
function CTLD_CARGO:WipeMark() end


---Define cargo types.
---@class CTLD_CARGO.Enum 
---@field CRATE string 
---@field ENGINEERS string 
---@field FOB string 
---@field GCLOADABLE string 
---@field REPAIR string 
---@field STATIC string 
---@field TROOPS string 
---@field VEHICLE string 
CTLD_CARGO.Enum = {}


---- **CTLD_ENGINEERING** class, extends Core.Base#BASE
---@class CTLD_ENGINEERING : BASE
---@field ClassName string 
---@field Group GROUP 
---@field HeliGroup GROUP 
---@field HeliUnit UNIT 
---@field Name string 
---@field State string 
---@field Unit UNIT 
---@field Version string 
---@field lid string 
---@field marktimer number 
CTLD_ENGINEERING = {}

---(Internal) Arrived at crates in reach.
---Stop group.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Arrive() end

---(Internal) Set build status.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Build() end

---(Internal) Set done status.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Done() end

---(Internal) Get the status
---
------
---@param self CTLD_ENGINEERING 
---@return string #State
function CTLD_ENGINEERING:GetStatus() end

---(Internal) Check the negative status
---
------
---@param self CTLD_ENGINEERING 
---@param State string 
---@return boolean #Outcome
function CTLD_ENGINEERING:IsNotStatus(State) end

---(Internal) Check the status
---
------
---@param self CTLD_ENGINEERING 
---@param State string 
---@return boolean #Outcome
function CTLD_ENGINEERING:IsStatus(State) end

---(Internal) Move towards crates in reach.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Move() end

---Create a new instance.
---
------
---@param self CTLD_ENGINEERING 
---@param Name string 
---@param GroupName string Name of Engineering #GROUP object
---@param HeliGroup GROUP HeliGroup
---@param HeliUnit UNIT HeliUnit
---@return CTLD_ENGINEERING #self 
function CTLD_ENGINEERING:New(Name, GroupName, HeliGroup, HeliUnit) end

---(Internal) Search for crates in reach.
---
------
---@param self CTLD_ENGINEERING 
---@param crates table Table of found crate Ops.CTLD#CTLD_CARGO objects.
---@param number number Number of crates found.
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Search(crates, number) end

---(Internal) Set the status
---
------
---@param self CTLD_ENGINEERING 
---@param State string 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:SetStatus(State) end

---(Internal) Set start status.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Start() end

---(Internal) Set stop status.
---
------
---@param self CTLD_ENGINEERING 
---@return CTLD_ENGINEERING #self
function CTLD_ENGINEERING:Stop() end

---(Internal) Return distance in meters between two coordinates.
---
------
---@param self CTLD_ENGINEERING 
---@param _point1 COORDINATE Coordinate one
---@param _point2 COORDINATE Coordinate two
---@return number #Distance in meters or -1
function CTLD_ENGINEERING:_GetDistance(_point1, _point2) end


---- **CTLD_HERCULES** class, extends Core.Base#BASE
---@class CTLD_HERCULES : BASE
---@field CTLD CTLD 
---@field ClassName string 
---@field Name string 
---@field Version string 
---@field alias  
---@field coalition  
---@field coalitiontxt  
---@field infantrytemplate string 
---@field lid string 
---@field verbose boolean 
CTLD_HERCULES = {}

---[Internal] Function to calc initiator heading
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_initiator GROUP 
---@return number #north corrected heading
function CTLD_HERCULES:Calculate_Cargo_Drop_initiator_Heading(Cargo_Drop_initiator) end

---[Internal] Function to calc north correction
---
------
---@param self CTLD_HERCULES 
---@param point POINT_Vec3 Position Vec3
---@return number #north correction
function CTLD_HERCULES:Calculate_Cargo_Drop_initiator_NorthCorrection(point) end

---[Internal] Function to calculate object height
---
------
---@param self CTLD_HERCULES 
---@param group GROUP The group for which to calculate the height
---@return number #height over ground
function CTLD_HERCULES:Calculate_Object_Height_AGL(group) end

---[Internal] Function to initialize dropped cargo
---
------
---@param self CTLD_HERCULES 
---@param Initiator GROUP 
---@param Cargo_Contents table Table 'weapon' from event data
---@param Cargo_Type_name string Name of this cargo
---@param Container_Enclosed boolean Is container?
---@param SoldierGroup boolean Is soldier group?
---@param ParatrooperGroupSpawnInit boolean Is paratroopers?
---@return CTLD_HERCULES #self
function CTLD_HERCULES:Cargo_Initialize(Initiator, Cargo_Contents, Cargo_Type_name, Container_Enclosed, SoldierGroup, ParatrooperGroupSpawnInit) end

---[Internal] Function to spawn cargo by type at position
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Type_name string 
---@param Cargo_Drop_Position COORDINATE 
---@param _name NOTYPE 
---@param _pos NOTYPE 
---@return CTLD_HERCULES #self
function CTLD_HERCULES:Cargo_SpawnDroppedAsCargo(Cargo_Type_name, Cargo_Drop_Position, _name, _pos) end

---[Internal] Function to spawn a group
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_initiator GROUP 
---@param Cargo_Drop_Position COORDINATE 
---@param Cargo_Type_name string 
---@param CargoHeading number 
---@param Cargo_Country number 
---@return CTLD_HERCULES #self 
function CTLD_HERCULES:Cargo_SpawnGroup(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, Cargo_Country) end

---[Internal] Spawn cargo objects
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_initiator GROUP 
---@param Cargo_Drop_Direction number 
---@param Cargo_Content_position COORDINATE 
---@param Cargo_Type_name string 
---@param Cargo_over_water boolean 
---@param Container_Enclosed boolean 
---@param ParatrooperGroupSpawn boolean 
---@param offload_cargo boolean 
---@param all_cargo_survive_to_the_ground boolean 
---@param all_cargo_gets_destroyed boolean 
---@param destroy_cargo_dropped_without_parachute boolean 
---@param Cargo_Country number 
---@return CTLD_HERCULES #self
function CTLD_HERCULES:Cargo_SpawnObjects(Cargo_Drop_initiator, Cargo_Drop_Direction, Cargo_Content_position, Cargo_Type_name, Cargo_over_water, Container_Enclosed, ParatrooperGroupSpawn, offload_cargo, all_cargo_survive_to_the_ground, all_cargo_gets_destroyed, destroy_cargo_dropped_without_parachute, Cargo_Country) end

---[Internal] Function to spawn static cargo
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_initiator GROUP 
---@param Cargo_Drop_Position COORDINATE 
---@param Cargo_Type_name string 
---@param CargoHeading number 
---@param dead boolean 
---@param Cargo_Country number 
---@return CTLD_HERCULES #self
function CTLD_HERCULES:Cargo_SpawnStatic(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, dead, Cargo_Country) end

---[Internal] Function to track cargo objects
---
------
---@param self CTLD_HERCULES 
---@param cargo CTLD_HERCULES.CargoObject 
---@param initiator GROUP 
---@return number #height over ground
function CTLD_HERCULES:Cargo_Track(cargo, initiator) end

---[Internal] Function to check availability of templates
---
------
---@param self CTLD_HERCULES 
---@return CTLD_HERCULES #self 
function CTLD_HERCULES:CheckTemplates() end

---[Internal] Function to check surface type
---
------
---@param self CTLD_HERCULES 
---@param group GROUP The group for which to calculate the height
---@param object NOTYPE 
---@return number #height over ground
function CTLD_HERCULES:Check_SurfaceType(group, object) end

---[User] Instantiate a new object
---
------
---
---USAGE
---```
---Integrate to your CTLD instance like so, where `my_ctld` is a previously created CTLD instance:
---           
---           my_ctld.enableFixedWing = false -- avoid dual loading via CTLD F10 and F8 ground crew
---           local herccargo = CTLD_HERCULES:New("blue", "Hercules Test", my_ctld)
---           
---You also need: 
---* A template called "Infantry" for 10 Paratroopers (as set via herccargo.infantrytemplate). 
---* Depending on what you are loading with the help of the ground crew, there are 42 more templates for the various vehicles that are loadable. 
---There's a **quick check output in the `dcs.log`** which tells you what's there and what not.
---E.g.:
---           ...Checking template for APC BTR-82A Air [24998lb] (BTR-82A) ... MISSING)
---           ...Checking template for ART 2S9 NONA Skid [19030lb] (SAU 2-C9) ... MISSING)
---           ...Checking template for EWR SBORKA Air [21624lb] (Dog Ear radar) ... MISSING)
---           ...Checking template for Transport Tigr Air [15900lb] (Tigr_233036) ... OK)
---           
---Expected template names are the ones in the rounded brackets.
---
---### HINTS
---
---The script works on the EVENTS.Shot trigger, which is used by the mod when you **drop cargo from the Hercules while flying**. Unloading on the ground does
---not achieve anything here. If you just want to unload on the ground, use the normal Moose CTLD.
---**Do not use** the **splash damage** script together with this, your cargo will just explode when reaching the ground!
---
---### Airdrops
---
---There are two ways of airdropping:   
---1) Very low and very slow (>5m and <10m AGL) - here you can drop stuff which has "Skid" at the end of the cargo name (loaded via F8 Ground Crew menu)
---2) Higher up and slow (>100m AGL) - here you can drop paratroopers and cargo which has "Air" at the end of the cargo name (loaded via F8 Ground Crew menu)
---
---### General
---
---Use either this method to integrate the Hercules **or** the one from the "normal" CTLD. Never both!
---```
------
---@param self CTLD_HERCULES 
---@param Coalition string Coalition side, "red", "blue" or "neutral"
---@param Alias string Name of this instance
---@param CtldObject CTLD CTLD instance to link into
---@return CTLD_HERCULES #self
function CTLD_HERCULES:New(Coalition, Alias, CtldObject) end

---[Internal] Function to change cargotype per group (Wrench)
---
------
---@param self CTLD_HERCULES 
---@param key number Carrier key id
---@param cargoType string Type of cargo
---@param cargoNum number Number of cargo objects
---@return CTLD_HERCULES #self
function CTLD_HERCULES:SetType(key, cargoType, cargoNum) end

---[Internal] Function to spawn a soldier group of 10 units
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_initiator GROUP 
---@param Cargo_Drop_Position COORDINATE 
---@param Cargo_Type_name string 
---@param CargoHeading number 
---@param Cargo_Country number 
---@param GroupSpacing number 
---@return CTLD_HERCULES #self 
function CTLD_HERCULES:Soldier_SpawnGroup(Cargo_Drop_initiator, Cargo_Drop_Position, Cargo_Type_name, CargoHeading, Cargo_Country, GroupSpacing) end

---[Internal] Function to capture BIRTH event
---
------
---@param self CTLD_HERCULES 
---@param event EVENTDATA The event data
---@return CTLD_HERCULES #self
function CTLD_HERCULES:_HandleBirth(event) end

---[Internal] Function to capture SHOT event
---
------
---@param self CTLD_HERCULES 
---@param Cargo_Drop_Event EVENTDATA The event data
---@return CTLD_HERCULES #self
function CTLD_HERCULES:_HandleShot(Cargo_Drop_Event) end


---Cargo Object
---@class CTLD_HERCULES.CargoObject 
---@field Cargo_Country number 
---@field Cargo_Drop_Direction number 
---@field Cargo_Type_name string 
---@field Cargo_over_water boolean 
---@field Container_Enclosed boolean 
---@field ParatrooperGroupSpawn boolean 
---@field all_cargo_gets_destroyed boolean 
---@field all_cargo_survive_to_the_ground boolean 
---@field destroy_cargo_dropped_without_parachute boolean 
---@field offload_cargo boolean 
---@field scheduleFunctionID TIMER 
CTLD_HERCULES.CargoObject = {}


---Define cargo types.
---@class CTLD_HERCULES.Types 
CTLD_HERCULES.Types = {}



