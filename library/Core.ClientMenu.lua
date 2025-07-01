---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Core_Menu.JPG" width="100%">
---
---**Core** - Client Menu Management.
---
---**Main Features:**
---
---   * For complex, non-static menu structures
---   * Lightweigt implementation as alternative to MENU
---   * Separation of menu tree creation from menu on the clients's side
---   * Works with a SET_CLIENT set of clients
---   * Allow manipulation of the shadow tree in various ways
---   * Push to all or only one client
---   * Change entries' menu text
---   * Option to make an entry usable once only across all clients
---   * Auto appends GROUP and CLIENT objects to menu calls
---
---===
---
---### Author: **applevangelist**
---
---===
---@class CLIENTMENU : BASE
---@field Children table 
---@field ClassName string Class Name
---@field Controller CLIENTMENUMANAGER 
---@field Function string 
---@field Functionargs table 
---@field Generic boolean 
---@field GroupID number Group ID
---@field ID number Entry ID
---@field Once boolean 
---@field Parent CLIENTMENU 
---@field UUID string Unique ID based on path+name
---@field private active boolean 
---@field private boolean active 
---@field private client CLIENT 
---@field private debug boolean 
---@field private group GROUP 
---@field private groupname string Group name
---@field private lid string Lid for log entries
---@field private name string Name
---@field private parentpath table 
---@field private path table 
---@field private version string Version string
CLIENTMENU = {}

---Link a child entry.
---
------
---@param self CLIENTMENU 
---@param Child CLIENTMENU The entry to link as a child.
---@return CLIENTMENU #self
function CLIENTMENU:AddChild(Child) end


---
------
function CLIENTMENU.CallHandler() end

---Remove this entry and all subentries (children) from this entry.
---
------
---@param self CLIENTMENU 
---@return CLIENTMENU #self
function CLIENTMENU:Clear() end

---Create a UUID
---
------
---@param self CLIENTMENU 
---@param Parent CLIENTMENU The parent object if any
---@param Text string The menu entry text
---@return string #UUID
function CLIENTMENU:CreateUUID(Parent, Text) end

---Get the menu path table.
---
------
---@param self CLIENTMENU 
---@return table #Path
function CLIENTMENU:GetPath() end

---Get the UUID.
---
------
---@param self CLIENTMENU 
---@return string #UUID
function CLIENTMENU:GetUUID() end

---Create an new CLIENTMENU object.
---
------
---@param self CLIENTMENU 
---@param Client CLIENT The client for whom this entry is. Leave as nil for a generic entry.
---@param Text string Text of the F10 menu entry.
---@param Parent CLIENTMENU The parent menu entry.
---@param Function? string (optional) Function to call when the entry is used.
---@param ...? NOTYPE (optional) Arguments for the Function, comma separated
---@return CLIENTMENU #self 
function CLIENTMENU:NewEntry(Client, Text, Parent, Function, ...) end

---Remove a child entry.
---
------
---@param self CLIENTMENU 
---@param Child CLIENTMENU The entry to remove from the children.
---@return CLIENTMENU #self
function CLIENTMENU:RemoveChild(Child) end

---Remove the entry from the F10 menu.
---
------
---@param self CLIENTMENU 
---@return CLIENTMENU #self 
function CLIENTMENU:RemoveF10() end

---Remove all subentries (children) from this entry.
---
------
---@param self CLIENTMENU 
---@return CLIENTMENU #self
function CLIENTMENU:RemoveSubEntries() end

---Set the CLIENTMENUMANAGER for this entry.
---
------
---@param self CLIENTMENU 
---@param Controller CLIENTMENUMANAGER The controlling object.
---@return CLIENTMENU #self 
function CLIENTMENU:SetController(Controller) end

---The entry will be deleted after being used used - for menu entries with functions only.
---
------
---@param self CLIENTMENU 
---@return CLIENTMENU #self 
function CLIENTMENU:SetOnce() end


