-- Fading Doors
if useDoorOpenHook then UnHookEvent(useDoorOpenHook) end
if initialPlayerSpawnHook then UnHookEvent(initialPlayerSpawnHook) end
if onPlayerRemovepropHook then UnHookEvent(onPlayerRemovepropHook) end
if onPlayerDisconnectHook then UnHookEvent(eventPlayerDisconnect) end
if propSpawnedHook then UnHookEvent(propSpawnedHook) end
if propDupedHook then UnHookEvent(propDupedHook) end

FadingDoors = FadingDoors or {};
Keypads = Keypads or {};
DoorSettings = DoorSettings or {};

function CreateDoorSettings(index, owner)
    DoorSettings[index] = {};
    DoorSettings[index].Color = "100+255+100";
    DoorSettings[index].Time = 10;
    DoorSettings[index].PadOnly = true;
    if owner ~= nil then
        DoorSettings[index].Owner = owner;
    else
        DoorSettings[index].Owner = index;
    end
    DoorSettings[index].Access = {};
    giveAccess(index, DoorSettings[index].Owner);
end

function giveAccess(userid, arg)
    DoorSettings[tonumber(userid)].Access[tonumber(arg)] = true;
    reloadSpawnMenu(userid)
end

function revokeAccess(userid, arg)
    DoorSettings[tonumber(userid)].Access[tonumber(arg)] = false;
    reloadSpawnMenu(userid)
end

function targetDoor(userid)
    PlayerLookTrace(userid, 150);
    local proptarget = _TraceGetEnt();
    MakeDoor(proptarget, userid)
end

function targetKeypad(userid)
    PlayerLookTrace(userid, 150);
    local proptarget = _TraceGetEnt();
    MakeKeypad(proptarget, userid)
end

function MakeDoor(proptarget, settingsindex)
    if _EntGetType(proptarget) == "prop_physics" and FadingDoors[proptarget] ==
        nil and Keypads[proptarget] == nil then
        if protect_props and
            not prop_protection(DoorSettings[settingsindex].Owner, proptarget) then
            return
        end

        FadingDoors[proptarget] = {};
        FadingDoors[proptarget].Owner = settingsindex;
        ApplyDoorSettings(settingsindex, proptarget)
        FadingDoors[proptarget].Flags = {};
        FadingDoors[proptarget].Flags["solid"] = _EntGetSolid(proptarget);
        FadingDoors[proptarget].Flags["collision"] =
            _EntGetCollisionGroup(proptarget);
        FadingDoors[proptarget].IsOpen = false;
        FadingDoors[proptarget].Keypads = {};
        FadingDoors[proptarget].Timer = nil;
        DoorSettings[settingsindex].KeyTarget = proptarget;
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTTALK,
                      "[Fading Doors] Created Door")
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTCONSOLE,
                      "[Fading Doors] Created Door")
    else
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTTALK,
                      "[Fading Doors] Trace hit nothing")
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

function ApplyDoorSettings(index, door)
    FadingDoors[door].PadOnly = DoorSettings[index].PadOnly;
    FadingDoors[door].Color = DoorSettings[index].Color;
    FadingDoors[door].Time = DoorSettings[index].Time;
    DoorSettings[index].KeyTarget = door;
    applyAccess(index, door)
end

function applyAccess(index, door)
    FadingDoors[door].Access = {};
    for i = 1, _MaxPlayers() do
        if DoorSettings[index].Access[i] == true then
            FadingDoors[door].Access[i] = true
        end
    end
end

function ClearTable(t)
    for k, v in pairs(t) do
        if type(v) == "table" then ClearTable(v) end
        t[k] = nil
    end
end

