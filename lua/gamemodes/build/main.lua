
-- Settings

scorelimit = 7;

ENABLE_PHYSGUN_PICKUP = false;
FREEZE_ON_GRAVGUN_DROP = false;
SPAWN_PROPS_GROUND_ONLY = true;

DEATH_MATCH = false;
DEATH_MATCH_TIMER = 8; -- every 8 minutes issue deathmatch mode
DEATH_MATCH_LENGTH = 3; -- deathmatch lasts for 4 minutes

--====================================
--Don't edit below this line
--====================================

--round_timelimit = 16; -- in minutes

gameStartTime = 0;
roundStartTime = 0;
RestartRound = 0;
bEndGame = 0;

tCountup = -2;

tDeathmatch = -1;

fDeathmatch_time = 0;
sDeathmatch_time = DEATH_MATCH_TIMER * 60;

fDeathmatch_len = 0;
sDeathmatch_len = DEATH_MATCH_LENGTH * 60;

dm_mode = false;


players = {};
for i=1, _MaxPlayers() do
	players[i] = {};
	players[i].canSwitchTeam = true;
end

entities = {};

levels = {};

levels[1] = {
	score = 1;
	reward = 1;
};

levels[2] = {
	score = 1;
	reward = 2;
};

levels[3] = {
	score = 1;
	reward = 0;
};


teams = {};

teams[TEAM_BLUE] = {
	name = "Blue Team",
	color = {r=50,g=150,b=255};
	padCount = 0,
	lastLevel = 0,
	reward = 0,
	levelsTime = {}
};
for i in levels do teams[TEAM_BLUE].levelsTime[i] = 0 end

teams[TEAM_YELLOW] = {
	name = "Yellow Team",
	color = {r=255,g=200,b=0};
	padCount = 0,
	lastLevel = 0,
	reward = 0,
	levelsTime = {}
};
for i in levels do teams[TEAM_YELLOW].levelsTime[i] = 0 end

teams[TEAM_GREEN] = {
	name = "Green Team",
	color = {r=50,g=255,b=150};
	padCount = 0,
	lastLevel = 0,
	reward = 0,
	levelsTime = {}
};
for i in levels do teams[TEAM_GREEN].levelsTime[i] = 0 end

teams[TEAM_RED] = {
	name = "Red Team",
	color = {r=255,g=100,b=100};
	padCount = 0,
	lastLevel = 0,
	reward = 0,
	levelsTime = {}
};
for i in levels do teams[TEAM_RED].levelsTime[i] = 0 end


_OpenScript("gamemodes/build/gui.lua")
_OpenScript("gamemodes/build/events.lua")
_OpenScript("gamemodes/build/misc.lua")
_OpenScript("gamemodes/build/admin.lua")
_OpenScript("gamemodes/build/adminlist.lua")


--====


function gamerulesThink ()
	-- Time to initiate deathmatch mode
	if (DEATH_MATCH) and (fDeathmatch_time <= _CurTime())
		and (bEndGame == 0) and (RestartRound == 0)
		and (not dm_mode)
	then
		messageInfo(0, 82, 0.3, "Deathmatch mode has begun!")
		StartDeathmatch();
	end
	
	if (DEATH_MATCH) and (fDeathmatch_len <= _CurTime())
		and (bEndGame == 0) and (RestartRound == 0)
		and (dm_mode)
	then
		messageInfo(0, 82, 0.3, "Deathmatch is over")
		EndDeathmatch();
	end
	
	if (bEndGame > 0) and (bEndGame <= _CurTime()) then
		HaltTimer(tCountup);
		-- reset scores
		_TeamSetScore(TEAM_BLUE, 0);
		_TeamSetScore(TEAM_YELLOW, 0);
		_TeamSetScore(TEAM_GREEN, 0);
		_TeamSetScore(TEAM_RED, 0);
		
		removeAllProps();
		
		local i = 1;
		for i=1, _MaxPlayers() do
			if (_PlayerInfo(i, "alive")) then
				_PlayerRemoveAllWeapons(i);
				_PlayerRespawn(i);
				players[i].canSwitchTeam = true;
			end;
		end
		
		for i in teams do
			teams[i].padCount = 0;
			teams[i].lastLevel = 0;
			teams[i].reward = 0;
		end
		
		UpdateScores(0);
		
		bEndGame = 0;
		roundStartTime = _CurTime();
		gameStartTime = _CurTime();
		
		tCountup = AddTimer(1, 0, doCountup);
		
		HaltTimer(tDeathmatch);
		dm_mode = false;
		fDeathmatch_time = _CurTime() + sDeathmatch_time;
		if DEATH_MATCH then
			tDeathmatch = AddTimer(1, sDeathmatch_time, doCountDeathmatch);
		end
		
	elseif (RestartRound > 0) and (RestartRound <= _CurTime()) then
		HaltTimer(tCountup);
		removeAllProps();
		
		local i = 1;
		for i=1, _MaxPlayers() do
			if (_PlayerInfo(i, "alive")) then
				_PlayerRespawn(i);
				players[i].canSwitchTeam = true;
			end
		end
		
		for i in teams do
			teams[i].padCount = 0;
			teams[i].lastLevel = 0;
			teams[i].reward = 0;
		end
		
		UpdateScores(0);
		roundStartTime = _CurTime();
		
		RestartRound = 0;
		
		tCountup = AddTimer(1, 0, doCountup);
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
	
	tCountup = AddTimer(1, 0, doCountup);
