
-- Settings

scorelimit = 6;

ENABLE_PHYSGUN_PICKUP = true;
FREEZE_ON_GRAVGUN_DROP = true;
SPAWN_PROPS_GROUND_ONLY = false;

NUM_TEAMS = 2; -- how many teams there will be, has to be 2, 3, or 4

AUTO_SWITCH = false; -- set this to true to enable auto-switching to even teams

DEATH_MATCH = true;
DEATH_MATCH_TIMER = 8; -- every 8 minutes issue deathmatch mode (how long build mode lasts)
DEATH_MATCH_LENGTH = 10; -- deathmatch lasts for 10 minutes

STARTING_MONEY = 200; -- how much money players start out with

MONEY_KILL_AMOUNT = 50; -- how much money to give per kill
FLAG_SCORE_MONEY = 100; -- how much money the person holding the flag gets when he scores for his team

--====================================
--Don't edit below this line
--====================================

flag = 0;
flagCarrier = 0;

gameStartTime = 0;
roundStartTime = 0;
RestartRound = 0;
bEndGame = 0;

tDeathmatch = -1;
tFlagTime = -2; -- timer for the flagtime

fDeathmatch_time = 0;
sDeathmatch_time = DEATH_MATCH_TIMER * 60;

fDeathmatch_len = 0;
sDeathmatch_len = DEATH_MATCH_LENGTH * 60;

dm_mode = true;

entities = {};

players = {};

for i=1, _MaxPlayers() do
	players[i] = {};
	players[i].spawn = vector3(0, 0, 0);
	players[i].canSwitchTeam = true;
	players[i].money = STARTING_MONEY;
end;

--FRound_timelimit = 0;
--sRound_timelimit = round_timelimit * 60;
--tCountdown = 0;

teams = {};

teams[TEAM_BLUE] = {
	name = "Blue Team",
	color = {r=50,g=150,b=255},
	hasFlag = false,
	flagTime = 0
};

teams[TEAM_YELLOW] = {
	name = "Yellow Team",
	color = {r=255,g=200,b=0},
	hasFlag = false,
	flagTime = 0,
};

teams[TEAM_GREEN] = {
	name = "Green Team",
	color = {r=50,g=255,b=150},
	hasFlag = false,
	flagTime = 0
};

teams[TEAM_RED] = {
	name = "Red Team",
	color = {r=255,g=100,b=100},
	hasFlag = false,
	flagTime = 0
};


_OpenScript("gamemodes/build/fortwars/gui.lua")
_OpenScript("gamemodes/build/fortwars/events.lua")
_OpenScript("gamemodes/build/fortwars/misc.lua")
_OpenScript("gamemodes/build/fortwars/admin.lua")
_OpenScript("gamemodes/build/adminlist.lua")


--====


function gamerulesThink ()
	-- Time to initiate deathmatch mode

	if (DEATH_MATCH) and (fDeathmatch_time <= _CurTime())
		and (bEndGame == 0) and (RestartRound == 0)
		and (not dm_mode)
	then
		messageInfo(0, 67, 0.3, "Deathmatch mode has begun!");
		StartDeathmatch();
	end


	if (DEATH_MATCH) and (fDeathmatch_len <= _CurTime())
		and (bEndGame == 0) and (RestartRound == 0)
		and (dm_mode)
	then
		removeAllPlayersWeapons();
		if (scorelimit > 0) and
			((_TeamScore(TEAM_BLUE) >= scorelimit) or (_TeamScore(TEAM_YELLOW) >= scorelimit)
			or (_TeamScore(TEAM_GREEN) >= scorelimit) or (_TeamScore(TEAM_RED) >= scorelimit))
		then
			-- Game over. The score limit has been reached
			messageInfo(0, 67, 0.3, "Game over. Score limit has been reached");
			displayWhoWon();
			bEndGame = _CurTime() + _GetConVar_Float( "mp_chattime" );
		else
			messageInfo(0, 67, 0.3, "Deathmatch is over. Starting new round...");
			RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
		end
	end

	
	if (bEndGame > 0) and (bEndGame <= _CurTime()) then
		-- reset scores
		_TeamSetScore(TEAM_BLUE, 0);
		_TeamSetScore(TEAM_YELLOW, 0);
		_TeamSetScore(TEAM_GREEN, 0);
		_TeamSetScore(TEAM_RED, 0);
		
		removeAllProps();
		EndDeathmatch();
		
		local i = 1;
		for i=1, _MaxPlayers() do
			if (_PlayerInfo(i, "alive")) then
				_PlayerRemoveAllWeapons(i);
				_PlayerRespawn(i);
				players[i].canSwitchTeam = true;
			end;
			players[i].money = STARTING_MONEY;
		end
		
		for i in teams do
			teams[i].hasFlag = false;
			teams[i].flagTime = 0;
		end
		
		UpdateScores(0);
		
		bEndGame = 0;
		roundStartTime = _CurTime();
		gameStartTime = _CurTime();
		
	elseif (RestartRound > 0) and (RestartRound <= _CurTime()) then
		removeAllProps();
		EndDeathmatch();
		
		local i = 1;
		for i=1, _MaxPlayers() do
			if (_PlayerInfo(i, "alive")) then
				_PlayerRespawn(i);
				players[i].canSwitchTeam = true;
			end
		end
		
		for i in teams do
			teams[i].hasFlag = false;
			teams[i].flagTime = 0;
		end
		
		UpdateScores(0);
		roundStartTime = _CurTime();
		RestartRound = 0;
	end
