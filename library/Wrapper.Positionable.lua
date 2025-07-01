---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Positionable.JPG" width="100%">
---
---**Wrapper** - POSITIONABLE wraps DCS classes that are "positionable".
---
---===
---
---### Author: **FlightControl**
---
---### Contributions: **Hardcard**, **funkyfranky**
---
---===
---A DCSPositionable
---@class DCSPositionable 
DCSPositionable = {}


---Wrapper class to handle the POSITIONABLE objects.
---
--- * Support all DCS APIs.
--- * Enhance with POSITIONABLE specific APIs not in the DCS API set.
--- * Manage the "state" of the POSITIONABLE.
---
---## POSITIONABLE constructor
---
---The POSITIONABLE class provides the following functions to construct a POSITIONABLE instance:
---
--- * #POSITIONABLE.New(): Create a POSITIONABLE instance.
---
---## Get the current speed
---
---There are 3 methods that can be used to determine the speed.
---Use #POSITIONABLE.GetVelocityKMH() to retrieve the current speed in km/h. Use #POSITIONABLE.GetVelocityMPS() to retrieve the speed in meters per second.
---The method #POSITIONABLE.GetVelocity() returns the speed vector (a Vec3).
---
---## Get the current altitude
---
---Altitude can be retrieved using the method #POSITIONABLE.GetHeight() and returns the current altitude in meters from the orthonormal plane.
---@class POSITIONABLE : IDENTIFIABLE
---@field CargoBayCapacityValues table 
---@field DefaultInfantryWeight number 
---@field LaserCode NOTYPE 
---@field PositionableName NOTYPE 
---@field __ POSITIONABLE.__ 
---@field private coordinate COORDINATE Coordinate object.
---@field private pointvec3 COORDINATE Point Vec3 object.
POSITIONABLE = {}

---Add cargo.
---
------
---@param self POSITIONABLE 
---@param Cargo CARGO 
---@return POSITIONABLE #
function POSITIONABLE:AddCargo(Cargo) end

---Get cargo item count.
---
------
---@param self POSITIONABLE 
---@return CARGO #Cargo
function POSITIONABLE:CargoItemCount() end

---Clear all cargo.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:ClearCargo() end

---Destroys the POSITIONABLE.
---
------
---
---USAGE
---```
---
---Air unit example: destroy the Helicopter and generate a S_EVENT_CRASH for each unit in the Helicopter group.
---Helicopter = UNIT:FindByName( "Helicopter" )
---Helicopter:Destroy( true )
---```
------
---@param self POSITIONABLE 
---@param GenerateEvent? boolean (Optional) If true, generates a crash or dead event for the unit. If false, no event generated. If nil, a remove event is generated. 
---@return nil #The DCS Unit is not existing or alive.
function POSITIONABLE:Destroy(GenerateEvent) end

---Triggers an explosion at the coordinates of the positionable.
---
------
---@param self POSITIONABLE 
---@param power number Power of the explosion in kg TNT. Default 100 kg TNT.
---@param delay? number (Optional) Delay of explosion in seconds.
---@return POSITIONABLE #self
function POSITIONABLE:Explode(power, delay) end

---Signal a flare at the position of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@param FlareColor FLARECOLOR 
function POSITIONABLE:Flare(FlareColor) end

---Signal a green flare at the position of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:FlareGreen() end

---Signal a red flare at the position of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:FlareRed() end

---Signal a white flare at the position of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:FlareWhite() end

---Signal a yellow flare at the position of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:FlareYellow() end

---Returns the indicated airspeed (IAS).
---The IAS is calculated from the TAS under the approximation that TAS increases by ~2% with every 1000 feet altitude ASL.
---
------
---@param self POSITIONABLE 
---@param oatcorr? number (Optional) Outside air temperature (OAT) correction factor. Default 0.017 (=1.7%).
---@return number #IAS in m/s. Returns 0 if the POSITIONABLE does not exist.
function POSITIONABLE:GetAirspeedIndicated(oatcorr) end

---Returns the true airspeed (TAS).
---This is calculated from the current velocity minus wind in 3D.
---
------
---@param self POSITIONABLE 
---@return number #TAS in m/s. Returns 0 if the POSITIONABLE does not exist.
function POSITIONABLE:GetAirspeedTrue() end

---Returns the altitude above sea level of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return Distance #The altitude of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetAltitude() end

---Returns the Angle of Attack of a POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return number #Angle of attack in degrees.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetAoA() end

