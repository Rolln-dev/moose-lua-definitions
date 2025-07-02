---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Menu.JPG" width="100%">
---
---**Core** - Manage hierarchical menu structures and commands for players within a mission.
---
---===
---
---## Features:
---
---  * Setup mission sub menus.
---  * Setup mission command menus.
---  * Setup coalition sub menus.
---  * Setup coalition command menus.
---  * Setup group sub menus.
---  * Setup group command menus.
---  * Manage menu creation intelligently, avoid double menu creation.
---  * Only create or delete menus when required, and keep existing menus persistent.
---  * Update menu structures.
---  * Refresh menu structures intelligently, based on a time stamp of updates.
---    - Delete obsolete menus.
---    - Create new one where required.
---    - Don't touch the existing ones.
---  * Provide a variable amount of parameters to menus.
---  * Update the parameters and the receiving methods, without updating the menu within DCS!
---  * Provide a great performance boost in menu management.
---  * Provide a great tool to manage menus in your code.
---
---DCS Menus can be managed using the MENU classes.
---The advantage of using MENU classes is that it hides the complexity of dealing with menu management in more advanced scenarios where you need to
---set menus and later remove them, and later set them again. You'll find while using use normal DCS scripting functions, that setting and removing
---menus is not a easy feat if you have complex menu hierarchies defined.
---Using the MOOSE menu classes, the removal and refreshing of menus are nicely being handled within these classes, and becomes much more easy.
---On top, MOOSE implements **variable parameter** passing for command menus.
---
---There are basically two different MENU class types that you need to use:
---
---### To manage **main menus**, the classes begin with **MENU_**:
---
---  * Core.Menu#MENU_MISSION: Manages main menus for whole mission file.
---  * Core.Menu#MENU_COALITION: Manages main menus for whole coalition.
---  * Core.Menu#MENU_GROUP: Manages main menus for GROUPs.
---
---### To manage **command menus**, which are menus that allow the player to issue **functions**, the classes begin with **MENU_COMMAND_**:
---
---  * Core.Menu#MENU_MISSION_COMMAND: Manages command menus for whole mission file.
---  * Core.Menu#MENU_COALITION_COMMAND: Manages command menus for whole coalition.
---  * Core.Menu#MENU_GROUP_COMMAND: Manages command menus for GROUPs.
---
---===
---
---### [Demo Missions](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Core/Menu)
---
---===
---
---### Author: **FlightControl**
---### Contributions:
---
---===
---@class MENU_BASE 
---@field MenuRemoveParent NOTYPE 
---@field MenuStamp NOTYPE 
---@field MenuTag NOTYPE 
MENU_BASE = {}


---Manages the main menus for DCS.coalition.
---
---You can add menus with the #MENU_COALITION.New method, which constructs a MENU_COALITION object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_COALITION.Remove.
---MENU_COALITION
---@class MENU_COALITION : MENU_BASE
MENU_COALITION = {}

---MENU_COALITION constructor.
---Creates a new MENU_COALITION object and creates the menu for a complete coalition.
---
------
---@param Coalition coalition.side The coalition owning the menu.
---@param MenuText string The text for the menu.
---@param ParentMenu table The parent menu. This parameter can be ignored if you want the menu to be located at the parent menu of DCS world (under F10 other).
---@return MENU_COALITION #self
function MENU_COALITION:New(Coalition, MenuText, ParentMenu) end

---Refreshes a radio item for a coalition
---
------
---@return MENU_COALITION #
function MENU_COALITION:Refresh() end

---Removes the main menu and the sub menus recursively of this MENU_COALITION.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE 
---@return nil #
function MENU_COALITION:Remove(MenuStamp, MenuTag) end

---Removes the sub menus recursively of this MENU_COALITION.
---Note that the main menu is kept!
---
------
---@return MENU_COALITION #
function MENU_COALITION:RemoveSubMenus() end


