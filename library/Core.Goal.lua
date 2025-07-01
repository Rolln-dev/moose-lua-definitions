---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Goal.JPG" width="100%">
---
---**Core** - Models the process to achieve goal(s).
---
---===
---
---## Features:
---
---  * Define the goal.
---  * Monitor the goal achievement.
---  * Manage goal contribution by players.
---
---===
---
---Classes that implement a goal achievement, will derive from GOAL to implement the ways how the achievements can be realized.
---
---===
---
---### Author: **FlightControl**
---### Contributions: **funkyfranky**
---
---===
---Models processes that have an objective with a defined achievement.
---Derived classes implement the ways how the achievements can be realized.
---
---# 1. GOAL constructor
---
---  * #GOAL.New(): Creates a new GOAL object.
---
---# 2. GOAL is a finite state machine (FSM).
---
---## 2.1. GOAL States
---
---  * **Pending**: The goal object is in progress.
---  * **Achieved**: The goal objective is Achieved.
---
---## 2.2. GOAL Events
---
---  * **Achieved**: Set the goal objective to Achieved.
---
---# 3. Player contributions.
---
---Goals are most of the time achieved by players. These player achievements can be registered as part of the goal achievement.
---Use #GOAL.AddPlayerContribution() to add a player contribution to the goal.
---The player contributions are based on a points system, an internal counter per player.
---So once the goal has been achieved, the player contributions can be queried using #GOAL.GetPlayerContributions(),
---that retrieves all contributions done by the players. For one player, the contribution can be queried using #GOAL.GetPlayerContribution().
---The total amount of player contributions can be queried using #GOAL.GetTotalContributions().
---
---# 4. Goal achievement.
---
---Once the goal is achieved, the mission designer will need to trigger the goal achievement using the **Achieved** event.
---The underlying 2 examples will achieve the goals for the `Goal` object:
---
---      Goal:Achieved() -- Achieve the goal immediately.
---      Goal:__Achieved( 30 ) -- Achieve the goal within 30 seconds.
---
---# 5. Check goal achievement.
---
---The method #GOAL.IsAchieved() will return true if the goal is achieved (the trigger **Achieved** was executed).
---You can use this method to check asynchronously if a goal has been achieved, for example using a scheduler.
---@class GOAL 
---@field Players table 
GOAL = {}

---Achieved Trigger for GOAL
---
------
---@param self GOAL 
function GOAL:Achieved() end

---Add a new contribution by a player.
---
------
---@param self GOAL 
---@param PlayerName string The name of the player.
function GOAL:AddPlayerContribution(PlayerName) end


---
------
---@param self NOTYPE 
---@param PlayerName NOTYPE 
function GOAL:GetPlayerContribution(PlayerName) end

---Get the players who contributed to achieve the goal.
---The result is a list of players, sorted by the name of the players.
---
------
---@param self GOAL 
---@return  ##list The list of players, indexed by the player name.
function GOAL:GetPlayerContributions() end

---Gets the total contributions that happened to achieve the goal.
---The result is a number.
---
------
---@param self GOAL 
---@return number #The total number of contributions. 0 is returned if there were no contributions (yet).
function GOAL:GetTotalContributions() end

---Validates if the goal is achieved.
---
------
---@param self GOAL 
---@return boolean #true if the goal is achieved.
function GOAL:IsAchieved() end

---GOAL Constructor.
---
------
---@param self GOAL 
---@return GOAL #
function GOAL:New() end

---Achieved Handler OnAfter for GOAL
---
------
---@param self GOAL 
---@param From string 
---@param Event string 
---@param To string 
function GOAL:OnAfterAchieved(From, Event, To) end

---Achieved Handler OnBefore for GOAL
---
------
---@param self GOAL 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function GOAL:OnBeforeAchieved(From, Event, To) end

---Achieved State Handler OnEnter for GOAL
---
------
---@param self GOAL 
---@param From string 
---@param Event string 
---@param To string 
function GOAL:OnEnterAchieved(From, Event, To) end

---Achieved State Handler OnLeave for GOAL
---
------
---@param self GOAL 
---@param From string 
---@param Event string 
---@param To string 
---@return boolean #
function GOAL:OnLeaveAchieved(From, Event, To) end

---Achieved Asynchronous Trigger for GOAL
---
------
---@param self GOAL 
---@param Delay number 
function GOAL:__Achieved(Delay) end