---*As a child my family's menu consisted of two choices: take it, or leave it.*
---
---===
---
---## CLIENTMENU and CLIENTMENUMANAGER
---
---Manage menu structures for a SET_CLIENT of clients.
---
---## Concept
---
---Separate creation of a menu tree structure from pushing it to each client. Create a shadow "reference" menu structure tree for your client pilot's in a mission. 
---This can then be propagated to all clients. Manipulate the entries in the structure with removing, clearing or changing single entries, create replacement sub-structures 
---for entries etc, push to one or all clients.
---
---Many functions can either change the tree for one client or for all clients.
---
---## Conceptual remarks
---
---There's a couple of things to fully understand: 
---
---1) **CLIENTMENUMANAGER** manages a set of entries from **CLIENTMENU**, it's main purpose is to administer the *shadow menu tree*, ie. a menu structure which is not 
---(yet) visible to any client   
---2) The entries are **CLIENTMENU** objects, which are linked in a tree form. There's two ways to create them:   
---         A) in the manager with ":NewEntry()" which initially 
---             adds it to the shadow menu **only**   
---         B) stand-alone directly as `CLIENTMENU:NewEntry()` - here it depends on whether or not you gave a CLIENT object if the entry is created as generic entry or pushed 
---             a **specific** client. **Be aware** though that the entries are not managed by the CLIENTMANAGER before the next step!   
---A generic entry can be added to the manager (and the shadow tree) with `:AddEntry()` - this will also push it to all clients(!) if no client is given, or a specific client only.  
---3) Pushing only works for alive clients.   
---4) Live and shadow tree entries are managed via the CLIENTMENUMANAGER object.   
---5) `Propagate()`refreshes the menu tree for all, or a single client.   
---
---## Create a base reference tree and send to all clients
---
---           local clientset = SET_CLIENT:New():FilterStart()
---           
---           local menumgr = CLIENTMENUMANAGER:New(clientset,"Dayshift")
---           local mymenu = menumgr:NewEntry("Top")
---           local mymenu_lv1a = menumgr:NewEntry("Level 1 a",mymenu)
---           local mymenu_lv1b = menumgr:NewEntry("Level 1 b",mymenu)
---           -- next one is a command menu entry, which can only be used once
---           local mymenu_lv1c = menumgr:NewEntry("Action Level 1 c",mymenu, testfunction, "testtext"):SetOnce()
---           
---           local mymenu_lv2a = menumgr:NewEntry("Go here",mymenu_lv1a)
---           local mymenu_lv2b = menumgr:NewEntry("Level 2 ab",mymenu_lv1a)
---           local mymenu_lv2c = menumgr:NewEntry("Level 2 ac",mymenu_lv1a)
---           
---           local mymenu_lv2ba = menumgr:NewEntry("Level 2 ba",mymenu_lv1b)
---           local mymenu_lv2bb = menumgr:NewEntry("Level 2 bb",mymenu_lv1b)
---           local mymenu_lv2bc = menumgr:NewEntry("Level 2 bc",mymenu_lv1b)
---           
---           local mymenu_lv3a = menumgr:NewEntry("Level 3 aaa",mymenu_lv2a)
---           local mymenu_lv3b = menumgr:NewEntry("Level 3 aab",mymenu_lv2a)
---           local mymenu_lv3c = menumgr:NewEntry("Level 3 aac",mymenu_lv2a)
---           
---           menumgr:Propagate() -- propagate **once** to all clients in the SET_CLIENT
---           
---## Remove a single entry's subtree
---
---           menumgr:RemoveSubEntries(mymenu_lv3a)
---           
---## Remove a single entry and also it's subtree
---
---           menumgr:DeleteEntry(mymenu_lv3a)
---
---## Add a single entry
---
---           local baimenu = menumgr:NewEntry("BAI",mymenu_lv1b)
---           
---           menumgr:AddEntry(baimenu)  
---           
---## Add an entry with a function 
---
---           local baimenu = menumgr:NewEntry("Task Action", mymenu_lv1b, TestFunction, Argument1, Argument1)
---           
--- Now, the class will **automatically append the call with GROUP and CLIENT objects**, as this is can only be done when pushing the entry to the clients. So, the actual function implementation needs to look like this:
--- 
---           function TestFunction( Argument1, Argument2, Group, Client)
---           
--- **Caveat is**, that you need to ensure your arguments are not **nil** or **false**, as LUA will optimize those away. You would end up having Group and Client in wrong places in the function call. Hence,
--- if you need/ want to send **nil** or **false**, send a place holder instead and ensure your function can handle this, e.g.
--- 
---           local baimenu = menumgr:NewEntry("Task Action", mymenu_lv1b, TestFunction, "nil", Argument1)
---    
---## Change the text of a leaf entry in the menu tree          
---           
---           menumgr:ChangeEntryTextForAll(mymenu_lv1b,"Attack")
---           
---## Reset a single clients menu tree
---
---           menumgr:ResetMenu(client)
---           
---## Reset all and clear the reference tree
---
---           menumgr:ResetMenuComplete()
---           
---## Set to auto-propagate for CLIENTs joining the SET_CLIENT **after** the script is loaded - handy if you have a single menu tree.
---
---           menumgr:InitAutoPropagation()
---Class CLIENTMENUMANAGER
---@class CLIENTMENUMANAGER : BASE
---@field ClassName string Class Name
---@field Coalition number 
---@field PlayerMenu table 
---@field private clientset SET_CLIENT The set of clients this menu manager is for
---@field private debug boolean 
---@field private entrycount number 
---@field private flattree table 
---@field private lid string Lid for log entries
---@field private menutree table 
---@field private name string Name
---@field private rootentries table 
---@field private version string Version string
CLIENTMENUMANAGER = {}

---Push a single previously created entry into the F10 menu structure of all clients.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The entry to add.
---@param Client? CLIENT (optional) If given, make this change only for this client. 
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:AddEntry(Entry, Client) end

---Alter the text of a leaf entry in the generic structure and push to one specific client's F10 menu.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The menu entry.
---@param Text string New Text of the F10 menu entry.
---@param Client? CLIENT (optional) The client for whom to alter the entry, if nil done for all clients.
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:ChangeEntryText(Entry, Text, Client) end

