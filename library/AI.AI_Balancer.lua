---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/AI_Balancing.JPG" width="100%">
---
---**AI** - Balance player slots with AI to create an engaging simulation environment, independent of the amount of players.
---
---**Features:**
---
---  * Automatically spawn AI as a replacement of free player slots for a coalition.
---  * Make the AI to perform tasks.
---  * Define a maximum amount of AI to be active at the same time.
---  * Configure the behaviour of AI when a human joins a slot for which an AI is active.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/AI/AI_Balancer)
---
---===
---
---### [YouTube Playlist](https://www.youtube.com/playlist?list=PL7ZUrU4zZUl2CJVIrL1TdAumuVS8n64B7)
---
---===
---
---### Author: **FlightControl**
---### Contributions: 
---
---  * **Dutch_Baron**: Working together with James has resulted in the creation of the AI_BALANCER class. James has shared his ideas on balancing AI with air units, and together we made a first design which you can use now :-)
---
---===
---![Banner Image](..\Images\deprecated.png)
---
---Monitors and manages as many replacement AI groups as there are
---CLIENTS in a SET\_CLIENT collection, which are not occupied by human players.
---In other words, use AI_BALANCER to simulate human behaviour by spawning in replacement AI in multi player missions.
---
---The parent class Core.Fsm#FSM_SET manages the functionality to control the Finite State Machine (FSM). 
---The mission designer can tailor the behaviour of the AI_BALANCER, by defining event and state transition methods.
---An explanation about state and event transition methods can be found in the Core.Fsm module documentation.
---
---The mission designer can tailor the AI_BALANCER behaviour, by implementing a state or event handling method for the following:
---
---  * #AI_BALANCER.OnAfterSpawned( AISet, From, Event, To, AIGroup ): Define to add extra logic when an AI is spawned.
---
---## 1. AI_BALANCER construction
---
---Create a new AI_BALANCER object with the #AI_BALANCER.New() method:
---
---## 2. AI_BALANCER is a FSM
---
---![Process](..\Presentations\AI_BALANCER\Dia13.JPG)
---
---### 2.1. AI_BALANCER States
---
---  * **Monitoring** ( Set ): Monitoring the Set if all AI is spawned for the Clients.
---  * **Spawning** ( Set, ClientName ): There is a new AI group spawned with ClientName as the name of reference.
---  * **Spawned** ( Set, AIGroup ): A new AI has been spawned. You can handle this event to customize the AI behaviour with other AI FSMs or own processes.
---  * **Destroying** ( Set, AIGroup ): The AI is being destroyed.
---  * **Returning** ( Set, AIGroup ): The AI is returning to the airbase specified by the ReturnToAirbase methods. Handle this state to customize the return behaviour of the AI, if any.
---
---### 2.2. AI_BALANCER Events
---
---  * **Monitor** ( Set ): Every 10 seconds, the Monitor event is triggered to monitor the Set.
---  * **Spawn** ( Set, ClientName ): Triggers when there is a new AI group to be spawned with ClientName as the name of reference.
---  * **Spawned** ( Set, AIGroup ): Triggers when a new AI has been spawned. You can handle this event to customize the AI behaviour with other AI FSMs or own processes.
---  * **Destroy** ( Set, AIGroup ): The AI is being destroyed.
---  * **Return** ( Set, AIGroup ): The AI is returning to the airbase specified by the ReturnToAirbase methods.
---   
---## 3. AI_BALANCER spawn interval for replacement AI
---
---Use the method #AI_BALANCER.InitSpawnInterval() to set the earliest and latest interval in seconds that is waited until a new replacement AI is spawned.
---
---## 4. AI_BALANCER returns AI to Airbases
---
---By default, When a human player joins a slot that is AI_BALANCED, the AI group will be destroyed by default. 
---However, there are 2 additional options that you can use to customize the destroy behaviour.
---When a human player joins a slot, you can configure to let the AI return to:
---
---   * #AI_BALANCER.ReturnToHomeAirbase: Returns the AI to the **home** Wrapper.Airbase#AIRBASE.
---   * #AI_BALANCER.ReturnToNearestAirbases: Returns the AI to the **nearest friendly** Wrapper.Airbase#AIRBASE.
---
---Note that when AI returns to an airbase, the AI_BALANCER will trigger the **Return** event and the AI will return, 
---otherwise the AI_BALANCER will trigger a **Destroy** event, and the AI will be destroyed.
---
---# Developer Note
---
---Note while this class still works, it is no longer supported as the original author stopped active development of MOOSE
---Therefore, this class is considered to be deprecated
---@deprecated
---@class AI_BALANCER 
---@field Earliest NOTYPE 
---@field Latest NOTYPE 
---@field ReturnAirbaseSet NOTYPE 
---@field ReturnThresholdRange NOTYPE 
---@field ToHomeAirbase boolean 
---@field ToNearestAirbase boolean 
AI_BALANCER = {}

