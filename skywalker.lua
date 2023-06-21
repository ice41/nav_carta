----------------------------------------------------------------------------------------------------------
--[   Esse script foi desenvolvido por <Ice41>, por favor mantenha os créditos               ]--
--[                     NPED.PT - ice41 Discord: discord.gg/eQgRv2BfxT                       ]--
----------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

mtt = {}
Tunnel.bindInterface("nav_carta",mtt)
--[ CAPTURA mySQL ]------------------------------------------------------------------------------------------------------------------------------

vRP._prepare("vRP/update_driverlicense","UPDATE vrp_user_identities SET driverlicense = @driverlicense WHERE user_id = @user_id")

vRP._prepare("vRP/update_cmota","UPDATE vrp_user_identities SET cmota = @cmota WHERE user_id = @user_id")
vRP._prepare("vRP/update_ccarro","UPDATE vrp_user_identities SET ccarro = @ccarro WHERE user_id = @user_id")
vRP._prepare("vRP/update_ccamiao","UPDATE vrp_user_identities SET ccamiao = @ccamiao WHERE user_id = @user_id")
vRP._prepare("vRP/update_creboque","UPDATE vrp_user_identities SET creboque = @creboque WHERE user_id = @user_id")

vRP._prepare("vRP/get_driverlicense","SELECT user_id FROM vrp_user_identities WHERE driverlicense = @driverlicense")

vRP._prepare("vRP/get_cmota","SELECT user_id FROM vrp_user_identities WHERE cmota = @cmota")
vRP._prepare("vRP/get_ccarro","SELECT user_id FROM vrp_user_identities WHERE ccarro = @ccarro")
vRP._prepare("vRP/get_ccamiao","SELECT user_id FROM vrp_user_identities WHERE ccamiao = @ccamiao")
vRP._prepare("vRP/get_creboque","SELECT user_id FROM vrp_user_identities WHERE creboque = @creboque")

--[CHECA SE PODE FAZER O PAGAMENTO]-----------------------------------------------------------------------------------------------------
--[SE TIVER VIP O PREÇO TEM DESCONTO DE 20 / 15 /10 /5 % ]------------------------------------------------------------------------------

function mtt.pagamento()
    local source = source
    local user_id = vRP.getUserId(source)
    local preco = 600

    if preco then
        if vRP.hasPermission(user_id,"platina.permissao") then
            desconto = math.floor(preco*20/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"ouro.permissao") then
            desconto = math.floor(preco*15/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"prata.permissao") then
            desconto = math.floor(preco*10/100)
            pagamento = math.floor(preco-desconto)
        elseif vRP.hasPermission(user_id,"bronze.permissao") then
            desconto = math.floor(preco*5/100)
            pagamento = math.floor(preco-desconto)
        else
            pagamento = math.floor(preco)
        end

        if vRP.getInventoryItemAmount(user_id,"cartaodebito") >= 1 then
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Dinheiro )</b>")
                return true
            else
                if vRP.tryDebitPayment(user_id,parseInt(pagamento)) then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Débito )</b>")
                    return true
                else
                    TriggerClientEvent("Notify",source,"negado","Dinheiro ou saldo bancario insuficientes.")
                    return false
                end
            end
        else
            if vRP.tryPayment(user_id,parseInt(pagamento)) then
                if preco > 0 then
                    TriggerClientEvent("Notify",source,"sucesso","Pagou <b>€"..vRP.format(parseInt(pagamento)).." Euros</b>. <b>( Dinheiro )</b>")
                    return true
                end
            else
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.")
                return false
            end
        end
    end
end

--[[CHECA A LICENÇA DO JOGADOR]]---------------------------------------------------------------------------------------
function mtt.checkcarlicense()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)

    if identity.driverlicense == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem o codigo completo.")
		return false
	elseif identity.driverlicense == 0 or identity.driverlicense == 3 then
        return true
    end
end

function mtt.checkmota()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.cmota == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem esta Categoria.")
		return false
    elseif identity.cmota == 0 or identity.cmota == 3 then
        return true
    end
end

function mtt.checkcarro()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if	identity.ccarro == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem esta Categoria.")
		return false
    elseif identity.ccarro == 0 or identity.ccarro == 3 then
        return true
    end
end

function mtt.checkcamiao()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.ccamiao == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem esta Categoria.")
		return false
    elseif identity.ccamiao == 0 or identity.ccamiao == 3 then
        return true
    end
end

function mtt.checkreboque()
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	
	if identity.creboque == 1 then
		TriggerClientEvent("Notify",source,"negado","Já tem esta Categoria.")
		return false
    elseif identity.creboque == 0 or identity.creboque == 3 then
        return true
    end
end

--[[FUNÇÃO QUE ADICIONA A CARTA AO PLAYER]]-----------------------------------------------------------------------------

function mtt.steorico()
	local user_id = vRP.getUserId(source)
		TriggerEvent("carta",1,user_id)		
end

function mtt.smota()
	local user_id = vRP.getUserId(source)
		TriggerEvent("rmota",1,user_id)		
end
function mtt.scarro()
	local user_id = vRP.getUserId(source)
		TriggerEvent("rcarro",1,user_id)			
end

