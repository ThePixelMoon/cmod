

function onShowSpare2 (userid)
	if (_PlayerInfo(userid, "team") ~= TEAM_SPECTATOR) then
		buyMenu(userid);
	end
end


function onShowHelp ( userid )
	messageMenu(userid,50, 0.30, 0.30, 20, "gm_build_fortwars:");
	message(userid,51, 0.35, 0.35, 20, "The object of this game is for each team to build a fort");
	message(userid,52, 0.35, 0.38, 20, "You can use the prop gun (slot 2, 1st gun) to create crates to build with");
	message(userid,53, 0.35, 0.41, 20, "You can use the gravity gun or physgun to position the crates with");
	message(userid,55, 0.35, 0.44, 20, "After bulid mode is over deathmatch begins");
	message(userid,56, 0.35, 0.47, 20, "Grab the basketball that falls in the center with your gravity gun");
	message(userid,57, 0.35, 0.50, 20, "For each minute you hold it, your team gets a point");
	
	message(userid,60, 0.35, 0.55, 20, "The spawnpoint gun will set where you will be spawned (slot 3, first gun)");
	message(userid,61, 0.35, 0.58, 20, "This gun can only be used during build mode.");
	message(userid,62, 0.35, 0.61, 20, "Note that this gun will set your spawn point to where you standing");
	message(userid,63, 0.35, 0.64, 20, "It does not set your spawnpoint to where you are aiming");
	message(userid,64, 0.35, 0.67, 20, "Alt-fire will reset the spawnpoint to default");
	
	messageAttn(userid,58, 0.30, 0.72, 20, "Press F2 to change teams. F3 is the admin panel for those with access.");
	messageAttn(userid,65, 0.30, 0.75, 20, "Press F4 for the buy menu.");
	
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos(0.25, 0.25, 0.60, 0.55);
		_GModRect_SetColor(0, 0, 0, 150);
		_GModRect_SetTime(20, 0.5, 1.5);
		_GModRect_SetDelay(0);
	_GModRect_Send(userid, 69);
end

function onShowTeam ( userid )

	_PlayerOption( userid, "ChooseTeam", 99999 );
	
	-- Title
	_GModText_Start( "ImpactMassive" );
	 _GModText_SetPos( -1, 0.1 );
	 _GModText_SetColor( 255, 200, 0, 205 );
	 _GModText_SetTime( 99999, 1.5, 0 );
	 _GModText_SetText( "Build Gamemode: Fort Wars" );
	 _GModText_SetDelay( 1.5 );
	 _GModText_AllowOffscreen( true );
	_GModText_Send( userid, 0 );
	
	_GModText_Start( "ImpactMassive" );
	 _GModText_SetPos( -1, 0.3 );
	 _GModText_SetColor( 255, 200, 0, 205 );
	 _GModText_SetDelay( 1.0 );
	_GModText_SendAnimate( userid, 0, 1.5, 0.7 );

			
	-- credit line
	_GModText_Start( "HudHintTextLarge" );
	 _GModText_SetPos( 0.6, 0.37 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0.5, 1.5 );
	 _GModText_SetText( "by g33k" );
	 _GModText_SetDelay( 1.0 );
	_GModText_Send( userid, 1 );

	
	-- background
	_GModRect_Start( "gmod/white" );
	 _GModRect_SetPos( 0.0, 0.0, 1, 1 );
	 _GModRect_SetColor( 255, 255, 255, 255 );
	 _GModRect_SetTime( 99999, 0.5, 2 );
	 _GModRect_SetDelay( 1 );
	_GModRect_Send( userid, 0 );

	_GModRect_Start( "gmod/white" );
	 _GModRect_SetPos( 0.0, 0.3, 0.2, 0.25 );
	 _GModRect_SetColor( 0, 0, 0, 150 );
	 _GModRect_SetDelay( 1 );
	_GModRect_SendAnimate(userid, 0, 0.5, 0.5);

	-- Options
	_GModText_Start("Default");
	 _GModText_SetPos(0.01, 0.33);
	 _GModText_SetColor(255, 255, 255, 255) ;
	 _GModText_SetTime(99999, 3, 1.0);
	 if (NUM_TEAMS == 2) then
		_GModText_SetText("Choose your team:\n\n\n1. Blue Team\n2. Yellow Team\n\n5. Auto");
	 elseif (NUM_TEAMS == 3) then
		_GModText_SetText("Choose your team:\n\n\n1. Blue Team\n2. Yellow Team\n3. Green Team\n\n5. Auto");
	 else
		_GModText_SetText("Choose your team:\n\n\n1. Blue Team\n2. Yellow Team\n3. Green Team\n4. Red Team\n\n5. Auto");
	 end
	
	 _GModText_SetDelay(1.5);
	_GModText_Send(userid, 2);

	_GModText_Start("Default");
	 _GModText_SetPos(0.06, 0.33);
	 _GModText_SetColor(255, 255, 255, 255);
	 _GModText_SetDelay(1.5);
	_GModText_SendAnimate(userid, 2, 1.0, 0.7);
