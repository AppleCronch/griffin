-----------------------------------
-- Add some npcs for testers in starter cities.
-----------------------------------
require("modules/module_utils")
require('scripts/zones/Bastok_Mines/Zone')
-----------------------------------
local m = Module:new("augment_npc")
m:setEnabled(true)

local jobTable =
{
    [1] = {'WAR'},
    [2] = {'MNK'},
    [3] = {'WHM'},
    [4] = {'BLM'},
    [5] = {'RDM'},
    [6] = {'THF'},
    [7] = {'PLD'},
    [8] = {'DRK'},
    [9] = {'BST'},
}


local onTriggerFunc = function(player, npc)
    npc:facePlayer(player)
    local jobId = player:getMainJob()
    local jobName = jobTable[jobId][1]
    local jobRebirthVar = string.format('%s_rebirth', jobName)
    local jobRebirth = player:getCharVar(jobRebirthVar)
    local tier1 = player:getCharVar('tier1_rebirth')
    player:printToPlayer('Ho ho ho, what do you need dear adventurer?', 0, npc:getPacketName())
    player:printToPlayer(string.format('Current job: %s', jobName), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('%s', jobRebirthVar), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('%s', jobRebirth), xi.msg.channel.SYSTEM_3)

    -- Forward declarations (required)
    local menu  = {}
    local menuConfirm  = {}
    local page1 = {}
    local page2 = {}
    local rebirthConfirm = {}

    -- We need just a tiny delay to let the previous menu context be cleared out
    -- 'New pages' are actually just whole new menus!
    local delaySendMenu = function(player)
        player:timer(50, function(playerArg)
            playerArg:customMenu(menu)
        end)
    end

    menu =
    {
        title = 'What do you need?',
        options = {},
    }

    menuConfirm =
    {
        title = 'Are you sure?',
        options = {},
    }

    page1 =
    {
        {
            'Job rebirth',

            function(playerArg)
                if player:getMainLvl() >=99 then
                    player:printToPlayer(string.format('You are qualified for rebirth', player:getSpentJobPoints()), 0, npc:getPacketName())
                    menu.title = 'This will reset your current job to level 1'
                    menu.options = rebirthConfirm
                    delaySendMenu(playerArg)
                else
                    player:printToPlayer(string.format('Come back when you\'re level 99 and you\'ve mastered your job', player:getSpentJobPoints()), 0, npc:getPacketName())
                end
                -- playerArg:setPos(0, 0, 0, 0, xi.zone.LOWER_JEUNO)
            end,
        },
        {
            'Next Page',
            function(playerArg)
                menu.options = page2
                delaySendMenu(playerArg)
            end,
        },
    }

    page2 =
    {
        {
            'Send me to Aht Urghan!',
            function(playerArg)
                playerArg:setPos(0, 0, 0, 0, xi.zone.AHT_URHGAN_WHITEGATE)
            end,
        },
        {
            'Previous Page',
            function(playerArg)
                menu.options = page1
                delaySendMenu(playerArg)
            end,
        },
    }

    rebirthConfirm =
    {
        {
            'Let\'s gooo',
            function(playerArg)
                player:printToPlayer('You feel much weaker, buy you have gained something more', xi.msg.channel.SYSTEM_3)
                if jobRebirth < 1 then
                    player:setCharVar(jobRebirthVar, 1)
                    player:setCharVar('tier1_rebirth', tier1 + 1)
                    player:setLevel(1)
                else
                    player:printToPlayer('Oops further rebirths are not implemented yet', 0, npc:getPacketName())
                end
            end,
        },
        {
            'Maybe later',
            function(playerArg)
                player:printToPlayer('Understandable, come back if you change your mind', 0, npc:getPacketName())
            end,
        },
    }

    menu.options = page1
    delaySendMenu(player)

    local keyItems =
    {
        2884, 2885, 2886, 2887, 2889, 2890, 2891, 2892, 2893,
    }
    for i = 1, #keyItems do
        if i == #keyItems then
            silent = false
            sendUpdate = true
        end
        player:addKeyItem(keyItems[i])
    end
