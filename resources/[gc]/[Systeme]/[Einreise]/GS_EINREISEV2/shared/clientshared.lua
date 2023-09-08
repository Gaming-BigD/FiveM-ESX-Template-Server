RegisterNUICallback("Call", function(data)
    local cooldown = 0
    if cooldown == 0 then
      closeUI()
  
      if Config.NotifySystem == GS then
        TriggerEvent('gs_notification:notify', Config.CallNaricht, 6000)
      else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.CallNaricht)
        DrawNotification(1)	
      end
  
      TriggerServerEvent("gs:CallNotify") 
      cooldown = cooldown + 1
    elseif cooldown == 1 then
      closeUI()
  
      if Config.NotifySystem == GS then
        TriggerEvent('gs_notification:notify', Config.CooldownNaricht, 6000) 
      else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.CooldownNaricht)
        DrawNotification(1)	
      end
      
      Citizen.Wait(180000)
      cooldown = cooldown - 1
  
    end
  end)