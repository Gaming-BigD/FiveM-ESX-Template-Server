local phoneProp = 0
local phoneModel = 'prop_phone_ing_03'
local currentStatus = 'out'
local lastDict = nil
local lastAnim = nil
local lastIsFreeze = false
local lastProp = nil

local ANIMS = {
    ['cellphone@'] = {
        ['out'] = {
            ['text'] = 'cellphone_call_to_text',
            ['call'] = 'cellphone_call_listen_base'
        },
        ['text'] = {
            ['out'] = 'cellphone_text_out',
            ['text'] = 'cellphone_text_in',
            ['call'] = 'cellphone_text_to_call'
        },
        ['call'] = {
            ['out'] = 'cellphone_call_out',
            ['text'] = 'cellphone_call_to_text',
            ['call'] = 'cellphone_text_to_call'
        }
    },
    ['anim@cellphone@in_car@ps'] = {
        ['out'] = {
            ['text'] = 'cellphone_text_in',
            ['call'] = 'cellphone_call_in'
        },
        ['text'] = {
            ['out'] = 'cellphone_text_out',
            ['text'] = 'cellphone_text_in',
            ['call'] = 'cellphone_text_to_call'
        },
        ['call'] = {
            ['out'] = 'cellphone_horizontal_exit',
            ['text'] = 'cellphone_call_to_text',
            ['call'] = 'cellphone_text_to_call'
        }
    }
}

function newPhoneProp(prop)

    phoneModel = selectPhoneProp(prop)

    deletePhone()
    RequestModel(phoneModel)
    while not HasModelLoaded(phoneModel) do
		Citizen.Wait(100)
    end
    phoneProp = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)

    local bone = GetPedBoneIndex(PlayerPedId(), 28422)
    AttachEntityToEntity(phoneProp, PlayerPedId(), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)

end

function deletePhone()
    if phoneProp ~= 0 then

        --DeleteEntity(phoneProp)
        Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))

        phoneProp = 0
    end
end

--[[
	out || text || Call ||
--]]
function PhonePlayAnim(status, freeze, force, prop)
    if currentStatus == status and force ~= true then
        return
    end

    local myPedId = PlayerPedId()

    GiveWeaponToPed(myPedId, 0xA2719263, 0, 0, 1)

    local freeze = freeze or false

    local dict = "cellphone@"
    if IsPedInAnyVehicle(myPedId, false) then
        dict = "anim@cellphone@in_car@ps"
    end
    loadAnimDict(dict)

    local anim = ANIMS[dict][currentStatus][status]
    if currentStatus ~= 'out' then
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
    local flag = 50
    if freeze == true then
        flag = 14
    end
    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

    if status ~= 'out' and currentStatus == 'out' then
        Wait(380)
        newPhoneProp(prop)
    end

    lastDict = dict
    lastAnim = anim
    lastIsFreeze = freeze
    currentStatus = status

    if status == 'out' then
        Wait(180)
        deletePhone()
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    end
end

function PhonePlayOut()
    PhonePlayAnim('out')
end

function PhonePlayText(prop)
    PhonePlayAnim('text', false, false, prop)
end

function PhonePlayCall(freeze)
    PhonePlayAnim('call', freeze)
end

function PhonePlayIn(prop)
    if currentStatus == 'out' then
        PhonePlayText(prop)
    end
end

function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(1)
    end
end

function getAnimationStatus()
    return currentStatus
end

function selectPhoneProp(propname)
    local phoneModel = "prop_phone_ing_03"
    
    if Config.UsePhoneProps then
        local phoneModels = {
            ["phone"] = "phonesilver",
            ["purple_phone"] = "phonepurple",
            ["green_phone"] = "phonegreen",
            ["blue_phone"] = "phonelightblue",
            ["red_phone"] = "phonered",
            ['black_phone'] = "phoneblack"
        }
        
        phoneModel = phoneModels[propname] or phoneModels[lastProp] or phoneModel
    end
    
    --print(phoneModel)
    
    return phoneModel
end
