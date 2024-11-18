-- This will unhook previous hook if executing another time
if chat_commands then
    UnHookEvent(chat_commands.hook)
end

chat_commands = {
    prefix = "!",
    commands = {
        help = function(playerid, args)
            _PrintMessage(playerid, HUD_PRINTTALK, "Available Chat Commands")
            for command, _ in pairs(chat_commands.commands) do
                _PrintMessage(playerid, HUD_PRINTTALK, chat_commands.prefix .. command)
            end
        end,
        argtest = function(playerid, args)
            _PrintMessage(playerid, HUD_PRINTTALK, "Here are your arguments:")
            for index, arg in pairs(args) do
                _PrintMessage(playerid, HUD_PRINTTALK, "[" .. index .. "] " .. arg)
            end
        end,
        kill = function(playerid, args)
            _PlayerKill(playerid)
        end,
        yeet = function(playerid, args)
            _EntSetVelocity(playerid, vector3(0, 0, 999999999))
        end
    }
}

chat_commands.hook = HookEvent("eventPlayerSay", function(playerid, message, _)
    -- For some reason, `message` also contains player's name, so we remove it. Also, space **MUST** be always present, check `key`
    message = string.gsub(message, _PlayerInfo(playerid, "name") .. ": ", "") .. " "
    if string.sub(message, 1, 1) == chat_commands.prefix then
        local key = string.sub(message, 2, string.find(message, " ") - 1)
        if chat_commands.commands[key] then
            message = string.sub(message, string.find(message, " "), string.len(message))
            local args = {}
            for arg in string.gfind(message, "(%w+)") do
                table.insert(args, arg)
            end
            chat_commands.commands[key](playerid, args)
        end
    end
end)