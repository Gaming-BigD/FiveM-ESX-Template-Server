ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("einreiseamt", function(source) 

    for k, v in pairs(GetPlayers()) do
        local xPlayerAdmin = ESX.GetPlayerFromId(v)
        local targetGroup = xPlayerAdmin.getGroup()

        if targetGroup == "einreise" or targetGroup == "teamleitung" or targetGroup == "support" or targetGroup == "mod" or targetGroup == "projektmangager" or targetGroup == "frakleitung" or targetGroup == "supporter" or targetGroup == "admin" or targetGroup == "superadmin" or targetGroup == "owner" then
            TriggerClientEvent('gs_adminmenu:menuopen', source)
        end
    end

end)
