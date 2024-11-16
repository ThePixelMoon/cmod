
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
		local vecpos = _PlayerGetShootPos(Owner);
		local plyang = _PlayerGetShootAng(Owner);
		
		_TraceLine(vecpos, plyang, 8000, Owner);
		
		vecpos = vecAdd( vecpos, vector3( 0, 0, -20 ) );
		
		local hitpos = _TraceEndPos();
		
		if (_TraceHit() == false)  then
			hitpos = vecAdd( vecpos, vecMul( plyang, vector3(8000,8000,8000) ) )
		end
		
		_EffectInit();
			_EffectSetEnt( 255 );
			_EffectSetOrigin( hitpos );
			_EffectSetStart( vecpos );
			_EffectSetScale( 40 );
			_EffectSetMagnitude( 0.5 );
		_EffectDispatch( "FadingLine" );
		
		if (_TraceHit() == true)  then 
			if (_TraceHitNonWorld()) and (_TraceGetEnt() > _MaxPlayers()) then 
				if (_EntGetType(_TraceGetEnt()) == "prop_physics") then
					_RunString("removeProp(" .. Owner .. ", " .. _TraceGetEnt() .. ")");
				end
			end
		end	
	end
	
	
	function onSecondaryAttack( )
		--
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
		return 5;	
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
		return 0.5;
	end
	
	function getSecondaryShotDelay()
		return 0.25;
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
		return "models/weapons/v_crossbow.mdl";
	end
	
	function getWorldModel( )
		return "models/weapons/w_crossbow.mdl";
	end
	
	function getClassName()
		return "weapon_propremover";
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
		return "Prop Remover Gun";
	end
	
	
	-- 0 = Don't override, shoot bullets, make sound and flash
	-- 1 = Don't shoot bullets but do make flash/sounds
	-- 2 = Only play animations
	-- 3 = Don't do anything
	
	function getPrimaryScriptOverride()
		return 1;
	end

	function getSecondaryScriptOverride()
		return 3;
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
