--Assign a script to a weapon scripted. Syntax: (weapon) (script)
function _WeaponScriptedAssign(weapon, script) end

--Sets SWEP's sound. Syntax: (weapon index) (action) (sound)
function _SWEPSetSound(weapon_index, action, sound) end

--Takes ammo from SWEP gun. Syntax: (weapon index) (clip# [0|1]) (amount)
function _SWEPUseAmmo(weapon_index, clip_0_1, amount) end

--Re-reads all the 'fetch' variables. You should call this if you have changed the accuracy etc.. Syntax: (weapon index)
function _SWEPUpdateVariables(weapon_index) end

--Runs a LUA string in the weapon's LUA instance Syntax: (weapon index) (string)
function _SWEPRunString(weapon_index, string) end

_swep = {}

--Get amount of ammo in a clip. Syntax: (weapon index) (clip# [0|1])
function _swep.GetClipAmmo(weapon_index, clip_0_1) end

--Get amount of ammo in a clip. Syntax: (weapon index) (clip# [0|1]) (clip)
function _swep.SetClipAmmo(weapon_index, clip_0_1, clip) end

--Gets death icon name. Syntax: (weapon index)
function _swep.GetDeathIcon(weapon_index) end

--Set the material of specified entity. Syntax: (entid) (material filename)
function _EntSetMaterial(entid, material_filename) end

--Set the gravity for specified entity. Syntax: (entid) (gravity)
function _EntSetGravity(entid, gravity) end

--Returns a entity type name. Syntax: (entid)
function _EntGetType(entid) end

--Returns an entity by targetname (0 if not found). Syntax: (name)
function _EntGetByName(name) end

--Returns a vector representing the position of the entity
function _EntGetPos(entid) end

--Make entity emit sound. Syntax: (entid) (soundfilename)
function _EntEmitSound(entid, soundfilename) end

--Make entity emit sound. Syntax: (entid) (soundfilename) (volume multiplier) (pitch multiplier)
function _EntEmitSoundEx(entid, soundfilename, volume_multiplier, pitch_multiplier) end

--Sets the position of the entity. Syntax: (entid) (vector3 pos)
function _EntSetPos(entid, vector3_pos) end

--Gets the enties velocity. Returned as a vector3. Syntax: (entid)
function _EntGetVelocity(entid) end

--Sets the velocity of the entity. Syntax: (entid) (vector3 newvelocity)
function _EntSetVelocity(entid, vector3_newvelocity) end

--Returns the forward vector. Syntax: (entid)
function _EntGetForwardVector(entid) end

--Returns the right vector. Syntax: (entid)
function _EntGetRightVector(entid) end

--Returns the up vector. Syntax: (entid)
function _EntGetUpVector(entid) end

--ent_fire an entity. Syntax: (entid) (action) (value) (delay)
function _EntFire(entid, action, value, delay) end

--Creates but doesn't spawn specified entity. Syntax: (entname)
function _EntCreate(entname) end

--Spawns specified entity. Syntax: (entindex)
function _EntSpawn(entindex) end

--Activate an entity. Syntax: (entindex)
function _EntActivate(entindex) end

--Sets an entity keyvalue (Must be done before spawning!). Syntax: (entindex) (string keyname) (string keyvalue)
function _EntSetKeyValue(entindex, string_keyname, string_keyvalue) end

--Sets the model of an entity. PRECACHE THE MODEL FIRST. Syntax: (ent) (modelname)
function _EntSetModel(ent, modelname) end

--Sets the owner. Syntax: (ent) (ownerid)
function _EntSetOwner(ent, ownerid) end

--Gets the entity's owner. Syntax: (ent)
function _EntGetOwner(ent) end

--Removes entity.. Syntax: (entindex)
function _EntRemove(entindex) end

--Check if entity exists.. Syntax: (entindex)
function _EntExists(entindex) end

--Precaches a model; Syntax: (modelname)
function _EntPrecacheModel(modelname) end

--Sets the angle of the entity (using a forward vector). Syntax: (entid) (vector3 ang)
function _EntSetAng(entid, vector3_ang) end

--Sets the ANGLE of the entity. Syntax: (entid) (vector3 angle)
function _EntSetAngAngle(entid, vector3_angle) end

--Returns the angle as a normalized 'forward' vector. Syntax: (entid)
function _EntGetAng(entid) end

--Returns the angle as a vector3. Syntax: (entid)
function _EntGetAngAngle(entid) end

--Returns the entity's model name. Syntax: (entid)
function _EntGetModel(entid) end

--Resets the effect data
function _EffectInit() end

--Syntax: (vector)
function _EffectSetOrigin(vector) end

--Syntax: (vector)
function _EffectSetAngles(vector) end

--Syntax: (vector)
function _EffectSetNormal(vector) end

--Syntax: (vector)
function _EffectSetStart(vector) end

--Syntax: (entindex)
function _EffectSetEnt(entindex) end

--Syntax: (int)
function _EffectSetFlags(int) end

--Syntax: (float)
function _EffectSetScale(float) end

--Syntax: (float)
function _EffectSetMagnitude(float) end

--Syntax: (float)
function _EffectSetRadius(float) end

--Syntax: (int)
function _EffectSetAttachIndex(int) end

--Syntax: (name)
function _EffectDispatch(name) end

--Returns a table of entities (or nil if none): (classname)
function _EntitiesFindByClass(classname) end

--Returns a table of entities contained in the sphere: (vector position) (radius)
function _EntitiesFindInSphere(vector_position, radius) end

--Returns a table of entities (or nil if none): (targetname)
function _EntitiesFindByName(targetname) end

--Returns the last physics attacker.. (entity)
function _EntityGetPhysicsAttacker(entity) end

--Sets the physics attacker on a specified object (entity) (attacker)
function _EntitySetPhysicsAttacker(entity, attacker) end

--Pass entity as -1 to clear the ground entity. Syntax: (entity) (groundentity)
function _EntSetGroundEntity(entity, groundentity) end

--Pass entity as -1 to clear the ground entity. Syntax: (entity) (groundentity)
function _EntGetGroundEntity(entity, groundentity) end

--Sets the movetype. Syntax: (entity) (type)
function _EntSetMoveType(entity, type) end

--Gets the movetype. Syntax: (entity)
function _EntGetMoveType(entity) end

--Sets the movecollide. Syntax: (entity) (type)
function _EntSetMoveCollide(entity, type) end

--Gets the movecollide. Syntax: (entity)
function _EntGetMoveCollide(entity) end

--Sets the solid type. Syntax: (entity) (type)
function _EntSetSolid(entity, type) end

--Gets the solid type. Syntax: (entity)
function _EntGetSolid(entity) end

--Sets the collision group. Syntax: (entity) (group)
function _EntSetCollisionGroup(entity, group) end

--Gets the collision group. Syntax: (entity)
function _EntGetCollisionGroup(entity) end

--Returns a number representing how under water an entity is. 0 means not underwater. 3 is totally underwater. Syntax: (entity)
function _EntGetWaterLevel(entity) end

--Sets an activity for an ent. Works for NPC's only. Syntax: (entid) (int sequence)
function _EntSetActivity(entid, int_sequence) end

--Gets an enemy disposition. Syntax: (NPC) (Enity)
function _EntGetDisposition(NPC, Enity) end

--Sets an entities parent. Syntax: (entid) (parent) (attachment)
function _EntSetParent(entid, parent, attachment) end

--Gets an entities parent. Syntax: (entid)
function _EntGetParent(entid) end

--Gets an entities name. Syntax: (entid)
function _EntGetName(entid) end

--Sets an entities name. Syntax: (entid) (name)
function _EntSetName(entid, name) end

--Gets entity max health. Syntax: (entid) (health)
function _EntSetMaxHealth(entid, health) end

--Sets entity max health. Syntax: (entid)
function _EntGetMaxHealth(entid) end

_file = {}

--Returns true if file exists. Syntax: (filename)
function _file.Exists(filename) end

--Reads a file into a string. Syntax: (filename)
function _file.Read(filename) end

--Writes a string to a file. Syntax: (filename) (string)
function _file.Write(filename, string) end

--Creates Dir Hierarchy. Syntax: (folder)
function _file.CreateDir(folder) end

--Returns true if is Dir. Syntax: (folder)
function _file.IsDir(folder) end

--Finds files, returns table, parameter should be like "maps/*.bsp". Syntax: (wildcard)
function _file.Find(wildcard) end

--Deletes specified file; Syntax: (wildcard)
function _file.Delete(wildcard) end

--Renames specified file; Syntax: (before) (after)
function _file.Rename(before, after) end

--Starts the next level
function _StartNextLevel() end

--Returns next map name
function _GetNextMap() end

--Returns current map name
function _GetCurrentMap() end

--Gets a rule. Syntax: (rule string)
function _GetRule(rule_string) end

--Runs a console command. Syntax: (command)
function _ServerCommand(command) end

--Sets targetID rules. Syntax: (int rule)
function _GameSetTargetIDRules(int_rule) end

--Force the file to be the same on client and server. Should be called after precaching the file. Syntax: (filename)
function _ForceFileConsistency(filename) end

--Sends a plugin message. Syntax: (userid) (title) (message) (time) (r)(g)(b)(a) (level)
function _PluginMsg(userid, title, message, time, r_g_b_a, level) end

--Sends plug in text. Syntax: (userid) (title) (message) (time) (r)(g)(b)(a) (level)
function _PluginText(userid, title, message, time, r_g_b_a, level) end

--Attack using the last trace. Syntax: (victim) (inflictor ent) (attacker ent) (amount)
function _TraceAttack(victim, inflictor_ent, attacker_ent, amount) end

--Sets the collision group for the next trace to use. Syntax: (group)
function _TraceSetCollisionGroup(group) end

--Sets the MASK_ to use for the next trace. Syntax: (group)
function _TraceSetMask(group) end

--Traces a line. Syntax: (vector start) (vector direction) (length) (ignore (optional))
function _TraceLine(vector_start, vector_direction, length, ignore_optional) end

--Return the endpos from the last trace
function _TraceEndPos() end

--Return the fraction of trace completed
function _TraceFraction() end

--Return the true if the last trace hit the world
function _TraceHitWorld() end

--Return the true if the last trace hit non world
function _TraceHitNonWorld() end

--Return the true if the last trace hit something
function _TraceHit() end

--Return the entity that the last trace hit
function _TraceGetEnt() end

--Return the normal of the surface that the trace hit
function _TraceGetSurfaceNormal() end

--Returns true if last hit was the sky
function _TraceDidHitSky() end

--Returns true if last hit was some kind of hitbox
function _TraceDidHitHitbox() end

--Returns the name of the texture that we hit
function _TraceGetTexture() end

--Returns true if we hit water
function _TraceDidHitWater() end

--Makes a decal using the last trace. Syntax: (decal)
function _MakeDecal(decal) end

--Sets weapon model. Syntax: (weapon name) (model type) (model name)
function _WeaponSetModel(weapon_name, model_type, model_name) end

--Sets weapon slot. Syntax: (weapon name) (slot) (pos)
function _WeaponSetSlot(weapon_name, slot, pos) end

--Sets weapon sound. Syntax: (weapon name) (action) (sound)
function _WeaponSetSound(weapon_name, action, sound) end

--Sets a weapon's draw FOV. Syntax: (weapon name) (fov)
function _WeaponSetFOV(weapon_name, fov) end

--Flips a weapon's hands. Syntax: (weapon name) (bool)
function _WeaponFlipHands(weapon_name, bool) end

--Sets the damage that a bullet from this gun does. Syntax: (weapon name) (damage)
function _WeaponSetDamage(weapon_name, damage) end

--Sets anim prefix . Syntax: (weapon name) (animprefix) (clipsize1) (clipsize2) (defaultammo1) (defaultammo2) (primaryammo) (secondaryammo)
function _WeaponSetup(weapon_name, animprefix, clipsize1, clipsize2, defaultammo1, defaultammo2, primaryammo, secondaryammo) end

--Get a server convar float. Syntax: (name)
function _GetConVar_Float(name) end

--Get a server convar string. Syntax: (name)
function _GetConVar_String(name) end

--Get a server convar bool. Syntax: (name)
function _GetConVar_Bool(name) end

--Get a client convar string. Syntax: (userid) (name)
function _GetClientConVar_String(userid, name) end

--Play a sound. Syntax: (soundname)
function _PlaySound(soundname) end

--Play a sound to a specific player. Syntax: (playerid) (soundname)
function _PlaySoundPlayer(playerid, soundname) end

--Returns the current time in seconds.
function _CurTime() end

--Returns the max players in the server.
function _MaxPlayers() end

-- Initialize the text. Syntax: (fontname)
function _GModText_Start(fontname) end

-- Set Position. Syntax: (x) (y)
function _GModText_SetPos(x, y) end

-- Allow the text to go offscreen. Syntax: (bool)
function _GModText_AllowOffscreen(bool) end

-- Set entity to hover over. Syntax: (entindex)
function _GModText_SetEntity(entindex) end

-- Set Colour. Syntax: (r) (g) (b) (a)
function _GModText_SetColor(r, g, b, a) end

-- Set Times. Syntax: (duration) (fadein) (fadeout)
function _GModText_SetTime(duration, fadein, fadeout) end

-- Set delay time. Syntax: (delay)
function _GModText_SetDelay(delay) end

-- Set Times. Syntax: (text)
function _GModText_SetText(text) end

-- Set Additive mode. Syntax: (bool)
function _GModText_SetAdditive(bool) end

-- Set entity offset to draw the text at. Syntax: (vector)
function _GModText_SetEntityOffset(vector) end

-- If player is 0 it is sent to everyone. Index says which slot this text should fill. (player) (index)
function _GModText_Send(player, index) end

-- Hides specified text. (player) (index) (fade time) (delay)
function _GModText_Hide(player, index, fade_time, delay) end

-- Hides All texts. (player)
function _GModText_HideAll(player) end

-- The same as normal send but will animate from Send to the new values. (player) (index) (length) (ease)
function _GModText_SendAnimate(player, index, length, ease) end

-- Initialize the text. Syntax: (material)
function _GModRect_Start(material) end

-- Set Position. Syntax: (x) (y) (width) (height)
function _GModRect_SetPos(x, y, width, height) end

-- Set entity to hover over. Syntax: (entindex)
function _GModRect_SetEntity(entindex) end

-- Set Colour. Syntax: (r) (g) (b) (a)
function _GModRect_SetColor(r, g, b, a) end

-- Set Times. Syntax: (duration) (fadein) (fadeout)
function _GModRect_SetTime(duration, fadein, fadeout) end

-- Set delay time. Syntax: (delay)
function _GModRect_SetDelay(delay) end

-- Set Additive mode. Syntax: (bool)
function _GModRect_SetAdditive(bool) end

-- Set entity offset to draw the text at. Syntax: (vector)
function _GModRect_SetEntityOffset(vector) end

-- If player is 0 it is sent to everyone. Index says which slot this text should fill. (player) (index)
function _GModRect_Send(player, index) end

-- If player is 0 it is sent to everyone. Index says which slot this text should fill. (player) (index) (length) (ease)
function _GModRect_SendAnimate(player, index, length, ease) end

-- Hides specified rect. (player) (index) (fade time) (delay)
function _GModRect_Hide(player, index, fade_time, delay) end

--Hides All rects. (player)
function _GModRect_HideAll(player) end

--Runs a command in the main gameplay script. (command)
function _RunString(command) end

--Gets the path to the gmod folder (on the server). No trailing slash.
function _GetModPath() end

--Returns whether linux or not.
function _IsLinux() end

--Returns whether dedicated server or not.
function _IsDedicatedServer() end

-- Hides specified world quads. (player) (index) (fade time) (delay)
function _GModQuad_Hide(player, index, fade_time, delay) end

-- Hides All world quads. (player)
function _GModQuad_HideAll(player) end

-- Initialize the quad. Syntax: (material)
function _GModQuad_Start(material) end

-- Set a vector of one of the quad's corners. Syntax: (corner [0-3]) (vector)
function _GModQuad_SetVector(corner0_3, vector) end

-- Set Timings. Syntax: (delay) (fadein) (life) (fadeout)
function _GModQuad_SetTimings(delay, fadein, life, fadeout) end

-- SetEntity to follow. Syntax: (entityid)
function _GModQuad_SetEntity(entityid) end

-- Send a quad to player. All players if player is 0. (player) (index)
function _GModQuad_Send(player, index) end

-- Send a quad to player. All players if player is 0. (player) (index) (length) (ease)
function _GModQuad_SendAnimate(player, index, length, ease) end

-- Sets the default relationship between two lifetypes. (class) (class) (disposition)
function _SetDefaultRelationship(class, class, disposition) end

_gameevent = {}

--Starts a (fake) gameevent. (name)
function _gameevent.Start(name) end

--Set Variable. (name) (value)
function _gameevent.SetString(name, value) end

--Set Variable. (name) (value)
function _gameevent.SetInt(name, value) end

--Fire event.
function _gameevent.Fire() end

_spawnmenu = {}

--Syntax: (playerid) (category) (name) (model/ent/etc)
function _spawnmenu.AddItem(playerid, category, name, model_ent_etc) end

--Syntax: (playerid) (category)
function _spawnmenu.RemoveCategory(playerid, category) end

--Syntax: (playerid)
function _spawnmenu.RemoveAll(playerid) end

--Syntax: (playerid) (category)
function _spawnmenu.SetCategory(playerid, category) end

_npc = {}

--Syntax: (ent)
function _npc.ExitScriptedSequence(ent) end

--Syntax: (ent) (sched)
function _npc.SetSchedule(ent, sched) end

--Syntax: (ent) (vector)
function _npc.SetLastPosition(ent, vector) end

--Syntax: (ent) (ent) (disposition) (priority (int))
function _npc.AddRelationship(ent, ent, disposition, priority_int) end

_phys = {}

--Enable/Disable motion. Syntax: (entid) (bool)
function _phys.EnableMotion(entid, bool) end

--Enable/Disable drag. Syntax: (entid) (bool)
function _phys.EnableDrag(entid, bool) end

--Enable/Disable gravity. Syntax: (entid) (bool)
function _phys.EnableGravity(entid, bool) end

--Enable/Disable Collisions. Syntax: (entid) (bool)
function _phys.EnableCollisions(entid, bool) end

--Gets mass. Syntax: (entid)
function _phys.GetMass(entid) end

--Sets mass. Syntax: (entid) (mass)
function _phys.SetMass(entid, mass) end

--Make object sleep. Syntax: (entid)
function _phys.Sleep(entid) end

--Wake a sleeping object. Syntax: (entid)
function _phys.Wake(entid) end

--Check whether object is rested. Syntax: (entid)
function _phys.IsAsleep(entid) end

--Returns true if entity has a physics object.. Syntax: (entid)
function _phys.HasPhysics(entid) end

--Set Entities for constraint.. Syntax: (Constraint Entity) (Entity 1) (Entity 2)
function _phys.ConstraintSetEnts(Constraint_Entity, Entity_1, Entity_2) end

--Pushes an object from the center. Syntax: (entid) (vector3 force)
function _phys.ApplyForceCenter(entid, vector3_force) end

--Pushes an object from the center. Syntax: (entid) (vector3 force) (vector3 worldpos)
function _phys.ApplyForceOffset(entid, vector3_force, vector3_worldpos) end

--Applys torque to the object. Syntax: (entid) (vector3 force)
function _phys.ApplyTorqueCenter(entid, vector3_force) end

--Shows the scoreboard on the specified players screen. Syntax: (playerid)
function _PlayerShowScoreboard(playerid) end

--Enable/Disable sprint for player. Syntax: (playerid) (freeze bool)
function _PlayerSetSprint(playerid, freeze_bool) end

--Freeze the specified player. Syntax: (playerid) (freeze bool)
function _PlayerFreeze(playerid, freeze_bool) end

--Returns the vector of the player's shoot position. Syntax: (playerid)
function _PlayerGetShootPos(playerid) end

--Returns the forward vector of the player's shoot angle. Syntax: (playerid)
function _PlayerGetShootAng(playerid) end

--Returns the player's active weapon id. Syntax: (playerid)
function _PlayerGetActiveWeapon(playerid) end

--Kill the specified player. Syntax: (playerid)
function _PlayerKill(playerid) end

--Give specified player ammo. Syntax: (playerid) (num amount) (string ammotype) (bool playsounds)
function _PlayerGiveAmmo(playerid, num_amount, string_ammotype, bool_playsounds) end

--Force player to re-spawn. Syntax: (playerid)
function _PlayerRespawn(playerid) end

--Sets whether to draw the team circle or not. Syntax: (playerid) (bool)
function _PlayerSetDrawTeamCircle(playerid, bool) end

--Returns info about a specific player (check 'connected' first!). Syntax: (playerid) (request)
function _PlayerInfo(playerid, request) end

--Changes a player's team. Syntax: (playerid) (teamid)
function _PlayerChangeTeam(playerid, teamid) end

--Changes a player's model. Syntax: (playerid) (model)
function _PlayerSetModel(playerid, model) end

--Returns a random allowed playermodel.
function _PlayerGetRandomAllowedModel() end

--Changes a player's health. Syntax: (playerid) (newhealth)
function _PlayerSetHealth(playerid, newhealth) end

--Changes a player's armour. Syntax: (playerid) (newarmor)
function _PlayerSetArmor(playerid, newarmor) end

--Changes a player's max speed. Syntax: (playerid) (speed)
function _PlayerSetMaxSpeed(playerid, speed) end

--Add to players score (can be minus). Syntax: (playerid) (increment)
function _PlayerAddScore(playerid, increment) end

--Sets to players score. Syntax: (playerid) (score)
function _PlayerSetScore(playerid, score) end

--Add to players deaths score (can be minus). Syntax: (playerid) (increment)
function _PlayerAddDeath(playerid, increment) end

--Give player named item. Syntax: (playerid) (item)
function _PlayerGiveItem(playerid, item) end

--Give player scripted weapon. Syntax: (playerid) (weapon script)
function _PlayerGiveSWEP(playerid, weapon_script) end

--Strip all of a player's weapons. Syntax: (playerid)
function _PlayerRemoveAllWeapons(playerid) end

--Strip a specific weapon. Syntax: (playerid) (weaponname)
function _PlayerRemoveWeapon(playerid, weaponname) end

--Add score for a team. Syntax: (teamid) (increment)
function _TeamAddScore(teamid, increment) end

--Set score for a team. Syntax: (teamid) (score)
function _TeamSetScore(teamid, score) end

--Get the number of players on a team.. Syntax: (teamid)
function _TeamNumPlayers(teamid) end

--Allow the player to spraypaint now rather than waiting the 30 or so seconds. Syntax: (playerid)
function _PlayerAllowDecalPaint(playerid) end

--Returns the number of teams
function _TeamCount() end

--Returns the total team score. Syntax: (teamid)
function _TeamScore(teamid) end

--Sets the name of the team. Syntax: (teamid) (new name)
function _TeamSetName(teamid, new_name) end

--Sets whether to draw the player's view model. Syntax: (playerid) (bool)
function _PlayerSetDrawViewModel(playerid, bool) end

--Select weapon. Syntax: (playerid) (weapon name)
function _PlayerSelectWeapon(playerid, weapon_name) end

--Sets whether to draw the player's world model. Syntax: (playerid) (bool)
function _PlayerSetDrawWorldModel(playerid, bool) end

--Player has an option to select. Syntax: (playerid) (callback) (timeout)
function _PlayerOption(playerid, callback, timeout) end

--Sets the position of the view vector (0, 0, 64) default. Syntax: (playerid) (vector)
function _PlayerSetVecView(playerid, vector) end

--Check whether specified key is pressed. Syntax: (playerid) (in_key)
function _PlayerIsKeyDown(playerid, in_key) end

--Stop spectating mode. Syntax: (playerid) (mode)
function _PlayerSpectatorStart(playerid, mode) end

--Set Spectator target for player. Syntax: (playerid) (target)
function _PlayerSpectatorTarget(playerid, target) end

--Stop spectating mode. Syntax: (playerid)
function _PlayerSpectatorEnd(playerid) end

--Sets the position of the duck view vector (0, 0, 24) default. Syntax: (playerid) (vector)
function _PlayerSetVecDuck(playerid, vector) end

--Print a message to everyone on the server. Syntax: (type of message) (string message)
function _PrintMessageAll(type_of_message, string_message) end

--Advanced function to print text to the screen. Syntax: (playerid) (string message) (posx) (posy) (r)(g)(b)(a) (fadein) (fadeout) (holdtime) (effect [0-2]) (channel [0-5])
function _ScreenText(playerid, string_message, posx, posy, r_g_b_a, fadein, fadeout, holdtime, effect0_2, channel0_5) end

--Print a message to a specific player. Syntax:  (playerid) (type of message) (string message)
function _PrintMessage(playerid, type_of_message, string_message) end

--Returns the player's preferred model. Returns a blank if the model isn't valid. Syntax: (playerid)
function _PlayerPreferredModel(playerid) end

--Silently kill a player. Syntax: (playerid) (respawn time) (bool Dissolve)
function _PlayerSilentKill(playerid, respawn_time, bool_Dissolve) end

--Syntax: (playerid)
function _PlayerDetonateTripmines(playerid) end

--Syntax: (playerid)
function _PlayerHolsterWeapon(playerid) end

--Syntax: (playerid) (fov) (time)
function _PlayerSetFOV(playerid, fov, time) end

--Syntax: (playerid) (bool (on/off))
function _PlayerSetFlashlight(playerid, bool_on_off) end

--Syntax: (playerid)
function _PlayerStopZooming(playerid) end

--Syntax: (playerid) (distance)
function _PlayerSetChaseCamDistance(playerid, distance) end

--Syntax: (playerid) (bool)
function _PlayerLockInPlace(playerid, bool) end

--Syntax: (playerid)
function _PlayerRemoveAllAmmo(playerid) end

--Syntax: (playerid) (bool)
function _PlayerDisableAttack(playerid, bool) end

--Syntax: (playerid) (bool)
function _PlayerShowCrosshair(playerid, bool) end

--Syntax: (playerid) (bool)
function _PlayerEnableSprint(playerid, bool) end

--If successful returns the length of the sequence in seconds. Syntax: (playerid) (int sequence)
function _PlayerViewModelSequence(playerid, int_sequence) end

-- Syntax: (playerid) (limit name)
function _PlayerGetLimit(playerid, limit_name) end

--Sets a players animation. Syntax: (player) (int sequence)
function _PlayerSetAnimation(player, int_sequence) end

--Sets a players weapon activity. Syntax: (player) (int sequence)
function _PlayerSetWeaponSequence(player, int_sequence) end

--Returns true if a player is crouching. Syntax: (player)
function _PlayerIsCrouching(player) end

--Make a player attempt to enter a vehicle. Syntax: (player) (vehicle)
function _PlayerUseVehicle(player, vehicle) end

--Give a player God Mode. Syntax: (player) (bool)
function _PlayerGod(player, bool) end

--Returns true if the player has this weapon. Syntax: (player) (weapon name)
function _PlayerHasWeapon(player, weapon_name) end

--Let the player's weapon decide how we should act out specific sequence. Syntax: (player) (int sequence)
function _PlayerWeaponTranslateSequence(player, int_sequence) end

_player = {}

--Show/Hide a panel by name. Syntax: (player) (name) (show (bool))
function _player.ShowPanel(player, name, show_bool) end

--Set the player's context menu. Syntax: (player) (name)
function _player.SetContextMenu(player, name) end

--returns true if flashlight is on. Syntax: (player)
function _player.GetFlashlight(player) end

--Set player FL on/off. Syntax: (player) (on)
function _player.SetFlashlight(player, on) end

--Get the last place the player was hit. Syntax: (player)
function _player.LastHitGroup(player) end

--Should player drop weapon on death? Syntax: (player) (bool)
function _player.ShouldDropWeapon(player, bool) end

_util = {}

--Returns playerid of player with name. Syntax: (name)
function _util.PlayerByName(name) end

--Returns playerid. Syntax: (userid)
function _util.PlayerByUserId(userid) end

--Returns entities contained in a box. Syntax: (min vec) (max vec)
function _util.EntsInBox(min_vec, max_vec) end

--Drops entity to floor. Syntax: (ent)
function _util.DropToFloor(ent) end

--Shakes screen. Syntax: (pos) (amp) (frequency), (duration) (radius)
function _util.ScreenShake(pos, amp, frequency, duration, radius) end

--Point one entity towards the other. Syntax: (ent) (ent)
function _util.PointAtEntity(ent, ent) end

--Outputs message to console. Syntax: (message)
function _Msg(message) end

--Opens a script. Syntax: (filename)
function _OpenScript(filename) end

--Internal Lua usage. Outputs error message. Syntax: (message)
function _ALERT(message) end

--Returns vector3 as table
function vector3(x, y, z) end

--Brainles5 Lua Helper File! Feel free to use or transform and share however you like!