---Sets the earliest to the latest interval in seconds how long AI_BALANCER will wait to spawn a new AI.
---Provide 2 identical seconds if the interval should be a fixed amount of seconds.
---
------
---@param self AI_BALANCER 
---@param Earliest number The earliest a new AI can be spawned in seconds.
---@param Latest number The latest a new AI can be spawned in seconds.
---@return  #self
function AI_BALANCER:InitSpawnInterval(Earliest, Latest) end

---Creates a new AI_BALANCER object
---
------
---@param self AI_BALANCER 
---@param SetClient SET_CLIENT A SET\_CLIENT object that will contain the CLIENT objects to be monitored if they are alive or not (joined by a player).
---@param SpawnAI SPAWN The default Spawn object to spawn new AI Groups when needed.
---@return AI_BALANCER #
function AI_BALANCER:New(SetClient, SpawnAI) end

---Returns the AI to the home Wrapper.Airbase#AIRBASE.
---
------
---@param self AI_BALANCER 
---@param ReturnThresholdRange Distance If there is an enemy @{Wrapper.Client#CLIENT} within the ReturnThresholdRange given in meters, the AI will not return to the nearest @{Wrapper.Airbase#AIRBASE}.
function AI_BALANCER:ReturnToHomeAirbase(ReturnThresholdRange) end

---Returns the AI to the nearest friendly Wrapper.Airbase#AIRBASE.
---
------
---@param self AI_BALANCER 
---@param ReturnThresholdRange Distance If there is an enemy @{Wrapper.Client#CLIENT} within the ReturnThresholdRange given in meters, the AI will not return to the nearest @{Wrapper.Airbase#AIRBASE}.
---@param ReturnAirbaseSet SET_AIRBASE The SET of @{Core.Set#SET_AIRBASE}s to evaluate where to return to.
function AI_BALANCER:ReturnToNearestAirbases(ReturnThresholdRange, ReturnAirbaseSet) end

---AI_BALANCER:onenterDestroying
---
------
---@param self AI_BALANCER 
---@param SetGroup SET_GROUP 
---@param AIGroup GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@param ClientName NOTYPE 
---@private
function AI_BALANCER:onenterDestroying(SetGroup, AIGroup, From, Event, To, ClientName) end

---AI_BALANCER:onenterMonitoring
---
------
---@param self AI_BALANCER 
---@param SetGroup NOTYPE 
---@private
function AI_BALANCER:onenterMonitoring(SetGroup) end

---RTB
---
------
---@param self AI_BALANCER 
---@param SetGroup SET_GROUP 
---@param From string 
---@param Event string 
---@param To string 
---@param AIGroup GROUP 
---@private
function AI_BALANCER:onenterReturning(SetGroup, From, Event, To, AIGroup) end

---AI_BALANCER:onenterSpawning
---
------
---@param self AI_BALANCER 
---@param SetGroup SET_GROUP 
---@param ClientName string 
---@param AIGroup GROUP 
---@param From NOTYPE 
---@param Event NOTYPE 
---@param To NOTYPE 
---@private
function AI_BALANCER:onenterSpawning(SetGroup, ClientName, AIGroup, From, Event, To) end



