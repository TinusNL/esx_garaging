--[[
  _____   _                                 _   _   _
 |_   _| (_)  _ __    _   _   ___          | \ | | | |
   | |   | | | '_ \  | | | | / __|         |  \| | | |    
   | |   | | | | | | | |_| | \__ \         | |\  | | |___ 
   |_|   |_| |_| |_|  \__,_| |___/  _____  |_| \_| |_____|
                                   |_____|
]]--

-- ESX
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Code

function GetTypeInfo(GottenTypeName)
	local TypeInfo = {}

	for Index, GarageType in pairs(Config.GarageTypes) do
		if GarageType.TypeName == GottenTypeName then
			TypeInfo = GarageType
		end
	end

	return TypeInfo
end

RegisterServerEvent('esx_garaging:SetStored')
AddEventHandler('esx_garaging:SetStored', function(VehiclePlate, Status)
    if Status == true then
        MySQL.Sync.fetchAll('UPDATE owned_vehicles SET stored = 1 WHERE plate = "'..VehiclePlate..'"')
    else
        MySQL.Sync.fetchAll('UPDATE owned_vehicles SET stored = 0 WHERE plate = "'..VehiclePlate..'"')
    end
end)

RegisterServerEvent('esx_garaging:SetGarage')
AddEventHandler('esx_garaging:SetGarage', function(VehiclePlate, GarageId)
    MySQL.Sync.fetchAll('UPDATE owned_vehicles SET garage = '..GarageId..' WHERE plate = "'..VehiclePlate..'"')
end)

ESX.RegisterServerCallback('esx_garaging:GetVehicles', function(source, Callback)
    local xSource = source
    local PlayerSteamId = ""

    for Index, CurrentIdentifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(CurrentIdentifier, 1, string.len("steam:")) == "steam:" then
            PlayerSteamId = CurrentIdentifier
        end
    end

    local SQLReturn = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = "'..PlayerSteamId..'"')

    Callback(SQLReturn)
end)

ESX.RegisterServerCallback('esx_garaging:GetGarages', function(source, Callback)
    local xSource = source
    local PlayerSteamId = ""

    for Index, CurrentIdentifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(CurrentIdentifier, 1, string.len("steam:")) == "steam:" then
            PlayerSteamId = CurrentIdentifier
        end
    end

    local SQLReturn = MySQL.Sync.fetchAll('SELECT * FROM owned_garages WHERE owner = "'..PlayerSteamId..'"')

    Callback(SQLReturn)
end)

ESX.RegisterServerCallback('esx_garaging:BuyGarage', function(source, Callback, GarageID)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)

    local PlayerIdentifier = ""
    local CurrentGarage = Config.Garages[GarageID]
    local GarageTypeInfo = GetTypeInfo(CurrentGarage.GarageType)

    for Index, CurrentIdentifier in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(CurrentIdentifier, 1, string.len("steam:")) == "steam:" then
            PlayerIdentifier = CurrentIdentifier
        end
    end

    if Config.MoneyType == true then
        if xPlayer.getAccount('bank').money >= GarageTypeInfo.TypePrice then
            xPlayer.removeAccountMoney('bank', GarageTypeInfo.TypePrice)
            MySQL.Sync.fetchAll('INSERT INTO owned_garages VALUES('..GarageID..', "'..PlayerIdentifier..'")')
            Callback(true)
        else
            Callback(false)
        end
    else
        if xPlayer.getMoney() >= GarageTypeInfo.TypePrice then
            xPlayer.removeMoney(GarageTypeInfo.TypePrice)
            MySQL.Sync.fetchAll('INSERT INTO owned_garages VALUES('..GarageID..', "'..PlayerIdentifier..'")')
            Callback(true)
        else
            Callback(false)
        end
    end
end)

ESX.RegisterServerCallback('esx_garaging:ReturnVehicle', function(source, Callback)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)

    if Config.Laptop.MoneyType == true then
        if xPlayer.getAccount('bank').money >= Config.Laptop.MoneyAmount then
            xPlayer.removeAccountMoney('bank', Config.Laptop.MoneyAmount)
            Callback(true)
        else
            Callback(false)
        end
    else
        if xPlayer.getMoney() >= Config.Laptop.MoneyAmount then
            xPlayer.removeMoney(Config.Laptop.MoneyAmount)
            Callback(true)
        else
            Callback(false)
        end
    end
end)