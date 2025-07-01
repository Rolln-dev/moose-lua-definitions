---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Storage.png" width="100%">
---
---**Wrapper** - Warehouse storage of DCS airbases.
---
---## Main Features:
---
---   * Convenient access to DCS API functions
---
---===
---
---## Example Missions:
---
---Demo missions can be found on [github](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Wrapper/Storage).
---
---===
---
---### Author: **funkyfranky**
---
---===
---*The capitalist cannot store labour-power in warehouses after he has bought it, as he may do with the raw material.* -- Karl Marx
---
---===
---
---# The STORAGE Concept
---
---The STORAGE class offers an easy-to-use wrapper interface to all DCS API functions of DCS warehouses.
---We named the class STORAGE, because the name WAREHOUSE is already taken by another MOOSE class.
---
---This class allows you to add and remove items to a DCS warehouse, such as aircraft, liquids, weapons and other equipment.
---
---# Constructor
---
---A DCS warehouse is associated with an airbase. Therefore, a `STORAGE` instance is automatically created, once an airbase is registered and added to the MOOSE database.
---
---You can get the `STORAGE` object from the
---
---    -- Create a STORAGE instance of the Batumi warehouse
---    local storage=STORAGE:FindByName("Batumi")
---
---An other way to get the `STORAGE` object is to retrieve it from the AIRBASE function `AIRBASE:GetStorage()`
---
---    -- Get storage instance of Batumi airbase
---    local Batumi=AIRBASE:FindByName("Batumi")
---    local storage=Batumi:GetStorage()
---
---# Aircraft, Weapons and Equipment
---
---## Adding Items
---
---To add aircraft, weapons and/or othe equipment, you can use the #STORAGE.AddItem() function
---
---    storage:AddItem("A-10C", 3)
---    storage:AddItem("weapons.missiles.AIM_120C", 10)
---
---This will add three A-10Cs and ten AIM-120C missiles to the warehouse inventory.
---
---## Setting Items
---
---You can also explicitly set, how many items are in the inventory with the #STORAGE.SetItem() function.
---
---## Removing Items
---
---Items can be removed from the inventory with the #STORAGE.RemoveItem() function.
---
---## Getting Amount
---
---The number of items currently in the inventory can be obtained with the #STORAGE.GetItemAmount() function
---
---    local N=storage:GetItemAmount("A-10C")
---    env.info(string.format("We currently have %d A-10Cs available", N))
---
---# Liquids
---
---Liquids can be added and removed by slightly different functions as described below. Currently there are four types of liquids
---
---* Jet fuel `STORAGE.Liquid.JETFUEL`
---* Aircraft gasoline `STORAGE.Liquid.GASOLINE`
---* MW 50 `STORAGE.Liquid.MW50`
---* Diesel `STORAGE.Liquid.DIESEL`
---
---## Adding Liquids
---
---To add a certain type of liquid, you can use the #STORAGE.AddItem(Type, Amount) function
---
---    storage:AddLiquid(STORAGE.Liquid.JETFUEL, 10000)
---    storage:AddLiquid(STORAGE.Liquid.DIESEL, 20000)
---
---This will add 10,000 kg of jet fuel and 20,000 kg of diesel to the inventory.
---
---## Setting Liquids
---
---You can also explicitly set the amount of liquid with the #STORAGE.SetLiquid(Type, Amount) function.
---
---## Removing Liquids
---
---Liquids can be removed with #STORAGE.RemoveLiquid(Type, Amount) function.
---
---## Getting Amount
---
---The current amount of a certain liquid can be obtained with the #STORAGE.GetLiquidAmount(Type) function
---
---    local N=storage:GetLiquidAmount(STORAGE.Liquid.DIESEL)
---    env.info(string.format("We currently have %d kg of Diesel available", N))
---
---
---# Inventory
---
---The current inventory of the warehouse can be obtained with the #STORAGE.GetInventory() function. This returns three tables with the aircraft, liquids and weapons:
---
---    local aircraft, liquids, weapons=storage:GetInventory()
---
---    UTILS.PrintTableToLog(aircraft)
---    UTILS.PrintTableToLog(liquids)
---    UTILS.PrintTableToLog(weapons)
---
---# Weapons Helper Enumerater
---
---The currently available weapon items are available in the `ENUMS.Storage.weapons`, e.g. `ENUMS.Storage.weapons.bombs.Mk_82Y`.
---
---# Persistence
---
---The contents of the storage can be saved to and read from disk. For this to function, `io` and `lfs` need to be desanitized in `MissionScripting.lua`.
---
---## Save once
---
---### To save once, e.g. this is sufficient:
---   
---     -- Filenames created are the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Only Storage NOT set to unlimited will be saved.
---     local Path = "C:\\Users\\UserName\\Saved Games\\DCS\\Missions\\"
---     local Filename = "Batumi"
---     storage:SaveToFile(Path,Filename)
---   
---### Autosave
---
---     storage:StartAutoSave(Path,Filename,300,true) -- save every 300 secs/5 mins starting in 5 mins, load the existing storage - if any - first if the last parameter is **not** `false`.
---
---### Stop Autosave
---
---     storage:StopAutoSave() -- stop the scheduler.
---   
---### Load back with e.g.
---
---     -- Filenames searched for the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Only Storage NOT set to unlimited will be loaded.
---     local Path = "C:\\Users\\UserName\\Saved Games\\DCS\\Missions\\"
---     local Filename = "Batumi"
---     storage:LoadFromFile(Path,Filename)
---STORAGE class.
---@class STORAGE : BASE
---@field ClassName string Name of the class.
---@field Liquid STORAGE.Liquid 
---@field LiquidName STORAGE.LiquidName 
---@field SaverTimer TIMER The TIMER for autosave.
---@field Type STORAGE.Type 
---@field private airbase Airbase The DCS airbase object.
---@field private lid string Class id string for output to DCS log file.
---@field private verbose number Verbosity level.
---@field private version string STORAGE class version.
---@field private warehouse Warehouse The DCS warehouse object.
STORAGE = {}

