--Use the _Buffer.Add(function, arg1, arg2, etc) function to add a function and arguments to the buffer. The buffer will be processed every think frame.
--Use the _Buffer.After(function, arg1, arg2, etc) will be processed after the main buffer is empty.

-- Don't touch this
GlobalBuffer = GlobalBuffer or {}
RunAfterBuffer = RunAfterBuffer or {}

_Buffer = {}

--Add function and arguments to the buffer(1 entry each lua think)
function _Buffer.Add(func, ...)
    table.insert(GlobalBuffer, {func = func, args = arg})
end

-- Run function and arguments after the buffer is empty. Only have one instance of this function in the buffer at a time.
--(this works the same way as buffer, but is meant to be used for functions that need to be run after the buffer is empty)
function _Buffer.After(func, ...)
    table.insert(RunAfterBuffer, {func = func, args = arg})
end


AddThinkFunction(function()
    if GlobalBuffer[1] ~= nil then
        GlobalBuffer[1].func(unpack(GlobalBuffer[1].args))
        table.remove(GlobalBuffer, 1)
    elseif RunAfterBuffer[1] ~= nil then
        RunAfterBuffer[1].func(unpack(RunAfterBuffer[1].args))
        table.remove(RunAfterBuffer, 1)
    end
end)