---Create a Core.Beacon#BEACON, to allow this POSITIONABLE to broadcast beacon signals.
---
------
---@param self POSITIONABLE 
---@return BEACON #Beacon
function POSITIONABLE:GetBeacon() end

---Get the bounding box of the underlying POSITIONABLE DCS Object.
---
------
---@param self POSITIONABLE 
---@return Box3 #The bounding box of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetBoundingBox() end

---Get the bounding radius of the underlying POSITIONABLE DCS Object.
---
------
---@param self POSITIONABLE 
---@param MinDist? number (Optional) If bounding box is smaller than this value, MinDist is returned.
---@return Distance #The bounding radius of the POSITIONABLE
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetBoundingRadius(MinDist) end

---Get all contained cargo.
---
------
---@param self POSITIONABLE 
---@return POSITIONABLE #
function POSITIONABLE:GetCargo() end

---Get Cargo Bay Free Weight in kg.
---
------
---@param self POSITIONABLE 
---@return number #CargoBayFreeWeight
function POSITIONABLE:GetCargoBayFreeWeight() end

---Get Cargo Bay Weight Limit in kg.
---
------
---@param self POSITIONABLE 
---@return number #Max cargo weight in kg. 
function POSITIONABLE:GetCargoBayWeightLimit() end

---Returns the climb or descent angle of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return number #Climb or descent angle in degrees. Or 0 if velocity vector norm is zero.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetClimbAngle() end

---Returns a reference to a COORDINATE object indicating the point in 3D of the POSITIONABLE within the mission.
---This function works similar to POSITIONABLE.GetCoordinate(), however, this function caches, updates and re-uses the same COORDINATE object stored
---within the POSITIONABLE. This has higher performance, but comes with all considerations associated with the possible referencing to the same COORDINATE object.
---This should only be used when performance is critical and there is sufficient awareness of the possible pitfalls. However, in most instances, GetCoordinate() is
---preferred as it will return a fresh new COORDINATE and thus avoid potentially unexpected issues.
---
------
---@param self POSITIONABLE 
---@return COORDINATE #A reference to the COORDINATE object of the POSITIONABLE.
function POSITIONABLE:GetCoord() end

---Returns a new COORDINATE object indicating the point in 3D of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return COORDINATE #A new COORDINATE object of the POSITIONABLE.
function POSITIONABLE:GetCoordinate() end

---Returns the DCS object.
---Polymorphic for other classes like UNIT, STATIC, GROUP, AIRBASE.
---
------
---@param self POSITIONABLE 
---@return Object #The DCS object.
function POSITIONABLE:GetDCSObject() end

---Returns the horizonal speed relative to eath's surface.
---The vertical component of the velocity vector is projected out (set to zero).
---
------
---@param self POSITIONABLE 
---@return number #Ground speed in m/s. Returns 0 if the POSITIONABLE does not exist.
function POSITIONABLE:GetGroundSpeed() end

---Returns the POSITIONABLE heading in degrees.
---
------
---@param self POSITIONABLE 
---@return number #The POSITIONABLE heading in degrees.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetHeading() end

---Returns the POSITIONABLE height above sea level in meters.
---
------
---@param self POSITIONABLE 
---@return Vec3 #Height of the positionable in meters (or nil, if the object does not exist).
function POSITIONABLE:GetHeight() end

---Get the last assigned laser code
---
------
---@param self POSITIONABLE 
---@return number #The laser code
function POSITIONABLE:GetLaserCode() end

---Returns a message with the callsign embedded (if there is one).
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
---@return MESSAGE #
function POSITIONABLE:GetMessage(Message, Duration, Name) end

---Returns the message text with the callsign embedded (if there is one).
---
------
---@param self POSITIONABLE 
---@param Message string The message text.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
---@return string #The message text.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetMessageText(Message, Name) end

---Returns a message of a specified type with the callsign embedded (if there is one).
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param MessageType MESSAGE MessageType The message type.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
---@return MESSAGE #
function POSITIONABLE:GetMessageType(Message, MessageType, Name) end

---Get the object size.
---
------
---@param self POSITIONABLE 
---@return Distance #Max size of object in x, z or 0 if bounding box could not be obtained.
---@return Distance #Length x or 0 if bounding box could not be obtained.
---@return Distance #Height y or 0 if bounding box could not be obtained.
---@return Distance #Width z or 0 if bounding box could not be obtained.
function POSITIONABLE:GetObjectSize() end

