if csfx then
    UnHookEvent(csfx.hook)
end

csfx = {
    config = {
        -- Activator = Filename or table with possible options
        yeah = "vo/npc/male01/yeah02.wav",
        nice = {
            "vo/npc/female01/nice01.wav",
            "vo/npc/female01/nice02.wav",
            "vo/npc/male01/nice.wav"
        },
        -- Here's how to create variables with spaces in them
        ["oh no"] = {
            "vo/npc/alyx/ohno_startle01.wav",
            "vo/npc/alyx/ohno_startle03.wav",
            "vo/npc/male01/ohno.wav",
            "vo/npc/female01/ohno.wav",
        }
    }
}

csfx.hook = HookEvent("eventPlayerSay", function(playerid, message, _)
    message = string.lower(tostring(message))
    for activator, filename in pairs(csfx.config) do
        if string.find(message, activator) ~= nil then
            -- If a sound file is used for NPC dialog then the player model will it's mouth
            if type(filename) == "table" then
                math.randomseed(_CurTime())
                local filename_length = 0
                for _ in filename do
                    filename_length = filename_length + 1
                end
                filename = filename[math.random(1, filename_length)]
            end
            _EntEmitSound(playerid, filename)
            -- We don't want to be able to play 10 diferent sounds at once, so we return
            return
        end
    end
end)
