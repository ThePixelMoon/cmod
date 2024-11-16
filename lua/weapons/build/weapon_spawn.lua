
TEAM_BLUE		=	2
TEAM_YELLOW		=	3
TEAM_GREEN		=	4
TEAM_RED		=	5

shoot_wait = 0;
can_shoot = false;
WAIT_TIME = 2;

-- Called when the weapon is created.
	
	function onInit( )
		_SWEPSetSound( MyIndex, "single_shot", "Weapon_Pistol.Single" )
	end

	
-- Called every frame

	function onThink( )
	end
	
	
	function onPrimaryAttack( )
		if (not _PlayerInfo(Owner, "alive")) then return; end
		
		_RunString("setSpawnPoint(" .. Owner .. ")");
	end
	
	
	function onSecondaryAttack( )
		_RunString("resetSpawnPoint(" .. Owner .. ")");
	end
	
	function Deploy( )
		
	end
	
	function Holster( )
	
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
		return 2;	
	end
	
	function getWeaponSlotPos()
		return 6;	
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
		return 0.5;
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
		return "models/weapons/v_iRifle.mdl";
	end
	
	function getWorldModel( )
		return "models/weapons/w_iRifle.mdl";
	end
	
	function getClassName()
		return "weapon_spawn";
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
		return "ar2";
	end

	function getPrintName()
		return "Set Spawnpoint";
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
