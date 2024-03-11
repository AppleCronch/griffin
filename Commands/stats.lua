-----------------------------------
-- func: additem <itemId> <quantity> <aug1> <v1> <aug2> <v2> <aug3> <v3> <aug4> <v4> <trial>
-- desc: Adds an item to the GMs inventory.
-----------------------------------
local commandObj = {}

commandObj.cmdprops =
{
    permission = 1,
    parameters = 's'
}


commandObj.onTrigger = function(player, modid)
    -- Load needed text ids for players current zone..
    local target = player:getCursorTarget()
    if target == nil then
        player:printToPlayer('Target something first.')
        return
    end

    local targetType = target:getObjType()

    if targetType == xi.objType.NPC then
        player:printToPlayer('Target something other than an NPC..They don\'t have stats!')
        return
    end

    player:printToPlayer(string.format('MainJob(jID: %s) LV: %i / SubJob(jID: %s) LV: %i ',
        target:getMainJob(), target:getMainLvl(), target:getSubJob(), target:getSubLvl()), xi.msg.channel.SYSTEM_3)

    player:printToPlayer(string.format('HP: %i/%i  MP: %i/%i (current/max) ',
        target:getHP(), target:getMaxHP(), target:getMP(), target:getMaxMP()), xi.msg.channel.SYSTEM_3)

    player:printToPlayer(string.format('Total STR: %i ', player:getStat(xi.mod.STR)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total DEX: %i ', player:getStat(xi.mod.DEX)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total VIT: %i ', player:getStat(xi.mod.VIT)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total AGI: %i ', player:getStat(xi.mod.AGI)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total MND: %i ', player:getStat(xi.mod.MND)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total INT: %i ', player:getStat(xi.mod.INT)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total CHR: %i ', player:getStat(xi.mod.CHR)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Food Accuracy%% bonus: %i ', player:getMod(xi.mod.FOOD_ACCP)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Accuracy Base: %i ', player:getMod(xi.mod.ACC)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total Accuracy: %i ', player:getStat(xi.mod.ACC)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Main Weap Dmg: %i ', player:getWeaponDmg()), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('RAccuracy Base: %i ', player:getMod(xi.mod.RACC)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total RAccuracy: %i ', player:getStat(xi.mod.RACC)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Ranged Weap Dmg: %i ', player:getRangedDmg()), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('EVA Base: %i ', player:getMod(xi.mod.EVA)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('EVA Total: %i ', player:getStat(xi.mod.EVA)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Magic EVA Base: %i ', player:getMod(xi.mod.MEVA)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Attack Base: %i ', player:getMod(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total Attack: %i ', player:getStat(xi.mod.ATT)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Defense Base: %i ', player:getMod(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Total Defense: %i ', player:getStat(xi.mod.DEF)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Magic Attack bonus: %i ', player:getMod(xi.mod.MATT)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Magic Defense bonus: %i ', player:getMod(xi.mod.MDEF)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Magic Accuracy bonus: %i ', player:getMod(xi.mod.MACC)), xi.msg.channel.SYSTEM_3)
    
    -- player:printToPlayer(string.format('Total Subtle Blow: %i ', target:getMod(xi.mod.SUBTLE_BLOW)), xi.msg.channel.SYSTEM_3)
    -- player:printToPlayer(string.format('Total Store TP: %i ', target:getMod(xi.mod.STORETP)), xi.msg.channel.SYSTEM_3)
    -- player:printToPlayer('Cannot easily and accurately get Magic Evasion with current methods.')

    if targetType == xi.objType.PC then
        player:printToPlayer(string.format('%s\'s base Treasure Hunter with current equipment: %i', target:getName(), target:getMod(xi.mod.TREASURE_HUNTER)), xi.msg.channel.SYSTEM_3)
    elseif targetType == xi.objType.PET then
        -- not needed yet, but we don't want to run MOB so just die in empty conditionals
    elseif targetType == xi.objType.TRUST then
        -- see above
    elseif targetType == xi.objType.FELLOW then
        -- see above
    elseif targetType == xi.objType.MOB then
        player:printToPlayer(string.format('Mob\'s current Treasure Hunter Tier: %i', target:getTHlevel()), xi.msg.channel.SYSTEM_3)
        player:printToPlayer(string.format('Battletime: %i ', target:getBattleTime()), xi.msg.channel.SYSTEM_3)
        -- Todo: check if raged and/or how long mobs ragetimer is.
    end

    local weaponType = player:getWeaponSkillType(xi.slot.MAIN)
    local pDifWeaponCapTable =
    {
        -- [Skill/weapon type used] = {pre-randomizer_pDIF_cap}, Values from: https://www.bg-wiki.com/ffxi/PDIF
        [xi.skill.NONE            ] = { 3    }, -- We will use this for mobs.
        [xi.skill.HAND_TO_HAND    ] = { 3.5  },
        [xi.skill.DAGGER          ] = { 3.25 },
        [xi.skill.SWORD           ] = { 3.25 },
        [xi.skill.GREAT_SWORD     ] = { 3.75 },
        [xi.skill.AXE             ] = { 3.25 },
        [xi.skill.GREAT_AXE       ] = { 3.75 },
        [xi.skill.SCYTHE          ] = { 4    },
        [xi.skill.POLEARM         ] = { 3.75 },
        [xi.skill.KATANA          ] = { 3.25 },
        [xi.skill.GREAT_KATANA    ] = { 3.5  },
        [xi.skill.CLUB            ] = { 3.25 },
        [xi.skill.STAFF           ] = { 3.75 },
        [xi.skill.AUTOMATON_MELEE ] = { 3    }, -- Unknown value. Copy of value below.
        [xi.skill.AUTOMATON_RANGED] = { 3    }, -- Unknown value. Reference found in an old post: https://forum.square-enix.com/ffxi/archive/index.php/t-52778.html?s=d906df07788334a185a902b0a6ae6a99
        [xi.skill.AUTOMATON_MAGIC ] = { 3    }, -- Unknown value. Here for completion sake.
        [xi.skill.ARCHERY         ] = { 3.25 },
        [xi.skill.MARKSMANSHIP    ] = { 3.5  },
        [xi.skill.THROWING        ] = { 3.25 },
    }

    local wCap = pDifWeaponCapTable[weaponType][1]
    local plus = player:getMod(xi.mod.DAMAGE_LIMIT)/100
    local plusp = (100 + player:getMod(xi.mod.DAMAGE_LIMITP))/100
    local baseRatio = player:getStat(xi.mod.ATT) / target:getStat(xi.mod.DEF)
    local baseRatioR = player:getStat(xi.mod.RATT) / target:getStat(xi.mod.DEF)
    local cappedRatio = utils.clamp(baseRatio, 0, wCap)
    local cappedRatioR = utils.clamp(baseRatioR, 0, wCap)
    local dlCap = 0


    if cappedRatio > 3.24 then
        dlCap = (cappedRatio + plus) * plusp
        player:printToPlayer(string.format('Capped'), xi.msg.channel.SYSTEM_3)
    else
        dlCap = cappedRatio
        player:printToPlayer(string.format('Uncapped'), xi.msg.channel.SYSTEM_3)
    end 

    local pdif = (wCap + plus) * plusp + 1
    local playerATT = player:getStat(xi.mod.ATT)
    local mobDef = target:getStat(xi.mod.DEF)

    player:printToPlayer(string.format('Damage limit + : %s', plus), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Damage limit + : %s percent', plusp), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('pDIF uncapped: %s', baseRatio), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('pDIF capped: %s', cappedRatio), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('pDIF Damage limit uncapped: %s', dlCap), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('Enspell: %s', player:getStat(xi.mod.ENSPELL_DMG)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('DA %s', player:getMod(xi.mod.DOUBLE_ATTACK)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('TA %s', player:getMod(xi.mod.TRIPLE_ATTACK)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('QA %s', player:getMod(xi.mod.QUAD_ATTACK)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('DW %s', player:getMod(xi.mod.DUAL_WIELD)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('1 hour recast reduction %s', player:getMod(xi.mod.ONE_HOUR_RECAST)), xi.msg.channel.SYSTEM_3)
    player:printToPlayer(string.format('WS DMG %s', player:getMod(xi.mod.ALL_WSDMG_ALL_HITS)), xi.msg.channel.SYSTEM_3)

end

return commandObj
