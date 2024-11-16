
PROP_MODEL = "models/props_junk/wood_crate001a.mdl";
PROP_MODEL2 = "models/props_c17/oildrum001.mdl";


TEAM_BLUE		=	2
TEAM_YELLOW		=	3

-- Called when the weapon is created.
	
	function onInit( )
		_SWEPSetSound( MyIndex, "single_shot", "Weapon_Pistol.Single" )
	end

	
-- Called every frame

	function onThink( )
		-- nil
	end
	
	
	function onPrimaryAttack( )
		if ( _PlayerInfo( Owner, "alive" ) == false ) then return; end
		
		local vecpos = _PlayerGetShootPos( Owner );
		local plyang = _PlayerGetShootAng( Owner );
		
		_TraceLine( vecpos, plyang, 200, Owner );
		
		vecpos = vecAdd( vecpos, vector3( 0, 0, -20 ) );
		
		local hitpos = _TraceEndPos();
		hitpos = vecAdd(hitpos, vector3(0, 0, 40));
		
		if (_TraceHit() == false) then
			_PrintMessage(Owner, 4, "You aren't close enough to the ground to spawn");
			return;
		end
		
		--if (_TraceHitWorld() == false) then
			--_PrintMessage(Owner, 4, "You can only spawn props on the ground");
			--return
		--end;
		
		local crate = _EntCreate( "prop_physics" );
		
		if (crate > 0) then
			_EntSetKeyValue(crate, "model", PROP_MODEL);
			_EntSetKeyValue(crate, "targetname", "crate01");
			_EntSetPos(crate, hitpos);
			--_EntSetAng(crate, plyang);
			_EntSpawn(crate);
			_PlayerFreeze(crate,true);
		end
	end
	
	
	function onSecondaryAttack( )
		if ( _PlayerInfo( Owner, "alive" ) == false ) then return; end
		
		local vecpos = _PlayerGetShootPos( Owner );
		local plyang = _PlayerGetShootAng( Owner );
		
		_TraceLine( vecpos, plyang, 200, Owner );
		
		vecpos = vecAdd( vecpos, vector3( 0, 0, -20 ) );
		
		local hitpos = _TraceEndPos();
		hitpos = vecAdd(hitpos, vector3(0, 0, 40));
		
		if (_TraceHit() == false) then
			_PrintMessage(Owner, 4, "You aren't close enough to the ground to spawn");
			return;
		end
		
		--if (_TraceHitWorld() == false) then
			--_PrintMessage(Owner, 4, "You can only spawn props on the ground");
			--return
		--end;
		
		local crate = _EntCreate( "prop_physics" );
		
		if (crate > 0) then
			_EntSetKeyValue(crate, "model", PROP_MODEL2);
			_EntSetKeyValue(crate, "targetname", "crate01");
			_EntSetPos(crate, hitpos);
			--_EntSetAng(crate, plyang);
			_EntSpawn(crate);
			_PlayerFreeze(crate,true);
		end
	end
	
	
	function onReload( )
		return false;
	end
	
	
	
-- Weapon settings.
-- These are only accessed once when setting the weapon up
	
	function getWeaponSwapHands()
		return false;	
	end
	
	function getWeaponFOV()
		return 60;	
	end
	
	function getWeaponSlot()
		return 1;	
	end
	
	function getWeaponSlotPos()
		return 4;	
	end
	
	function getFiresUnderwater()
		return false;
	end
	
	function getReloadsSingly()
		return false;
	end
	
	function getDamage()
		return 5;
	end
	
	function getPrimaryShotDelay()
		return 1.5;
	end
	
	function getSecondaryShotDelay()
		return 1.5;
	end
	
	function getPrimaryIsAutomatic()
		return false;
	end
	
	function getSecondaryIsAutomatic()
		return false;
	end
	
	function getBulletSpread()
		return vector3( 0.00, 0.00, 0.00 );
	end
	
	function getViewKick()
		return vector3( 0.0, 0.0, 0.0);
	end
	
	function getViewKickRandom()
		return vector3( 0.0, 0.0, 0.0 );
	end

	function getViewModel( )
		return "models/weapons/v_Pistol.mdl";
	end
	
	function getWorldModel( )
		return "models/weapons/w_Pistol.mdl";
	end
	
	function getClassName()
		return "weapon_propmaker";
	end

	function getPrimaryAmmoType()
		return;
	end
		
	function getSecondaryAmmoType()
		return;
	end
	
	-- return -1 if it doesn't use clips
	function getMaxClipPrimary()
		return 1;
	end
	
	function getMaxClipSecondary()
		return -1;
	end
	
	-- ammo in gun by default
	function getDefClipPrimary()
		return 1;
	end
	
	function getDefClipSecondary()
		return 1;
	end

	-- pistol, smg, ar2, shotgun, rpg, phys, crossbow, melee, slam, grenade
	function getAnimPrefix()
		return "pistol";
	end

	function getPrintName()
		return "Prop Gun";
	end
	
	
	-- 0 = Don't override, shoot bullets, make sound and flash
	-- 1 = Don't shoot bullets but do make flash/sounds
	-- 2 = Only play animations
	-- 3 = Don't do anything
	
	function getPrimaryScriptOverride()
		return 1;
	end

	function getSecondaryScriptOverride()
		return 1;
	end
	
	
	
	function getBulletSpreadSecondary()
		return vector3( 0.0, 0.0, 0.0 );
	end
	
	function getViewKickSecondary()
		return vector3( 0.0, 0.0, 0.0);
	end
	
	function getViewKickRandomSecondary()
		return vector3( 0.0, 0.0, 0.0 );
	end