end

function gamerulesStartMap ()	
	PlayerFreezeAll(false);
	_TeamSetName(TEAM_BLUE, "Blue Team");
	_TeamSetName(TEAM_YELLOW, "Yellow Team");
	_TeamSetName(TEAM_GREEN, "Green Team");
	_TeamSetName(TEAM_RED, "Red Team");
	
	UpdateScores(0);

	gameStartTime = _CurTime();
	roundStartTime = _CurTime();
	
	if DEATH_MATCH then
		dm_mode = false;
		fDeathmatch_time = _CurTime() + sDeathmatch_time;
		tDeathmatch = AddTimer(1, 0, doCountDeathmatch);
	end
end


function EndDeathmatch()
	msgDebug("****** stop deathmatch");
	toggleWalls();
	_GModRect_Hide(0, 99, 0, 0);
	
	HaltTimer(tDeathmatch);
	HaltTimer(tFlagTime);
	if (flag > 0) then
		_EntRemove(flag);
		flag = 0;
	end;
	
	for i=1, _MaxPlayers() do
		--reset spawn pos
		resetSpawnPoint(i);
		
		if (_PlayerInfo(i, "alive")) then
			_PlayerGiveSWEP(i, "weapons/build/weapon_propmaker.lua");
			_PlayerGiveSWEP(i, "weapons/build/weapon_freeze.lua");
			_PlayerGiveSWEP(i, "weapons/build/weapon_spawn.lua");
			_PlayerGiveItem(i, "weapon_physgun");
		end
	end
	
	dm_mode = false;
	fDeathmatch_time = _CurTime() + sDeathmatch_time;
	if DEATH_MATCH then
		tDeathmatch = AddTimer(1, 0, doCountDeathmatch);
	end
end

function StartDeathmatch()
	msgDebug("****** start deathmatch");
	toggleWalls();
	
	HaltTimer(tDeathmatch);
	HaltTimer(tFlagTime);
	
	for i=1, _MaxPlayers() do
		if (_PlayerInfo(i, "alive")) then
			_PlayerGiveItem(i, "weapon_pistol");
			_PlayerGiveItem(i, "weapon_smg1");
			_PlayerGiveAmmo(i, 256, "pistol", false);
			_PlayerGiveAmmo(i, 90, "SMG1", false);
			
			_PlayerRemoveWeapon(i, "weapon_propmaker");
			_PlayerRemoveWeapon(i, "weapon_propremover");
			_PlayerRemoveWeapon(i, "weapon_prop_freeze");
			_PlayerRemoveWeapon(i, "weapon_spawn");
			_PlayerRemoveWeapon(i, "weapon_physgun");
		end
	end
	
	if (flag > 0) then
		_EntRemove(flag);
		flag = 0;
	end;
	
	createFlag();
	dm_mode = true;
	fDeathmatch_len = _CurTime() + sDeathmatch_len;
	
	if DEATH_MATCH then
		tDeathmatch = AddTimer(1, 0, doCountDMLen);
	end
end
		

function doCountDeathmatch ()
	if (bEndGame == 0) and (RestartRound == 0) then
		UpdateDMTime(0, 0,  math.time(fDeathmatch_time - _CurTime()));
	end
end

function doCountDMLen ()
	if (bEndGame == 0) and (RestartRound == 0) then
		UpdateDMTime(0, 1,  math.time(fDeathmatch_len - _CurTime()));
	end
end


function PickDefaultSpawnTeam(userid)		
	_PlayerChangeTeam(userid, TEAM_SPECTATOR);
	return true;
end

function GiveDefaultItems (playerid)
	if (_PlayerInfo(playerid, "alive"))
		and (_PlayerInfo(playerid, "team") ~= TEAM_SPECTATOR)
	then
		_PlayerGiveItem(playerid, "weapon_physcannon");
		if (not dm_mode) then
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_propmaker.lua");
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_freeze.lua");
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_spawn.lua");
			_PlayerGiveItem(playerid, "weapon_physgun");
		end
		
		if (dm_mode) then
			_PlayerGiveItem(playerid, "weapon_pistol");
			_PlayerGiveItem(playerid, "weapon_smg1");
			_PlayerGiveAmmo(playerid, 255, "pistol", false);
			_PlayerGiveAmmo(playerid, 90, "SMG1", false);
		end
	end
end



