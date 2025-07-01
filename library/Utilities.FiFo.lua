---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/MOOSE.JPG" width="100%">
---
--- **UTILS** - Classic FiFo Stack.
---
---===
---
---## Main Features:
---
---   * Build a simple multi-purpose FiFo (First-In, First-Out) stack for generic data.
---   * [Wikipedia](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)
---
---===
---
---### Author: **applevangelist**
---FIFO class.
---@class FIFO : BASE
---@field ClassName string Name of the class.
---@field private counter number Counter.
---@field private lid string Class id string for output to DCS log file.
---@field private pointer number Pointer.
---@field private stackbyid table Stack by ID.
---@field private stackbypointer table Stack by pointer.
---@field private uniquecounter number 
---@field private version string Version of FiFo.
FIFO = {}

---Empty FIFO Stack.
---
------
---@param self FIFO 
---@return FIFO #self
function FIFO:Clear() end

---FIFO Get stack size
---
------
---@param self FIFO 
---@return number #size
function FIFO:Count() end

---FIFO Housekeeping
---
------
---@param self FIFO 
---@return FIFO #self
function FIFO:Flatten() end

---FIFO Print stacks to dcs.log
---
------
---@param self FIFO 
---@return FIFO #self
function FIFO:Flush() end

---Iterate the FIFO and call an iterator function for the given FIFO data, providing the object for each element of the stack and optional parameters.
---
------
---@param self FIFO 
---@param IteratorFunction function The function that will be called.
---@param Arg? table (Optional) Further Arguments of the IteratorFunction.
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return FIFO #self
function FIFO:ForEach(IteratorFunction, Arg, Function, FunctionArguments) end

---FIFO Get table of data entries
---
------
---@param self FIFO 
---@return table #Raw table indexed [1] to [n] of object entries - might be empty!
function FIFO:GetDataTable() end

---FIFO Get the data stack by UniqueID
---
------
---@param self FIFO 
---@return table #Table of #FIFO.IDEntry entries
function FIFO:GetIDStack() end

---FIFO Get table of UniqueIDs sorted smallest to largest
---
------
---@param self FIFO 
---@return table #Table with index [1] to [n] of UniqueID entries
function FIFO:GetIDStackSorted() end

---FIFO Get the data stack by pointer
---
------
---@param self FIFO 
---@return table #Table of #FIFO.IDEntry entries
function FIFO:GetPointerStack() end

---FIFO Get stack size
---
------
---@param self FIFO 
---@return number #size
function FIFO:GetSize() end

---FIFO Get sorted table of data entries by UniqueIDs (must be numerical UniqueIDs only!)
---
------
---@param self FIFO 
---@return table #Table indexed [1] to [n] of sorted object entries - might be empty!
function FIFO:GetSortedDataTable() end

---FIFO Check if a certain UniqeID exists
---
------
---@param self FIFO 
---@param UniqueID NOTYPE 
---@return boolean #exists
function FIFO:HasUniqueID(UniqueID) end

---FIFO Check Stack is empty
---
------
---@param self FIFO 
---@return boolean #empty
function FIFO:IsEmpty() end

---FIFO Check Stack is NOT empty
---
------
---@param self FIFO 
---@return boolean #notempty
function FIFO:IsNotEmpty() end

---Instantiate a new FIFO Stack.
---
------
---@param self FIFO 
---@return FIFO #self
function FIFO:New() end

---FIFO Pull Object from Stack.
---
------
---@param self FIFO 
---@return table #Object or nil if stack is empty
function FIFO:Pull() end

---FIFO Pull Object from Stack by UniqueID
---
------
---@param self FIFO 
---@param UniqueID NOTYPE 
---@return table #Object or nil if stack is empty
function FIFO:PullByID(UniqueID) end

---FIFO Pull Object from Stack by Pointer
---
------
---@param self FIFO 
---@param Pointer number 
---@return table #Object or nil if stack is empty
function FIFO:PullByPointer(Pointer) end

---FIFO Push Object to Stack.
---
------
---@param self FIFO 
---@param Object table 
---@param UniqueID? string (optional) - will default to current pointer + 1. Note - if you intend to use `FIFO:GetIDStackSorted()` keep the UniqueID numerical!
---@return FIFO #self
function FIFO:Push(Object, UniqueID) end

---FIFO Read, not Pull, Object from Stack by UniqueID
---
------
---@param self FIFO 
---@param UniqueID number 
---@return table #Object data or nil if stack is empty or ID does not exist
function FIFO:ReadByID(UniqueID) end

---FIFO Read, not Pull, Object from Stack by Pointer
---
------
---@param self FIFO 
---@param Pointer number 
---@return table #Object or nil if stack is empty or pointer does not exist
function FIFO:ReadByPointer(Pointer) end


