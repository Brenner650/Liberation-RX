waitUntil { !isNil "save_is_loaded" };
waitUntil { !isNil "blufor_sectors" };
waitUntil { !isNil "saved_intel_res" };

resources_intel = saved_intel_res;

while { GRLIB_endgame == 0 } do {

	_base_tick_period = 4800;

	if ( count allPlayers > 0 ) then {

		_blufor_mil_sectors = [];
		{
			if ( _x in sectors_military ) then {
				_blufor_mil_sectors pushback _x;
				_base_tick_period = _base_tick_period * 0.82;
			};
		} foreach blufor_sectors;

		_base_tick_period = _base_tick_period / GRLIB_resources_multiplier;

		if ( _base_tick_period < 300 ) then { _base_tick_period = 300 };

		sleep _base_tick_period;

		if ( count _blufor_mil_sectors > 0 ) then {
			if ( GRLIB_passive_income ) then {

				private _income =  (round (300 + (random 75)));
				{
					private _ammo_collected = _x getVariable ["GREUH_ammo_count",0];
					_x setVariable ["GREUH_ammo_count", _ammo_collected + _income, true];
				} forEach allPlayers;
				_text = format ["Reward Received: + %1 Ammo.", _income];
				[gamelogic, _text] remoteExec ["globalChat", 0];
			} else {
				if ( ( { typeof _x == ammobox_b_typename } count vehicles ) <= ( ceil ( ( count _blufor_mil_sectors ) * 1.3 ) ) ) then {

					_spawnsector = ( _blufor_mil_sectors call BIS_fnc_selectRandom );
					_spawnpos = zeropos;
					while { _spawnpos distance zeropos < 1000 } do {
						_spawnpos =  ( [ ( markerpos _spawnsector), random 50, random 360 ] call BIS_fnc_relPos ) findEmptyPosition [ 10, 100, 'B_Heli_Transport_01_F' ];
						if ( count _spawnpos == 0 ) then { _spawnpos = zeropos; };
					};

					_newbox = [ammobox_b_typename, _spawnpos, false] call boxSetup;
					clearWeaponCargoGlobal _newbox;
					clearMagazineCargoGlobal _newbox;
					clearItemCargoGlobal _newbox;
					clearBackpackCargoGlobal _newbox;
				};
			};
		};
	};
	sleep 300;
};