---Returns a COORDINATE object, which is offset with respect to the orientation of the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@param x number Offset in the direction "the nose" of the unit is pointing in meters. Default 0 m.
---@param y number Offset "above" the unit in meters. Default 0 m.
---@param z number Offset in the direction "the wing" of the unit is pointing in meters. z>0 starboard, z<0 port. Default 0 m.
---@return COORDINATE #The COORDINATE of the offset with respect to the orientation of the  POSITIONABLE.
function POSITIONABLE:GetOffsetCoordinate(x, y, z) end

--- Returns a {@DCS#Vec3} table of the objects current orientation in 3D space.
---X, Y, Z values are unit vectors defining the objects orientation.
--- X is the orientation parallel to the movement of the object, Z perpendicular and Y vertical orientation.
---
------
---@param self POSITIONABLE 
---@return Vec3 #X orientation, i.e. parallel to the direction of movement.
---@return Vec3 #Y orientation, i.e. vertical.
---@return Vec3 #Z orientation, i.e. perpendicular to the direction of movement.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetOrientation() end

--- Returns a {@DCS#Vec3} table of the objects current X orientation in 3D space, i.e.
---along the direction of movement.
---
------
---@param self POSITIONABLE 
---@return Vec3 #X orientation, i.e. parallel to the direction of movement.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetOrientationX() end

--- Returns a {@DCS#Vec3} table of the objects current Y orientation in 3D space, i.e.
---vertical orientation.
---
------
---@param self POSITIONABLE 
---@return Vec3 #Y orientation, i.e. vertical.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetOrientationY() end

--- Returns a {@DCS#Vec3} table of the objects current Z orientation in 3D space, i.e.
---perpendicular to direction of movement.
---
------
---@param self POSITIONABLE 
---@return Vec3 #Z orientation, i.e. perpendicular to movement.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetOrientationZ() end

---Returns the pitch angle of a POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return number #Pitch angle in degrees.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetPitch() end

---Returns a COORDINATE object indicating the point in 2D of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return COORDINATE #The 3D point vector of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetPointVec2() end

---Returns a COORDINATE object indicating the point in 3D of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return COORDINATE #The 3D point vector of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetPointVec3() end

---Returns a pos3 table of the objects current position and orientation in 3D space.
---X, Y, Z values are unit vectors defining the objects orientation.
---Coordinates are dependent on the position of the maps origin.
---
------
---@param self POSITIONABLE 
---@return Position3 #Table consisting of the point and orientation tables.
function POSITIONABLE:GetPosition() end

---Returns the DCS#Position3 position vectors indicating the point and direction vectors in 3D of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return Position #The 3D position vectors of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetPositionVec3() end

---Create a Sound.Radio#RADIO, to allow radio transmission for this POSITIONABLE.
---Set parameters with the methods provided, then use RADIO:Broadcast() to actually broadcast the message
---
------
---@param self POSITIONABLE 
---@return RADIO #Radio
function POSITIONABLE:GetRadio() end

---Returns a random DCS#Vec3 vector within a range, indicating the point in 3D of the POSITIONABLE within the mission.
---
------
---
---USAGE
---```
----- If Radius is ignored, returns the DCS#Vec3 of first UNIT of the GROUP
---```
------
---@param self POSITIONABLE 
---@param Radius number 
---@return Vec3 #The 3D point vector of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetRandomVec3(Radius) end

---Returns a COORDINATE object, which is transformed to be relative to the POSITIONABLE.
---Inverse of #POSITIONABLE.GetOffsetCoordinate.
---
------
---@param self POSITIONABLE 
---@param x number Offset along the world x-axis in meters. Default 0 m.
---@param y number Offset along the world y-axis in meters. Default 0 m.
---@param z number Offset along the world z-axis in meters. Default 0 m.
---@return COORDINATE #The relative COORDINATE with respect to the orientation of the  POSITIONABLE.
function POSITIONABLE:GetRelativeCoordinate(x, y, z) end

---Get relative velocity with respect to another POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@param Positionable POSITIONABLE Other POSITIONABLE.
---@return number #Relative velocity in m/s.
function POSITIONABLE:GetRelativeVelocity(Positionable) end

---Returns the roll angle of a unit.
---
------
---@param self POSITIONABLE 
---@return number #Pitch angle in degrees.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetRoll() end


---
------
---@param self NOTYPE 
function POSITIONABLE:GetSize() end

---Get the Spot
---
------
---@param self POSITIONABLE 
---@return SPOT #The Spot
function POSITIONABLE:GetSpot() end

---Get the number of infantry soldiers that can be embarked into an aircraft (airplane or helicopter).
---Returns `nil` for ground or ship units.
---
------
---@param self POSITIONABLE 
---@return number #Descent number of soldiers that fit into the unit. Returns `#nil` for ground and ship units. 
function POSITIONABLE:GetTroopCapacity() end

---Returns the DCS#Vec2 vector indicating the point in 2D of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return Vec2 #The 2D point vector of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetVec2() end

---Returns the DCS#Vec3 vector indicating the 3D vector of the POSITIONABLE within the mission.
---
------
---@param self POSITIONABLE 
---@return Vec3 #The 3D point vector of the POSITIONABLE.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetVec3() end

---Returns the Core.Velocity object from the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return VELOCITY #Velocity The Velocity object.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetVelocity() end

---Returns the POSITIONABLE velocity in km/h.
---
------
---@param self POSITIONABLE 
---@return number #The velocity in km/h.
function POSITIONABLE:GetVelocityKMH() end

---Returns the POSITIONABLE velocity in knots.
---
------
---@param self POSITIONABLE 
---@return number #The velocity in knots.
function POSITIONABLE:GetVelocityKNOTS() end

---Returns the POSITIONABLE velocity in meters per second.
---
------
---@param self POSITIONABLE 
---@return number #The velocity in meters per second.
function POSITIONABLE:GetVelocityMPS() end

---Returns the POSITIONABLE velocity Vec3 vector.
---
------
---@param self POSITIONABLE 
---@return Vec3 #The velocity Vec3 vector
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetVelocityVec3() end

---Returns the yaw angle of a POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return number #Yaw angle in degrees.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:GetYaw() end

---Returns if carrier has given cargo.
---
------
---@param self POSITIONABLE 
---@param Cargo NOTYPE 
---@return CARGO #Cargo
function POSITIONABLE:HasCargo(Cargo) end

---Returns true if the POSITIONABLE is in the air.
---Polymorphic, is overridden in GROUP and UNIT.
---
------
---@param self POSITIONABLE 
---@return boolean #true if in the air.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:InAir() end

---Returns if the Positionable is located above a runway.
---
------
---@param self POSITIONABLE 
---@return boolean #true if Positionable is above a runway.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:IsAboveRunway() end

---Returns if the unit is of an air category.
---If the unit is a helicopter or a plane, then this method will return true, otherwise false.
---
------
---@param self POSITIONABLE 
---@return boolean #Air category evaluation result.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:IsAir() end

---Is cargo bay empty.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:IsCargoEmpty() end

---Returns if the unit is of an ground category.
---If the unit is a ground vehicle or infantry, this method will return true, otherwise false.
---
------
---@param self POSITIONABLE 
---@return boolean #Ground category evaluation result.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:IsGround() end

---Returns true if the unit is within a Core.Zone.
---
------
---@param self POSITIONABLE 
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the unit is within the @{Core.Zone#ZONE_BASE}
function POSITIONABLE:IsInZone(Zone) end

---Check if the POSITIONABLE is lasing a target.
---
------
---@param self POSITIONABLE 
---@return boolean #true if it is lasing a target
function POSITIONABLE:IsLasing() end

---Returns true if the unit is not within a Core.Zone.
---
------
---@param self POSITIONABLE 
---@param Zone ZONE_BASE The zone to test.
---@return boolean #Returns true if the unit is not within the @{Core.Zone#ZONE_BASE}
function POSITIONABLE:IsNotInZone(Zone) end

---Returns if the unit is of ship category.
---
------
---@param self POSITIONABLE 
---@return boolean #Ship category evaluation result.
---@return nil #The POSITIONABLE is not existing or alive.
function POSITIONABLE:IsShip() end

---Returns if the unit is a submarine.
---
------
---@param self POSITIONABLE 
---@return boolean #Submarines attributes result.
function POSITIONABLE:IsSubmarine() end

---Start Lasing a COORDINATE.
---
------
---@param self POSITIONABLE 
---@param Coordinate COORDINATE The coordinate where the lase is pointing at.
---@param LaserCode number Laser code or random number in [1000, 9999].
---@param Duration number Duration of lasing in seconds.
---@return SPOT #
function POSITIONABLE:LaseCoordinate(Coordinate, LaserCode, Duration) end

---Stop Lasing a POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@return POSITIONABLE #
function POSITIONABLE:LaseOff() end

---Start Lasing a POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@param Target POSITIONABLE The target to lase.
---@param LaserCode number Laser code or random number in [1000, 9999].
---@param Duration number Duration of lasing in seconds.
---@return SPOT #
function POSITIONABLE:LaseUnit(Target, LaserCode, Duration) end

---Send a message to the players in the Wrapper.Group.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:Message(Message, Duration, Name) end

---Send a message to all coalitions.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToAll(Message, Duration, Name) end

---Send a message to the blue coalition.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToBlue(Message, Duration, Name) end

---Send a message to a client.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Client CLIENT The client object receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToClient(Message, Duration, Client, Name) end

---Send a message to a coalition.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param MessageCoalition coalition The Coalition receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToCoalition(Message, Duration, MessageCoalition, Name) end

---Send a message to a Wrapper.Group.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param MessageGroup GROUP The GROUP object receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToGroup(Message, Duration, MessageGroup, Name) end

---Send a message to the red coalition.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToRed(Message, Duration, Name) end

---Send a message to a Core.Set#SET_GROUP.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param MessageSetGroup SET_GROUP The SET_GROUP collection receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageToSetGroup(Message, Duration, MessageSetGroup, Name) end

---Send a message to a Core.Set#SET_UNIT.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param MessageSetUnit SET_UNIT The SET_UNIT collection receiving the message.
---@param Name? string (optional) The Name of the sender. If not provided, the Name is the type of the Positionable.
function POSITIONABLE:MessageToSetUnit(Message, Duration, MessageSetUnit, Name) end

---Send a message to a Wrapper.Unit.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param Duration Duration The duration of the message.
---@param MessageUnit UNIT The UNIT object receiving the message.
---@param Name? string (optional) The Name of the sender. If not provided, the Name is the type of the Positionable.
function POSITIONABLE:MessageToUnit(Message, Duration, MessageUnit, Name) end

---Send a message to a coalition.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param MessageType MESSAGE.Type The message type that determines the duration.
---@param MessageCoalition coalition The Coalition receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, Name is set to the type of the POSITIONABLE.
function POSITIONABLE:MessageTypeToCoalition(Message, MessageType, MessageCoalition, Name) end

---Send a message of a message type to a Wrapper.Group.
---The message will appear in the message area. The message will begin with the callsign of the group and the type of the first unit sending the message.
---
------
---@param self POSITIONABLE 
---@param Message string The message text
---@param MessageType MESSAGE.Type The message type that determines the duration.
---@param MessageGroup GROUP The GROUP object receiving the message.
---@param Name? string (Optional) The Name of the sender. If not provided, the Name is the type of the POSITIONABLE.
function POSITIONABLE:MessageTypeToGroup(Message, MessageType, MessageGroup, Name) end

---Create a new POSITIONABLE from a DCSPositionable
---
------
---@param self POSITIONABLE 
---@param PositionableName string The POSITIONABLE name
---@return POSITIONABLE #self
function POSITIONABLE:New(PositionableName) end

---Remove cargo.
---
------
---@param self POSITIONABLE 
---@param Cargo CARGO 
---@return POSITIONABLE #
function POSITIONABLE:RemoveCargo(Cargo) end

---Set Cargo Bay Weight Limit in kg.
---
------
---@param self POSITIONABLE 
---@param WeightLimit? number (Optional) Weight limit in kg. If not given, the value is taken from the descriptors or hard coded. 
function POSITIONABLE:SetCargoBayWeightLimit(WeightLimit) end

---Smoke the POSITIONABLE.
---
------
---@param self POSITIONABLE 
---@param SmokeColor SMOKECOLOR The smoke color.
---@param Range number The range in meters to randomize the smoking around the POSITIONABLE.
---@param AddHeight number The height in meters to add to the altitude of the POSITIONABLE.
function POSITIONABLE:Smoke(SmokeColor, Range, AddHeight) end

---Smoke the POSITIONABLE Blue.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:SmokeBlue() end

---Smoke the POSITIONABLE Green.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:SmokeGreen() end

---Smoke the POSITIONABLE Orange.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:SmokeOrange() end

---Smoke the POSITIONABLE Red.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:SmokeRed() end

---Smoke the POSITIONABLE White.
---
------
---@param self POSITIONABLE 
function POSITIONABLE:SmokeWhite() end


---@class POSITIONABLE.__ : IDENTIFIABLE
---@field Cargo POSITIONABLE.__.Cargo 
POSITIONABLE.__ = {}



