---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Artillery.JPG" width="100%">
---
---**Functional** -- Send a truck to supply artillery groups.
---
---===
---
---**AMMOTRUCK** - Send a truck to supply artillery groups.
---
---===
---
---## Missions:
---
---Demo missions can be found on [GitHub](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/develop/Functional/AmmoTruck)
---
---===
---
---### Author : **applevangelist**
---*Amateurs talk about tactics, but professionals study logistics.* - General Robert H Barrow, USMC
---
---Simple Class to re-arm your artillery with trucks.
---
---#AMMOTRUCK
---
---* Controls a SET\_GROUP of trucks which will re-arm a SET\_GROUP of artillery groups when they run out of ammunition. 
---
---## 1 The AMMOTRUCK concept
---
---A SET\_GROUP of trucks which will re-arm a SET\_GROUP of artillery groups when they run out of ammunition. They will be based on a
---homebase and drive from there to the artillery groups and then back home.
---Trucks are the **only known in-game mechanic** to re-arm artillery and other units in DCS. Working units are e.g.: M-939 (blue), Ural-375 and ZIL-135 (both red).
---
---## 2 Set-up
---
---Define a set of trucks and a set of artillery:  
---
---           local truckset = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterCategoryGround():FilterPrefixes("Ammo Truck"):FilterStart()
---           local ariset = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterCategoryGround():FilterPrefixes("Artillery"):FilterStart()
---
---Create an AMMOTRUCK object to take care of the artillery using the trucks, with a homezone:  
---
---           local ammotruck = AMMOTRUCK:New(truckset,ariset,coalition.side.BLUE,"Logistics",ZONE:FindByName("HomeZone") 
---           
---## 2 Options and their default values
---
---           ammotruck.ammothreshold = 5 -- send a truck when down to this many rounds
---           ammotruck.remunidist = 20000 -- 20km - send trucks max this far from home
---           ammotruck.unloadtime = 600 -- 10 minutes - min time to unload ammunition
---           ammotruck.waitingtime = 1800 -- 30 mintes - wait max this long until remunition is done
---           ammotruck.monitor = -60 -- 1 minute - AMMOTRUCK checks run every one minute
---           ammotruck.routeonroad = true -- Trucks will **try** to drive on roads
---           ammotruck.usearmygroup = false -- If true, will make use of ARMYGROUP in the background (if used in DEV branch)
---           ammotruck.reloads = 5 -- Maxn re-arms a truck can do before he needs to go home and restock. Set to -1 for unlimited
---
---## 3 FSM Events to shape mission
---
---Truck has been sent off:
---
---           function ammotruck:OnAfterRouteTruck(From, Event, To, Truckdata, Aridata)
---             ...
---           end
---           
---Truck has arrived:
---
---           function ammotruck:OnAfterTruckArrived(From, Event, To, Truckdata)
---             ...
---           end 
---
---Truck is unloading:
---
---           function ammotruck:OnAfterTruckUnloading(From, Event, To, Truckdata)
---             ...
---           end 
---
---Truck is returning home:
---
---           function ammotruck:OnAfterTruckReturning(From, Event, To, Truckdata)
---             ...
---           end  
---
---Truck is arrived at home:
---
---           function ammotruck:OnAfterTruckHome(From, Event, To, Truckdata)
---             ...
---           end 
---- **AMMOTRUCK** class, extends Core.Fsm#FSM
---@class AMMOTRUCK : FSM
---@field ClassName string Class Name
---@field State AMMOTRUCK.State 
---@field private alias string Alias name
---@field private ammothreshold number Threshold (min) ammo before sending a truck
---@field private coalition number Coalition this is for
---@field private debug boolean Debug flag
---@field private hasarmygroup boolean 
---@field private homezone ZONE 
---@field private lid string Lid for log entries
---@field private monitor number Monitor interval in seconds
---@field private reloads number Number of reloads a single truck can do before he must return home
---@field private remunidist number Max distance trucks will go
---@field private remunitionqueue table List of (alive) #AMMOTRUCK.data artillery to be reloaded
---@field private routeonroad boolean Route truck on road if true (default)
---@field private targetlist table  List of (alive) #AMMOTRUCK.data artillery
---@field private targetset SET_GROUP SET of artillery
---@field private trucklist table List of (alive) #AMMOTRUCK.data trucks
---@field private truckset SET_GROUP SET of trucks
---@field private unloadtime number Unload time in seconds
---@field private usearmygroup boolean 
---@field private version string Version string
---@field private waitingtargets table  List of (alive) #AMMOTRUCK.data artillery waiting
---@field private waitingtime number Max waiting time in seconds
AMMOTRUCK = {}


---
------
---@param dataset table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckArrivedTrucks(dataset) end


---
------
---@param dataset table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckDrivingTrucks(dataset) end


---
------
---@param dataset table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckReturningTrucks(dataset) end


---
------
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckTargetsAlive() end


---
------
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckTrucksAlive() end


---
------
---@param dataset table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckUnloadingTrucks(dataset) end


---
------
---@param dataset table table of #AMMOTRUCK.data entries
---@return AMMOTRUCK #self 
function AMMOTRUCK:CheckWaitingTargets(dataset) end


---
------
---@param name string Artillery group name to find
---@return AMMOTRUCK.data #Data
function AMMOTRUCK:FindTarget(name) end


---
------
---@param name string Truck group name to find
---@return AMMOTRUCK.data #Data
function AMMOTRUCK:FindTruck(name) end


---
------
---@param Group GROUP 
---@return AMMOTRUCK #self 
function AMMOTRUCK:GetAmmoStatus(Group) end


---
------
---
---USAGE
---```
---Define a set of trucks and a set of artillery:  
---           local truckset = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterCategoryGround():FilterPrefixes("Ammo Truck"):FilterStart()
---           local ariset = SET_GROUP:New():FilterCoalitions("blue"):FilterActive(true):FilterCategoryGround():FilterPrefixes("Artillery"):FilterStart()
---
---Create an AMMOTRUCK object to take care of the artillery using the trucks, with a homezone:  
---           local ammotruck = AMMOTRUCK:New(truckset,ariset,coalition.side.BLUE,"Logistics",ZONE:FindByName("HomeZone")
---```
------
---@param Truckset SET_GROUP Set of truck groups
---@param Targetset SET_GROUP Set of artillery groups
---@param Coalition number Coalition
---@param Alias string Alias Name
---@param Homezone ZONE Home, return zone for trucks 
---@return AMMOTRUCK #self
function AMMOTRUCK:New(Truckset, Targetset, Coalition, Alias, Homezone) end

---On after "RouteTruck" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Truck AMMOTRUCK.data 
function AMMOTRUCK:OnAfterRouteTruck(From, Event, To, Truck) end

---On after "TruckHome" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Truck AMMOTRUCK.data 
function AMMOTRUCK:OnAfterTruckHome(From, Event, To, Truck) end

---On after "TruckReturning" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Truck AMMOTRUCK.data 
function AMMOTRUCK:OnAfterTruckReturning(From, Event, To, Truck) end

---On after "TruckUnloading" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Truck AMMOTRUCK.data 
function AMMOTRUCK:OnAfterTruckUnloading(From, Event, To, Truck) end

---Triggers the FSM event "Stop".
---Stops the AMMOTRUCK and all its event handlers.
---
------
function AMMOTRUCK:Stop() end

---Triggers the FSM event "Stop" after a delay.
---Stops the AMMOTRUCK and all its event handlers.
---
------
---@param delay number Delay in seconds.
function AMMOTRUCK:__Stop(delay) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterMonitor(From, Event, To) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Truckdata AMMOTRUCK.data 
---@param Aridata AMMOTRUCK.data 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterRouteTruck(From, Event, To, Truckdata, Aridata) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterStart(From, Event, To) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterStop(From, Event, To) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Truck AMMOTRUCK.data 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterTruckReturning(From, Event, To, Truck) end


---
------
---@param From string 
---@param Event string 
---@param To string 
---@param Truckdata AMMOTRUCK.data 
---@return AMMOTRUCK #self 
---@private
function AMMOTRUCK:onafterTruckUnloading(From, Event, To, Truckdata) end


---@class AMMOTRUCK.State 
---@field ARRIVED string 
---@field DRIVING string 
---@field IDLE string 
---@field OUTOFAMMO string 
---@field RELOADING string 
---@field REQUESTED string 
---@field RETURNING string 
---@field UNLOADING string 
---@field WAITING string 
AMMOTRUCK.State = {}


---@class AMMOTRUCK.data 
---@field private ammo number 
---@field private coordinate COORDINATE 
---@field private group GROUP 
---@field private lastspeed NOTYPE 
---@field private name string 
---@field private reloads number 
---@field private statusquo AMMOTRUCK.State 
---@field private targetcoordinate COORDINATE 
---@field private targetgroup GROUP 
---@field private targetname string 
---@field private timestamp number 
AMMOTRUCK.data = {}



