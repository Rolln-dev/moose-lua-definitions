---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Sets.JPG" width="100%">
---
---**Core** - Define collections of objects to perform bulk actions and logically group objects.
---
---===
---
---## Features:
---
---  * Dynamically maintain collections of objects.
---  * Manually modify the collection, by adding or removing objects.
---  * Collections of different types.
---  * Validate the presence of objects in the collection.
---  * Perform bulk actions on collection.
---
---===
---
---Group objects or data of the same type into a collection, which is either:
---
---  * Manually managed using the **:Add...()** or **:Remove...()** methods. The initial SET can be filtered with the **#SET_BASE.FilterOnce()** method.
---  * Dynamically updated when new objects are created or objects are destroyed using the **#SET_BASE.FilterStart()** method.
---
---Various types of SET_ classes are available:
---
---  * #SET_GROUP: Defines a collection of Wrapper.Groups filtered by filter criteria.
---  * #SET_UNIT: Defines a collection of Wrapper.Units filtered by filter criteria.
---  * #SET_STATIC: Defines a collection of Wrapper.Statics filtered by filter criteria.
---  * #SET_CLIENT: Defines a collection of Wrapper.Clients filtered by filter criteria.
---  * #SET_AIRBASE: Defines a collection of Wrapper.Airbases filtered by filter criteria.
---  * #SET_CARGO: Defines a collection of Cargo.Cargos filtered by filter criteria.
---  * #SET_ZONE: Defines a collection of Core.Zones filtered by filter criteria.
---  * #SET_SCENERY: Defines a collection of Wrapper.Scenerys added via a filtered #SET_ZONE.
---  * #SET_DYNAMICCARGO: Defines a collection of Wrapper.DynamicCargos filtered by filter criteria.
---
---These classes are derived from #SET_BASE, which contains the main methods to manage the collections.
---
---A multitude of other methods are available in the individual set classes that allow to:
---
---  * Validate the presence of objects in the SET.
---  * Trigger events when objects in the SET change a zone presence.
---
---## Notes on `FilterPrefixes()`:  
---
---This filter always looks for a **partial match** somewhere in the given field. LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through the following to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching).  
---For example, setting a filter like so `FilterPrefixes("Huey")` is perfectly all right, whilst `FilterPrefixes("UH-1H Al-Assad")` might not be due to the minus signs. A quick fix here is to use a dot (.) 
---in place of the special character, or escape it with a percentage sign (%), i.e. either `FilterPrefixes("UH.1H Al.Assad")` or `FilterPrefixes("UH%-1H Al%-Assad")` will give you the expected results.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**, **applevangelist**
---
---===
---Mission designers can use the Core.Set#SET_AIRBASE class to build sets of airbases optionally belonging to certain:
---
--- * Coalitions
---
---## SET_AIRBASE constructor
---
---Create a new SET_AIRBASE object with the #SET_AIRBASE.New method:
---
---   * #SET_AIRBASE.New: Creates a new SET_AIRBASE object.
---
---## Add or Remove AIRBASEs from SET_AIRBASE
---
---AIRBASEs can be added and removed using the Core.Set#SET_AIRBASE.AddAirbasesByName and Core.Set#SET_AIRBASE.RemoveAirbasesByName respectively.
---These methods take a single AIRBASE name or an array of AIRBASE names to be added or removed from SET_AIRBASE.
---
---## SET_AIRBASE filter criteria
---
---You can set filter criteria to define the set of clients within the SET_AIRBASE.
---Filter criteria are defined by:
---
---   * #SET_AIRBASE.FilterCoalitions: Builds the SET_AIRBASE with the airbases belonging to the coalition(s).
---
---Once the filter criteria have been set for the SET_AIRBASE, you can start filtering using:
---
---  * #SET_AIRBASE.FilterStart: Starts the filtering of the airbases within the SET_AIRBASE.
---
---## SET_AIRBASE iterators
---
---Once the filters have been defined and the SET_AIRBASE has been built, you can iterate the SET_AIRBASE with the available iterator methods.
---The iterator methods will walk the SET_AIRBASE set, and call for each airbase within the set a function that you provide.
---The following iterator methods are currently available within the SET_AIRBASE:
---
---  * #SET_AIRBASE.ForEachAirbase: Calls a function for each airbase it finds within the SET_AIRBASE.
---
---===
---@class SET_AIRBASE : SET_BASE
SET_AIRBASE = {}

---Add an AIRBASE object to SET_AIRBASE.
---
------
---@param self SET_AIRBASE 
---@param airbase AIRBASE Airbase that should be added to the set.
---@return  #self
function SET_AIRBASE:AddAirbase(airbase) end

---Add AIRBASEs to SET_AIRBASE.
---
------
---@param self SET_AIRBASE 
---@param AddAirbaseNames string A single name or an array of AIRBASE names.
---@return  #self
function SET_AIRBASE:AddAirbasesByName(AddAirbaseNames) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_AIRBASE 
---@param Event EVENTDATA Event data.
---@return string #The name of the AIRBASE.
---@return AIRBASE #The AIRBASE object.
function SET_AIRBASE:AddInDatabase(Event) end

---Builds a set of airbases out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_AIRBASE 
---@param Categories string Can take the following values: "airdrome", "helipad", "ship".
---@return SET_AIRBASE #self
function SET_AIRBASE:FilterCategories(Categories) end

---Builds a set of airbases of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_AIRBASE 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_AIRBASE #self
function SET_AIRBASE:FilterCoalitions(Coalitions) end

---Starts the filtering.
---
------
---@param self SET_AIRBASE 
---@return SET_AIRBASE #self
function SET_AIRBASE:FilterStart() end

---Builds a set of airbase objects in zones.
---
------
---@param self SET_AIRBASE 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_AIRBASE #self
function SET_AIRBASE:FilterZones(Zones) end

---Finds a Airbase based on the Airbase Name.
---
------
---@param self SET_AIRBASE 
---@param AirbaseName string 
---@return AIRBASE #The found Airbase.
function SET_AIRBASE:FindAirbase(AirbaseName) end

---Finds an Airbase in range of a coordinate.
---
------
---@param self SET_AIRBASE 
---@param Coordinate COORDINATE 
---@param Range number 
---@return AIRBASE #The found Airbase.
function SET_AIRBASE:FindAirbaseInRange(Coordinate, Range) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_AIRBASE 
---@param Event EVENTDATA Event data.
---@return string #The name of the AIRBASE.
---@return AIRBASE #The AIRBASE object.
function SET_AIRBASE:FindInDatabase(Event) end