---Manages the command menus for coalitions, which allow players to execute functions during mission execution.
---
---You can add menus with the #MENU_COALITION_COMMAND.New method, which constructs a MENU_COALITION_COMMAND object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_COALITION_COMMAND.Remove.
---MENU_COALITION_COMMAND
---@class MENU_COALITION_COMMAND : MENU_COMMAND_BASE
MENU_COALITION_COMMAND = {}

---MENU_COALITION constructor.
---Creates a new radio command item for a coalition, which can invoke a function with parameters.
---
------
---@param Coalition coalition.side The coalition owning the menu.
---@param MenuText string The text for the menu.
---@param ParentMenu MENU_COALITION The parent menu.
---@param CommandMenuFunction NOTYPE A function that is called when the menu key is pressed.
---@param CommandMenuArgument NOTYPE An argument for the function. There can only be ONE argument given. So multiple arguments must be wrapped into a table. See the below example how to do this.
---@param ... NOTYPE 
---@return MENU_COALITION_COMMAND #
function MENU_COALITION_COMMAND:New(Coalition, MenuText, ParentMenu, CommandMenuFunction, CommandMenuArgument, ...) end

---Refreshes a radio item for a coalition
---
------
---@return MENU_COALITION_COMMAND #
function MENU_COALITION_COMMAND:Refresh() end

---Removes a radio command item for a coalition
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE 
---@return nil #
function MENU_COALITION_COMMAND:Remove(MenuStamp, MenuTag) end


---Defines the main MENU class where other MENU COMMAND_
---classes are derived from, in order to set commands.
---MENU_COMMAND_BASE
---@class MENU_COMMAND_BASE : MENU_BASE
---@field MenuCallHandler function 
MENU_COMMAND_BASE = {}

---Constructor
---
------
---@param MenuText NOTYPE 
---@param ParentMenu NOTYPE 
---@param CommandMenuFunction NOTYPE 
---@param CommandMenuArguments NOTYPE 
---@return MENU_COMMAND_BASE #
function MENU_COMMAND_BASE:New(MenuText, ParentMenu, CommandMenuFunction, CommandMenuArguments) end

---This sets the new command arguments of a menu,
---so that if a menu is regenerated, or if command arguments change,
---that the arguments set for the menu are loosely coupled with the menu itself!!!
---If the arguments change, no new menu needs to be generated if the menu text is the same!!!
---
------
---@param CommandMenuArguments NOTYPE 
---@return MENU_COMMAND_BASE #
function MENU_COMMAND_BASE:SetCommandMenuArguments(CommandMenuArguments) end

---This sets the new command function of a menu,
---so that if a menu is regenerated, or if command function changes,
---that the function set for the menu is loosely coupled with the menu itself!!!
---If the function changes, no new menu needs to be generated if the menu text is the same!!!
---
------
---@param CommandMenuFunction NOTYPE 
---@return MENU_COMMAND_BASE #
function MENU_COMMAND_BASE:SetCommandMenuFunction(CommandMenuFunction) end


---Manages the main menus for Wrapper.Groups.
---
---You can add menus with the #MENU_GROUP.New method, which constructs a MENU_GROUP object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_GROUP.Remove.
---@class MENU_GROUP : MENU_BASE
---@field Group NOTYPE 
---@field GroupID NOTYPE 
---@field MenuPath NOTYPE 
MENU_GROUP = {}

---MENU_GROUP constructor.
---Creates a new radio menu item for a group.
---
------
---@param Group GROUP The Group owning the menu.
---@param MenuText string The text for the menu.
---@param ParentMenu table The parent menu.
---@return MENU_GROUP #self
function MENU_GROUP:New(Group, MenuText, ParentMenu) end

---Refreshes a new radio item for a group and submenus
---
------
---@return MENU_GROUP #
function MENU_GROUP:Refresh() end

---Refreshes a new radio item for a group and submenus, ordering by (numerical) MenuTag
---
------
---@return MENU_GROUP #
function MENU_GROUP:RefreshAndOrderByTag() end

