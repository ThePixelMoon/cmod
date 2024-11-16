DEBUG_MSGS = false;

function toggleWalls()
    local walls = _EntitiesFindByClass("func_wall_toggle");
    for i, v in walls do _EntFire(v, "toggle", 0, 0); end
end

function setSpawnPoint(Owner)
    players[Owner].spawn = _EntGetPos(Owner);
    message(Owner, 98, -1, 0.3, 4, "Your spawn point as been set");
end

function resetSpawnPoint(userid)
    if (userid) and (userid > 0) and (userid <= _MaxPlayers()) then
        players[userid].spawn.x = 0;
        players[userid].spawn.y = 0;
        players[userid].spawn.z = 0;

        message(userid, 98, -1, 0.3, 4, "Your spawn point as been reset");
    end
end

function msgDebug(msg) if DEBUG_MSGS then _Msg(msg .. "\n"); end end

function testHealthChange(activator, caller)
    msgDebug("act " .. activator .. " caller: " .. caller);
    if entities[caller].r > 5 then
        entities[caller].r = entities[caller].r - 5;
    end
    _EntFire(caller, "color",
             entities[caller].r .. " " .. entities[caller].g .. " " ..
                 entities[caller].b, 0);
end

function createRunEnt()
    local ent = _EntCreate("gmod_runfunction");
    msgDebug(ent);
    if (ent > 0) then
        _EntSetKeyValue(ent, "targetname", "func_HealthChanged01");
        _EntSetKeyValue(ent, "FunctionName", "testHealthChange");
        _EntSpawn(ent);
        _EntActivate(ent);
    end
end

function createFlag()
    if flag then msgDebug("****** flag: " .. flag); end
    if (flag > 0) then
        _EntRemove(flag);
        flag = 0;
    end

    -- setpos 	-262.703766 	281.776917 	2927.726563
    -- setpos 	-849.718262 	207.219238 	2950.437500
    -- setpos 	-935.451660 	880.663330 	2950.437500
    -- setpos 	-84.708145 	893.179260 	2950.437500
    -- setpos 	-532.375244 	490.952148 	3219.899414

    -- flag_model = "models/bm/basketball.mdl";
    flag_model = "models/Roller.mdl";

    local prop = _EntCreate("prop_physics");
    if (prop > 0) then
        _EntSetKeyValue(prop, "targetname", "flag01");
        _EntSetKeyValue(prop, "model", flag_model);
        -- _EntSetPos(prop, vector3(math.random(-2000,-800), math.random(-200,400), 2960));

        _EntSetPos(prop, vector3(math.random(-600, -400), math.random(400, 600),
                                 2950));

        _EntSpawn(prop);

        _GModRect_Start("matsys_regressiontest/background");
        _GModRect_SetPos(0, 0, 0.035, 0.035);
        _GModRect_SetColor(255, 255, 255, 255);
        _GModRect_SetTime(99999, 0, 0);
        _GModRect_SetDelay(0);
        _GModRect_SetEntityOffset(vector3(0, 0, 16));
        _GModRect_SetEntity(prop);
        _GModRect_Send(0, 99);

        flag = prop;
        msgDebug("****** create flag: " .. flag);
    end
end

function doFlagTime(team)
    teams[team].flagTime = teams[team].flagTime + 1;
    if (math.mod(teams[team].flagTime, 60) == 0) then
        _TeamAddScore(team, 1);
        if (IsPlayer(flagCarrier)) then
            players[flagCarrier].money =
                players[flagCarrier].money + FLAG_SCORE_MONEY;
            drawMoneyAmmount(flagCarrier);
        end
    end
    UpdateScores(0);
end

function playerCanUse(player, entity)
    if (entities[entity] == _PlayerInfo(player, "team")) then return true; end
    return false;
end