end

function ChooseTeam( playerid, num, seconds )
	_GModText_Hide( playerid, 0, 0.5 );
	_GModText_Hide( playerid, 1, 0.5 );
	_GModText_Hide( playerid, 2, 0.5 );
	
	_GModRect_Hide( playerid, 0, 0.9 );
	
	if players[playerid].canSwitchTeam then
	
		--players[playerid].canSwitchTeam = false;
		
		-- if they are by theirself then allow them to change
--		if (_PlayerInfo(playerid, "team") ~= TEAM_SPECTATOR) then
--			if (_TeamNumPlayers(_PlayerInfo(playerid,"team")) == 1) then
--				if (num > 0) and (num < 5) then
--					autoJoinTeam(playerid, (num+1));
--				else
--					autoJoinTeam(playerid, 0);
--				end
--				return;
--			end
--		end
		
	
		if (num == 1) then
			if (_PlayerInfo(playerid, "team") == TEAM_BLUE) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_SPECTATOR) then
				if (_TeamNumPlayers(TEAM_BLUE) > _TeamNumPlayers(TEAM_YELLOW))
					or (_TeamNumPlayers(TEAM_BLUE) > _TeamNumPlayers(TEAM_GREEN))
					or (_TeamNumPlayers(TEAM_BLUE) > _TeamNumPlayers(TEAM_RED))
				then
					autoJoinTeam(playerid, 0);
					return;
				end;
			else
				if (_TeamNumPlayers(TEAM_BLUE) >= _TeamNumPlayers(_PlayerInfo(playerid,"team")))
				then
					_PrintMessage(playerid, 4, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_BLUE);
			_PlayerRespawn(playerid);
			players[playerid].canSwitchTeam = false;
			resetSpawnPoint(playerid);
			
			return;
		end
		
		if (num == 2) then
		
			if (_PlayerInfo(playerid, "team") == TEAM_YELLOW) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_SPECTATOR) then
				if (_TeamNumPlayers(TEAM_YELLOW) > _TeamNumPlayers(TEAM_BLUE))
					or (_TeamNumPlayers(TEAM_YELLOW) > _TeamNumPlayers(TEAM_GREEN))
					or (_TeamNumPlayers(TEAM_YELLOW) > _TeamNumPlayers(TEAM_RED))
				then
					autoJoinTeam(playerid, 0);
					return;
				end;
			else
				if (_TeamNumPlayers(TEAM_YELLOW) >= _TeamNumPlayers(_PlayerInfo(playerid,"team")))
				then
					_PrintMessage(playerid, 4, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_YELLOW);
			_PlayerRespawn(playerid);
			players[playerid].canSwitchTeam = false;
			resetSpawnPoint(playerid);
			
			return;	
		end
		
		if (num == 3) then
			if (NUM_TEAMS < 3) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_GREEN) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_SPECTATOR) then
				if (_TeamNumPlayers(TEAM_GREEN) > _TeamNumPlayers(TEAM_YELLOW))
					or (_TeamNumPlayers(TEAM_GREEN) > _TeamNumPlayers(TEAM_BLUE))
					or (_TeamNumPlayers(TEAM_GREEN) > _TeamNumPlayers(TEAM_RED))
				then
					autoJoinTeam(playerid, 0);
					return;
				end;
			else
				if (_TeamNumPlayers(TEAM_GREEN) >= _TeamNumPlayers(_PlayerInfo(playerid,"team")))
				then
					_PrintMessage(playerid, 4, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_GREEN);
			_PlayerRespawn(playerid);
			players[playerid].canSwitchTeam = false;
			resetSpawnPoint(playerid);
			
			return;
		end
		
		if (num == 4) then
			if (NUM_TEAMS < 4) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_RED) then return; end;
			
			if (_PlayerInfo(playerid, "team") == TEAM_SPECTATOR) then
				if (_TeamNumPlayers(TEAM_RED) > _TeamNumPlayers(TEAM_YELLOW))
					or (_TeamNumPlayers(TEAM_RED) > _TeamNumPlayers(TEAM_BLUE))
					or (_TeamNumPlayers(TEAM_RED) > _TeamNumPlayers(TEAM_GREEN))
				then
					autoJoinTeam(playerid, 0);
					return;
				end;
			else
				if (_TeamNumPlayers(TEAM_RED) >= _TeamNumPlayers(_PlayerInfo(playerid,"team")))
				then
					_PrintMessage(playerid, 4, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_RED);
			_PlayerRespawn(playerid);
			players[playerid].canSwitchTeam = false;
			resetSpawnPoint(playerid);
			
			return;
		end;
	
		
		autoJoinTeam(playerid, 0);
	else
		messageInfo(playerid, 76, 0.25, "You can't switch teams until next round");
	end