function UnmakeTarget(proptarget, userid)
    if FadingDoors[proptarget] ~= nil then
        if FadingDoors[proptarget].Timer ~= nil then
            HaltTimer(FadingDoors[proptarget].Timer)
        end
        if _EntExists(proptarget) then closeDoor(proptarget) end
        for k, v in pairs(FadingDoors[proptarget].Keypads) do
            ClearTable(Keypads[v])
            Keypads[v] = nil
        end
        ClearTable(FadingDoors[proptarget])
        FadingDoors[proptarget] = nil

        if (_PlayerInfo(userid, "connected")) then
            _PrintMessage(userid, HUD_PRINTTALK,
                          "[Fading Doors] Unmade Door and its Keypads")
            _PrintMessage(userid, HUD_PRINTCONSOLE,
                          "[Fading Doors] Unmade Door and its Keypads")
        end
    elseif Keypads[proptarget] ~= nil then
        if FadingDoors[Keypads[proptarget].Target] == nil then
            ClearTable(Keypads[proptarget])
        else
            local targetDoor = FadingDoors[Keypads[proptarget].Target]
            for i, v in ipairs(targetDoor.Keypads) do
                if v == proptarget then
                    ClearTable(Keypads[v])
                    Keypads[v] = nil
                    table.remove(targetDoor.Keypads, i)
                    if (_PlayerInfo(userid, "connected")) then
                        _PrintMessage(userid, HUD_PRINTTALK,
                                      "[Fading Doors] Unmade Keypad")
                        _PrintMessage(userid, HUD_PRINTCONSOLE,
                                      "[Fading Doors] Unmade Keypad")
                    end
                end
            end
        end
    end
end