---@class FIFO.IDEntry 
---@field private data table 
---@field private pointer number 
---@field private uniqueID table 
FIFO.IDEntry = {}


---LIFO class.
---@class LIFO : BASE
---@field ClassName string Name of the class.
---@field private counter number 
---@field private lid string Class id string for output to DCS log file.
---@field private pointer number 
---@field private stackbyid table 
---@field private stackbypointer table 
---@field private uniquecounter number 
---@field private version string Version of LiFo
LIFO = {}

---Empty LIFO Stack
---
------
---@param self LIFO 
---@return LIFO #self
function LIFO:Clear() end

---LIFO Get stack size
---
------
---@param self LIFO 
---@return number #size
function LIFO:Count() end

---LIFO Housekeeping
---
------
---@param self LIFO 
---@return LIFO #self
function LIFO:Flatten() end

---LIFO Print stacks to dcs.log
---
------
---@param self LIFO 
---@return LIFO #self
function LIFO:Flush() end

---Iterate the LIFO and call an iterator function for the given LIFO data, providing the object for each element of the stack and optional parameters.
---
------
---@param self LIFO 
---@param IteratorFunction function The function that will be called.
---@param Arg? table (Optional) Further Arguments of the IteratorFunction.
---@param Function? function (Optional) A function returning a #boolean true/false. Only if true, the IteratorFunction is called.
---@param FunctionArguments? table (Optional) Function arguments.
---@return LIFO #self
function LIFO:ForEach(IteratorFunction, Arg, Function, FunctionArguments) end

---LIFO Get table of data entries
---
------
---@param self LIFO 
---@return table #Raw table indexed [1] to [n] of object entries - might be empty!
function LIFO:GetDataTable() end

---LIFO Get the data stack by UniqueID
---
------
---@param self LIFO 
---@return table #Table of #LIFO.IDEntry entries
function LIFO:GetIDStack() end

---LIFO Get table of UniqueIDs sorted smallest to largest
---
------
---@param self LIFO 
---@return table #Table of #LIFO.IDEntry entries
function LIFO:GetIDStackSorted() end

---LIFO Get the data stack by pointer
---
------
---@param self LIFO 
---@return table #Table of #LIFO.IDEntry entries
function LIFO:GetPointerStack() end

---LIFO Get stack size
---
------
---@param self LIFO 
---@return number #size
function LIFO:GetSize() end

---LIFO Get sorted table of data entries by UniqueIDs (must be numerical UniqueIDs only!)
---
------
---@param self LIFO 
---@return table #Table indexed [1] to [n] of sorted object entries - might be empty!
function LIFO:GetSortedDataTable() end

---LIFO Check if a certain UniqeID exists
---
------
---@param self LIFO 
---@param UniqueID NOTYPE 
---@return boolean #exists
function LIFO:HasUniqueID(UniqueID) end

---LIFO Check Stack is empty
---
------
---@param self LIFO 
---@return boolean #empty
function LIFO:IsEmpty() end

---LIFO Check Stack is NOT empty
---
------
---@param self LIFO 
---@return boolean #notempty
function LIFO:IsNotEmpty() end

---Instantiate a new LIFO Stack
---
------
---@param self LIFO 
---@return LIFO #self
function LIFO:New() end

---LIFO Pull Object from Stack
---
------
---@param self LIFO 
---@return table #Object or nil if stack is empty
function LIFO:Pull() end

---LIFO Pull Object from Stack by UniqueID
---
------
---@param self LIFO 
---@param UniqueID NOTYPE 
---@return table #Object or nil if stack is empty
function LIFO:PullByID(UniqueID) end

---LIFO Pull Object from Stack by Pointer
---
------
---@param self LIFO 
---@param Pointer number 
---@return table #Object or nil if stack is empty
function LIFO:PullByPointer(Pointer) end

---LIFO Push Object to Stack
---
------
---@param self LIFO 
---@param Object table 
---@param UniqueID? string (optional) - will default to current pointer + 1
---@return LIFO #self
function LIFO:Push(Object, UniqueID) end

---LIFO Read, not Pull, Object from Stack by UniqueID
---
------
---@param self LIFO 
---@param UniqueID number 
---@return table #Object or nil if stack is empty or ID does not exist
function LIFO:ReadByID(UniqueID) end

---LIFO Read, not Pull, Object from Stack by Pointer
---
------
---@param self LIFO 
---@param Pointer number 
---@return table #Object or nil if stack is empty or pointer does not exist
function LIFO:ReadByPointer(Pointer) end


---@class LIFO.IDEntry 
---@field private data table 
---@field private pointer number 
---@field private uniqueID table 
LIFO.IDEntry = {}



