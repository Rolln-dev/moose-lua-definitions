---@meta

---<img src="https://flightcontrol-master.github.io/MOOSE_DOCS_DEVELOP/Images/Wrapper_Weapon.png" width="100%">
---
---**Wrapper** - Weapon functions.
---
---## Main Features:
---
---   * Convenient access to DCS API functions
---   * Track weapon and get impact position
---   * Get launcher and target of weapon
---   * Define callback function when weapon impacts
---   * Define callback function when tracking weapon
---   * Mark impact points on F10 map
---   * Put coloured smoke on impact points
---
---===
---
---## Additional Material:
---
---* **Demo Missions:** [GitHub](https://github.com/FlightControl-Master/MOOSE_Demos/tree/master/Wrapper/Weapon)
---* **YouTube videos:** None
---* **Guides:** None
---
---===
---
---### Author: **funkyfranky**
---
---===
---*In the long run, the sharpest weapon of all is a kind and gentle spirit.* -- Anne Frank
---
---===
---
---# The WEAPON Concept
---
---The WEAPON class offers an easy-to-use wrapper interface to all DCS API functions.
---
---Probably, the most striking highlight is that the position of the weapon can be tracked and its impact position can be determined, which is not
---possible with the native DCS scripting engine functions.
---
---**Note** that this wrapper class is different from most others as weapon objects cannot be found with a DCS API function like `getByName()`.
---They can only be found in DCS events like the "Shot" event, where the weapon object is contained in the event data.
---
---# Tracking
---
---The status of the weapon can be tracked with the #WEAPON.StartTrack function. This function will try to determin the position of the weapon in (normally) relatively
---small time steps. The time step can be set via the #WEAPON.SetTimeStepTrack function and is by default set to 0.01 seconds.
---
---Once the position cannot be retrieved any more, the weapon has impacted (or was destroyed otherwise) and the last known position is safed as the impact point.
---The impact point can be accessed with the #WEAPON.GetImpactVec3 or #WEAPON.GetImpactCoordinate functions.
---
---## Impact Point Marking
---
---You can mark the impact point on the F10 map with #WEAPON.SetMarkImpact.
---
---You can also trigger coloured smoke at the impact point via #WEAPON.SetSmokeImpact.
---
---## Callback functions
---
---It is possible to define functions that are called during the tracking of the weapon and upon impact, which help you to customize further actions.
---
---### Callback on Impact
---
---The function called on impact can be set with #WEAPON.SetFuncImpact
---
---### Callback when Tracking
---
---The function called each time the weapon status is tracked can be set with #WEAPON.SetFuncTrack
---
---# Target
---
---If the weapon has a specific target, you can get it with the #WEAPON.GetTarget function. Note that the object, which is returned can vary. Normally, it is a UNIT
---but it could also be a STATIC object.
---
---Also note that the weapon does not always have a target, it can loose a target and re-aquire it and the target might change to another unit.
---
---You can get the target name with the #WEAPON.GetTargetName function.
---
---The distance to the target is returned by the #WEAPON.GetTargetDistance function.
---
---# Category
---
---The category (bomb, rocket, missile, shell, torpedo) of the weapon can be retrieved with the #WEAPON.GetCategory function.
---
---You can check if the weapon is a
---
---* bomb with #WEAPON.IsBomb
---* rocket with #WEAPON.IsRocket
---* missile with #WEAPON.IsMissile
---* shell with #WEAPON.IsShell
---* torpedo with #WEAPON.IsTorpedo
---
---# Parameters
---
---You can get various parameters of the weapon, *e.g.*
---
---* position: #WEAPON.GetVec3, #WEAPON.GetVec2, #WEAPON.GetCoordinate
---* speed: #WEAPON.GetSpeed
---* coalition: #WEAPON.GetCoalition
---* country: #WEAPON.GetCountry
---
---# Dependencies
---
---This class is used (at least) in the MOOSE classes:
---
---* RANGE (to determine the impact points of bombs and missiles)
---* ARTY (to destroy and replace shells with smoke or illumination)
---* FOX (to destroy the missile before it hits the target)
---WEAPON class.
---@class WEAPON : POSITIONABLE
---@field ClassName string Name of the class.
---@field private category number Weapon category 0=SHELL, 1=MISSILE, 2=ROCKET, 3=BOMB, 4=TORPEDO (Weapon.Category.X).
---@field private categoryMissile number Missile category 0=AAM, 1=SAM, 2=BM, 3=ANTI_SHIP, 4=CRUISE, 5=OTHER (Weapon.MissileCategory.X).
---@field private coalition number Coalition ID.
---@field private coordinate COORDINATE Coordinate object of the weapon. Can be used in other classes.
---@field private country number Country ID.
---@field private desc Desc Descriptor table.
---@field private distIP number Distance in meters for the intercept point estimation.
---@field private dtTrack number Time step in seconds for tracking scheduler.
---@field private guidance Desc Missile guidance descriptor.
---@field private impactArg table Optional arguments for the impact callback function.
---@field private impactCoord COORDINATE Impact coordinate.
---@field private impactDestroy boolean If `true`, destroy weapon before impact. Requires tracking to be started and sufficiently small time step.
---@field private impactDestroyDist number Distance in meters to the estimated impact point. If smaller, then weapon is destroyed.
---@field private impactFunc function Callback function for weapon impact.
---@field private impactHeading NOTYPE 
---@field private impactMark boolean If `true`, the impact point is marked on the F10 map. Requires tracking to be started.
---@field private impactSmoke boolean If `true`, the impact point is marked by smoke. Requires tracking to be started.
---@field private impactSmokeColor number Colour of impact point smoke.
---@field private impactVec3 Vec3 Impact 3D vector.
---@field private last_velocity NOTYPE 
---@field private launcher Unit Launcher DCS unit.
---@field private launcherName string Name of launcher unit.
---@field private launcherUnit UNIT Launcher Unit.
---@field private lid string Class id string for output to DCS log file.
---@field private name string Name of the weapon object.
---@field private pos3 Position3 Last known 3D position and direction vector of the tracked weapon.
---@field private releaseAltitudeAGL NOTYPE 
---@field private releaseAltitudeASL NOTYPE 
---@field private releaseCoordinate NOTYPE 
---@field private releaseHeading NOTYPE 
---@field private releasePitch NOTYPE 
---@field private target UNIT Last known target.
---@field private trackArg table Optional arguments for the track callback function.
---@field private trackFunc function Callback function when weapon is tracked and alive.
---@field private trackScheduleID number Tracking scheduler ID. Can be used to remove/destroy the scheduler function.
---@field private tracking boolean If `true`, scheduler will keep tracking. Otherwise, function will return nil and stop tracking.
---@field private typeName string Type name of the weapon.
---@field private vec3 Vec3 Last known 3D position vector of the tracked weapon.
---@field private verbose number Verbosity level.
---@field private version string WEAPON class version.
---@field private weapon Weapon The DCS weapon object.
WEAPON = {}

---Destroy the weapon object.
---
------
---@param Delay number Delay before destroy in seconds.
---@return WEAPON #self
function WEAPON:Destroy(Delay) end

---Get coalition.
---
------
---@return number #Coalition ID.
function WEAPON:GetCoalition() end

---Get country.
---
------
---@return number #Country ID.
function WEAPON:GetCountry() end

---Get DCS object.
---
------
---@return Weapon #The weapon object.
function WEAPON:GetDCSObject() end

---Get the impact coordinate.
---Note that this might not exist if the weapon has not impacted yet!
---
------
---@return COORDINATE #Impact coordinate (if any).
function WEAPON:GetImpactCoordinate() end

---Get the heading of the weapon when it impacted.
---Note that this might not exist if the weapon has not impacted yet!
---
------
---@param AccountForMagneticInclination? bool (Optional) If true will account for the magnetic declination of the current map. Default is true
---@return number #Heading
function WEAPON:GetImpactHeading(AccountForMagneticInclination) end

---Get the impact position vector.
---Note that this might not exist if the weapon has not impacted yet!
---
------
---@return Vec3 #Impact position vector (if any).
function WEAPON:GetImpactVec3() end

---Get the unit that launched the weapon.
---
------
---@return UNIT #Laucher unit.
function WEAPON:GetLauncher() end

---Get the altitude above ground level at which the weapon was released
---
------
---@return number #Altitude in meters
function WEAPON:GetReleaseAltitudeAGL() end

---Get the altitude above sea level at which the weapon was released
---
------
---@return number #Altitude in meters
function WEAPON:GetReleaseAltitudeASL() end

---Get the coordinate where the weapon was released
---
------
---@return COORDINATE #Impact coordinate (if any).
function WEAPON:GetReleaseCoordinate() end

---Get the heading on which the weapon was released
---
------
---@param AccountForMagneticInclination? bool (Optional) If true will account for the magnetic declination of the current map. Default is true
---@return number #Heading
function WEAPON:GetReleaseHeading(AccountForMagneticInclination) end

---Get the pitch of the unit when the weapon was released
---
------
---@return number #Degrees
function WEAPON:GetReleasePitch() end

---Get speed of weapon.
---
------
---@param ConversionFunction? function (Optional) Conversion function from m/s to desired unit, *e.g.* `UTILS.MpsToKmph`.
---@return number #Speed in meters per second.
function WEAPON:GetSpeed(ConversionFunction) end

---Get the target, which the weapon is guiding to.
---
------
---@return OBJECT #The target object, which can be a UNIT or STATIC object.
function WEAPON:GetTarget() end

---Get the distance to the current target the weapon is guiding to.
---
------
---@param ConversionFunction? function (Optional) Conversion function from meters to desired unit, *e.g.* `UTILS.MpsToKmph`.
---@return number #Distance from weapon to target in meters.
function WEAPON:GetTargetDistance(ConversionFunction) end

---Get name the current target the weapon is guiding to.
---
------
---@return string #Name of the target or "None" if no target.
function WEAPON:GetTargetName() end

---Get type name.
---
------
---@return string #The type name.
function WEAPON:GetTypeName() end

---Get the current 2D position vector.
---
------
---@return Vec2 #Current position vector in 2D.
function WEAPON:GetVec2() end

---Get the current 3D position vector.
---
------
---@return Vec3 #Current position vector in 3D.
function WEAPON:GetVec3() end

---Get velocity vector of weapon.
---
------
---@return Vec3 #Velocity vector with x, y and z components in meters/second.
function WEAPON:GetVelocityVec3() end

---Check if weapon is in the air.
---Obviously not really useful for torpedos. Well, then again, this is DCS...
---
------
---@return boolean #If `true`, weapon is in the air and `false` if not. Returns `nil` if weapon object itself is `nil`.
function WEAPON:InAir() end

---Check if weapon is a bomb.
---
------
---@return boolean #If `true`, is a bomb.
function WEAPON:IsBomb() end

---Check if weapon object (still) exists.
---
------
---@return boolean #If `true`, the weapon object still exists and `false` otherwise. Returns `nil` if weapon object itself is `nil`.
function WEAPON:IsExist() end

---Check if weapon is a Fox One missile (Radar Semi-Active).
---
------
---@return boolean #If `true`, is a Fox One.
function WEAPON:IsFoxOne() end

---Check if weapon is a Fox Three missile (Radar Active).
---
------
---@return boolean #If `true`, is a Fox Three.
function WEAPON:IsFoxThree() end

---Check if weapon is a Fox Two missile (IR guided).
---
------
---@return boolean #If `true`, is a Fox Two.
function WEAPON:IsFoxTwo() end

---Check if weapon is a missile.
---
------
---@return boolean #If `true`, is a missile.
function WEAPON:IsMissile() end

---Check if weapon is a rocket.
---
------
---@return boolean #If `true`, is a missile.
function WEAPON:IsRocket() end

---Check if weapon is a shell.
---
------
---@return boolean #If `true`, is a shell.
function WEAPON:IsShell() end

---Check if weapon is a torpedo.
---
------
---@return boolean #If `true`, is a torpedo.
function WEAPON:IsTorpedo() end

---Create a new WEAPON object from the DCS weapon object.
---
------
---@param WeaponObject Weapon The DCS weapon object.
---@return WEAPON #self
function WEAPON:New(WeaponObject) end

---Set distance of intercept point for estimated impact point.
---If the weapon cannot be tracked any more, the intercept point from its last known position and direction is used to get
---a better approximation of the impact point. Can be useful when using longer time steps in the tracking and still achieve
---a good result on the impact point.
---It uses the DCS function [getIP](https://wiki.hoggitworld.com/view/DCS_func_getIP).
---
------
---@param Distance number Distance in meters. Default is 50 m. Set to 0 to deactivate.
---@return WEAPON #self
function WEAPON:SetDistanceInterceptPoint(Distance) end

---Set callback function when weapon impacted or was destroyed otherwise, *i.e.* cannot be tracked any more.
---
------
---
---USAGE
---```
----- Function called on impact.
---local function OnImpact(Weapon)
---  Weapon:GetImpactCoordinate():MarkToAll("Impact Coordinate of weapon")
---end
---
----- Set which function to call.
---myweapon:SetFuncImpact(OnImpact)
---
----- Start tracking.
---myweapon:Track()
---```
------
---@param FuncImpact function Function called once the weapon impacted.
---@param ... NOTYPE Optional function arguments.
---@return WEAPON #self 
function WEAPON:SetFuncImpact(FuncImpact, ...) end

---Set callback function when weapon is tracked and still alive.
---The first argument will be the WEAPON object.
---Note that this can be called many times per second. So be careful for performance reasons.
---
------
---@param FuncTrack function Function called during tracking.
---@param ... NOTYPE Optional function arguments.
---@return WEAPON #self
function WEAPON:SetFuncTrack(FuncTrack, ...) end

---Mark impact point on the F10 map.
---This requires that the tracking has been started.
---
------
---@param Switch boolean If `true` or nil, impact is marked.
---@return WEAPON #self
function WEAPON:SetMarkImpact(Switch) end

---Put smoke on impact point.
---This requires that the tracking has been started.
---
------
---@param Switch boolean If `true` or nil, impact is smoked.
---@param SmokeColor number Color of smoke. Default is `SMOKECOLOR.Red`.
---@return WEAPON #self
function WEAPON:SetSmokeImpact(Switch, SmokeColor) end

---Set track position time step.
---
------
---@param TimeStep number Time step in seconds when the position is updated. Default 0.01 sec ==> 100 evaluations per second.
---@return WEAPON #self
function WEAPON:SetTimeStepTrack(TimeStep) end

---Set verbosity level.
---
------
---@param VerbosityLevel number Level of output (higher=more). Default 0.
---@return WEAPON #self
function WEAPON:SetVerbosity(VerbosityLevel) end

---Start tracking the weapon until it impacts or is destroyed otherwise.
---The position of the weapon is monitored in small time steps. Once the position cannot be determined anymore, the monitoring is stopped and the last known position is
---the (approximate) impact point. Of course, the smaller the time step, the better the position can be determined. However, this can hit the performance as many
---calculations per second need to be carried out.
---
------
---@param Delay number Delay in seconds before the tracking starts. Default 0.001 sec.
---@return WEAPON #self
function WEAPON:StartTrack(Delay) end

---Stop tracking the weapon by removing the scheduler function.
---
------
---@param Delay? number (Optional) Delay in seconds before the tracking is stopped.
---@return WEAPON #self
function WEAPON:StopTrack(Delay) end

---Compute estimated intercept/impact point (IP) based on last known position and direction.
---
------
---@param Distance number Distance in meters. Default 50 m.
---@return Vec3 #Estimated intercept/impact point. Can also return `nil`, if no IP can be determined.
function WEAPON:_GetIP(Distance) end

---Track weapon until impact.
---
------
---@param time Time Time in seconds.
---@return number #Time when called next or nil if not called again.
function WEAPON:_TrackWeapon(time) end



