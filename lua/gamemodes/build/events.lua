

-- Trigger events
--

-- Blue team triggers

function BlueTeamEnter(activator, caller, level)
	local team = TEAM_BLUE;
	if (_PlayerInfo(activator, "team") == team) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			teams[team].padCount = teams[team].padCount + 1;
			if (teams[team].lastLevel == (level - 1)) then
				-- last level was reached
				if (teams[team].padCount == _TeamNumPlayers(team)) then
					-- all players are on the pad
					local scrmsg = teams[team].name .. " made it to level " .. level .. ".\n";
					
					_ScreenText(0, scrmsg,-1,0.2, 255, 100, 25, 255, 1,3, 6, 1, 1);				
					_TeamAddScore(team, levels[level].score);
					UpdateScores(0);
					teams[team].lastLevel = level;
					teams[team].padCount = 0;
					
					teams[team].levelsTime[level] = (_CurTime() - roundStartTime);
					UpdateScores(0);
					
					-- Check if this is the last level
					if (level == table.getn(levels)) then
						if (scorelimit > 0) and (_TeamScore(team) >= scorelimit) then
							-- Game over. The score limit has been reached
							_ScreenText(0, "Game over. Score limit has been reached",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							displayWhoWon();
							bEndGame = _CurTime() + _GetConVar_Float( "mp_chattime" );
						else
							_ScreenText(0, "Round over. " .. teams[team].name .. " made it to the last level",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
						end
					end
					
					if (levels[level].reward == 1) then
						messageInfo(0, 74, 0.4, teams[team].name .. " has been given the gravity freeze upgrade");
						reward(team, level);
					elseif (levels[level].reward == 2) then
						messageInfo(0, 74, 0.4, teams[team].name .. " can now spawn rpops ontop objects");
						reward(team, level);
					end
				else
					-- all the players aren't on the pad. issue a warning
					_PrintMessage(activator, 4, "You need all of your team on the pad");
				end
			else
				-- not at the right level. check to see what they should do
				if (teams[team].lastLevel == table.getn(levels)) then
					_PrintMessage(activator, 4, "You have completed all levels. Wait for time limit to expire");
				elseif (teams[team].lastLevel >= level) then
					_PrintMessage(activator, 4, "You have already activated this level. You need to build upward.");
				elseif (teams[team].lastLevel < level) then
					_PrintMessage(activator, 4, "You have not activated a previous level. You need to go back.");
				end
			end
		end
	end
end

function BlueTeamExit(activator, caller)
	if (_PlayerInfo(activator, "team") == TEAM_BLUE) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			if (teams[TEAM_BLUE].padCount > 0) then 
				teams[TEAM_BLUE].padCount = teams[TEAM_BLUE].padCount - 1;
			end
		end
	end
end


-- Yellow team triggers

function YellowTeamEnter(activator, caller, level)
	local team = TEAM_YELLOW;
	if (_PlayerInfo(activator, "team") == team) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			teams[team].padCount = teams[team].padCount + 1;
			if (teams[team].lastLevel == (level - 1)) then
				-- last level was reached
				if (teams[team].padCount == _TeamNumPlayers(team)) then
					-- all players are on the pad
					local scrmsg = teams[team].name .. " made it to level " .. level .. ".\n";
					
					_ScreenText(0, scrmsg,-1,0.2, 255, 100, 25, 255, 1,3, 6, 1, 1);				
					_TeamAddScore(team, levels[level].score);
					UpdateScores(0);
					teams[team].lastLevel = level;
					teams[team].padCount = 0;
					
					teams[team].levelsTime[level] = (_CurTime() - roundStartTime);
					UpdateScores(0);
					
					-- Check if this is the last level
					if (level == table.getn(levels)) then
						if (scorelimit > 0) and (_TeamScore(team) >= scorelimit) then
							-- Game over. The score limit has been reached
							_ScreenText(0, "Game over. Score limit has been reached",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							displayWhoWon();
							bEndGame = _CurTime() + _GetConVar_Float( "mp_chattime" );
						else
							_ScreenText(0, "Round over. " .. teams[team].name .. " made it to the last level",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
						end
					end
					
					if (levels[level].reward == 1) then
						messageInfo(0, 74, 0.4, teams[team].name .. " has been given the gravity freeze upgrade");
						reward(team, level);
					elseif (levels[level].reward == 2) then
						messageInfo(0, 74, 0.4, teams[team].name .. " can now spawn props ontop objects");
						reward(team, level);
					end
				else
					-- all the players aren't on the pad. issue a warning
					_PrintMessage(activator, 4, "You need all of your team on the pad");
				end
			else
				-- not at the right level. check to see what they should do
				if (teams[team].lastLevel == table.getn(levels)) then
					_PrintMessage(activator, 4, "You have completed all levels. Wait for time limit to expire");
				elseif (teams[team].lastLevel >= level) then
					_PrintMessage(activator, 4, "You have already activated this level. You need to build upward.");
				elseif (teams[team].lastLevel < level) then
					_PrintMessage(activator, 4, "You have not activated a previous level. You need to go back.");
				end
			end
		end
	end
end

function YellowTeamExit(activator, caller)
	if (_PlayerInfo(activator, "team") == TEAM_YELLOW) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			if (teams[TEAM_YELLOW].padCount > 0) then 
				teams[TEAM_YELLOW].padCount = teams[TEAM_YELLOW].padCount - 1;
			end
		end
	end
end


-- Green team triggers

function GreenTeamEnter(activator, caller, level)
	local team = TEAM_GREEN;
	if (_PlayerInfo(activator, "team") == team) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			teams[team].padCount = teams[team].padCount + 1;
			if (teams[team].lastLevel == (level - 1)) then
				-- last level was reached
				if (teams[team].padCount == _TeamNumPlayers(team)) then
					-- all players are on the pad
					local scrmsg = teams[team].name .. " made it to level " .. level .. ".\n";
					
					_ScreenText(0, scrmsg,-1,0.2, 255, 100, 25, 255, 1,3, 6, 1, 1);				
					_TeamAddScore(team, levels[level].score);
					UpdateScores(0);
					teams[team].lastLevel = level;
					teams[team].padCount = 0;
					
					teams[team].levelsTime[level] = (_CurTime() - roundStartTime);
					UpdateScores(0);
					
					-- Check if this is the last level
					if (level == table.getn(levels)) then
						if (scorelimit > 0) and (_TeamScore(team) >= scorelimit) then
							-- Game over. The score limit has been reached
							_ScreenText(0, "Game over. Score limit has been reached",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							displayWhoWon();
							bEndGame = _CurTime() + _GetConVar_Float( "mp_chattime" );
						else
							_ScreenText(0, "Round over. " .. teams[team].name .. " made it to the last level",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
						end
					end
					
					if (levels[level].reward == 1) then
						messageInfo(0, 74, 0.4, teams[team].name .. " has been given the gravity freeze upgrade");
						reward(team, level);
					elseif (levels[level].reward == 2) then
						messageInfo(0, 74, 0.4, teams[team].name .. " can now spawn props ontop objects");
						reward(team, level);
					end
				else
					-- all the players aren't on the pad. issue a warning
					_PrintMessage(activator, 4, "You need all of your team on the pad");
				end
			else
				-- not at the right level. check to see what they should do
				if (teams[team].lastLevel == table.getn(levels)) then
					_PrintMessage(activator, 4, "You have completed all levels. Wait for time limit to expire");
				elseif (teams[team].lastLevel >= level) then
					_PrintMessage(activator, 4, "You have already activated this level. You need to build upward.");
				elseif (teams[team].lastLevel < level) then
					_PrintMessage(activator, 4, "You have not activated a previous level. You need to go back.");
				end
			end
		end
	end
end

function GreenTeamExit(activator, caller)
	if (_PlayerInfo(activator, "team") == TEAM_GREEN) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			if (teams[TEAM_GREEN].padCount > 0) then 
				teams[TEAM_GREEN].padCount = teams[TEAM_GREEN].padCount - 1;
			end
		end
	end
end


-- Red team triggers

function RedTeamEnter(activator, caller, level)
	local team = TEAM_RED;
	if (_PlayerInfo(activator, "team") == team) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			teams[team].padCount = teams[team].padCount + 1;
			if (teams[team].lastLevel == (level - 1)) then
				-- last level was reached
				if (teams[team].padCount == _TeamNumPlayers(team)) then
					-- all players are on the pad
					local scrmsg = teams[team].name .. " made it to level " .. level .. ".\n";
					
					_ScreenText(0, scrmsg,-1,0.2, 255, 100, 25, 255, 1,3, 6, 1, 1);				
					_TeamAddScore(team, levels[level].score);
					UpdateScores(0);
					teams[team].lastLevel = level;
					teams[team].padCount = 0;
					
					teams[team].levelsTime[level] = (_CurTime() - roundStartTime);
					UpdateScores(0);
					
					-- Check if this is the last level
					if (level == table.getn(levels)) then
						if (scorelimit > 0) and (_TeamScore(team) >= scorelimit) then
							-- Game over. The score limit has been reached
							_ScreenText(0, "Game over. Score limit has been reached",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							displayWhoWon();
							bEndGame = _CurTime() + _GetConVar_Float( "mp_chattime" );
						else
							_ScreenText(0, "Round over. " .. teams[team].name .. " made it to the last level",-1,0.15, 0, 0, 255, 255, 1,3, 6, 1, 3);
							RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
						end
					end
					
					if (levels[level].reward == 1) then
						messageInfo(0, 74, 0.4, teams[team].name .. " has been given the gravity freeze upgrade");
						reward(team, level);
					elseif (levels[level].reward == 2) then
						messageInfo(0, 74, 0.4, teams[team].name .. " can now spawn props ontop objects");
						reward(team, level);
					end
				else
					-- all the players aren't on the pad. issue a warning
					_PrintMessage(activator, 4, "You need all of your team on the pad");
				end
			else
				-- not at the right level. check to see what they should do
				if (teams[team].lastLevel == table.getn(levels)) then
					_PrintMessage(activator, 4, "You have completed all levels. Wait for time limit to expire");
				elseif (teams[team].lastLevel >= level) then
					_PrintMessage(activator, 4, "You have already activated this level. You need to build upward.");
				elseif (teams[team].lastLevel < level) then
					_PrintMessage(activator, 4, "You have not activated a previous level. You need to go back.");
				end
			end
		end
	end
end

function RedTeamExit(activator, caller)
	if (_PlayerInfo(activator, "team") == TEAM_RED) then
		if ((bEndGame == 0) and (RestartRound == 0)) then
			if (teams[TEAM_RED].padCount > 0) then 
				teams[TEAM_RED].padCount = teams[TEAM_RED].padCount - 1;
			end
		end
	end
end

--======================


function eventPlayerSpawn (userid)
	if (_PlayerInfo(userid, "team") == TEAM_SPECTATOR) then
		UpdateScores(userid);
		onShowTeam(userid);
	end
	_PlayerSetDrawTeamCircle(userid, true);
end

function eventPlayerKilled ( killed, attacker, weapon )		
	_PlayerAddDeath(killed, 1);
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
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	if (ENABLE_PHYSGUN_PICKUP) then
		_EntFire(entity, "color", "255 255 255", 0);
		return true;
	end;
		
	return false;
end;

function onGravGunPunt( player, entity)
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;

	_EntFire(entity, "color", "255 255 255", 0);
	return true;
end;
function onGravGunPickup( player, entity )
	if (entities[entity] ~= _PlayerInfo(player, "team")) then return false; end;
	
	_EntFire(entity, "color", "255 255 255", 0);
	return true;
end;

function onGravGunDrop( player, entity)
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
	
	return true;
end

function canPlayerHaveItem( playerid, itemname )
	if (itemname == "weapon_propmaker") and (not dm_mode) then return true; end;
	if (itemname == "weapon_propremover") and (not dm_mode) then return true; end;
	if (itemname == "weapon_prop_freeze") and (not dm_mode) then return true; end;
	if (itemname == "weapon_physgun") then return true; end;
	if (itemname == "weapon_physcannon") then return true; end;
	
	if (dm_mode) then
		if (itemname == "weapon_shotgun") then return true; end;
		if (itemname == "weapon_smg1") then return true; end;
	end
	
	return false;
end

function eventPlayerActive ( name, userid, steamid )
	players[userid].canSwitchTeam = true;
end


