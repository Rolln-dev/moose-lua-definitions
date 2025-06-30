---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Cargo.JPG" width="100%">
---
---**Cargo** - Management of CARGO logistics, that can be transported from and to transportation carriers.
---
---===
---
---![Banner Image](..\Images\deprecated.png)
---
---# 1) MOOSE Cargo System.
---
---#### Those who have used the mission editor, know that the DCS mission editor provides cargo facilities.
---However, these are merely static objects. Wouldn't it be nice if cargo could bring a new dynamism into your
---simulations? Where various objects of various types could be treated also as cargo?
---
---This is what MOOSE brings to you, a complete new cargo object model that used the cargo capabilities of 
---DCS world, but enhances it.
---
---MOOSE Cargo introduces also a new concept, called a "carrier". These can be:
---
---  - Helicopters
---  - Planes
---  - Ground Vehicles
---  - Ships
---
---With the MOOSE Cargo system, you can:
---
---  - Take full control of the cargo as objects within your script (see below).
---  - Board/Unboard infantry into carriers. Also other objects can be boarded, like mortars.
---  - Load/Unload dcs world cargo objects into carriers.
---  - Load/Unload other static objects into carriers (like tires etc).
---  - Slingload cargo objects.
---  - Board units one by one...
---  
---# 2) MOOSE Cargo Objects.
---
---In order to make use of the MOOSE cargo system, you need to **declare** the DCS objects as MOOSE cargo objects!
---
---This sounds complicated, but it is actually quite simple.
---
---See here an example:
---
---    local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 250 )
---    
---The above code declares a MOOSE cargo object called `EngineerCargoGroup`.
---It actually just refers to an infantry group created within the sim called `"Engineers"`.
---The infantry group now becomes controlled by the MOOSE cargo object `EngineerCargoGroup`.
---A MOOSE cargo object also has properties, like the type of cargo, the logical name, and the reporting range.
---
---There are 4 types of MOOSE cargo objects possible, each represented by its own class:
---
---  - Cargo.CargoGroup#CARGO_GROUP: A MOOSE cargo that is represented by a DCS world GROUP object.
---  - Cargo.CargoCrate#CARGO_CRATE: A MOOSE cargo that is represented by a DCS world cargo object (static object).
---  - Cargo.CargoUnit#CARGO_UNIT: A MOOSE cargo that is represented by a DCS world unit object or static object.
---  - Cargo.CargoSlingload#CARGO_SLINGLOAD: A MOOSE cargo that is represented by a DCS world cargo object (static object), that can be slingloaded.
---  
---Note that a CARGO crate is not meant to be slingloaded (it can, but it is not **meant** to be handled like that.
---Instead, a CARGO_CRATE is able to load itself into the bays of a carrier.
---
---Each of these MOOSE cargo objects behave in its own way, and have methods to be handled.
---
---    local InfantryGroup = GROUP:FindByName( "Infantry" )
---    local InfantryCargo = CARGO_GROUP:New( InfantryGroup, "Engineers", "Infantry Engineers", 2000 )
---    local CargoCarrier = UNIT:FindByName( "Carrier" )
---    -- This call will make the Cargo run to the CargoCarrier.
---    -- Upon arrival at the CargoCarrier, the Cargo will be Loaded into the Carrier.
---    -- This process is now fully automated.
---    InfantryCargo:Board( CargoCarrier, 25 ) 
---
---The above would create a MOOSE cargo object called `InfantryCargo`, and using that object,
---you can board the cargo into the carrier `CargoCarrier`.
---Simple, isn't it? Told you, and this is only the beginning.
---
---The boarding, unboarding, loading, unloading of cargo is however something that is not meant to be coded manually by mission designers.
---It would be too low-level and not end-user friendly to deal with cargo handling complexity.
---Things can become really complex if you want to make cargo being handled and behave in multiple scenarios.
---
---# 3) Cargo Handling Classes, the main engines for mission designers!
---
---For this reason, the MOOSE Cargo System is heavily used by 3 important **cargo handling class hierarchies** within MOOSE,
---that make cargo come "alive" within your mission in a full automatic manner!
---
---## 3.1) AI Cargo handlers.
---
---  - AI.AI_Cargo_APC will create for you the capability to make an APC group handle cargo.
---  - AI.AI_Cargo_Helicopter will create for you the capability to make a Helicopter group handle cargo.
---  
---  
---## 3.2) AI Cargo transportation dispatchers.
---
---There are also dispatchers that make AI work together to transport cargo automatically!!!
---  
---  - AI.AI_Cargo_Dispatcher_APC derived classes will create for your dynamic cargo handlers controlled by AI ground vehicle groups (APCs) to transport cargo between sites.
---  - AI.AI_Cargo_Dispatcher_Helicopter derived classes will create for your dynamic cargo handlers controlled by AI helicopter groups to transport cargo between sites.
---
---## 3.3) Cargo transportation tasking.
---  
---And there is cargo transportation tasking for human players.
---  
---  - Tasking.Task_CARGO derived classes will create for you cargo transportation tasks, that allow human players to interact with MOOSE cargo objects to complete tasks.
---
---Please refer to the documentation reflected within these modules to understand the detailed capabilities.
---
---# 4) Cargo SETs.
---
---To make life a bit more easy, MOOSE cargo objects can be grouped into a Core.Set#SET_CARGO.
---This is a collection of MOOSE cargo objects.
---
---This would work as follows:
---
---     -- Define the cargo set.
---     local CargoSetWorkmaterials = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()
---     
---     -- Now add cargo the cargo set.
---     local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 250 )
---     local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 150, 50 )
---     local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 150, 50 )
---     local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 50 )
---     local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 150, 50 )
---
---This is a very powerful concept!
---Instead of having to deal with multiple MOOSE cargo objects yourself, the cargo set capability will group cargo objects into one set.
---The key is the **cargo type** name given at each cargo declaration!
---In the above example, the cargo type name is `"Workmaterials"`. Each cargo object declared is given that type name. (the 2nd parameter).
---What happens now is that the cargo set `CargoSetWorkmaterials` will be added with each cargo object **dynamically** when the cargo object is created.
---In other words, the cargo set `CargoSetWorkmaterials` will incorporate any `"Workmaterials"` dynamically into its set.
---
---The cargo sets are extremely important for the AI cargo transportation dispatchers and the cargo transporation tasking.
---
---# 5) Declare cargo directly in the mission editor!
---
---But I am not finished! There is something more, that is even more great!
---Imagine the mission designers having to code all these lines every time it wants to embed cargo within a mission.
--- 
---     -- Now add cargo the cargo set.
---     local EngineerCargoGroup = CARGO_GROUP:New( GROUP:FindByName( "Engineers" ), "Workmaterials", "Engineers", 250 )
---     local ConcreteCargo = CARGO_SLINGLOAD:New( STATIC:FindByName( "Concrete" ), "Workmaterials", "Concrete", 150, 50 )
---     local CrateCargo = CARGO_CRATE:New( STATIC:FindByName( "Crate" ), "Workmaterials", "Crate", 150, 50 )
---     local EnginesCargo = CARGO_CRATE:New( STATIC:FindByName( "Engines" ), "Workmaterials", "Engines", 150, 50 )
---     local MetalCargo = CARGO_CRATE:New( STATIC:FindByName( "Metal" ), "Workmaterials", "Metal", 150, 50 )
---
---This would be extremely tiring and a huge overload.
---However, the MOOSE framework allows to declare MOOSE cargo objects within the mission editor!!!
---
---So, at mission startup, MOOSE will search for objects following a special naming convention, and will **create** for you **dynamically
---cargo objects** at **mission start**!!! -- These cargo objects can then be automatically incorporated within cargo set(s)!!!
---In other words, your mission will be reduced to about a few lines of code, providing you with a full dynamic cargo handling mission!
---
---## 5.1) Use \#CARGO tags in the mission editor:
---
---MOOSE can create automatically cargo objects, if the name of the cargo contains the **\#CARGO** tag.
---When a mission starts, MOOSE will scan all group and static objects it found for the presence of the \#CARGO tag.
---When found, MOOSE will declare the object as cargo (create in the background a CARGO_ object, like CARGO_GROUP, CARGO_CRATE or CARGO_SLINGLOAD.
---The creation of these CARGO_ objects will allow to be filtered and automatically added in SET_CARGO objects.
---In other words, with very minimal code as explained in the above code section, you are able to create vast amounts of cargo objects just from within the editor.
---
---What I talk about is this:
---
---     -- BEFORE THIS SCRIPT STARTS, MOOSE WILL ALREADY HAVE SCANNED FOR OBJECTS WITH THE #CARGO TAG IN THE NAME.
---     -- FOR EACH OF THESE OBJECT, MOOSE WILL HAVE CREATED CARGO_ OBJECTS LIKE CARGO_GROUP, CARGO_CRATE AND CARGO_SLINGLOAD.
---
---     HQ = GROUP:FindByName( "HQ", "Bravo" )
---     
---     CommandCenter = COMMANDCENTER
---       :New( HQ, "Lima" )
---     
---     Mission = MISSION
---       :New( CommandCenter, "Operation Cargo Fun", "Tactical", "Transport Cargo", coalition.side.RED )
---     
---     TransportGroups = SET_GROUP:New():FilterCoalitions( "blue" ):FilterPrefixes( "Transport" ):FilterStart()
---     
---     TaskDispatcher = TASK_CARGO_DISPATCHER:New( Mission, TransportGroups )
---     
---     -- This is the most important now. You setup a new SET_CARGO filtering the relevant type.
---     -- The actual cargo objects are now created by MOOSE in the background.
---     -- Each cargo is setup in the Mission Editor using the #CARGO tag in the group name.
---     -- This allows a truly dynamic setup.
---     local CargoSetWorkmaterials = SET_CARGO:New():FilterTypes( "Workmaterials" ):FilterStart()
---     
---     local WorkplaceTask = TaskDispatcher:AddTransportTask( "Build a Workplace", CargoSetWorkmaterials, "Transport the workers, engineers and the equipment near the Workplace." )
---     TaskDispatcher:SetTransportDeployZone( WorkplaceTask, ZONE:New( "Workplace" ) )
---     
---The above code example has the `CargoSetWorkmaterials`, which is a SET_CARGO collection and will include the CARGO_ objects of the type "Workmaterials".    
---And there is NO cargo object actually declared within the script! However, if you would open the mission, there would be hundreds of cargo objects...
---
---The \#CARGO tag even allows for several options to be specified, which are important to learn.
---
---## 5.2) The \#CARGO tag to create CARGO_GROUP objects:
---
---You can also use the \#CARGO tag on **group** objects of the mission editor.
---
---For example, the following #CARGO naming in the **group name** of the object, will create a CARGO_GROUP object when the mission starts.
---
---  `Infantry #CARGO(T=Workmaterials,RR=500,NR=25)`
---
---This will create a CARGO_GROUP object:
---
---   * with the group name `Infantry #CARGO`
---   * is of type `Workmaterials`
---   * will report when a carrier is within 500 meters
---   * will board to carriers when the carrier is within 500 meters from the cargo object
---   * will disappear when the cargo is within 25 meters from the carrier during boarding
---
---So the overall syntax of the #CARGO naming tag and arguments are:
---
---  `GroupName #CARGO(T=CargoTypeName,RR=Range,NR=Range)`
---
---   * **T=** Provide a text that contains the type name of the cargo object. This type name can be used to filter cargo within a SET_CARGO object.
---   * **RR=** Provide the minimal range in meters when the report to the carrier, and board to the carrier.
---     Note that this option is optional, so can be omitted. The default value of the RR is 250 meters.
---   * **NR=** Provide the maximum range in meters when the cargo units will be boarded within the carrier during boarding.
---     Note that this option is optional, so can be omitted. The default value of the RR is 10 meters.
---
---## 5.2) The \#CARGO tag to create CARGO_CRATE or CARGO_SLINGLOAD objects:
---
---You can also use the \#CARGO tag on **static** objects, including **static cargo** objects of the mission editor.
---
---For example, the following #CARGO naming in the **static name** of the object, will create a CARGO_CRATE object when the mission starts.
---
---  `Static #CARGO(T=Workmaterials,C=CRATE,RR=500,NR=25)`
---
---This will create a CARGO_CRATE object:
---
---   * with the group name `Static #CARGO`
---   * is of type `Workmaterials`
---   * is of category `CRATE` (as opposed to `SLING`)
---   * will report when a carrier is within 500 meters
---   * will board to carriers when the carrier is within 500 meters from the cargo object
---   * will disappear when the cargo is within 25 meters from the carrier during boarding
---
---So the overall syntax of the #CARGO naming tag and arguments are:
---
---  `StaticName #CARGO(T=CargoTypeName,C=Category,RR=Range,NR=Range)`
---
---   * **T=** Provide a text that contains the type name of the cargo object. This type name can be used to filter cargo within a SET_CARGO object.
---   * **C=** Provide either `CRATE` or `SLING` to have this static created as a CARGO_CRATE or CARGO_SLINGLOAD respectively.
---   * **RR=** Provide the minimal range in meters when the report to the carrier, and board to the carrier.
---     Note that this option is optional, so can be omitted. The default value of the RR is 250 meters.
---   * **NR=** Provide the maximum range in meters when the cargo units will be boarded within the carrier during boarding.
---     Note that this option is optional, so can be omitted. The default value of the RR is 10 meters.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---===
---Defines the core functions that defines a cargo object within MOOSE.
---
---A cargo is a **logical object** defined that is available for transport, and has a life status within a simulation.
---
---CARGO is not meant to be used directly by mission designers, but provides a base class for **concrete cargo implementation classes** to handle:
---
---  * Cargo **group objects**, implemented by the Cargo.CargoGroup#CARGO_GROUP class.
---  * Cargo **Unit objects**, implemented by the Cargo.CargoUnit#CARGO_UNIT class.
---  * Cargo **Crate objects**, implemented by the Cargo.CargoCrate#CARGO_CRATE class.
---  * Cargo **Sling Load objects**, implemented by the Cargo.CargoSlingload#CARGO_SLINGLOAD class.
---
---The above cargo classes are used by the AI\_CARGO\_ classes to allow AI groups to transport cargo:
---
---  * AI Armoured Personnel Carriers to transport cargo and engage in battles, using the AI.AI_Cargo_APC#AI_CARGO_APC class.
---  * AI Helicopters to transport cargo, using the AI.AI_Cargo_Helicopter#AI_CARGO_HELICOPTER class.
---  * AI Planes to transport cargo, using the AI.AI_Cargo_Airplane#AI_CARGO_AIRPLANE class.
---  * AI Ships is planned.
---
---The above cargo classes are also used by the TASK\_CARGO\_ classes to allow human players to transport cargo as part of a tasking:
---
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_TRANSPORT to transport cargo by human players.
---  * Tasking.Task_Cargo_Transport#TASK_CARGO_CSAR to transport downed pilots by human players.
---
---
---The CARGO is a state machine: it manages the different events and states of the cargo.
---All derived classes from CARGO follow the same state machine, expose the same cargo event functions, and provide the same cargo states.
---
---## CARGO Events:
---
---  * #CARGO.Board( ToCarrier ):  Boards the cargo to a carrier.
---  * #CARGO.Load( ToCarrier ): Loads the cargo into a carrier, regardless of its position.
---  * #CARGO.UnBoard( ToPointVec2 ): UnBoard the cargo from a carrier. This will trigger a movement of the cargo to the option ToPointVec2.
---  * #CARGO.UnLoad( ToPointVec2 ): UnLoads the cargo from a carrier.
---  * #CARGO.Destroyed( Controllable ): The cargo is dead. The cargo process will be ended.
---@class CARGO 
---@field CargoCarrier CLIENT 
---@field CargoLimit number 
---@field CargoObject GROUP 
---@field CargoScheduler  
---@field Containable boolean 
---@field Deployed  
---@field Moveable boolean 
---@field Name  
---@field ReportFlareColor  
---@field ReportSmokeColor  
---@field Representable boolean 
---@field Slingloadable boolean 
---@field Type  
---@field Volume  
CARGO = {}

---Boards the cargo to a Carrier.
---The event will create a movement (= running or driving) of the cargo to the Carrier.
---The cargo must be in the **UnLoaded** state.
---
------
---@param self CARGO 
---@param ToCarrier CONTROLLABLE The Carrier that will hold the cargo.
---@param NearRadius number The radius when the cargo will board the Carrier (to avoid collision).
function CARGO:Board(ToCarrier, NearRadius) end

---Check if the cargo can be Boarded.
---
------
---@param self CARGO 
function CARGO:CanBoard() end

---Check if the cargo can be Loaded.
---
------
---@param self CARGO 
function CARGO:CanLoad() end

---Check if the cargo can be Slingloaded.
---
------
---@param self CARGO 
function CARGO:CanSlingload() end

---Check if the cargo can be Unboarded.
---
------
---@param self CARGO 
function CARGO:CanUnboard() end

---Check if the cargo can be Unloaded.
---
------
---@param self CARGO 
function CARGO:CanUnload() end

---Destroy the cargo.
---
------
---@param self CARGO 
function CARGO:Destroy() end

---Find a CARGO in the _DATABASE.
---
------
---@param self CARGO 
---@param CargoName string The Cargo Name.
---@return CARGO #self
function CARGO:FindByName(CargoName) end

---Signal a flare at the position of the CARGO.
---
------
---@param self CARGO 
---@param FlareColor FLARECOLOR 
function CARGO:Flare(FlareColor) end

---Signal a green flare at the position of the CARGO.
---
------
---@param self CARGO 
function CARGO:FlareGreen() end

---Signal a red flare at the position of the CARGO.
---
------
---@param self CARGO 
function CARGO:FlareRed() end

---Signal a white flare at the position of the CARGO.
---
------
---@param self CARGO 
function CARGO:FlareWhite() end

---Signal a yellow flare at the position of the CARGO.
---
------
---@param self CARGO 
function CARGO:FlareYellow() end

---Get the coalition of the Cargo.
---
------
---@param self CARGO 
---@return  #Coalition
function CARGO:GetCoalition() end

---Get the current coordinates of the Cargo.
---
------
---@param self CARGO 
---@return COORDINATE #The coordinates of the Cargo.
function CARGO:GetCoordinate() end

---Get the amount of Cargo.
---
------
---@param self CARGO 
---@return number #The amount of Cargo.
function CARGO:GetCount() end

---Get the heading of the cargo.
---
------
---@param self CARGO 
---@return number #
function CARGO:GetHeading() end

---Get the Load radius, which is the radius till when the Cargo can be loaded.
---
------
---@param self CARGO 
---@return number #The radius till Cargo can be loaded.
function CARGO:GetLoadRadius() end

---Get the name of the Cargo.
---
------
---@param self CARGO 
---@return string #The name of the Cargo.
function CARGO:GetName() end

---Get the current active object representing or being the Cargo.
---
------
---@param self CARGO 
---@return POSITIONABLE #The object representing or being the Cargo.
function CARGO:GetObject() end

---Get the object name of the Cargo.
---
------
---@param self CARGO 
---@return string #The object name of the Cargo.
function CARGO:GetObjectName() end

---Get the current PointVec2 of the cargo.
---
------
---@param self CARGO 
---@return COORDINATE #
function CARGO:GetPointVec2() end

---Get the transportation method of the Cargo.
---
------
---@param self CARGO 
---@return string #The transportation method of the Cargo.
function CARGO:GetTransportationMethod() end

---Get the type of the Cargo.
---
------
---@param self CARGO 
---@return string #The type of the Cargo.
function CARGO:GetType() end

---Get the volume of the cargo.
---
------
---@param self CARGO 
---@return number #Volume The volume in kg.
function CARGO:GetVolume() end

---Get the weight of the cargo.
---
------
---@param self CARGO 
---@return number #Weight The weight in kg.
function CARGO:GetWeight() end

---Get the x position of the cargo.
---
------
---@param self CARGO 
---@return number #
function CARGO:GetX() end

---Get the y position of the cargo.
---
------
---@param self CARGO 
---@return number #
function CARGO:GetY() end

---Check if cargo is alive.
---
------
---@param self CARGO 
---@return boolean #true if unloaded
function CARGO:IsAlive() end

---Check if cargo is boarding.
---
------
---@param self CARGO 
---@return boolean #true if boarding
function CARGO:IsBoarding() end

---Is the cargo deployed
---
------
---@param self CARGO 
---@return boolean #
function CARGO:IsDeployed() end

---Check if cargo is destroyed.
---
------
---@param self CARGO 
---@return boolean #true if destroyed
function CARGO:IsDestroyed() end

---Check if Cargo is in the LoadRadius for the Cargo to be Boarded or Loaded.
---
------
---@param self CARGO 
---@param Coordinate COORDINATE 
---@return boolean #true if the CargoGroup is within the loading radius.
function CARGO:IsInLoadRadius(Coordinate) end

---Check if the Cargo can report itself to be Boarded or Loaded.
---
------
---@param self CARGO 
---@param Coordinate COORDINATE 
---@return boolean #true if the Cargo can report itself.
function CARGO:IsInReportRadius(Coordinate) end

---Check if Cargo is the given Core.Zone.
---
------
---@param self CARGO 
---@param Zone ZONE_BASE 
---@return boolean #**true** if cargo is in the Zone, **false** if cargo is not in the Zone.
function CARGO:IsInZone(Zone) end

---Check if cargo is loaded.
---
------
---@param self CARGO 
---@return boolean #true if loaded
function CARGO:IsLoaded() end

---Check if cargo is loaded.
---
------
---@param self CARGO 
---@param Carrier UNIT 
---@return boolean #true if loaded
function CARGO:IsLoadedInCarrier(Carrier) end

---Check if CargoCarrier is near the coordinate within NearRadius.
---
------
---@param self CARGO 
---@param Coordinate COORDINATE 
---@param NearRadius number The radius when the cargo will board the Carrier (to avoid collision).
---@return boolean #
function CARGO:IsNear(Coordinate, NearRadius) end

---Check if cargo is unloaded.
---
------
---@param self CARGO 
---@return boolean #true if unloaded
function CARGO:IsUnLoaded() end

---Check if cargo is unboarding.
---
------
---@param self CARGO 
---@return boolean #true if unboarding
function CARGO:IsUnboarding() end

---Loads the cargo to a Carrier.
---The event will load the cargo into the Carrier regardless of its position. There will be no movement simulated of the cargo loading.
---The cargo must be in the **UnLoaded** state.
---
------
---@param self CARGO 
---@param ToCarrier CONTROLLABLE The Carrier that will hold the cargo.
function CARGO:Load(ToCarrier) end

---Send a CC message to a Wrapper.Group.
---
------
---@param self CARGO 
---@param Message string 
---@param CarrierGroup GROUP The Carrier Group.
---@param Name string (optional) The name of the Group used as a prefix for the message to the Group. If not provided, there will be nothing shown.
function CARGO:MessageToGroup(Message, CarrierGroup, Name) end

---CARGO Constructor.
---This class is an abstract class and should not be instantiated.
---
------
---@param self CARGO 
---@param Type string 
---@param Name string 
---@param Weight number 
---@param LoadRadius number (optional)
---@param NearRadius number (optional)
---@return CARGO #
function CARGO:New(Type, Name, Weight, LoadRadius, NearRadius) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
---@param NearRadius number The radius when the cargo will board the Carrier (to avoid collision).
function CARGO:OnEnterBoarding(Controllable, NearRadius) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
function CARGO:OnEnterLoaded(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
function CARGO:OnEnterUnBoarding(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
function CARGO:OnEnterUnLoaded(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
---@return boolean #
function CARGO:OnLeaveBoarding(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
---@return boolean #
function CARGO:OnLeaveLoaded(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
---@return boolean #
function CARGO:OnLeaveUnBoarding(Controllable) end


---
------
---@param self CARGO 
---@param Controllable CONTROLLABLE 
---@return boolean #
function CARGO:OnLeaveUnLoaded(Controllable) end

---Report to a Carrier Group.
---
------
---@param self CARGO 
---@param Action string The string describing the action for the cargo.
---@param CarrierGroup GROUP The Carrier Group to send the report to.
---@param ReportText NOTYPE 
---@return CARGO #
function CARGO:Report(Action, CarrierGroup, ReportText) end

---Report to a Carrier Group with a Flaring signal.
---
------
---@param self CARGO 
---@param FlareColor UTILS.FlareColor the color of the flare.
---@return CARGO #
function CARGO:ReportFlare(FlareColor) end

---Reset the reporting for a Carrier Group.
---
------
---@param self CARGO 
---@param Action string The string describing the action for the cargo.
---@param CarrierGroup GROUP The Carrier Group to send the report to.
---@return CARGO #
function CARGO:ReportReset(Action, CarrierGroup) end

---Reset all the reporting for a Carrier Group.
---
------
---@param self CARGO 
---@param CarrierGroup GROUP The Carrier Group to send the report to.
---@return CARGO #
function CARGO:ReportResetAll(CarrierGroup) end

---Report to a Carrier Group with a Smoking signal.
---
------
---@param self CARGO 
---@param SmokeColor UTILS.SmokeColor the color of the smoke.
---@return CARGO #
function CARGO:ReportSmoke(SmokeColor) end

---Respawn the cargo when destroyed
---
------
---@param self CARGO 
---@param RespawnDestroyed boolean 
function CARGO:RespawnOnDestroyed(RespawnDestroyed) end

---Set the cargo as deployed.
---
------
---@param self CARGO 
---@param Deployed boolean true if the cargo is to be deployed. false or nil otherwise.
function CARGO:SetDeployed(Deployed) end

---Set the Load radius, which is the radius till when the Cargo can be loaded.
---
------
---@param self CARGO 
---@param LoadRadius number The radius till Cargo can be loaded.
---@return CARGO #
function CARGO:SetLoadRadius(LoadRadius) end

---Set the volume of the cargo.
---
------
---@param self CARGO 
---@param Volume number The volume in kg.
---@return CARGO #
function CARGO:SetVolume(Volume) end

---Set the weight of the cargo.
---
------
---@param self CARGO 
---@param Weight number The weight in kg.
---@return CARGO #
function CARGO:SetWeight(Weight) end

---Smoke the CARGO.
---
------
---@param self CARGO 
---@param SmokeColor SMOKECOLOR The color of the smoke.
---@param Radius number The radius of randomization around the center of the Cargo.
function CARGO:Smoke(SmokeColor, Radius) end

---Smoke the CARGO Blue.
---
------
---@param self CARGO 
function CARGO:SmokeBlue() end

---Smoke the CARGO Green.
---
------
---@param self CARGO 
function CARGO:SmokeGreen() end

---Smoke the CARGO Orange.
---
------
---@param self CARGO 
function CARGO:SmokeOrange() end

---Smoke the CARGO Red.
---
------
---@param self CARGO 
function CARGO:SmokeRed() end

---Smoke the CARGO White.
---
------
---@param self CARGO 
function CARGO:SmokeWhite() end

---Template method to spawn a new representation of the CARGO in the simulator.
---
------
---@param self CARGO 
---@param PointVec2 NOTYPE 
---@return CARGO #
function CARGO:Spawn(PointVec2) end

---UnBoards the cargo to a Carrier.
---The event will create a movement (= running or driving) of the cargo from the Carrier.
---The cargo must be in the **Loaded** state.
---
------
---@param self CARGO 
---@param ToPointVec2 COORDINATE (optional) @{Core.Point#COORDINATE) to where the cargo should run after onboarding. If not provided, the cargo will run to 60 meters behind the Carrier location.
function CARGO:UnBoard(ToPointVec2) end

---UnLoads the cargo to a Carrier.
---The event will unload the cargo from the Carrier. There will be no movement simulated of the cargo loading.
---The cargo must be in the **Loaded** state.
---
------
---@param self CARGO 
---@param ToPointVec2 COORDINATE (optional) @{Core.Point#COORDINATE) to where the cargo will be placed after unloading. If not provided, the cargo will be placed 60 meters behind the Carrier location.
function CARGO:UnLoad(ToPointVec2) end

---Boards the cargo to a Carrier.
---The event will create a movement (= running or driving) of the cargo to the Carrier.
---The cargo must be in the **UnLoaded** state.
---
------
---@param self CARGO 
---@param DelaySeconds number The amount of seconds to delay the action.
---@param ToCarrier CONTROLLABLE The Carrier that will hold the cargo.
---@param NearRadius number The radius when the cargo will board the Carrier (to avoid collision).
function CARGO:__Board(DelaySeconds, ToCarrier, NearRadius) end

---Loads the cargo to a Carrier.
---The event will load the cargo into the Carrier regardless of its position. There will be no movement simulated of the cargo loading.
---The cargo must be in the **UnLoaded** state.
---
------
---@param self CARGO 
---@param DelaySeconds number The amount of seconds to delay the action.
---@param ToCarrier CONTROLLABLE The Carrier that will hold the cargo.
function CARGO:__Load(DelaySeconds, ToCarrier) end

---UnBoards the cargo to a Carrier.
---The event will create a movement (= running or driving) of the cargo from the Carrier.
---The cargo must be in the **Loaded** state.
---
------
---@param self CARGO 
---@param DelaySeconds number The amount of seconds to delay the action.
---@param ToPointVec2 COORDINATE (optional) @{Core.Point#COORDINATE) to where the cargo should run after onboarding. If not provided, the cargo will run to 60 meters behind the Carrier location.
function CARGO:__UnBoard(DelaySeconds, ToPointVec2) end

---UnLoads the cargo to a Carrier.
---The event will unload the cargo from the Carrier. There will be no movement simulated of the cargo loading.
---The cargo must be in the **Loaded** state.
---
------
---@param self CARGO 
---@param DelaySeconds number The amount of seconds to delay the action.
---@param ToPointVec2 COORDINATE (optional) @{Core.Point#COORDINATE) to where the cargo will be placed after unloading. If not provided, the cargo will be placed 60 meters behind the Carrier location.
function CARGO:__UnLoad(DelaySeconds, ToPointVec2) end


---
------
---@param self NOTYPE 
function CARGO:onenterDestroyed() end


--- @type CARGO_PACKAGE
--- @extends #CARGO_REPRESENTABLE
---@class CARGO_PACKAGE 
---@field CargoCarrier  
---@field CargoInAir  
CARGO_PACKAGE = {}


---Models CARGO that is representable by a Unit.
---@class CARGO_REPRESENTABLE 
CARGO_REPRESENTABLE = {}

---CARGO_REPRESENTABLE Destructor.
---
------
---@param self CARGO_REPRESENTABLE 
---@return CARGO_REPRESENTABLE #
function CARGO_REPRESENTABLE:Destroy() end

---Send a message to a Wrapper.Group through a communication channel near the cargo.
---
------
---@param self CARGO_REPRESENTABLE 
---@param Message string 
---@param TaskGroup GROUP 
---@param Name string (optional) The name of the Group used as a prefix for the message to the Group. If not provided, there will be nothing shown.
function CARGO_REPRESENTABLE:MessageToGroup(Message, TaskGroup, Name) end

---CARGO_REPRESENTABLE Constructor.
---
------
---@param self CARGO_REPRESENTABLE 
---@param CargoObject POSITIONABLE The cargo object.
---@param Type string Type name
---@param Name string Name.
---@param LoadRadius number (optional) Radius in meters.
---@param NearRadius number (optional) Radius in meters when the cargo is loaded into the carrier.
---@return CARGO_REPRESENTABLE #
function CARGO_REPRESENTABLE:New(CargoObject, Type, Name, LoadRadius, NearRadius) end

---Route a cargo unit to a PointVec2.
---
------
---@param self CARGO_REPRESENTABLE 
---@param ToPointVec2 COORDINATE 
---@param Speed number 
---@return CARGO_REPRESENTABLE #
function CARGO_REPRESENTABLE:RouteTo(ToPointVec2, Speed) end



