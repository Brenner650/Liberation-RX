params ["_vehicle"];
private["_display","_vehicles","_detected_vehicles","_color","_pic","_text"];
if (isNil "_vehicle") exitWith {};
paint_veh = 0;

createDialog "RPT_vehicle_repaint";
waitUntil { dialog };

if(!isNull (findDisplay 2300)) then {
	_display = findDisplay 2300;
	_color = _vehicle getVariable ["GRLIB_vehicle_color_name", "Default"];
	_pic = getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "picture");
	_text = getText(configFile >> "cfgVehicles" >> typeOf _vehicle >> "DisplayName");

	ctrlSetText [230, format ["%1 - (%2)", _text, _color]];
	ctrlSetText [234, _pic];
	ctrlSetText [235, _pic];

	_veh_class = typeOf _vehicle;
	_veh_texture_list = (configfile >> "CfgVehicles" >> _veh_class >> "TextureSources") call Bis_fnc_getCfgSubClasses;

	_i = 0;
	{
		lbAdd[231,format["%1", _x]];
		lbSetValue [231, (lbSize 231)-1, _i];
		lbSetData [231, (lbSize 231)-1, ""];
		_i = _i + 1;
	} foreach _veh_texture_list;

	{
		lbAdd[231,format["%1", _x select 0]];
		lbSetValue [231, (lbSize 231)-1, _i];
		lbSetData [231, (lbSize 231)-1, _x select 1];
		_i = _i + 1;
	} foreach colorList;
	lbSetCurSel [231,0];

	while { dialog && (alive player) && paint_veh == 0 } do {
		sleep 0.1;
	};
	closeDialog 0;

	if (paint_veh == 1) then {
		_color = lbcursel 231;
		if (_color == -1) exitWith {};
		_name = lbText [231, _color];
		_texture = lbData[231, _color];

		if (!([player, _vehicle] call is_owner)) exitWith { hintSilent "Wrong Vehicle Owner.\nAccess is Denied !" };
		if ((damage _vehicle) != 0) exitWith { hintSilent "Damaged Vehicles cannot be Painted !" };
		if (_veh_class in GRLIB_vehicle_blacklist) exitWith { hintSilent "This Vehicle cannot be Painted !" };
		if (_texture == "" ) then {_texture = [_name]};
		[_vehicle, _texture, _name, []] call RPT_fnc_TextureVehicle;
		sleep 1;
	};
};