---Adds the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount number Amount of given type to add. Liquids in kg.
---@return STORAGE #self
function STORAGE:AddAmount(Type, Amount) end

---Adds the passed amount of a given item to the warehouse.
---
------
---@param self STORAGE 
---@param Name string Name of the item to add.
---@param Amount number Amount of items to add.
---@return STORAGE #self
function STORAGE:AddItem(Name, Amount) end

---Adds the passed amount of a given liquid to the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid.
---@param Amount number Amount of liquid to add.
---@return STORAGE #self
function STORAGE:AddLiquid(Type, Amount) end

---Airbases only - Find a STORAGE in the **_DATABASE** using the name associated airbase.
---
------
---@param self STORAGE 
---@param AirbaseName string The Airbase Name.
---@return STORAGE #self
function STORAGE:FindByName(AirbaseName) end

---Try to find the #STORAGE object of one of the many "H"-Helipads in Syria.
---You need to put a (small, round) zone on top of it, because the name is not unique(!).
---
------
---@param self STORAGE 
---@param ZoneName string The name of the zone where to find the helipad.
---@return STORAGE #self or nil if not found.
function STORAGE:FindSyriaHHelipadWarehouse(ZoneName) end

---Gets the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid or name of aircraft, weapon or equipment.
---@return number #Amount of given type. Liquids in kg.
function STORAGE:GetAmount(Type) end

---Returns a full itemized list of everything currently in a warehouse.
---If a category is set to unlimited then the table will be returned empty.
---
------
---@param self STORAGE 
---@param Item string Name of item as #string or type of liquid as #number.
---@return table #Table of aircraft. Table is emtpy `{}` if number of aircraft is set to be unlimited.
---@return table #Table of liquids. Table is emtpy `{}` if number of liquids is set to be unlimited.
---@return table #Table of weapons and other equipment. Table is emtpy `{}` if number of liquids is set to be unlimited.
function STORAGE:GetInventory(Item) end

---Gets the amount of a given item currently present the warehouse.
---
------
---@param self STORAGE 
---@param Name string Name of the item.
---@return number #Amount of items.
function STORAGE:GetItemAmount(Name) end

---Gets the amount of a given liquid currently present the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid.
---@return number #Amount of liquid in kg.
function STORAGE:GetLiquidAmount(Type) end

---Returns the name of the liquid from its numeric type.
---
------
---@param self STORAGE 
---@param Type number Type of liquid.
---@return string #Name of the liquid.
function STORAGE:GetLiquidName(Type) end

---Returns whether a given type of aircraft, liquid, weapon is set to be limited.
---
------
---@param self STORAGE 
---@param Type number Type of liquid or name of aircraft, weapon or equipment.
---@return boolean #If `true` the given type is limited or `false` otherwise.
function STORAGE:IsLimited(Type) end

---Returns whether aircraft are limited.
---
------
---@param self STORAGE 
---@return boolean #If `true` aircraft are limited or `false` otherwise.
function STORAGE:IsLimitedAircraft() end

---Returns whether liquids are limited.
---
------
---@param self STORAGE 
---@return boolean #If `true` liquids are limited or `false` otherwise.
function STORAGE:IsLimitedLiquids() end

---Returns whether weapons and equipment are limited.
---
------
---@param self STORAGE 
---@return boolean #If `true` liquids are limited or `false` otherwise.
function STORAGE:IsLimitedWeapons() end

---Returns whether a given type of aircraft, liquid, weapon is set to be unlimited.
---
------
---@param self STORAGE 
---@param Type string Name of aircraft, weapon or equipment or type of liquid (as `#number`).
---@return boolean #If `true` the given type is unlimited or `false` otherwise.
function STORAGE:IsUnlimited(Type) end

