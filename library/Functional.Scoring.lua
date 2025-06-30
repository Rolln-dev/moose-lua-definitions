---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Scoring.JPG" width="100%">
---
---**Functional** - Administer the scoring of player achievements, file and log the scoring events for use at websites.
---
---===
---
---## Features:
---
---  * Set the scoring scales based on threat level.
---  * Positive scores and negative scores.
---  * A contribution model to score achievements.
---  * Score goals.
---  * Score specific achievements.
---  * Score the hits and destroys of units.
---  * Score the hits and destroys of statics.
---  * Score the hits and destroys of scenery.
---  * (optional) Log scores into a CSV file.
---  * Connect to a remote server using JSON and IP.
---
---===
---
---## Missions:
---
---[SCO - Scoring](https://github.com/FlightControl-Master/MOOSE_MISSIONS/tree/master/Functional/Scoring)
---
---===
---
---Administers the scoring of player achievements,
---and creates a CSV file logging the scoring events and results for use at team or squadron websites.
---
---SCORING automatically calculates the threat level of the objects hit and destroyed by players,
---which can be Wrapper.Unit, Wrapper.Static) and @{Scenery objects.
---
---Positive score points are granted when enemy or neutral targets are destroyed.
---Negative score points or penalties are given when a friendly target is hit or destroyed.
---This brings a lot of dynamism in the scoring, where players need to take care to inflict damage on the right target.
---By default, penalties weight heavier in the scoring, to ensure that players don't commit fratricide.
---The total score of the player is calculated by **adding the scores minus the penalties**.
---
---![Banner Image](..\Presentations\SCORING\Dia4.JPG)
---
---The score value is calculated based on the **threat level of the player** and the **threat level of the target**.
---A calculated score takes the threat level of the target divided by a balanced threat level of the player unit.
---As such, if the threat level of the target is high, and the player threat level is low, a higher score will be given than
---if the threat level of the player would be high too.
---
---![Banner Image](..\Presentations\SCORING\Dia5.JPG)
---
---When multiple players hit the same target, and finally succeed in destroying the target, then each player who contributed to the target
---destruction, will receive a score. This is important for targets that require significant damage before it can be destroyed, like
---ships or heavy planes.
---
---![Banner Image](..\Presentations\SCORING\Dia13.JPG)
---
---Optionally, the score values can be **scaled** by a **scale**. Specific scales can be set for positive cores or negative penalties.
---The default range of the scores granted is a value between 0 and 10. The default range of penalties given is a value between 0 and 30.
---
---![Banner Image](..\Presentations\SCORING\Dia7.JPG)
---
---**Additional scores** can be granted to **specific objects**, when the player(s) destroy these objects.
---
---![Banner Image](..\Presentations\SCORING\Dia9.JPG)
---
---Various Core.Zones can be defined for which scores are also granted when objects in that Core.Zone are destroyed.
---This is **specifically useful** to designate **scenery targets on the map** that will generate points when destroyed.
---
---With a small change in MissionScripting.lua, the scoring results can also be logged in a **CSV file**.
---These CSV files can be used to:
---
---  * Upload scoring to a database or a BI tool to publish the scoring results to the player community.
---  * Upload scoring in an (online) Excel like tool, using pivot tables and pivot charts to show mission results.
---  * Share scoring among players after the mission to discuss mission results.
---
---Scores can be **reported**. **Menu options** are automatically added to **each player group** when a player joins a client slot or a CA unit.
---Use the radio menu F10 to consult the scores while running the mission.
---Scores can be reported for your user, or an overall score can be reported of all players currently active in the mission.
---
---===
---
---### Authors: **FlightControl**
---
---### Contributions:
--- 
---  * **Applevangelist**: Additional functionality, fixes.
---  * **Wingthor (TAW)**: Testing & Advice.
---  * **Dutch-Baron (TAW)**: Testing & Advice.
---  * **Whisper**: Testing and Advice.
---
---===
---SCORING class
---
---# Constructor:
---
---     local Scoring = SCORING:New( "Scoring File" )
---
---# Set the destroy score or penalty scale:
---
---Score scales can be set for scores granted when enemies or friendlies are destroyed.
---Use the method #SCORING.SetScaleDestroyScore() to set the scale of enemy destroys (positive destroys).
---Use the method #SCORING.SetScaleDestroyPenalty() to set the scale of friendly destroys (negative destroys).
---
---     local Scoring = SCORING:New( "Scoring File" )
---     Scoring:SetScaleDestroyScore( 10 )
---     Scoring:SetScaleDestroyPenalty( 40 )
---
---The above sets the scale for valid scores to 10. So scores will be given in a scale from 0 to 10.
---The penalties will be given in a scale from 0 to 40.
---
---# Define special targets that will give extra scores:
---
---Special targets can be set that will give extra scores to the players when these are destroyed.
---Use the methods #SCORING.AddUnitScore() and #SCORING.RemoveUnitScore() to specify a special additional score for a specific Wrapper.Units.
---Use the methods #SCORING.AddStaticScore() and #SCORING.RemoveStaticScore() to specify a special additional score for a specific Wrapper.Statics.
---Use the method #SCORING.AddScoreSetGroup() to specify a special additional score for a specific Wrapper.Groups gathered in a Core.Set#SET_GROUP.
---
---     local Scoring = SCORING:New( "Scoring File" )
---     Scoring:AddUnitScore( UNIT:FindByName( "Unit #001" ), 200 )
---     Scoring:AddStaticScore( STATIC:FindByName( "Static #1" ), 100 )
---     local GroupSet = SET_GROUP:New():FilterPrefixes("RAT"):FilterStart()
---     Scoring:AddScoreSetGroup( GroupSet, 100)
---
---The above grants an additional score of 200 points for Unit #001 and an additional 100 points of Static #1 if these are destroyed.
---Note that later in the mission, one can remove these scores set, for example, when the a goal achievement time limit is over.
---For example, this can be done as follows:
---
---     Scoring:RemoveUnitScore( UNIT:FindByName( "Unit #001" ) )
---
---# Define destruction zones that will give extra scores:
---
---Define zones of destruction. Any object destroyed within the zone of the given category will give extra points.
---Use the method #SCORING.AddZoneScore() to add a Core.Zone for additional scoring.
---Use the method #SCORING.RemoveZoneScore() to remove a Core.Zone for additional scoring.
---There are interesting variations that can be achieved with this functionality. For example, if the Core.Zone is a Core.Zone#ZONE_UNIT,
---then the zone is a moving zone, and anything destroyed within that Core.Zone will generate points.
---The other implementation could be to designate a scenery target (a building) in the mission editor surrounded by a Core.Zone,
---just large enough around that building.
---
---# Add extra Goal scores upon an event or a condition:
---
---A mission has goals and achievements. The scoring system provides an API to set additional scores when a goal or achievement event happens.
---Use the method #SCORING.AddGoalScore() to add a score for a Player at any time in your mission.
---
---# (Decommissioned) Configure fratricide level.
---
---**This functionality is decommissioned until the DCS bug concerning Unit:destroy() not being functional in multi player for player units has been fixed by ED**.
---
---When a player commits too much damage to friendlies, his penalty score will reach a certain level.
---Use the method #SCORING.SetFratricide() to define the level when a player gets kicked.
---By default, the fratricide level is the default penalty multiplier * 2 for the penalty score.
---
---# Penalty score when a player changes the coalition.
---
---When a player changes the coalition, he can receive a penalty score.
---Use the method #SCORING.SetCoalitionChangePenalty() to define the penalty when a player changes coalition.
---By default, the penalty for changing coalition is the default penalty scale.
---
---# Define output CSV files.
---
---The CSV file is given the name of the string given in the #SCORING.New{} constructor, followed by the .csv extension.
---The file is incrementally saved in the **<User>\\Saved Games\\DCS\\Logs** folder, and has a time stamp indicating each mission run.
---See the following example:
---
---    local ScoringFirstMission = SCORING:New( "FirstMission" )
---    local ScoringSecondMission = SCORING:New( "SecondMission" )
---
---The above documents that 2 Scoring objects are created, ScoringFirstMission and ScoringSecondMission. 
---
---### **IMPORTANT!!!*
---In order to allow DCS world to write CSV files, you need to adapt a configuration file in your DCS world installation **on the server**.
---For this, browse to the **missionscripting.lua** file in your DCS world installation folder.
---For me, this installation folder is in _D:\\Program Files\\Eagle Dynamics\\DCS World\Scripts_.
---
---Edit a few code lines in the MissionScripting.lua file. Comment out the lines **os**, **io** and **lfs**:
---
---       do
---         --sanitizeModule('os')
---         --sanitizeModule('io')
---         --sanitizeModule('lfs')
---         require = nil
---         loadlib = nil
---       end
---
---When these lines are not sanitized, functions become available to check the time, and to write files to your system at the above specified location.
---Note that the MissionScripting.lua file provides a warning. So please beware of this warning as outlined by Eagle Dynamics!
---
---       --Sanitize Mission Scripting environment
---       --This makes unavailable some unsecure functions.
---       --Mission downloaded from server to client may contain potentially harmful lua code that may use these functions.
---       --You can remove the code below and make available these functions at your own risk.
---
---The MOOSE designer cannot take any responsibility of any damage inflicted as a result of the de-sanitization.
---That being said, I hope that the SCORING class provides you with a great add-on to score your squad mates achievements.
---
---# Configure messages.
---
---When players hit or destroy targets, messages are sent.
---Various methods exist to configure:
---
---  * Which messages are sent upon the event.
---  * Which audience receives the message.
---
---## Configure the messages sent upon the event.
---
---Use the following methods to configure when to send messages. By default, all messages are sent.
---
---  * #SCORING.SetMessagesHit(): Configure to send messages after a target has been hit.
---  * #SCORING.SetMessagesDestroy(): Configure to send messages after a target has been destroyed.
---  * #SCORING.SetMessagesAddon(): Configure to send messages for additional score, after a target has been destroyed.
---  * #SCORING.SetMessagesZone(): Configure to send messages for additional score, after a target has been destroyed within a given zone.
---
---## Configure the audience of the messages.
---
---Use the following methods to configure the audience of the messages. By default, the messages are sent to all players in the mission.
---
---  * #SCORING.SetMessagesToAll(): Configure to send messages to all players.
---  * #SCORING.SetMessagesToCoalition(): Configure to send messages to only those players within the same coalition as the player.
---
---===
---@class SCORING : BASE
---@field AutoSavePath  
---@field CoalitionChangePenalty  
---@field Fratricide  
---@field GameName  
---@field MessagesAudience number 
---@field MessagesDestroy  
---@field MessagesHit  
---@field MessagesScore  
---@field MessagesZone  
---@field RunTime  
---@field ScaleDestroyPenalty  
---@field ScaleDestroyScore  
---@field ScoreIncrementOnHit  
---@field ScoringCSV  
---@field ScoringPlayerScan  
---@field penaltyoncoalitionchange boolean 
---@field penaltyonfratricide boolean 
SCORING = {}

---Add a goal score for a player.
---The method takes the PlayerUnit for which the Goal score needs to be set.
---The GoalTag is a string or identifier that is taken into the CSV file scoring log to identify the goal.
---A free text can be given that is shown to the players.
---The Score can be both positive and negative.
---
------
---@param self SCORING 
---@param PlayerUnit UNIT The @{Wrapper.Unit} of the Player. Other Properties for the scoring are taken from this PlayerUnit, like coalition, type etc.
---@param GoalTag string The string or identifier that is used in the CSV file to identify the goal (sort or group later in Excel).
---@param Text string A free text that is shown to the players.
---@param Score number The score can be both positive or negative ( Penalty ).
function SCORING:AddGoalScore(PlayerUnit, GoalTag, Text, Score) end

---Add a goal score for a player.
---The method takes the Player name for which the Goal score needs to be set.
---The GoalTag is a string or identifier that is taken into the CSV file scoring log to identify the goal.
---A free text can be given that is shown to the players.
---The Score can be both positive and negative.
---
------
---@param self SCORING 
---@param PlayerName string The name of the Player.
---@param GoalTag string The string or identifier that is used in the CSV file to identify the goal (sort or group later in Excel).
---@param Text string A free text that is shown to the players.
---@param Score number The score can be both positive or negative ( Penalty ).
function SCORING:AddGoalScorePlayer(PlayerName, GoalTag, Text, Score) end

---Specify a special additional score for a Wrapper.Group.
---
------
---@param self SCORING 
---@param ScoreGroup GROUP The @{Wrapper.Group} for which each @{Wrapper.Unit} a Score is given.
---@param Score number The Score value.
---@return SCORING #
function SCORING:AddScoreGroup(ScoreGroup, Score) end

---Specify a special additional score for a Core.Set#SET_GROUP.
---
------
---@param self SCORING 
---@param Set SET_GROUP The @{Core.Set#SET_GROUP} for which each @{Wrapper.Unit} in each Group a Score is given.
---@param Score number The Score value.
---@return SCORING #
function SCORING:AddScoreSetGroup(Set, Score) end

---Add a Wrapper.Static for additional scoring when the Wrapper.Static is destroyed.
---Note that if there was already a Wrapper.Static declared within the scoring with the same name,
---then the old Wrapper.Static  will be replaced with the new Wrapper.Static.
---
------
---@param self SCORING 
---@param ScoreStatic UNIT The @{Wrapper.Static} for which the Score needs to be given.
---@param Score number The Score value.
---@return SCORING #
function SCORING:AddStaticScore(ScoreStatic, Score) end

---Add a Wrapper.Unit for additional scoring when the Wrapper.Unit is destroyed.
---Note that if there was already a Wrapper.Unit declared within the scoring with the same name,
---then the old Wrapper.Unit  will be replaced with the new Wrapper.Unit.
---
------
---@param self SCORING 
---@param ScoreUnit UNIT The @{Wrapper.Unit} for which the Score needs to be given.
---@param Score number The Score value.
---@return SCORING #
function SCORING:AddUnitScore(ScoreUnit, Score) end

---Add a Core.Zone to define additional scoring when any object is destroyed in that zone.
---Note that if a Core.Zone with the same name is already within the scoring added, the Core.Zone (type) and Score will be replaced!
---This allows for a dynamic destruction zone evolution within your mission.
---
------
---@param self SCORING 
---@param ScoreZone ZONE_BASE The @{Core.Zone} which defines the destruction score perimeters. Note that a zone can be a polygon or a moving zone.
---@param Score number The Score value.
---@return SCORING #
function SCORING:AddZoneScore(ScoreZone, Score) end

---Close CSV file
---
------
---@param self SCORING 
---@return SCORING #self
function SCORING:CloseCSV() end

---If to send messages after a target has been destroyed.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesDestroy() end

---If to send messages after a target has been hit.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesHit() end

---If to send messages after a target has been destroyed and receives additional scores.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesScore() end

---If to send messages to all players.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesToAll() end

---If to send messages to only those players within the same coalition as the player.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesToCoalition() end

---If to send messages after a target has been hit in a zone, and additional score is received.
---
------
---@param self SCORING 
---@return boolean #
function SCORING:IfMessagesZone() end

---Creates a new SCORING object to administer the scoring achieved by players.
---
------
---
---USAGE
---```
---
---  -- Define a new scoring object for the mission Gori Valley.
---  ScoringObject = SCORING:New( "Gori Valley" )
---```
------
---@param self SCORING 
---@param GameName string The name of the game. This name is also logged in the CSV score file.
---@param SavePath string (Optional) Path where to save the CSV file, defaults to your **<User>\\Saved Games\\DCS\\Logs** folder.
---@param AutoSave boolean (Optional) If passed as `false`, then swith autosave off.
---@return SCORING #self
function SCORING:New(GameName, SavePath, AutoSave) end

---Handles the OnBirth event for the scoring.
---
------
---@param self SCORING 
---@param Event EVENTDATA 
function SCORING:OnEventBirth(Event) end

---Handles the OnPlayerLeaveUnit event for the scoring.
---
------
---@param self SCORING 
---@param Event EVENTDATA 
function SCORING:OnEventPlayerLeaveUnit(Event) end

---Handles the event when one player kill another player
---
------
---@param self SCORING 
---@param PlayerName string The attacking player
---@param TargetUnitName string the name of the killed unit
---@param IsTeamKill boolean true if this kill was a team kill
---@param TargetThreatLevel number Threat level of the target
---@param PlayerThreatLevel number Threat level of the player
---@param Score number The score based on both threat levels
function SCORING:OnKillPvE(PlayerName, TargetUnitName, IsTeamKill, TargetThreatLevel, PlayerThreatLevel, Score) end

---Handles the event when one player kill another player
---
------
---@param self SCORING 
---@param PlayerName string The attacking player
---@param TargetPlayerName string The name of the killed player
---@param IsTeamKill boolean true if this kill was a team kill
---@param TargetThreatLevel number Threat level of the target
---@param PlayerThreatLevel number Threat level of the player
---@param Score number The score based on both threat levels
function SCORING:OnKillPvP(PlayerName, TargetPlayerName, IsTeamKill, TargetThreatLevel, PlayerThreatLevel, Score) end

---Opens a score CSV file to log the scores.
---
------
---
---USAGE
---```
----- Open a new CSV file to log the scores of the game Gori Valley. Let the name of the CSV file begin with "Player Scores".
---ScoringObject = SCORING:New( "Gori Valley" )
---ScoringObject:OpenCSV( "Player Scores" )
---```
------
---@param self SCORING 
---@param ScoringCSV string 
---@return SCORING #self
function SCORING:OpenCSV(ScoringCSV) end

---Removes a Wrapper.Static for additional scoring when the Wrapper.Static is destroyed.
---
------
---@param self SCORING 
---@param ScoreStatic UNIT The @{Wrapper.Static} for which the Score needs to be given.
---@return SCORING #
function SCORING:RemoveStaticScore(ScoreStatic) end

---Removes a Wrapper.Unit for additional scoring when the Wrapper.Unit is destroyed.
---
------
---@param self SCORING 
---@param ScoreUnit UNIT The @{Wrapper.Unit} for which the Score needs to be given.
---@return SCORING #
function SCORING:RemoveUnitScore(ScoreUnit) end

---Remove a Core.Zone for additional scoring.
---The scoring will search if any Core.Zone is added with the given name, and will remove that zone from the scoring.
---This allows for a dynamic destruction zone evolution within your mission.
---
------
---@param self SCORING 
---@param ScoreZone ZONE_BASE The @{Core.Zone} which defines the destruction score perimeters. Note that a zone can be a polygon or a moving zone.
---@return SCORING #
function SCORING:RemoveZoneScore(ScoreZone) end

---Produce detailed report of player penalty scores because of changing the coalition.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@return string #The report.
function SCORING:ReportDetailedPlayerCoalitionChanges(PlayerName) end

---Produce detailed report of player destroy scores.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@return string #The report.
function SCORING:ReportDetailedPlayerDestroys(PlayerName) end

---Produce detailed report of player goal scores.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@return string #The report.
function SCORING:ReportDetailedPlayerGoals(PlayerName) end

---Produce detailed report of player hit scores.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@return string #The report.
function SCORING:ReportDetailedPlayerHits(PlayerName) end

---Produce detailed report of player penalty scores because of changing the coalition.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@return string #The report.
function SCORING:ReportDetailedPlayerMissions(PlayerName) end

---Report all players score
---
------
---@param self SCORING 
---@param PlayerGroup GROUP The player group.
function SCORING:ReportScoreAllSummary(PlayerGroup) end

---Report Group Score Detailed
---
------
---@param self SCORING 
---@param PlayerGroup GROUP The player group.
function SCORING:ReportScoreGroupDetailed(PlayerGroup) end

---Report Group Score Summary
---
------
---@param self SCORING 
---@param PlayerGroup GROUP The player group.
function SCORING:ReportScoreGroupSummary(PlayerGroup) end

---Registers a score for a player.
---
------
---@param self SCORING 
---@param PlayerName string The name of the player.
---@param TargetPlayerName string The name of the target player.
---@param ScoreType string The type of the score.
---@param ScoreTimes string The amount of scores achieved.
---@param ScoreAmount string The score given.
---@param PlayerUnitName string The unit name of the player.
---@param PlayerUnitCoalition string The coalition of the player unit.
---@param PlayerUnitCategory string The category of the player unit.
---@param PlayerUnitType string The type of the player unit.
---@param TargetUnitName string The name of the target unit.
---@param TargetUnitCoalition string The coalition of the target unit.
---@param TargetUnitCategory string The category of the target unit.
---@param TargetUnitType string The type of the target unit.
---@return SCORING #self
function SCORING:ScoreCSV(PlayerName, TargetPlayerName, ScoreType, ScoreTimes, ScoreAmount, PlayerUnitName, PlayerUnitCoalition, PlayerUnitCategory, PlayerUnitType, TargetUnitName, TargetUnitCoalition, TargetUnitCategory, TargetUnitType) end


---
------
---@param self NOTYPE 
---@param sSeconds NOTYPE 
function SCORING:SecondsToClock(sSeconds) end

---When a player changes the coalition, he can receive a penalty score.
---Use the method #SCORING.SetCoalitionChangePenalty() to define the penalty when a player changes coalition.
---By default, the penalty for changing coalition is the default penalty scale.
---
------
---@param self SCORING 
---@param CoalitionChangePenalty number The amount of penalty that is given.
---@return SCORING #
function SCORING:SetCoalitionChangePenalty(CoalitionChangePenalty) end

---Set a prefix string that will be displayed at each scoring message sent.
---
------
---@param self SCORING 
---@param DisplayMessagePrefix string (Default="Scoring: ") The scoring prefix string.
---@return SCORING #
function SCORING:SetDisplayMessagePrefix(DisplayMessagePrefix) end

---When a player commits too much damage to friendlies, his penalty score will reach a certain level.
---Use this method to define the level when a player gets kicked.
---By default, the fratricide level is the default penalty multiplier * 2 for the penalty score.
---
------
---@param self SCORING 
---@param Fratricide number The amount of maximum penalty that may be inflicted by a friendly player before he gets kicked. 
---@return SCORING #
function SCORING:SetFratricide(Fratricide) end

---Configure to send messages after a target has been destroyed.
---
------
---@param self SCORING 
---@param OnOff boolean If true is given, the messages are sent.
---@return SCORING #
function SCORING:SetMessagesDestroy(OnOff) end

---Configure to send messages after a target has been hit.
---
------
---@param self SCORING 
---@param OnOff boolean If true is given, the messages are sent.
---@return SCORING #
function SCORING:SetMessagesHit(OnOff) end

---Configure to send messages after a target has been destroyed and receives additional scores.
---
------
---@param self SCORING 
---@param OnOff boolean If true is given, the messages are sent.
---@return SCORING #
function SCORING:SetMessagesScore(OnOff) end

---Configure to send messages to all players.
---
------
---@param self SCORING 
---@return SCORING #
function SCORING:SetMessagesToAll() end

---Configure to send messages to only those players within the same coalition as the player.
---
------
---@param self SCORING 
---@return SCORING #
function SCORING:SetMessagesToCoalition() end

---Configure to send messages after a target has been hit in a zone, and additional score is received.
---
------
---@param self SCORING 
---@param OnOff boolean If true is given, the messages are sent.
---@return SCORING #
function SCORING:SetMessagesZone(OnOff) end

---Set the scale for scoring penalty destroys (friendly destroys).
---A default calculated penalty is a value between 1 and 10.
---The scale magnifies the scores given to the players.
---
------
---@param self SCORING 
---@param Scale number The scale of the score given.
---@return SCORING #
function SCORING:SetScaleDestroyPenalty(Scale) end

---Set the scale for scoring valid destroys (enemy destroys).
---A default calculated score is a value between 1 and 10.
---The scale magnifies the scores given to the players.
---
------
---@param self SCORING 
---@param Scale number The scale of the score given.
function SCORING:SetScaleDestroyScore(Scale) end

---Configure to increment score after a target has been hit.
---
------
---@param self SCORING 
---@param score number  amount of point to inclement score on each hit
---@return SCORING #
function SCORING:SetScoreIncrementOnHit(score) end

---Sets the scoring menu.
---
------
---@param self SCORING 
---@param ScoringGroup NOTYPE 
---@return SCORING #
function SCORING:SetScoringMenu(ScoringGroup) end

---Registers a score for a player.
---
------
---@param self SCORING 
---@param OnOff boolean Switch saving to CSV on = true or off = false
---@return SCORING #self
function SCORING:SwitchAutoSave(OnOff) end

---Decide if fratricide is leading to penalties (true) or not (false)
---
------
---@param self SCORING 
---@param OnOff boolean Switch for Fratricide
---@return SCORING #
function SCORING:SwitchFratricide(OnOff) end

---Decide if a change of coalition is leading to penalties (true) or not (false)
---
------
---@param self SCORING 
---@param OnOff boolean Switch for Coalition Changes.
---@return SCORING #
function SCORING:SwitchTreason(OnOff) end

---Registers Scores the players completing a Mission Task.
---
------
---@param self SCORING 
---@param Mission MISSION 
---@param PlayerName string 
---@param Text string 
---@param Score number 
function SCORING:_AddMissionGoalScore(Mission, PlayerName, Text, Score) end

---Registers Mission Scores for possible multiple players that contributed in the Mission.
---
------
---@param self SCORING 
---@param Mission MISSION 
---@param PlayerUnit UNIT 
---@param Text string 
---@param Score number 
function SCORING:_AddMissionScore(Mission, PlayerUnit, Text, Score) end

---Registers Scores the players completing a Mission Task.
---
------
---@param self SCORING 
---@param Mission MISSION 
---@param PlayerUnit UNIT 
---@param Text string 
---@param Score number 
function SCORING:_AddMissionTaskScore(Mission, PlayerUnit, Text, Score) end

---Add a new player entering a Unit.
---
------
---@param self SCORING 
---@param UnitData UNIT 
function SCORING:_AddPlayerFromUnit(UnitData) end

---Track  DEAD or CRASH events for the scoring.
---
------
---@param self SCORING 
---@param Event EVENTDATA 
function SCORING:_EventOnDeadOrCrash(Event) end

---Handles the OnHit event for the scoring.
---
------
---@param self SCORING 
---@param Event EVENTDATA 
function SCORING:_EventOnHit(Event) end



