


function onShowHelp ( userid )
	messageMenu(userid,50, 0.20, 0.25, 20, "gm_build_bridge:");
	message(userid,51, 0.25, 0.30, 20, "The object of this game is to build across to the last level");
	message(userid,52, 0.25, 0.33, 20, "You can use the prop gun (slot 2, 1st gun) to create crates or barrels (alt fire)");
	message(userid,53, 0.25, 0.36, 20, "Use the gravity gun to position the object and have someone else freeze it for you");
	message(userid,54, 0.25, 0.39, 20, "The physgun's alt fire will freeze or use the freeze gun (slot 2, 3rd gun)");
	message(userid,55, 0.25, 0.42, 20, "Certain levels will give you gun upgrades");
	
	messageMenu(userid,56, 0.20, 0.47, 20, "gm_build_tothetop:");
	message(userid,57, 0.25, 0.52, 20, "Same rules as gm_build_bridge except you build upwards instead of across");
	
	messageAttn(userid,58, 0.20, 0.57, 20, "Press F2 to change teams. F3 is the admin panel for those with access.");
	
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos(0.17, 0.22, 0.65, 0.40);
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
	 _GModText_SetText( "Build Gamemode" );
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
	 _GModText_SetText("Choose your team:\n\n\n1. Blue Team\n2. Yellow Team\n3. Green Team\n4. Red Team\n\n5. Auto");
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
		players[playerid].canSwitchTeam = false;
	
		-- if they are by theirself then allow them to change
		if (_PlayerInfo(playerid, "team") ~= TEAM_SPECTATOR) then
			if (_TeamNumPlayers(_PlayerInfo(playerid,"team")) == 1) then
				if (num > 0) and (num < 5) then
					autoJoinTeam(playerid, (num+1));
				else
					autoJoinTeam(playerid, 0);
				end
				return;
			end
		end
		
	
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
					messageInfo(playerid, 77, 0.3, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_BLUE);
			_PlayerRespawn(playerid);
			
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
					messageInfo(playerid, 77, 0.3, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_YELLOW);
			_PlayerRespawn(playerid);
			
			return;	
		end
		
		if (num == 3) then
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
					messageInfo(playerid, 77, 0.3, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_GREEN);
			_PlayerRespawn(playerid);
			
			return;
		end
		
		if (num == 4) then
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
					messageInfo(playerid, 77, 0.3, "Teams would be too uneven if you switched.");
					return;
				end
			end
			
			_PlayerChangeTeam(playerid, TEAM_RED);
			_PlayerRespawn(playerid);
			
			return;
		end;
	
		
		autoJoinTeam(playerid, 0);
	else
		messageInfo(playerid, 76, 0.25, "You can't switch teams until next round");
	end
end

function UpdateScores( UserID )

	local COLUMN1, COLUMN2, COLUMN3, COLUMN4, COLUMN5 = 0.03, 0.14, 0.17, 0.22, 0.27;
	local TOP_MARGIN, LINE_SPACING, COL_SPACING = 0.06, 0.03, 0.05;