function MakeKeypad(proptarget, settingsindex, isattached)
    if _EntGetType(proptarget) == "prop_physics" and Keypads[proptarget] == nil and
        FadingDoors[proptarget] == nil and DoorSettings[settingsindex].KeyTarget ~=
        nil and FadingDoors[DoorSettings[settingsindex].KeyTarget] ~= nil then
        if protect_props and
            not prop_protection(DoorSettings[settingsindex].Owner, proptarget) then
            return
        end
        Keypads[proptarget] = {}
        Keypads[proptarget].ItSelf = proptarget;
        Keypads[proptarget].Attached = isattached or false;
        Keypads[proptarget].Target = DoorSettings[settingsindex].KeyTarget;
        Keypads[proptarget].Flags = {};
        Keypads[proptarget].Flags["solid"] = _EntGetSolid(proptarget);
        Keypads[proptarget].Flags["collision"] =
            _EntGetCollisionGroup(proptarget);
        table.insert(FadingDoors[DoorSettings[settingsindex].KeyTarget].Keypads,
                     proptarget);

        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTTALK,
                      "[Fading Doors] Created Keypad")
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTCONSOLE,
                      "[Fading Doors] Created Keypad")
    else
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTTALK,
                      "[Fading Doors] Trace hit nothing")
        _PrintMessage(DoorSettings[settingsindex].Owner, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

useDoorOpenHook = HookEvent("eventPlayerUseEntity", function(userid, entity)
    if FadingDoors[entity] ~= nil then
        if FadingDoors[entity].Access[userid] and
            not FadingDoors[entity].PadOnly and not FadingDoors[entity].IsOpen then
            openDoor(entity);
        end
    elseif Keypads[entity] ~= nil then
        if FadingDoors[Keypads[entity].Target].Access[userid] and
            not FadingDoors[Keypads[entity].Target].IsOpen then
            openDoor(Keypads[entity].Target);
        end
    end
end)

propSpawnedHook = HookEvent("eventPlayerPropSpawned",
                            function(userid, entity) UnmakeTarget(entity) end)

propDupedHook = HookEvent("eventPlayerDuplicateProp",
                          function(userid, entity) UnmakeTarget(entity) end)

initialPlayerSpawnHook = HookEvent("eventPlayerInitialSpawn", function(userid)
    _spawnmenu.SetCategory(userid, "Fading Doors")
    CreateDoorSettings(userid)
end)

onPlayerRemovepropHook = HookEvent("onPlayerRemove", function(userid, entity)
    UnmakeTarget(entity, userid)
end)

onPlayerDisconnectHook = HookEvent("eventPlayerDisconnect",
                                   function(name, userid, address, steamid,
                                            reason)
    for i, v in pairs(FadingDoors) do
        if FadingDoors[i] ~= nil then
            if FadingDoors[i].Access[userid] == true then
                FadingDoors[i].Access[userid] = nil
            end
            if FadingDoors[i].Owner == userid then
                UnmakeTarget(i, userid)
            end
        end
    end

    for i = 1, _MaxPlayers() do
        if DoorSettings[i] ~= nil then
            DoorSettings[i].Access[userid] = nil
        end
    end
end)

if not stillExistChecker then
    stillExistChecker = AddTimer(0, 0, function()
        for i, v in pairs(FadingDoors) do
            if not _EntExists(i) then UnmakeTarget(i) end
        end

        for i, v in pairs(Keypads) do
            if not _EntExists(i) then UnmakeTarget(i) end
        end
    end)
end

function openDoor(entity)
    FadingDoors[entity].IsOpen = true;
    _EntSetSolid(entity, 0);
    _EntSetCollisionGroup(entity, COLLISION_GROUP_PASSABLE_DOOR);
    _EntSetKeyValue(entity, "rendermode", "1");
    _EntSetKeyValue(entity, "renderfx", "2");
    _EntFire(entity, "alpha", "70", 0);
    _EntFire(entity, "color", FadingDoors[entity].Color, 0);
    _phys.EnableGravity(entity, false)
    _phys.EnableMotion(entity, false)
    _EntEmitSound(entity, "doors/door1_move.wav");

    for i, v in ipairs(FadingDoors[entity].Keypads) do
        if (Keypads[v].Attached) then
            _EntSetCollisionGroup(Keypads[v].ItSelf,
                                  COLLISION_GROUP_PASSABLE_DOOR);
            _EntSetSolid(Keypads[v].ItSelf, 0);
            _phys.EnableGravity(v, false)
            _phys.EnableMotion(v, false)
        end
        _EntFire(Keypads[v].ItSelf, "color", FadingDoors[entity].Color, 0);
    end
    FadingDoors[entity].Timer = AddTimer(FadingDoors[entity].Time, 1, closeDoor,
                                         entity);
end

function closeDoor(entity)
    if FadingDoors[entity].IsOpen == false then return end
    _EntSetSolid(entity, FadingDoors[entity].Flags["solid"]);
    _EntSetCollisionGroup(entity, FadingDoors[entity].Flags["collision"]);
    _EntSetKeyValue(entity, "rendermode", "0");
    _EntSetKeyValue(entity, "renderfx", "0");
    _EntFire(entity, "color", "255+255+255", 0);
    _EntEmitSound(entity, "doors/door1_stop.wav");
    _phys.EnableGravity(entity, true)

    for i, v in ipairs(FadingDoors[entity].Keypads) do
        _EntSetCollisionGroup(Keypads[v].ItSelf, Keypads[v].Flags["collision"]);
        _EntSetSolid(Keypads[v].ItSelf, Keypads[v].Flags["solid"]);
        _EntFire(Keypads[v].ItSelf, "color", "255+255+255", 0);
        _phys.EnableGravity(v, true)
        _phys.EnableMotion(v, true)
    end
    FadingDoors[entity].Timer = nil;
    FadingDoors[entity].IsOpen = false;
end

function instantFadingDoor(userid, mirror)
    PlayerLookTrace(userid, 150);
    makeInstantDoor(userid, mirror)
end

function makeInstantDoor(userid, mirror)
    local instantdoor = _TraceGetEnt();
    local vSpawnPos = _TraceEndPos();
    local vNormal = _TraceGetSurfaceNormal();

    if protect_props and not prop_protection(userid, instantdoor) then
        return
    elseif FadingDoors[instantdoor] == nil then
        MakeDoor(instantdoor, userid);
    elseif FadingDoors[instantdoor] ~= nil and FadingDoors[instantdoor].Owner ==
        userid then
        DoorSettings[userid].KeyTarget = instantdoor;
    end

    if FadingDoors[instantdoor] ~= nil and FadingDoors[instantdoor].Owner ==
        userid then
        local instantpad = _EntCreate("prop_physics");
        _EntSetPos(instantpad, vSpawnPos);
        _EntSetAng(instantpad, vNormal);
        _EntPrecacheModel("models/props_lab/keypad.mdl");
        _EntSetModel(instantpad, "models/props_lab/keypad.mdl");

        local targetnamepad = "nocollide_" .. tostring(instantpad);
        local targetnamedoor = "nocollide_" .. tostring(instantdoor);

        _EntSetKeyValue(instantpad, "targetname", targetnamepad)
        _EntSetKeyValue(instantdoor, "targetname", targetnamedoor)

        collisionpairname = _EntCreate("logic_collision_pair")
        _EntSetKeyValue(collisionpairname, "attach1", targetnamepad)
        _EntSetKeyValue(collisionpairname, "attach2", targetnamedoor)
        _EntFire(collisionpairname, "DisableCollisions", 1, 0)
        _EntSpawn(instantpad);

        WeldEntities(instantdoor, instantpad)
        _phys.EnableGravity(instantpad, false)
        MakeKeypad(instantpad, userid, true)

        if protect_props then prop_spawned(userid, instantpad) end

        if mirror == "1" then
            local forwardVector = _EntGetForwardVector(instantpad)

            for i = 512, 8, -8 do
                local moveVector = vecMul(forwardVector, i)
                local newPosition = vecSub(vSpawnPos, moveVector)

                _TraceLine(newPosition, forwardVector, i)

                if _TraceGetEnt() == instantdoor then
                    makeInstantDoor(userid)
                    break
                end
            end
        end
    end
end

function reloadSpawnMenu(userid)
    _spawnmenu.RemoveCategory(userid, "Fading Doors")
    FadingDoorSpawnMenu(userid)
end

function traceunmakeTarget(userid)
    PlayerLookTrace(userid, 150);
    if protect_props and not prop_protection(userid, _TraceGetEnt()) then
        return
    end
    if FadingDoors[_TraceGetEnt()] ~= nil and FadingDoors[_TraceGetEnt()].Owner ==
        userid then
        if not FadingDoors[_TraceGetEnt()].IsOpen then
            UnmakeTarget(_TraceGetEnt(), userid);
        else
            _PrintMessage(userid, HUD_PRINTTALK,
                          "[Fading Doors] Door has to be closed")
            _PrintMessage(userid, HUD_PRINTCONSOLE,
                          "[Fading Doors] Door has to be closed")
        end
    elseif Keypads[_TraceGetEnt()] ~= nil and
        FadingDoors[Keypads[_TraceGetEnt()].Target].Owner == userid then
        if not FadingDoors[Keypads[_TraceGetEnt()].Target].IsOpen then
            UnmakeTarget(_TraceGetEnt(), userid);
        else
            _PrintMessage(userid, HUD_PRINTTALK,
                          "[Fading Doors] Door has to be closed")
            _PrintMessage(userid, HUD_PRINTCONSOLE,
                          "[Fading Doors] Door has to be closed")
        end
    else
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Trace hit nothing")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

function settingsColor(userid, color)
    local textcolor = ""
    if color == "255+100+100" then
        textcolor = "Red"
    elseif color == "100+255+100" then
        textcolor = "Green"
    elseif color == "100+100+255" then
        textcolor = "Blue"
    elseif color == "255+100+255" then
        textcolor = "Purple"
    elseif color == "255+255+100" then
        textcolor = "Yellow"
    elseif color == "255+255+255" then
        textcolor = "White"
    else
        textcolor = color
    end

    _PrintMessage(userid, HUD_PRINTTALK,
                  "[Fading Doors] Color was set to " .. textcolor)
    _PrintMessage(userid, HUD_PRINTCONSOLE,
                  "[Fading Doors] Color was set to " .. textcolor)
    DoorSettings[userid].Color = color;
    reloadSpawnMenu(userid)
end

function settingsTime(userid, time)
    _PrintMessage(userid, HUD_PRINTTALK,
                  "[Fading Doors] Time was set to " .. time .. " seconds")
    _PrintMessage(userid, HUD_PRINTCONSOLE,
                  "[Fading Doors] Time was set to " .. time .. " seconds")
    DoorSettings[userid].Time = time;
    reloadSpawnMenu(userid)
end

function keypadOnly(userid, string)
    if string == "1" or string == "true" then
        DoorSettings[userid].PadOnly = true
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Enabled Pad Only")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Enabled Pad Only")
    else
        DoorSettings[userid].PadOnly = false
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Disabled Pad Only")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Disabled Pad Only")
    end
    reloadSpawnMenu(userid)
