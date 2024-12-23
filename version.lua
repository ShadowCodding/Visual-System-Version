local ressource = GetInvokingResource() or GetCurrentResourceName()
local versionActuelle = GetResourceMetadata(ressource, 'version', 0)
local serverlatest

if versionActuelle then
    versionActuelle = versionActuelle:match('%d+%.%d+%.%d+')
end

if not versionActuelle then
    return print(("^1Impossible de récupérer la version pour '%s' ^0"):format(ressource))
end

PerformHttpRequest("https://raw.githubusercontent.com/ShadowCodding/Visual-System/version.txt", function(code, currentVersion)
    if code == 200 then
        serverlatest = currentVersion:gsub("%s+","")
    else 
        serverlatest = versionActuelle
        print("^1[Visual-System] - Échec de récupération de la dernière version. Code HTTP : "..code)
    end 
end)

while not serverlatest do Wait(100) end

if serverlatest ~= versionActuelle then
    print("^1[Visual-System] - Vous utilisez une version obsolète ("..versionActuelle.."), téléchargez la dernière version : "..serverlatest.."^7")
else
    print("^2[Visual-System] - Vous utilisez la dernière version ("..versionActuelle..")^7")
end 
