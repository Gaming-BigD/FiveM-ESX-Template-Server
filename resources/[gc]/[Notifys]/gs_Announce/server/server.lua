RegisterCommand("announce", function(source, args)
    local argString = table.concat(args, " ")
    if argString ~= nil then
        TriggerClientEvent('gs_coreonAnnounce:Announce', -1, argString, 5000)
    end
end, true)