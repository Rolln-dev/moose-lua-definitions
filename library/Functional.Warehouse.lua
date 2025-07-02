---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Warehouse.JPG" width="100%">
---
---**Functional** - Simulation of logistic operations.
---
---===
---
---## Features:
---
---   * Holds (virtual) assets in stock and spawns them upon request.
---   * Manages requests of assets from other warehouses.
---   * Queueing system with optional prioritization of requests.
---   * Realistic transportation of assets between warehouses.
---   * Different means of automatic transportation (planes, helicopters, APCs, self propelled).
---   * Strategic components such as capturing, defending and destroying warehouses and their associated infrastructure.
---   * Intelligent spawning of aircraft on airports (only if enough parking spots are available).
---   * Possibility to hook into events and customize actions.
---   * Persistence of assets. Warehouse assets can be saved and loaded from file.
---   * Can be easily interfaced to other MOOSE classes.
---
---===
---
---## Youtube Videos:
---
---   * [Warehouse Trailer](https://www.youtube.com/watch?v=e98jzLi5fGk)
---   * [DCS Warehouse Airbase Resources Proof Of Concept](https://www.youtube.com/watch?v=YeuGL0duEgY)
---
---===
---
---## Missions:
---
---===
---
---The MOOSE warehouse concept simulates the organization and implementation of complex operations regarding the flow of assets between the point of origin and the point of consumption
---in order to meet requirements of a potential conflict. In particular, this class is concerned with maintaining army supply lines while disrupting those of the enemy, since an armed
---force without resources and transportation is defenseless.
---
---===
---
---### Author: **funkyfranky**
---### Co-author: FlightControl (cargo dispatcher classes)
---
---===
---Have your assets at the right place at the right time - or not!
---
---===
---
---# The Warehouse Concept
---
---The MOOSE warehouse adds a new logistic component to the DCS World.
---*Assets*, i.e. ground, airborne and naval units, can be transferred from one place
---to another in a realistic and highly automatic fashion. In contrast to a "DCS warehouse" these assets have a physical representation in game. In particular,
---this means they can be destroyed during the transport and add more life to the DCS world.
---
---This comes along with some additional interesting strategic aspects since capturing/defending and destroying/protecting an enemy or your
---own warehouse becomes of critical importance for the development of a conflict.
---
---In essence, creating an efficient network of warehouses is vital for the success of a battle or even the whole war. Likewise, of course, cutting off the enemy
---of important supply lines by capturing or destroying warehouses or their associated infrastructure is equally important.
---
---## What is a warehouse?
---
---A warehouse is an abstract object represented by a physical (static) building that can hold virtual assets in stock.
---It can (but it must not) be associated with a particular airbase. The associated airbase can be an airdrome, a Helipad/FARP or a ship.
---
---If another warehouse requests assets, the corresponding troops are spawned at the warehouse and being transported to the requestor or go their
---by themselfs. Once arrived at the requesting warehouse, the assets go into the stock of the requestor and can be activated/deployed when necessary.
---
---## What assets can be stored?
---
---Any kind of ground, airborne or naval asset can be stored and are spawned upon request.
---The fact that the assets live only virtually in stock and are put into the game only when needed has a positive impact on the game performance.
---It also alliviates the problem of limited parking spots at smaller airbases.
---
---## What means of transportation are available?
---
---Firstly, all mobile assets can be send from warehouse to another on their own.
---
---* Ground vehicles will use the road infrastructure. So a good road connection for both warehouses is important but also off road connections can be added if necessary.
---* Airborne units get a flightplan from the airbase of the sending warehouse to the airbase of the receiving warehouse. This already implies that for airborne
---assets both warehouses need an airbase. If either one of the warehouses does not have an associated airbase, direct transportation of airborne assets is not possible.
---* Naval units can be exchanged between warehouses which possess a port, which can be defined by the user. Also shipping lanes must be specified manually but the user since DCS does not provide these.
---* Trains (would) use the available railroad infrastructure and both warehouses must have a connection to the railroad. Unfortunately, however, trains are not yet implemented to
---a reasonable degree in DCS at the moment and hence cannot be used yet.
---
---Furthermore, ground assets can be transferred between warehouses by transport units. These are APCs, helicopters and airplanes. The transportation process is modeled
---in a realistic way by using the corresponding cargo dispatcher classes, i.e.
---
---* AI.AI_Cargo_Dispatcher_APC#AI_DISPATCHER_APC
---* AI.AI_Cargo_Dispatcher_Helicopter#AI_DISPATCHER_HELICOPTER
---* AI.AI_Cargo_Dispatcher_Airplane#AI_DISPATCHER_AIRPLANE
---
---Depending on which cargo dispatcher is used (ground or airbore), similar considerations like in the self propelled case are necessary. Howver, note that
---the dispatchers as of yet cannot use user defined off road paths for example since they are classes of their own and use a different routing logic.
---
---===
---
---# Creating a Warehouse
---
---A MOOSE warehouse must be represented in game by a physical *static* object. For example, the mission editor already has warehouse as static object available.
---This would be a good first choice but any static object will do.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Static.png)
---
---The positioning of the warehouse static object is very important for a couple of reasons. Firstly, a warehouse needs a good infrastructure so that spawned assets
---have a proper road connection or can reach the associated airbase easily.
---
---## Constructor and Start
---
---Once the static warehouse object is placed in the mission editor it can be used as a MOOSE warehouse by the #WAREHOUSE.New(*warehousestatic*, *alias*) constructor,
---like for example:
---
---    warehouseBatumi=WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"), "My optional Warehouse Alias")
---    warehouseBatumi:Start()
---
---The first parameter *warehousestatic* is the static MOOSE object. By default, the name of the warehouse will be the same as the name given to the static object.
---The second parameter *alias* is optional and can be used to choose a more convenient name if desired. This will be the name the warehouse calls itself when reporting messages.
---
---Note that a warehouse also needs to be started in order to be in service. This is done with the #WAREHOUSE.Start() or #WAREHOUSE.__Start(*delay*) functions.
---The warehouse is now fully operational and requests are being processed.
---
---# Adding Assets
---
---Assets can be added to the warehouse stock by using the #WAREHOUSE.AddAsset(*group*, *ngroups*, *forceattribute*, *forcecargobay*, *forceweight*, *loadradius*, *skill*, *liveries*, *assignment*) function.
---The parameter *group* has to be a MOOSE Wrapper.Group#GROUP. This is also the only mandatory parameters. All other parameters are optional and can be used for fine tuning if
---nessary. The parameter *ngroups* specifies how many clones of this group are added to the stock.
---
---    infrantry=GROUP:FindByName("Some Infantry Group")
---    warehouseBatumi:AddAsset(infantry, 5)
---
---This will add five infantry groups to the warehouse stock. Note that the group should normally be a late activated template group,
---which was defined in the mission editor. But you can also add other groups which are already spawned and present in the mission.
---
---Also note that the coalition of the template group (red, blue or neutral) does not matter. The coalition of the assets is determined by the coalition of the warehouse owner.
---In other words, it is no problem to add red groups to blue warehouses and vice versa. The assets will automatically have the coalition of the warehouse.
---
---You can add assets with a delay by using the #WAREHOUSE.__AddAsset(*delay*, *group*, *ngroups*, *forceattribute*, *forcecargobay*, *forceweight*, *loadradius*,  *skill*, *liveries*, *assignment*),
---where *delay* is the delay in seconds before the asset is added.
---
---In game, the warehouse will get a mark which is regularly updated and showing the currently available assets in stock.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Stock-Marker.png)
---
---## Optional Parameters for Fine Tuning
---
---By default, the generalized attribute of the asset is determined automatically from the DCS descriptor attributes. However, this might not always result in the desired outcome.
---Therefore, it is possible, to force a generalized attribute for the asset with the third optional parameter *forceattribute*, which is of type #WAREHOUSE.Attribute.
---
---### Setting the Generalized Attibute
---For example, a UH-1H Huey has in DCS the attibute of an attack helicopter. But of course, it can also transport cargo. If you want to use it for transportation, you can specify this
---manually when the asset is added
---
---    warehouseBatumi:AddAsset("Huey", 5, WAREHOUSE.Attribute.AIR_TRANSPORTHELO)
---
---This becomes important when assets are requested from other warehouses as described below. In this case, the five Hueys are now marked as transport helicopters and
---not attack helicopters. This is also particularly useful when adding assets to a warehouse with the intention of using them to transport other units that are part of 
---a subsequent request (see below). Setting the attribute will help to ensure that warehouse module can find the correct unit when attempting to service a request in its
---queue. For example, if we want to add an Amphibious Landing Ship, even though most are indeed armed, it's recommended to do the following:
---
---    warehouseBatumi:AddAsset("Landing Ship", 1, WAREHOUSE.Attribute.NAVAL_UNARMEDSHIP)
---
---Then when adding the request, you can simply specify WAREHOUSE.TransportType.SHIP (which corresponds to NAVAL_UNARMEDSHIP) as the TransportType.
---
---### Setting the Cargo Bay Weight Limit
---You can ajust the cargo bay weight limit, in case it is not calculated correctly automatically. For example, the cargo bay of a C-17A is much smaller in DCS than that of a C-130, which is
---unrealistic. This can be corrected by the *forcecargobay* parmeter which is here set to 77,000 kg
---
---    warehouseBatumi:AddAsset("C-17A", nil, nil, 77000)
---
---The size of the cargo bay is only important when the group is used as transport carrier for other assets.
---
---### Setting the Weight
---If an asset shall be transported by a carrier it important to note that - as in real life - a carrier can only carry cargo up to a certain weight. The weight of the
---units is automatically determined from the DCS descriptor table.
---However, in the current DCS version (2.5.3) a mortar unit has a weight of 5 tons. This confuses the transporter logic, because it appears to be too have for, e.g. all APCs.
---
---As a workaround, you can manually adjust the weight by the optional *forceweight* parameter:
---
---    warehouseBatumi:AddAsset("Mortar Alpha", nil, nil, nil, 210)
---
--- In this case we set it to 210 kg. Note, the weight value set is meant for *each* unit in the group. Therefore, a group consisting of three mortars will have a total weight
--- of 630 kg. This is important as groups cannot be split between carrier units when transporting, i.e. the total weight of the whole group must be smaller than the
--- cargo bay of the transport carrier.
---
---### Setting the Load Radius
---Boading and loading of cargo into a carrier is modeled in a realistic fashion in the AI\_CARGO\DISPATCHER classes, which are used inernally by the WAREHOUSE class.
---Meaning that troops (cargo) will board, i.e. run or drive to the carrier, and only once they are in close proximity to the transporter they will be loaded (disappear).
---
---Unfortunately, there are some situations where problems can occur. For example, in DCS tanks have the strong tentendcy not to drive around obstacles but rather to roll over them.
---I have seen cases where an aircraft of the same coalition as the tank was in its way and the tank drove right through the plane waiting on a parking spot and destroying it.
---
---As a workaround it is possible to set a larger load radius so that the cargo units are despawned further away from the carrier via the optional **loadradius** parameter:
---
---    warehouseBatumi:AddAsset("Leopard 2", nil, nil, nil, nil, 250)
---
---Adding the asset like this will cause the units to be loaded into the carrier already at a distance of 250 meters.
---
---### Setting the AI Skill
---
---By default, the asset has the skill of its template group. The optional parameter *skill* allows to set a different skill when the asset is added. See the
---[hoggit page](https://wiki.hoggitworld.com/view/DCS_enum_AI) possible values of this enumerator.
---For example you can use
---
---    warehouseBatumi:AddAsset("Leopard 2", nil, nil, nil, nil, nil, AI.Skill.EXCELLENT)
---
---do set the skill of the asset to excellent.
---
---### Setting Liveries
---
---By default ,the asset uses the livery of its template group. The optional parameter *liveries* allows to define one or multiple liveries.
---If multiple liveries are given in form of a table of livery names, each asset gets a random one.
---
---For example
---
---    warehouseBatumi:AddAsset("Mi-8", nil, nil, nil, nil, nil, nil, "China UN")
---
---would spawn the asset with a Chinese UN livery.
---
---Or
---
---    warehouseBatumi:AddAsset("Mi-8", nil, nil, nil, nil, nil, nil, {"China UN", "German"})
---
---would spawn the asset with either a Chinese UN or German livery. Mind the curly brackets **{}** when you want to specify multiple liveries.
---
---Four each unit type, the livery names can be found in the DCS root folder under Bazar\Liveries. You have to use the name of the livery subdirectory. The names of the liveries
---as displayed in the mission editor might be different and won't work in general.
---
---### Setting an Assignment
---
---Assets can be added with a specific assignment given as a text, e.g.
---
---    warehouseBatumi:AddAsset("Mi-8", nil, nil, nil, nil, nil, nil, nil, "Go to Warehouse Kobuleti")
---
---This is helpful to establish supply chains once an asset has arrived at its (first) destination and is meant to be forwarded to another warehouse.
---
---## Retrieving the Asset
---
---Once a an asset is added to a warehouse, the #WAREHOUSE.NewAsset event is triggered. You can hook into this event with the #WAREHOUSE.OnAfterNewAsset(*asset*, *assignment*) function.
---
---The first parameter *asset* is a table of type #WAREHOUSE.Assetitem and contains a lot of information about the asset. The seconed parameter *assignment* is optional and is the specific
---assignment the asset got when it was added.
---
---Note that the assignment is can also be the assignment that was specified when adding a request (see next section). Once an asset that was requested from another warehouse and an assignment
---was specified in the #WAREHOUSE.AddRequest function, the assignment can be checked when the asset has arrived and is added to the receiving warehouse.
---
---===
---
---# Requesting Assets
---
---Assets of the warehouse can be requested by other MOOSE warehouses. A request will first be scrutinized to check if can be fulfilled at all. If the request is valid, it is
---put into the warehouse queue and processed as soon as possible.
---
---Requested assets spawn in various "Rule of Engagement Rules" (ROE) and Alerts modes. If your assets will cross into dangerous areas, be sure to change these states. You can do this in #WAREHOUSE:OnAfterAssetSpawned(*From, *Event, *To, *group, *asset, *request)) function.
---
---Initial Spawn states is as follows:
---   GROUND: ROE, "Return Fire" Alarm, "Green"
---   AIR:  ROE, "Return Fire" Reaction to Threat, "Passive Defense"
---   NAVAL ROE, "Return Fire" Alarm,"N/A"
---
---A request can be added by the #WAREHOUSE.AddRequest(*warehouse*, *AssetDescriptor*, *AssetDescriptorValue*, *nAsset*, *TransportType*, *nTransport*, *Prio*, *Assignment*) function.
---The parameters are
---
---* *warehouse*: The requesting MOOSE #WAREHOUSE. Assets will be delivered there.
---* *AssetDescriptor*: The descriptor to describe the asset "type". See the #WAREHOUSE.Descriptor enumerator. For example, assets requested by their generalized attibute.
---* *AssetDescriptorValue*: The value of the asset descriptor.
---* *nAsset*: (Optional) Number of asset group requested. Default is one group.
---* *TransportType*: (Optional) The transport method used to deliver the assets to the requestor. Default is that assets go to the requesting warehouse on their own.
---* *nTransport*: (Optional) Number of asset groups used to transport the cargo assets from A to B. Default is one group.
---* *Prio*: (Optional) A number between 1 (high) and 100 (low) describing the priority of the request. Request with high priority are processed first. Default is 50, i.e. medium priority.
---* *Assignment*: (Optional) A free to choose string describing the assignment. For self requests, this can be used to assign the spawned groups to specific tasks.
---
---## Requesting by Generalized Attribute
---
---Generalized attributes are similar to [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes). However, they are a bit more general and
---an asset can only have one generalized attribute by which it is characterized.
---
---For example:
---
---    warehouseBatumi:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 5, WAREHOUSE.TransportType.APC, 2)
---
---Here, warehouse Kobuleti requests 5 infantry groups from warehouse Batumi. These "cargo" assets should be transported from Batumi to Kobuleti by 2 APCS.
---Note that the warehouse at Batumi needs to have at least five infantry groups and two APC groups in their stock if the request can be processed.
---If either to few infantry or APC groups are available when the request is made, the request is held in the warehouse queue until enough cargo and
---transport assets are available.
---
---Also note that the above request is for five infantry groups. So any group in stock that has the generalized attribute "GROUND_INFANTRY" can be selected for the request.
---
---### Generalized Attributes
---
---Currently implemented are:
---
---* #WAREHOUSE.Attribute.AIR_TRANSPORTPLANE Airplane with transport capability. This can be used to transport other assets.
---* #WAREHOUSE.Attribute.AIR_AWACS Airborne Early Warning and Control System.
---* #WAREHOUSE.Attribute.AIR_FIGHTER Fighter, interceptor, ... airplane.
---* #WAREHOUSE.Attribute.AIR_BOMBER Aircraft which can be used for strategic bombing.
---* #WAREHOUSE.Attribute.AIR_TANKER Airplane which can refuel other aircraft.
---* #WAREHOUSE.Attribute.AIR_TRANSPORTHELO Helicopter with transport capability. This can be used to transport other assets.
---* #WAREHOUSE.Attribute.AIR_ATTACKHELO Attack helicopter.
---* #WAREHOUSE.Attribute.AIR_UAV Unpiloted Aerial Vehicle, e.g. drones.
---* #WAREHOUSE.Attribute.AIR_OTHER Any airborne unit that does not fall into any other airborne category.
---* #WAREHOUSE.Attribute.GROUND_APC Infantry carriers, in particular Amoured Personell Carrier. This can be used to transport other assets.
---* #WAREHOUSE.Attribute.GROUND_TRUCK Unarmed ground vehicles, which has the DCS "Truck" attribute.
---* #WAREHOUSE.Attribute.GROUND_INFANTRY Ground infantry assets.
---* #WAREHOUSE.Attribute.GROUND_IFV Ground infantry fighting vehicle.
---* #WAREHOUSE.Attribute.GROUND_ARTILLERY Artillery assets.
---* #WAREHOUSE.Attribute.GROUND_TANK Tanks (modern or old).
---* #WAREHOUSE.Attribute.GROUND_TRAIN Trains. Not that trains are **not** yet properly implemented in DCS and cannot be used currently.
---* #WAREHOUSE.Attribute.GROUND_EWR Early Warning Radar.
---* #WAREHOUSE.Attribute.GROUND_AAA Anti-Aircraft Artillery.
---* #WAREHOUSE.Attribute.GROUND_SAM Surface-to-Air Missile system or components.
---* #WAREHOUSE.Attribute.GROUND_OTHER Any ground unit that does not fall into any other ground category.
---* #WAREHOUSE.Attribute.NAVAL_AIRCRAFTCARRIER Aircraft carrier.
---* #WAREHOUSE.Attribute.NAVAL_WARSHIP War ship, i.e. cruisers, destroyers, firgates and corvettes.
---* #WAREHOUSE.Attribute.NAVAL_ARMEDSHIP Any armed ship that is not an aircraft carrier, a cruiser, destroyer, firgatte or corvette.
---* #WAREHOUSE.Attribute.NAVAL_UNARMEDSHIP Any unarmed naval vessel.
---* #WAREHOUSE.Attribute.NAVAL_OTHER Any naval unit that does not fall into any other naval category.
---* #WAREHOUSE.Attribute.OTHER_UNKNOWN Anything that does not fall into any other category.
---
---## Requesting a Specific Unit Type
---
---A more specific request could look like:
---
---    warehouseBatumi:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.UNITTYPE, "A-10C", 2)
---
---Here, Kobuleti requests a specific unit type, in particular two groups of A-10Cs. Note that the spelling is important as it must exacly be the same as
---what one get's when using the DCS unit type.
---
---## Requesting a Specific Group
---
---An even more specific request would be:
---
---    warehouseBatumi:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.GROUPNAME, "Group Name as in ME", 3)
---
---In this case three groups named "Group Name as in ME" are requested. This explicitly request the groups named like that in the Mission Editor.
---
---## Requesting a General Category
---
---On the other hand, very general and unspecifc requests can be made by the categroy descriptor. The descriptor value parameter can be any [group category](https://wiki.hoggitworld.com/view/DCS_Class_Group), i.e.
---
---* Group.Category.AIRPLANE for fixed wing aircraft,
---* Group.Category.HELICOPTER for helicopters,
---* Group.Category.GROUND for all ground troops,
---* Group.Category.SHIP for naval assets,
---* Group.Category.TRAIN for trains (not implemented and not working in DCS yet).
---
---For example,
---
---    warehouseBatumi:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.CATEGORY, Group.Category.GROUND, 10)
---
---means that Kubuleti requests 10 ground groups and does not care which ones. This could be a mix of infantry, APCs, trucks etc.
---
---**Note** that these general requests should be made with *great care* due to the fact, that depending on what a warehouse has in stock a lot of different unit types can be spawned.
---
---## Requesting Relative Quantities
---
---In addition to requesting absolute numbers of assets it is possible to request relative amounts of assets currently in stock. To this end the #WAREHOUSE.Quantity enumerator
---was introduced:
---
---* #WAREHOUSE.Quantity.ALL
---* #WAREHOUSE.Quantity.HALF
---* #WAREHOUSE.Quantity.QUARTER
---* #WAREHOUSE.Quantity.THIRD
---* #WAREHOUSE.Quantity.THREEQUARTERS
---
---For example,
---
---    warehouseBatumi:AddRequest(warehouseKobuleti, WAREHOUSE.Descriptor.CATEGORY, Group.Category.HELICOPTER, WAREHOUSE.Quantity.HALF)
---
---means that Kobuleti warehouse requests half of all available helicopters which Batumi warehouse currently has in stock.
---
---# Employing Assets - The Self Request
---
---Transferring assets from one warehouse to another is important but of course once the the assets are at the "right" place it is equally important that they
---can be employed for specific tasks and assignments.
---
---Assets in the warehouses stock can be used for user defined tasks quite easily. They can be spawned into the game by a "***self request***", i.e. the warehouse
---requests the assets from itself:
---
---    warehouseBatumi:AddRequest(warehouseBatumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 5)
---
---Note that the *sending* and *requesting* warehouses are *identical* in this case.
---
---This would simply spawn five infantry groups in the spawn zone of the Batumi warehouse if/when they are available.
---
---## Accessing the Assets
---
---If a warehouse requests assets from itself, it triggers the event **SelfReqeuest**. The mission designer can capture this event with the associated
---#WAREHOUSE.OnAfterSelfRequest(*From*, *Event*, *To*, *groupset*, *request*) function.
---
---    --- OnAfterSelfRequest user function. Access groups spawned from the warehouse for further tasking.
---    -- @param #WAREHOUSE self
---    -- @param #string From From state.
---    -- @param #string Event Event.
---    -- @param #string To To state.
---    -- @param Core.Set#SET_GROUP groupset The set of cargo groups that was delivered to the warehouse itself.
---    -- @param #WAREHOUSE.Pendingitem request Pending self request.
---    function WAREHOUSE:OnAfterSelfRequest(From, Event, To, groupset, request)
---      local groupset=groupset --Core.Set#SET_GROUP
---      local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      for _,group in pairs(groupset:GetSetObjects()) do
---        local group=group --Wrapper.Group#GROUP
---        group:SmokeGreen()
---      end
---
---    end
---
---The variable *groupset* is a Core.Set#SET_GROUP object and holds all asset groups from the request. The code above shows, how the mission designer can access the groups
---for further tasking. Here, the groups are only smoked but, of course, you can use them for whatever assignment you fancy.
---
---Note that airborne groups are spawned in **uncontrolled state** and need to be activated first before they can begin with their assigned tasks and missions.
---This can be done with the Wrapper.Controllable#CONTROLLABLE.StartUncontrolled function as demonstrated in the example section below.
---
---===
---
---# Infrastructure
---
---A good infrastructure is important for a warehouse to be efficient. Therefore, the location of a warehouse should be chosen with care.
---This can also help to avoid many DCS related issues such as units getting stuck in buildings, blocking taxi ways etc.
---
---## Spawn Zone
---
---By default, the zone were ground assets are spawned is a circular zone around the physical location of the warehouse with a radius of 200 meters. However, the location of the
---spawn zone can be set by the #WAREHOUSE.SetSpawnZone(*zone*) functions. It is advisable to choose a zone which is clear of obstacles.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Batumi.png)
---
---The parameter *zone* is a MOOSE Core.Zone#ZONE object. So one can, e.g., use trigger zones defined in the mission editor. If a cicular zone is not desired, one
---can use a polygon zone (see Core.Zone#ZONE_POLYGON).
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_SpawnPolygon.png)
---
---## Road Connections
---
---Ground assets will use a road connection to travel from one warehouse to another. Therefore, a proper road connection is necessary.
---
---By default, the closest point on road to the center of the spawn zone is chosen as road connection automatically. But only, if distance between the spawn zone
---and the road connection is less than 3 km.
---
---The user can set the road connection manually with the #WAREHOUSE.SetRoadConnection function. This is only functional for self propelled assets at the moment
---and not if using the AI dispatcher classes since these have a different logic to find the route.
---
---## Off Road Connections
---
---For ground troops it is also possible to define off road paths between warehouses if no proper road connection is available or should not be used.
---
---An off road path can be defined via the #WAREHOUSE.AddOffRoadPath(*remotewarehouse*, *group*, *oneway*) function, where
---*remotewarehouse* is the warehouse to which the path leads.
---The parameter *group* is a *late activated* template group. The waypoints of this group are used to define the path between the two warehouses.
---By default, the reverse paths is automatically added to get *from* the remote warehouse *to* this warehouse unless the parameter *oneway* is set to *true*.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Off-Road_Paths.png)
---
---**Note** that if an off road connection is defined between two warehouses this becomes the default path, i.e. even if there is a path *on road* possible
---this will not be used.
---
---Also note that you can define multiple off road connections between two warehouses. If there are multiple paths defined, the connection is chosen randomly.
---It is also possible to add the same path multiple times. By this you can influence the probability of the chosen path. For example Path1(A->B) has been
---added two times while Path2(A->B) was added only once. Hence, the group will choose Path1 with a probability of 66.6 % while Path2 is only chosen with
---a probability of 33.3 %.
---
---## Rail Connections
---
---A rail connection is automatically defined as the closest point on a railway measured from the center of the spawn zone. But only, if the distance is less than 3 km.
---
---The mission designer can manually specify a rail connection with the #WAREHOUSE.SetRailConnection function.
---
---**NOTE** however, that trains in DCS are currently not implemented in a way so that they can be used.
---
---## Air Connections
---
---In order to use airborne assets, a warehouse needs to have an associated airbase. This can be an airdrome, a FARP/HELOPAD or a ship.
---
---If there is an airbase within 3 km range of the warehouse it is automatically set as the associated airbase. A user can set an airbase manually
---with the #WAREHOUSE.SetAirbase function. Keep in mind that sometimes ground units need to walk/drive from the spawn zone to the airport
---to get to their transport carriers.
---
---## Naval Connections
---
---Natively, DCS does not have the concept of a port/habour or shipping lanes. So in order to have a meaningful transfer of naval units between warehouses, these have to be
---defined by the mission designer.
---
---### Defining a Port
---
---A port in this context is the zone where all naval assets are spawned. This zone can be defined with the function #WAREHOUSE.SetPortZone(*zone*), where the parameter
---*zone* is a MOOSE zone. So again, this can be create from a trigger zone defined in the mission editor or if a general shape is desired by a Core.Zone#ZONE_POLYGON.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_PortZone.png)
---
---### Defining Shipping Lanes
---
---A shipping lane between to warehouses can be defined by the #WAREHOUSE.AddShippingLane(*remotewarehouse*, *group*, *oneway*) function. The first parameter *remotewarehouse*
---is the warehouse which should be connected to the present warehouse.
---
---The parameter *group* should be a late activated group defined in the mission editor. The waypoints of this group are used as waypoints of the shipping lane.
---
---By default, the reverse lane is automatically added to the remote warehouse. This can be disabled by setting the *oneway* parameter to *true*.
---
---Similar to off road connections, you can also define multiple shipping lanes between two warehouse ports. If there are multiple lanes defined, one is chosen randomly.
---It is possible to add the same lane multiple times. By this you can influence the probability of the chosen lane. For example Lane_1(A->B) has been
---added two times while Lane_2(A->B) was added only once. Therefore, the ships will choose Lane_1 with a probability of 66.6 % while Path_2 is only chosen with
---a probability of 33.3 %.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_ShippingLane.png)
---
---===
---
---# Why is my request not processed?
---
---For each request, the warehouse class logic does a lot of consistency and validation checks under the hood.
---This helps to circumvent a lot of DCS issues and shortcomings. For example, it is checked that enough free
---parking spots at an airport are available *before* the assets are spawned.
---However, this also means that sometimes a request is deemed to be *invalid* in which case they are deleted
---from the queue or considered to be valid but cannot be executed at this very moment.
---
---## Invalid Requests
---
---Invalid request are requests which can **never** be processes because there is some logical or physical argument against it.
---(Or simply because that feature was not implemented (yet).)
---
---* All airborne assets need an associated airbase of any kind on the sending *and* receiving warehouse.
---* Airplanes need an airdrome at the sending and receiving warehouses.
---* Not enough parking spots of the right terminal type at the sending warehouse. This avoids planes spawning on runways or on top of each other.
---* No parking spots of the right terminal type at the receiving warehouse. This avoids DCS despawning planes on landing if they have no valid parking spot.
---* Ground assets need a road connection between both warehouses or an off-road path needs to be added manually.
---* Ground assets cannot be send directly to ships, i.e. warehouses on ships.
---* Naval units need a user defined shipping lane between both warehouses.
---* Warehouses need a user defined port zone to spawn naval assets.
---* The receiving warehouse is destroyed or stopped.
---* If transport by airplane, both warehouses must have and airdrome.
---* If transport by APC, both warehouses must have a road connection.
---* If transport by helicopter, the sending airbase must have an associated airbase (airdrome or FARP).
---
---All invalid requests are cancelled and **removed** from the warehouse queue!
---
---## Temporarily Unprocessable Requests
---
---Temporarily unprocessable requests are possible in principle, but cannot be processed at the given time the warehouse checks its queue.
---
---* No enough parking spaces are available for all requested assets but the airbase has enough parking spots in total so that this request is possible once other aircraft have taken off.
---* The requesting warehouse is not in state "Running" (could be paused, not yet started or under attack).
---* Not enough cargo assets available at this moment.
---* Not enough free parking spots for all cargo or transport airborne assets at the moment.
---* Not enough transport assets to carry all cargo assets.
---
---Temporarily unprocessable requests are held in the queue. If at some point in time, the situation changes so that these requests can be processed, they are executed.
---
---## Cargo Bay and Weight Limitations
---
---The transportation of cargo is handled by the AI\_Dispatcher classes. These take the cargo bay of a carrier and the weight of
---the cargo into account so that a carrier can only load a realistic amount of cargo.
---
---However, if troops are supposed to be transported between warehouses, there is one important limitations one has to keep in mind.
---This is that **cargo asset groups cannot be split** and divided into separate carrier units!
---
---For example, a TPz Fuchs has a cargo bay large enough to carry up to 10 soldiers at once, which is a realistic number.
---If a group consisting of more than ten soldiers needs to be transported, it cannot be loaded into the APC.
---Even if two APCs are available, which could in principle carry up to 20 soldiers, a group of, let's say 12 soldiers will not
---be split into a group of ten soldiers using the first APC and a group two soldiers using the second APC.
---
---In other words, **there must be at least one carrier unit available that has a cargo bay large enough to load the heaviest cargo group!**
---The warehouse logic will automatically search all available transport assets for a large enough carrier.
---But if none is available, the request will be queued until a suitable carrier becomes available.
---
---The only realistic solution in this case is to either provide a transport carrier with a larger cargo bay or to reduce the number of soldiers
---in the group.
---
---A better way would be to have two groups of max. 10 soldiers each and one TPz Fuchs for transport. In this case, the first group is
---loaded and transported to the receiving warehouse. Once this is done, the carrier will drive back and pick up the remaining
---group.
---
---As an artificial workaround one can manually set the cargo bay size to a larger value or alternatively reduce the weight of the cargo
---when adding the assets via the #WAREHOUSE.AddAsset function. This might even be unavoidable if, for example, a SAM group
---should be transported since SAM sites only work when all units are in the same group.
---
---## Processing Speed
---
---A warehouse has a limited speed to process requests. Each time the status of the warehouse is updated only one requests is processed.
---The time interval between status updates is 30 seconds by default and can be adjusted via the #WAREHOUSE.SetStatusUpdate(*interval*) function.
---However, the status is also updated on other occasions, e.g. when a new request was added.
---
---===
---
---# Strategic Considerations
---
---Due to the fact that a warehouse holds (or can hold) a lot of valuable assets, it makes a (potentially) juicy target for enemy attacks.
---There are several interesting situations, which can occur.
---
---## Capturing a Warehouses Airbase
---
---If a warehouse has an associated airbase, it can be captured by the enemy. In this case, the warehouse looses its ability so employ all airborne assets and is also cut-off
---from supply by airplanes. Supply of ground troops via helicopters is still possible, because they deliver the troops into the spawn zone.
---
---Technically, the capturing of the airbase is triggered by the DCS [S\_EVENT\_BASE\_CAPTURED](https://wiki.hoggitworld.com/view/DCS_event_base_captured) event.
---So the capturing takes place when only enemy ground units are in the airbase zone whilst no ground units of the present airbase owner are in that zone.
---
---The warehouse will also create an event **AirbaseCaptured**, which can be captured by the #WAREHOUSE.OnAfterAirbaseCaptured function. So the warehouse chief can react on
---this attack and for example deploy ground groups to re-capture its airbase.
---
---When an airbase is re-captured the event **AirbaseRecaptured** is triggered and can be captured by the #WAREHOUSE.OnAfterAirbaseRecaptured function.
---This can be used to put the defending assets back into the warehouse stock.
---
---## Capturing the Warehouse
---
---A warehouse can be captured by the enemy coalition. If enemy ground troops enter the warehouse zone the event **Attacked** is triggered which can be captured by the
---#WAREHOUSE.OnAfterAttacked event. By default the warehouse zone circular zone with a radius of 500 meters located at the center of the physical warehouse.
---The warehouse zone can be set via the #WAREHOUSE.SetWarehouseZone(*zone*) function. The parameter *zone* must also be a circular zone.
---
---The #WAREHOUSE.OnAfterAttacked function can be used by the mission designer to react to the enemy attack. For example by deploying some or all ground troops
---currently in stock to defend the warehouse. Note that the warehouse also has a self defence option which can be enabled by the #WAREHOUSE.SetAutoDefenceOn()
---function. In this case, the warehouse will automatically spawn all ground troops. If the spawn zone is further away from the warehouse zone, all mobile troops
---are routed to the warehouse zone. The self request which is triggered on an automatic defence has the assignment "AutoDefence". So you can use this to
---give orders to the groups that were spawned using the #WAREHOUSE.OnAfterSelfRequest function.
---
---If only ground troops of the enemy coalition are present in the warehouse zone, the warehouse and all its assets falls into the hands of the enemy.
---In this case the event **Captured** is triggered which can be captured by the #WAREHOUSE.OnAfterCaptured function.
---
---The warehouse turns to the capturing coalition, i.e. its physical representation, and all assets as well. In particular, all requests to the warehouse will
---spawn assets belonging to the new owner.
---
---If the enemy troops could be defeated, i.e. no more troops of the opposite coalition are in the warehouse zone, the event **Defeated** is triggered and
---the #WAREHOUSE.OnAfterDefeated function can be used to adapt to the new situation. For example putting back all spawned defender troops back into
---the warehouse stock. Note that if the automatic defence is enabled, all defenders are automatically put back into the warehouse on the **Defeated** event.
---
---## Destroying a Warehouse
---
---If an enemy destroy the physical warehouse structure, the warehouse will of course stop all its services. In principle, all assets contained in the warehouse are
---gone as well. So a warehouse should be properly defended.
---
---Upon destruction of the warehouse, the event **Destroyed** is triggered, which can be captured by the #WAREHOUSE.OnAfterDestroyed function.
---So the mission designer can intervene at this point and for example choose to spawn all or particular types of assets before the warehouse is gone for good.
---
---===
---
---# Hook in and Take Control
---
---The Finite State Machine implementation allows mission designers to hook into important events and add their own code.
---Most of these events have already been mentioned but here is the list at a glance:
---
---* "NotReadyYet" --> "Start" --> "Running" (Starting the warehouse)
---* "*" --> "Status" --> "*" (status updated in regular intervals)
---* "*" --> "AddAsset" --> "*" (adding a new asset to the warehouse stock)
---* "*" --> "NewAsset" --> "*" (a new asset has been added to the warehouse stock)
---* "*" --> "AddRequest" --> "*" (adding a request for the warehouse assets)
---* "Running" --> "Request" --> "*" (a request is processed when the warehouse is running)
---* "Attacked" --> "Request" --> "*" (a request is processed when the warehouse is attacked)
---* "*" --> "Arrived" --> "*" (asset group has arrived at its destination)
---* "*" --> "Delivered" --> "*" (all assets of a request have been delivered)
---* "Running" --> "SelfRequest" --> "*" (warehouse is requesting asset from itself when running)
---* "Attacked" --> "SelfRequest" --> "*" (warehouse is requesting asset from itself while under attack)
---* "*" --> "Attacked" --> "Attacked" (warehouse is being attacked)
---* "Attacked" --> "Defeated" --> "Running" (an attack was defeated)
---* "Attacked" --> "Captured" --> "Running" (warehouse was captured by the enemy)
---* "*" --> "AirbaseCaptured" --> "*" (airbase belonging to the warehouse was captured by the enemy)
---* "*" --> "AirbaseRecaptured" --> "*" (airbase was re-captured)
---* "*" --> "AssetSpawned" --> "*" (an asset has been spawned into the world)
---* "*" --> "AssetLowFuel" --> "*" (an asset is running low on fuel)
---* "*" --> "AssetDead" --> "*" (a whole asset, i.e. all its units/groups, is dead)
---* "*" --> "Destroyed" --> "Destroyed" (warehouse was destroyed)
---* "Running" --> "Pause" --> "Paused" (warehouse is paused)
---* "Paused" --> "Unpause" --> "Running" (warehouse is unpaused)
---* "*" --> "Stop" --> "Stopped" (warehouse is stopped)
---
---The transitions are of the general form "From State" --> "Event" --> "To State". The "*" star denotes that the transition is possible from *any* state.
---Some transitions, however, are only allowed from certain "From States". For example, no requests can be processed if the warehouse is in "Paused" or "Destroyed" or "Stopped" state.
---
---Mission designers can capture the events with OnAfterEvent functions, e.g. #WAREHOUSE.OnAfterDelivered or #WAREHOUSE.OnAfterAirbaseCaptured.
---
---===
---
---# Persistence of Assets
---
---Assets in stock of a warehouse can be saved to a file on your hard drive and then loaded from that file at a later point. This enables to restart the mission
---and restore the warehouse stock.
---
---## Prerequisites
---
---**Important** By default, DCS does not allow for writing data to files. Therefore, one first has to comment out the line "sanitizeModule('io')", i.e.
---
---    do
---      sanitizeModule('os')
---      --sanitizeModule('io')
---      sanitizeModule('lfs')
---      require = nil
---      loadlib = nil
---    end
---
---in the file "MissionScripting.lua", which is located in the subdirectory "Scripts" of your DCS installation root directory.
---
---### Don't!
---
---Do not use **semi-colons** or **equal signs** in the group names of your assets as these are used as separators in the saved and loaded files texts.
---If you do, it will cause problems and give you a headache!
---
---## Save Assets
---
---Saving asset data to file is achieved by the #WAREHOUSE.Save(*path*, *filename*) function. The parameter *path* specifies the path on the file system where the
---warehouse data is saved. If you do not specify a path, the file is saved your the DCS installation root directory.
---The parameter *filename* is optional and defines the name of the saved file. By default this is automatically created from the warehouse id and name, for example
---"Warehouse-1234_Batumi.txt".
---
---    warehouseBatumi:Save("D:\\My Warehouse Data\\")
---
---This will save all asset data to in "D:\\My Warehouse Data\\Warehouse-1234_Batumi.txt".
---
---### Automatic Save at Mission End
---
---The assets can be saved automatically when the mission is ended via the #WAREHOUSE.SetSaveOnMissionEnd(*path*, *filename*) function, i.e.
---
---    warehouseBatumi:SetSaveOnMissionEnd("D:\\My Warehouse Data\\")
---
---## Load Assets
---
---Loading assets data from file is achieved by the #WAREHOUSE.Load(*path*, *filename*) function. The parameter *path* specifies the path on the file system where the
---warehouse data is loaded from. If you do not specify a path, the file is loaded from your the DCS installation root directory.
---The parameter *filename* is optional and defines the name of the file to load. By default this is automatically generated from the warehouse id and name, for example
---"Warehouse-1234_Batumi.txt".
---
---Note that the warehouse **must not be started** and in the *Running* state in order to load the assets. In other words, loading should happen after the
---#WAREHOUSE.New command is specified in the code but before the #WAREHOUSE.Start command is given.
---
---Loading the assets is done by
---
---    warehouseBatumi:New(STATIC:FindByName("Warehouse Batumi"))
---    warehouseBatumi:Load("D:\\My Warehouse Data\\")
---    warehouseBatumi:Start()
---
---This sequence loads all assets from file. If a warehouse was captured in the last mission, it also respawns the static warehouse structure with the right coalition.
---However, it due to DCS limitations it is not possible to set the airbase coalition. This has to be done manually in the mission editor. Or alternatively, one could
---spawn some ground units via a self request and let them capture the airbase.
---
---===
---
---# Examples
---
---This section shows some examples how the WAREHOUSE class is used in practice. This is one of the best ways to explain things, in my opinion.
---
---But first, let me introduce a convenient way to define several warehouses in a table. This is absolutely *not necessary* but quite handy if you have
---multiple WAREHOUSE objects in your mission.
---
---## Example 0: Setting up a Warehouse Array
---
---If you have multiple warehouses, you can put them in a table. This makes it easier to access them or to loop over them.
---
---    -- Define Warehouses.
---    local warehouse={}
---    -- Blue warehouses
---    warehouse.Senaki   = WAREHOUSE:New(STATIC:FindByName("Warehouse Senaki"),   "Senaki")   --Functional.Warehouse#WAREHOUSE
---    warehouse.Batumi   = WAREHOUSE:New(STATIC:FindByName("Warehouse Batumi"),   "Batumi")   --Functional.Warehouse#WAREHOUSE
---    warehouse.Kobuleti = WAREHOUSE:New(STATIC:FindByName("Warehouse Kobuleti"), "Kobuleti") --Functional.Warehouse#WAREHOUSE
---    warehouse.Kutaisi  = WAREHOUSE:New(STATIC:FindByName("Warehouse Kutaisi"),  "Kutaisi")  --Functional.Warehouse#WAREHOUSE
---    warehouse.Berlin   = WAREHOUSE:New(STATIC:FindByName("Warehouse Berlin"),   "Berlin")   --Functional.Warehouse#WAREHOUSE
---    warehouse.London   = WAREHOUSE:New(STATIC:FindByName("Warehouse London"),   "London")   --Functional.Warehouse#WAREHOUSE
---    warehouse.Stennis  = WAREHOUSE:New(STATIC:FindByName("Warehouse Stennis"),  "Stennis")  --Functional.Warehouse#WAREHOUSE
---    warehouse.Pampa    = WAREHOUSE:New(STATIC:FindByName("Warehouse Pampa"),    "Pampa")    --Functional.Warehouse#WAREHOUSE
---    -- Red warehouses
---    warehouse.Sukhumi  = WAREHOUSE:New(STATIC:FindByName("Warehouse Sukhumi"),  "Sukhumi")  --Functional.Warehouse#WAREHOUSE
---    warehouse.Gudauta  = WAREHOUSE:New(STATIC:FindByName("Warehouse Gudauta"),  "Gudauta")  --Functional.Warehouse#WAREHOUSE
---    warehouse.Sochi    = WAREHOUSE:New(STATIC:FindByName("Warehouse Sochi"),    "Sochi")    --Functional.Warehouse#WAREHOUSE
---
---Remarks:
---
---* I defined the array as local, i.e. local warehouse={}. This is personal preference and sometimes causes trouble with the lua garbage collection. You can also define it as a global array/table!
---* The "--Functional.Warehouse#WAREHOUSE" at the end is only to have the LDT intellisense working correctly. If you don't use LDT (which you should!), it can be omitted.
---
---**NOTE** that all examples below need this bit or code at the beginning - or at least the warehouses which are used.
---
---The example mission is based on the same template mission, which has defined a lot of airborne, ground and naval assets as templates. Only few of those are used here.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Assets.png)
---
---## Example 1: Self Request
---
---Ground troops are taken from the Batumi warehouse stock and spawned in its spawn zone. After a short delay, they are added back to the warehouse stock.
---Also a new request is made. Hence, the groups will be spawned, added back to the warehouse, spawned again and so on and so forth...
---
---    -- Start warehouse Batumi.
---    warehouse.Batumi:Start()
---
---    -- Add five groups of infantry as assets.
---    warehouse.Batumi:AddAsset(GROUP:FindByName("Infantry Platoon Alpha"), 5)
---
---    -- Add self request for three infantry at Batumi.
---    warehouse.Batumi:AddRequest(warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 3)
---
---
---    --- Self request event. Triggered once the assets are spawned in the spawn zone or at the airbase.
---    function warehouse.Batumi:OnAfterSelfRequest(From, Event, To, groupset, request)
---      local mygroupset=groupset --Core.Set#SET_GROUP
---
---      -- Loop over all groups spawned from that request.
---      for _,group in pairs(mygroupset:GetSetObjects()) do
---        local group=group --Wrapper.Group#GROUP
---
---        -- Gree smoke on spawned group.
---        group:SmokeGreen()
---
---        -- Put asset back to stock after 10 seconds.
---        warehouse.Batumi:__AddAsset(10, group)
---      end
---
---      -- Add new self request after 20 seconds.
---      warehouse.Batumi:__AddRequest(20, warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 3)
---
---    end
---
---## Example 2: Self propelled Ground Troops
---
---Warehouse Berlin, which is a FARP near Batumi, requests infantry and troop transports from the warehouse at Batumi.
---The groups are spawned at Batumi and move by themselves from Batumi to Berlin using the roads.
---Once the troops have arrived at Berlin, the troops are automatically added to the warehouse stock of Berlin.
---While on the road, Batumi has requested back two APCs from Berlin. Since Berlin does not have the assets in stock,
---the request is queued. After the troops have arrived, Berlin is sending back the APCs to Batumi.
---
---    -- Start Warehouse at Batumi.
---    warehouse.Batumi:Start()
---
---    -- Add 20 infantry groups and ten APCs as assets at Batumi.
---    warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 20)
---    warehouse.Batumi:AddAsset("TPz Fuchs", 10)
---
---    -- Start Warehouse Berlin.
---    warehouse.Berlin:Start()
---
---    -- Warehouse Berlin requests 10 infantry groups and 5 APCs from warehouse Batumi.
---    warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 10)
---    warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_APC, 5)
---
---    -- Request from Batumi for 2 APCs. Initially these are not in stock. When they become available, the request is executed.
---    warehouse.Berlin:AddRequest(warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_APC, 2)
---
---## Example 3: Self Propelled Airborne Assets
---
---Warehouse Senaki receives a high priority request from Kutaisi for one Yak-52s. At the same time, Kobuleti requests half of
---all available Yak-52s. Request from Kutaisi is first executed and then Kobuleti gets half of the remaining assets.
---Additionally, London requests one third of all available UH-1H Hueys from Senaki.
---Once the units have arrived they are added to the stock of the receiving warehouses and can be used for further assignments.
---
---    -- Start warehouses
---    warehouse.Senaki:Start()
---    warehouse.Kutaisi:Start()
---    warehouse.Kobuleti:Start()
---    warehouse.London:Start()
---
---    -- Add assets to Senaki warehouse.
---    warehouse.Senaki:AddAsset("Yak-52", 10)
---    warehouse.Senaki:AddAsset("Huey", 6)
---
---    -- Kusaisi requests 3 Yak-52 form Senaki while Kobuleti wants all the rest.
---    warehouse.Senaki:AddRequest(warehouse.Kutaisi,  WAREHOUSE.Descriptor.GROUPNAME, "Yak-52", 1, nil, nil, 10)
---    warehouse.Senaki:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.GROUPNAME, "Yak-52", WAREHOUSE.Quantity.HALF,  nil, nil, 70)
---
---    -- FARP London wants 1/3 of the six available Hueys.
---    warehouse.Senaki:AddRequest(warehouse.London,  WAREHOUSE.Descriptor.GROUPNAME, "Huey", WAREHOUSE.Quantity.THIRD)
---
---## Example 4: Transport of Assets by APCs
---
---Warehouse at FARP Berlin requests five infantry groups from Batumi. These assets shall be transported using two APC groups.
---Infantry and APC are spawned in the spawn zone at Batumi. The APCs have a cargo bay large enough to pick up four of the
---five infantry groups in the first run and will bring them to Berlin. There, they unboard and walk to the warehouse where they will be added to the stock.
---Meanwhile the APCs go back to Batumi and one will pick up the last remaining soldiers.
---Once the APCs have completed their mission, they return to Batumi and are added back to stock.
---
---    -- Start Warehouse at Batumi.
---    warehouse.Batumi:Start()
---
---    -- Start Warehouse Berlin.
---    warehouse.Berlin:Start()
---
---    -- Add 20 infantry groups and five APCs as assets at Batumi.
---    warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 20)
---    warehouse.Batumi:AddAsset("TPz Fuchs", 5)
---
---    -- Warehouse Berlin requests 5 infantry groups from warehouse Batumi using 2 APCs for transport.
---    warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 5, WAREHOUSE.TransportType.APC, 2)
---
---## Example 5: Transport of Assets by Helicopters
---
--- Warehouse at FARP Berlin requests five infantry groups from Batumi. They shall be transported by all available transport helicopters.
--- Note that the UH-1H Huey in DCS is an attack and not a transport helo. So the warehouse logic would be default also
--- register it as an #WAREHOUSE.Attribute.AIR_ATTACKHELICOPTER. In order to use it as a transport we need to force
--- it to be added as transport helo.
--- Also note that even though all (here five) helos are requested, only two of them are employed because this number is sufficient to
--- transport all requested assets in one go.
---
---    -- Start Warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Berlin:Start()
---
---    -- Add 20 infantry groups as assets at Batumi.
---    warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 20)
---
---    -- Add five Hueys for transport. Note that a Huey in DCS is an attack and not a transport helo. So we force this attribute!
---    warehouse.Batumi:AddAsset("Huey", 5, WAREHOUSE.Attribute.AIR_TRANSPORTHELO)
---
---    -- Warehouse Berlin requests 5 infantry groups from warehouse Batumi using all available helos for transport.
---    warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 5, WAREHOUSE.TransportType.HELICOPTER, WAREHOUSE.Quantity.ALL)
---
---## Example 6: Transport of Assets by Airplanes
---
---Warehoues Kobuleti requests all (three) APCs from Batumi using one airplane for transport.
---The available C-130 is able to carry one APC at a time. So it has to commute three times between Batumi and Kobuleti to deliver all requested cargo assets.
---Once the cargo is delivered, the C-130 transport returns to Batumi and is added back to stock.
---
---    -- Start warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Kobuleti:Start()
---
---    -- Add assets to Batumi warehouse.
---    warehouse.Batumi:AddAsset("C-130", 1)
---    warehouse.Batumi:AddAsset("TPz Fuchs", 3)
---
---    warehouse.Batumi:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_APC, WAREHOUSE.Quantity.ALL, WAREHOUSE.TransportType.AIRPLANE)
---
---## Example 7: Capturing Airbase and Warehouse
---
---A red BMP has made it through our defence lines and drives towards our unprotected airbase at Senaki.
---Once the BMP captures the airbase (DCS [S\_EVENT\_BASE\_CAPTURED](https://wiki.hoggitworld.com/view/DCS_event_base_captured) is evaluated)
---the warehouse at Senaki lost its air infrastructure and it is not possible any more to spawn airborne units. All requests for airborne units are rejected and cancelled in this case.
---
---The red BMP then drives further to the warehouse. Once it enters the warehouse zone (500 m radius around the warehouse building), the warehouse is
---considered to be under attack. This triggers the event **Attacked**. The #WAREHOUSE.OnAfterAttacked function can be used to react to this situation.
---Here, we only broadcast a distress call and launch a flare. However, it would also be reasonable to spawn all or selected ground troops in order to defend
---the warehouse. Note, that the warehouse has a self defence option which can be activated via the #WAREHOUSE.SetAutoDefenceOn() function. If activated,
---*all* ground assets are automatically spawned and assigned to defend the warehouse. Once/if the attack is defeated, these assets go automatically back
---into the warehouse stock.
---
---If the red coalition manages to capture our warehouse, all assets go into their possession. Now red tries to steal three F/A-18 flights and send them to
---Sukhumi. These aircraft will be spawned and begin to taxi. However, ...
---
---A blue Bradley is in the area and will attempt to recapture the warehouse. It might also catch the red F/A-18s before they take off.
---
---    -- Start warehouses.
---    warehouse.Senaki:Start()
---    warehouse.Sukhumi:Start()
---
---    -- Add some assets.
---    warehouse.Senaki:AddAsset("TPz Fuchs", 5)
---    warehouse.Senaki:AddAsset("Infantry Platoon Alpha", 10)
---    warehouse.Senaki:AddAsset("F/A-18C 2ship", 10)
---
---    -- Enable auto defence, i.e. spawn all group troups into the spawn zone.
---    --warehouse.Senaki:SetAutoDefenceOn()
---
---    -- Activate Red BMP trying to capture the airfield and the warehouse.
---    local red1=GROUP:FindByName("Red BMP-80 Senaki"):Activate()
---
---    -- The red BMP first drives to the airbase which gets captured and changes from blue to red.
---    -- This triggers the "AirbaseCaptured" event where you can hook in and do things.
---    function warehouse.Senaki:OnAfterAirbaseCaptured(From, Event, To, Coalition)
---      -- This request cannot be processed since the warehouse has lost its airbase. In fact it is deleted from the queue.
---      warehouse.Senaki:AddRequest(warehouse.Senaki,WAREHOUSE.Descriptor.CATEGORY, Group.Category.AIRPLANE, 1)
---    end
---
---    -- Now the red BMP also captures the warehouse. This triggers the "Captured" event where you can hook in.
---    -- So now the warehouse and the airbase are both red and aircraft can be spawned again.
---    function warehouse.Senaki:OnAfterCaptured(From, Event, To, Coalition, Country)
---      -- These units will be spawned as red units because the warehouse has just been captured.
---      if Coalition==coalition.side.RED then
---        -- Sukhumi tries to "steals" three F/A-18 from Senaki and brings them to Sukhumi.
---        -- Well, actually the aircraft wont make it because blue1 will kill it on the taxi way leaving a blood bath. But that's life!
---        warehouse.Senaki:AddRequest(warehouse.Sukhumi, WAREHOUSE.Descriptor.CATEGORY, Group.Category.AIRPLANE, 3)
---        warehouse.Senaki.warehouse:SmokeRed()
---      elseif Coalition==coalition.side.BLUE then
---        warehouse.Senaki.warehouse:SmokeBlue()
---      end
---
---      -- Activate a blue vehicle to re-capture the warehouse. It will drive to the warehouse zone and kill the red intruder.
---      local blue1=GROUP:FindByName("blue1"):Activate()
---    end
---
---## Example 8: Destroying a Warehouse
---
---FARP Berlin requests a Huey from Batumi warehouse. This helo is deployed and will be delivered.
---After 30 seconds into the mission we create and (artificial) big explosion - or a terrorist attack if you like - which completely destroys the
---the warehouse at Batumi. All assets are gone and requests cannot be processed anymore.
---
---    -- Start Batumi and Berlin warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Berlin:Start()
---
---    -- Add some assets.
---    warehouse.Batumi:AddAsset("Huey", 5, WAREHOUSE.Attribute.AIR_TRANSPORTHELO)
---    warehouse.Berlin:AddAsset("Huey", 5, WAREHOUSE.Attribute.AIR_TRANSPORTHELO)
---
---    -- Big explosion at the warehose. It has a very nice damage model by the way :)
---    local function DestroyWarehouse()
---      warehouse.Batumi:GetCoordinate():Explosion(999)
---    end
---    SCHEDULER:New(nil, DestroyWarehouse, {}, 30)
---
---    -- First request is okay since warehouse is still alive.
---    warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.AIR_TRANSPORTHELO, 1)
---
---    -- These requests should both not be processed any more since the warehouse at Batumi is destroyed.
---    warehouse.Batumi:__AddRequest(35, warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.AIR_TRANSPORTHELO, 1)
---    warehouse.Berlin:__AddRequest(40, warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.AIR_TRANSPORTHELO, 1)
---
---## Example 9: Self Propelled Naval Assets
---
---Kobuleti requests all naval assets from Batumi.
---However, before naval assets can be exchanged, both warehouses need a port and at least one shipping lane defined by the user.
---See the #WAREHOUSE.SetPortZone() and #WAREHOUSE.AddShippingLane() functions.
---We do not want to spawn them all at once, because this will probably be a disaster
---in the port zone. Therefore, each ship is spawned with a delay of five minutes.
---
---Batumi has quite a selection of different ships (for testing).
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Naval_Assets.png)
---
---    -- Start warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Kobuleti:Start()
---
---    -- Define ports. These are polygon zones created by the waypoints of late activated units.
---    warehouse.Batumi:SetPortZone(ZONE_POLYGON:NewFromGroupName("Warehouse Batumi Port Zone", "Warehouse Batumi Port Zone"))
---    warehouse.Kobuleti:SetPortZone(ZONE_POLYGON:NewFromGroupName("Warehouse Kobuleti Port Zone", "Warehouse Kobuleti Port Zone"))
---
---    -- Shipping lane. Again, the waypoints of late activated units are taken as points defining the shipping lane.
---    -- Some units will take lane 1 while others will take lane two. But both lead from Batumi to Kobuleti port.
---    warehouse.Batumi:AddShippingLane(warehouse.Kobuleti, GROUP:FindByName("Warehouse Batumi-Kobuleti Shipping Lane 1"))
---    warehouse.Batumi:AddShippingLane(warehouse.Kobuleti, GROUP:FindByName("Warehouse Batumi-Kobuleti Shipping Lane 2"))
---
---    -- Large selection of available naval units in DCS.
---    warehouse.Batumi:AddAsset("Speedboat")
---    warehouse.Batumi:AddAsset("Perry")
---    warehouse.Batumi:AddAsset("Normandy")
---    warehouse.Batumi:AddAsset("Stennis")
---    warehouse.Batumi:AddAsset("Carl Vinson")
---    warehouse.Batumi:AddAsset("Tarawa")
---    warehouse.Batumi:AddAsset("SSK 877")
---    warehouse.Batumi:AddAsset("SSK 641B")
---    warehouse.Batumi:AddAsset("Grisha")
---    warehouse.Batumi:AddAsset("Molniya")
---    warehouse.Batumi:AddAsset("Neustrashimy")
---    warehouse.Batumi:AddAsset("Rezky")
---    warehouse.Batumi:AddAsset("Moskva")
---    warehouse.Batumi:AddAsset("Pyotr Velikiy")
---    warehouse.Batumi:AddAsset("Kuznetsov")
---    warehouse.Batumi:AddAsset("Zvezdny")
---    warehouse.Batumi:AddAsset("Yakushev")
---    warehouse.Batumi:AddAsset("Elnya")
---    warehouse.Batumi:AddAsset("Ivanov")
---    warehouse.Batumi:AddAsset("Yantai")
---    warehouse.Batumi:AddAsset("Type 052C")
---    warehouse.Batumi:AddAsset("Guangzhou")
---
---    -- Get Number of ships at Batumi.
---    local nships=warehouse.Batumi:GetNumberOfAssets(WAREHOUSE.Descriptor.CATEGORY, Group.Category.SHIP)
---
---    -- Send one ship every 3 minutes (ships do not evade each other well, so we need a bit space between them).
---    for i=1, nships do
---      warehouse.Batumi:__AddRequest(180*(i-1)+10, warehouse.Kobuleti, WAREHOUSE.Descriptor.CATEGORY, Group.Category.SHIP, 1)
---    end
---
---## Example 10: Warehouse on Aircraft Carrier
---
---This example shows how to spawn assets from a warehouse located on an aircraft carrier. The warehouse must still be represented by a
---physical static object. However, on a carrier space is limit so we take a smaller static. In priciple one could also take something
---like a windsock.
---
---![Banner Image](..\Presentations\WAREHOUSE\Warehouse_Carrier.png)
---
---USS Stennis requests F/A-18s from Batumi. At the same time Kobuleti requests F/A-18s from the Stennis which currently does not have any.
---So first, Batumi delivers the fighters to the Stennis. After they arrived they are deployed again and send to Kobuleti.
---
---    -- Start warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Stennis:Start()
---    warehouse.Kobuleti:Start()
---
---    -- Add F/A-18 2-ship flight to Batmi.
---    warehouse.Batumi:AddAsset("F/A-18C 2ship", 1)
---
---    -- USS Stennis requests F/A-18 from Batumi.
---    warehouse.Batumi:AddRequest(warehouse.Stennis, WAREHOUSE.Descriptor.GROUPNAME, "F/A-18C 2ship")
---
---    -- Kobuleti requests F/A-18 from USS Stennis.
---    warehouse.Stennis:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.GROUPNAME, "F/A-18C 2ship")
---
---## Example 11: Aircraft Carrier - Rescue Helo and Escort
---
---After 10 seconds we make a self request for a rescue helicopter. Note, that the #WAREHOUSE.AddRequest function has a parameter which lets you
---specify an "Assignment". This can be later used to identify the request and take the right actions.
---
---Once the request is processed, the #WAREHOUSE.OnAfterSelfRequest function is called. This is where we hook in and postprocess the spawned assets.
---In particular, we use the AI.AI_Formation#AI_FORMATION class to make some nice escorts for our carrier.
---
---When the resue helo is spawned, we can check that this is the correct asset and make the helo go into formation with the carrier.
---Once the helo runs out of fuel, it will automatically return to the ship and land. For the warehouse, this means that the "cargo", i.e. the helicopter
---has been delivered - assets can be delivered to other warehouses and to the same warehouse - hence a *self* request.
---When that happens, the **Delivered** event is triggered and the #WAREHOUSE.OnAfterDelivered function called. This can now be used to spawn
---a fresh helo. Effectively, there we created an infinite, never ending loop. So a rescue helo will be up at all times.
---
---After 30 and 45 seconds requests for five groups of armed speedboats are made. These will be spawned in the port zone right behind the carrier.
---The first five groups will go port of the carrier an form a left wing formation. The seconds groups will to the analogue on the starboard side.
---**Note** that in order to spawn naval assets a warehouse needs a port (zone). Since the carrier and hence the warehouse is mobile, we define a moving
---zone as Core.Zone#ZONE_UNIT with the carrier as reference unit. The "port" of the Stennis at its stern so all naval assets are spawned behind the carrier.
---
---    -- Start warehouse on USS Stennis.
---    warehouse.Stennis:Start()
---
---    -- Aircraft carrier gets a moving zone right behind it as port.
---    warehouse.Stennis:SetPortZone(ZONE_UNIT:New("Warehouse Stennis Port Zone", UNIT:FindByName("USS Stennis"), 100, {rho=250, theta=180, relative_to_unit=true}))
---
---    -- Add speedboat assets.
---    warehouse.Stennis:AddAsset("Speedboat", 10)
---    warehouse.Stennis:AddAsset("CH-53E", 1)
---
---    -- Self request of speed boats.
---    warehouse.Stennis:__AddRequest(10, warehouse.Stennis, WAREHOUSE.Descriptor.GROUPNAME, "CH-53E", 1, nil, nil, nil, "Rescue Helo")
---    warehouse.Stennis:__AddRequest(30, warehouse.Stennis, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.NAVAL_ARMEDSHIP, 5, nil, nil, nil, "Speedboats Left")
---    warehouse.Stennis:__AddRequest(45, warehouse.Stennis, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.NAVAL_ARMEDSHIP, 5, nil, nil, nil, "Speedboats Right")
---
---    --- Function called after self request
---    function warehouse.Stennis:OnAfterSelfRequest(From, Event, To,_groupset, request)
---      local groupset=_groupset --Core.Set#SET_GROUP
---      local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      -- USS Stennis is the mother ship.
---      local Mother=UNIT:FindByName("USS Stennis")
---
---      -- Get assignment of the request.
---      local assignment=warehouse.Stennis:GetAssignment(request)
---
---      if assignment=="Speedboats Left" then
---
---        -- Define AI Formation object.
---        -- Note that this has to be a global variable or the garbage collector will remove it for some reason!
---        CarrierFormationLeft = AI_FORMATION:New(Mother, groupset, "Left Formation with Carrier", "Escort Carrier.")
---
---        -- Formation parameters.
---        CarrierFormationLeft:FormationLeftWing(200 ,50, 0, 0, 500, 50)
---        CarrierFormationLeft:__Start(2)
---
---        for _,group in pairs(groupset:GetSetObjects()) do
---          local group=group --Wrapper.Group#GROUP
---          group:FlareRed()
---        end
---
---      elseif assignment=="Speedboats Right" then
---
---        -- Define AI Formation object.
---        -- Note that this has to be a global variable or the garbage collector will remove it for some reason!
---        CarrierFormationRight = AI_FORMATION:New(Mother, groupset, "Right Formation with Carrier", "Escort Carrier.")
---
---        -- Formation parameters.
---        CarrierFormationRight:FormationRightWing(200 ,50, 0, 0, 500, 50)
---        CarrierFormationRight:__Start(2)
---
---        for _,group in pairs(groupset:GetSetObjects()) do
---          local group=group --Wrapper.Group#GROUP
---          group:FlareGreen()
---        end
---
---      elseif assignment=="Rescue Helo" then
---
---        -- Start uncontrolled helo.
---        local group=groupset:GetFirst() --Wrapper.Group#GROUP
---        group:StartUncontrolled()
---
---        -- Define AI Formation object.
---        CarrierFormationHelo = AI_FORMATION:New(Mother, groupset, "Helo Formation with Carrier", "Fly Formation.")
---
---        -- Formation parameters.
---        CarrierFormationHelo:FormationCenterWing(-150, 50, 20, 50, 100, 50)
---        CarrierFormationHelo:__Start(2)
---
---      end
---
---      --- When the helo is out of fuel, it will return to the carrier and should be delivered.
---      function warehouse.Stennis:OnAfterDelivered(From,Event,To,request)
---        local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---        -- So we start another request.
---        if request.assignment=="Rescue Helo" then
---          warehouse.Stennis:__AddRequest(10, warehouse.Stennis, WAREHOUSE.Descriptor.GROUPNAME, "CH-53E", 1, nil, nil, nil, "Rescue Helo")
---        end
---      end
---
---    end
---
---## Example 12: Pause a Warehouse
---
---This example shows how to pause and unpause a warehouse. In paused state, requests will not be processed but assets can be added and requests be added.
---
---   * Warehouse Batumi is paused after 10 seconds.
---   * Request from Berlin after 15 which will not be processed.
---   * New tank assets for Batumi after 20 seconds. This is possible also in paused state.
---   * Batumi unpaused after 30 seconds. Queued request from Berlin can be processed.
---   * Berlin is paused after 60 seconds.
---   * Berlin requests tanks from Batumi after 90 seconds. Request is not processed because Berlin is paused and not running.
---   * Berlin is unpaused after 120 seconds. Queued request for tanks from Batumi can not be processed.
---
---Here is the code:
---
---    -- Start Warehouse at Batumi.
---    warehouse.Batumi:Start()
---
---    -- Start Warehouse Berlin.
---    warehouse.Berlin:Start()
---
---    -- Add 20 infantry groups and 5 tank platoons as assets at Batumi.
---    warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 20)
---
---    -- Pause the warehouse after 10 seconds
---    warehouse.Batumi:__Pause(10)
---
---    -- Add a request from Berlin after 15 seconds. A request can be added but not be processed while warehouse is paused.
---    warehouse.Batumi:__AddRequest(15, warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 1)
---
---    -- New asset added after 20 seconds. This is possible even if the warehouse is paused.
---    warehouse.Batumi:__AddAsset(20, "Abrams", 5)
---
---    -- Unpause warehouse after 30 seconds. Now the request from Berlin can be processed.
---    warehouse.Batumi:__Unpause(30)
---
---    -- Pause warehouse Berlin
---    warehouse.Berlin:__Pause(60)
---
---    -- After 90 seconds request from Berlin for tanks.
---    warehouse.Batumi:__AddRequest(90, warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_TANK, 1)
---
---    -- After 120 seconds unpause Berlin.
---    warehouse.Berlin:__Unpause(120)
---
---## Example 13: Battlefield Air Interdiction
---
---This example show how to couple the WAREHOUSE class with the AI.AI_BAI class.
---Four enemy targets have been located at the famous Kobuleti X. All three available Viggen 2-ship flights are assigned to kill at least one of the BMPs to complete their mission.
---
---    -- Start Warehouse at Kobuleti.
---    warehouse.Kobuleti:Start()
---
---    -- Add three 2-ship groups of Viggens.
---    warehouse.Kobuleti:AddAsset("Viggen 2ship", 3)
---
---    -- Self request for all Viggen assets.
---    warehouse.Kobuleti:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.GROUPNAME, "Viggen 2ship", WAREHOUSE.Quantity.ALL, nil, nil, nil, "BAI")
---
---    -- Red targets at Kobuleti X (late activated).
---    local RedTargets=GROUP:FindByName("Red IVF Alpha")
---
---    -- Activate the targets.
---    RedTargets:Activate()
---
---    -- Do something with the spawned aircraft.
---    function warehouse.Kobuleti:OnAfterSelfRequest(From,Event,To,groupset,request)
---      local groupset=groupset --Core.Set#SET_GROUP
---      local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      if request.assignment=="BAI" then
---
---        for _,group in pairs(groupset:GetSetObjects()) do
---          local group=group --Wrapper.Group#GROUP
---
---          -- Start uncontrolled aircraft.
---          group:StartUncontrolled()
---
---          local BAI=AI_BAI_ZONE:New(ZONE:New("Patrol Zone Kobuleti"), 500, 1000, 500, 600, ZONE:New("Patrol Zone Kobuleti"))
---
---          -- Tell the program to use the object (in this case called BAIPlane) as the group to use in the BAI function
---          BAI:SetControllable(group)
---
---          -- Function checking if targets are still alive
---          local function CheckTargets()
---            local nTargets=RedTargets:GetSize()
---            local nInitial=RedTargets:GetInitialSize()
---            local nDead=nInitial-nTargets
---            local nRequired=1  -- Let's make this easy.
---            if RedTargets:IsAlive() and nDead < nRequired then
---              MESSAGE:New(string.format("BAI Mission: %d of %d red targets still alive. At least %d targets need to be eliminated.", nTargets, nInitial, nRequired), 5):ToAll()
---            else
---              MESSAGE:New("BAI Mission: The required red targets are destroyed.", 30):ToAll()
---              BAI:__Accomplish(1) -- Now they should fly back to the patrolzone and patrol.
---            end
---          end
---
---          -- Start scheduler to monitor number of targets.
---          local Check, CheckScheduleID = SCHEDULER:New(nil, CheckTargets, {}, 60, 60)
---
---          -- When the targets in the zone are destroyed, (see scheduled function), the planes will return home ...
---          function BAI:OnAfterAccomplish( Controllable, From, Event, To )
---            MESSAGE:New( "BAI Mission: Sending the Viggens back to base.", 30):ToAll()
---            Check:Stop(CheckScheduleID)
---            BAI:__RTB(1)
---          end
---
---          -- Start BAI
---          BAI:Start()
---
---          -- Engage after 5 minutes.
---          BAI:__Engage(300)
---
---          -- RTB after 30 min max.
---          BAI:__RTB(-30*60)
---
---        end
---      end
---
---    end
---
---## Example 14: Strategic Bombing
---
---This example shows how to employ strategic bombers in a mission. Three B-52s are launched at Kobuleti with the assignment to wipe out the enemy warehouse at Sukhumi.
---The bombers will get a flight path and make their approach from the South at an altitude of 5000 m ASL. After their bombing run, they will return to Kobuleti and
---added back to stock.
---
---    -- Start warehouses
---    warehouse.Kobuleti:Start()
---    warehouse.Sukhumi:Start()
---
---    -- Add a strategic bomber assets
---    warehouse.Kobuleti:AddAsset("B-52H", 3)
---
---    -- Request bombers for specific task of bombing Sukhumi warehouse.
---    warehouse.Kobuleti:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.AIR_BOMBER, WAREHOUSE.Quantity.ALL, nil, nil, nil, "Bomb Sukhumi")
---
---    -- Specify assignment after bombers have been spawned.
---    function warehouse.Kobuleti:OnAfterSelfRequest(From, Event, To, groupset, request)
---      local groupset=groupset --Core.Set#SET_GROUP
---
---      -- Get assignment of this request.
---      local assignment=warehouse.Kobuleti:GetAssignment(request)
---
---      if assignment=="Bomb Sukhumi" then
---
---        for _,_group in pairs(groupset:GetSet()) do
---          local group=_group --Wrapper.Group#GROUP
---
---          -- Start uncontrolled aircraft.
---          group:StartUncontrolled()
---
---          -- Target coordinate!
---          local ToCoord=warehouse.Sukhumi:GetCoordinate():SetAltitude(5000)
---
---          -- Home coordinate.
---          local HomeCoord=warehouse.Kobuleti:GetCoordinate():SetAltitude(3000)
---
---          -- Task bomb Sukhumi warehouse using all bombs (2032) from direction 180 at altitude 5000 m.
---          local task=group:TaskBombing(warehouse.Sukhumi:GetCoordinate():GetVec2(), false, "All", nil , 180, 5000, 2032)
---
---          -- Define waypoints.
---          local WayPoints={}
---
---          -- Take off position.
---          WayPoints[1]=warehouse.Kobuleti:GetCoordinate():WaypointAirTakeOffParking()
---          -- Begin bombing run 20 km south of target.
---          WayPoints[2]=ToCoord:Translate(20*1000, 180):WaypointAirTurningPoint(nil, 600, {task}, "Bombing Run")
---          -- Return to base.
---          WayPoints[3]=HomeCoord:WaypointAirTurningPoint()
---          -- Land at homebase. Bombers are added back to stock and can be employed in later assignments.
---          WayPoints[4]=warehouse.Kobuleti:GetCoordinate():WaypointAirLanding()
---
---          -- Route bombers.
---          group:Route(WayPoints)
---        end
---
---      end
---    end
---
---## Example 15: Defining Off-Road Paths
---
---For self propelled assets it is possible to define custom off-road paths from one warehouse to another via the #WAREHOUSE.AddOffRoadPath function.
---The waypoints of a path are taken from late activated units. In this example, two paths have been defined between the warehouses Kobuleti and FARP London.
---Trucks are spawned at each warehouse and are guided along the paths to the other warehouse.
---Note that if more than one path was defined, each asset group will randomly select its route.
---
---    -- Start warehouses
---    warehouse.Kobuleti:Start()
---    warehouse.London:Start()
---
---    -- Define a polygon zone as spawn zone at Kobuleti.
---    warehouse.Kobuleti:SetSpawnZone(ZONE_POLYGON:New("Warehouse Kobuleti Spawn Zone", GROUP:FindByName("Warehouse Kobuleti Spawn Zone")))
---
---    -- Add assets.
---    warehouse.Kobuleti:AddAsset("M978", 20)
---    warehouse.London:AddAsset("M818", 20)
---
---    -- Off two road paths from Kobuleti to London. The reverse path from London to Kobuleti is added automatically.
---    warehouse.Kobuleti:AddOffRoadPath(warehouse.London, GROUP:FindByName("Warehouse Kobuleti-London OffRoad Path 1"))
---    warehouse.Kobuleti:AddOffRoadPath(warehouse.London, GROUP:FindByName("Warehouse Kobuleti-London OffRoad Path 2"))
---
---    -- London requests all available trucks from Kobuleti.
---    warehouse.Kobuleti:AddRequest(warehouse.London, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_TRUCK, WAREHOUSE.Quantity.ALL)
---
---    -- Kobuleti requests all available trucks from London.
---    warehouse.London:AddRequest(warehouse.Kobuleti, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_TRUCK, WAREHOUSE.Quantity.HALF)
---
---## Example 16: Resupply of Dead Assets
---
---Warehouse at FARP Berlin is located at the front line and sends infantry groups to the battle zone.
---Whenever a group dies, a new group is send from the warehouse to the battle zone.
---Additionally, for each dead group, Berlin requests resupply from Batumi.
---
---    -- Start warehouses.
---    warehouse.Batumi:Start()
---    warehouse.Berlin:Start()
---
---    -- Front line warehouse.
---    warehouse.Berlin:AddAsset("Infantry Platoon Alpha", 6)
---
---    -- Resupply warehouse.
---    warehouse.Batumi:AddAsset("Infantry Platoon Alpha", 50)
---
---    -- Battle zone near FARP Berlin. This is where the action is!
---    local BattleZone=ZONE:New("Virtual Battle Zone")
---
---    -- Send infantry groups to the battle zone. Two groups every ~60 seconds.
---    for i=1,2 do
---      local time=(i-1)*60+10
---      warehouse.Berlin:__AddRequest(time, warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 2, nil, nil, nil, "To Battle Zone")
---    end
---
---    -- Take care of the spawned units.
---    function warehouse.Berlin:OnAfterSelfRequest(From,Event,To,groupset,request)
---      local groupset=groupset --Core.Set#SET_GROUP
---      local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      -- Get assignment of this request.
---      local assignment=warehouse.Berlin:GetAssignment(request)
---
---      if assignment=="To Battle Zone" then
---
---        for _,group in pairs(groupset:GetSet()) do
---          local group=group --Wrapper.Group#GROUP
---
---          -- Route group to Battle zone.
---          local ToCoord=BattleZone:GetRandomCoordinate()
---          group:RouteGroundOnRoad(ToCoord, group:GetSpeedMax()*0.8)
---
---          -- After 3-5 minutes we create an explosion to destroy the group.
---          SCHEDULER:New(nil, Explosion, {group, 50}, math.random(180, 300))
---        end
---
---      end
---
---    end
---
---    -- An asset has died ==> request resupply for it.
---    function warehouse.Berlin:OnAfterAssetDead(From, Event, To, asset, request)
---      local asset=asset       --Functional.Warehouse#WAREHOUSE.Assetitem
---      local request=request   --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      -- Get assignment.
---      local assignment=warehouse.Berlin:GetAssignment(request)
---
---      -- Request resupply for dead asset from Batumi.
---      warehouse.Batumi:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, asset.attribute, nil, nil, nil, nil, "Resupply")
---
---      -- Send asset to Battle zone either now or when they arrive.
---      warehouse.Berlin:AddRequest(warehouse.Berlin, WAREHOUSE.Descriptor.ATTRIBUTE, asset.attribute, 1, nil, nil, nil, assignment)
---    end
---
---## Example 17: Supply Chains
---
---Our remote warehouse "Pampa" south of Batumi needs assets but does not have any air infrastructure (FARP or airdrome).
---Leopard 2 tanks are transported from Kobuleti to Batumi using two C-17As. From there they go be themselfs to Pampa.
---Eight infantry groups and two mortar groups are also being transferred from Kobuleti to Batumi by helicopter.
---The infantry has a higher priority and will be transported first using all available Mi-8 helicopters.
---Once infantry has arrived at Batumi, it will walk by itself to warehouse Pampa.
---The mortars can only be transported once the Mi-8 helos are available again, i.e. when the infantry has been delivered.
---Once the mortars arrive at Batumi, they will be transported by APCs to Pampa.
---
---    -- Start warehouses.
---    warehouse.Kobuleti:Start()
---    warehouse.Batumi:Start()
---    warehouse.Pampa:Start()
---
---    -- Add assets to Kobuleti warehouse, which is our main hub.
---    warehouse.Kobuleti:AddAsset("C-130",  2)
---    warehouse.Kobuleti:AddAsset("C-17A",  2, nil, 77000)
---    warehouse.Kobuleti:AddAsset("Mi-8",  2, WAREHOUSE.Attribute.AIR_TRANSPORTHELO, nil, nil, nil, AI.Skill.EXCELLENT, {"Germany", "United Kingdom"})
---    warehouse.Kobuleti:AddAsset("Leopard 2", 10, nil, nil, 62000, 500)
---    warehouse.Kobuleti:AddAsset("Mortar Alpha", 10, nil, nil, 210)
---    warehouse.Kobuleti:AddAsset("Infantry Platoon Alpha", 20)
---
---    -- Transports at Batumi.
---    warehouse.Batumi:AddAsset("SPz Marder", 2)
---    warehouse.Batumi:AddAsset("TPz Fuchs", 2)
---
---    -- Tanks transported by plane from from Kobuleti to Batumi.
---    warehouse.Kobuleti:AddRequest(warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_TANK, 2, WAREHOUSE.TransportType.AIRPLANE, 2, 10, "Assets for Pampa")
---    -- Artillery transported by helicopter from Kobuleti to Batumi.
---    warehouse.Kobuleti:AddRequest(warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_ARTILLERY, 2, WAREHOUSE.TransportType.HELICOPTER, 2, 30, "Assets for Pampa via APC")
---    -- Infantry transported by helicopter from Kobuleti to Batumi.
---    warehouse.Kobuleti:AddRequest(warehouse.Batumi, WAREHOUSE.Descriptor.ATTRIBUTE, WAREHOUSE.Attribute.GROUND_INFANTRY, 8, WAREHOUSE.TransportType.HELICOPTER, 2, 20, "Assets for Pampa")
---
---    --- Function handling assets delivered from Kobuleti warehouse.
---    function warehouse.Kobuleti:OnAfterDelivered(From, Event, To, request)
---      local request=request --Functional.Warehouse#WAREHOUSE.Pendingitem
---
---      -- Get assignment.
---      local assignment=warehouse.Kobuleti:GetAssignment(request)
---
---      -- Check if these assets were meant for Warehouse Pampa.
---      if assignment=="Assets for Pampa via APC" then
---        -- Forward everything that arrived at Batumi to Pampa via APC.
---        warehouse.Batumi:AddRequest(warehouse.Pampa, WAREHOUSE.Descriptor.ATTRIBUTE, request.cargoattribute, request.ndelivered, WAREHOUSE.TransportType.APC, WAREHOUSE.Quantity.ALL)
---      end
---    end
---
---    -- Forward all mobile ground assets to Pampa once they arrived.
---    function warehouse.Batumi:OnAfterNewAsset(From, Event, To, asset, assignment)
---      local asset=asset --Functional.Warehouse#WAREHOUSE.Assetitem
---      if assignment=="Assets for Pampa" then
---        if asset.category==Group.Category.GROUND and asset.speedmax>0 then
---          warehouse.Batumi:AddRequest(warehouse.Pampa, WAREHOUSE.Descriptor.GROUPNAME, asset.templatename)
---        end
---      end
---    end
---WAREHOUSE class.
---@class WAREHOUSE : FSM
---@field Attribute WAREHOUSE.Attribute 
---@field ClassName string Name of the class.
---@field Debug boolean If true, send debug messages to all.
---@field Descriptor WAREHOUSE.Descriptor 
---@field Quantity WAREHOUSE.Quantity 
---@field Report boolean If true, send status messages to coalition.
---@field TransportType WAREHOUSE.TransportType 
---@field private airbase AIRBASE Airbase the warehouse belongs to.
---@field private airbasename string Name of the airbase associated to the warehouse.
---@field private alias string Alias of the warehouse. Name its called when sending messages.
---@field private allowSpawnOnClientSpots boolean 
---@field private autodefence boolean When the warehouse is under attack, automatically spawn assets to defend the warehouse.
---@field private autosave boolean Automatically save assets to file when mission ends.
---@field private autosavefile string File name of the auto asset save file. Default is auto generated from warehouse id and name.
---@field private autosavepath string Path where the asset file is saved on auto save.
---@field private coalition NOTYPE 
---@field private countryid NOTYPE 
---@field private dTstatus number Time interval in seconds of updating the warehouse status and processing new events. Default 30 seconds.
---@field private defending table Table holding all defending requests, i.e. self requests that were if the warehouse is under attack. Table elements are of type @{#WAREHOUSE.Pendingitem}.
---@field private delivered table Table holding all delivered requests. Table elements are #boolean. If true, all cargo has been delivered.
---@field private flightcontrol FLIGHTCONTROL Flight control of this warehouse.
---@field private harborzone NOTYPE 
---@field private isShip boolean If `true`, warehouse is represented by a ship unit.
---@field private isUnit boolean If `true`, warehouse is represented by a unit instead of a static.
---@field private lid NOTYPE 
---@field private lowfuelthresh number Low fuel threshold. Triggers the event AssetLowFuel if for any unit fuel goes below this number.
---@field private markerOn boolean If true, markers are displayed on the F10 map.
---@field private markerRail MARKER Rail road connection.
---@field private markerRoad MARKER Road connection.
---@field private markerWarehouse MARKER Marker warehouse.
---@field private markerid number ID of the warehouse marker at the airbase.
---@field private markrail NOTYPE 
---@field private markroad NOTYPE 
---@field private offroadpaths table Table holding user defined paths from one warehouse to another.
---@field private parkingIDs NOTYPE 
---@field private pending table Table holding all pending requests, i.e. those that are currently in progress. Table elements are of type @{#WAREHOUSE.Pendingitem}.
---@field private portzone ZONE Zone defining the port of a warehouse. This is where naval assets are spawned.
---@field private queue table Table holding all queued requests. Table entries are of type @{#WAREHOUSE.Queueitem}.
---@field private queueid number Unit id of each request in the queue. Essentially a running number starting at one and incremented when a new request is added.
---@field private rail COORDINATE Closest point to warehouse on rail.
---@field private respawnafterdestroyed boolean If true, warehouse is respawned after it was destroyed. Assets are kept.
---@field private respawndelay number Delay before respawn in seconds.
---@field private road COORDINATE Closest point to warehouse on road.
---@field private runwaydestroyed number Time stamp timer.getAbsTime() when the runway was destroyed.
---@field private runwayrepairtime number Time in seconds until runway will be repaired after it was destroyed. Default is 3600 sec (one hour).
---@field private safeparking boolean If true, parking spots for aircraft are considered as occupied if e.g. a client aircraft is parked there. Default false.
---@field private shippinglanes table Table holding the user defined shipping between warehouses.
---@field private spawnzone ZONE Zone in which assets are spawned.
---@field private spawnzonemaxdist number Max distance between warehouse and spawn zone. Default 5000 meters.
---@field private stock table Table holding all assets in stock. Table entries are of type @{#WAREHOUSE.Assetitem}.
---@field private transporting table Table holding assets currently transporting cargo assets.
---@field private uid number Unique ID of the warehouse.
---@field private verbosity number Verbosity level.
---@field private version string Warehouse class version.
---@field private warehouse STATIC The phyical warehouse structure.
---@field private wid string Identifier of the warehouse printed before other output to DCS.log file.
---@field private zone ZONE Zone around the warehouse. If this zone is captured, the warehouse and all its assets goes to the capturing coalition.
WAREHOUSE = {}

---Trigger the FSM event "AddAsset".
---Add a group to the warehouse stock.
---
------
---@param group GROUP Group to be added as new asset.
---@param ngroups? number (Optional) Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) The distance in meters when the cargo is loaded into the carrier. Default is the bounding box size of the carrier.
---@param skill AI.Skill Skill of the asset.
---@param liveries table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
function WAREHOUSE:AddAsset(group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment) end

---Add an off-road path from this warehouse to another and back.
---The start and end points are automatically set to one random point in the respective spawn zones of the two warehouses.
---By default, the reverse path is also added as path from the remote warehouse to this warehouse.
---
------
---@param remotewarehouse WAREHOUSE The remote warehouse to which the path leads.
---@param group GROUP Waypoints of this group will define the path between to warehouses.
---@param oneway? boolean (Optional) If true, the path can only be used from this warehouse to the other but not other way around. Default false.
---@return WAREHOUSE #self
function WAREHOUSE:AddOffRoadPath(remotewarehouse, group, oneway) end

---Triggers the FSM event "AddRequest".
---Add a request to the warehouse queue, which is processed when possible.
---
------
---@param warehouse WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor WAREHOUSE.Descriptor Descriptor describing the asset that is requested.
---@param AssetDescriptorValue NOTYPE Value of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset number Number of groups requested that match the asset specification.
---@param TransportType WAREHOUSE.TransportType Type of transport.
---@param nTransport number Number of transport units requested.
---@param Prio number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment string A keyword or text that later be used to identify this request and postprocess the assets.
function WAREHOUSE:AddRequest(warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Prio, Assignment) end

---Add a shipping lane from this warehouse to another remote warehouse.
---Note that both warehouses must have a port zone defined before a shipping lane can be added!
---Shipping lane is taken from the waypoints of a (late activated) template group. So set up a group, e.g. a ship or a helicopter, and place its
---waypoints along the shipping lane you want to add.
---
------
---@param remotewarehouse WAREHOUSE The remote warehouse to where the shipping lane is added
---@param group GROUP Waypoints of this group will define the shipping lane between to warehouses.
---@param oneway? boolean (Optional) If true, the lane can only be used from this warehouse to the other but not other way around. Default false.
---@return WAREHOUSE #self
function WAREHOUSE:AddShippingLane(remotewarehouse, group, oneway) end

---Triggers the FSM event "AirbaseCaptured" when the airbase of the warehouse has been captured by another coalition.
---
------
---@param Coalition coalition.side Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:AirbaseCaptured(Coalition) end

---Triggers the FSM event "AirbaseRecaptured" when the airbase of the warehouse has been re-captured from the other coalition.
---
------
---@param Coalition coalition.side Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:AirbaseRecaptured(Coalition) end

---Triggers the FSM event "Arrived" when a group has arrived at the destination warehouse.
---This function should always be called from the sending and not the receiving warehouse.
---If the group is a cargo asset, it is added to the receiving warehouse. If the group is a transporter it
---is added to the sending warehouse since carriers are supposed to return to their home warehouse once
---all cargo was delivered.
---
------
---@param group GROUP Group that has arrived.
function WAREHOUSE:Arrived(group) end

---Triggers the FSM event "AssetDead" when an asset group has died.
---
------
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
function WAREHOUSE:AssetDead(asset, request) end

---Triggers the FSM event "AssetLowFuel" when an asset runs low on fuel
---
------
---@param asset WAREHOUSE.Assetitem The asset that is low on fuel.
---@param request WAREHOUSE.Pendingitem The request of the asset that is low on fuel.
function WAREHOUSE:AssetLowFuel(asset, request) end

---Triggers the FSM event "AssetSpawned" when the warehouse has spawned an asset.
---
------
---@param group GROUP the group that was spawned.
---@param asset WAREHOUSE.Assetitem The asset that was spawned.
---@param request WAREHOUSE.Pendingitem The request of the spawned asset.
function WAREHOUSE:AssetSpawned(group, asset, request) end

---Triggers the FSM event "Attacked" when a warehouse is under attack by an another coalition.
---
------
---@param Coalition coalition.side Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country country.id Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:Attacked(Coalition, Country) end

---Triggers the FSM event "Captured" when a warehouse has been captured by another coalition.
---
------
---@param Coalition coalition.side Coalition side which captured the warehouse.
---@param Country country.id Country id which has captured the warehouse.
function WAREHOUSE:Captured(Coalition, Country) end

---Triggers the FSM event "ChangeCountry" so the warehouse is respawned with the new country.
---
------
---@param Country country.id New country id of the warehouse.
function WAREHOUSE:ChangeCountry(Country) end

---Triggers the FSM event "Defeated" when an attack from an enemy was defeated.
---
------
function WAREHOUSE:Defeated() end

---Triggers the FSM event "Delivered".
---All (cargo) assets of a request have been delivered to the receiving warehouse.
---
------
---@param request WAREHOUSE.Pendingitem Pending request that was now delivered.
function WAREHOUSE:Delivered(request) end

---Triggers the FSM event "Destroyed" when the warehouse was destroyed.
---Services are stopped.
---
------
function WAREHOUSE:Destroyed() end

---Filter stock assets by descriptor and attribute.
---
------
---@param descriptor string Descriptor describing the filtered assets.
---@param attribute NOTYPE Value of the descriptor.
---@param nmax? number (Optional) Maximum number of items that will be returned. Default nmax=nil is all matching items are returned.
---@param mobile? boolean (Optional) If true, filter only mobile assets.
---@return table #Filtered assets in stock with the specified descriptor value.
---@return number #Total number of (requested) assets available.
---@return boolean #If true, enough assets are available.
function WAREHOUSE:FilterStock(descriptor, attribute, nmax, mobile) end

---Find an asset in the the global warehouse data base.
---Parameter is the MOOSE group object.
---Note that the group name must contain they "AID" keyword.
---
------
---@param group GROUP The group from which it is assumed that it has a registered asset.
---@return WAREHOUSE.Assetitem #The asset from the data base or nil if it could not be found.
function WAREHOUSE:FindAssetInDB(group) end

---Find nearest warehouse in service, i.e.
---warehouses which are not started, stopped or destroyed are not considered.
---Optionally, only warehouses with (specific) assets can be included in the search or warehouses of a certain coalition.
---
------
---@param MinAssets? NOTYPE (Optional) Minimum number of assets the warehouse should have. Default 0.
---@param Descriptor? string (Optional) Descriptor describing the selected assets which should be in stock. See @{#WAREHOUSE.Descriptor} for possible values.
---@param DescriptorValue? NOTYPE (Optional) Descriptor value selecting the type of assets which should be in stock.
---@param Coalition? Coalition.side (Optional) Coalition side of the warehouse. Default is the same coalition as the present warehouse. Set to false for any coalition.
---@param RefCoordinate? COORDINATE (Optional) Coordinate to which the closest warehouse is searched. Default is the warehouse calling this function.
---@return WAREHOUSE #The the nearest warehouse object. Or nil if no warehouse is found.
---@return number #The distance to the nearest warehouse in meters. Or nil if no warehouse is found.
function WAREHOUSE:FindNearestWarehouse(MinAssets, Descriptor, DescriptorValue, Coalition, RefCoordinate) end

---Find a warehouse in the global warehouse data base.
---
------
---@param uid number The unique ID of the warehouse.
---@return WAREHOUSE #The warehouse object or nil if no warehouse exists.
function WAREHOUSE:FindWarehouseInDB(uid) end

---Get airbase associated to the warehouse.
---
------
---@return AIRBASE #Airbase object or nil if warehouse has no airbase connection.
function WAREHOUSE:GetAirbase() end

---Get category of airbase associated to the warehouse.
---
------
---@return number #Category of airbase or -1 if warehouse has (currently) no airbase.
function WAREHOUSE:GetAirbaseCategory() end

---Get name airbase associated to the warehouse.
---
------
---@return string #name of the airbase assosicated to the warehouse or "none" if the airbase has not airbase connection currently.
function WAREHOUSE:GetAirbaseName() end

---Get a warehouse asset from its unique id.
---
------
---@param id number Asset ID.
---@return WAREHOUSE.Assetitem #The warehouse asset.
function WAREHOUSE:GetAssetByID(id) end

---Get a warehouse asset from its name.
---
------
---@param GroupName string Spawn group name.
---@return WAREHOUSE.Assetitem #The warehouse asset.
function WAREHOUSE:GetAssetByName(GroupName) end

---Get assignment of a request.
---
------
---@param request WAREHOUSE.Pendingitem The request from which the assignment is extracted.
---@return string #The assignment text.
function WAREHOUSE:GetAssignment(request) end

---Get coalition side of warehouse static.
---
------
---@return number #Coalition side, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCoalition() end

---Get coalition name of warehouse static.
---
------
---@return number #Coalition side, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCoalitionName() end

---Get coordinate of warehouse static.
---
------
---@return COORDINATE #The coordinate of the warehouse.
function WAREHOUSE:GetCoordinate() end

---Get country id of warehouse static.
---
------
---@return number #Country id, i.e. number of @{DCS#country.id}.
function WAREHOUSE:GetCountry() end

---Get country name of warehouse static.
---
------
---@return number #Country id, i.e. number of @{DCS#coalition.side}.
function WAREHOUSE:GetCountryName() end

---Get number of assets in warehouse stock.
---Optionally, only specific assets can be counted.
---
------
---@param Descriptor? string (Optional) Descriptor return the number of a specifc asset type. See @{#WAREHOUSE.Descriptor} for possible values.
---@param DescriptorValue? NOTYPE (Optional) Descriptor value selecting the type of assets.
---@param OnlyMobile? boolean (Optional) If true only mobile units are considered.
---@return number #Number of assets in stock.
function WAREHOUSE:GetNumberOfAssets(Descriptor, DescriptorValue, OnlyMobile) end

---Get a warehouse request from its unique id.
---
------
---@param id number Request ID.
---@return WAREHOUSE.Pendingitem #The warehouse requested - either queued or pending.
---@return boolean #If *true*, request is queued, if *false*, request is pending, if *nil*, request could not be found.
function WAREHOUSE:GetRequestByID(id) end

---Check if runway is operational.
---
------
---@return number #Time in seconds until the runway is repaired. Will return 0 if runway is repaired.
function WAREHOUSE:GetRunwayRepairtime() end

---Get the spawn zone.
---
------
---@return ZONE #The spawn zone.
function WAREHOUSE:GetSpawnZone() end

---Returns the number of assets for each generalized attribute.
---
------
---@param stock table The stock of the warehouse.
---@return table #Data table holding the numbers, i.e. data[attibute]=n.
function WAREHOUSE:GetStockInfo(stock) end

---Get 2D vector of warehouse static.
---
------
---@return Vec2 #The 2D vector of the warehouse.
function WAREHOUSE:GetVec2() end

---Get 3D vector of warehouse static.
---
------
---@return Vec3 #The 3D vector of the warehouse.
function WAREHOUSE:GetVec3() end

---Get the warehouse zone.
---
------
---@return ZONE #The warehouse zone.
function WAREHOUSE:GetWarehouseZone() end

---Check if the warehouse has a shipping lane defined to another warehouse.
---
------
---@param warehouse WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath boolean If true, place markers of path segments on the F10 map.
---@param smokepath boolean If true, put green smoke on path segments.
---@return boolean #If true, the two warehouses are connected by road.
---@return number #Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionNaval(warehouse, markpath, smokepath) end

---Check if the warehouse has an off road path defined to another warehouse.
---
------
---@param warehouse WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath boolean If true, place markers of path segments on the F10 map.
---@param smokepath boolean If true, put green smoke on path segments.
---@return boolean #If true, the two warehouses are connected by road.
---@return number #Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionOffRoad(warehouse, markpath, smokepath) end

---Check if the warehouse has a railroad connection to another warehouse.
---Both warehouses need to be started!
---
------
---@param warehouse WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath boolean If true, place markers of path segments on the F10 map.
---@param smokepath boolean If true, put green smoke on path segments.
---@return boolean #If true, the two warehouses are connected by road.
---@return number #Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionRail(warehouse, markpath, smokepath) end

---Check if the warehouse has a road connection to another warehouse.
---Both warehouses need to be started!
---
------
---@param warehouse WAREHOUSE The remote warehouse to where the connection is checked.
---@param markpath boolean If true, place markers of path segments on the F10 map.
---@param smokepath boolean If true, put green smoke on path segments.
---@return boolean #If true, the two warehouses are connected by road.
---@return number #Path length in meters. Negative distance -1 meter indicates no connection.
function WAREHOUSE:HasConnectionRoad(warehouse, markpath, smokepath) end

---Check if the warehouse is under attack by another coalition.
---
------
---@return boolean #If true, the warehouse is attacked.
function WAREHOUSE:IsAttacked() end

---Check if the warehouse has been destroyed.
---
------
---@return boolean #If true, the warehouse had been destroyed.
function WAREHOUSE:IsDestroyed() end

---Check if the warehouse has been loaded from disk via the "Load" event.
---
------
---@return boolean #If true, the warehouse was loaded from disk.
function WAREHOUSE:IsLoaded() end

---Check if the warehouse has not been started yet, i.e.
---is in the state "NotReadyYet".
---
------
---@return boolean #If true, the warehouse object has been created but the warehouse has not been started yet.
function WAREHOUSE:IsNotReadyYet() end

---Check if the warehouse is paused.
---In this state, requests are not processed.
---
------
---@return boolean #If true, the warehouse is paused.
function WAREHOUSE:IsPaused() end

---Check if the warehouse is running.
---
------
---@return boolean #If true, the warehouse is running and requests are processed.
function WAREHOUSE:IsRunning() end

---Check if runway is operational.
---
------
---@return boolean #If `true`, runway is operational.
function WAREHOUSE:IsRunwayOperational() end

---Check if warehouse physical representation is a ship.
---
------
---@return boolean #If `true`, warehouse object is a ship.
function WAREHOUSE:IsShip() end

---Check if warehouse physical representation is a static (not a unit) object.
---
------
---@return boolean #If `true`, warehouse object is a static.
function WAREHOUSE:IsStatic() end

---Check if the warehouse is stopped.
---
------
---@return boolean #If true, the warehouse is stopped.
function WAREHOUSE:IsStopped() end

---Check if warehouse physical representation is a unit (not a static) object.
---
------
---@return boolean #If `true`, warehouse object is a unit.
function WAREHOUSE:IsUnit() end

---Triggers the FSM event "Load" when the warehouse is loaded from a file on disk.
---
------
---@param path string Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:Load(path, filename) end

---The WAREHOUSE constructor.
---Creates a new WAREHOUSE object from a static object. Parameters like the coalition and country are taken from the static object structure.
---
------
---@param warehouse STATIC The physical structure representing the warehouse. Can also be a @{Wrapper.Unit#UNIT}.
---@param alias? string (Optional) Alias of the warehouse, i.e. the name it will be called when sending messages etc. Default is the name of the static/unit representing the warehouse.
---@return WAREHOUSE #self
function WAREHOUSE:New(warehouse, alias) end

---Triggers the FSM delayed event "NewAsset" when a new asset has been added to the warehouse stock.
---
------
---@param asset WAREHOUSE.Assetitem The new asset.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:NewAsset(asset, assignment) end

---On after "AirbaseCaptured" even user function.
---Called when the airbase of the warehouse has been captured by another coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:OnAfterAirbaseCaptured(From, Event, To, Coalition) end

---On after "AirbaseRecaptured" event user function.
---Called when the airbase of the warehouse has been re-captured from the other coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:OnAfterAirbaseRecaptured(From, Event, To, Coalition) end

---On after "Arrived" event user function.
---Called when a group has arrived at its destination.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP Group that has arrived.
function WAREHOUSE:OnAfterArrived(From, Event, To, group) end

---On after "AssetDead" event user function.
---Called when an asset group died.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
function WAREHOUSE:OnAfterAssetDead(From, Event, To, asset, request) end

---On after "AssetLowFuel" event user function.
---Called when the an asset is low on fuel.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that is low on fuel.
---@param request WAREHOUSE.Pendingitem The request of the asset that is low on fuel.
function WAREHOUSE:OnAfterAssetLowFuel(From, Event, To, asset, request) end

---On after "AssetSpawned" event user function.
---Called when the warehouse has spawned an asset.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP the group that was spawned.
---@param asset WAREHOUSE.Assetitem The asset that was spawned.
---@param request WAREHOUSE.Pendingitem The request of the spawned asset.
function WAREHOUSE:OnAfterAssetSpawned(From, Event, To, group, asset, request) end

---On after "Attacked" event user function.
---Called when a warehouse (zone) is under attack by an enemy.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country country.id Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:OnAfterAttacked(From, Event, To, Coalition, Country) end

---On after "Captured" event user function.
---Called when the warehouse has been captured by an enemy coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side Coalition side which captured the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country country.id Country id which has captured the warehouse, i.e. a number @{DCS#country.id} enumerator. 
function WAREHOUSE:OnAfterCaptured(From, Event, To, Coalition, Country) end

---On after "ChangeCountry" event user function.
---Called when the warehouse has changed its country.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Country country.id New country id of the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:OnAfterChangeCountry(From, Event, To, Country) end

---On after "Defeated" event user function.
---Called when an enemy attack was defeated.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function WAREHOUSE:OnAfterDefeate(From, Event, To) end

---On after "Delivered" event user function.
---Called when a group has been delivered from the warehouse to another warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param request WAREHOUSE.Pendingitem Pending request that was now delivered.
function WAREHOUSE:OnAfterDelivered(From, Event, To, request) end

---On after "Destroyed" event user function.
---Called when the warehouse was destroyed. Services are stopped.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function WAREHOUSE:OnAfterDestroyed(From, Event, To) end

---On after "Load" event user function.
---Called when the warehouse assets are loaded from disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:OnAfterLoad(From, Event, To, path, filename) end

---On after "NewAsset" event user function.
---A new asset has been added to the warehouse stock.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that has just been added.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:OnAfterNewAsset(From, Event, To, asset, assignment) end

---On after "Request" user function.
---The necessary cargo and transport assets were spawned.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Queueitem Information table of the request.
function WAREHOUSE:OnAfterRequest(From, Event, To, Request) end

---On after "Respawn" event user function.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
function WAREHOUSE:OnAfterRespawn(From, Event, To) end

---On after "Save" event user function.
---Called when the warehouse assets are saved to disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:OnAfterSave(From, Event, To, path, filename) end

---On after "SelfRequest" event.
---Request was initiated from the warehouse to itself. Groups are simply spawned at the warehouse or the associated airbase.
---All requested assets are passed as a Core.Set#SET_GROUP and can be used for further tasks or in other MOOSE classes.
---Note that airborne assets are spawned in uncontrolled state so they do not simply "fly away" after spawning.
---
------
---
---USAGE
---```
------ Self request event. Triggered once the assets are spawned in the spawn zone or at the airbase.
---function mywarehouse:OnAfterSelfRequest(From, Event, To, groupset, request)
---  local groupset=groupset --Core.Set#SET_GROUP
---
---  -- Loop over all groups spawned from that request.
---  for _,group in pairs(groupset:GetSetObjects()) do
---    local group=group --Wrapper.Group#GROUP
---
---    -- Gree smoke on spawned group.
---    group:SmokeGreen()
---
---    -- Activate uncontrolled airborne group if necessary.
---    group:StartUncontrolled()
---  end
---end
---```
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param groupset SET_GROUP The set of (cargo) groups that was delivered to the warehouse itself.
---@param request WAREHOUSE.Pendingitem Pending self request.
function WAREHOUSE:OnAfterSelfRequest(From, Event, To, groupset, request) end

---On before "Request" user function.
---The necessary cargo and transport assets will be spawned. Time to set some additional asset parameters.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Queueitem Information table of the request.
function WAREHOUSE:OnBeforeRequest(From, Event, To, Request) end

---Triggers the FSM event "Pause".
---Pauses the warehouse. Assets can still be added and requests be made. However, requests are not processed.
---
------
function WAREHOUSE:Pause() end

---Triggers the FSM event "Request".
---Executes a request from the queue if possible.
---
------
---@param Request WAREHOUSE.Queueitem Information table of the request.
function WAREHOUSE:Request(Request) end

---Triggers the FSM event "Respawn".
---
------
function WAREHOUSE:Respawn() end

---Triggers the FSM event "Restart".
---Restarts the warehouse from stopped state by reactivating the event handlers *only*.
---
------
function WAREHOUSE:Restart() end

---Triggers the FSM event "Save" when the warehouse assets are saved to file on disk.
---
------
---@param path string Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:Save(path, filename) end

---Triggers the FSM event "SelfRequest".
---Request was initiated from the warehouse to itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---
------
---@param groupset SET_GROUP The set of cargo groups that was delivered to the warehouse itself.
---@param request WAREHOUSE.Pendingitem Pending self request.
function WAREHOUSE:SelfRequest(groupset, request) end

---Set the airbase belonging to this warehouse.
---Note that it has to be of the same coalition as the warehouse.
---Also, be reasonable and do not put it too far from the phyiscal warehouse structure because you troops might have a long way to get to their transports.
---
------
---@param airbase AIRBASE The airbase object associated to this warehouse.
---@return WAREHOUSE #self
function WAREHOUSE:SetAirbase(airbase) end

---Set wether client parking spots can be used for spawning.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetAllowSpawnOnClientParking() end

---Set auto defence off.
---This is the default.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetAutoDefenceOff() end

---Set auto defence on.
---When the warehouse is under attack, all ground assets are spawned automatically and will defend the warehouse zone.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetAutoDefenceOn() end

---Set debug mode off.
---This is the default
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetDebugOff() end

---Set debug mode on.
---Error messages will be displayed on screen, units will be smoked at some events.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetDebugOn() end

---Add a Harbor Zone for this warehouse where naval cargo units will spawn and be received.
---Both warehouses must have the harbor zone defined for units to properly spawn on both the 
---sending and receiving side. The harbor zone should be within 3km of the port zone used for 
---warehouse in order to facilitate the boarding process.
---
------
---@param zone ZONE The zone defining the naval embarcation/debarcation point for cargo units
---@return WAREHOUSE #self
function WAREHOUSE:SetHarborZone(zone) end

---Set low fuel threshold.
---If one unit of an asset has less fuel than this number, the event AssetLowFuel will be fired.
---
------
---@param threshold number Relative low fuel threshold, i.e. a number in [0,1]. Default 0.15 (15%).
---@return WAREHOUSE #self
function WAREHOUSE:SetLowFuelThreshold(threshold) end

---Show or don't show markers on the F10 map displaying the Warehouse stock and road/rail connections.
---
------
---@param switch boolean If true (or nil), markers are on. If false, markers are not displayed.
---@return WAREHOUSE #self
function WAREHOUSE:SetMarker(switch) end

---Set valid parking spot IDs.
---
------
---@param ParkingIDs table Table of numbers.
---@return WAREHOUSE #self
function WAREHOUSE:SetParkingIDs(ParkingIDs) end

---Set the port zone for this warehouse.
---The port zone is the zone, where all naval assets of the warehouse are spawned.
---
------
---@param zone ZONE The zone defining the naval port of the warehouse.
---@return WAREHOUSE #self
function WAREHOUSE:SetPortZone(zone) end

---Set the connection of the warehouse to the railroad.
---This is the place where train assets or transports will be spawned.
---
------
---@param coordinate COORDINATE The railroad connection. Technically, the closest point on rails from this coordinate is determined by DCS API function. So this point must not be exactly on the a railroad connection.
---@return WAREHOUSE #self
function WAREHOUSE:SetRailConnection(coordinate) end

---Set report off.
---Warehouse does not report about its status and at certain events.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetReportOff() end

---Set report on.
---Messages at events will be displayed on screen to the coalition owning the warehouse.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetReportOn() end

---Set respawn after destroy.
---
------
---@param delay NOTYPE 
---@return WAREHOUSE #self
function WAREHOUSE:SetRespawnAfterDestroyed(delay) end

---Set the connection of the warehouse to the road.
---Ground assets spawned in the warehouse spawn zone will first go to this point and from there travel on road to the requesting warehouse.
---Note that by default the road connection is set to the closest point on road from the center of the spawn zone if it is withing 3000 meters.
---Also note, that if the parameter "coordinate" is passed as nil, any road connection is disabled and ground assets cannot travel of be transportet on the ground.
---
------
---@param coordinate COORDINATE The road connection. Technically, the closest point on road from this coordinate is determined by DCS API function. So this point must not be exactly on the road.
---@return WAREHOUSE #self
function WAREHOUSE:SetRoadConnection(coordinate) end

---Set the time until the runway(s) of an airdrome are repaired after it has been destroyed.
---Note that this is the time, the DCS engine uses not something we can control on a user level or we could get via scripting.
---You need to input the value. On the DCS forum it was stated that this is currently one hour. Hence this is the default value.
---
------
---@param RepairTime number Time in seconds until the runway is repaired. Default 3600 sec (one hour).
---@return WAREHOUSE #self
function WAREHOUSE:SetRunwayRepairtime(RepairTime) end

---Disable safe parking option.
---Note that is the default setting.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetSafeParkingOff() end

---Enable safe parking option, i.e.
---parking spots at an airbase will be considered as occupied when a client aircraft is parked there (even if the client slot is not taken by a player yet).
---Note that also incoming aircraft can reserve/occupie parking spaces.
---
------
---@return WAREHOUSE #self
function WAREHOUSE:SetSafeParkingOn() end

---Enable auto save of warehouse assets at mission end event.
---
------
---@param path string Path where to save the asset data file.
---@param filename string File name. Default is generated automatically from warehouse id.
---@return WAREHOUSE #self
function WAREHOUSE:SetSaveOnMissionEnd(path, filename) end

---Set a zone where the (ground) assets of the warehouse are spawned once requested.
---
------
---@param zone ZONE The spawn zone.
---@param maxdist? number (Optional) Maximum distance in meters between spawn zone and warehouse. Units are not spawned if distance is larger. Default is 5000 m.
---@return WAREHOUSE #self
function WAREHOUSE:SetSpawnZone(zone, maxdist) end

---Set interval of status updates.
---Note that normally only one request can be processed per time interval.
---
------
---@param timeinterval number Time interval in seconds.
---@return WAREHOUSE #self
function WAREHOUSE:SetStatusUpdate(timeinterval) end

---Set verbosity level.
---
------
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return WAREHOUSE #self
function WAREHOUSE:SetVerbosityLevel(VerbosityLevel) end

---Set a warehouse zone.
---If this zone is captured, the warehouse and all its assets fall into the hands of the enemy.
---
------
---@param zone ZONE The warehouse zone. Note that this **cannot** be a polygon zone!
---@return WAREHOUSE #self
function WAREHOUSE:SetWarehouseZone(zone) end

---Triggers the FSM event "Start".
---Starts the warehouse. Initializes parameters and starts event handlers.
---
------
function WAREHOUSE:Start() end

---Triggers the FSM event "Status".
---Queue is updated and requests are executed.
---
------
function WAREHOUSE:Status() end

---Triggers the FSM event "Stop".
---Stops the warehouse and all its event handlers. All waiting and pending queue items are deleted as well and all assets are removed from stock.
---
------
function WAREHOUSE:Stop() end

---Triggers the FSM event "Unpause".
---Unpauses the warehouse. Processing of queued requests is resumed.
---
------
function WAREHOUSE:UnPause() end

---Task function for last waypoint.
---Triggering the "Arrived" event.
---
------
---@param group GROUP The group that arrived.
function WAREHOUSE:_Arrived(group) end

---Asset item characteristics.
---
------
---@param asset WAREHOUSE.Assetitem The asset for which info in printed in trace mode.
function WAREHOUSE:_AssetItemInfo(asset) end

---Checks if the associated airbase still belongs to the warehouse.
---
------
function WAREHOUSE:_CheckAirbaseOwner() end

---Function that checks if an asset group is still okay.
---
------
function WAREHOUSE:_CheckAssetStatus() end

---Checks if the warehouse zone was conquered by antoher coalition.
---
------
function WAREHOUSE:_CheckConquered() end

---Checks fuel on all pening assets.
---
------
function WAREHOUSE:_CheckFuel() end

---Check parking ID for an asset.
---
------
---@param spot AIRBASE.ParkingSpot Parking spot.
---@param asset NOTYPE 
---@return boolean #If true, parking is valid.
function WAREHOUSE:_CheckParkingAsset(spot, asset) end

---Check parking ID.
---
------
---@param spot AIRBASE.ParkingSpot Parking spot.
---@return boolean #If true, parking is valid.
function WAREHOUSE:_CheckParkingValid(spot) end

---Sorts the queue and checks if the request can be fulfilled.
---
------
---@return WAREHOUSE.Queueitem #Chosen request.
function WAREHOUSE:_CheckQueue() end

---Checks if the request can be fulfilled in general.
---If not, it is removed from the queue.
---Check if departure and destination bases are of the right type.
---
------
---@param queue table The queue which is holding the requests to check.
---@return boolean #If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestConsistancy(queue) end

---Checks if the request can be fulfilled right now.
---Check for current parking situation, number of assets and transports currently in stock.
---
------
---@param request WAREHOUSE.Queueitem The request to be checked.
---@return boolean #If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestNow(request) end

---Check if a request is valid in general.
---If not, it will be removed from the queue.
---This routine needs to have at least one asset in stock that matches the request descriptor in order to determine whether the request category of troops.
---If no asset is in stock, the request will remain in the queue but cannot be executed.
---
------
---@param request WAREHOUSE.Queueitem The request to be checked.
---@return boolean #If true, request can be executed. If false, something is not right.
function WAREHOUSE:_CheckRequestValid(request) end

---Debug message.
---Message send to all if debug mode is activated (and duration > 0). Text self:T(text) added to DCS.log file.
---
------
---@param text string The text of the error message.
---@param duration number Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_DebugMessage(text, duration) end

---Delete item from queue.
---
------
---@param qitem WAREHOUSE.Queueitem Item of queue to be removed.
---@param queue table The queue from which the item should be deleted.
function WAREHOUSE:_DeleteQueueItem(qitem, queue) end

---Delete item from queue.
---
------
---@param qitemID number ID of queue item to be removed.
---@param queue table The queue from which the item should be deleted.
function WAREHOUSE:_DeleteQueueItemByID(qitemID, queue) end

---Delete an asset item from stock.
---
------
---@param stockitem WAREHOUSE.Assetitem Asset item to delete from stock table.
function WAREHOUSE:_DeleteStockItem(stockitem) end

---Display status of warehouse.
---
------
function WAREHOUSE:_DisplayStatus() end

---Display stock items of warehouse.
---
------
---@param stock table Table holding all assets in stock of the warehouse. Each entry is of type @{#WAREHOUSE.Assetitem}.
function WAREHOUSE:_DisplayStockItems(stock) end

---Error message.
---Message send to all (if duration > 0). Text self:E(text) added to DCS.log file.
---
------
---@param text string The text of the error message.
---@param duration number Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_ErrorMessage(text, duration) end

---Filter stock assets by table entry.
---
------
---@param stock table Table holding all assets in stock of the warehouse. Each entry is of type @{#WAREHOUSE.Assetitem}.
---@param descriptor string Descriptor describing the filtered assets.
---@param attribute NOTYPE Value of the descriptor.
---@param nmax? number (Optional) Maximum number of items that will be returned. Default nmax=nil is all matching items are returned.
---@param mobile? boolean (Optional) If true, filter only mobile assets.
---@return table #Filtered stock items table.
---@return number #Total number of (requested) assets available.
---@return boolean #If true, enough assets are available.
function WAREHOUSE:_FilterStock(stock, descriptor, attribute, nmax, mobile) end

---Seach unoccupied parking spots at the airbase for a list of assets.
---For each asset group a list of parking spots is returned.
---During the search also the not yet spawned asset aircraft are considered.
---If not enough spots for all asset units could be found, the routine returns nil!
---
------
---@param airbase AIRBASE The airbase where we search for parking spots.
---@param assets table A table of assets for which the parking spots are needed.
---@return table #Table of coordinates and terminal IDs of free parking spots. Each table entry has the elements .Coordinate and .TerminalID.
function WAREHOUSE:_FindParkingForAssets(airbase, assets) end

---Fireworks!
---
------
---@param coord COORDINATE 
function WAREHOUSE:_Fireworks(coord) end

---Get the generalized attribute of a group.
---Note that for a heterogenious group, the attribute is determined from the attribute of the first unit!
---
------
---@param group GROUP MOOSE group object.
---@return WAREHOUSE.Attribute #Generalized attribute of the group.
function WAREHOUSE:_GetAttribute(group) end

---Make a flight plan from a departure to a destination airport.
---
------
---@param asset WAREHOUSE.Assetitem 
---@param departure AIRBASE Departure airbase.
---@param destination AIRBASE Destination airbase.
---@return table #Table of flightplan waypoints.
---@return table #Table of flightplan coordinates.
function WAREHOUSE:_GetFlightplan(asset, departure, destination) end

---Get warehouse id, asset id and request id from group name (alias).
---
------
---@param group GROUP The group from which the info is gathered.
---@return number #Warehouse ID.
---@return number #Asset ID.
---@return number #Request ID.
function WAREHOUSE:_GetIDsFromGroup(group) end

---Get warehouse id, asset id and request id from group name (alias).
---
------
---@param groupname string Name of the group from which the info is gathered.
---@return number #Warehouse ID.
---@return number #Asset ID.
---@return number #Request ID.
function WAREHOUSE:_GetIDsFromGroupName(groupname) end

---Calculate the maximum height an aircraft can reach for the given parameters.
---
------
---@param D number Total distance in meters from Departure to holding point at destination.
---@param alphaC number Climb angle in rad.
---@param alphaD number Descent angle in rad.
---@param Hdep number AGL altitude of departure point.
---@param Hdest number AGL altitude of destination point.
---@param Deltahhold number Relative altitude of holding point above destination.
---@return number #Maximum height the aircraft can reach.
function WAREHOUSE:_GetMaxHeight(D, alphaC, alphaD, Hdep, Hdest, Deltahhold) end

---Get group name without any spawn or cargo suffix #CARGO etc.
---
------
---@param group GROUP The group from which the info is gathered.
---@return string #Name of the object without trailing #...
function WAREHOUSE:_GetNameWithOut(group) end

---Size of the bounding box of a DCS object derived from the DCS descriptor table.
---If boundinb box is nil, a size of zero is returned.
---
------
---@param DCSobject Object The DCS object for which the size is needed.
---@return number #Max size of object in meters (length (x) or width (z) components not including height (y)).
---@return number #Length (x component) of size.
---@return number #Height (y component) of size.
---@return number #Width (z component) of size.
function WAREHOUSE:_GetObjectSize(DCSobject) end

---Get the request belonging to a group.
---
------
---@param group GROUP The group from which the info is gathered.
---@param queue table Queue holding all requests.
---@return WAREHOUSE.Pendingitem #The request belonging to this group.
function WAREHOUSE:_GetRequestOfGroup(group, queue) end

---Get text about warehouse stock.
---
------
---@param messagetoall boolean If true, send message to all.
---@return string #Text about warehouse stock
function WAREHOUSE:_GetStockAssetsText(messagetoall) end

--- Get the proper terminal type based on generalized attribute of the group.
---
------
---@param _attribute WAREHOUSE.Attribute Generlized attibute of unit.
---@param _category number Airbase category.
---@return AIRBASE.TerminalType #Terminal type for this group.
function WAREHOUSE:_GetTerminal(_attribute, _category) end

---Get (optimized) transport carriers for the given assets to be transported.
---
------
---@param Chosen WAREHOUSE.Pendingitem request.
---@param request NOTYPE 
function WAREHOUSE:_GetTransportsForAssets(Chosen, request) end

---Is the group a used as transporter for a given request?
---
------
---@param group GROUP The group from which the info is gathered.
---@param request WAREHOUSE.Pendingitem Request.
---@return boolean #True if group is transport, false if group is cargo and nil otherwise.
function WAREHOUSE:_GroupIsTransport(group, request) end

---Check if a group has a generalized attribute.
---
------
---@param group GROUP MOOSE group object.
---@param attribute WAREHOUSE.Attribute Attribute to check.
---@return boolean #True if group has the specified attribute.
function WAREHOUSE:_HasAttribute(group, attribute) end

---Info Message.
---Message send to coalition if reports or debug mode activated (and duration > 0). Text self:I(text) added to DCS.log file.
---
------
---@param text string The text of the error message.
---@param duration number Message display duration in seconds. Default 20 sec. If duration is zero, no message is displayed.
function WAREHOUSE:_InfoMessage(text, duration) end

---Function that checks if a pending job is done and can be removed from queue.
---
------
function WAREHOUSE:_JobDone() end

---Create a new path from a template group.
---
------
---@param group GROUP Group used for extracting the waypoints.
---@param startcoord COORDINATE First coordinate.
---@param finalcoord COORDINATE Final coordinate.
---@return table #Table with route points.
function WAREHOUSE:_NewLane(group, startcoord, finalcoord) end

---Arrived event if an air unit/group arrived at its destination.
---This can be an engine shutdown or a landing event.
---
------
---@param EventData EVENTDATA Event data table.
function WAREHOUSE:_OnEventArrived(EventData) end

---Warehouse event handling function.
---Handles the case when the airbase associated with the warehous is captured.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventBaseCaptured(EventData) end

---Warehouse event function, handling the birth of a unit.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventBirth(EventData) end

---Warehouse event handling function.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventCrashOrDead(EventData) end

---Function handling the event when a (warehouse) unit shuts down its engines.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventEngineShutdown(EventData) end

---Function handling the event when a (warehouse) unit starts its engines.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventEngineStartup(EventData) end

---Function handling the event when a (warehouse) unit lands.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventLanding(EventData) end

---Warehouse event handling function.
---Handles the case when the mission is ended.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventMissionEnd(EventData) end

---Function handling the event when a (warehouse) unit takes off.
---
------
---@param EventData EVENTDATA Event data.
function WAREHOUSE:_OnEventTakeOff(EventData) end

---Task function for when passing a waypoint.
---
------
---@param group GROUP The group that arrived.
---@param n number Waypoint passed.
---@param N number Final waypoint.
function WAREHOUSE:_PassingWaypoint(group, n, N) end

---Prints the queue to DCS.log file.
---
------
---@param queue table Queue to print.
---@param name string Name of the queue for info reasons.
function WAREHOUSE:_PrintQueue(queue, name) end

---Relative to absolute quantity.
---
------
---@param relative string Relative number in terms of @{#WAREHOUSE.Quantity}.
---@param ntot number Total number.
---@return number #Absolute number.
function WAREHOUSE:_QuantityRel2Abs(relative, ntot) end

---Register new asset in globase warehouse data base.
---
------
---@param group GROUP The group that will be added to the warehouse stock.
---@param ngroups number Number of groups to be added.
---@param forceattribute string Forced generalized attribute.
---@param forcecargobay number Cargo bay weight limit in kg.
---@param forceweight number Weight of units in kg.
---@param loadradius number Radius in meters when cargo is loaded into the carrier.
---@param liveries table Table of liveries.
---@param skill AI.Skill Skill of AI.
---@param assignment string Assignment attached to the asset item.
---@return table #A table containing all registered assets.
function WAREHOUSE:_RegisterAsset(group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, liveries, skill, assignment) end

---Route the airplane from one airbase another.
---Activates uncontrolled aircraft and sets ROE/ROT for ferry flights.
---ROE is set to return fire and ROT to passive defence.
---
------
---@param aircraft GROUP Airplane group to be routed.
function WAREHOUSE:_RouteAir(aircraft) end

---Route ground units to destination.
---ROE is set to return fire and alarm state to green.
---
------
---@param group GROUP The ground group to be routed
---@param request WAREHOUSE.Queueitem The request for this group.
function WAREHOUSE:_RouteGround(group, request) end

---Route naval units along user defined shipping lanes to destination warehouse.
---ROE is set to return fire.
---
------
---@param group GROUP The naval group to be routed
---@param request WAREHOUSE.Queueitem The request for this group.
function WAREHOUSE:_RouteNaval(group, request) end

---Route trains to their destination - or at least to the closest point on rail of the desired final destination.
---
------
---@param Group GROUP The train group.
---@param Coordinate COORDINATE of the destination. Tail will be routed to the closest point
---@param Speed number Speed in km/h to drive to the destination coordinate. Default is 60% of max possible speed the unit can go.
function WAREHOUSE:_RouteTrain(Group, Coordinate, Speed) end

---Simple task function.
---Can be used to call a function which has the warehouse and the executing group as parameters.
---
------
---@param Function string The name of the function to call passed as string.
---@param group GROUP The group which is meant.
function WAREHOUSE:_SimpleTaskFunction(Function, group) end

---Simple task function.
---Can be used to call a function which has the warehouse and the executing group as parameters.
---
------
---@param Function string The name of the function to call passed as string.
---@param group GROUP The group which is meant.
---@param n number Waypoint passed.
---@param N number Final waypoint number.
function WAREHOUSE:_SimpleTaskFunctionWP(Function, group, n, N) end

---Sort requests queue wrt prio and request uid.
---
------
function WAREHOUSE:_SortQueue() end

---Spawn an aircraft asset (plane or helo) at the airbase associated with the warehouse.
---
------
---@param alias string Alias name of the asset group.
---@param asset WAREHOUSE.Assetitem Ground asset that will be spawned.
---@param request WAREHOUSE.Queueitem Request belonging to this asset. Needed for the name/alias.
---@param parking table Parking data for this asset.
---@param uncontrolled boolean Spawn aircraft in uncontrolled state.
---@param lateactivated boolean If true, groups are spawned late activated.
---@return GROUP #The spawned group or nil if the group could not be spawned.
function WAREHOUSE:_SpawnAssetAircraft(alias, asset, request, parking, uncontrolled, lateactivated) end

---Spawn a ground or naval asset in the corresponding spawn zone of the warehouse.
---
------
---@param alias string Alias name of the asset group.
---@param asset WAREHOUSE.Assetitem Ground asset that will be spawned.
---@param request WAREHOUSE.Queueitem Request belonging to this asset. Needed for the name/alias.
---@param spawnzone ZONE Zone where the assets should be spawned.
---@param lateactivated boolean If true, groups are spawned late activated.
---@return GROUP #The spawned group or nil if the group could not be spawned.
function WAREHOUSE:_SpawnAssetGroundNaval(alias, asset, request, spawnzone, lateactivated) end

---Prepare a spawn template for the asset.
---Deep copy of asset template, adjusting template and unit names, nillifying group and unit ids.
---
------
---@param asset WAREHOUSE.Assetitem Ground asset that will be spawned.
---@param alias string Alias name of the group.
---@return table #Prepared new spawn template.
function WAREHOUSE:_SpawnAssetPrepareTemplate(asset, alias) end

---Spawns requested assets at warehouse or associated airbase.
---
------
---@param Request WAREHOUSE.Queueitem Information table of the request.
function WAREHOUSE:_SpawnAssetRequest(Request) end

---A unit of a group just died.
---Update group sets in request.
---This is important in order to determine if a job is done and can be removed from the (pending) queue.
---
------
---@param deadunit UNIT Unit that died.
---@param deadgroup GROUP Group of unit that died.
---@param request WAREHOUSE.Pendingitem Request that needs to be updated.
function WAREHOUSE:_UnitDead(deadunit, deadgroup, request) end

---Create or update mark text at warehouse, which is displayed in F10 map showing how many assets of each type are in stock.
---Only the coalition of the warehouse owner is able to see it.
---
------
---@return string #Text about warehouse stock
function WAREHOUSE:_UpdateWarehouseMarkText() end

---Trigger the FSM event "AddAsset" with a delay.
---Add a group to the warehouse stock.
---
------
---@param delay number Delay in seconds.
---@param group GROUP Group to be added as new asset.
---@param ngroups? number (Optional) Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) The distance in meters when the cargo is loaded into the carrier. Default is the bounding box size of the carrier.
---@param skill AI.Skill Skill of the asset.
---@param liveries table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
function WAREHOUSE:__AddAsset(delay, group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment) end

---Triggers the FSM event "AddRequest" with a delay.
---Add a request to the warehouse queue, which is processed when possible.
---
------
---@param delay number Delay in seconds.
---@param warehouse WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor WAREHOUSE.Descriptor Descriptor describing the asset that is requested.
---@param AssetDescriptorValue NOTYPE Value of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset number Number of groups requested that match the asset specification.
---@param TransportType WAREHOUSE.TransportType Type of transport.
---@param nTransport number Number of transport units requested.
---@param Prio number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment string A keyword or text that later be used to identify this request and postprocess the assets.
function WAREHOUSE:__AddRequest(delay, warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Prio, Assignment) end

---Triggers the FSM event "AirbaseCaptured" with a delay when the airbase of the warehouse has been captured by another coalition.
---
------
---@param delay number Delay in seconds.
---@param Coalition coalition.side Coalition side which captured the airbase, i.e. a number of @{DCS#coalition.side} enumerator.
function WAREHOUSE:__AirbaseCaptured(delay, Coalition) end

---Triggers the FSM event "AirbaseRecaptured" with a delay when the airbase of the warehouse has been re-captured from the other coalition.
---
------
---@param delay number Delay in seconds.
---@param Coalition coalition.side Coalition which re-captured the airbase, i.e. the same as the current warehouse owner coalition.
function WAREHOUSE:__AirbaseRecaptured(delay, Coalition) end

---Triggers the FSM event "Arrived" after a delay when a group has arrived at the destination.
---This function should always be called from the sending and not the receiving warehouse.
---If the group is a cargo asset, it is added to the receiving warehouse. If the group is a transporter it
---is added to the sending warehouse since carriers are supposed to return to their home warehouse once
---
------
---@param delay number Delay in seconds.
---@param group GROUP Group that has arrived.
function WAREHOUSE:__Arrived(delay, group) end

---Triggers the delayed FSM event "AssetDead" when an asset group has died.
---
------
---@param delay number Delay in seconds.
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
function WAREHOUSE:__AssetDead(delay, asset, request) end

---Triggers the FSM event "AssetLowFuel" with a delay when an asset  runs low on fuel.
---
------
---@param delay number Delay in seconds.
---@param asset WAREHOUSE.Assetitem The asset that is low on fuel.
---@param request WAREHOUSE.Pendingitem The request of the asset that is low on fuel.
function WAREHOUSE:__AssetLowFuel(delay, asset, request) end

---Triggers the FSM event "AssetSpawned" with a delay when the warehouse has spawned an asset.
---
------
---@param delay number Delay in seconds.
---@param group GROUP the group that was spawned.
---@param asset WAREHOUSE.Assetitem The asset that was spawned.
---@param request WAREHOUSE.Pendingitem The request of the spawned asset.
function WAREHOUSE:__AssetSpawned(delay, group, asset, request) end

---Triggers the FSM event "Attacked" with a delay when a warehouse is under attack by an another coalition.
---
------
---@param delay number Delay in seconds.
---@param Coalition coalition.side Coalition side which is attacking the warehouse, i.e. a number of @{DCS#coalition.side} enumerator.
---@param Country country.id Country ID, which is attacking the warehouse, i.e. a number @{DCS#country.id} enumerator.
function WAREHOUSE:__Attacked(delay, Coalition, Country) end

---Triggers the FSM event "Captured" with a delay when a warehouse has been captured by another coalition.
---
------
---@param delay number Delay in seconds.
---@param Coalition coalition.side Coalition side which captured the warehouse.
---@param Country country.id Country id which has captured the warehouse.
function WAREHOUSE:__Captured(delay, Coalition, Country) end

---Triggers the FSM event "ChangeCountry" after a delay so the warehouse is respawned with the new country.
---
------
---@param delay number Delay in seconds.
---@param Country country.id Country id which has captured the warehouse.
function WAREHOUSE:__ChangeCountry(delay, Country) end

---Triggers the FSM event "Defeated" with a delay when an attack from an enemy was defeated.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Defeated(delay) end

---Triggers the FSM event "Delivered" after a delay.
---A group has been delivered from the warehouse to another warehouse.
---
------
---@param delay number Delay in seconds.
---@param request WAREHOUSE.Pendingitem Pending request that was now delivered.
function WAREHOUSE:__Delivered(delay, request) end

---Triggers the FSM event "Destroyed" with a delay when the warehouse was destroyed.
---Services are stopped.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Destroyed(delay) end

---Triggers the FSM event "Load" with a delay when the warehouse assets are loaded from disk.
---
------
---@param delay number Delay in seconds.
---@param path string Path where the file is located. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:__Load(delay, path, filename) end

---Triggers the FSM delayed event "NewAsset" when a new asset has been added to the warehouse stock.
---
------
---@param delay number Delay in seconds.
---@param asset WAREHOUSE.Assetitem The new asset.
---@param assignment? string (Optional) Assignment text for the asset.
function WAREHOUSE:__NewAsset(delay, asset, assignment) end

---Triggers the FSM event "Pause" after a delay.
---Pauses the warehouse. Assets can still be added and requests be made. However, requests are not processed.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Pause(delay) end

---Triggers the FSM event "Request" after a delay.
---Executes a request from the queue if possible.
---
------
---@param Delay number Delay in seconds.
---@param Request WAREHOUSE.Queueitem Information table of the request.
function WAREHOUSE:__Request(Delay, Request) end

---Triggers the FSM event "Respawn" after a delay.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Respawn(delay) end

---Triggers the FSM event "Restart" after a delay.
---Restarts the warehouse from stopped state by reactivating the event handlers *only*.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Restart(delay) end

---Triggers the FSM event "Save" with a delay when the warehouse assets are saved to a file.
---
------
---@param delay number Delay in seconds.
---@param path string Path where the file is saved. Default is the DCS installation root directory.
---@param filename? string (Optional) File name. Default is WAREHOUSE-<UID>_<ALIAS>.txt.
function WAREHOUSE:__Save(delay, path, filename) end

---Triggers the FSM event "SelfRequest" with a delay.
---Request was initiated from the warehouse to itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---
------
---@param delay number Delay in seconds.
---@param groupset SET_GROUP The set of cargo groups that was delivered to the warehouse itself.
---@param request WAREHOUSE.Pendingitem Pending self request.
function WAREHOUSE:__SelfRequest(delay, groupset, request) end

---Triggers the FSM event "Start" after a delay.
---Starts the warehouse. Initializes parameters and starts event handlers.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Start(delay) end

---Triggers the FSM event "Status" after a delay.
---Queue is updated and requests are executed.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Status(delay) end

---Triggers the FSM event "Stop" after a delay.
---Stops the warehouse and all its event handlers. All waiting and pending queue items are deleted as well and all assets are removed from stock.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Stop(delay) end

---Triggers the FSM event "Unpause" after a delay.
---Unpauses the warehouse. Processing of queued requests is resumed.
---
------
---@param delay number Delay in seconds.
function WAREHOUSE:__Unpause(delay) end

---On after "AddAsset" event.
---Add a group to the warehouse stock. If the group is alive, it is destroyed.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP Group or template group to be added to the warehouse stock.
---@param ngroups number Number of groups to add to the warehouse stock. Default is 1.
---@param forceattribute? WAREHOUSE.Attribute (Optional) Explicitly force a generalized attribute for the asset. This has to be an @{#WAREHOUSE.Attribute}.
---@param forcecargobay? number (Optional) Explicitly force cargobay weight limit in kg for cargo carriers. This is for each *unit* of the group.
---@param forceweight? number (Optional) Explicitly force weight in kg of each unit in the group.
---@param loadradius? number (Optional) Radius in meters when the cargo is loaded into the carrier.
---@param skill AI.Skill Skill of the asset.
---@param liveries table Table of livery names. When the asset is spawned one livery is chosen randomly.
---@param assignment string A free to choose string specifying an assignment for the asset. This can be used with the @{#WAREHOUSE.OnAfterNewAsset} function.
---@param other? table (Optional) Table of other useful data. Can be collected via WAREHOUSE.OnAfterNewAsset() function for example
---@private
function WAREHOUSE:onafterAddAsset(From, Event, To, group, ngroups, forceattribute, forcecargobay, forceweight, loadradius, skill, liveries, assignment, other) end

---On after "AddRequest" event.
---Add a request to the warehouse queue, which is processed when possible.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param warehouse WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor WAREHOUSE.Descriptor Descriptor describing the asset that is requested.
---@param AssetDescriptorValue NOTYPE Value of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset number Number of groups requested that match the asset specification.
---@param TransportType WAREHOUSE.TransportType Type of transport.
---@param nTransport number Number of transport units requested.
---@param Prio number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment string A keyword or text that can later be used to identify this request and postprocess the assets.
---@private
function WAREHOUSE:onafterAddRequest(From, Event, To, warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Prio, Assignment) end

---On after "AirbaseCaptured" event.
---Airbase of warehouse has been captured by another coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side which captured the warehouse.
---@private
function WAREHOUSE:onafterAirbaseCaptured(From, Event, To, Coalition) end

---On after "AirbaseRecaptured" event.
---Airbase of warehouse has been re-captured from other coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side Coalition side which originally captured the warehouse.
---@private
function WAREHOUSE:onafterAirbaseRecaptured(From, Event, To, Coalition) end

---On after "Arrived" event.
---Triggered when a group has arrived at its destination warehouse.
---The routine should be called by the warehouse sending this asset and not by the receiving warehouse.
---It is checked if this asset is cargo (or self propelled) or transport. If it is cargo it is put into the stock of receiving warehouse.
---If it is a transporter it is put back into the sending warehouse since transports are supposed to return their home warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP The group that was delivered.
---@private
function WAREHOUSE:onafterArrived(From, Event, To, group) end

---On after "AssetDead" event triggered when an asset group died.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
---@private
function WAREHOUSE:onafterAssetDead(From, Event, To, asset, request) end

---On after "AssetSpawned" event triggered when an asset group is spawned into the cruel world.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP The group spawned.
---@param asset WAREHOUSE.Assetitem The asset that is dead.
---@param request WAREHOUSE.Pendingitem The request of the dead asset.
---@private
function WAREHOUSE:onafterAssetSpawned(From, Event, To, group, asset, request) end

---On after "Attacked" event.
---Warehouse is under attack by an another coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side which is attacking the warehouse.
---@param Country country.id which is attacking the warehouse.
---@private
function WAREHOUSE:onafterAttacked(From, Event, To, Coalition, Country) end

---On after "Captured" event.
---Warehouse has been captured by another coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
---@private
function WAREHOUSE:onafterCaptured(From, Event, To, Coalition, Country) end

---On after "ChangeCountry" event.
---Warehouse is respawned with the specified country. All queued requests are deleted and the owned airbase is reset if the coalition is changed by changing the
---country.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Country country.id Country which has captured the warehouse.
---@private
function WAREHOUSE:onafterChangeCountry(From, Event, To, Country) end

---On after "Defeated" event.
---Warehouse defeated an attack by another coalition. Defender assets are added back to warehouse stock.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterDefeated(From, Event, To) end

---On after "Delivered" event.
---Triggered when all asset groups have reached their destination. Corresponding request is deleted from the pending queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param request WAREHOUSE.Pendingitem The pending request that is finished and deleted from the pending queue.
---@private
function WAREHOUSE:onafterDelivered(From, Event, To, request) end

---On after "Destroyed" event.
---Warehouse was destroyed. All services are stopped. Warehouse is going to "Stopped" state in one minute.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterDestroyed(From, Event, To) end

---On after "Load" event.
---Warehouse assets are loaded from file on disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is loaded from.
---@param filename? string (Optional) Name of the file containing the asset data.
---@private
function WAREHOUSE:onafterLoad(From, Event, To, path, filename) end

---On after "NewAsset" event.
---A new asset has been added to the warehouse stock.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param asset WAREHOUSE.Assetitem The asset that has just been added.
---@param assignment? string The (optional) assignment for the asset.
---@private
function WAREHOUSE:onafterNewAsset(From, Event, To, asset, assignment) end

---On after "Pause" event.
---Pauses the warehouse, i.e. no requests are processed. However, new requests and new assets can be added in this state.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterPause(From, Event, To) end

---On after "Request" event.
---Spawns the necessary cargo and transport assets.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Queueitem Information table of the request.
---@private
function WAREHOUSE:onafterRequest(From, Event, To, Request) end

---On after "RequestSpawned" event.
---Initiates the transport of the assets to the requesting warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Pendingitem Information table of the request.
---@param CargoGroupSet SET_GROUP Set of cargo groups.
---@param TransportGroupSet SET_GROUP Set of transport groups if any.
---@private
function WAREHOUSE:onafterRequestSpawned(From, Event, To, Request, CargoGroupSet, TransportGroupSet) end

---Respawn warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterRespawn(From, Event, To) end

---On after "Restart" event.
---Restarts the warehouse when it was in stopped state by reactivating the event handlers *only*.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterRestart(From, Event, To) end

---On after "RunwayDestroyed" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterRunwayDestroyed(From, Event, To) end

---On after "RunwayRepaired" event.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterRunwayRepaired(From, Event, To) end

---On after "Save" event.
---Warehouse assets are saved to file on disk.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is saved. If nil, file is saved in the DCS root installtion directory.
---@param filename? string (Optional) Name of the file containing the asset data.
---@private
function WAREHOUSE:onafterSave(From, Event, To, path, filename) end

---On after "SelfRequest" event.
---Request was initiated to the warehouse itself. Groups are just spawned at the warehouse or the associated airbase.
---If the warehouse is currently under attack when the self request is made, the self request is added to the defending table. One the attack is defeated,
---this request is used to put the groups back into the warehouse stock.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param groupset SET_GROUP The set of asset groups that was delivered to the warehouse itself.
---@param request WAREHOUSE.Pendingitem Pending self request.
---@private
function WAREHOUSE:onafterSelfRequest(From, Event, To, groupset, request) end

---On after Start event.
---Starts the warehouse. Adds event handlers and schedules status updates of reqests and queue.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterStart(From, Event, To) end

---On after Status event.
---Checks the queue and handles requests.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterStatus(From, Event, To) end

---On after "Stop" event.
---Stops the warehouse, unhandles all events.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterStop(From, Event, To) end

---On after "Unloaded" event.
---Triggered when a group was unloaded from the carrier.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP The group that was delivered.
---@private
function WAREHOUSE:onafterUnloaded(From, Event, To, group) end

---On after "Unpause" event.
---Unpauses the warehouse, i.e. requests in queue are processed again.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@private
function WAREHOUSE:onafterUnpause(From, Event, To) end

---On before "AddRequest" event.
---Checks some basic properties of the given parameters.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param warehouse WAREHOUSE The warehouse requesting supply.
---@param AssetDescriptor WAREHOUSE.Descriptor Descriptor describing the asset that is requested.
---@param AssetDescriptorValue NOTYPE Value of the asset descriptor. Type depends on descriptor, i.e. could be a string, etc.
---@param nAsset number Number of groups requested that match the asset specification.
---@param TransportType WAREHOUSE.TransportType Type of transport.
---@param nTransport number Number of transport units requested.
---@param Prio number Priority of the request. Number ranging from 1=high to 100=low.
---@param Assignment string A keyword or text that later be used to identify this request and postprocess the assets.
---@return boolean #If true, request is okay at first glance.
---@private
function WAREHOUSE:onbeforeAddRequest(From, Event, To, warehouse, AssetDescriptor, AssetDescriptorValue, nAsset, TransportType, nTransport, Prio, Assignment) end

---On before "Arrived" event.
---Triggered when a group has arrived at its destination warehouse.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param group GROUP The group that was delivered.
---@private
function WAREHOUSE:onbeforeArrived(From, Event, To, group) end

---On before "Captured" event.
---Warehouse has been captured by another coalition.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Coalition coalition.side which captured the warehouse.
---@param Country country.id which has captured the warehouse.
---@private
function WAREHOUSE:onbeforeCaptured(From, Event, To, Coalition, Country) end

---On before "ChangeCountry" event.
---Checks whether a change of country is necessary by comparing the actual country to the the requested one.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Country country.id which has captured the warehouse.
---@private
function WAREHOUSE:onbeforeChangeCountry(From, Event, To, Country) end

---On before "Load" event.
---Checks if the file the warehouse data should be loaded from exists.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param path string Path where the file is loaded from.
---@param filename? string (Optional) Name of the file containing the asset data.
---@private
function WAREHOUSE:onbeforeLoad(From, Event, To, path, filename) end

---On before "Request" event.
---Checks if the request can be fulfilled.
---
------
---@param From string From state.
---@param Event string Event.
---@param To string To state.
---@param Request WAREHOUSE.Queueitem Information table of the request.
---@return boolean #If true, request is granted.
---@private
function WAREHOUSE:onbeforeRequest(From, Event, To, Request) end


---Item of the warehouse stock table.
---@class WAREHOUSE.Assetitem 
---@field DCSdesc Object.Desc All DCS descriptors.
---@field Treturned number Time stamp when asset returned to its legion (airwing, brigade).
---@field private arrived boolean If true, asset arrived at its destination.
---@field private assignment string Assignment of the asset. This could, e.g., be used in the @{#WAREHOUSE.OnAfterNewAsset) function.
---@field private attribute WAREHOUSE.Attribute Generalized attribute of the group.
---@field private cargobay table Array of cargo bays of all units in an asset group.
---@field private cargobaymax number Largest cargo bay of all units in the group.
---@field private cargobaytot number Total weight in kg that fits in the cargo bay of all asset group units.
---@field private category Group.Category Category of the group.
---@field private cohort COHORT The cohort this asset belongs to.
---@field private damage number Damage of asset group in percent.
---@field private flightgroup OPSGROUP The flightgroup object.
---@field private isReserved boolean If `true`, asset was reserved and cannot be selected by another request.
---@field private iscargo boolean If true, asset is cargo. If false asset is transport. Nil if in stock.
---@field private legion LEGION The legion this asset belonts to.
---@field private life0 NOTYPE 
---@field private livery string Livery of the asset.
---@field private loadradius number Distance when cargo is loaded into the carrier.
---@field private nunits number Number of units in the group.
---@field private payload AIRWING.Payload The payload of the asset.
---@field private range number Range of the unit in meters.
---@field private requested boolean If `true`, asset was requested and cannot be selected by another request.
---@field private rid number Request ID of this asset (if any).
---@field private size number Maximum size in length and with of the asset in meters.
---@field private skill AI.Skill Skill of AI unit.
---@field private spawned boolean If true, asset was spawned into the cruel world. If false, it is still in stock.
---@field private spawngroupname string Name of the spawned group.
---@field private speedmax number Maximum speed in km/h the group can do.
---@field private squadname string Name of the squadron this asset belongs to.
---@field private task NOTYPE 
---@field private template table The spawn template of the group.
---@field private templatename string Name of the template group.
---@field private uid number Unique id of the asset.
---@field private unittype string Type of the first unit of the group as obtained by the Object.getTypeName() DCS API function.
---@field private weight number The weight of the whole asset group in kilograms.
---@field private weights NOTYPE 
---@field private wid number ID of the warehouse this asset belongs to.
WAREHOUSE.Assetitem = {}


---Generalized asset attributes.
---Can be used to request assets with certain general characteristics. See [DCS attributes](https://wiki.hoggitworld.com/view/DCS_enum_attributes) on hoggit.
---@class WAREHOUSE.Attribute 
---@field AIR_ATTACKHELO string Attack helicopter.
---@field AIR_AWACS string Airborne Early Warning and Control System.
---@field AIR_BOMBER string Aircraft which can be used for strategic bombing.
---@field AIR_FIGHTER string Fighter, interceptor, ... airplane.
---@field AIR_OTHER string Any airborne unit that does not fall into any other airborne category.
---@field AIR_TANKER string Airplane which can refuel other aircraft.
---@field AIR_TRANSPORTHELO string Helicopter with transport capability. This can be used to transport other assets.
---@field AIR_TRANSPORTPLANE string Airplane with transport capability. This can be used to transport other assets.
---@field AIR_UAV string Unpiloted Aerial Vehicle, e.g. drones.
---@field GROUND_AAA string Anti-Aircraft Artillery.
---@field GROUND_APC string Infantry carriers, in particular Amoured Personell Carrier. This can be used to transport other assets.
---@field GROUND_ARTILLERY string Artillery assets.
---@field GROUND_EWR string Early Warning Radar.
---@field GROUND_IFV string Ground infantry fighting vehicle.
---@field GROUND_INFANTRY string Ground infantry assets.
---@field GROUND_OTHER string Any ground unit that does not fall into any other ground category.
---@field GROUND_SAM string Surface-to-Air Missile system or components.
---@field GROUND_TANK string Tanks (modern or old).
---@field GROUND_TRAIN string Trains. Not that trains are **not** yet properly implemented in DCS and cannot be used currently.
---@field GROUND_TRUCK string Unarmed ground vehicles, which has the DCS "Truck" attribute.
---@field NAVAL_AIRCRAFTCARRIER string Aircraft carrier.
---@field NAVAL_ARMEDSHIP string Any armed ship that is not an aircraft carrier, a cruiser, destroyer, firgatte or corvette.
---@field NAVAL_OTHER string Any naval unit that does not fall into any other naval category.
---@field NAVAL_UNARMEDSHIP string Any unarmed naval vessel.
---@field NAVAL_WARSHIP string War ship, i.e. cruisers, destroyers, firgates and corvettes.
---@field OTHER_UNKNOWN string Anything that does not fall into any other category.
WAREHOUSE.Attribute = {}


---Descriptors enumerator describing the type of the asset.
---@class WAREHOUSE.Descriptor 
---@field ASSETLIST string List of specific assets gives as a table of assets. Mind the curly brackets {}.
---@field ASSIGNMENT string Assignment of asset when it was added.
---@field ATTRIBUTE string Generalized attribute @{#WAREHOUSE.Attribute}.
---@field CATEGORY string Asset category of type DCS#Group.Category, i.e. GROUND, AIRPLANE, HELICOPTER, SHIP, TRAIN.
---@field GROUPNAME string Name of the asset template.
---@field UNITTYPE string Typename of the DCS unit, e.g. "A-10C".
WAREHOUSE.Descriptor = {}


---Item of the warehouse pending queue table.
---@class WAREHOUSE.Pendingitem : WAREHOUSE.Queueitem
---@field private assetproblem table Table with assets that might have problems (damage or stuck).
---@field private cargogroupset SET_GROUP Set of cargo groups do be delivered.
---@field private carriercargo table Table holding the cargo groups of each carrier unit.
---@field private lowfuel boolean If true, at least one asset group is low on fuel.
---@field private ndelivered number Number of groups delivered to destination.
---@field private ntransporthome number Number of transports back home.
---@field private timestamp number Absolute mission time in seconds when the request was processed.
---@field private transportcargoset SET_CARGO Set of cargo objects.
---@field private transportgroupset SET_GROUP Set of cargo transport carrier groups.
WAREHOUSE.Pendingitem = {}


---Warehouse quantity enumerator for selecting number of assets, e.g.
---all, half etc. of what is in stock rather than an absolute number.
---@class WAREHOUSE.Quantity 
---@field ALL string All "all" assets currently in stock.
---@field HALF string Half "1/2" of assets in stock.
---@field QUARTER string One quarter "1/4" of assets in stock.
---@field THIRD string One third "1/3" of assets in stock.
---@field THREEQUARTERS string Three quarters "3/4" of assets in stock.
WAREHOUSE.Quantity = {}


---Item of the warehouse queue table.
---@class WAREHOUSE.Queueitem 
---@field private airbase AIRBASE The airbase beloning to requesting warehouse if any.
---@field private assetdesc WAREHOUSE.Descriptor Descriptor of the requested asset. Enumerator of type @{#WAREHOUSE.Descriptor}.
---@field private assetproblem table 
---@field private assets table Table of self propelled (or cargo) and transport assets. Each element of the table is a @{#WAREHOUSE.Assetitem} and can be accessed by their asset ID.
---@field private assignment string A keyword or text that later be used to identify this request and postprocess the assets.
---@field private cargoassets table Table of cargo (or self propelled) assets. Each element of the table is a @{#WAREHOUSE.Assetitem}.
---@field private cargoattribute number Attribute of cargo assets of type @{#WAREHOUSE.Attribute}.
---@field private cargocategory number Category of cargo assets of type @{#WAREHOUSE.Category}.
---@field private category Airbase.Category Category of the requesting airbase, i.e. airdrome, helipad/farp or ship.
---@field private lateActivation boolean Assets are spawned in late activated state.
---@field private nasset number Number of asset groups requested.
---@field private ntransport number Max. number of transport units requested.
---@field private prio number Priority of the request. Number between 1 (high) and 100 (low).
---@field private timestamp NOTYPE 
---@field private toself boolean Self request, i.e. warehouse requests assets from itself.
---@field private transportassets table Table of transport carrier assets. Each element of the table is a @{#WAREHOUSE.Assetitem}.
---@field private transportattribute number Attribute of transport assets of type @{#WAREHOUSE.Attribute}.
---@field private transportcategory number Category of transport assets of type @{#WAREHOUSE.Category}.
---@field private transporttype WAREHOUSE.TransportType Transport unit type.
---@field private uid number Unique id of the queue item.
---@field private warehouse WAREHOUSE Requesting warehouse.
WAREHOUSE.Queueitem = {}


---Cargo transport type.
---Defines how assets are transported to their destination.
---@class WAREHOUSE.TransportType 
---@field AIRCRAFTCARRIER string 
---@field AIRPLANE string Transports are carried out by airplanes.
---@field APC string Transports are conducted by APCs.
---@field ARMEDSHIP string 
---@field HELICOPTER string Transports are carried out by helicopters.
---@field SELFPROPELLED string Assets go to their destination by themselves. No transport carrier needed.
---@field SHIP string Transports are conducted by ships. Not implemented yet.
---@field TRAIN string Transports are conducted by trains. Not implemented yet. Also trains are buggy in DCS.
---@field WARSHIP string 
WAREHOUSE.TransportType = {}


---Warehouse database.
---Note that this is a global array to have easier exchange between warehouses.
---@class _WAREHOUSEDB 
---@field AssetID number Unique ID of each asset. This is a running number, which is increased each time a new asset is added.
---@field Assets table Table holding registered assets, which are of type @{Functional.Warehouse#WAREHOUSE.Assetitem}.#
---@field WarehouseID number Unique ID of the warehouse. Running number.
---@field Warehouses table Table holding all defined @{#WAREHOUSE} objects by their unique ids.
_WAREHOUSEDB = {}