end

function UpdateScores( UserID )

	local COLUMN1, COLUMN2, COLUMN3, COLUMN4, COLUMN5 = 0.03, 0.14, 0.19, 0.24, 0.27;
	local TOP_MARGIN, LINE_SPACING, COL_SPACING = 0.06, 0.03, 0.05;

-- Header
	-- Score
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos(0.125, 0.03);
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Score" );
	_GModText_Send( UserID, 5 );
	
	-- Flag Time
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( 0.18, 0.03 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Flag Time" );
	_GModText_Send( UserID, 7 );
--

	
	
	local timekey = 20;
	local marg_multi = 0;
	for iTeam in teams do
		-- Name
		_GModText_Start("DefaultShadow");
			_GModText_SetPos(COLUMN1, TOP_MARGIN + (marg_multi * LINE_SPACING));
			_GModText_SetColor(teams[iTeam].color.r, teams[iTeam].color.g, teams[iTeam].color.b, 255);
			_GModText_SetTime(99999, 0, 0);
			_GModText_SetText(teams[iTeam].name .. ": ");
		_GModText_Send(UserID, 10 + marg_multi); -- 10,11,12,13
		
		-- Score
		_GModText_Start("DefaultShadow");
			_GModText_SetPos(COLUMN2, TOP_MARGIN + (marg_multi * LINE_SPACING));
			_GModText_SetColor(teams[iTeam].color.r, teams[iTeam].color.g, teams[iTeam].color.b, 255);
			_GModText_SetTime(99999, 0, 0);
			_GModText_SetText(_TeamScore(iTeam));
		_GModText_Send(UserID, 14 + marg_multi); -- 14,15,16,17
		
		-- Flag hold time
		_GModText_Start( "DefaultShadow" );
			_GModText_SetPos(COLUMN3, TOP_MARGIN + (marg_multi * LINE_SPACING));
			
			if (teams[iTeam].hasFlag) then
				_GModText_SetColor(teams[iTeam].color.r, teams[iTeam].color.g, teams[iTeam].color.b, 255);
			else
				_GModText_SetColor(255, 255, 255, 155);
			end
			
			_GModText_SetTime(99999, 0, 0);
			_GModText_SetText(math.time(teams[iTeam].flagTime));
		_GModText_Send(UserID, timekey);
		
		timekey = timekey + 1;			
		marg_multi = marg_multi + 1;
	end
	
	-- Background
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos( 0.01, 0.01, 0.25, 0.19 );
		_GModRect_SetColor( 0, 0, 0, 150 );
		_GModRect_SetTime( 99999, 0, 0 );
		_GModRect_SetDelay( 0 );
	_GModRect_Send( UserID, 17 );
	
end


function UpdateDMTime(UserID, dm, rTime)
	_GModText_Start("DefaultShadow");
	 _GModText_SetPos(0.01, 0.21);
	 _GModText_SetColor(255, 255, 255, 255);
	 _GModText_SetTime(99999, 0, 0);
	if (dm == 0) then
	 _GModText_SetText("Build: " .. rTime);
	elseif (dm == 1) then
	 _GModText_SetText("Fight: " .. rTime);
	end
	_GModText_Send(UserID, 19);
end

function drawMoneyAmmount(userid)
	if (userid == 0) then
		for i=1, _MaxPlayers() do
			if (_PlayerInfo(i, "connected")) then
				_GModText_Start("ImpactMassive");
					_GModText_SetPos(0.025, 0.80);
					_GModText_SetColor(50, 255, 100, 255);
					_GModText_SetTime(99999, 0, 0);
					_GModText_SetText("$" .. players[i].money);
				_GModText_Send(i, 101);
			end
		end
	else
		_GModText_Start("ImpactMassive");
			_GModText_SetPos(0.025, 0.80);
			_GModText_SetColor(50, 255, 100, 255);
			_GModText_SetTime(99999, 0, 0);
			_GModText_SetText("$" .. players[userid].money);
		_GModText_Send(userid, 101);
	end
end


function buyMenu(userid)
	_PlayerOption(userid, "BuyItem", 99999);
	
	xpos = 0.04;
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.25);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("1. Shotgun: $100");
	_GModText_Send(userid, 110);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.29);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("2. AR2: $200");
	_GModText_Send(userid, 111);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.33);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("3. 357: $350");
	_GModText_Send(userid, 112);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.37);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("4. Crossbow: $500");
	_GModText_Send(userid, 113);	
	
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.45);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("5. Buy Ammo");
	_GModText_Send(userid, 114);

	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.50);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("7. Exit");
	_GModText_Send(userid, 116);
				
	-- Background
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos(0.01, 0.2, 0.3, 0.35);
		_GModRect_SetColor(0, 0, 0, 150);
		_GModRect_SetTime(99999, 0, 0);
		_GModRect_SetDelay(0);
	_GModRect_Send(userid, 101);
