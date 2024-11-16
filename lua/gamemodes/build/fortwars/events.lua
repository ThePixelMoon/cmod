

function eventPlayerSpawn (userid)
	if (_PlayerInfo(userid, "team") == TEAM_SPECTATOR) then
		UpdateScores(userid);
		onShowTeam(userid);
	end
	_PlayerSetDrawTeamCircle(userid, true);
	drawMoneyAmmount(userid);
	
	if (players[userid].spawn.x ~= 0)
	then
		_EntSetPos(userid, players[userid].spawn);
	end
end

function eventPlayerKilled ( killed, attacker, weapon )		
	_Msg("attacker ".._PlayerInfo(attacker,"name").." killed ".._PlayerInfo(killed,"name").."\n");
	_PlayerAddDeath(killed, 1);
	if (IsPlayer(attacker)) and (attacker ~= killed) then
		_PlayerAddScore(attacker, 1);
		players[attacker].money = players[attacker].money + MONEY_KILL_AMOUNT;
		drawMoneyAmmount(attacker);
	end
	
	if (killed == flagCarrier) then
		teams[_PlayerInfo(killed,"team")].hasFlag = false;
		HaltTimer(tFlagTime);
		--createFlag();
	end;
end

function onPhysFreeze( player, entity )
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	if (_PlayerInfo(playerid,"team") == TEAM_BLUE) then
		_EntFire(entity, "color", "50 150 255", 0);
	elseif (_PlayerInfo(player,"team") == TEAM_YELLOW) then
		_EntFire(entity, "color", "255 200 0", 0);
	elseif (_PlayerInfo(player,"team") == TEAM_GREEN) then
		_EntFire(entity, "color", "50 255 150", 0);
	elseif (_PlayerInfo(player,"team") == TEAM_RED) then
		_EntFire(entity, "color", "255 100 100", 0);
	else
		_EntFire(entity, "color", "0 0 255", 0);
	end
	
	return true;
end;

function onPhysPickup( player, entity )
	if dm_mode then return false; end;
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	if (ENABLE_PHYSGUN_PICKUP) then
		_EntFire(entity, "color", "255 255 255", 0);
		return true;
	end;
		
	return false;
end;

function onGravGunPunt( player, entity )
	msgDebug("** Debug ** GavPunt - Flag: " ..flag.. " entity: " .. entity);
	if dm_mode then
		if (entity == flag) then return true; end
		return false;
	end;
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	_EntFire(entity, "color", "255 255 255", 0);
	return true;
end;
function onGravGunPickup( player, entity )
	msgDebug("** Debug ** GavPickup - Flag: " ..flag.. " entity: " .. entity);
	if dm_mode then
		if (entity == flag) then
			-- start the timer for that time
			msgDebug("** Debug ** tDeathmatch: " ..tDeathmatch.. " tFlagTime: " .. tFlagTime);
			HaltTimer(tFlagTime);
			flagCarrier = player;
			teams[_PlayerInfo(player,"team")].hasFlag = true;
			tFlagTime = AddTimer(1, 0, doFlagTime, _PlayerInfo(player,"team"));
			return true;
		end;
		return false;
	end;
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	_EntFire(entity, "color", "255 255 255", 0);
	return true;
end;

function onGravGunDrop( player, entity )
	msgDebug("** Debug ** GavDrop - Flag: " ..flag.. " entity: " .. entity);
	if (entity == flag) then
		HaltTimer(tFlagTime);
		teams[_PlayerInfo(player,"team")].hasFlag = false;
		flagCarrier = 0;
	else
		if ((FREEZE_ON_GRAVGUN_DROP) or (teams[_PlayerInfo(player,"team")].reward > 0))
		then
			if (_PlayerInfo(playerid,"team") == TEAM_BLUE) then
				_EntFire(entity, "color", "50 150 255", 0);
			elseif (_PlayerInfo(player,"team") == TEAM_YELLOW) then
				_EntFire(entity, "color", "255 200 0", 0);
			elseif (_PlayerInfo(player,"team") == TEAM_GREEN) then
				_EntFire(entity, "color", "50 255 150", 0);
			elseif (_PlayerInfo(player,"team") == TEAM_RED) then
				_EntFire(entity, "color", "255 100 100", 0);
			else
				_EntFire(entity, "color", "0 0 255", 0);
			end
			
			_PhysEnableMotion(entity, false);
		end
	end
	
	return true;
end

function onGravGunLaunch( player, entity)
	msgDebug("** Debug ** GavLaunch - Flag: " ..flag.. " entity: " .. entity);
	if (entity == flag) then
		HaltTimer(tFlagTime);
		teams[_PlayerInfo(player,"team")].hasFlag = false;
		flagCarrier = 0;
	end
	return true;
end;

function canPlayerHaveItem( playerid, itemname )
	if (itemname == "weapon_physcannon") then return true; end;
	
	if (not dm_mode) then
		if (itemname == "weapon_propmaker") then return true; end;
		if (itemname == "weapon_propremover") then return true; end;
		if (itemname == "weapon_prop_freeze") then return true; end;
		if (itemname == "weapon_spawn") then return true; end
		if (itemname == "weapon_physgun") then return true; end;
	end
	
--		if (itemname == "weapon_shotgun") then return true; end;
--		if (itemname == "weapon_smg1") then return true; end;
--		if (itemname == "weapon_357") then return true; end;
--		if (itemname == "weapon_ar2") then return true; end;
--		if (itemname == "weapon_frag") then return true; end;
--		if (itemname == "weapon_rpg") then return true; end;
--		if (itemname == "weapon_slam") then return true; end;
	
	return true;
end


function eventPlayerActive ( name, userid, steamid )
	players[userid].spawn = vector3(0, 0, 0);
	players[userid].canSwitchTeam = true;
	players[userid].money = STARTING_MONEY;
end


