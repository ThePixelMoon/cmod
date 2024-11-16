-- 	DO NOT EDIT THIS FILE!
--	This file defines the event callback functions which the engine calls.
--  If you want to override these you should override it in a custom script
--   or in your gamemode script. This file should be used as a reference to
--   see which callbacks are available and the correct syntax.
function eventPlayerActive(name, userid, steamid) end
function eventPlayerConnect(name, address, steamid) end
function eventPlayerDisconnect(name, userid, address, steamid, reason) end
function eventPlayerChangeTeam(name, userid, new_team, old_team) end
function eventPlayerKilled(userid, attacker, weapon) end
function eventPlayerNameChange(userid, newname, oldname) end
function eventPlayerHurt(userid, newhealth, attacker) end
-- Return false to choose a random valid team
function PickDefaultSpawnTeam(userid) return false; end
function eventPlayerSpawn(userid) end
-- return true to allow
function eventPlayerSpawnProp(userid, propname) return true; end
function eventPlayerDuplicateProp(userid, propid) return true; end
function eventPlayerSpawnRagdoll(userid, propname) return true; end
function eventPlayerDuplicateRagdoll(userid, propid) return true; end
function eventPlayerPropSpawned(userid, propid) end
function eventPlayerRagdollSpawned(userid, propid) end
-- player will "say" the returned string - return nothing ("") to block the say.
function eventPlayerSay(userid, strText, bTeam) return strText; end
function eventPropBreak(breakerid, propid) end
function eventNPCKilled(killerid, killed, inflictor) end
-- return true if the specified player can pickup the specified item/weapon
function canPlayerHaveItem(playerid, itemname) return true; end
-- return true to tell the engine that you've taken care of it and to not do default actions
function eventPlayerUseEntity(playerid, entity) return false; end
function eventPlayerInitialSpawn(playerid) end

function eventKeyPressed(userid, in_key) end
function eventKeyReleased(userid, in_key) end
function OnBalloonExplode(balloon, killer) end

function onPhysTakeDamage(ent, inflictor, attacker) end
function onTakeDamage(ent, inflictor, attacker, damage) end

-- Return true if the player can delete the speficied entity
function onPlayerRemove(player, entity) return true; end

-- Gravity Gun
function onGravGunPunt(player, entity) return true; end
function onGravGunPickup(player, entity) return true; end
function onGravGunLaunch(player, entity) return true; end
function onGravGunDrop(player, entity) return true; end

-- Physgun
function onPhysPickup(player, entity) return true; end
function onPhysFreeze(player, entity) return true; end
function onPhysDrop(player, entity) end

function GetPlayerDamageScale(hitgroup) return 1.0; end

-- These commands are bound to the F keys by default.
-- Help and Team should always do the same things to offer consistency between mods
-- F3 and F4 are up to you - you can use them however you like in your mod.

-- F1
function onShowHelp(userid) end

-- F2
function onShowTeam(userid) end

-- F3
function onShowSpare1(userid) end

-- F4
function onShowSpare2(userid) end