---Removes the main menu and sub menus recursively of this MENU_GROUP.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return nil #
function MENU_GROUP:Remove(MenuStamp, MenuTag) end

---Removes the sub menus recursively of this MENU_GROUP.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return MENU_GROUP #self
function MENU_GROUP:RemoveSubMenus(MenuStamp, MenuTag) end


---The Core.Menu#MENU_GROUP_COMMAND class manages the command menus for coalitions, which allow players to execute functions during mission execution.
---You can add menus with the #MENU_GROUP_COMMAND.New method, which constructs a MENU_GROUP_COMMAND object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_GROUP_COMMAND.Remove.
---@class MENU_GROUP_COMMAND : MENU_COMMAND_BASE
---@field Group NOTYPE 
---@field GroupID NOTYPE 
---@field MenuPath NOTYPE 
MENU_GROUP_COMMAND = {}

---Creates a new radio command item for a group
---
------
---@param Group GROUP The Group owning the menu.
---@param MenuText NOTYPE The text for the menu.
---@param ParentMenu NOTYPE The parent menu.
---@param CommandMenuFunction NOTYPE A function that is called when the menu key is pressed.
---@param CommandMenuArgument NOTYPE An argument for the function.
---@param ... NOTYPE 
---@return MENU_GROUP_COMMAND #
function MENU_GROUP_COMMAND:New(Group, MenuText, ParentMenu, CommandMenuFunction, CommandMenuArgument, ...) end

---Refreshes a radio item for a group
---
------
---@return MENU_GROUP_COMMAND #
function MENU_GROUP_COMMAND:Refresh() end

---Removes a menu structure for a group.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return nil #
function MENU_GROUP_COMMAND:Remove(MenuStamp, MenuTag) end


---Manages the command menus for coalitions, which allow players to execute functions during mission execution.
---
---You can add menus with the #MENU_GROUP_COMMAND_DELAYED.New method, which constructs a MENU_GROUP_COMMAND_DELAYED object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_GROUP_COMMAND_DELAYED.Remove.
---@class MENU_GROUP_COMMAND_DELAYED : MENU_COMMAND_BASE
---@field Group NOTYPE 
---@field GroupID NOTYPE 
---@field MenuPath NOTYPE 
---@field MenuSet boolean 
MENU_GROUP_COMMAND_DELAYED = {}

---Creates a new radio command item for a group
---
------
---@param Group GROUP The Group owning the menu.
---@param MenuText NOTYPE The text for the menu.
---@param ParentMenu NOTYPE The parent menu.
---@param CommandMenuFunction NOTYPE A function that is called when the menu key is pressed.
---@param CommandMenuArgument NOTYPE An argument for the function.
---@param ... NOTYPE 
---@return MENU_GROUP_COMMAND_DELAYED #
function MENU_GROUP_COMMAND_DELAYED:New(Group, MenuText, ParentMenu, CommandMenuFunction, CommandMenuArgument, ...) end

---Refreshes a radio item for a group
---
------
---@return MENU_GROUP_COMMAND_DELAYED #
function MENU_GROUP_COMMAND_DELAYED:Refresh() end

---Removes a menu structure for a group.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return nil #
function MENU_GROUP_COMMAND_DELAYED:Remove(MenuStamp, MenuTag) end

---Refreshes a radio item for a group
---
------
---@return MENU_GROUP_COMMAND_DELAYED #
function MENU_GROUP_COMMAND_DELAYED:Set() end


---The MENU_GROUP_DELAYED class manages the main menus for groups.
---You can add menus with the #MENU_GROUP.New method, which constructs a MENU_GROUP object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_GROUP.Remove.
---The creation of the menu item is delayed however, and must be created using the #MENU_GROUP.Set method.
---This method is most of the time called after the "old" menu items have been removed from the sub menu.
---@class MENU_GROUP_DELAYED : MENU_BASE
---@field Group NOTYPE 
---@field GroupID NOTYPE 
---@field MenuPath NOTYPE 
---@field MenuSet boolean 
MENU_GROUP_DELAYED = {}