function createProp(Owner, model, posx, posy, posz, hitWorld)
    local cost = 5;
    if (model == "models/props_junk/wood_crate002a.mdl") then cost = 10; end

    if (hitWorld == false) and (SPAWN_PROPS_GROUND_ONLY) then
        _PrintMessage(Owner, 4, "You can only spawn props on the ground");
    elseif (players[Owner].money < cost) then
        _PrintMessage(Owner, 4, "You don't have enough money to build this prop");
    else
        local prop = _EntCreate("prop_physics");
        msgDebug(prop);
        if (prop > 0) then
            _EntSetKeyValue(prop, "targetname", "crate01");
            _EntSetKeyValue(prop, "model", model);
            -- _EntSetKeyValue(prop, "spawnflags", "256");

            local plyang = _EntGetAng(Owner);
            _EntSetPos(prop, vector3(posx, posy, posz));
            _EntSetAng(prop, vector3(plyang.x, plyang.y, 0));

            _EntSpawn(prop);

            entities[prop] = _PlayerInfo(Owner, "team");

            -- _EntFire(prop, "color", entities[prop].r .." ".. entities[prop].g .." ".. entities[prop].b, 0);

            _EntFire(prop, "SetHealth", "1000", 0);
            -- _EntFire(prop, "AddOutput", "OnHealthChanged func_HealthChanged01,RunScript,0,0,-1", 0);

            -- _EntFire(prop, "AddOutput", "OnPlayerUse crate01,color,255 0 0,0,-1", 0);
        end
        players[Owner].money = players[Owner].money - cost;
        drawMoneyAmmount(Owner);
    end
end

function removeProp(Owner, entity)
    if (playerCanUse(Owner, entity)) then
        if (_EntGetType(entity) == "prop_physics") then
            _EntRemove(entity);
            entities[entity] = 0;
        end
    end
end

function freezeProp(Owner, entity)
    if (playerCanUse(Owner, entity)) then
        _PhysEnableMotion(entity, false);

        if (_PlayerInfo(Owner, "team") == TEAM_BLUE) then
            _EntFire(entity, "color", "50 150 255", 0);
        elseif (_PlayerInfo(Owner, "team") == TEAM_YELLOW) then
            _EntFire(entity, "color", "255 200 0", 0);
        elseif (_PlayerInfo(Owner, "team") == TEAM_GREEN) then
            _EntFire(entity, "color", "50 255 150", 0);
        elseif (_PlayerInfo(Owner, "team") == TEAM_RED) then
            _EntFire(entity, "color", "255 100 100", 0);
        else
            _EntFire(entity, "color", "0 0 255", 0);
        end
    end
end

function unfreezeProp(Owner, entity)
    if (playerCanUse(Owner, entity)) then
        _PhysEnableMotion(entity, true);
        _PhysWake(entity);
        _EntFire(entity, "color", "255 255 255", 0);
    end
end

function reward(team, level)
    if (level == 1) or (level == 2) then teams[team].reward = level; end
end

function sendmessage(userid, key, posx, posy, r, g, b, stime, text)
    _GModText_Start("HudHintTextLarge");
    _GModText_SetPos(posx, posy);
    _GModText_SetColor(r, g, b, 255);
    _GModText_SetTime(stime, 0.5, 1.5);
    _GModText_SetText(text);
    _GModText_SetDelay(0);
    _GModText_Send(userid, key);
end

function message(userid, key, posx, posy, stime, text)
    sendmessage(userid, key, posx, posy, 255, 255, 255, stime, text);
end

function messageMenu(userid, key, posx, posy, stime, text)
    sendmessage(userid, key, posx, posy, 255, 200, 50, stime, text);
end

function messageAttn(userid, key, posx, posy, stime, text)
    sendmessage(userid, key, posx, posy, 255, 0, 0, stime, text);
end

function messageInfo(userid, key, posy, text)
    _GModText_Start("TargetID");
    _GModText_SetPos(-1, posy);
    _GModText_SetColor(255, 255, 255, 255);
    _GModText_SetTime(8, 0.5, 1.5);
    _GModText_SetText(text);
    _GModText_SetDelay(0);
    _GModText_Send(userid, key);
end

function stopPlayer(userid, stop)
    if stop then
        _PlayerSetMaxSpeed(userid, 1);
        _PlayerSetSprint(userid, false);
    else
        _PlayerSetMaxSpeed(userid, 200);
        _PlayerSetSprint(userid, true);
    end
end

function stopPlayersAll(stop)
    local i = 1;
    for i = 1, _MaxPlayers() do
        if (_PlayerInfo(i, "alive")) then stopPlayer(i, stop); end
    end
end

function removeAllPlayersWeapons()
    local i = 1;
    for i = 1, _MaxPlayers() do
        if (_PlayerInfo(i, "alive")) then _PlayerRemoveAllWeapons(i); end
    end
end

function removeAllProps()
    local props = _EntitiesFindByClass("prop_physics");
    for i, v in props do _EntRemove(v); end
end

function math.round(num, idp)
    return tonumber(string.format("%." .. idp .. "f", num))
end

function math.time(num)
    if (num) then
        if (num <= 0) then return "00:00"; end

        local minutes = (num / 60);
        local mins = string.format("%.2i", math.floor(minutes));
        local secs = string.format("%.2i", math.floor((minutes - mins) * 60));
        return mins .. ":" .. secs;
    else
        return "error";
    end