---Remove the entry and all entries below the given entry from the client's F10 menus.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The entry to remove
---@param Client? CLIENT (optional) If given, make this change only for this client. 
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:DeleteF10Entry(Entry, Client) end

---Remove the entry and all entries below the given entry from the generic tree.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The entry to remove
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:DeleteGenericEntry(Entry) end

---Check matching entry in the generic structure by UUID.
---
------
---@param self CLIENTMENUMANAGER 
---@param UUID string UUID of the menu entry.
---@return boolean #Exists
function CLIENTMENUMANAGER:EntryUUIDExists(UUID) end

---Find matching entries in the generic structure under a parent.
---
------
---@param self CLIENTMENUMANAGER 
---@param Parent CLIENTMENU Find entries under this parent entry.
---@return table #Table of matching #CLIENTMENU objects.
---@return number #Number of matches
function CLIENTMENUMANAGER:FindEntriesByParent(Parent) end

---Find matching entries in the generic structure by the menu text.
---
------
---@param self CLIENTMENUMANAGER 
---@param Text string Text or partial text of the F10 menu entry.
---@param Parent? CLIENTMENU (Optional) Only find entries under this parent entry.
---@return table #Table of matching #CLIENTMENU objects.
---@return number #Number of matches
function CLIENTMENUMANAGER:FindEntriesByText(Text, Parent) end

---Find matching entry in the generic structure by UUID.
---
------
---@param self CLIENTMENUMANAGER 
---@param UUID string UUID of the menu entry.
---@return CLIENTMENU #Entry The #CLIENTMENU object found or nil.
function CLIENTMENUMANAGER:FindEntryByUUID(UUID) end

---Find matching entries under a parent in the generic structure by UUID.
---
------
---@param self CLIENTMENUMANAGER 
---@param Parent CLIENTMENU Find entries under this parent entry.
---@return table #Table of matching UUIDs of #CLIENTMENU objects
---@return table #Table of matching #CLIENTMENU objects
---@return number #Number of matches
function CLIENTMENUMANAGER:FindUUIDsByParent(Parent) end

---Find matching entries by text in the generic structure by UUID.
---
------
---@param self CLIENTMENUMANAGER 
---@param Text string Text or partial text of the menu entry to find.
---@param Parent? CLIENTMENU (Optional) Only find entries under this parent entry.
---@return table #Table of matching UUIDs of #CLIENTMENU objects
---@return table #Table of matching #CLIENTMENU objects
---@return number #Number of matches
function CLIENTMENUMANAGER:FindUUIDsByText(Text, Parent) end

---Set this Client Manager to auto-propagate menus **once** to newly joined players.
---Useful if you have **one** menu structure only. Does not automatically push follow-up changes to the client(s).
---
------
---@param self CLIENTMENUMANAGER 
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:InitAutoPropagation() end

---Create a new ClientManager instance.
---
------
---@param self CLIENTMENUMANAGER 
---@param ClientSet SET_CLIENT The set of clients to manage.
---@param Alias string The name of this manager.
---@param Coalition? number (Optional) Coalition of this Manager, defaults to coalition.side.BLUE
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:New(ClientSet, Alias, Coalition) end

---Create a new entry in the **generic** structure.
---
------
---@param self CLIENTMENUMANAGER 
---@param Text string Text of the F10 menu entry.
---@param Parent CLIENTMENU The parent menu entry.
---@param Function? string (optional) Function to call when the entry is used.
---@param ...? NOTYPE (optional) Arguments for the Function, comma separated.
---@return CLIENTMENU #Entry
function CLIENTMENUMANAGER:NewEntry(Text, Parent, Function, ...) end

---Push the complete menu structure to each of the clients in the set - refresh the menu tree of the clients.
---
------
---@param self CLIENTMENUMANAGER 
---@param Client? CLIENT (optional) If given, propagate only for this client.
---@return CLIENTMENU #Entry
function CLIENTMENUMANAGER:Propagate(Client) end

---Remove all entries below the given entry from the client's F10 menus.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The entry where to start. This entry stays.
---@param Client? CLIENT (optional) If given, make this change only for this client. In this case the generic structure will not be touched.
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:RemoveF10SubEntries(Entry, Client) end

---Remove all entries below the given entry from the generic tree.
---
------
---@param self CLIENTMENUMANAGER 
---@param Entry CLIENTMENU The entry where to start. This entry stays.
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:RemoveGenericSubEntries(Entry) end

---Blank out the menu - remove **all root entries** and all entries below from the client's F10 menus, leaving the generic structure untouched.
---
------
---@param self CLIENTMENUMANAGER 
---@param Client? CLIENT (optional) If given, remove only for this client.
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:ResetMenu(Client) end

---Blank out the menu - remove **all root entries** and all entries below from all clients' F10 menus, and **delete** the generic structure.
---
------
---@param self CLIENTMENUMANAGER 
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:ResetMenuComplete() end

---[Internal] Event handling
---
------
---@param self CLIENTMENUMANAGER 
---@param EventData EVENTDATA 
---@param Retry NOTYPE 
---@return CLIENTMENUMANAGER #self
function CLIENTMENUMANAGER:_EventHandler(EventData, Retry) end



