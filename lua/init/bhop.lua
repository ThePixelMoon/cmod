BHOP_DEFAULT = 1.5
local tick = 0.3 -- 0.4 is hard on the border
local nextjump = {}
local lastjump = {}
local bhop_enabled = {}

BHOP_MAXVEL = 3000

for i = 1, _MaxPlayers() do
    lastjump[i] = 0
    nextjump[i] = 0
    bhop_enabled[i] = false -- too overpowered
end

local function jumpmult(userid, key)
    if not bhop_enabled[userid] then return end

    if key == IN_JUMP and _EntGetMoveType(userid) == MOVETYPE_WALK and
        _EntGetParent(userid) == 0 -- and _EntGetGroundEntity(userid) ~= -1
    and nextjump[userid] < _CurTime() then

        nextjump[userid] = _CurTime() + tick

        if vecLength(_EntGetVelocity(userid)) < BHOP_MAXVEL then
            _EntSetVelocity(userid,
                            vecMul(_EntGetVelocity(userid), BHOP_DEFAULT))
            _EntSetGroundEntity(userid, -1)

            _EffectInit()
            -- _EffectSetEnt(userid)
            _EffectSetOrigin(_EntGetPos(userid))
            _EffectSetStart(_EntGetPos(userid))
            _EffectSetScale(50)
            _EffectSetMagnitude(20000)
            _EffectDispatch("ThumperDust")
        end
    end
end

if hook_jumpmult then UnHookEvent(hook_jumpmult) end
hook_jumpmult = HookEvent("eventKeyPressed", jumpmult)

if timer_bhop_holdspace then HaltTimer(timer_bhop_holdspace) end
timer_bhop_holdspace = AddTimer(0, 0, function()
    for i = 1, _MaxPlayers() do

        if bhop_enabled[i] and _PlayerInfo(i, "connected") and
            _PlayerInfo(i, "alive") and _EntGetMoveType(i) == MOVETYPE_WALK and
            _EntGetParent(i) == 0 and _PlayerIsKeyDown(i, IN_JUMP) and
            nextjump[i] < _CurTime() then
            _TraceLine(_EntGetPos(i), vector3(0, 0, -1), 16, i)
            local vel = _EntGetVelocity(i)
            if _TraceHit() and vel.z >= 0 then

                vel = vecMul(vel, BHOP_DEFAULT)

                if vecLength(vel) > BHOP_MAXVEL then
                    vel = vecMul(vel, BHOP_MAXVEL / vecLength(vel))
                end

                vel.z = 200
                _EntSetVelocity(i, vel)
                _EntSetGroundEntity(i, -1)
                nextjump[i] = _CurTime() + tick

                _EffectInit()
                _EffectSetOrigin(_EntGetPos(i))
                _EffectSetStart(_TraceEndPos())
                _EffectSetScale(4)
                _EffectSetMagnitude(4)
                _EffectDispatch("cball_explode")
            end
        end
    end
end)

if _GetConVar_String("sv_airaccelerate") ~= "1000000" then
    _ServerCommand("sv_airaccelerate 1000000\n")
end

local function cc_guestbhop(userid)
    if bhop_enabled[userid] then
        bhop_enabled[userid] = false
        _PrintMessage(userid, HUD_PRINTTALK, "Your auto-bunnyhop is now turned OFF")

    else
        bhop_enabled[userid] = true
        _PrintMessage(userid, HUD_PRINTTALK, "Your auto-bunnyhop is now turned ON")
    end
end
CONCOMMAND("bhop", cc_guestbhop)

local function bhop_authed(name, userid, steamid) bhop_enabled[userid] = true end
HookEvent("eventPlayerActive", bhop_authed)

