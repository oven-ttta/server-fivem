local playersWaiting = {}
local loadedPlayers = {}

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    loadedPlayers[playerId] = true
end)

AddEventHandler('esx:playerDropped', function(playerId)
    loadedPlayers[playerId] = nil
    playersWaiting[playerId] = nil
end)

RegisterServerEvent('esx_identity:setIdentity')
AddEventHandler('esx_identity:setIdentity', function(data, myIdentifiers)
    local _source = source

    if not playersWaiting[_source] then
        print(('[^3WARNING^7] Player ^5%s^7 attempted to use esx_identity without being authorized'):format(GetPlayerName(_source)))
        return
    end

    if not data.firstname or not data.lastname or not data.dateofbirth or not data.sex or not data.height then
        print(('[^3WARNING^7] Player ^5%s^7 sent incomplete identity data'):format(GetPlayerName(_source)))
        TriggerClientEvent('esx_identity:identityCheck', _source, false, 'ข้อมูลไม่ครบถ้วน')
        return
    end

    local firstname = string.gsub(data.firstname, "[^%a]", "")
    local lastname = string.gsub(data.lastname, "[^%a]", "")
    local dateofbirth = data.dateofbirth
    local sex = data.sex
    local height = tonumber(data.height)

    if firstname == '' or lastname == '' then
        TriggerClientEvent('esx_identity:identityCheck', _source, false, 'ชื่อหรือนามสกุลไม่ถูกต้อง')
        return
    end

    if #firstname > Config.MaxNameLength or #lastname > Config.MaxNameLength then
        TriggerClientEvent('esx_identity:identityCheck', _source, false, 'ชื่อหรือนามสกุลยาวเกินไป')
        return
    end

    if not height or height < 140 or height > 220 then
        TriggerClientEvent('esx_identity:identityCheck', _source, false, 'ส่วนสูงไม่ถูกต้อง')
        return
    end

    local identifier = GetPlayerIdentifiers(_source)[1]

    MySQL.Async.execute('INSERT INTO users (identifier, firstname, lastname, dateofbirth, sex, height) VALUES (@identifier, @firstname, @lastname, @dateofbirth, @sex, @height)',
    {
        ['@identifier'] = identifier,
        ['@firstname'] = firstname,
        ['@lastname'] = lastname,
        ['@dateofbirth'] = dateofbirth,
        ['@sex'] = sex,
        ['@height'] = height
    }, function(rowsChanged)
        if rowsChanged then
            playersWaiting[_source] = nil
            TriggerClientEvent('esx_identity:identityCheck', _source, true)

            Wait(500)

            local xPlayer = ESX.GetPlayerFromId(_source)
            if xPlayer then
                xPlayer.setName(('%s %s'):format(firstname, lastname))
                xPlayer.set('dateofbirth', dateofbirth)
                xPlayer.set('sex', sex)
                xPlayer.set('height', height)
            end
        else
            TriggerClientEvent('esx_identity:identityCheck', _source, false, 'เกิดข้อผิดพลาดในการบันทึกข้อมูล')
        end
    end)
end)

ESX.RegisterServerCallback('esx_identity:checkIdentity', function(source, cb)
    local identifier = GetPlayerIdentifiers(source)[1]

    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            cb(true, result[1])
        else
            playersWaiting[source] = true
            cb(false)
        end
    end)
end)

ESX.RegisterServerCallback('esx_identity:searchIdentity', function(source, cb, firstname, lastname)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname = @firstname AND lastname = @lastname', {
        ['@firstname'] = firstname,
        ['@lastname'] = lastname
    }, function(result)
        if result[1] then
            cb(result)
        else
            cb(nil)
        end
    end)
end)

RegisterCommand('checkidentity', function(source, args, rawCommand)
    if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            print(('Name: %s %s | DOB: %s | Sex: %s | Height: %scm'):format(
                xPlayer.get('firstname'),
                xPlayer.get('lastname'),
                xPlayer.get('dateofbirth'),
                xPlayer.get('sex'),
                xPlayer.get('height')
            ))
        end
    end
end, false)