---Returns whether aircraft are unlimited.
---
------
---@param self STORAGE 
---@return boolean #If `true` aircraft are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedAircraft() end

---Returns whether liquids are unlimited.
---
------
---@param self STORAGE 
---@return boolean #If `true` liquids are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedLiquids() end

---Returns whether weapons and equipment are unlimited.
---
------
---@param self STORAGE 
---@return boolean #If `true` weapons and equipment are unlimited or `false` otherwise.
function STORAGE:IsUnlimitedWeapons() end

---Load the contents of a STORAGE from files.
---Filenames searched for are the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Requires io and lfs to be desanitized to be working.
---
------
---@param self STORAGE 
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@return STORAGE #self
function STORAGE:LoadFromFile(Path, Filename) end

---Create a new STORAGE object from the DCS airbase object.
---
------
---@param self STORAGE 
---@param AirbaseName string Name of the airbase.
---@return STORAGE #self
function STORAGE:New(AirbaseName) end

---Create a new STORAGE object from a Wrapper.DynamicCargo#DYNAMICCARGO object.
---
------
---@param self STORAGE 
---@param DynamicCargoName string Unit name of the dynamic cargo.
---@return STORAGE #self
function STORAGE:NewFromDynamicCargo(DynamicCargoName) end

---Create a new STORAGE object from an DCS static cargo object.
---
------
---@param self STORAGE 
---@param StaticCargoName string Unit name of the static.
---@return STORAGE #self
function STORAGE:NewFromStaticCargo(StaticCargoName) end

---Removes the amount of a given type of aircraft, liquid, weapon from the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount number Amount of given type to remove. Liquids in kg.
---@return STORAGE #self
function STORAGE:RemoveAmount(Type, Amount) end

---Removes the amount of the passed item from the warehouse.
---
------
---@param self STORAGE 
---@param Name string Name of the item.
---@param Amount number Amount of items.
---@return STORAGE #self
function STORAGE:RemoveItem(Name, Amount) end

---Removes the amount of the given liquid type from the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid.
---@param Amount number Amount of liquid in kg to be removed.
---@return STORAGE #self
function STORAGE:RemoveLiquid(Type, Amount) end

---Save the contents of a STORAGE to files in CSV format.
---Filenames created are the Filename given amended by "_Liquids", "_Aircraft" and "_Weapons" followed by a ".csv". Requires io and lfs to be desanitized to be working.
---
------
---@param self STORAGE 
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The base name of the files. Existing files will be overwritten.
---@return STORAGE #self
function STORAGE:SaveToFile(Path, Filename) end

---Sets the amount of a given type of aircraft, liquid, weapon currently present the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid or name of aircraft, weapon or equipment.
---@param Amount number of given type. Liquids in kg.
---@return STORAGE #self
function STORAGE:SetAmount(Type, Amount) end

---Sets the specified amount of a given item to the warehouse.
---
------
---@param self STORAGE 
---@param Name string Name of the item.
---@param Amount number Amount of items.
---@return STORAGE #self
function STORAGE:SetItem(Name, Amount) end

---Sets the specified amount of a given liquid to the warehouse.
---
------
---@param self STORAGE 
---@param Type number Type of liquid.
---@param Amount number Amount of liquid.
---@return STORAGE #self
function STORAGE:SetLiquid(Type, Amount) end

---Set verbosity level.
---
------
---@param self STORAGE 
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return STORAGE #self
function STORAGE:SetVerbosity(VerbosityLevel) end

---Start a STORAGE autosave process.
---
------
---@param self STORAGE 
---@param Path string The path to use. Use double backslashes \\\\ on Windows filesystems.
---@param Filename string The name of the file.
---@param Interval number The interval, start after this many seconds and repeat every interval seconds. Defaults to 300.
---@param LoadOnce boolean If LoadOnce is true or nil, we try to load saved storage first.
---@return STORAGE #self
function STORAGE:StartAutoSave(Path, Filename, Interval, LoadOnce) end

---Stop a running STORAGE autosave process.
---
------
---@param self STORAGE 
---@return STORAGE #self
function STORAGE:StopAutoSave() end


---Liquid types.
---@class STORAGE.Liquid 
---@field DIESEL number Diesel (3).
---@field GASOLINE number Aviation gasoline (1).
---@field JETFUEL number Jet fuel (0).
---@field MW50 number MW50 (2).
STORAGE.Liquid = {}


---Liquid Names for the static cargo resource table.
---@class STORAGE.LiquidName 
---@field DIESEL number "diesel".
---@field GASOLINE number "gasoline".
---@field JETFUEL number "jet_fuel".
---@field MW50 number "methanol_mixture".
STORAGE.LiquidName = {}


---Storage types.
---@class STORAGE.Type 
---@field AIRCRAFT number aircraft.
---@field LIQUIDS number liquids. Also see #list<#STORAGE.Liquid> for types of liquids.
---@field WEAPONS number weapons.
STORAGE.Type = {}