end

function BuyItem(userid, num, seconds)
	if (num == 1) then
		-- Shotgun
		if (players[userid].money >= 100) then
			_PlayerGiveItem(userid, "weapon_shotgun");
			_PlayerGiveAmmo(userid, 60, "Buckshot", true);
			players[userid].money = players[userid].money - 100;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		HideBuyMenu(userid);
		return;
		
	elseif (num == 2) then
		-- AR2
		if (players[userid].money >= 200) then
			_PlayerGiveItem(userid, "weapon_ar2");
			_PlayerGiveAmmo(userid, 90, "AR2", true);
			players[userid].money = players[userid].money - 200;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		HideBuyMenu(userid);
		return;
		
	elseif (num == 3) then
		-- 357
		if (players[userid].money >= 350) then
			_PlayerGiveItem(userid, "weapon_357");
			_PlayerGiveAmmo(userid, 36, "357", true);
			players[userid].money = players[userid].money - 350;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		HideBuyMenu(userid);
		return;
		
	elseif (num == 4) then
		-- Crossbow
		if (players[userid].money >= 420) then
			_PlayerGiveItem(userid, "weapon_crossbow");
			_PlayerGiveAmmo(userid, 5, "XBowBolt", true);
			players[userid].money = players[userid].money - 420;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		HideBuyMenu(userid);
		return;
		
	elseif (num == 5) then
		-- Ammo screen
		HideBuyMenu(userid);
		AmmoMenu(userid)
		return;
	end
	
	HideBuyMenu(userid);
	return;