---MENU_GROUP_DELAYED constructor.
---Creates a new radio menu item for a group.
---
------
---@param Group GROUP The Group owning the menu.
---@param MenuText string The text for the menu.
---@param ParentMenu table The parent menu.
---@return MENU_GROUP_DELAYED #self
function MENU_GROUP_DELAYED:New(Group, MenuText, ParentMenu) end

---Refreshes a new radio item for a group and submenus
---
------
---@return MENU_GROUP_DELAYED #
function MENU_GROUP_DELAYED:Refresh() end

---Removes the main menu and sub menus recursively of this MENU_GROUP.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return nil #
function MENU_GROUP_DELAYED:Remove(MenuStamp, MenuTag) end

---Removes the sub menus recursively of this MENU_GROUP_DELAYED.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE A Tag or Key to filter the menus to be refreshed with the Tag set.
---@return MENU_GROUP_DELAYED #self
function MENU_GROUP_DELAYED:RemoveSubMenus(MenuStamp, MenuTag) end

---Refreshes a new radio item for a group and submenus
---
------
---@return MENU_GROUP_DELAYED #
function MENU_GROUP_DELAYED:Set() end


---MENU_MISSION
---@class MENU_MISSION : MENU_BASE
---@field ClassName string 
---@field MenuPath NOTYPE 
MENU_MISSION = {}

---MENU_MISSION constructor.
---Creates a new MENU_MISSION object and creates the menu for a complete mission file.
---
------
---@param MenuText string The text for the menu.
---@param ParentMenu table The parent menu. This parameter can be ignored if you want the menu to be located at the parent menu of DCS world (under F10 other).
---@return MENU_MISSION #
function MENU_MISSION:New(MenuText, ParentMenu) end

---Refreshes a radio item for a mission
---
------
---@return MENU_MISSION #
function MENU_MISSION:Refresh() end

---Removes the main menu and the sub menus recursively of this MENU_MISSION.
---
------
---@param MenuStamp NOTYPE 
---@param MenuTag NOTYPE 
---@return nil #
function MENU_MISSION:Remove(MenuStamp, MenuTag) end

---Removes the sub menus recursively of this MENU_MISSION.
---Note that the main menu is kept!
---
------
---@return MENU_MISSION #
function MENU_MISSION:RemoveSubMenus() end


---Manages the command menus for a complete mission, which allow players to execute functions during mission execution.
---
---You can add menus with the #MENU_MISSION_COMMAND.New method, which constructs a MENU_MISSION_COMMAND object and returns you the object reference.
---Using this object reference, you can then remove ALL the menus and submenus underlying automatically with #MENU_MISSION_COMMAND.Remove.
---@class MENU_MISSION_COMMAND : MENU_COMMAND_BASE
MENU_MISSION_COMMAND = {}

---MENU_MISSION constructor.
---Creates a new radio command item for a complete mission file, which can invoke a function with parameters.
---
------
---@param MenuText string The text for the menu.
---@param ParentMenu MENU_MISSION The parent menu.
---@param CommandMenuFunction NOTYPE A function that is called when the menu key is pressed.
---@param CommandMenuArgument NOTYPE An argument for the function. There can only be ONE argument given. So multiple arguments must be wrapped into a table. See the below example how to do this.
---@param ... NOTYPE 
---@return MENU_MISSION_COMMAND #self
function MENU_MISSION_COMMAND:New(MenuText, ParentMenu, CommandMenuFunction, CommandMenuArgument, ...) end

---Refreshes a radio item for a mission
---
------
---@return MENU_MISSION_COMMAND #
function MENU_MISSION_COMMAND:Refresh() end

---Removes a radio command item for a coalition
---
------
---@return nil #
function MENU_MISSION_COMMAND:Remove() end