end

function StartDeathmatch()
	HaltTimer(tDeathmatch);
	toggleWalls();
	
	for i=1, _MaxPlayers() do
		if (_PlayerInfo(i, "alive")) then
			_PlayerGiveItem(i, "weapon_shotgun");
			_PlayerGiveItem(i, "weapon_smg1");
			_PlayerGiveAmmo(i, 128, "Buckshot", false);
			_PlayerGiveAmmo(i, 255, "SMG1", false);
			
			_PlayerRemoveWeapon(i, "weapon_propmaker");
			_PlayerRemoveWeapon(i, "weapon_propremover");
			_PlayerRemoveWeapon(i, "weapon_prop_freeze");
		end
	end
	
	dm_mode = true;
	fDeathmatch_len = _CurTime() + sDeathmatch_len;
	tDeathmatch = AddTimer(1, sDeathmatch_len, doCountDMLen);
end

function EndDeathmatch()
	HaltTimer(tDeathmatch);
	toggleWalls();
	
	for i=1, _MaxPlayers() do
		if (_PlayerInfo(i, "alive")) then
			_PlayerRemoveWeapon(i, "weapon_shotgun");
			_PlayerRemoveWeapon(i, "weapon_smg1");
			_PlayerRemoveAllAmmo(i);
			
			_PlayerGiveSWEP(i, "weapons/build/weapon_propmaker.lua");
			_PlayerGiveSWEP(i, "weapons/build/weapon_remover.lua");
			_PlayerGiveSWEP(i, "weapons/build/weapon_freeze.lua");
		end
	end
	
	dm_mode = false;
	fDeathmatch_time = _CurTime() + sDeathmatch_time;
	tDeathmatch = AddTimer(1, sDeathmatch_time, doCountDeathmatch);
end


function doCountdown ()
	if (bEndGame == 0) and (RestartRound == 0) then
		UpdateRoundTime(0, math.time(FRound_timelimit - _CurTime()));
	end
end

function doCountup ()
	if (bEndGame == 0) and (RestartRound == 0) then
		UpdateRoundTime(0, math.time((_CurTime() - roundStartTime)));
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
		_PlayerGiveItem(playerid, "weapon_physgun");
		
		if (not dm_mode) then
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_propmaker.lua");
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_remover.lua");
			_PlayerGiveSWEP(playerid, "weapons/build/weapon_freeze.lua");
		end
		
		if (dm_mode) then
			_PlayerGiveItem(playerid, "weapon_shotgun");
			_PlayerGiveItem(playerid, "weapon_smg1");
			_PlayerGiveAmmo(playerid, 128, "Buckshot", false);
			_PlayerGiveAmmo(playerid, 255, "SMG1", false);
		end
	end
end



function displayWhoWon ()
	if (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_YELLOW))
		and (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_BLUE) > _TeamScore(TEAM_RED))
	then
		-- blue team won
		messageInfo(0, 83, 0.2, "Blue team won the game!")
	elseif (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_YELLOW) > _TeamScore(TEAM_RED))
	then
		-- yellow team won
		messageInfo(0, 83, 0.2, "Yellow team won the game!")
	elseif (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_YELLOW))
		and (_TeamScore(TEAM_GREEN) > _TeamScore(TEAM_RED))
	then
		-- green team won
		messageInfo(0, 83, 0.2, "Green team won the game!")
	elseif (_TeamScore(TEAM_RED) > _TeamScore(TEAM_BLUE))
		and (_TeamScore(TEAM_RED) > _TeamScore(TEAM_GREEN))
		and (_TeamScore(TEAM_RED) > _TeamScore(TEAM_YELLOW))
	then
		-- red team won
		messageInfo(0, 83, 0.2, "Red team won the game!")
	else
		-- draw
		messageInfo(0, 83, 0.2, "It was a tie game")
	end
end


-- Admin commands

function cc_removeAllProps (fromplayer, args)
	if (isAdmin(fromplayer)) then
		local props = _EntitiesFindByClass("prop_physics");
		for i,v in ipairs(props) do
			_EntRemove(v);
		end
		message(0, 99, -1, 0.3, 3, _PlayerInfo(fromplayer,"name") .. " removed all props.")
	end
end

function cc_restartRound (fromplayer, args)
	if (isAdmin(fromplayer)) then
		--FRound_timelimit = _CurTime();
		message(0, 99, -1, 0.3, 3, "Round over. " .. _PlayerInfo(fromplayer,"name") .. " restarted the round")
		roundStartTime = _CurTime();
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
			messageInfo(0, 85, 0.2, "Deathmatch has been enabled")
			
			DEATH_MATCH = true;
			dm_mode = false;
			HaltTimer(tDeathmatch);
			fDeathmatch_time = _CurTime() + sDeathmatch_time;
			tDeathmatch = AddTimer(1, sDeathmatch_time, doCountDeathmatch);
		elseif (args == "0") then
			HaltTimer(tDeathmatch);
			DEATH_MATCH = false;
			
			for i=1, _MaxPlayers() do
				if (_PlayerInfo(i, "alive")) then
					_PlayerRemoveWeapon(i, "weapon_shotgun");
					_PlayerRemoveAllAmmo(i);
				end
			end
		
			messageInfo(0, 85, 0.2, "Deathmatch has been disabled")
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