end

function applyNewSettings(userid)
    PlayerLookTrace(userid, 150);

    if protect_props and not prop_protection(userid, _TraceGetEnt()) then
        return
    elseif FadingDoors[_TraceGetEnt()] ~= nil and
        FadingDoors[_TraceGetEnt()].Owner == userid then
        ApplyDoorSettings(userid, _TraceGetEnt())
        _PrintMessage(userid, HUD_PRINTTALK,
                      "[Fading Doors] Settings were applied")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Settings were applied")
    else
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Trace hit nothing")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

function keypadTargetDoor(userid)
    PlayerLookTrace(userid, 150);
    if FadingDoors[_TraceGetEnt()] ~= nil and FadingDoors[_TraceGetEnt()].Owner ==
        userid then
        DoorSettings[userid].KeyTarget = _TraceGetEnt()
        _PrintMessage(userid, HUD_PRINTTALK,
                      "[Fading Doors] Keypad target was set")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Keypad target was set")
    else
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Trace hit nothing")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

function targetApplyAccess(userid)
    PlayerLookTrace(userid, 150);
    if FadingDoors[_TraceGetEnt()] ~= nil and FadingDoors[_TraceGetEnt()].Owner ==
        userid then
        applyAccess(userid, _TraceGetEnt())
        _PrintMessage(userid, HUD_PRINTTALK,
                      "[Fading Doors] Applying new Access settings")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Applying new Access settings")
    else
        _PrintMessage(userid, HUD_PRINTTALK, "[Fading Doors] Trace hit nothing")
        _PrintMessage(userid, HUD_PRINTCONSOLE,
                      "[Fading Doors] Trace hit nothing")
    end