function displayWhoWon ()
	if (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_YELLOW))
		and (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_RED))
	then
		-- blue team won
		messageInfo(0, 68, 0.2, "Blue team won the game!");
	elseif (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_RED))
	then
		-- yellow team won
		messageInfo(0, 68, 0.2, "Yellow team won the game!");
	elseif (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_YELLOW))
		and (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_RED))
	then
		-- green team won
		messageInfo(0, 68, 0.2, "Green team won the game!");
	elseif (_TeamScore(TEAM_RED) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_RED) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_RED) > _TeamScore(TEAM_YELLOW))
	then
		-- red team won
		messageInfo(0, 68, 0.2, "Red team won the game!");
	else
		-- draw
		messageInfo(0, 68, 0.2, "It was a tie game");
	end
end


-- Admin commands

function cc_removeAllProps (fromplayer, args)
	if (isAdmin(fromplayer)) then
		local props = _EntitiesFindByClass("prop_physics");
		for i,v in props do
			_EntRemove(v);
		end
		message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " removed all props.")
	end
end

function cc_restartRound (fromplayer, args)
	if (isAdmin(fromplayer)) then
		message(0, 99, -1, 0.3, 3, "Round over. " .. _PlayerInfo(fromplayer,"name") .. " restarted the round")
		
		if dm_mode then
			removeAllPlayersWeapons();
			toggleWalls();
		end
		
		RestartRound = _CurTime() + _GetConVar_Float( "mp_chattime" );
	end
end

function cc_enablePhysgunPickup (fromplayer, args)
	if (isAdmin(fromplayer)) then
		if (args == "1") then
			ENABLE_PHYSGUN_PICKUP = true;
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " enabled physgun pickup");
		elseif (args == "0") then
			ENABLE_PHYSGUN_PICKUP = false;
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " disabled physgun pickup");
		end
	end
end

function cc_enableFreezeGravGunDrop(fromplayer, args)
	if (isAdmin(fromplayer)) then
		if (args == "1") then
			FREEZE_ON_GRAVGUN_DROP = true;
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " enabled gravgun freezing");
		elseif (args == "0") then
			FREEZE_ON_GRAVGUN_DROP = false
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " disabled gravgun freezing");
		end
	end
end

function cc_spawnPropGround(fromplayer, args)
	if (isAdmin(fromplayer)) then
		if (args == "1") then
			SPAWN_PROPS_GROUND_ONLY = true;
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " enabled spawning of props on ground only");
		elseif (args == "0") then
			SPAWN_PROPS_GROUND_ONLY = false
			message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " disabled spawning of props on ground only");
		end
	end
end

function cc_setTimeLimit (fromplayer, args)
	if (isAdmin(fromplayer)) then
		if tonumber(args) then
			round_timelimit = args;
			sRound_timelimit = round_timelimit * 60;
		end
	end
end

function cc_setScoreLimit (fromplayer, args)
	if (isAdmin(fromplayer)) then
		if tonumber(args) then
			scorelimit = args;
		end
	end
end

function cc_setDeathmatchMode (fromplayer, args)
	if (isAdmin(fromplayer)) then
		if (args == "1") then
			if dm_mode then
				messageInfo(fromplayer, 85, 0.25, "Error: deathmatch mode is already on");
			else
				messageInfo(0, 85, 0.25, "Deathmatch has been enabled");
				fDeathmatch_time = _CurTime();
			end
		elseif (args == "0") then
			if dm_mode then
				messageInfo(0, 85, 0.25, "Deathmatch has been terminated");
			
				fDeathmatch_len = _CurTime()
			else
				messageInfo(fromplayer, 85, 0.25, "Error: deathmatch mode is already off");
			end
		end
	end
end

function cc_toggleWalls(fromplayer, args)
	if (isAdmin(fromplayer)) then
		toggleWalls();
	end
end

function cc_changeNumTeams(fromplayer, args)
	if (isAdmin(fromplayer)) then
		if (args == "2") then
			NUM_TEAMS = 2;
		elseif (args == "3") then
			NUM_TEAMS = 3;
		elseif (args == "4") then
			NUM_TEAMS = 4;
		end
	end
end

CONCOMMAND("bg_removeallprops", cc_removeAllProps);
CONCOMMAND("bg_restartround", cc_restartRound);
CONCOMMAND("bg_physgunpickup", cc_enablePhysgunPickup);
CONCOMMAND("bg_gravgunfreeze", cc_enableFreezeGravGunDrop);
CONCOMMAND("bg_spawngroundonly", cc_spawnPropGround);
CONCOMMAND("bg_timelimit", cc_setTimeLimit);
CONCOMMAND("bg_scorelimit", cc_setScoreLimit);
CONCOMMAND("bg_deathmatch", cc_setDeathmatchMode);
CONCOMMAND("bg_togglewalls", cc_toggleWalls);
CONCOMMAND("bg_numteams", cc_changeNumTeams);

