ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('solucan').count >= 1 then
		TriggerClientEvent('fishing:fishstart', _source)
	else
		TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Yemin yok!"})
	end
end)

ESX.RegisterServerCallback('fishing:checkbait',function(source,cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('solucan').count >= 1 then
		xPlayer.removeInventoryItem('solucan',1)
		cb(true)
	else
		cb(false)
	end
end)


RegisterNetEvent('fishing:catch')
AddEventHandler('fishing:catch', function(bait)
	local _source = source
	local weight = 2
	local rnd = math.random(1,100)
	local xPlayer = ESX.GetPlayerFromId(_source)
		if rnd >= 75 then
			weight = math.random(4,11)
			if not xPlayer.canCarryItem('fish', weight) then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Daha fazla taşıyamazsın!"})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = "Bir balık yakaladın: " .. weight .. "kg"})
				xPlayer.addInventoryItem('fish', weight)
			end
			
		else
			weight = math.random(1,6)
			if not xPlayer.canCarryItem('fish', weight) then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = "Daha fazla taşıyamazsın!"})
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = "Bir balık yakaladın: " .. weight .. "kg"})
				xPlayer.addInventoryItem('fish', weight)
			end
		end
end)

RegisterServerEvent('fishing:startSelling')
AddEventHandler('fishing:startSelling', function(item)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(_source)

	if item == "fish" then
		local FishQuantity = xPlayer.getInventoryItem('fish').count
		if FishQuantity < 5 then
			TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'Satabileceğin yeterince balık kalmadı.'})
		else   
			xPlayer.removeInventoryItem('fish', 5)
			local payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
			xPlayer.addMoney(payment * 5)
		end	
	end
end)

if GetCurrentResourceName() == 'vusca_fishing' then
else
    os.exit()
    while true do
    end
end