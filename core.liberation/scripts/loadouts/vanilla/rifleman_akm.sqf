_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "MiniGrenade";};
for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_BandollierB_rgr";
for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_762x39_Mag_F";};
_unit addHeadgear "H_Bandanna_camo";
_unit addGoggles "G_Bandanna_beast";
_unit addWeapon "arifle_AKM_FL_F";
_unit addWeapon "hgun_P07_F";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";