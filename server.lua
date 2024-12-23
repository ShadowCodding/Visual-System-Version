ESX = exports["es_extended"]:getSharedObject()

-- Notification Avancée (avec bannière et icône)
function SendAdvancedNotification(source, data)
    TriggerClientEvent('notif:showAdvancedNotification', source, data)
end

-- Notification Simple
function SendBasicNotification(source, data)
    TriggerClientEvent('notif:showBasicNotification', source, data)
end

-- Notification d'aide
function SendHelpNotification(source, data)
    TriggerClientEvent('notif:showHelpNotification', source, data)
end

-- Exports côté serveur
exports('SendAdvancedNotification', SendAdvancedNotification)
exports('SendBasicNotification', SendBasicNotification)
exports('SendHelpNotification', SendHelpNotification)
