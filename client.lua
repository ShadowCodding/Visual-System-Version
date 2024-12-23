-- Au début du fichier
ESX = exports["es_extended"]:getSharedObject()

-- Notification Avancée (avec bannière et icône)
local function CreateAdvancedNotification(data)
    SendNUIMessage({
        type = "CREATE_ADVANCED_NOTIFICATION",
        data = {
            title = data.title or nil,
            subtitle = data.subtitle or nil,
            description = data.description or nil,
            duration = data.duration or 5000,
            icon = data.icon or nil,
            banner = data.banner or nil,
            backgroundColor = data.backgroundColor or nil,
            borderColor = data.borderColor or nil,
            progressColor = data.progressColor or nil,
            type = data.type or nil,
            typeColor = data.typeColor or nil
        }
    })
end

-- Notification Simple
local function CreateBasicNotification(data)
    SendNUIMessage({
        type = "CREATE_BASIC_NOTIFICATION",
        data = {
            title = data.title or nil,
            message = data.message or nil,
            duration = data.duration or 5000,
            type = data.type or nil,
            typeColor = data.typeColor or nil,
            progressColor = data.progressColor or nil
        }
    })
end

-- Notification d'aide (type ShowHelpNotification)
local function CreateHelpNotification(data)
    SendNUIMessage({
        type = "CREATE_HELP_NOTIFICATION",
        data = {
            message = data.message or "Appuyez sur ~INPUT_CONTEXT~ pour interagir",
            duration = data.duration or -1, -- -1 pour permanent jusqu'à RemoveHelpNotification
            key = data.key or "E"
        }
    })
end

local function RemoveHelpNotification()
    SendNUIMessage({
        type = "REMOVE_HELP_NOTIFICATION"
    })
end

-- Exports
exports('ShowAdvancedNotification', CreateAdvancedNotification)
exports('ShowBasicNotification', CreateBasicNotification)
exports('ShowHelpNotification', CreateHelpNotification)
exports('RemoveHelpNotification', RemoveHelpNotification)

-- Exemples d'utilisation:
RegisterCommand('testadvanced', function()
    CreateAdvancedNotification({
        title = "Validé",
        subtitle = "Accès validé",
        description = "Super cool",
        duration = 5000,
        icon = "images/icons/logo.png",
        banner = "images/banners/banner-police.png",
        backgroundColor = "rgba(26, 26, 26, 0.95)",
        progressColor = "#53cc2e",
        type = "Succès",
        typeColor = "#53cc2e"
    })
end)

RegisterCommand('testbasic', function()
    CreateBasicNotification({
        title = "Information",
        message = "Ceci est une notification simple",
        duration = 5000,
        type = "Info",
        typeColor = "#3498db",
        progressColor = "#3498db"
    })
end)

RegisterCommand('testhelp', function()
    CreateHelpNotification({
        message = "Appuyez sur E pour ouvrir le menu",
        key = "E"
    })
    -- Pour la démo, on retire la notification après 5 secondes
    Citizen.SetTimeout(5000, function()
        RemoveHelpNotification()
    end)
end)

-- Ajouter ces events après les fonctions existantes
RegisterNetEvent('notif:showAdvancedNotification')
AddEventHandler('notif:showAdvancedNotification', function(data)
    CreateAdvancedNotification(data)
end)

RegisterNetEvent('notif:showBasicNotification')
AddEventHandler('notif:showBasicNotification', function(data)
    CreateBasicNotification(data)
end)

RegisterNetEvent('notif:showHelpNotification')
AddEventHandler('notif:showHelpNotification', function(data)
    CreateHelpNotification(data)
end)