function mtt.scamiao()
	local user_id = vRP.getUserId(source)
	TriggerEvent("rcamiao",1,user_id)			
end
function mtt.sreboque()
	local user_id = vRP.getUserId(source)
    TriggerEvent("rreboque",1,user_id)		
end
--[[COMANDO PARA POLICIA REMOVER CARTA]]-----------------------------------------------------------------------------
--[[ QUANDO O VALOR DA CARTA É 3 A CARTA ESTÁ APREENDIDA ]]-----------------------------------------------------------------------------
--[[ /TIRARCARTA MOTA | /TIRARCARTA CARRO | /TIRARCARTA CAMIAO | /TIRARCARTA REBOQUE ]]-----------------------------------------------------------------------------
RegisterCommand("tirarcarta",function(source,args)
	local source = source
	local identity = vRP.getUserIdentity(user_id)
	local nplayer = vRPclient.getNearestPlayer(source,2)
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local nuser_id = vRP.getUserId(nplayer)
	local identitynu = vRP.getUserIdentity(nuser_id)
	local cmota = vRP.identity.cmota (source,user_id,cmota)
	local ccarro = vRP.identity.ccarro (source,user_id,ccarro)
	local ccamiao = vRP.identity.ccamiao (source,user_id,ccamiao)
	local creboque = vRP.identity.creboque (source,user_id,creboque)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then	
		if nplayer then
			if args[1] == "mota" or "moto" then
				if cmota == 1 then
					TriggerEvent("rmota",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				
				elseif cmota == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
				
			elseif args[1] == "carro" then
				if ccarro == 1 then
					TriggerEvent("rcarro",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				elseif ccarro == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
				
			elseif args[1] == "camiao" or "caminhao" then
				if ccamiao == 1 then
					TriggerEvent("rcamiao",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				elseif ccamiao == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
				
			elseif args[1] == "reboque" or "traler" then
				if creboque == 1 then
					TriggerEvent("rreboque",3,nuser_id)
					TriggerClientEvent("Notify",source,"sucesso","Apreendeu a carta de condução de <b>"..identitynu.name.." "..identitynu.firstname.."</b>.",5000)
					TriggerClientEvent("Notify",nplayer,"negado","O oficial <b>"..identity.name.." "..identity.firstname.."</b> apreendeu a sua carta de condução.",5000)
				elseif creboque == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta já apreendida",5000) 
				end
			end
		end
	end
end)

--[[CHECA SE O PLAYER TEM CARTA]]-----------------------------------------------------------------------------
----[[ /CARTA /CARTA MOTA | /CARTA CARRO | /CARTA CAMIAO | /CARTA REBOQUE ]--

RegisterCommand("carta",function(source,args)
	local source = source
	local identity = vRP.getUserIdentity(user_id)
	local cmota = vRP.identity.cmota (source,user_id,cmota)
	local ccarro = vRP.identity.ccarro (source,user_id,ccarro)
	local ccamiao = vRP.identity.ccamiao (source,user_id,ccamiao)
	local creboque = vRP.identity.creboque (source,user_id,creboque)
	if vRP.hasPermission(user_id,"policia.permissao") or vRP.hasPermission(user_id,"mindmaster.permissao") then	
		if nplayer then
			if args[1] == "mota" then
				if cmota == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Mota",5000) 
				elseif cmota == 3 then
					TriggerClientEvent("Notify",source,"negado","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Mota",5000) 
				end
			elseif args[1] == "carro" then
				if ccarro == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Carro",5000) 
				elseif ccarro == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Carro",5000) 
				end
			elseif args[1] == "camiao" then
				if ccamiao == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Camiao",5000) 
				elseif ccamiao == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Camiao",5000) 
				end
			elseif args[1] == "reboque" then
				if creboque == 1 then
					TriggerClientEvent("Notify",source,"importante","Utilizador com carta de Reboque",5000) 
				elseif creboque == 3 then
					TriggerClientEvent("Notify",source,"importante","Carta apreendida",5000) 
				else
					TriggerClientEvent("Notify",source,"importante","Sem carta de Reboque",5000) 
				end
			else
				TriggerEvent("Notify","negado","Sem carta de condução")
			end
		end
	end
end)

RegisterServerEvent("carta")
AddEventHandler("carta",function(driverlicense,user_id)
    vRP.execute("vRP/update_driverlicense", {driverlicense = driverlicense, user_id = user_id})
end)

RegisterServerEvent("rmota")
AddEventHandler("rmota",function(cmota,user_id)
    vRP.execute("vRP/update_cmota", {cmota = cmota, user_id = user_id})
end)

RegisterServerEvent("rcarro")
AddEventHandler("rcarro",function(ccarro,user_id)
    vRP.execute("vRP/update_ccarro", {ccarro = ccarro, user_id = user_id})
end)

RegisterServerEvent("rcamiao")
AddEventHandler("rcamiao",function(ccamiao,user_id)
    vRP.execute("vRP/update_ccamiao", {ccamiao = ccamiao, user_id = user_id})
end)
RegisterServerEvent("rreboque")
AddEventHandler("rreboque",function(creboque,user_id)
    vRP.execute("vRP/update_creboque", {creboque = creboque, user_id = user_id})
end)