end

function HideBuyMenu(userid)
	_GModText_Hide(userid, 110, 0.5, 0);
	_GModText_Hide(userid, 111, 0.5, 0);
	_GModText_Hide(userid, 112, 0.5, 0);
	_GModText_Hide(userid, 113, 0.5, 0);
	_GModText_Hide(userid, 114, 0.5, 0);
	_GModText_Hide(userid, 116, 0.5, 0);
	_GModRect_Hide(userid, 101, 0.5, 0);
end




function AmmoMenu(userid)
	_PlayerOption(userid, "BuyAmmo", 99999);
	
	xpos = 0.04;
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.25);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("1. SMG (30 rounds): $25");
	_GModText_Send(userid, 120);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.29);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("2. Shotgun (12 shells): $40");
	_GModText_Send(userid, 121);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.33);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("3. AR2 (30 rounds): $50");
	_GModText_Send(userid, 122);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.37);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("4. 357 (12 rounds): $60");
	_GModText_Send(userid, 123);
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.41);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("5. Crossbow (6 bolts): $80");
	_GModText_Send(userid, 124);
	
	
	
	_GModText_Start("TargetID");
		_GModText_SetPos(xpos, 0.50);
		_GModText_SetColor(255, 200, 50, 255);
		_GModText_SetTime(99999, 0, 0);
		_GModText_SetText("7. Exit");
	_GModText_Send(userid, 125);

	
	-- Background
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos(0.01, 0.2, 0.3, 0.35);
		_GModRect_SetColor(0, 0, 0, 150);
		_GModRect_SetTime(99999, 0, 0);
		_GModRect_SetDelay(0);
	_GModRect_Send(userid, 102);
end

function HideAmmoMenu(userid)
	_GModText_Hide(userid, 120, 0.5, 0);
	_GModText_Hide(userid, 121, 0.5, 0)
	_GModText_Hide(userid, 122, 0.5, 0);
	_GModText_Hide(userid, 123, 0.5, 0);
	_GModText_Hide(userid, 124, 0.5, 0);
	_GModText_Hide(userid, 125, 0.5, 0);
	_GModRect_Hide(userid, 102, 0.5, 0);
end

function BuyAmmo(userid, num, seconds)
	if (num == 1) then
		-- SMG Ammo
		if (players[userid].money >= 25) then
			_PlayerGiveAmmo(userid, 30, "SMG1", true);
			players[userid].money = players[userid].money - 25;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		AmmoMenu(userid);
		return;
		
	elseif (num == 2) then
		-- Shotgun Ammo
		if (players[userid].money >= 40) then
			_PlayerGiveAmmo(userid, 12, "Buckshot", true);
			players[userid].money = players[userid].money - 40;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		AmmoMenu(userid);
		return;
	
	elseif (num == 3) then
		-- AR2 Ammo
		if (players[userid].money >= 50) then
			_PlayerGiveAmmo(userid, 30, "AR2", true);
			players[userid].money = players[userid].money - 50;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		AmmoMenu(userid);
		return;
	
	elseif (num == 4) then
		-- 357 Ammo
		if (players[userid].money >= 60) then
			_PlayerGiveAmmo(userid, 12, "357", true);
			players[userid].money = players[userid].money - 60;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		AmmoMenu(userid);
		return;
	
	elseif (num == 5) then
		-- Crossbow Ammo
		if (players[userid].money >= 80) then
			_PlayerGiveAmmo(userid, 6, "XBowBolt", true);
			players[userid].money = players[userid].money - 80;
			drawMoneyAmmount(userid);
		else
			_PrintMessage(userid, 4, "You don't have enough money for this item");
		end
		AmmoMenu(userid);
		return;
	
	else
		HideAmmoMenu(userid);
		return;
	end
	
	return;
end

