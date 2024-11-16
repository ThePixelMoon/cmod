function onShowSpare1 ( userid )
	-- admin menu
	UpdateAdminPanel(userid);
end

function UpdateAdminPanel(userid)
	if isAdmin(userid) then
		_PlayerOption(userid, "ChooseAdminOption", 99999);
		
		message(userid, 60, 0.02, 0.41, 99999, "Admin control");
		
		messageMenu(userid, 61, 0.02, 0.43, 99999, "1. Restart Round");
		messageMenu(userid, 62, 0.02, 0.45, 99999, "2. Remove All Props");
		if ENABLE_PHYSGUN_PICKUP then
			messageMenu(userid, 63, 0.02, 0.47, 99999, "3. Physgun pickup: On");
		else
			messageMenu(userid, 63, 0.02, 0.47, 99999, "3. Physgun pickup: Off");
		end
		
		messageMenu(userid, 64, 0.02, 0.49, 99999, "4. Number of teams: " .. NUM_TEAMS);
		
		if dm_mode then
			messageMenu(userid, 65, 0.02, 0.51, 99999, "5. Initiate build mode");
		else
			messageMenu(userid, 65, 0.02, 0.51, 99999, "5. Initiate deathmatch mode");
		end
		messageMenu(userid, 66, 0.02, 0.53, 99999, "6. Toggle Walls");
		messageMenu(userid, 69, 0.02, 0.56, 99999, "7. Exit ");
	
		_GModRect_Start( "gmod/white" );
			_GModRect_SetPos(0.01, 0.4, 0.20, 0.19);
			_GModRect_SetColor(0, 0, 0, 150);
			_GModRect_SetTime(99999, 0.5, 1.5);
			_GModRect_SetDelay(0);
		_GModRect_Send(userid, 60);
	end
end;

function ChooseAdminOption(playerid, num, seconds)
	if isAdmin(playerid) then
		if (num == 1) then
			cc_restartRound(playerid, "");
			UpdateAdminPanel(playerid);
			return;
			
		elseif (num == 2) then
			cc_removeAllProps(playerid, "");
			UpdateAdminPanel(playerid);
			return;
		
		elseif (num == 3) then
			if ENABLE_PHYSGUN_PICKUP then
				cc_enablePhysgunPickup (playerid, "0");
			else
				cc_enablePhysgunPickup (playerid, "1");
			end
			UpdateAdminPanel(playerid);
			return;
		
		elseif (num == 4) then
			if (NUM_TEAMS == 2) then
				cc_changeNumTeams(playerid, "3");
			elseif (NUM_TEAMS == 3) then
				cc_changeNumTeams(playerid, "4");
			elseif (NUM_TEAMS == 4) then
				cc_changeNumTeams(playerid, "2");
			end
			UpdateAdminPanel(playerid);
			return;
		
		elseif (num == 5) then
			if dm_mode then
				cc_setDeathmatchMode(playerid, "0");
			else
				cc_setDeathmatchMode(playerid, "1");
			end
			UpdateAdminPanel(playerid);
			return;
			
		elseif (num == 6) then
			cc_toggleWalls(playerid, "");
			UpdateAdminPanel(playerid);
			return;
			
		else
			_GModText_Hide(playerid, 60, 0.5);
			_GModText_Hide(playerid, 61, 0.5);
			_GModText_Hide(playerid, 62, 0.5);
			_GModText_Hide(playerid, 63, 0.5);
			_GModText_Hide(playerid, 64, 0.5);
			_GModText_Hide(playerid, 65, 0.5);
			_GModText_Hide(playerid, 66, 0.5);
			_GModText_Hide(playerid, 69, 0.5);
			
			_GModRect_Hide(playerid, 60, 0.5);
			return;
		end
	end
end