---Iterate the SET_AIRBASE while identifying the nearest Wrapper.Airbase#AIRBASE from a Core.Point#COORDINATE.
---
------
---@param self SET_AIRBASE 
---@param Coordinate COORDINATE A @{Core.Point#COORDINATE} object from where to evaluate the closest @{Wrapper.Airbase#AIRBASE}.
---@return AIRBASE #The closest @{Wrapper.Airbase#AIRBASE}.
function SET_AIRBASE:FindNearestAirbaseFromPointVec2(Coordinate) end

---Iterate the SET_AIRBASE and call an iterator function for each AIRBASE, providing the AIRBASE and optional parameters.
---
------
---@param self SET_AIRBASE 
---@param IteratorFunction function The function that will be called when there is an alive AIRBASE in the SET_AIRBASE. The function needs to accept a AIRBASE parameter.
---@param ... NOTYPE 
---@return SET_AIRBASE #self
function SET_AIRBASE:ForEachAirbase(IteratorFunction, ...) end

---Finds a random Airbase in the set.
---
------
---@param self SET_AIRBASE 
---@return AIRBASE #The found Airbase.
function SET_AIRBASE:GetRandomAirbase() end


---
------
---@param self SET_AIRBASE 
---@param MAirbase AIRBASE 
---@return SET_AIRBASE #self
function SET_AIRBASE:IsIncludeObject(MAirbase) end

---Creates a new SET_AIRBASE object, building a set of airbases belonging to a coalitions and categories.
---
------
---
---USAGE
---```
----- Define a new SET_AIRBASE Object. The DatabaseSet will contain a reference to all Airbases.
---DatabaseSet = SET_AIRBASE:New()
---```
------
---@param self SET_AIRBASE 
---@return SET_AIRBASE #self
function SET_AIRBASE:New() end

---Base capturing event.
---
------
---@param self SET_AIRBASE 
---@param EventData EVENT 
function SET_AIRBASE:OnEventBaseCaptured(EventData) end

---Dead event.
---
------
---@param self SET_AIRBASE 
---@param EventData EVENT 
function SET_AIRBASE:OnEventDead(EventData) end

---Remove AIRBASEs from SET_AIRBASE.
---
------
---@param self SET_AIRBASE 
---@param RemoveAirbaseNames AIRBASE A single name or an array of AIRBASE names.
---@return  #self
function SET_AIRBASE:RemoveAirbasesByName(RemoveAirbaseNames) end


---The Core.Set#SET_BASE class defines the core functions that define a collection of objects.
---A SET provides iterators to iterate the SET, but will **temporarily** yield the ForEach iterator loop at defined **"intervals"** to the mail simulator loop.
---In this way, large loops can be done while not blocking the simulator main processing loop.
---The default **"yield interval"** is after 10 objects processed.
---The default **"time interval"** is after 0.001 seconds.
---
---## Add or remove objects from the SET
---
---Some key core functions are Core.Set#SET_BASE.Add and Core.Set#SET_BASE.Remove to add or remove objects from the SET in your logic.
---
---## Define the SET iterator **"yield interval"** and the **"time interval"**
---
---Modify the iterator intervals with the Core.Set#SET_BASE.SetIteratorIntervals method.
---You can set the **"yield interval"**, and the **"time interval"**. (See above).
---@class SET_BASE : BASE
---@field CallScheduler SCHEDULER 
---@field Database NOTYPE 
---@field Filter SET_BASE.Filters Filters
---@field Index table Table of indices.
---@field List table Unused table.
---@field Set table Table of objects.
SET_BASE = {}

---Adds a Core.Base#BASE object in the Core.Set#SET_BASE, using a given ObjectName as the index.
---
------
---@param self SET_BASE 
---@param ObjectName string The name of the object.
---@param Object BASE The object itself.
---@return BASE #The added BASE Object.
function SET_BASE:Add(ObjectName, Object) end

---Adds a Core.Base#BASE object in the Core.Set#SET_BASE, using the Object Name as the index.
---
------
---@param self SET_BASE 
---@param Object OBJECT 
---@return BASE #The added BASE Object.
function SET_BASE:AddObject(Object) end

---Add a SET to this set.
---
------
---@param self SET_BASE 
---@param SetToAdd SET_BASE Set to add.
---@return SET_BASE #self
function SET_BASE:AddSet(SetToAdd) end

---Clear the Objects in the Set.
---
------
---@param self SET_BASE 
---@param TriggerEvent boolean If `true`, an event remove is triggered for each group that is removed from the set.
---@return SET_BASE #self
function SET_BASE:Clear(TriggerEvent) end

---Compare two sets.
---
------
---@param self SET_BASE 
---@param SetA SET_BASE First set.
---@param SetB SET_BASE Set to be merged into first set.
---@return SET_BASE #The set of objects that are included in SetA and SetB.
function SET_BASE:CompareSets(SetA, SetB) end

---Retrieves the amount of objects in the Core.Set#SET_BASE and derived classes.
---
------
---@param self SET_BASE 
---@return number #Count
function SET_BASE:Count() end

---Clear all filters.
---You still need to apply :FilterOnce()
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:FilterClear() end

---Starts the filtering of the Crash events for the collection.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:FilterCrashes() end

---Starts the filtering of the Dead events for the collection.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:FilterDeads() end

---[Internal] Add a functional filter
---
------
---@param self SET_BASE 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a CONTROLLABLE object as first argument.
---@param ... NOTYPE Condition function arguments, if any.
---@return boolean #If true, at least one condition is true
function SET_BASE:FilterFunction(ConditionFunction, ...) end

---Filters for the defined collection.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:FilterOnce() end

---Stops the filtering for the defined collection.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:FilterStop() end

---Iterate the SET_BASE while identifying the nearest object in the set from a Core.Point#COORDINATE.
---
------
---
---USAGE
---```
---         myset:FindNearestObjectFromPointVec2( ZONE:New("Test Zone"):GetCoordinate() )
---```
------
---@param self SET_BASE 
---@param Coordinate COORDINATE A @{Core.Point#COORDINATE} object (but **not** a simple DCS#Vec2!) from where to evaluate the closest object in the set.
---@return BASE #The closest object.
function SET_BASE:FindNearestObjectFromPointVec2(Coordinate) end

---Flushes the current SET_BASE contents in the log ...
---(for debugging reasons).
---
------
---@param self SET_BASE 
---@param MasterObject? BASE (Optional) The master object as a reference.
---@return string #A string with the names of the objects.
function SET_BASE:Flush(MasterObject) end

---Iterate the SET_BASE and derived classes and call an iterator function for the given SET_BASE, providing the Object for each element within the set and optional parameters.
---
------
---@param self SET_BASE 
---@param IteratorFunction function The function that will be called.
---@param arg table Arguments of the IteratorFunction.
---@param Set? SET_BASE (Optional) The set to use. Default self:GetSet().
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return SET_BASE #self
function SET_BASE:ForEach(IteratorFunction, arg, Set, Function, FunctionArguments) end

---Iterate the SET_BASE and derived classes and call an iterator function for the given SET_BASE, providing the Object for each element within the set and optional parameters.
---
------
---@param self SET_BASE 
---@param IteratorFunction function The function that will be called.
---@param arg NOTYPE 
---@param Set NOTYPE 
---@param Function NOTYPE 
---@param FunctionArguments NOTYPE 
---@return SET_BASE #self
function SET_BASE:ForSome(IteratorFunction, arg, Set, Function, FunctionArguments) end

---Gets a Core.Base#BASE object from the Core.Set#SET_BASE and derived classes, based on the Object Name.
---
------
---@param self SET_BASE 
---@param ObjectName string 
---@return BASE #
function SET_BASE:Get(ObjectName) end

---Gets the first object from the Core.Set#SET_BASE and derived classes.
---
------
---@param self SET_BASE 
---@return BASE #
function SET_BASE:GetFirst() end

---Gets the last object from the Core.Set#SET_BASE and derived classes.
---
------
---@param self SET_BASE 
---@return BASE #
function SET_BASE:GetLast() end

---Gets a string with all the object names.
---
------
---@param self SET_BASE 
---@return string #A string with the names of the objects.
function SET_BASE:GetObjectNames() end

---Gets a random object from the Core.Set#SET_BASE and derived classes.
---
------
---@param self SET_BASE 
---@return BASE #or nil if none found or the SET is empty!
function SET_BASE:GetRandom() end

---Gets a random object from the Core.Set#SET_BASE and derived classes.
---A bit slower than #SET_BASE.GetRandom() but tries to ensure you get an object back if the SET is not empty.
---
------
---@param self SET_BASE 
---@return BASE #or nil if  the SET is empty!
function SET_BASE:GetRandomSurely() end

---Gets the Set.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:GetSet() end

---Get the *complement* of two sets.
---
------
---@param self SET_BASE 
---@param SetB SET_BASE Set other set, called *B*.
---@return SET_BASE #The set of objects that are in set *B* but **not** in this set *A*.
function SET_BASE:GetSetComplement(SetB) end

---Get the *intersection* of this set, called *A*, and another set.
---
------
---@param self SET_BASE 
---@param SetB SET_BASE Set other set, called *B*.
---@return SET_BASE #A set of objects that is included in set *A* **and** in set *B*.
function SET_BASE:GetSetIntersection(SetB) end

---Gets a list of the Names of the Objects in the Set.
---
------
---@param self SET_BASE 
---@return table #Table of names.
function SET_BASE:GetSetNames() end

---Returns a table of the Objects in the Set.
---
------
---@param self SET_BASE 
---@return table #Table of objects.
function SET_BASE:GetSetObjects() end

---Get the *union* of two sets.
---
------
---@param self SET_BASE 
---@param SetB SET_BASE Set *B*.
---@return SET_BASE #The union set, i.e. contains objects that are in set *A* **or** in set *B*.
function SET_BASE:GetSetUnion(SetB) end

---Get the SET iterator **"limit"**.
---
------
---@param self SET_BASE 
---@return number #Defines how many objects are evaluated of the set as part of the Some iterators.
function SET_BASE:GetSomeIteratorLimit() end

---Get max threat level of all objects in the SET.
---
------
---@param self SET_BASE 
---@return number #Max threat level found.
function SET_BASE:GetThreatLevelMax() end

---Decides whether an object is in the SET
---
------
---@param self SET_BASE 
---@param Object table 
---@return boolean #`true` if object is in set and `false` otherwise.
function SET_BASE:IsInSet(Object) end

---Decides whether to include the Object.
---
------
---@param self SET_BASE 
---@param Object table 
---@return SET_BASE #self
function SET_BASE:IsIncludeObject(Object) end

---Decides whether an object is **not** in the SET
---
------
---@param self SET_BASE 
---@param Object table 
---@return SET_BASE #self
function SET_BASE:IsNotInSet(Object) end

---Creates a new SET_BASE object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_BASE Object. This DBObject will contain a reference to all Group and Unit Templates defined within the ME and the DCSRTE.
---DBObject = SET_BASE:New()
---```
------
---@param self SET_BASE 
---@param Database NOTYPE 
---@return SET_BASE #
function SET_BASE:New(Database) end

---Added Handler OnAfter for SET_BASE
---
------
---@param self SET_BASE 
---@param From string 
---@param Event string 
---@param To string 
---@param ObjectName string The name of the object.
---@param Object NOTYPE The object.
function SET_BASE:OnAfterAdded(From, Event, To, ObjectName, Object) end

---Removed Handler OnAfter for SET_BASE
---
------
---@param self SET_BASE 
---@param From string 
---@param Event string 
---@param To string 
---@param ObjectName string The name of the object.
---@param Object NOTYPE The object.
function SET_BASE:OnAfterRemoved(From, Event, To, ObjectName, Object) end

---Removes a Core.Base#BASE object from the Core.Set#SET_BASE and derived classes, based on the Object Name.
---
------
---@param self SET_BASE 
---@param ObjectName string 
---@param NoTriggerEvent? boolean (Optional) When `true`, the :Remove() method will not trigger a **Removed** event.
function SET_BASE:Remove(ObjectName, NoTriggerEvent) end

---Copies the Filter criteria from a given Set (for rebuilding a new Set based on an existing Set).
---
------
---@param self SET_BASE 
---@param BaseSet SET_BASE 
---@return SET_BASE #
function SET_BASE:SetDatabase(BaseSet) end

---Define the SET iterator **"limit"**.
---
------
---@param self SET_BASE 
---@param Limit number Defines how many objects are evaluated of the set as part of the Some iterators. The default is 1.
---@return SET_BASE #self
function SET_BASE:SetSomeIteratorLimit(Limit) end

---Sort the set by name.
---
------
---@param self SET_BASE 
---@return BASE #The added BASE Object.
function SET_BASE:SortByName() end

---[Internal] Check if the condition functions returns true.
---
------
---@param self SET_BASE 
---@param Object CONTROLLABLE The object to filter for
---@return boolean #If true, if **all** conditions are true
function SET_BASE:_EvalFilterFunctions(Object) end

---Handles the OnBirth event for the Set.
---
------
---@param self SET_BASE 
---@param Event EVENTDATA 
function SET_BASE:_EventOnBirth(Event) end

---Handles the OnDead or OnCrash event for alive units set.
---
------
---@param self SET_BASE 
---@param Event EVENTDATA 
function SET_BASE:_EventOnDeadOrCrash(Event) end

---Starts the filtering for the defined collection.
---
------
---@param self SET_BASE 
---@return SET_BASE #self
function SET_BASE:_FilterStart() end

---Finds an Core.Base#BASE object based on the object Name.
---
------
---@param self SET_BASE 
---@param ObjectName string 
---@return BASE #The Object found.
function SET_BASE:_Find(ObjectName) end


---Filters
---@class SET_BASE.Filters 
---@field Coalition table Coalitions
---@field Functions table 
---@field Prefix table Prefixes.
SET_BASE.Filters = {}


---Mission designers can use the Core.Set#SET_CARGO class to build sets of cargos optionally belonging to certain:
---
--- * Coalitions
--- * Types
--- * Name or Prefix
---
---## SET_CARGO constructor
---
---Create a new SET_CARGO object with the #SET_CARGO.New method:
---
---   * #SET_CARGO.New: Creates a new SET_CARGO object.
---
---## Add or Remove CARGOs from SET_CARGO
---
---CARGOs can be added and removed using the Core.Set#SET_CARGO.AddCargosByName and Core.Set#SET_CARGO.RemoveCargosByName respectively.
---These methods take a single CARGO name or an array of CARGO names to be added or removed from SET_CARGO.
---
---## SET_CARGO filter criteria
---
---You can set filter criteria to automatically maintain the SET_CARGO contents.
---Filter criteria are defined by:
---
---   * #SET_CARGO.FilterCoalitions: Builds the SET_CARGO with the cargos belonging to the coalition(s).
---   * #SET_CARGO.FilterPrefixes: Builds the SET_CARGO with the cargos containing the same string(s). **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_CARGO.FilterTypes: Builds the SET_CARGO with the cargos belonging to the cargo type(s).
---   * #SET_CARGO.FilterCountries: Builds the SET_CARGO with the cargos belonging to the country(ies).
---
---Once the filter criteria have been set for the SET_CARGO, you can start filtering using:
---
---  * #SET_CARGO.FilterStart: Starts the filtering of the cargos within the SET_CARGO.
---
---## SET_CARGO iterators
---
---Once the filters have been defined and the SET_CARGO has been built, you can iterate the SET_CARGO with the available iterator methods.
---The iterator methods will walk the SET_CARGO set, and call for each cargo within the set a function that you provide.
---The following iterator methods are currently available within the SET_CARGO:
---
---  * #SET_CARGO.ForEachCargo: Calls a function for each cargo it finds within the SET_CARGO.
---@class SET_CARGO : SET_BASE
SET_CARGO = {}

---(R2.1) Add CARGO to SET_CARGO.
---
------
---@param self SET_CARGO 
---@param Cargo CARGO A single cargo.
---@return SET_CARGO #self
function SET_CARGO:AddCargo(Cargo) end

---(R2.1) Add CARGOs to SET_CARGO.
---
------
---@param self SET_CARGO 
---@param AddCargoNames string A single name or an array of CARGO names.
---@return SET_CARGO #self
function SET_CARGO:AddCargosByName(AddCargoNames) end

---(R2.1) Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_CARGO 
---@param Event EVENTDATA 
---@return string #The name of the CARGO
---@return table #The CARGO
function SET_CARGO:AddInDatabase(Event) end

---(R2.1) Builds a set of cargos of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_CARGO 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_CARGO #self
function SET_CARGO:FilterCoalitions(Coalitions) end

---(R2.1) Builds a set of cargos of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_CARGO 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_CARGO #self
function SET_CARGO:FilterCountries(Countries) end

---Builds a set of CARGOs that contain a given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all cargos that **contain** the string.
---
------
---@param self SET_CARGO 
---@param Prefixes string The string pattern(s) that need to be in the cargo name. Can also be passed as a `#table` of strings.
---@return SET_CARGO #self
function SET_CARGO:FilterPrefixes(Prefixes) end

---(R2.1) Starts the filtering.
---
------
---@param self SET_CARGO 
---@return SET_CARGO #self
function SET_CARGO:FilterStart() end

---Stops the filtering for the defined collection.
---
------
---@param self SET_CARGO 
---@return SET_CARGO #self
function SET_CARGO:FilterStop() end

---(R2.1) Builds a set of cargos of defined cargo types.
---Possible current types are those types known within DCS world.
---
------
---@param self SET_CARGO 
---@param Types string Can take those type strings known within DCS world.
---@return SET_CARGO #self
function SET_CARGO:FilterTypes(Types) end

---(R2.1) Finds a Cargo based on the Cargo Name.
---
------
---@param self SET_CARGO 
---@param CargoName string 
---@return CARGO #The found Cargo.
function SET_CARGO:FindCargo(CargoName) end

---(R2.1) Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_CARGO 
---@param Event EVENTDATA 
---@return string #The name of the CARGO
---@return table #The CARGO
function SET_CARGO:FindInDatabase(Event) end

---(R2.1) Iterate the SET_CARGO while identifying the nearest Cargo.Cargo#CARGO from a Core.Point#COORDINATE.
---
------
---@param self SET_CARGO 
---@param Coordinate COORDINATE A @{Core.Point#COORDINATE} object from where to evaluate the closest @{Cargo.Cargo#CARGO}.
---@return CARGO #The closest @{Cargo.Cargo#CARGO}.
function SET_CARGO:FindNearestCargoFromPointVec2(Coordinate) end

---Iterate the SET_CARGO while identifying the first Cargo.Cargo#CARGO that is Deployed.
---
------
---@param self SET_CARGO 
---@return CARGO #The first @{Cargo.Cargo#CARGO}.
function SET_CARGO:FirstCargoDeployed() end

---Iterate the SET_CARGO while identifying the first Cargo.Cargo#CARGO that is Loaded.
---
------
---@param self SET_CARGO 
---@return CARGO #The first @{Cargo.Cargo#CARGO}.
function SET_CARGO:FirstCargoLoaded() end

---Iterate the SET_CARGO while identifying the first Cargo.Cargo#CARGO that is UnLoaded.
---
------
---@param self SET_CARGO 
---@return CARGO #The first @{Cargo.Cargo#CARGO}.
function SET_CARGO:FirstCargoUnLoaded() end

---Iterate the SET_CARGO while identifying the first Cargo.Cargo#CARGO that is UnLoaded and not Deployed.
---
------
---@param self SET_CARGO 
---@return CARGO #The first @{Cargo.Cargo#CARGO}.
function SET_CARGO:FirstCargoUnLoadedAndNotDeployed() end


---
------
---@param self SET_CARGO 
---@param State NOTYPE 
function SET_CARGO:FirstCargoWithState(State) end


---
------
---@param self SET_CARGO 
---@param State NOTYPE 
function SET_CARGO:FirstCargoWithStateAndNotDeployed(State) end

---(R2.1) Iterate the SET_CARGO and call an iterator function for each CARGO, providing the CARGO and optional parameters.
---
------
---@param self SET_CARGO 
---@param IteratorFunction function The function that will be called when there is an alive CARGO in the SET_CARGO. The function needs to accept a CARGO parameter.
---@param ... NOTYPE 
---@return SET_CARGO #self
function SET_CARGO:ForEachCargo(IteratorFunction, ...) end

---(R2.1)
---
------
---@param self SET_CARGO 
---@param MCargo AI_CARGO 
---@return SET_CARGO #self
function SET_CARGO:IsIncludeObject(MCargo) end

---Creates a new SET_CARGO object, building a set of cargos belonging to a coalitions and categories.
---
------
---
---USAGE
---```
----- Define a new SET_CARGO Object. The DatabaseSet will contain a reference to all Cargos.
---DatabaseSet = SET_CARGO:New()
---```
------
---@param self SET_CARGO 
---@return SET_CARGO #
function SET_CARGO:New() end

---(R2.1) Handles the OnDead or OnCrash event for alive units set.
---
------
---@param self SET_CARGO 
---@param EventData EVENTDATA 
function SET_CARGO:OnEventDeleteCargo(EventData) end

---(R2.1) Handles the OnEventNewCargo event for the Set.
---
------
---@param self SET_CARGO 
---@param EventData EVENTDATA 
function SET_CARGO:OnEventNewCargo(EventData) end

---(R2.1) Remove CARGOs from SET_CARGO.
---
------
---@param self SET_CARGO 
---@param RemoveCargoNames CARGO A single name or an array of CARGO names.
---@return SET_CARGO #self
function SET_CARGO:RemoveCargosByName(RemoveCargoNames) end


---Mission designers can use the Core.Set#SET_CLIENT class to build sets of units belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Client types
--- * Starting with certain prefix strings.
---
---## 1) SET_CLIENT constructor
---
---Create a new SET_CLIENT object with the #SET_CLIENT.New method:
---
---   * #SET_CLIENT.New: Creates a new SET_CLIENT object.
---
---## 2) Add or Remove CLIENT(s) from SET_CLIENT
---
---CLIENTs can be added and removed using the Core.Set#SET_CLIENT.AddClientsByName and Core.Set#SET_CLIENT.RemoveClientsByName respectively.
---These methods take a single CLIENT name or an array of CLIENT names to be added or removed from SET_CLIENT.
---
---## 3) SET_CLIENT filter criteria
---
---You can set filter criteria to define the set of clients within the SET_CLIENT.
---Filter criteria are defined by:
---
---   * #SET_CLIENT.FilterCoalitions: Builds the SET_CLIENT with the clients belonging to the coalition(s).
---   * #SET_CLIENT.FilterCategories: Builds the SET_CLIENT with the clients belonging to the category(ies).
---   * #SET_CLIENT.FilterTypes: Builds the SET_CLIENT with the clients belonging to the client type(s).
---   * #SET_CLIENT.FilterCountries: Builds the SET_CLIENT with the clients belonging to the country(ies).
---   * #SET_CLIENT.FilterPrefixes: Builds the SET_CLIENT with the clients containing the same string(s) in their unit/pilot name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_CLIENT.FilterActive: Builds the SET_CLIENT with the units that are only active. Units that are inactive (late activation) won't be included in the set!
---   * #SET_CLIENT.FilterZones: Builds the SET_CLIENT with the clients within a Core.Zone#ZONE.
---   * #SET_CLIENT.FilterFunction: Builds the SET_CLIENT with a custom condition.
---   
---Once the filter criteria have been set for the SET_CLIENT, you can start filtering using:
---
---  * #SET_CLIENT.FilterStart: Starts the filtering of the clients **dynamically**.
---  * #SET_CLIENT.FilterOnce: Filters the clients **once**.
---
---## 4) SET_CLIENT iterators
---
---Once the filters have been defined and the SET_CLIENT has been built, you can iterate the SET_CLIENT with the available iterator methods.
---The iterator methods will walk the SET_CLIENT set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_CLIENT:
---
---  * #SET_CLIENT.ForEachClient: Calls a function for each alive client it finds within the SET_CLIENT.
---
---===
---@class SET_CLIENT : SET_BASE
---@field ZoneTimer TIMER 
---@field ZoneTimerInterval number 
SET_CLIENT = {}

---Add CLIENT(s) to SET_CLIENT.
---
------
---@param self SET_CLIENT 
---@param AddClientNames string A single name or an array of CLIENT names.
---@return  #self
function SET_CLIENT:AddClientsByName(AddClientNames) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_CLIENT 
---@param Event EVENTDATA 
---@return string #The name of the CLIENT
---@return table #The CLIENT
function SET_CLIENT:AddInDatabase(Event) end

---Iterate the SET_CLIENT and count alive units.
---
------
---@param self SET_CLIENT 
---@return number #count
function SET_CLIENT:CountAlive() end

---Builds a set of clients that are only active.
---Only the clients that are active will be included within the set.
---
------
---
---USAGE
---```
---
----- Include only active clients to the set.
---ClientSet = SET_CLIENT:New():FilterActive():FilterStart()
---
----- Include only active clients to the set of the blue coalition, and filter one time.
---ClientSet = SET_CLIENT:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---
----- Include only active clients to the set of the blue coalition, and filter one time.
----- Later, reset to include back inactive clients to the set.
---ClientSet = SET_CLIENT:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---... logic ...
---ClientSet = SET_CLIENT:New():FilterActive( false ):FilterCoalition( "blue" ):FilterOnce()
---```
------
---@param self SET_CLIENT 
---@param Active? boolean (Optional) Include only active clients to the set. Include inactive clients if you provide false.
---@return SET_CLIENT #self
function SET_CLIENT:FilterActive(Active) end

---Builds a set of units which exist and are alive.
---
------
---@param self SET_CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:FilterAlive() end

---Builds a set of clients of certain callsigns.
---
------
---@param self SET_CLIENT 
---@param Callsigns string Can be a single string e.g. "Ford", or a table of strings e.g. {"Uzi","Enfield","Chevy"}. Refers to the callsigns as they can be set in the mission editor.
---@return SET_CLIENT #self
function SET_CLIENT:FilterCallsigns(Callsigns) end

---Builds a set of clients out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_CLIENT 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_CLIENT #self
function SET_CLIENT:FilterCategories(Categories) end

---Builds a set of clients of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_CLIENT 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_CLIENT #self
function SET_CLIENT:FilterCoalitions(Coalitions) end

---Builds a set of clients of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_CLIENT 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_CLIENT #self
function SET_CLIENT:FilterCountries(Countries) end

---[User] Add a custom condition function.
---
------
---
---USAGE
---```
---         -- Image you want to exclude a specific CLIENT from a SET:
---         local groundset = SET_CLIENT:New():FilterCoalitions("blue"):FilterActive(true):FilterFunction(
---         -- The function needs to take a UNIT object as first - and in this case, only - argument.
---         function(client)
---             local isinclude = true
---             if client:GetPlayerName() == "Exclude Me" then isinclude = false end
---             return isinclude
---         end
---         ):FilterOnce()
---         BASE:I(groundset:Flush())
---```
------
---@param self SET_CLIENT 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a CLIENT object as first argument.
---@param ... NOTYPE Condition function arguments if any.
---@return SET_CLIENT #self
function SET_CLIENT:FilterFunction(ConditionFunction, ...) end

---Builds a set of clients which belong to groups with certain **group names**.
---
------
---@param self SET_CLIENT 
---@param Prefixes string The (partial) group names to look for. Can be anywhere in the group name. Can be a single string or a table of strings.
---@return SET_CLIENT #self
function SET_CLIENT:FilterGroupPrefixes(Prefixes) end

---Builds a set of clients of certain playernames.
---
------
---@param self SET_CLIENT 
---@param Playernames string Can be a single string e.g. "Apple", or a table of strings e.g. {"Walter","Hermann","Gonzo"}. Useful if you have e.g. a common squadron prefix.
---@return SET_CLIENT #self
function SET_CLIENT:FilterPlayernames(Playernames) end

---Builds a set of CLIENTs that contain the given string in their **unit/pilot** name and **NOT** the group name!
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all clients that **contain** the string.
---Pattern matching applies.
---
------
---@param self SET_CLIENT 
---@param Prefixes string The string pattern(s) that needs to be contained in the unit/pilot name. Can also be passed as a `#table` of strings.
---@return SET_CLIENT #self
function SET_CLIENT:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:FilterStart() end

---Stops the filtering.
---
------
---@param self SET_CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:FilterStop() end

---Builds a set of clients of defined client types.
---Possible current types are those types known within DCS world.
---
------
---@param self SET_CLIENT 
---@param Types string Can take those type strings known within DCS world.
---@return SET_CLIENT #self
function SET_CLIENT:FilterTypes(Types) end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---
------
---@param self SET_CLIENT 
---@param Seconds number Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_CLIENT #self
function SET_CLIENT:FilterZoneTimer(Seconds) end

---Builds a set of clients in zones.
---
------
---@param self SET_CLIENT 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_CLIENT #self
function SET_CLIENT:FilterZones(Zones) end

---Finds a Client based on the Client Name.
---
------
---@param self SET_CLIENT 
---@param ClientName string 
---@return CLIENT #The found Client.
function SET_CLIENT:FindClient(ClientName) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_CLIENT 
---@param Event EVENTDATA 
---@return string #The name of the CLIENT
---@return table #The CLIENT
function SET_CLIENT:FindInDatabase(Event) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT, providing the CLIENT and optional parameters.
---
------
---@param self SET_CLIENT 
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_CLIENT #self
function SET_CLIENT:ForEachClient(IteratorFunction, ...) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT presence completely in a Core.Zone, providing the CLIENT and optional parameters to the called function.
---
------
---@param self SET_CLIENT 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_CLIENT #self
function SET_CLIENT:ForEachClientInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_CLIENT and call an iterator function for each **alive** CLIENT presence not in a Core.Zone, providing the CLIENT and optional parameters to the called function.
---
------
---@param self SET_CLIENT 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_CLIENT. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_CLIENT #self
function SET_CLIENT:ForEachClientNotInZone(ZoneObject, IteratorFunction, ...) end

---Gets the alive set.
---
------
---@param self SET_CLIENT 
---@return table #Table of SET objects
function SET_CLIENT:GetAliveSet() end

---Make the SET handle CA slots **only** (GROUND units used by any player).
---Needs active filtering with `FilterStart()`
---
------
---@param self SET_CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:HandleCASlots() end


---
------
---@param self SET_CLIENT 
---@param MClient CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:IsIncludeObject(MClient) end

---Creates a new SET_CLIENT object, building a set of clients belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_CLIENT Object. This DBObject will contain a reference to all Clients.
---DBObject = SET_CLIENT:New()
---```
------
---@param self SET_CLIENT 
---@return SET_CLIENT #
function SET_CLIENT:New() end

---Remove CLIENT(s) from SET_CLIENT.
---
------
---@param self SET_CLIENT 
---@param RemoveClientNames CLIENT A single object or an array of CLIENT objects.
---@return  #self
function SET_CLIENT:RemoveClientsByName(RemoveClientNames) end

---[Internal] Private function for use of continous zone filter
---
------
---@param self SET_CLIENT 
---@return SET_CLIENT #self
function SET_CLIENT:_ContinousZoneFilter() end

---Handle CA slots addition
---
------
---@param self SET_CLIENT 
---@param Event EVENTDATA 
---@return SET_CLIENT #self
function SET_CLIENT:_EventPlayerEnterUnit(Event) end

---Handle CA slots removal
---
------
---@param self SET_CLIENT 
---@param Event EVENTDATA 
---@return SET_CLIENT #self
function SET_CLIENT:_EventPlayerLeaveUnit(Event) end


---The Core.Set#SET_DYNAMICCARGO class defines the functions that define a collection of objects form Wrapper.DynamicCargo#DYNAMICCARGO.
---A SET provides iterators to iterate the SET.
---- Mission designers can use the SET_DYNAMICCARGO class to build sets of cargos belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Static types
--- * Starting with certain prefix strings.
--- * Etc.
---
---## SET_DYNAMICCARGO constructor
---
---Create a new SET_DYNAMICCARGO object with the #SET_DYNAMICCARGO.New method:
---
---   * #SET_DYNAMICCARGO.New: Creates a new SET_DYNAMICCARGO object.
---
---## SET_DYNAMICCARGO filter criteria
---
---You can set filter criteria to define the set of objects within the SET_DYNAMICCARGO.
---Filter criteria are defined by:
---
---   * #SET_DYNAMICCARGO.FilterCoalitions: Builds the SET_DYNAMICCARGO with the objects belonging to the coalition(s).
---   * #SET_DYNAMICCARGO.FilterTypes: Builds the SET_DYNAMICCARGO with the cargos belonging to the statiy type name(s).
---   * #SET_DYNAMICCARGO.FilterCountries: Builds the SET_DYNAMICCARGO with the objects belonging to the country(ies).
---   * #SET_DYNAMICCARGO.FilterNamePatterns, #SET_DYNAMICCARGO.FilterPrefixes: Builds the SET_DYNAMICCARGO with the cargo containing the same string(s) in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_DYNAMICCARGO.FilterZones: Builds the SET_DYNAMICCARGO with the cargo within a Core.Zone#ZONE.
---   * #SET_DYNAMICCARGO.FilterFunction: Builds the SET_DYNAMICCARGO with a custom condition.
---   * #SET_DYNAMICCARGO.FilterCurrentOwner: Builds the SET_DYNAMICCARGO with a specific owner name.
---   * #SET_DYNAMICCARGO.FilterIsLoaded: Builds the SET_DYNAMICCARGO which is in state LOADED.
---   * #SET_DYNAMICCARGO.FilterIsNew: Builds the SET_DYNAMICCARGO with is in state NEW.
---   * #SET_DYNAMICCARGO.FilterIsUnloaded: Builds the SET_DYNAMICCARGO with is in state UNLOADED.
---   
---Once the filter criteria have been set for the SET\_DYNAMICCARGO, you can start and stop filtering using:
---
---  * #SET_DYNAMICCARGO.FilterStart: Starts the continous filtering of the objects within the SET_DYNAMICCARGO.
---  * #SET_DYNAMICCARGO.FilterStop: Stops the continous filtering of the objects within the SET_DYNAMICCARGO.
---  * #SET_DYNAMICCARGO.FilterOnce: Filters once for the objects within the SET_DYNAMICCARGO.
---
---## SET_DYNAMICCARGO iterators
---
---Once the filters have been defined and the SET\_DYNAMICCARGO has been built, you can iterate the SET\_DYNAMICCARGO with the available iterator methods.
---The iterator methods will walk the SET\_DYNAMICCARGO set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET\_DYNAMICCARGO:
---
---  * #SET_DYNAMICCARGO.ForEach: Calls a function for each alive dynamic cargo it finds within the SET\_DYNAMICCARGO.
---
---## SET_DYNAMICCARGO atomic methods
---
---Various methods exist for a SET_DYNAMICCARGO to perform actions or calculations and retrieve results from the SET\_DYNAMICCARGO:
---
---  * #SET_DYNAMICCARGO.GetOwnerClientObjects(): Retrieve the type names of the Wrapper.Statics in the SET, delimited by a comma.
---  * #SET_DYNAMICCARGO.GetOwnerNames(): Retrieve the type names of the Wrapper.Statics in the SET, delimited by a comma.
---  * #SET_DYNAMICCARGO.GetStorageObjects(): Retrieve the type names of the Wrapper.Statics in the SET, delimited by a comma.  
---
---===
---@class SET_DYNAMICCARGO : SET_BASE
---@field CallScheduler SCHEDULER 
---@field Filter SET_DYNAMICCARGO.Filters Filters.
---@field Index table Table of indices.
---@field List table Unused table.
---@field Set table Table of objects.
---@field ZoneTimer TIMER Timer for active filtering of zones.
---@field ZoneTimerInterval number 
SET_DYNAMICCARGO = {}

---Builds a set of dynamic cargo of defined coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_DYNAMICCARGO 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterCoalitions(Coalitions) end

---Builds a set of dynamic cargo of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_DYNAMICCARGO 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterCountries(Countries) end

---This filter is N/A for SET_DYNAMICCARGO
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterCrashes() end

---Builds a set of DYNAMICCARGOs that are owned at the moment by this player name.
---
------
---@param self SET_DYNAMICCARGO 
---@param PlayerName string 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterCurrentOwner(PlayerName) end

---This filter is N/A for SET_DYNAMICCARGO
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterDeads() end

---[User] Add a custom condition function.
---
------
---
---USAGE
---```
---         -- Image you want to exclude a specific DYNAMICCARGO from a SET:
---         local cargoset = SET_DYNAMICCARGO:New():FilterCoalitions("blue"):FilterFunction(
---         -- The function needs to take a DYNAMICCARGO object as first - and in this case, only - argument.
---         function(dynamiccargo)
---             local isinclude = true
---             if dynamiccargo:GetName() == "Exclude Me" then isinclude = false end
---             return isinclude
---         end
---         ):FilterOnce()
---         BASE:I(cargoset:Flush())
---```
------
---@param self SET_DYNAMICCARGO 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a DYNAMICCARGO object as first argument.
---@param ... NOTYPE Condition function arguments if any.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterFunction(ConditionFunction, ...) end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.LOADED (i.e.
---is on board of a Chinook).
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterIsLoaded() end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.NEW (i.e.
---new and never loaded into a Chinook).
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterIsNew() end

---Builds a set of DYNAMICCARGOs that are in state DYNAMICCARGO.State.LOADED (i.e.
---was on board of a Chinook previously and is now unloaded).
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterIsUnloaded() end

---Builds a set of DYNAMICCARGOs that contain the given string in their name.
---**Attention!** LUA Regex applies!
---
------
---@param self SET_DYNAMICCARGO 
---@param Patterns string The string pattern(s) that need to be contained in the dynamic cargo name. Can also be passed as a `#table` of strings.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterNamePattern(Patterns) end

---Builds a set of DYNAMICCARGOs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all names that **contain** the string. LUA Regex applies.
---
------
---@param self SET_DYNAMICCARGO 
---@param Prefixes string The string pattern(s) that need to be contained in the dynamic cargo name. Can also be passed as a `#table` of strings.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterStart() end

---Stops the filtering.
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterStop() end

---Builds a set of dynamic cargo of defined dynamic cargo type names.
---
------
---@param self SET_DYNAMICCARGO 
---@param Types string Can take those type name strings known within DCS world.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterTypes(Types) end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---
------
---@param self SET_DYNAMICCARGO 
---@param Seconds number Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Objects are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterZoneTimer(Seconds) end

---Builds a set of dynamic cargo in zones.
---
------
---@param self SET_DYNAMICCARGO 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:FilterZones(Zones) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_DYNAMICCARGO event or vise versa!
---
------
---@param self SET_DYNAMICCARGO 
---@param Event EVENTDATA 
---@return string #The name of the DYNAMICCARGO
---@return DYNAMICCARGO #The DYNAMICCARGO object
function SET_DYNAMICCARGO:FindInDatabase(Event) end

---Returns a list of current owners (Wrapper.Client#CLIENT objects) indexed by playername from the SET.
---
------
---@param self SET_DYNAMICCARGO 
---@return list #Ownerlist
function SET_DYNAMICCARGO:GetOwnerClientObjects() end

---Returns a list of current owners (playernames) indexed by playername from the SET.
---
------
---@param self SET_DYNAMICCARGO 
---@return list #Ownerlist
function SET_DYNAMICCARGO:GetOwnerNames() end

---Returns a list of Wrapper.Storage#STORAGE objects from the SET indexed by cargo name.
---
------
---@param self SET_DYNAMICCARGO 
---@return list #Storagelist
function SET_DYNAMICCARGO:GetStorageObjects() end


---
------
---@param self SET_DYNAMICCARGO 
---@param DCargo DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:IsIncludeObject(DCargo) end

---Creates a new SET_DYNAMICCARGO object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_DYNAMICCARGO Object. This DBObject will contain a reference to all alive Statics.
---DBObject = SET_DYNAMICCARGO:New()
---```
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #
function SET_DYNAMICCARGO:New() end

---[Internal] Private function for use of continous zone filter
---
------
---@param self SET_DYNAMICCARGO 
---@return SET_DYNAMICCARGO #self
function SET_DYNAMICCARGO:_ContinousZoneFilter() end

---Handles the events for the Set.
---
------
---@param self SET_DYNAMICCARGO 
---@param Event EVENTDATA 
function SET_DYNAMICCARGO:_EventHandlerDCAdd(Event) end

---Handles the remove event for dynamic cargo set.
---
------
---@param self SET_DYNAMICCARGO 
---@param Event EVENTDATA 
function SET_DYNAMICCARGO:_EventHandlerDCRemove(Event) end


---@class SET_DYNAMICCARGO.Filters 
---@field Coalitions string 
---@field Countries string 
---@field StaticPrefixes string 
---@field Types string 
---@field Zones string 
SET_DYNAMICCARGO.Filters = {}


---Mission designers can use the Core.Set#SET_GROUP class to build sets of groups belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Starting with certain prefix strings.
---
---## SET_GROUP constructor
---
---Create a new SET_GROUP object with the #SET_GROUP.New method:
---
---   * #SET_GROUP.New: Creates a new SET_GROUP object.
---
---## Add or Remove GROUP(s) from SET_GROUP
---
---GROUPS can be added and removed using the Core.Set#SET_GROUP.AddGroupsByName and Core.Set#SET_GROUP.RemoveGroupsByName respectively.
---These methods take a single GROUP name or an array of GROUP names to be added or removed from SET_GROUP.
---
---## SET_GROUP filter criteria
---
---You can set filter criteria to define the set of groups within the SET_GROUP.
---Filter criteria are defined by:
---
---   * #SET_GROUP.FilterCoalitions: Builds the SET_GROUP with the groups belonging to the coalition(s).
---   * #SET_GROUP.FilterCategories: Builds the SET_GROUP with the groups belonging to the category(ies).
---   * #SET_GROUP.FilterCountries: Builds the SET_GROUP with the groups belonging to the country(ies).
---   * #SET_GROUP.FilterPrefixes: Builds the SET_GROUP with the groups *containing* the given string in the group name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_GROUP.FilterActive: Builds the SET_GROUP with the groups that are only active. Groups that are inactive (late activation) won't be included in the set!
---
---For the Category Filter, extra methods have been added:
---
---   * #SET_GROUP.FilterCategoryAirplane: Builds the SET_GROUP from airplanes.
---   * #SET_GROUP.FilterCategoryHelicopter: Builds the SET_GROUP from helicopters.
---   * #SET_GROUP.FilterCategoryGround: Builds the SET_GROUP from ground vehicles or infantry.
---   * #SET_GROUP.FilterCategoryShip: Builds the SET_GROUP from ships.
---   * #SET_GROUP.FilterCategoryStructure: Builds the SET_GROUP from structures.
---   * #SET_GROUP.FilterZones: Builds the SET_GROUP with the groups within a Core.Zone#ZONE.
---   * #SET_GROUP.FilterFunction: Builds the SET_GROUP with a custom condition.
---
---Once the filter criteria have been set for the SET_GROUP, you can start filtering using:
---
---   * #SET_GROUP.FilterStart: Starts the filtering of the groups within the SET_GROUP and add or remove GROUP objects **dynamically**.
---   * #SET_GROUP.FilterOnce: Filters of the groups **once**.
---
---## SET_GROUP iterators
---
---Once the filters have been defined and the SET_GROUP has been built, you can iterate the SET_GROUP with the available iterator methods.
---The iterator methods will walk the SET_GROUP set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_GROUP:
---
---  * #SET_GROUP.ForEachGroup: Calls a function for each alive group it finds within the SET_GROUP.
---  * #SET_GROUP.ForEachGroupCompletelyInZone: Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence completely in a Core.Zone, providing the GROUP and optional parameters to the called function.
---  * #SET_GROUP.ForEachGroupPartlyInZone: Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence partly in a Core.Zone, providing the GROUP and optional parameters to the called function.
---  * #SET_GROUP.ForEachGroupNotInZone: Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence not in a Core.Zone, providing the GROUP and optional parameters to the called function.
---
---
---## SET_GROUP trigger events on the GROUP objects.
---
---The SET is derived from the FSM class, which provides extra capabilities to track the contents of the GROUP objects in the SET_GROUP.
---
---### When a GROUP object crashes or is dead, the SET_GROUP will trigger a **Dead** event.
---
---You can handle the event using the OnBefore and OnAfter event handlers.
---The event handlers need to have the parameters From, Event, To, GroupObject.
---The GroupObject is the GROUP object that is dead and within the SET_GROUP, and is passed as a parameter to the event handler.
---See the following example:
---
---       -- Create the SetCarrier SET_GROUP collection.
---
---       local SetHelicopter = SET_GROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
---
---       -- Put a Dead event handler on SetCarrier, to ensure that when a carrier is destroyed, that all internal parameters are reset.
---
---       function SetHelicopter:OnAfterDead( From, Event, To, GroupObject )
---         --self:F( { GroupObject = GroupObject:GetName() } )
---       end
---
---While this is a good example, there is a catch.
---Imagine you want to execute the code above, the the self would need to be from the object declared outside (above) the OnAfterDead method.
---So, the self would need to contain another object. Fortunately, this can be done, but you must use then the **`.`** notation for the method.
---See the modified example:
---
---       -- Now we have a constructor of the class AI_CARGO_DISPATCHER, that receives the SetHelicopter as a parameter.
---       -- Within that constructor, we want to set an enclosed event handler OnAfterDead for SetHelicopter.
---       -- But within the OnAfterDead method, we want to refer to the self variable of the AI_CARGO_DISPATCHER.
---
---       function AI_CARGO_DISPATCHER:New( SetCarrier, SetCargo, SetDeployZones )
---
---         local self = BASE:Inherit( self, FSM:New() ) -- #AI_CARGO_DISPATCHER
---
---         -- Put a Dead event handler on SetCarrier, to ensure that when a carrier is destroyed, that all internal parameters are reset.
---         -- Note the "." notation, and the explicit declaration of SetHelicopter, which would be using the ":" notation the implicit self variable declaration.
---
---         function SetHelicopter.OnAfterDead( SetHelicopter, From, Event, To, GroupObject )
---           SetHelicopter:F( { GroupObject = GroupObject:GetName() } )
---           self.PickupCargo[GroupObject] = nil  -- So here I clear the PickupCargo table entry of the self object AI_CARGO_DISPATCHER.
---           self.CarrierHome[GroupObject] = nil
---         end
---
---       end
---
---===
---@class SET_GROUP : SET_BASE
---@field ZoneTimer TIMER 
---@field ZoneTimerInterval number 
SET_GROUP = {}

---Activate late activated groups.
---
------
---@param self SET_GROUP 
---@param Delay number Delay in seconds.
---@return SET_GROUP #self
function SET_GROUP:Activate(Delay) end

---Add a GROUP to SET_GROUP.
---Note that for each unit in the group that is set, a default cargo bay limit is initialized.
---
------
---@param self SET_GROUP 
---@param group GROUP The group which should be added to the set.
---@param DontSetCargoBayLimit boolean If true, do not attempt to auto-add the cargo bay limit per unit in this group.
---@return SET_GROUP #self
function SET_GROUP:AddGroup(group, DontSetCargoBayLimit) end

---Add GROUP(s) to SET_GROUP.
---
------
---@param self SET_GROUP 
---@param AddGroupNames string A single name or an array of GROUP names.
---@return SET_GROUP #self
function SET_GROUP:AddGroupsByName(AddGroupNames) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_GROUP 
---@param Event EVENTDATA 
---@return string #The name of the GROUP
---@return table #The GROUP
function SET_GROUP:AddInDatabase(Event) end

---Iterate the SET_GROUP and return true if all the Wrapper.Group#GROUP are completely in the Core.Zone#ZONE
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---if MySetGroup:AllCompletelyInZone(MyZone) then
---  MESSAGE:New("All the SET's GROUP are in zone !", 10):ToAll()
---else
---  MESSAGE:New("Some or all SET's GROUP are outside zone !", 10):ToAll()
---end
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #true if all the @{Wrapper.Group#GROUP} are completely in the @{Core.Zone#ZONE}, false otherwise
function SET_GROUP:AllCompletelyInZone(Zone) end

---Iterate the SET_GROUP and return true if at least one of the Wrapper.Group#GROUP is completely inside the Core.Zone#ZONE
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---if MySetGroup:AnyCompletelyInZone(MyZone) then
---  MESSAGE:New("At least one GROUP is completely in zone !", 10):ToAll()
---else
---  MESSAGE:New("No GROUP is completely in zone !", 10):ToAll()
---end
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #true if at least one of the @{Wrapper.Group#GROUP} is completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyCompletelyInZone(Zone) end

---Iterate the SET_GROUP and return true if at least one #UNIT of one Wrapper.Group#GROUP of the #SET_GROUP is in Core.Zone
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---if MySetGroup:AnyPartlyInZone(MyZone) then
---  MESSAGE:New("At least one GROUP has at least one UNIT in zone !", 10):ToAll()
---else
---  MESSAGE:New("No UNIT of any GROUP is in zone !", 10):ToAll()
---end
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #true if at least one of the @{Wrapper.Group#GROUP} is partly or completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyInZone(Zone) end

---Iterate the SET_GROUP and return true if at least one Wrapper.Group#GROUP of the #SET_GROUP is partly in Core.Zone.
---Will return false if a Wrapper.Group#GROUP is fully in the Core.Zone
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---if MySetGroup:AnyPartlyInZone(MyZone) then
---  MESSAGE:New("At least one GROUP is partially in the zone, but none are fully in it !", 10):ToAll()
---else
---  MESSAGE:New("No GROUP are in zone, or one (or more) GROUP is completely in it !", 10):ToAll()
---end
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #true if at least one of the @{Wrapper.Group#GROUP} is partly or completely inside the @{Core.Zone#ZONE}, false otherwise.
function SET_GROUP:AnyPartlyInZone(Zone) end

---Iterate the SET_GROUP and count how many GROUPs and UNITs are alive.
---
------
---@param self SET_GROUP 
---@return number #The number of GROUPs alive.
---@return number #The number of UNITs alive.
function SET_GROUP:CountAlive() end

---Iterate the SET_GROUP and count how many GROUPs are completely in the Zone
---That could easily be done with SET_GROUP:ForEachGroupCompletelyInZone(), but this function
---provides an easy to use shortcut...
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---MESSAGE:New("There are " .. MySetGroup:CountInZone(MyZone) .. " GROUPs in the Zone !", 10):ToAll()
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return number #the number of GROUPs completely in the Zone
function SET_GROUP:CountInZone(Zone) end

---Iterate the SET_GROUP and count how many UNITs are completely in the Zone
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---MESSAGE:New("There are " .. MySetGroup:CountUnitInZone(MyZone) .. " UNITs in the Zone !", 10):ToAll()
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return number #the number of GROUPs completely in the Zone
function SET_GROUP:CountUnitInZone(Zone) end

---Builds a set of groups that are active, ie in the mission but not yet activated (false) or actived (true).
---Only the groups that are active will be included within the set.
---
------
---
---USAGE
---```
---
----- Include only active groups to the set.
---GroupSet = SET_GROUP:New():FilterActive():FilterStart()
---
----- Include only active groups to the set of the blue coalition, and filter one time.
---GroupSet = SET_GROUP:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---
----- Include only active groups to the set of the blue coalition, and filter one time.
----- Later, reset to include back inactive groups to the set.
---GroupSet = SET_GROUP:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---... logic ...
---GroupSet = SET_GROUP:New():FilterActive( false ):FilterCoalition( "blue" ):FilterOnce()
---```
------
---@param self SET_GROUP 
---@param Active? boolean (Optional) Include only active groups to the set. Include inactive groups if you provide false.
---@return SET_GROUP #self
function SET_GROUP:FilterActive(Active) end

---Build a set of groups that are alive.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterAlive() end

---Builds a set of groups out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_GROUP 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship".
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_GROUP #self
function SET_GROUP:FilterCategories(Categories, Clear) end

---Builds a set of groups out of airplane category.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterCategoryAirplane() end

---Builds a set of groups out of ground category.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterCategoryGround() end

---Builds a set of groups out of helicopter category.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterCategoryHelicopter() end

---Builds a set of groups out of ship category.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterCategoryShip() end

---Builds a set of groups out of structure category.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterCategoryStructure() end

---Builds a set of groups of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_GROUP 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_GROUP #self
function SET_GROUP:FilterCoalitions(Coalitions, Clear) end

---Builds a set of groups of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_GROUP 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_GROUP #self
function SET_GROUP:FilterCountries(Countries) end

---[User] Add a custom condition function.
---
------
---
---USAGE
---```
---         -- Image you want to exclude a specific GROUP from a SET:
---         local groundset = SET_GROUP:New():FilterCoalitions("blue"):FilterCategoryGround():FilterFunction(
---         -- The function needs to take a GROUP object as first - and in this case, only - argument.
---         function(grp)
---             local isinclude = true
---             if grp:GetName() == "Exclude Me" then isinclude = false end
---             return isinclude
---         end
---         ):FilterOnce()
---         BASE:I(groundset:Flush())
---```
------
---@param self SET_GROUP 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a GROUP object as first argument.
---@param ... NOTYPE Condition function arguments if any.
---@return SET_GROUP #self
function SET_GROUP:FilterFunction(ConditionFunction, ...) end

---Filter the set once
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterOnce() end

---Builds a set of groups that contain the given string in their group name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all groups that **contain** the string.
---
------
---@param self SET_GROUP 
---@param Prefixes string The string pattern(s) that needs to be contained in the group name. Can also be passed as a `#table` of strings.
---@return SET_GROUP #self
function SET_GROUP:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterStart() end

---Stops the filtering.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:FilterStop() end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---
------
---@param self SET_GROUP 
---@param Seconds number Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_GROUP #self
function SET_GROUP:FilterZoneTimer(Seconds) end

---Builds a set of groups in zones.
---
------
---@param self SET_GROUP 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_GROUP #self
function SET_GROUP:FilterZones(Zones, Clear) end

---Finds a Group based on the Group Name.
---
------
---@param self SET_GROUP 
---@param GroupName string 
---@return GROUP #The found Group.
function SET_GROUP:FindGroup(GroupName) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_GROUP 
---@param Event EVENTDATA 
---@return string #The name of the GROUP
---@return table #The GROUP
function SET_GROUP:FindInDatabase(Event) end

---Iterate the SET_GROUP while identifying the nearest object from a Core.Point#COORDINATE.
---
------
---@param self SET_GROUP 
---@param Coordinate COORDINATE A @{Core.Point#COORDINATE} object from where to evaluate the closest object in the set.
---@return GROUP #The closest group.
function SET_GROUP:FindNearestGroupFromPointVec2(Coordinate) end

---Iterate the SET_GROUP and call an iterator function for each GROUP object, providing the GROUP and optional parameters.
---
------
---@param self SET_GROUP 
---@param IteratorFunction function The function that will be called for all GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroup(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP object, providing the GROUP and optional parameters.
---
------
---@param self SET_GROUP 
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroupAlive(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each alive GROUP that has any unit in the Core.Zone, providing the GROUP and optional parameters to the called function.
---
------
---@param self SET_GROUP 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroupAnyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence completely in a Core.Zone, providing the GROUP and optional parameters to the called function.
---
------
---@param self SET_GROUP 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroupCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence not in a Core.Zone, providing the GROUP and optional parameters to the called function.
---
------
---@param self SET_GROUP 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroupNotInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for each **alive** GROUP presence partly in a Core.Zone, providing the GROUP and optional parameters to the called function.
---
------
---@param self SET_GROUP 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForEachGroupPartlyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for some GROUP objects, providing the GROUP and optional parameters.
---
------
---@param self SET_GROUP 
---@param IteratorFunction function The function that will be called for some GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForSomeGroup(IteratorFunction, ...) end

---Iterate the SET_GROUP and call an iterator function for some **alive** GROUP objects, providing the GROUP and optional parameters.
---
------
---@param self SET_GROUP 
---@param IteratorFunction function The function that will be called when there is an alive GROUP in the SET_GROUP. The function needs to accept a GROUP parameter.
---@param ... NOTYPE 
---@return SET_GROUP #self
function SET_GROUP:ForSomeGroupAlive(IteratorFunction, ...) end

---Get a *new* set that only contains alive groups.
---
------
---@param self SET_GROUP 
---@return SET_GROUP #Set of alive groups.
function SET_GROUP:GetAliveSet() end

---Get the closest group of the set with respect to a given reference coordinate.
---Optionally, only groups of given coalitions are considered in the search.
---
------
---@param self SET_GROUP 
---@param Coordinate COORDINATE Reference Coordinate from which the closest group is determined.
---@param Coalitions? table (Optional) Table of coalition #number entries to filter for.
---@return GROUP #The closest group (if any).
---@return number #Distance in meters to the closest group.
function SET_GROUP:GetClosestGroup(Coordinate, Coalitions) end

---Returns a report of of unit types.
---
------
---@param self SET_GROUP 
---@return REPORT #A report of the unit types found. The key is the UnitTypeName and the value is the amount of unit types found.
function SET_GROUP:GetUnitTypeNames() end


---
------
---@param self SET_GROUP 
---@param MGroup GROUP The group that is checked for inclusion.
---@return SET_GROUP #self
function SET_GROUP:IsIncludeObject(MGroup) end

---Creates a new SET_GROUP object, building a set of groups belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_GROUP Object. This DBObject will contain a reference to all alive GROUPS.
---DBObject = SET_GROUP:New()
---```
------
---@param self SET_GROUP 
---@return SET_GROUP #
function SET_GROUP:New() end

---Iterate the SET_GROUP and return true if no Wrapper.Group#GROUP of the #SET_GROUP is in Core.Zone
---This could also be achieved with `not SET_GROUP:AnyPartlyInZone(Zone)`, but it's easier for the
---mission designer to add a dedicated method
---
------
---
---USAGE
---```
---local MyZone = ZONE:New("Zone1")
---local MySetGroup = SET_GROUP:New()
---MySetGroup:AddGroupsByName({"Group1", "Group2"})
---
---if MySetGroup:NoneInZone(MyZone) then
---  MESSAGE:New("No GROUP is completely in zone !", 10):ToAll()
---else
---  MESSAGE:New("No UNIT of any GROUP is in zone !", 10):ToAll()
---end
---```
------
---@param self SET_GROUP 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #true if no @{Wrapper.Group#GROUP} is inside the @{Core.Zone#ZONE} in any way, false otherwise.
function SET_GROUP:NoneInZone(Zone) end

---Remove GROUP(s) from SET_GROUP.
---
------
---@param self SET_GROUP 
---@param RemoveGroupNames GROUP A single name or an array of GROUP names.
---@return SET_GROUP #self
function SET_GROUP:RemoveGroupsByName(RemoveGroupNames) end

---Iterate the SET_GROUP and set for each unit the default cargo bay weight limit.
---Because within a group, the type of carriers can differ, each cargo bay weight limit is set on Wrapper.Unit level.
---
------
---
---USAGE
---```
----- Set the default cargo bay weight limits of the carrier units.
---local MySetGroup = SET_GROUP:New()
---MySetGroup:SetCargoBayWeightLimit()
---```
------
---@param self SET_GROUP 
function SET_GROUP:SetCargoBayWeightLimit() end

---[Internal] Private function for use of continous zone filter
---
------
---@param self SET_GROUP 
---@return SET_GROUP #self
function SET_GROUP:_ContinousZoneFilter() end

---Handles the OnDead or OnCrash event for alive groups set.
---Note: The GROUP object in the SET_GROUP collection will only be removed if the last unit is destroyed of the GROUP.
---
------
---@param self SET_GROUP 
---@param Event EVENTDATA 
function SET_GROUP:_EventOnDeadOrCrash(Event) end


---Mission designers can use the Core.Set#SET_OPSGROUP class to build sets of OPS groups belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Contain a certain string pattern
---
---## SET_OPSGROUP constructor
---
---Create a new SET_OPSGROUP object with the #SET_OPSGROUP.New method:
---
---   * #SET_OPSGROUP.New: Creates a new SET_OPSGROUP object.
---
---## Add or Remove GROUP(s) from SET_OPSGROUP
---
---GROUPS can be added and removed using the Core.Set#SET_OPSGROUP.AddGroupsByName and Core.Set#SET_OPSGROUP.RemoveGroupsByName respectively.
---These methods take a single GROUP name or an array of GROUP names to be added or removed from SET_OPSGROUP.
---
---## SET_OPSGROUP filter criteria
---
---You can set filter criteria to define the set of groups within the SET_OPSGROUP.
---Filter criteria are defined by:
---
---   * #SET_OPSGROUP.FilterCoalitions: Builds the SET_OPSGROUP with the groups belonging to the coalition(s).
---   * #SET_OPSGROUP.FilterCategories: Builds the SET_OPSGROUP with the groups belonging to the category(ies).
---   * #SET_OPSGROUP.FilterCountries: Builds the SET_OPSGROUP with the groups belonging to the country(ies).
---   * #SET_OPSGROUP.FilterPrefixes: Builds the SET_OPSGROUP with the groups *containing* the given string in the group name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_OPSGROUP.FilterActive: Builds the SET_OPSGROUP with the groups that are only active. Groups that are inactive (late activation) won't be included in the set!
---
---For the Category Filter, extra methods have been added:
---
---   * #SET_OPSGROUP.FilterCategoryAirplane: Builds the SET_OPSGROUP from airplanes.
---   * #SET_OPSGROUP.FilterCategoryHelicopter: Builds the SET_OPSGROUP from helicopters.
---   * #SET_OPSGROUP.FilterCategoryGround: Builds the SET_OPSGROUP from ground vehicles or infantry.
---   * #SET_OPSGROUP.FilterCategoryShip: Builds the SET_OPSGROUP from ships.
---
---
---Once the filter criteria have been set for the SET_OPSGROUP, you can start filtering using:
---
---   * #SET_OPSGROUP.FilterStart: Starts the filtering of the groups within the SET_OPSGROUP and add or remove GROUP objects **dynamically**.
---   * #SET_OPSGROUP.FilterOnce: Filters of the groups **once**.
---
---
---## SET_OPSGROUP iterators
---
---Once the filters have been defined and the SET_OPSGROUP has been built, you can iterate the SET_OPSGROUP with the available iterator methods.
---The iterator methods will walk the SET_OPSGROUP set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_OPSGROUP:
---
---  * #SET_OPSGROUP.ForEachGroup: Calls a function for each alive group it finds within the SET_OPSGROUP.
---
---## SET_OPSGROUP trigger events on the GROUP objects.
---
---The SET is derived from the FSM class, which provides extra capabilities to track the contents of the GROUP objects in the SET_OPSGROUP.
---
---### When a GROUP object crashes or is dead, the SET_OPSGROUP will trigger a **Dead** event.
---
---You can handle the event using the OnBefore and OnAfter event handlers.
---The event handlers need to have the parameters From, Event, To, GroupObject.
---The GroupObject is the GROUP object that is dead and within the SET_OPSGROUP, and is passed as a parameter to the event handler.
---See the following example:
---
---       -- Create the SetCarrier SET_OPSGROUP collection.
---
---       local SetHelicopter = SET_OPSGROUP:New():FilterPrefixes( "Helicopter" ):FilterStart()
---
---       -- Put a Dead event handler on SetCarrier, to ensure that when a carrier is destroyed, that all internal parameters are reset.
---
---       function SetHelicopter:OnAfterDead( From, Event, To, GroupObject )
---         --self:F( { GroupObject = GroupObject:GetName() } )
---       end
---
---
---===
---@class SET_OPSGROUP : SET_BASE
SET_OPSGROUP = {}

---Activate late activated groups in the set.
---
------
---@param self SET_OPSGROUP 
---@param Delay number Delay in seconds.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:Activate(Delay) end

---Adds a Core.Base#BASE object in the Core.Set#SET_BASE, using a given ObjectName as the index.
---
------
---@param self SET_BASE 
---@param ObjectName string The name of the object.
---@param Object BASE The object itself.
---@return BASE #The added BASE Object.
function SET_OPSGROUP:Add(ObjectName, Object) end

---Add a GROUP or OPSGROUP object to the set.
---**NOTE** that an OPSGROUP is automatically created from the GROUP if it does not exist already.
---
------
---@param self SET_OPSGROUP 
---@param group GROUP The GROUP which should be added to the set. Can also be given as an #OPSGROUP object.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:AddGroup(group) end

---Add GROUP(s) or OPSGROUP(s) to the set.
---
------
---@param self SET_OPSGROUP 
---@param AddGroupNames string A single name or an array of GROUP names.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:AddGroupsByName(AddGroupNames) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_OPSGROUP 
---@param Event EVENTDATA Event data.
---@return string #The name of the GROUP.
---@return GROUP #The GROUP object.
function SET_OPSGROUP:AddInDatabase(Event) end

---Adds a Core.Base#BASE object in the Core.Set#SET_BASE, using the Object Name as the index.
---
------
---@param self SET_BASE 
---@param Object OPSGROUP Ops group
---@return BASE #The added BASE Object.
function SET_OPSGROUP:AddObject(Object) end

---Builds a set of groups that are only active.
---Only the groups that are active will be included within the set.
---
------
---
---USAGE
---```
---
----- Include only active groups to the set.
---GroupSet = SET_OPSGROUP:New():FilterActive():FilterStart()
---
----- Include only active groups to the set of the blue coalition, and filter one time.
---GroupSet = SET_OPSGROUP:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---
----- Include only active groups to the set of the blue coalition, and filter one time.
----- Later, reset to include back inactive groups to the set.
---GroupSet = SET_OPSGROUP:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---... logic ...
---GroupSet = SET_OPSGROUP:New():FilterActive( false ):FilterCoalition( "blue" ):FilterOnce()
---```
------
---@param self SET_OPSGROUP 
---@param Active? boolean (optional) Include only active groups to the set. Include inactive groups if you provide false.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterActive(Active) end

---Builds a set of groups out of categories.
---
---Possible current categories are:
---
---* "plane" for fixed wing groups
---* "helicopter" for rotary wing groups
---* "ground" for ground groups
---* "ship" for naval groups
---
------
---@param self SET_OPSGROUP 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship" or combinations as a table, for example `{"plane", "helicopter"}`.
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategories(Categories, Clear) end

---Builds a set of groups out of aicraft category (planes and helicopters).
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategoryAircraft() end

---Builds a set of groups out of airplane category.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategoryAirplane() end

---Builds a set of groups out of ground category.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategoryGround() end

---Builds a set of groups out of helicopter category.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategoryHelicopter() end

---Builds a set of groups out of ship category.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCategoryShip() end

---Builds a set of groups of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_OPSGROUP 
---@param Coalitions string Can take the following values: "red", "blue", "neutral" or combinations as a table, for example `{"red", "neutral"}`.
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCoalitions(Coalitions, Clear) end

---Builds a set of groups of defined countries.
---
------
---@param self SET_OPSGROUP 
---@param Countries string Can take those country strings known within DCS world.
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterCountries(Countries, Clear) end

---Builds a set of groups that contain the given string in their group name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all groups that **contain** the string.
---
------
---@param self SET_OPSGROUP 
---@param Prefixes string The string pattern(s) that needs to be contained in the group name. Can also be passed as a `#table` of strings.
---@param Clear boolean If `true`, clear any previously defined filters.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterPrefixes(Prefixes, Clear) end

---Starts the filtering.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:FilterStart() end

---Finds a ARMYGROUP based on the group name.
---
------
---@param self SET_OPSGROUP 
---@param GroupName string Name of the group.
---@return ARMYGROUP #The found ARMYGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindArmyGroup(GroupName) end

---Finds a FLIGHTGROUP based on the group name.
---
------
---@param self SET_OPSGROUP 
---@param GroupName string Name of the group.
---@return FLIGHTGROUP #The found FLIGHTGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindFlightGroup(GroupName) end

---Finds an OPSGROUP based on the group name.
---
------
---@param self SET_OPSGROUP 
---@param GroupName string Name of the group.
---@return OPSGROUP #The found OPSGROUP (FLIGHTGROUP, ARMYGROUP or NAVYGROUP) or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindGroup(GroupName) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_OPSGROUP 
---@param Event EVENTDATA Event data table.
---@return string #The name of the GROUP.
---@return GROUP #The GROUP object.
function SET_OPSGROUP:FindInDatabase(Event) end

---Finds a NAVYGROUP based on the group name.
---
------
---@param self SET_OPSGROUP 
---@param GroupName string Name of the group.
---@return NAVYGROUP #The found NAVYGROUP or `#nil` if the group is not in the set.
function SET_OPSGROUP:FindNavyGroup(GroupName) end

---Iterate the set and call an iterator function for each OPSGROUP object.
---
------
---@param self SET_OPSGROUP 
---@param IteratorFunction function The function that will be called for all OPSGROUPs in the set. **NOTE** that the function must have the OPSGROUP as first parameter!
---@param ...? NOTYPE (Optional) arguments passed to the `IteratorFunction`.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:ForEachGroup(IteratorFunction, ...) end

---Gets a **new** set that only contains alive groups.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:GetAliveSet() end

---Check include object.
---
------
---@param self SET_OPSGROUP 
---@param MGroup GROUP The group that is checked for inclusion.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:IsIncludeObject(MGroup) end

---Creates a new SET_OPSGROUP object, building a set of groups belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---@param self SET_OPSGROUP 
---@return SET_OPSGROUP #self
function SET_OPSGROUP:New() end

---Remove GROUP(s) or OPSGROUP(s) from the set.
---
------
---@param self SET_OPSGROUP 
---@param RemoveGroupNames GROUP A single name or an array of GROUP names.
---@return SET_OPSGROUP #self
function SET_OPSGROUP:RemoveGroupsByName(RemoveGroupNames) end

---Handles the OnBirth event for the Set.
---
------
---@param self SET_OPSGROUP 
---@param Event EVENTDATA Event data.
function SET_OPSGROUP:_EventOnBirth(Event) end

---Handles the OnDead or OnCrash event for alive groups set.
---Note: The GROUP object in the SET_OPSGROUP collection will only be removed if the last unit is destroyed of the GROUP.
---
------
---@param self SET_OPSGROUP 
---@param Event EVENTDATA 
function SET_OPSGROUP:_EventOnDeadOrCrash(Event) end


---Mission designers can use the Core.Set#SET_OPSZONE class to build sets of zones of various types.
---
---## SET_OPSZONE constructor
---
---Create a new SET_OPSZONE object with the #SET_OPSZONE.New method:
---
---   * #SET_OPSZONE.New: Creates a new SET_OPSZONE object.
---
---## Add or Remove ZONEs from SET_OPSZONE
---
---ZONEs can be added and removed using the Core.Set#SET_OPSZONE.AddZonesByName and Core.Set#SET_OPSZONE.RemoveZonesByName respectively.
---These methods take a single ZONE name or an array of ZONE names to be added or removed from SET_OPSZONE.
---
---## SET_OPSZONE filter criteria
---
---You can set filter criteria to build the collection of zones in SET_OPSZONE.
---Filter criteria are defined by:
---
---   * #SET_OPSZONE.FilterPrefixes: Builds the SET_OPSZONE with the zones having a certain text pattern in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---
---Once the filter criteria have been set for the SET_OPSZONE, you can start filtering using:
---
---  * #SET_OPSZONE.FilterStart: Starts the filtering of the zones within the SET_OPSZONE.
---
---## SET_OPSZONE iterators
---
---Once the filters have been defined and the SET_OPSZONE has been built, you can iterate the SET_OPSZONE with the available iterator methods.
---The iterator methods will walk the SET_OPSZONE set, and call for each airbase within the set a function that you provide.
---The following iterator methods are currently available within the SET_OPSZONE:
---
---  * #SET_OPSZONE.ForEachZone: Calls a function for each zone it finds within the SET_OPSZONE.
---
---===
---@class SET_OPSZONE : SET_BASE
SET_OPSZONE = {}

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_OPSZONE 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_OPSZONE:AddInDatabase(Event) end

---Add an OPSZONE to set.
---
------
---@param self SET_OPSZONE 
---@param Zone OPSZONE The OPSZONE object.
---@return SET_OPSZONE #self
function SET_OPSZONE:AddZone(Zone) end

---Clear all filters.
---You still need to apply `FilterOnce()` to have an effect on the set.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterClear() end

---Builds a set of groups of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_OPSZONE 
---@param Coalitions string Can take the following values: "red", "blue", "neutral" or combinations as a table, for example `{"red", "neutral"}`.
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterCoalitions(Coalitions) end

---Filters for the defined collection.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterOnce() end

---Builds a set of OPSZONEs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---
------
---@param self SET_OPSZONE 
---@param Prefixes string The string pattern(s) that needs to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterStart() end

---Stops the filtering for the defined collection.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:FilterStop() end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_OPSZONE 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_OPSZONE:FindInDatabase(Event) end

---Finds a Zone based on its name.
---
------
---@param self SET_OPSZONE 
---@param ZoneName string 
---@return OPSZONE #The found Zone.
function SET_OPSZONE:FindZone(ZoneName) end

---Iterate the SET_OPSZONE and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---
------
---@param self SET_OPSZONE 
---@param IteratorFunction function The function that will be called when there is an alive ZONE in the SET_OPSZONE. The function needs to accept a AIRBASE parameter.
---@param ... NOTYPE 
---@return SET_OPSZONE #self
function SET_OPSZONE:ForEachZone(IteratorFunction, ...) end

---Get the closest OPSZONE from a given reference coordinate.
---Only started zones are considered.
---
------
---@param self SET_OPSZONE 
---@param Coordinate COORDINATE The reference coordinate from which the closest zone is determined.
---@param Coalitions table Only consider the given coalition(s), *e.g.* `{coaliton.side.RED}` to find the closest red zone.
---@return OPSZONE #The closest OPSZONE (if any).
---@return number #Distance to ref coordinate in meters.
function SET_OPSZONE:GetClosestZone(Coordinate, Coalitions) end

---Get a random zone from the set.
---
------
---@param self SET_OPSZONE 
---@return OPSZONE #The random Zone.
function SET_OPSZONE:GetRandomZone() end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordiante is located.
---If zones overlap, the first zone that validates the test is returned.
---
------
---@param self SET_OPSZONE 
---@param Coordinate COORDINATE The coordinate to be searched.
---@return ZONE_BASE #The zone that validates the coordinate location.
---@return nil #No zone has been found.
function SET_OPSZONE:IsCoordinateInZone(Coordinate) end

---Private function that checks if an object is contained in the set or filtered.
---
------
---@param self SET_OPSZONE 
---@param MZone OPSZONE The OPSZONE object.
---@return SET_OPSZONE #self
function SET_OPSZONE:IsIncludeObject(MZone) end

---Creates a new SET_OPSZONE object, building a set of zones.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:New() end

---Handles the OnDead or OnCrash event for alive units set.
---
------
---@param self SET_OPSZONE 
---@param EventData EVENTDATA 
function SET_OPSZONE:OnEventDeleteZoneGoal(EventData) end

---Handles the OnEventNewZone event for the Set.
---
------
---@param self SET_OPSZONE 
---@param EventData EVENTDATA 
function SET_OPSZONE:OnEventNewZoneGoal(EventData) end

---Remove ZONEs from SET_OPSZONE.
---
------
---@param self SET_OPSZONE 
---@param RemoveZoneNames table A single name or an array of OPSZONE names.
---@return SET_OPSZONE # self
function SET_OPSZONE:RemoveZonesByName(RemoveZoneNames) end

---Set a zone probability.
---
------
---@param self SET_OPSZONE 
---@param ZoneName string The name of the zone.
---@param Probability number The probability in percent.
function SET_OPSZONE:SetZoneProbability(ZoneName, Probability) end

---Start all opszones of the set.
---
------
---@param self SET_OPSZONE 
---@return SET_OPSZONE #self
function SET_OPSZONE:Start() end


---Mission designers can use the Core.Set#SET_PLAYER class to build sets of units belonging to alive players:
---
---## SET_PLAYER constructor
---
---Create a new SET_PLAYER object with the #SET_PLAYER.New method:
---
---   * #SET_PLAYER.New: Creates a new SET_PLAYER object.
---
---## SET_PLAYER filter criteria
---
---You can set filter criteria to define the set of clients within the SET_PLAYER.
---Filter criteria are defined by:
---
---   * #SET_PLAYER.FilterCoalitions: Builds the SET_PLAYER with the clients belonging to the coalition(s).
---   * #SET_PLAYER.FilterCategories: Builds the SET_PLAYER with the clients belonging to the category(ies).
---   * #SET_PLAYER.FilterTypes: Builds the SET_PLAYER with the clients belonging to the client type(s).
---   * #SET_PLAYER.FilterCountries: Builds the SET_PLAYER with the clients belonging to the country(ies).
---   * #SET_PLAYER.FilterPrefixes: Builds the SET_PLAYER with the clients sharing the same string(s) in their unit/pilot name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---
---Once the filter criteria have been set for the SET_PLAYER, you can start filtering using:
---
---  * #SET_PLAYER.FilterStart: Starts the filtering of the clients within the SET_PLAYER.
---
---Planned filter criteria within development are (so these are not yet available):
---
---   * #SET_PLAYER.FilterZones: Builds the SET_PLAYER with the clients within a Core.Zone#ZONE.
---
---## SET_PLAYER iterators
---
---Once the filters have been defined and the SET_PLAYER has been built, you can iterate the SET_PLAYER with the available iterator methods.
---The iterator methods will walk the SET_PLAYER set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_PLAYER:
---
---  * #SET_PLAYER.ForEachClient: Calls a function for each alive client it finds within the SET_PLAYER.
---
---===
---@class SET_PLAYER : SET_BASE
SET_PLAYER = {}

---Add CLIENT(s) to SET_PLAYER.
---
------
---@param self SET_PLAYER 
---@param AddClientNames string A single name or an array of CLIENT names.
---@return  #self
function SET_PLAYER:AddClientsByName(AddClientNames) end

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_PLAYER 
---@param Event EVENTDATA 
---@return string #The name of the CLIENT
---@return table #The CLIENT
function SET_PLAYER:AddInDatabase(Event) end

---Builds a set of clients out of categories joined by players.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_PLAYER 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_PLAYER #self
function SET_PLAYER:FilterCategories(Categories) end

---Builds a set of clients of coalitions joined by specific players.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_PLAYER 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_PLAYER #self
function SET_PLAYER:FilterCoalitions(Coalitions) end

---Builds a set of clients of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_PLAYER 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_PLAYER #self
function SET_PLAYER:FilterCountries(Countries) end

---Builds a set of PLAYERs that contain the given string in their unit/pilot name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all player clients that **contain** the string.
---
------
---@param self SET_PLAYER 
---@param Prefixes string The string pattern(s) that needs to be contained in the unit/pilot name. Can also be passed as a `#table` of strings.
---@return SET_PLAYER #self
function SET_PLAYER:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_PLAYER 
---@return SET_PLAYER #self
function SET_PLAYER:FilterStart() end

---Builds a set of clients of defined client types joined by players.
---Possible current types are those types known within DCS world.
---
------
---@param self SET_PLAYER 
---@param Types string Can take those type strings known within DCS world.
---@return SET_PLAYER #self
function SET_PLAYER:FilterTypes(Types) end

---Builds a set of players in zones.
---
------
---@param self SET_PLAYER 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_PLAYER #self
function SET_PLAYER:FilterZones(Zones) end

---Finds a Client based on the Player Name.
---
------
---@param self SET_PLAYER 
---@param PlayerName string 
---@return CLIENT #The found Client.
function SET_PLAYER:FindClient(PlayerName) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_PLAYER 
---@param Event EVENTDATA 
---@return string #The name of the CLIENT
---@return table #The CLIENT
function SET_PLAYER:FindInDatabase(Event) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT, providing the CLIENT and optional parameters.
---
------
---@param self SET_PLAYER 
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_PLAYER #self
function SET_PLAYER:ForEachPlayer(IteratorFunction, ...) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT presence completely in a Core.Zone, providing the CLIENT and optional parameters to the called function.
---
------
---@param self SET_PLAYER 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_PLAYER #self
function SET_PLAYER:ForEachPlayerInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_PLAYER and call an iterator function for each **alive** CLIENT presence not in a Core.Zone, providing the CLIENT and optional parameters to the called function.
---
------
---@param self SET_PLAYER 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive CLIENT in the SET_PLAYER. The function needs to accept a CLIENT parameter.
---@param ... NOTYPE 
---@return SET_PLAYER #self
function SET_PLAYER:ForEachPlayerNotInZone(ZoneObject, IteratorFunction, ...) end


---
------
---@param self SET_PLAYER 
---@param MClient CLIENT 
---@return SET_PLAYER #self
function SET_PLAYER:IsIncludeObject(MClient) end

---Creates a new SET_PLAYER object, building a set of clients belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_PLAYER Object. This DBObject will contain a reference to all Clients.
---DBObject = SET_PLAYER:New()
---```
------
---@param self SET_PLAYER 
---@return SET_PLAYER #
function SET_PLAYER:New() end

---Remove CLIENT(s) from SET_PLAYER.
---
------
---@param self SET_PLAYER 
---@param RemoveClientNames CLIENT A single name or an array of CLIENT names.
---@return  #self
function SET_PLAYER:RemoveClientsByName(RemoveClientNames) end


---Mission designers can use the SET_SCENERY class to build sets of scenery belonging to certain:
---
--- * Zone Sets
---
---## SET_SCENERY constructor
---
---Create a new SET_SCENERY object with the #SET_SCENERY.New method:
---
---   * #SET_SCENERY.New: Creates a new SET_SCENERY object.
---
---## Add or Remove SCENERY(s) from SET_SCENERY
---
---SCENERYs can be added and removed using the Core.Set#SET_SCENERY.AddSceneryByName and Core.Set#SET_SCENERY.RemoveSceneryByName respectively.
---These methods take a single SCENERY name or an array of SCENERY names to be added or removed from SET_SCENERY.
---
---## SET_SCENERY filter criteria
---
---N/A at the moment
---   
---## SET_SCENERY iterators
---
---Once the filters have been defined and the SET_SCENERY has been built, you can iterate the SET_SCENERY with the available iterator methods.
---The iterator methods will walk the SET_SCENERY set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_SCENERY:
---
---  * #SET_SCENERY.ForEachScenery: Calls a function for each alive object it finds within the SET_SCENERY.
---
---## SET_SCENERY atomic methods
---
---N/A at the moment
---
---===
---@class SET_SCENERY : SET_BASE
SET_SCENERY = {}

---Add SCENERY(s) to SET_SCENERY.
---
------
---@param self SET_SCENERY 
---@param AddScenery SCENERY A single SCENERY object.
---@return SET_SCENERY #self
function SET_SCENERY:AddScenery(AddScenery) end

---Add SCENERY(s) to SET_SCENERY.
---
------
---@param self SET_SCENERY 
---@param AddSceneryNames string A single name or an array of SCENERY zone names.
---@return SET_SCENERY #self
function SET_SCENERY:AddSceneryByName(AddSceneryNames) end

---Iterate the SET_SCENERY and count how many SCENERYSs are alive.
---
------
---@param self SET_SCENERY 
---@return number #The number of SCENERYSs alive.
function SET_SCENERY:CountAlive() end

---Filters for the defined collection.
---
------
---@param self SET_SCENERY 
---@return SET_SCENERY #self
function SET_SCENERY:FilterOnce() end

---Builds a set of SCENERYs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all scenery that **contain** the string.
---
------
---@param self SET_SCENERY 
---@param Prefixes string The string pattern(s) that need to be contained in the scenery name. Can also be passed as a `#table` of strings.
---@return SET_SCENERY #self
function SET_SCENERY:FilterPrefixes(Prefixes) end

---Builds a set of SCENERYs that **contain** an exact match of the "ROLE" property.
---
------
---@param self SET_SCENERY 
---@param Role string The string pattern(s) that needs to exactly match the scenery "ROLE" property from the ME quad-zone properties. Can also be passed as a `#table` of strings.
---@return SET_SCENERY #self
function SET_SCENERY:FilterRoles(Role) end

---Builds a set of scenery objects in zones.
---
------
---@param self SET_SCENERY 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_SCENERY #self
function SET_SCENERY:FilterZones(Zones) end

---Finds a Scenery in the SET, based on the Scenery Name.
---
------
---@param self SET_SCENERY 
---@param SceneryName string 
---@return SCENERY #The found Scenery.
function SET_SCENERY:FindScenery(SceneryName) end

---Iterate the SET_SCENERY and call an iterator function for each **alive** SCENERY, providing the SCENERY and optional parameters.
---
------
---@param self SET_SCENERY 
---@param IteratorFunction function The function that will be called when there is an alive SCENERY in the SET_SCENERY. The function needs to accept a SCENERY parameter.
---@param ... NOTYPE 
---@return SET_SCENERY #self
function SET_SCENERY:ForEachScenery(IteratorFunction, ...) end

---Get a table of alive objects.
---
------
---@param self SET_SCENERY 
---@return table #Table of alive objects
---@return SET_SCENERY #SET of alive objects
function SET_SCENERY:GetAliveSet() end

---Get the center coordinate of the SET_SCENERY.
---
------
---@param self SET_SCENERY 
---@return COORDINATE #The center coordinate of all the objects in the set.
function SET_SCENERY:GetCoordinate() end

---Count overall current lifepoints of the SET objects.
---
------
---@param self SET_SCENERY 
---@return number #LifePoints
function SET_SCENERY:GetLife() end

---Count overall initial (Life0) lifepoints of the SET objects.
---
------
---@param self SET_SCENERY 
---@return number #LIfe0Points
function SET_SCENERY:GetLife0() end

---Calculate current relative lifepoints of the SET objects, i.e.
---Life divided by Life0 as percentage value, eg 75 meaning 75% alive. 
---**CAVEAT**: Some objects change their life value or "hitpoints" **after** the first hit. Hence we will adjust the Life0 value to 120% 
---of the last life value if life exceeds life0 ata any point.
---Thus we will get a smooth percentage decrease, if you use this e.g. as success criteria for a bombing task.
---
------
---@param self SET_SCENERY 
---@return number #LifePoints
function SET_SCENERY:GetRelativeLife() end

---[Internal] Determine if an object is to be included in the SET
---
------
---@param self SET_SCENERY 
---@param MScenery SCENERY 
---@return SET_SCENERY #self
function SET_SCENERY:IsIncludeObject(MScenery) end

---Creates a new SET_SCENERY object.
---Scenery is **not** auto-registered in the Moose database, there are too many objects on each map. Hence we need to find them first. For this we are using a SET_ZONE.
---
------
---
---USAGE
---```
----- Define a new SET_SCENERY Object. This Object will contain a reference to all added Scenery Objects.
---   ZoneSet = SET_ZONE:New():FilterPrefixes("Bridge"):FilterOnce()
---   mysceneryset = SET_SCENERY:New(ZoneSet)
---```
------
---@param self SET_SCENERY 
---@param ZoneSet SET_ZONE SET_ZONE of ZONE objects as created by right-clicks on the map in the mission editor, choosing "assign as...". Rename the zones for grouping purposes, e.g. all sections of a bridge as "Bridge-1" to "Bridge-3".
---@return SET_SCENERY #
function SET_SCENERY:New(ZoneSet) end

---Creates a new SET_SCENERY object.
---Scenery is **not** auto-registered in the Moose database, there are too many objects on each map. Hence we need to find them first. For this we scan the zone.
---
------
---@param self SET_SCENERY 
---@param Zone ZONE The zone to be scanned. Can be a ZONE_RADIUS (round) or a ZONE_POLYGON (e.g. Quad-Point)
---@return SET_SCENERY #
function SET_SCENERY:NewFromZone(Zone) end

---Remove SCENERY(s) from SET_SCENERY.
---
------
---@param self SET_SCENERY 
---@param RemoveSceneryNames SCENERY A single name or an array of SCENERY zone names.
---@return  #self
function SET_SCENERY:RemoveSceneryByName(RemoveSceneryNames) end


---Mission designers can use the SET_STATIC class to build sets of Statics belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Static types
--- * Starting with certain prefix strings.
---
---## SET_STATIC constructor
---
---Create a new SET_STATIC object with the #SET_STATIC.New method:
---
---   * #SET_STATIC.New: Creates a new SET_STATIC object.
---
---## Add or Remove STATIC(s) from SET_STATIC
---
---STATICs can be added and removed using the Core.Set#SET_STATIC.AddStaticsByName and Core.Set#SET_STATIC.RemoveStaticsByName respectively.
---These methods take a single STATIC name or an array of STATIC names to be added or removed from SET_STATIC.
---
---## SET_STATIC filter criteria
---
---You can set filter criteria to define the set of units within the SET_STATIC.
---Filter criteria are defined by:
---
---   * #SET_STATIC.FilterCoalitions: Builds the SET_STATIC with the units belonging to the coalition(s).
---   * #SET_STATIC.FilterCategories: Builds the SET_STATIC with the units belonging to the category(ies).
---   * #SET_STATIC.FilterTypes: Builds the SET_STATIC with the units belonging to the unit type(s).
---   * #SET_STATIC.FilterCountries: Builds the SET_STATIC with the units belonging to the country(ies).
---   * #SET_STATIC.FilterPrefixes: Builds the SET_STATIC with the units containing the same string(s) in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_STATIC.FilterZones: Builds the SET_STATIC with the units within a Core.Zone#ZONE.
---   * #SET_STATIC.FilterFunction: Builds the SET_STATIC with a custom condition.
---   
---Once the filter criteria have been set for the SET_STATIC, you can start filtering using:
---
---  * #SET_STATIC.FilterStart: Starts the filtering of the units within the SET_STATIC.
---
---## SET_STATIC iterators
---
---Once the filters have been defined and the SET_STATIC has been built, you can iterate the SET_STATIC with the available iterator methods.
---The iterator methods will walk the SET_STATIC set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_STATIC:
---
---  * #SET_STATIC.ForEachStatic: Calls a function for each alive unit it finds within the SET_STATIC.
---  * #SET_STATIC.ForEachStaticCompletelyInZone: Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence completely in a Core.Zone, providing the STATIC and optional parameters to the called function.
---  * #SET_STATIC.ForEachStaticInZone: Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence completely in a Core.Zone, providing the STATIC and optional parameters to the called function.
---  * #SET_STATIC.ForEachStaticNotInZone: Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence not in a Core.Zone, providing the STATIC and optional parameters to the called function.
---
---## SET_STATIC atomic methods
---
---Various methods exist for a SET_STATIC to perform actions or calculations and retrieve results from the SET_STATIC:
---
---  * #SET_STATIC.GetTypeNames(): Retrieve the type names of the Wrapper.Statics in the SET, delimited by a comma.
---
---===
---@class SET_STATIC : SET_BASE
SET_STATIC = {}

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_STATIC 
---@param Event EVENTDATA 
---@return string #The name of the STATIC
---@return table #The STATIC
function SET_STATIC:AddInDatabase(Event) end

---Add STATIC(s) to SET_STATIC.
---
------
---@param self SET_STATIC 
---@param AddStatic STATIC A single STATIC.
---@return SET_STATIC #self
function SET_STATIC:AddStatic(AddStatic) end

---Add STATIC(s) to SET_STATIC.
---
------
---@param self SET_STATIC 
---@param AddStaticNames string A single name or an array of STATIC names.
---@return SET_STATIC #self
function SET_STATIC:AddStaticsByName(AddStaticNames) end

---Calculate the maximum A2G threat level of the SET_STATIC.
---
------
---@param self SET_STATIC 
---@return number #The maximum threatlevel
function SET_STATIC:CalculateThreatLevelA2G() end

---Iterate the SET_STATIC and count how many STATICSs are alive.
---
------
---@param self SET_STATIC 
---@return number #The number of UNITs alive.
function SET_STATIC:CountAlive() end

---Builds a set of units out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_STATIC 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_STATIC #self
function SET_STATIC:FilterCategories(Categories) end

---Builds a set of units of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_STATIC 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_STATIC #self
function SET_STATIC:FilterCoalitions(Coalitions) end

---Builds a set of units of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_STATIC 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_STATIC #self
function SET_STATIC:FilterCountries(Countries) end

---[User] Add a custom condition function.
---
------
---
---USAGE
---```
---         -- Image you want to exclude a specific CLIENT from a SET:
---         local groundset = SET_STATIC:New():FilterCoalitions("blue"):FilterActive(true):FilterFunction(
---         -- The function needs to take a STATIC object as first - and in this case, only - argument.
---         function(static)
---             local isinclude = true
---             if static:GetName() == "Exclude Me" then isinclude = false end
---             return isinclude
---         end
---         ):FilterOnce()
---         BASE:I(groundset:Flush())
---```
------
---@param self SET_STATIC 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a STATIC object as first argument.
---@param ... NOTYPE Condition function arguments if any.
---@return SET_STATIC #self
function SET_STATIC:FilterFunction(ConditionFunction, ...) end

---Builds a set of STATICs that contain the given string in their name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all statics that **contain** the string.
---
------
---@param self SET_STATIC 
---@param Prefixes string The string pattern(s) that need to be contained in the static name. Can also be passed as a `#table` of strings.
---@return SET_STATIC #self
function SET_STATIC:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_STATIC 
---@return SET_STATIC #self
function SET_STATIC:FilterStart() end

---Builds a set of units of defined unit types.
---Possible current types are those types known within DCS world.
---
------
---@param self SET_STATIC 
---@param Types string Can take those type strings known within DCS world.
---@return SET_STATIC #self
function SET_STATIC:FilterTypes(Types) end

---Builds a set of statics in zones.
---
------
---@param self SET_STATIC 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_STATIC #self
function SET_STATIC:FilterZones(Zones) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_STATIC 
---@param Event EVENTDATA 
---@return string #The name of the STATIC
---@return table #The STATIC
function SET_STATIC:FindInDatabase(Event) end

---Finds a Static based on the Static Name.
---
------
---@param self SET_STATIC 
---@param StaticName string 
---@return STATIC #The found Static.
function SET_STATIC:FindStatic(StaticName) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC, providing the STATIC and optional parameters.
---
------
---@param self SET_STATIC 
---@param IteratorFunction function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... NOTYPE 
---@return SET_STATIC #self
function SET_STATIC:ForEachStatic(IteratorFunction, ...) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence completely in a Core.Zone, providing the STATIC and optional parameters to the called function.
---
------
---@param self SET_STATIC 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... NOTYPE 
---@return SET_STATIC #self
function SET_STATIC:ForEachStaticCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Check if minimal one element of the SET_STATIC is in the Zone.
---
------
---@param self SET_STATIC 
---@param IteratorFunction function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... NOTYPE 
---@return SET_STATIC #self
function SET_STATIC:ForEachStaticInZone(IteratorFunction, ...) end

---Iterate the SET_STATIC and call an iterator function for each **alive** STATIC presence not in a Core.Zone, providing the STATIC and optional parameters to the called function.
---
------
---@param self SET_STATIC 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive STATIC in the SET_STATIC. The function needs to accept a STATIC parameter.
---@param ... NOTYPE 
---@return SET_STATIC #self
function SET_STATIC:ForEachStaticNotInZone(ZoneObject, IteratorFunction, ...) end

---Get the closest static of the set with respect to a given reference coordinate.
---Optionally, only statics of given coalitions are considered in the search.
---
------
---@param self SET_STATIC 
---@param Coordinate COORDINATE Reference Coordinate from which the closest static is determined.
---@param Coalitions NOTYPE 
---@return STATIC #The closest static (if any).
---@return number #Distance in meters to the closest static.
function SET_STATIC:GetClosestStatic(Coordinate, Coalitions) end

---Get the center coordinate of the SET_STATIC.
---
------
---@param self SET_STATIC 
---@return COORDINATE #The center coordinate of all the units in the set, including heading in degrees and speed in mps in case of moving units.
function SET_STATIC:GetCoordinate() end

---Get the first unit from the set.
---
------
---@param self SET_STATIC 
---@return STATIC #The STATIC object.
function SET_STATIC:GetFirst() end

---Get the average heading of the SET_STATIC.
---
------
---@param self SET_STATIC 
---@return number #Heading Heading in degrees and speed in mps in case of moving units.
function SET_STATIC:GetHeading() end

---Returns map of unit types.
---
------
---@param self SET_STATIC 
---@return map #A map of the unit types found. The key is the StaticTypeName and the value is the amount of unit types found.
function SET_STATIC:GetStaticTypes() end

---Returns a comma separated string of the unit types with a count in the  Core.Set.
---
------
---@param self SET_STATIC 
---@return string #The unit types string
function SET_STATIC:GetStaticTypesText() end

---Retrieve the type names of the Wrapper.Statics in the SET, delimited by an optional delimiter.
---
------
---@param self SET_STATIC 
---@param Delimiter? string (Optional) The delimiter, which is default a comma.
---@return string #The types of the @{Wrapper.Static}s delimited.
function SET_STATIC:GetTypeNames(Delimiter) end

---Get the maximum velocity of the SET_STATIC.
---
------
---@param self SET_STATIC 
---@return number #The speed in mps in case of moving units.
function SET_STATIC:GetVelocity() end


---
------
---@param self SET_STATIC 
---@param MStatic STATIC 
---@return SET_STATIC #self
function SET_STATIC:IsIncludeObject(MStatic) end

---Check if no element of the SET_STATIC is in the Zone.
---
------
---@param self SET_STATIC 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #
function SET_STATIC:IsNotInZone(Zone) end

---Check if minimal one element of the SET_STATIC is in the Zone.
---
------
---@param self SET_STATIC 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #
function SET_STATIC:IsPartiallyInZone(Zone) end

---Creates a new SET_STATIC object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_STATIC Object. This DBObject will contain a reference to all alive Statics.
---DBObject = SET_STATIC:New()
---```
------
---@param self SET_STATIC 
---@return SET_STATIC #
function SET_STATIC:New() end

---Remove STATIC(s) from SET_STATIC.
---
------
---@param self SET_STATIC 
---@param RemoveStaticNames STATIC A single name or an array of STATIC names.
---@return  #self
function SET_STATIC:RemoveStaticsByName(RemoveStaticNames) end


---Mission designers can use the SET_UNIT class to build sets of units belonging to certain:
---
--- * Coalitions
--- * Categories
--- * Countries
--- * Unit types
--- * Starting with certain prefix strings.
---
---## 1) SET_UNIT constructor
---
---Create a new SET_UNIT object with the #SET_UNIT.New method:
---
---   * #SET_UNIT.New: Creates a new SET_UNIT object.
---
---## 2) Add or Remove UNIT(s) from SET_UNIT
---
---UNITs can be added and removed using the Core.Set#SET_UNIT.AddUnitsByName and Core.Set#SET_UNIT.RemoveUnitsByName respectively.
---These methods take a single UNIT name or an array of UNIT names to be added or removed from SET_UNIT.
---
---## 3) SET_UNIT filter criteria
---
---You can set filter criteria to define the set of units within the SET_UNIT.
---Filter criteria are defined by:
---
---   * #SET_UNIT.FilterCoalitions: Builds the SET_UNIT with the units belonging to the coalition(s).
---   * #SET_UNIT.FilterCategories: Builds the SET_UNIT with the units belonging to the category(ies).
---   * #SET_UNIT.FilterTypes: Builds the SET_UNIT with the units belonging to the unit type(s).
---   * #SET_UNIT.FilterCountries: Builds the SET_UNIT with the units belonging to the country(ies).
---   * #SET_UNIT.FilterPrefixes: Builds the SET_UNIT with the units sharing the same string(s) in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---   * #SET_UNIT.FilterActive: Builds the SET_UNIT with the units that are only active. Units that are inactive (late activation) won't be included in the set!
---   * #SET_UNIT.FilterZones: Builds the SET_UNIT with the units within a Core.Zone#ZONE.
---   * #SET_UNIT.FilterFunction: Builds the SET_UNIT with a custom condition.
---   
---Once the filter criteria have been set for the SET_UNIT, you can start filtering using:
---
---  * #SET_UNIT.FilterStart: Starts the filtering of the units **dynamically**.
---  * #SET_UNIT.FilterOnce: Filters of the units **once**.
---
---## 4) SET_UNIT iterators
---
---Once the filters have been defined and the SET_UNIT has been built, you can iterate the SET_UNIT with the available iterator methods.
---The iterator methods will walk the SET_UNIT set, and call for each element within the set a function that you provide.
---The following iterator methods are currently available within the SET_UNIT:
---
---  * #SET_UNIT.ForEachUnit: Calls a function for each alive unit it finds within the SET_UNIT.
---  * #SET_UNIT.ForEachUnitInZone: Iterate the SET_UNIT and call an iterator function for each **alive** UNIT object presence completely in a Core.Zone, providing the UNIT object and optional parameters to the called function.
---  * #SET_UNIT.ForEachUnitNotInZone: Iterate the SET_UNIT and call an iterator function for each **alive** UNIT object presence not in a Core.Zone, providing the UNIT object and optional parameters to the called function.
---  * #SET_UNIT:ForEachUnitPerThreatLevel: Iterate the SET_UNIT **sorted *per Threat Level** and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters
---
---## 5) SET_UNIT atomic methods
---
---Various methods exist for a SET_UNIT to perform actions or calculations and retrieve results from the SET_UNIT:
---
---  * #SET_UNIT.GetTypeNames(): Retrieve the type names of the Wrapper.Units in the SET, delimited by a comma.
---
---## 6) SET_UNIT trigger events on the UNIT objects.
---
---The SET is derived from the FSM class, which provides extra capabilities to track the contents of the UNIT objects in the SET_UNIT.
---
---### 6.1) When a UNIT object crashes or is dead, the SET_UNIT will trigger a **Dead** event.
---
---You can handle the event using the OnBefore and OnAfter event handlers.
---The event handlers need to have the parameters From, Event, To, GroupObject.
---The GroupObject is the UNIT object that is dead and within the SET_UNIT, and is passed as a parameter to the event handler.
---See the following example:
---
---       -- Create the SetCarrier SET_UNIT collection.
---
---       local SetHelicopter = SET_UNIT:New():FilterPrefixes( "Helicopter" ):FilterStart()
---
---       -- Put a Dead event handler on SetCarrier, to ensure that when a carrier unit is destroyed, that all internal parameters are reset.
---
---       function SetHelicopter:OnAfterDead( From, Event, To, UnitObject )
---         --self:F( { UnitObject = UnitObject:GetName() } )
---       end
---
---While this is a good example, there is a catch.
---Imagine you want to execute the code above, the the self would need to be from the object declared outside (above) the OnAfterDead method.
---So, the self would need to contain another object. Fortunately, this can be done, but you must use then the **`.`** notation for the method.
---See the modified example:
---
---       -- Now we have a constructor of the class AI_CARGO_DISPATCHER, that receives the SetHelicopter as a parameter.
---       -- Within that constructor, we want to set an enclosed event handler OnAfterDead for SetHelicopter.
---       -- But within the OnAfterDead method, we want to refer to the self variable of the AI_CARGO_DISPATCHER.
---
---       function ACLASS:New( SetCarrier, SetCargo, SetDeployZones )
---
---         local self = BASE:Inherit( self, FSM:New() ) -- #AI_CARGO_DISPATCHER
---
---         -- Put a Dead event handler on SetCarrier, to ensure that when a carrier is destroyed, that all internal parameters are reset.
---         -- Note the "." notation, and the explicit declaration of SetHelicopter, which would be using the ":" notation the implicit self variable declaration.
---
---         function SetHelicopter.OnAfterDead( SetHelicopter, From, Event, To, UnitObject )
---           SetHelicopter:F( { UnitObject = UnitObject:GetName() } )
---           self.array[UnitObject] = nil  -- So here I clear the array table entry of the self object ACLASS.
---         end
---
---       end
---===
---@class SET_UNIT : SET_BASE
---@field ZoneTimer TIMER 
---@field ZoneTimerInterval number 
SET_UNIT = {}

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_UNIT 
---@param Event EVENTDATA 
---@return string #The name of the UNIT
---@return table #The UNIT
function SET_UNIT:AddInDatabase(Event) end

---Add UNIT(s) to SET_UNIT.
---
------
---@param self SET_UNIT 
---@param Unit UNIT A single UNIT.
---@return SET_UNIT #self
function SET_UNIT:AddUnit(Unit) end

---Add UNIT(s) to SET_UNIT.
---
------
---@param self SET_UNIT 
---@param AddUnitNames string A single name or an array of UNIT names.
---@return SET_UNIT #self
function SET_UNIT:AddUnitsByName(AddUnitNames) end

---Calculate the maximum A2G threat level of the SET_UNIT.
---
------
---@param self SET_UNIT 
---@return number #The maximum threat level
function SET_UNIT:CalculateThreatLevelA2G() end

---Count Alive Units
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:CountAlive() end

---Builds a set of units that are only active.
---Only the units that are active will be included within the set.
---
------
---
---USAGE
---```
---
----- Include only active units to the set.
---UnitSet = SET_UNIT:New():FilterActive():FilterStart()
---
----- Include only active units to the set of the blue coalition, and filter one time.
---UnitSet = SET_UNIT:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---
----- Include only active units to the set of the blue coalition, and filter one time.
----- Later, reset to include back inactive units to the set.
---UnitSet = SET_UNIT:New():FilterActive():FilterCoalition( "blue" ):FilterOnce()
---... logic ...
---UnitSet = SET_UNIT:New():FilterActive( false ):FilterCoalition( "blue" ):FilterOnce()
---```
------
---@param self SET_UNIT 
---@param Active? boolean (Optional) Include only active units to the set. Include inactive units if you provide false.
---@return SET_UNIT #self
function SET_UNIT:FilterActive(Active) end

---Builds a set of units which exist and are alive.
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:FilterAlive() end

---Builds a set of units out of categories.
---Possible current categories are plane, helicopter, ground, ship.
---
------
---@param self SET_UNIT 
---@param Categories string Can take the following values: "plane", "helicopter", "ground", "ship".
---@return SET_UNIT #self
function SET_UNIT:FilterCategories(Categories) end

---Builds a set of units of coalitions.
---Possible current coalitions are red, blue and neutral.
---
------
---@param self SET_UNIT 
---@param Coalitions string Can take the following values: "red", "blue", "neutral".
---@return SET_UNIT #self
function SET_UNIT:FilterCoalitions(Coalitions) end

---Builds a set of units of defined countries.
---Possible current countries are those known within DCS world.
---
------
---@param self SET_UNIT 
---@param Countries string Can take those country strings known within DCS world.
---@return SET_UNIT #self
function SET_UNIT:FilterCountries(Countries) end

---[User] Add a custom condition function.
---
------
---
---USAGE
---```
---         -- Image you want to exclude a specific UNIT from a SET:
---         local groundset = SET_UNIT:New():FilterCoalitions("blue"):FilterCategories("ground"):FilterFunction(
---         -- The function needs to take a UNIT object as first - and in this case, only - argument.
---         function(unit)
---             local isinclude = true
---             if unit:GetName() == "Exclude Me" then isinclude = false end
---             return isinclude
---         end
---         ):FilterOnce()
---         BASE:I(groundset:Flush())
---```
------
---@param self SET_UNIT 
---@param ConditionFunction function If this function returns `true`, the object is added to the SET. The function needs to take a UNIT object as first argument.
---@param ... NOTYPE Condition function arguments if any.
---@return SET_UNIT #self
function SET_UNIT:FilterFunction(ConditionFunction, ...) end

---Builds a set of units which belong to groups with certain **group names**.
---
------
---@param self SET_UNIT 
---@param Prefixes string The (partial) group names to look for. Can be a single string or a table of strings.
---@return SET_UNIT #self
function SET_UNIT:FilterGroupPrefixes(Prefixes) end

---Builds a set of units having a radar of give types.
---All the units having a radar of a given type will be included within the set.
---
------
---@param self SET_UNIT 
---@param RadarTypes table The radar types.
---@return SET_UNIT #self
function SET_UNIT:FilterHasRadar(RadarTypes) end

---Builds a set of SEADable units.
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:FilterHasSEAD() end

---Builds a set of UNITs that contain a given string in their unit name.
---**Attention!** Bad naming convention as this **does not** filter only **prefixes** but all units that **contain** the string.
---
------
---@param self SET_UNIT 
---@param Prefixes string The string pattern(s) that needs to be contained in the unit name. Can also be passed as a `#table` of strings.
---@return SET_UNIT #self
function SET_UNIT:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:FilterStart() end

---Stops the filtering.
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:FilterStop() end

---Builds a set of units of defined unit types.
---Possible current types are those types known within DCS world.
---
------
---@param self SET_UNIT 
---@param Types string Can take those type strings known within DCS world.
---@return SET_UNIT #self
function SET_UNIT:FilterTypes(Types) end

---Set filter timer interval for FilterZones if using active filtering with FilterStart().
---
------
---@param self SET_UNIT 
---@param Seconds number Seconds between check intervals, defaults to 30. **Caution** - do not be too agressive with timing! Groups are usually not moving fast enough to warrant a check of below 10 seconds.
---@return SET_UNIT #self
function SET_UNIT:FilterZoneTimer(Seconds) end

---Builds a set of units in zones.
---
------
---@param self SET_UNIT 
---@param Zones table Table of Core.Zone#ZONE Zone objects, or a Core.Set#SET_ZONE
---@return SET_UNIT #self
function SET_UNIT:FilterZones(Zones) end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_UNIT 
---@param Event EVENTDATA 
---@return string #The name of the UNIT
---@return table #The UNIT
function SET_UNIT:FindInDatabase(Event) end

---Finds a Unit based on the Unit Name.
---
------
---@param self SET_UNIT 
---@param UnitName string 
---@return UNIT #The found Unit.
function SET_UNIT:FindUnit(UnitName) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters.
---
------
---@param self SET_UNIT 
---@param IteratorFunction function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... NOTYPE 
---@return SET_UNIT #self
function SET_UNIT:ForEachUnit(IteratorFunction, ...) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT presence completely in a Core.Zone, providing the UNIT and optional parameters to the called function.
---
------
---@param self SET_UNIT 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... NOTYPE 
---@return SET_UNIT #self
function SET_UNIT:ForEachUnitCompletelyInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_UNIT and call an iterator function for each **alive** UNIT presence not in a Core.Zone, providing the UNIT and optional parameters to the called function.
---
------
---@param self SET_UNIT 
---@param ZoneObject ZONE The Zone to be tested for.
---@param IteratorFunction function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... NOTYPE 
---@return SET_UNIT #self
function SET_UNIT:ForEachUnitNotInZone(ZoneObject, IteratorFunction, ...) end

---Iterate the SET_UNIT **sorted *per Threat Level** and call an iterator function for each **alive** UNIT, providing the UNIT and optional parameters.
---
------
---
---USAGE
---```
---
---    UnitSet:ForEachUnitPerThreatLevel( 10, 0,
---      -- @param Wrapper.Unit#UNIT UnitObject The UNIT object in the UnitSet, that will be passed to the local function for evaluation.
---      function( UnitObject )
---        .. logic ..
---      end
---    )
---```
------
---@param self SET_UNIT 
---@param FromThreatLevel number The TreatLevel to start the evaluation **From** (this must be a value between 0 and 10).
---@param ToThreatLevel number The TreatLevel to stop the evaluation **To** (this must be a value between 0 and 10).
---@param IteratorFunction function The function that will be called when there is an alive UNIT in the SET_UNIT. The function needs to accept a UNIT parameter.
---@param ... NOTYPE 
---@return SET_UNIT #self
function SET_UNIT:ForEachUnitPerThreatLevel(FromThreatLevel, ToThreatLevel, IteratorFunction, ...) end

---Gets the alive set.
---
------
---@param self SET_UNIT 
---@return table #Table of SET objects
---@return SET_UNIT #AliveSet 
function SET_UNIT:GetAliveSet() end

---Get the center coordinate of the SET_UNIT.
---
------
---@param self SET_UNIT 
---@return COORDINATE #The center coordinate of all the units in the set, including heading in degrees and speed in mps in case of moving units.
function SET_UNIT:GetCoordinate() end

---Get the first unit from the set.
---
------
---@param self SET_UNIT 
---@return UNIT #The UNIT object.
function SET_UNIT:GetFirst() end

---Get the average heading of the SET_UNIT.
---
------
---@param self SET_UNIT 
---@return number #Heading Heading in degrees and speed in mps in case of moving units.
function SET_UNIT:GetHeading() end

---Get the SET of the SET_UNIT **sorted per Threat Level**.
---
------
---@param self SET_UNIT 
---@param FromThreatLevel number The TreatLevel to start the evaluation **From** (this must be a value between 0 and 10).
---@param ToThreatLevel number The TreatLevel to stop the evaluation **To** (this must be a value between 0 and 10).
---@return SET_UNIT #self
function SET_UNIT:GetSetPerThreatLevel(FromThreatLevel, ToThreatLevel) end

---Retrieve the type names of the Wrapper.Units in the SET, delimited by an optional delimiter.
---
------
---@param self SET_UNIT 
---@param Delimiter? string (Optional) The delimiter, which is default a comma.
---@return string #The types of the @{Wrapper.Unit}s delimited.
function SET_UNIT:GetTypeNames(Delimiter) end

---Returns map of unit threat levels.
---
------
---@param self SET_UNIT 
---@return table #
function SET_UNIT:GetUnitThreatLevels() end

---Returns map of unit types.
---
------
---@param self SET_UNIT 
---@return map #A map of the unit types found. The key is the UnitTypeName and the value is the amount of unit types found.
function SET_UNIT:GetUnitTypes() end

---Returns a comma separated string of the unit types with a count in the  Core.Set.
---
------
---@param self SET_UNIT 
---@return string #The unit types string
function SET_UNIT:GetUnitTypesText() end

---Get the maximum velocity of the SET_UNIT.
---
------
---@param self SET_UNIT 
---@return number #The speed in mps in case of moving units.
function SET_UNIT:GetVelocity() end

---Returns if the Core.Set has air targets.
---
------
---@param self SET_UNIT 
---@return number #The amount of air targets in the Set.
function SET_UNIT:HasAirUnits() end

---Returns if the Core.Set has friendly ground units.
---
------
---@param self SET_UNIT 
---@param FriendlyCoalition NOTYPE 
---@return number #The amount of ground targets in the Set.
function SET_UNIT:HasFriendlyUnits(FriendlyCoalition) end

---Returns if the Core.Set has ground targets.
---
------
---@param self SET_UNIT 
---@return number #The amount of ground targets in the Set.
function SET_UNIT:HasGroundUnits() end

---Returns if the Core.Set has targets having a radar (of a given type).
---
------
---@param self SET_UNIT 
---@param RadarType Unit.RadarType 
---@return number #The amount of radars in the Set with the given type
function SET_UNIT:HasRadar(RadarType) end

---Returns if the Core.Set has targets that can be SEADed.
---
------
---@param self SET_UNIT 
---@return number #The amount of SEADable units in the Set
function SET_UNIT:HasSEAD() end


---
------
---@param self SET_UNIT 
---@param MUnit UNIT 
---@return SET_UNIT #self
function SET_UNIT:IsIncludeObject(MUnit) end

---Check if no element of the SET_UNIT is in the Zone.
---
------
---@param self SET_UNIT 
---@param Zone ZONE The Zone to be tested for.
---@return boolean #
function SET_UNIT:IsNotInZone(Zone) end

---Check if minimal one element of the SET_UNIT is in the Zone.
---
------
---@param self SET_UNIT 
---@param ZoneTest ZONE The Zone to be tested for.
---@return boolean #
function SET_UNIT:IsPartiallyInZone(ZoneTest) end

---Creates a new SET_UNIT object, building a set of units belonging to a coalitions, categories, countries, types or with defined prefix names.
---
------
---
---USAGE
---```
----- Define a new SET_UNIT Object. This DBObject will contain a reference to all alive Units.
---DBObject = SET_UNIT:New()
---```
------
---@param self SET_UNIT 
---@return SET_UNIT #
function SET_UNIT:New() end

---Remove UNIT(s) from SET_UNIT.
---
------
---@param self SET_UNIT 
---@param RemoveUnitNames table A single name or an array of UNIT names.
---@return SET_UNIT #self
function SET_UNIT:RemoveUnitsByName(RemoveUnitNames) end

---Iterate the SET_UNIT and set for each unit the default cargo bay weight limit.
---
------
---
---USAGE
---```
----- Set the default cargo bay weight limits of the carrier units.
---local MySetUnit = SET_UNIT:New()
---MySetUnit:SetCargoBayWeightLimit()
---```
------
---@param self SET_UNIT 
function SET_UNIT:SetCargoBayWeightLimit() end

---[Internal] Private function for use of continous zone filter
---
------
---@param self SET_UNIT 
---@return SET_UNIT #self
function SET_UNIT:_ContinousZoneFilter() end


---Mission designers can use the Core.Set#SET_ZONE class to build sets of zones of various types.
---
---## SET_ZONE constructor
---
---Create a new SET_ZONE object with the #SET_ZONE.New method:
---
---   * #SET_ZONE.New: Creates a new SET_ZONE object.
---
---## Add or Remove ZONEs from SET_ZONE
---
---ZONEs can be added and removed using the Core.Set#SET_ZONE.AddZonesByName and Core.Set#SET_ZONE.RemoveZonesByName respectively.
---These methods take a single ZONE name or an array of ZONE names to be added or removed from SET_ZONE.
---
---## SET_ZONE filter criteria
---
---You can set filter criteria to build the collection of zones in SET_ZONE.
---Filter criteria are defined by:
---
---   * #SET_ZONE.FilterPrefixes: Builds the SET_ZONE with the zones having a certain text pattern in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---
---Once the filter criteria have been set for the SET_ZONE, you can start filtering using:
---
---  * #SET_ZONE.FilterStart: Starts the filtering of the zones within the SET_ZONE.
---
---## SET_ZONE iterators
---
---Once the filters have been defined and the SET_ZONE has been built, you can iterate the SET_ZONE with the available iterator methods.
---The iterator methods will walk the SET_ZONE set, and call for each airbase within the set a function that you provide.
---The following iterator methods are currently available within the SET_ZONE:
---
---  * #SET_ZONE.ForEachZone: Calls a function for each zone it finds within the SET_ZONE.
---
---===
---@class SET_ZONE : SET_BASE
---@field private checkobjects NOTYPE 
---@field private objectset NOTYPE 
SET_ZONE = {}

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_ZONE 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_ZONE:AddInDatabase(Event) end

---Add ZONEs to SET_ZONE.
---
------
---@param self SET_ZONE 
---@param Zone ZONE_BASE A ZONE_BASE object.
---@return  #self
function SET_ZONE:AddZone(Zone) end

---Add ZONEs by a search name to SET_ZONE.
---
------
---@param self SET_ZONE 
---@param AddZoneNames string A single name or an array of ZONE_BASE names.
---@return  #self
function SET_ZONE:AddZonesByName(AddZoneNames) end

---Draw all zones in the set on the F10 map.
---
------
---@param self SET_ZONE 
---@param Coalition number Coalition: All=-1, Neutral=0, Red=1, Blue=2. Default -1=All.
---@param Color table RGB color table {r, g, b}, e.g. {1,0,0} for red.
---@param Alpha number Transparency [0,1]. Default 1.
---@param FillColor table RGB color table {r, g, b}, e.g. {1,0,0} for red. Default is same as `Color` value.
---@param FillAlpha number Transparency [0,1]. Default 0.15.
---@param LineType number Line type: 0=No line, 1=Solid, 2=Dashed, 3=Dotted, 4=Dot dash, 5=Long dash, 6=Two dash. Default 1=Solid.
---@param ReadOnly? boolean (Optional) Mark is readonly and cannot be removed by users. Default false.
---@return SET_ZONE #self
function SET_ZONE:DrawZone(Coalition, Color, Alpha, FillColor, FillAlpha, LineType, ReadOnly) end

---Builds a set of ZONEs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---
------
---@param self SET_ZONE 
---@param Prefixes string The string pattern(s) that need to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_ZONE #self
function SET_ZONE:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_ZONE 
---@return SET_ZONE #self
function SET_ZONE:FilterStart() end

---Stops the filtering for the defined collection.
---
------
---@param self SET_ZONE 
---@return SET_ZONE #self
function SET_ZONE:FilterStop() end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_ZONE 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_ZONE:FindInDatabase(Event) end

---Finds a Zone based on the Zone Name.
---
------
---@param self SET_ZONE 
---@param ZoneName string 
---@return ZONE_BASE #The found Zone.
function SET_ZONE:FindZone(ZoneName) end

---Iterate the SET_ZONE and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---
------
---@param self SET_ZONE 
---@param IteratorFunction function The function that will be called when there is an alive ZONE in the SET_ZONE. The function needs to accept a AIRBASE parameter.
---@param ... NOTYPE 
---@return SET_ZONE #self
function SET_ZONE:ForEachZone(IteratorFunction, ...) end

---Get the average aggregated coordinate of this set of zones.
---
------
---@param self SET_ZONE 
---@return COORDINATE #
function SET_ZONE:GetAverageCoordinate() end

---Get the closest zone to a given coordinate.
---
------
---@param self SET_ZONE 
---@param Coordinate COORDINATE The reference coordinate from which the closest zone is determined.
---@return ZONE_BASE #The closest zone (if any).
---@return number #Distance to ref coordinate in meters.
function SET_ZONE:GetClosestZone(Coordinate) end

---Get a random zone from the set.
---
------
---@param self SET_ZONE 
---@param margin number Number of tries to find a zone
---@return ZONE_BASE #The random Zone.
---@return nil #if no zone in the collection.
function SET_ZONE:GetRandomZone(margin) end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordinate is located.
---If zones overlap, the first zone that validates the test is returned.
---
------
---@param self SET_ZONE 
---@param Coordinate COORDINATE The coordinate to be searched.
---@return ZONE_BASE #The zone (if any) that validates the coordinate location.
function SET_ZONE:IsCoordinateInZone(Coordinate) end

---Private function.
---
------
---@param self SET_ZONE 
---@param MZone ZONE_BASE 
---@return SET_ZONE #self
function SET_ZONE:IsIncludeObject(MZone) end

---Creates a new SET_ZONE object, building a set of zones.
---
------
---
---USAGE
---```
----- Define a new SET_ZONE Object. The DatabaseSet will contain a reference to all Zones.
---DatabaseSet = SET_ZONE:New()
---```
------
---@param self SET_ZONE 
---@return SET_ZONE #self
function SET_ZONE:New() end

---On After "EnteredZone" event.
---An observed object has entered the zone.
---
------
---@param self SET_ZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Controllable CONTROLLABLE The controllable entering the zone.
---@param Zone ZONE_BASE The zone entered.
function SET_ZONE:OnAfterEnteredZone(From, Event, To, Controllable, Zone) end

---On After "LeftZone" event.
---An observed object has left the zone.
---
------
---@param self SET_ZONE 
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Controllable CONTROLLABLE The controllable leaving the zone.
---@param Zone ZONE_BASE The zone left.
function SET_ZONE:OnAfterLeftZone(From, Event, To, Controllable, Zone) end

---Handles the OnDead or OnCrash event for alive units set.
---
------
---@param self SET_ZONE 
---@param EventData EVENTDATA 
function SET_ZONE:OnEventDeleteZone(EventData) end

---Handles the OnEventNewZone event for the Set.
---
------
---@param self SET_ZONE 
---@param EventData EVENTDATA 
function SET_ZONE:OnEventNewZone(EventData) end

---Remove ZONEs from SET_ZONE.
---
------
---@param self SET_ZONE 
---@param RemoveZoneNames ZONE_BASE A single name or an array of ZONE_BASE names.
---@return  #self
function SET_ZONE:RemoveZonesByName(RemoveZoneNames) end

---Set the check time for SET_ZONE:Trigger()
---
------
---@param self SET_ZONE 
---@param seconds number Check every seconds for objects entering or leaving the zone. Defaults to 5 secs.
---@return SET_ZONE #self
function SET_ZONE:SetCheckTime(seconds) end

---Set a zone probability.
---
------
---@param self SET_ZONE 
---@param ZoneName string The name of the zone.
---@param ZoneProbability NOTYPE 
function SET_ZONE:SetZoneProbability(ZoneName, ZoneProbability) end

---Start watching if the Object or Objects move into or out of our set of zones.
---
------
---
---USAGE
---```
---         -- Create a SET_GROUP and a SET_ZONE for this:
---
---         local groupset = SET_GROUP:New():FilterPrefixes("Aerial"):FilterStart()
---         
---         -- Trigger will check each zone of the SET_ZONE every 5 secs for objects entering or leaving from the groupset
---         local zoneset = SET_ZONE:New():FilterPrefixes("Target Zone"):FilterOnce():Trigger(groupset)
---         
---         -- Draw zones on map so we see what's going on
---         zoneset:ForEachZone(
---           function(zone)
---             zone:DrawZone(-1, {0,1,0}, Alpha, FillColor, FillAlpha, 4, ReadOnly)
---           end 
---         )
---         
---         -- This FSM function will be called for entering objects
---         function zoneset:OnAfterEnteredZone(From,Event,To,Controllable,Zone)
---           MESSAGE:New("Group "..Controllable:GetName() .. " entered zone "..Zone:GetName(),10,"Set Trigger"):ToAll()
---         end
---         
---         -- This FSM function will be called for leaving objects
---         function zoneset:OnAfterLeftZone(From,Event,To,Controllable,Zone)
---           MESSAGE:New("Group "..Controllable:GetName() .. " left zone "..Zone:GetName(),10,"Set Trigger"):ToAll()
---         end
---         
---         -- Stop watching after 1 hour
---         zoneset:__TriggerStop(3600)
---```
------
---@param self SET_ZONE 
---@param Objects CONTROLLABLE Object or Objects to watch, can be of type UNIT, GROUP, CLIENT, or SET\_UNIT, SET\_GROUP, SET\_CLIENT
---@return SET_ZONE #self
function SET_ZONE:Trigger(Objects) end

---Triggers the FSM event "TriggerStop".
---Stops the SET_ZONE Trigger.
---
------
---@param self SET_ZONE 
function SET_ZONE:TriggerStop() end

---(Internal) Check the assigned objects for being in/out of the zone
---
------
---@param self SET_ZONE 
---@param fromstart boolean If true, do the init of the objects
---@return SET_ZONE #self
function SET_ZONE:_TriggerCheck(fromstart) end

---Triggers the FSM event "TriggerStop" after a delay.
---
------
---@param self SET_ZONE 
---@param delay number Delay in seconds.
function SET_ZONE:__TriggerStop(delay) end

---(Internal) Check the assigned objects for being in/out of the zone
---
------
---@param self SET_ZONE 
---@param From string 
---@param Event string 
---@param to string 
---@param To NOTYPE 
---@return SET_ZONE #self
---@private
function SET_ZONE:onafterTriggerRunCheck(From, Event, to, To) end


---Mission designers can use the Core.Set#SET_ZONE_GOAL class to build sets of zones of various types.
---
---## SET_ZONE_GOAL constructor
---
---Create a new SET_ZONE_GOAL object with the #SET_ZONE_GOAL.New method:
---
---   * #SET_ZONE_GOAL.New: Creates a new SET_ZONE_GOAL object.
---
---## Add or Remove ZONEs from SET_ZONE_GOAL
---
---ZONEs can be added and removed using the Core.Set#SET_ZONE_GOAL.AddZonesByName and Core.Set#SET_ZONE_GOAL.RemoveZonesByName respectively.
---These methods take a single ZONE name or an array of ZONE names to be added or removed from SET_ZONE_GOAL.
---
---## SET_ZONE_GOAL filter criteria
---
---You can set filter criteria to build the collection of zones in SET_ZONE_GOAL.
---Filter criteria are defined by:
---
---   * #SET_ZONE_GOAL.FilterPrefixes: Builds the SET_ZONE_GOAL with the zones having a certain text pattern in their name. **Attention!** LUA regular expression apply here, so special characters in names like minus, dot, hash (#) etc might lead to unexpected results. 
---Have a read through here to understand the application of regular expressions: [LUA regular expressions](https://riptutorial.com/lua/example/20315/lua-pattern-matching)
---
---Once the filter criteria have been set for the SET_ZONE_GOAL, you can start filtering using:
---
---  * #SET_ZONE_GOAL.FilterStart: Starts the filtering of the zones within the SET_ZONE_GOAL.
---
---## SET_ZONE_GOAL iterators
---
---Once the filters have been defined and the SET_ZONE_GOAL has been built, you can iterate the SET_ZONE_GOAL with the available iterator methods.
---The iterator methods will walk the SET_ZONE_GOAL set, and call for each airbase within the set a function that you provide.
---The following iterator methods are currently available within the SET_ZONE_GOAL:
---
---  * #SET_ZONE_GOAL.ForEachZone: Calls a function for each zone it finds within the SET_ZONE_GOAL.
---
---===
---@class SET_ZONE_GOAL : SET_BASE
SET_ZONE_GOAL = {}

---Handles the Database to check on an event (birth) that the Object was added in the Database.
---This is required, because sometimes the _DATABASE birth event gets called later than the SET_BASE birth event!
---
------
---@param self SET_ZONE_GOAL 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_ZONE_GOAL:AddInDatabase(Event) end

---Add ZONEs to SET_ZONE_GOAL.
---
------
---@param self SET_ZONE_GOAL 
---@param Zone ZONE_BASE A ZONE_BASE object.
---@return  #self
function SET_ZONE_GOAL:AddZone(Zone) end

---Builds a set of ZONE_GOALs that contain the given string in their name.
---**ATTENTION!** Bad naming convention as this **does not** filter only **prefixes** but all zones that **contain** the string.
---
------
---@param self SET_ZONE_GOAL 
---@param Prefixes string The string pattern(s) that needs to be contained in the zone name. Can also be passed as a `#table` of strings.
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:FilterPrefixes(Prefixes) end

---Starts the filtering.
---
------
---@param self SET_ZONE_GOAL 
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:FilterStart() end

---Stops the filtering for the defined collection.
---
------
---@param self SET_ZONE_GOAL 
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:FilterStop() end

---Handles the Database to check on any event that Object exists in the Database.
---This is required, because sometimes the _DATABASE event gets called later than the SET_BASE event or vise versa!
---
------
---@param self SET_ZONE_GOAL 
---@param Event EVENTDATA 
---@return string #The name of the AIRBASE
---@return table #The AIRBASE
function SET_ZONE_GOAL:FindInDatabase(Event) end

---Finds a Zone based on the Zone Name.
---
------
---@param self SET_ZONE_GOAL 
---@param ZoneName string 
---@return ZONE_BASE #The found Zone.
function SET_ZONE_GOAL:FindZone(ZoneName) end

---Iterate the SET_ZONE_GOAL and call an iterator function for each ZONE, providing the ZONE and optional parameters.
---
------
---@param self SET_ZONE_GOAL 
---@param IteratorFunction function The function that will be called when there is an alive ZONE in the SET_ZONE_GOAL. The function needs to accept a AIRBASE parameter.
---@param ... NOTYPE 
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:ForEachZone(IteratorFunction, ...) end

---Get a random zone from the set.
---
------
---@param self SET_ZONE_GOAL 
---@return ZONE_BASE #The random Zone.
---@return nil #if no zone in the collection.
function SET_ZONE_GOAL:GetRandomZone() end

---Validate if a coordinate is in one of the zones in the set.
---Returns the ZONE object where the coordiante is located.
---If zones overlap, the first zone that validates the test is returned.
---
------
---@param self SET_ZONE_GOAL 
---@param Coordinate COORDINATE The coordinate to be searched.
---@return ZONE_BASE #The zone that validates the coordinate location.
---@return nil #No zone has been found.
function SET_ZONE_GOAL:IsCoordinateInZone(Coordinate) end


---
------
---@param self SET_ZONE_GOAL 
---@param MZone ZONE_BASE 
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:IsIncludeObject(MZone) end

---Creates a new SET_ZONE_GOAL object, building a set of zones.
---
------
---
---USAGE
---```
----- Define a new SET_ZONE_GOAL Object. The DatabaseSet will contain a reference to all Zones.
---DatabaseSet = SET_ZONE_GOAL:New()
---```
------
---@param self SET_ZONE_GOAL 
---@return SET_ZONE_GOAL #self
function SET_ZONE_GOAL:New() end

---Handles the OnDead or OnCrash event for alive units set.
---
------
---@param self SET_ZONE_GOAL 
---@param EventData EVENTDATA 
function SET_ZONE_GOAL:OnEventDeleteZoneGoal(EventData) end

---Handles the OnEventNewZone event for the Set.
---
------
---@param self SET_ZONE_GOAL 
---@param EventData EVENTDATA 
function SET_ZONE_GOAL:OnEventNewZoneGoal(EventData) end

---Remove ZONEs from SET_ZONE_GOAL.
---
------
---@param self SET_ZONE_GOAL 
---@param RemoveZoneNames ZONE_BASE A single name or an array of ZONE_BASE names.
---@return  #self
function SET_ZONE_GOAL:RemoveZonesByName(RemoveZoneNames) end

---Set a zone probability.
---
------
---@param self SET_ZONE_GOAL 
---@param ZoneName string The name of the zone.
---@param ZoneProbability NOTYPE 
function SET_ZONE_GOAL:SetZoneProbability(ZoneName, ZoneProbability) end