-- Header
	-- Score
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos(0.125, 0.03);
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Score" );
	_GModText_Send( UserID, 5 );
	
	-- Level 1
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( 0.17, 0.03 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Level1" );
	_GModText_Send( UserID, 6 );
	
	-- Level 2
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( 0.22, 0.03 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Level2" );
	_GModText_Send( UserID, 7 );

	-- Level 3
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( 0.27, 0.03 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Level3" );
	_GModText_Send( UserID, 8 );
	
	
-- Blue Team

--[[
	-- Name
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN1, TOP_MARGIN );
	 _GModText_SetColor(50, 150, 255, 255);
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Blue Team: " );
	_GModText_Send( UserID, 9 );
	
	-- Score
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN2, TOP_MARGIN );
	 _GModText_SetColor( 50, 150, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( _TeamScore(TEAM_BLUE) );
	_GModText_Send( UserID, 23 );
	]]--
	
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

		local col_multi = 0
		for i in teams[iTeam].levelsTime do
			_GModText_Start( "DefaultShadow" );
				_GModText_SetPos(COLUMN3 + (col_multi * COL_SPACING), TOP_MARGIN + (marg_multi * LINE_SPACING));
				
				if (teams[iTeam].lastLevel < i) then
					_GModText_SetColor(255, 255, 255, 155);
				else
					_GModText_SetColor(teams[iTeam].color.r, teams[iTeam].color.g, teams[iTeam].color.b, 255);
				end
				
				_GModText_SetTime(99999, 0, 0);
				_GModText_SetText(math.time(teams[iTeam].levelsTime[i]));
			_GModText_Send(UserID, timekey);
			
			timekey = timekey + 1;				
			col_multi = col_multi + 1;
		end
		marg_multi = marg_multi + 1;
	end
	
--[[
	-- Level 1 time
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN3, TOP_MARGIN );
	 
	 if (teams[TEAM_BLUE].lastLevel < 1) then
		_GModText_SetColor( 255, 255, 255, 155 );
	 else
		_GModText_SetColor( 50, 150, 255, 255 );
	 end
	 
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( math.time(teams[TEAM_BLUE].levelsTime[1]) );
	_GModText_Send( UserID, 24 );
	
	-- Level 2 time
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN4, TOP_MARGIN );

	 if (teams[TEAM_BLUE].lastLevel < 2) then
		_GModText_SetColor( 255, 255, 255, 155 );
	 else
		_GModText_SetColor( 50, 150, 255, 255 );
	 end

	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( math.time(teams[TEAM_BLUE].levelsTime[2]) );
	_GModText_Send( UserID, 25 );
	
	-- Level 3 time
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN5, TOP_MARGIN );
	 
	 if (teams[TEAM_BLUE].lastLevel < 3) then
		_GModText_SetColor( 255, 255, 255, 155 );
	 else
		_GModText_SetColor( 50, 150, 255, 255 );
	 end
	 
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( math.time(teams[TEAM_BLUE].levelsTime[3]) );
	_GModText_Send( UserID, 26 );
	
	
-- Yellow Team
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN1, (TOP_MARGIN + (LINE_SPACING * 1)) );
	 _GModText_SetColor( 255, 200, 0, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Yellow Team: " );
	_GModText_Send( UserID, 11 );
	
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN2, (TOP_MARGIN + (LINE_SPACING * 1)) );
	 _GModText_SetColor( 255, 200, 0, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( _TeamScore(TEAM_YELLOW) );
	_GModText_Send( UserID, 12 );
	
	-- Green Team
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN1, (TOP_MARGIN + (LINE_SPACING * 2)) );
	 _GModText_SetColor( 50, 255, 150, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Green Team: " );
	_GModText_Send( UserID, 13 );
	
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN2, (TOP_MARGIN + (LINE_SPACING * 2)) );
	 _GModText_SetColor( 50, 255, 150, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( _TeamScore(TEAM_GREEN) );
	_GModText_Send( UserID, 14 );
	
	-- RedTeam
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN1, (TOP_MARGIN + (LINE_SPACING * 3)) );
	 _GModText_SetColor( 255, 100, 100, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Red Team: " );
	_GModText_Send( UserID, 15 );
	
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( COLUMN2, (TOP_MARGIN + (LINE_SPACING * 3)) );
	 _GModText_SetColor( 255, 100, 100, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( _TeamScore(TEAM_RED) );
	_GModText_Send( UserID, 16 );
]]--

	-- Background
	_GModRect_Start( "gmod/white" );
		_GModRect_SetPos( 0.01, 0.01, 0.33, 0.19 );
		_GModRect_SetColor( 0, 0, 0, 150 );
		_GModRect_SetTime( 99999, 0, 0 );
		_GModRect_SetDelay( 0 );
	_GModRect_Send( UserID, 17 );
	
end


function UpdateRoundTime(UserID, rTime)
	_GModText_Start( "DefaultShadow" );
	 _GModText_SetPos( 0.03, 0.83 );
	 _GModText_SetColor( 255, 255, 255, 255 );
	 _GModText_SetTime( 99999, 0, 0 );
	 _GModText_SetText( "Time: " .. rTime);
	_GModText_Send( UserID, 18 );
end


function UpdateDMTime(UserID, dm, rTime)
	_GModText_Start("DefaultShadow");
	 _GModText_SetPos(0.01, 0.21);
	 _GModText_SetColor(255, 255, 255, 255);
	 _GModText_SetTime(99999, 0, 0);
	if (dm == 0) then
	 _GModText_SetText("DM mode in: " .. rTime);
	elseif (dm == 1) then
	 _GModText_SetText("DM over in: " .. rTime);
	end
	_GModText_Send(UserID, 19);
end