end

local onTradeFunc = function(player, npc, trade)
    local ID = zones[player:getZoneID()]
    local tradeList = {trade:getItemId(0), trade:getItemId(1), trade:getItemId(2), trade:getItemId(3), trade:getItemId(4),}
    npc:facePlayer(player)
    if trade:confirmItem(16482) then
        player:printToPlayer('Sorry it seems like your bag is full. Try clearing your inventory', 0, npc:getPacketName())
        return
    elseif trade:confirmItem(536) then
        player:printToPlayer('Ho ho ho I didn\'t think someone would keep this around. This brings memories of my time as an adventurer', 0, npc:getPacketName())
        player:printToPlayer('I\'ll give you these for it.', 0, npc:getPacketName())
        player:addItem(4094, 1)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 4094)
        player:addItem(13440, 1)
        player:messageSpecial(ID.text.ITEM_OBTAINED, 13440)
        player:printToPlayer('If you trade me back the ring I gave you along with the stew I can augment the ring with powerful effects', 0, npc:getPacketName())
        player:tradeComplete()
        return
    elseif trade:confirmItem(4094) and trade:confirmItem(13440) then
        if trade:getSlotCount() == 2 then
            player:printToPlayer('here you go, one powerful ring just for you!', 0, npc:getPacketName())
            player:messageSpecial(ID.text.ITEM_OBTAINED, 13440)
            player:tradeComplete()
            player:addItem(13440, 1, 71, 4, 49, 4, 142, 14, 140, 19)
            return
        else
            player:printToPlayer('For other equipment you can add other items to add more augments, but I just need the stew and ring for this one', 0, npc:getPacketName())
            return
        end
    end   
    player:printToPlayer(string.format('test 2 %s', trade:getItemId()), 0, npc:getPacketName())
end

m:addOverride('xi.zones.Bastok_Mines.Zone.onInitialize', function(zone)
    -- Call the zone's original function for onInitialize
    super(zone)

    -- Insert NPC into zone
    local Horro = zone:insertDynamicEntity({

        -- NPC or MOB
        objtype = xi.objType.NPC,

        -- The name visible to players
        -- NOTE: Even if you plan on making the name invisible, we're using it internally for lookups
        --     : So populate it with something unique-ish even if you aren't going to use it.
        --     : You can then hide the name with entity:hideName(true)
        -- NOTE: This name CAN include spaces and underscores.
        name = 'Horro',

        -- Optional: Define a different name that is visible to players.
        -- 'Horro' (DE_Horro) will still be used internally for lookups.
        -- packetName = 'New Horro',

        -- You can use regular model ids (See documentation/model_ids.txt, or play around with !costume)
        look = 2430,

        -- You can also use the raw packet look information (as a string), as seen in npc_list and mob_pools
        -- look = '0x0100020500101120003000400050006000700000',

        -- Set the position using in-game x, y and z
        x = 100.446,
        y = 0.623,
        z = -69.617,

        -- Rotation is scaled 0-255, with 0 being East
        rotation = 0,

        -- Overriding widescan is only available to NPCs.
        widescan = 1,

        -- onTrade and onTrigger can be hooked up to your dynamic entity,
        -- just like with regular entities. You can also omit these.
        onTrade = onTradeFunc,
        -- The entity will not be 'triggerable' unless you populate onTrigger
        onTrigger = onTriggerFunc,
    })


    -- Use the mob object however you like
    -- horro:getID() etc.
    -- We're not doing anything with it, so ignore this object


    -- You could also just not capture the object
    -- zone:insertDynamicEntity({ ...

    -- Menu NPC Example
end)    

xi.zones.Bastok_Mines.npcs.DE_Horro.onTrigger = onTriggerFunc
xi.zones.Bastok_Mines.npcs.DE_Horro.onTrade = onTradeFunc

return m