end

CONCOMMAND("fdoor_instant", instantFadingDoor)
CONCOMMAND("fdoor_targetdoor", targetDoor)
CONCOMMAND("fdoor_targetkeypad", targetKeypad)
CONCOMMAND("fdoor_setcolor", settingsColor)
CONCOMMAND("fdoor_settime", settingsTime)
CONCOMMAND("fdoor_giveaccess", giveAccess)
CONCOMMAND("fdoor_revokeaccess", revokeAccess)
CONCOMMAND("fdoor_reloadspawnmenu", reloadSpawnMenu)
CONCOMMAND("fdoor_traceunmaketarget", traceunmakeTarget)
CONCOMMAND("fdoor_padonly", keypadOnly)
CONCOMMAND("fdoor_apply", applyNewSettings)
CONCOMMAND("fdoor_padnewtarget", keypadTargetDoor)
CONCOMMAND("fdoor_applyaccess", targetApplyAccess)

function FadingDoorSpawnMenu(userid)
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Instant Fading Door", "")
    _spawnmenu.AddItem(userid, "- Fading Doors",
                       "@Attaches keypad and turns prop", "")
    _spawnmenu.AddItem(userid, "- Fading Doors",
                       "@you look at into a Fading Door", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Instant Keypad",
                       "fdoor_instant")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Mirror Keypad",
                       "fdoor_instant 1")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Can use on existing door", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Manage who can use your", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@next door or apply to old", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Reload Players",
                       "fdoor_reloadspawnmenu " .. userid)
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Apply access to",
                       "fdoor_applyaccess " .. userid)
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Click to revoke access", "")
    for i = 1, _MaxPlayers() do
        if _PlayerInfo(i, "connected") then
            if DoorSettings[userid].Access[i] == true then
                _spawnmenu.AddItem(userid, "- Fading Doors",
                                   "+" .. (_PlayerInfo(i, "name")),
                                   "fdoor_revokeaccess " .. i)
            end
        end
    end

    _spawnmenu.AddItem(userid, "- Fading Doors", "@Click to give access", "")
    for i = 1, _MaxPlayers() do
        if _PlayerInfo(i, "connected") then
            if DoorSettings[userid].Access[i] ~= true then
                _spawnmenu.AddItem(userid, "Fading Doors",
                                   "+" .. (_PlayerInfo(i, "name")),
                                   "fdoor_giveaccess " .. i)
            end
        end
    end
    _spawnmenu.AddItem(userid, "- Fading Doors", "@     ", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Manual Fading Doors", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Make object infront into", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Door", "fdoor_targetdoor")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Keypad", "fdoor_targetkeypad")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Manual keypad target or", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@it target last edited door", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Set Keypad target",
                       "fdoor_padnewtarget")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@ ", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Settings", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Applies to next created door",
                       "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@or apply to door you look at",
                       "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Apply to existing",
                       "fdoor_apply")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Color when door is open", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Red",
                       "fdoor_setcolor 255+100+100")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Green",
                       "fdoor_setcolor 100+255+100")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Blue",
                       "fdoor_setcolor 100+100+255")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Purple",
                       "fdoor_setcolor 255+100+255")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Yellow",
                       "fdoor_setcolor 255+255+100")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+white",
                       "fdoor_setcolor 255+255+255")
    local colorcommand = ("@fdoor_setcolor " .. DoorSettings[userid].Color ..
                             " ")
    _spawnmenu.AddItem(userid, "- Fading Doors", colorcommand, "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Seconds to stay open", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+1", "fdoor_settime 1")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+3", "fdoor_settime 3")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+5", "fdoor_settime 5")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+7", "fdoor_settime 7")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+10", "fdoor_settime 10")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+12", "fdoor_settime 12")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+15", "fdoor_settime 15")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+30", "fdoor_settime 30")
    local timecommand = ("@fdoor_settime " .. DoorSettings[userid].Time .. " ")
    _spawnmenu.AddItem(userid, "- Fading Doors", timecommand, "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@    ", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Unmake Door or Keypad", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@also unmakes attached Keypads",
                       "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Unmake Target",
                       "fdoor_traceunmaketarget")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@      ", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@KeypadOnly, disabling will", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@allow Use on door to open it",
                       "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Disable", "fdoor_padonly 0")
    _spawnmenu.AddItem(userid, "- Fading Doors", "+Enable", "fdoor_padonly 1")
    if DoorSettings[userid].PadOnly == true then
        _spawnmenu.AddItem(userid, "- Fading Doors", "@fdoor_padonly 1", "")
    else
        _spawnmenu.AddItem(userid, "- Fading Doors", "@fdoor_padonly 0", "")
    end
    _spawnmenu.AddItem(userid, "- Fading Doors", "@       ", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@Fading Doors 1.8", "")
    _spawnmenu.AddItem(userid, "- Fading Doors", "@by Brainles5", "")
end