end

function randomTeamMember(team)
    for i = 1, _MaxPlayers() do
        if (_PlayerInfo(i, "team") == team) then return i; end
    end
    return 0;
end

function isAdmin(userid)
    for i, v in ipairs(adminlist) do
        if (userid) and (userid > 0) then
            if (string.lower(v) ==
                string.lower(_PlayerInfo(userid, "networkid"))) then
                return true;
            end
        end
    end
    return false;
end

function autoJoinTeam(playerid, wantTeam)
    -- do I really need this much code for an auto-join?

    --[[
	local t0p, t1p, t2p, t3mp = -1, -1, -1, -1;
	local plyrCount = 0;
	
	plyrCount = _TeamNumPlayers(TEAM_BLUE);
	plyrCount = plyrCount + _TeamNumPlayers(TEAM_YELLOW);
	plyrCount = plyrCount + _TeamNumPlayers(TEAM_GREEN);
	plyrCount = plyrCount + _TeamNumPlayers(TEAM_RED);
	
	-- this is used to make sure no one joins a team by theirself if there's already a team with 1 person
	if (_TeamNumPlayers(TEAM_BLUE) == 0) then t0p = TEAM_BLUE;
	elseif (_TeamNumPlayers(TEAM_BLUE) == 1) then
		if (_PlayerInfo(playerid, "team") ~= TEAM_BLUE) then
			t1p = TEAM_BLUE;
		end
	elseif (_TeamNumPlayers(TEAM_BLUE) == 2) then t2p = TEAM_BLUE;
	elseif (_TeamNumPlayers(TEAM_BLUE) >= 3) then t3mp = TEAM_BLUE; end;
	
	if (_TeamNumPlayers(TEAM_YELLOW) == 0) then t0p = TEAM_YELLOW;
	elseif (_TeamNumPlayers(TEAM_YELLOW) == 1) then
		if (_PlayerInfo(playerid, "team") ~= TEAM_YELLOW) then
			t1p = TEAM_YELLOW;
		end
	elseif (_TeamNumPlayers(TEAM_YELLOW) == 2) then t2p = TEAM_YELLOW;
	elseif (_TeamNumPlayers(TEAM_YELLOW) >= 3) then t3mp = TEAM_YELLOW; end;
	
	if (_TeamNumPlayers(TEAM_GREEN) == 0) then t0p = TEAM_GREEN;
	elseif (_TeamNumPlayers(TEAM_GREEN) == 1) then
		if (_PlayerInfo(playerid, "team") ~= TEAM_GREEN) then
			t1p = TEAM_GREEN;
		end
	elseif (_TeamNumPlayers(TEAM_GREEN) == 2) then t2p = TEAM_GREEN;
	elseif (_TeamNumPlayers(TEAM_GREEN) >= 3) then t3mp = TEAM_GREEN; end;
	
	if (_TeamNumPlayers(TEAM_RED) == 0) then t0p = TEAM_RED;
	elseif (_TeamNumPlayers(TEAM_RED) == 1) then
		if (_PlayerInfo(playerid, "team") ~= TEAM_RED) then
			t1p = TEAM_RED;
		end
	elseif (_TeamNumPlayers(TEAM_RED) == 2) then t2p = TEAM_RED;
	elseif (_TeamNumPlayers(TEAM_RED) >= 3) then t3mp = TEAM_RED; end;
	
	-- make sure there's at least one team with less than 3 people
	if (plyrCount < 9) and ((t0p > 0) or (t1p > 0) or (t2p > 0)) then
		if (t1p > 0) then
			-- there's a 1 person team. Make the player join this team
			--_Msg("there's a 1 person team. Make the player join this team\n");
			if (wantTeam > 0) and (_TeamNumPlayers(wantTeam) == 1) then
				-- If the wanted team has 1 person then let them join it
				_PlayerChangeTeam(playerid, wantTeam);
				_PlayerRespawn(playerid);
			else
				_PlayerChangeTeam(playerid, t1p);
				_PlayerRespawn(playerid);
			end
			players[playerid].canSwitchTeam = false;
			
		elseif (t3mp > 0) then
			-- there's a 3 or more person team, switch one person and make them join a new team
			--_Msg("there's a 3 or more person team, switch one person and make them join a new team\n");
			if (wantTeam > 0) and (_TeamNumPlayers(wantTeam) == 0) then
				-- If the wanted team has 0 people then let them join it
				_PlayerChangeTeam(playerid, wantTeam);
				_PlayerRespawn(playerid);
				players[playerid].canSwitchTeam = false;
				
				if AUTO_SWITCH then
					local rTeamMember = randomTeamMember(t3mp);
					if (rTeamMember > 0) then
						_PlayerChangeTeam(rTeamMember, wantTeam);
						_PlayerRespawn(rTeamMember);
						_PrintMessage(rTeamMember, 4, "You were auto-switched to even teams");
					end
				end
			else
				_PlayerChangeTeam(playerid, t0p);
				_PlayerRespawn(playerid);
				players[playerid].canSwitchTeam = false;
				
				if AUTO_SWITCH then
					local rTeamMember = randomTeamMember(t3mp);
					if (rTeamMember > 0) then
						_PlayerChangeTeam(rTeamMember, t0p);
						_PlayerRespawn(rTeamMember);
						_PrintMessage(rTeamMember, 4, "You were auto-switched to even teams");
					end
				end
			end
			
		elseif (t2p > 0) then
			-- there's a 2 person team (and no 1 person team) make them join as the 3rd
			--_Msg("there's a 2 person team (and no 1 person team) make them join as the 3rd\n");
			if (wantTeam > 0) and (_TeamNumPlayers(wantTeam) == 2) then
				-- If the wanted team has 2 people then let them join it
				_PlayerChangeTeam(playerid, wantTeam);
				_PlayerRespawn(playerid);
			else
				_PlayerChangeTeam(playerid, t2p);
				_PlayerRespawn(playerid);
			end
			players[playerid].canSwitchTeam = false;
		else
			-- must be the only player playing, switch them to a 0 person team
			--_Msg(" must be the only player playing, switch them to a 0 person team\n");
			if (wantTeam > 0) and (_TeamNumPlayers(wantTeam) == 0) then
				-- If the wanted team has 0 people then let them join it
				_PlayerChangeTeam(playerid, wantTeam);
				_PlayerRespawn(playerid);
			else
				-- there's no 1 or 2 person team. they have to join a empty team
				_PlayerChangeTeam(playerid, t0p);
				_PlayerRespawn(playerid);
			end
			players[playerid].canSwitchTeam = false;
		end
		
	else
]] --
    -- Find out which team has the least amount of people

    if (NUM_TEAMS == 2) then
        if (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_YELLOW)) then
            -- blue has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_BLUE);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        else
            -- yellow has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_YELLOW);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        end

    elseif (NUM_TEAMS == 3) then
        if (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_YELLOW)) and
            (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_GREEN)) then
            -- blue has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_BLUE);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        elseif (_TeamNumPlayers(TEAM_YELLOW) <= _TeamNumPlayers(TEAM_BLUE)) and
            (_TeamNumPlayers(TEAM_YELLOW) <= _TeamNumPlayers(TEAM_GREEN)) then
            -- yellow has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_YELLOW);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        else
            -- green has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_GREEN);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        end
    else

        if (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_YELLOW)) and
            (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_GREEN)) and
            (_TeamNumPlayers(TEAM_BLUE) <= _TeamNumPlayers(TEAM_RED)) then
            -- blue has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_BLUE);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        elseif (_TeamNumPlayers(TEAM_YELLOW) <= _TeamNumPlayers(TEAM_BLUE)) and
            (_TeamNumPlayers(TEAM_YELLOW) <= _TeamNumPlayers(TEAM_GREEN)) and
            (_TeamNumPlayers(TEAM_YELLOW) <= _TeamNumPlayers(TEAM_RED)) then
            -- yellow has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_YELLOW);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        elseif (_TeamNumPlayers(TEAM_GREEN) <= _TeamNumPlayers(TEAM_BLUE)) and
            (_TeamNumPlayers(TEAM_GREEN) <= _TeamNumPlayers(TEAM_YELLOW)) and
            (_TeamNumPlayers(TEAM_GREEN) <= _TeamNumPlayers(TEAM_RED)) then
            -- green has the least amount of players
            _PlayerChangeTeam(playerid, TEAM_GREEN);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        else
            -- none of the other teams had the least amount so that only leaves red
            _PlayerChangeTeam(playerid, TEAM_RED);
            _PlayerRespawn(playerid);
            players[playerid].canSwitchTeam = false;
            resetSpawnPoint(playerid);
        end
    end

    -- end
end

function printUsers()
    for i = 1, _MaxPlayers() do
        if (_PlayerInfo(i, "name")) then
            _Msg(i .. " " .. _PlayerInfo(i, "name") .. "\n");
        end
    end
end
