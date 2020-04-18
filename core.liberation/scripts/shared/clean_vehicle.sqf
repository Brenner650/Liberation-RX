params ["_vehicle"];

// Delete Cargo
{[[_x], "deleteVehicle"] call BIS_fnc_MP} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);

//unTow
_towed = _vehicle getVariable ["R3F_LOG_remorque", objNull];
if (!isNull _towed) then {
	[_towed] call R3F_LOG_FNCT_remorqueur_detacher;
};

// Delete GR Cargo
if ( _vehicle getVariable ["GRLIB_ammo_truck_load", 0] >= 1 ) then {
	{[[_x], "deleteVehicle"] call BIS_fnc_MP} foreach (attachedObjects _vehicle);
};

// Delete Crew
{if (! alive _x) then {[[_x], "deleteVehicle"] call BIS_fnc_MP}} forEach crew _vehicle;
_vehicle removeAllEventHandlers "HandleDamage";