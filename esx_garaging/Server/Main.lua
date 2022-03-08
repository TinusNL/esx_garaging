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

local PlayerGarages = {}

function GetTypeInfo(GottenTypeName)
	local TypeInfo = {}

	for Index, GarageType in pairs(Config.GarageTypes) do
		if GarageType.TypeName == GottenTypeName then
			TypeInfo = GarageType
		end
	end

	return TypeInfo
end

function GetPlayerSteamId(xSource)
    local PlayerIdentifier = ""

    for Index, CurrentIdentifier in pairs(GetPlayerIdentifiers(xSource)) do
        if string.sub(CurrentIdentifier, 1, string.len(Config.PlayerIdentifiers.Tag)) == Config.PlayerIdentifiers.Tag then
            PlayerIdentifier = Config.PlayerIdentifiers.Format(CurrentIdentifier)
        end
    end

    return PlayerIdentifier
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

RegisterServerEvent('esx_garaging:SetProps')
AddEventHandler('esx_garaging:SetProps', function(VehicleProps)
    local xSource = source
    local PlayerSteamId = GetPlayerSteamId(xSource)
    local VehiclePropsEncoded = json.encode(VehicleProps)

    MySQL.Sync.fetchAll('UPDATE owned_vehicles SET vehicle = @VehiclePropsEncoded WHERE plate = "'..VehicleProps.plate..'"', {
        ["@VehiclePropsEncoded"] = VehiclePropsEncoded
    })
end)

ESX.RegisterServerCallback('esx_garaging:GetVehicles', function(source, Callback)
    local xSource = source
    local PlayerSteamId = GetPlayerSteamId(xSource)

    local SQLReturn = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = "'..PlayerSteamId..'"')

    local NewSQL = {}

    for Index, CurrentVehicle in pairs(SQLReturn) do
        if CurrentVehicle.type == "car" then 
            NewSQL[#NewSQL + 1] = CurrentVehicle
        end
    end

    Callback(NewSQL)
end)

ESX.RegisterServerCallback('esx_garaging:GetGarages', function(source, Callback)
    local xSource = source
    local PlayerSteamId = GetPlayerSteamId(xSource)

    local SQLReturn = MySQL.Sync.fetchAll('SELECT * FROM owned_garages WHERE owner = "'..PlayerSteamId..'"')

    Callback(SQLReturn)
end)

ESX.RegisterServerCallback('esx_garaging:BuyGarage', function(source, Callback, GarageID)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)

    local PlayerIdentifier = GetPlayerSteamId(xSource)
    local CurrentGarage = Config.Garages[GarageID]
    local GarageTypeInfo = GetTypeInfo(CurrentGarage.GarageType)

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

ESX.RegisterServerCallback('esx_garaging:SellGarage', function(source, Callback, GarageID)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)

    local PlayerIdentifier = GetPlayerSteamId(xSource)
    local CurrentGarage = Config.Garages[GarageID]
    local GarageTypeInfo = GetTypeInfo(CurrentGarage.GarageType)
    local MoneyToPay = math.floor((GarageTypeInfo.TypePrice / 100) * Config.SellPercentage)

    xPlayer.addAccountMoney('bank', MoneyToPay)
    MySQL.Sync.fetchAll('DELETE FROM owned_garages WHERE owner = "'..PlayerIdentifier..'" AND id = '..GarageID..'')

    Callback()
end)

RegisterServerEvent('esx_garaging:UpdateGarage')
AddEventHandler('esx_garaging:UpdateGarage', function(GarageInfo)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    
    PlayerGarages[GetPlayerName(xPlayer.source)] = GarageInfo
end)

AddEventHandler('playerDropped', function(DropReason)
    local xSource = source
    local xPlayer = ESX.GetPlayerFromId(xSource)
    local xPlayerName = GetPlayerName(xPlayer.source)
    local xPlayerSteam = GetPlayerSteamId(xSource)

    if PlayerGarages[xPlayerName] then
        local OutsidePosition = {
            x = math.ceil(PlayerGarages[GetPlayerName(xPlayer.source)].GarageInfo.DoorPos.x),
            y = math.ceil(PlayerGarages[GetPlayerName(xPlayer.source)].GarageInfo.DoorPos.y),
            z = math.ceil(PlayerGarages[GetPlayerName(xPlayer.source)].GarageInfo.DoorPos.z),
        }

        OutsidePosition = json.encode(OutsidePosition)
        PlayerGarages[xPlayerName] = nil

        Citizen.Wait(5000)
        
        MySQL.Sync.fetchAll('UPDATE users SET position = @OutsidePosition WHERE identifier = "'..xPlayerSteam..'"', {
            ["@OutsidePosition"] = OutsidePosition
        })
    end
end)