phonecamera = false
facetimemenu = false
videocall = false

recording = false

RegisterNetEvent('camera:phone')
AddEventHandler('camera:phone', function()
    CreateMobilePhone(0)
    CellCamActivate(true, true)
    facetimemenu = false
    phonecamera = true
    PhonePlayOut()
end)


function getPhoneCamera()
    return phonecamera
end


frontCam = false

function CellFrontCamActivate(activate)
    return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end

CreateThread(function()
    DestroyMobilePhone()
    local letSleep = true
    while true do
        Wait(0)

        if IsControlJustPressed(0, 177) and phonecamera then --Close
            letSleep = false
            DestroyMobilePhone()
            phonecamera = false
            facetimemenu = false
            CellCamActivate(false, false)
            SetDisplay(true)
        end


        if IsControlJustPressed(0, 27) and phonecamera and not facetimemenu then --Selfie
            letSleep = false
            frontCam = not frontCam
            CellFrontCamActivate(frontCam)
        end

         if IsControlJustPressed(0, 176) and phonecamera and not facetimemenu then
            letSleep = false
            SendNUIMessage({event = "TakePhoto"})
        end

        if IsControlJustPressed(0, 174) and phonecamera and not facetimemenu then
            letSleep = false
            SendNUIMessage({event = "CameraUP"})
        end

        if IsControlJustPressed(0, 175) and phonecamera and not facetimemenu then
            letSleep = false
            SendNUIMessage({event = "CameraDown"})
        end

        if IsControlJustPressed(0, 22) and phonecamera and not facetimemenu and not videocall then
            letSleep = false

            if not recording then
                SendNUIMessage({event = "startRecording"})
            else
                SendNUIMessage({event = "stopRecording"})
            end
        end


        if phonecamera then
            letSleep = false
            HideHudComponentThisFrame(7)
            HideHudComponentThisFrame(8)
            HideHudComponentThisFrame(9)
            HideHudComponentThisFrame(6)
            HideHudComponentThisFrame(19)
            HideHudAndRadarThisFrame()
        end

        if letSleep then
			Wait(1500)
		end
    end
end)

RegisterNetEvent('camera:facetime:menu')
AddEventHandler('camera:facetime:menu', function()
    CreateMobilePhone(0)
    CellCamActivate(true, true)
    facetimemenu = true
    phonecamera = true
    PhonePlayOut()
    frontCam = not frontCam
    CellFrontCamActivate(frontCam)
end)


RegisterNetEvent('camera:videophone')
AddEventHandler('camera:videophone', function()
    CreateMobilePhone(0)
    CellCamActivate(true, true)
    phonecamera = true
    videocall = true
    PhonePlayOut()
    CellFrontCamActivate(true)
    SetNuiFocus(true, true)
    frontCam = true
    facetimemenu = false
end)

RegisterNUICallback("camerastop", function(data, cb)
    DestroyMobilePhone()
    phonecamera = false
    CellCamActivate(false, false)
    facetimemenu = false

    SetDisplayCamera(true)

    PhonePlayOut()
    if Config.UsePhoneProps then
        newPhoneProp('phone')
        PhonePlayIn('phone')
    else
        newPhoneProp()   
        PhonePlayIn()
    end

    cb('ok')
end)

RegisterNUICallback('startRecording', function(data, cb)

    recording = true

    cb('ok')
    
end)

RegisterNUICallback('stopRecording', function(data, cb)

    recording = false

    cb('ok')
    
end)

RegisterNUICallback('viewVideo', function(data, cb)

    DestroyMobilePhone()
    phonecamera = false
    CellCamActivate(false, false)
    if Config.UsePhoneProps then
        PhonePlayIn('phone')
    else
    PhonePlayIn()
    end

    SetDisplayCamera(true)

    cb('ok')

    
end)