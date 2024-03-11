-----------------------------------
-- Gives buffs during login
-----------------------------------
local m = Module:new('onGameIn_override')

m:addOverride('xi.player.onGameIn', function(player, firstLogin, zoning)
    local tier1 = player:getCharVar('tier1_rebirth')
    local tier2 = player:getCharVar('tier2_rebirth')
    local tier3 = player:getCharVar('tier3_rebirth')
    local extraTier = player:getCharVar('extra_tier_rebirth')

    local warRebirth = player:getCharVar('WAR_rebirth')
    local mnkRebirth = player:getCharVar('MNK_rebirth')
    local whmRebirth = player:getCharVar('WHM_rebirth')
    local blmRebirth = player:getCharVar('BLM_rebirth')
    local rdmRebirth = player:getCharVar('RDM_rebirth')
    local thfRebirth = player:getCharVar('THF_rebirth')
    local pldRebirth = player:getCharVar('PLD_rebirth')
    local drkRebirth = player:getCharVar('DRK_rebirth')
    local bstRebirth = player:getCharVar('BST_rebirth')
    local brdRebirth = player:getCharVar('BRD_rebirth')
    local rngRebirth = player:getCharVar('RNG_rebirth')
    local samRebirth = player:getCharVar('SAM_rebirth')
    local ninRebirth = player:getCharVar('NIN_rebirth')
    local drgRebirth = player:getCharVar('DRG_rebirth')
    local smnRebirth = player:getCharVar('SMN_rebirth')
    local bluRebirth = player:getCharVar('BLU_rebirth')
    local corRebirth = player:getCharVar('COR_rebirth')
    local pupRebirth = player:getCharVar('PUP_rebirth')
    local dncRebirth = player:getCharVar('DNC_rebirth')
    local schRebirth = player:getCharVar('SCH_rebirth')
    local geoRebirth = player:getCharVar('GEO_rebirth')
    local runRebirth = player:getCharVar('RUN_rebirth')

    player:addMod(xi.mod.HASTE_ABILITY, 5)
    player:addMod(xi.mod.HASTE_GEAR, 5)
    player:addMod(xi.mod.HASTE_MAGIC, 5)


    if tier1 > 0 then
        local baseBoost = math.floor(5 * (tier1 + math.floor(1.5 * tier2) + math.floor(2 * tier3)))
        player:addMod(xi.mod.STR, baseBoost)
        player:addMod(xi.mod.DEX, baseBoost)
        player:addMod(xi.mod.VIT, baseBoost)
        player:addMod(xi.mod.AGI, baseBoost)
        player:addMod(xi.mod.INT, baseBoost)
        player:addMod(xi.mod.MND, baseBoost)
        player:addMod(xi.mod.CHR, baseBoost)
        player:addMod(xi.mod.HASTE_ABILITY, 5 + math.floor(tier1 / 6))
        player:addMod(xi.mod.DMG_RATING, 5 + 1 * tier1)
        player:addMod(xi.mod.MAGIC_DAMAGE, 5 + 1 * tier1)
    end

    if tier2 > 0 then
        player:addMod(xi.mod.STR, 50)
        player:addMod(xi.mod.DEX, 50)
        player:addMod(xi.mod.VIT, 50)
        player:addMod(xi.mod.AGI, 50)
        player:addMod(xi.mod.INT, 50)
        player:addMod(xi.mod.MND, 50)
        player:addMod(xi.mod.CHR, 50)
        player:addMod(xi.mod.HASTE_ABILITY, 5 + math.floor(tier2 / 3))
        player:addMod(xi.mod.DOUBLE_ATTACK, 5 + 3 * tier2)
        player:addMod(xi.mod.TRIPLE_ATTACK, 2 + 2 * tier2)
        player:addMod(xi.mod.QUAD_ATTACK, 1 + 1 * tier2)
        player:addMod(xi.mod.STATUSRES, 3 + 1 * tier2)
        player:addMod(xi.mod.CRITHITRATE, 3 + 2 * tier2)
        player:addMod(xi.mod.DMG_RATING, 15 + 3 * tier2)
        player:addMod(xi.mod.MAGIC_DAMAGE, 15 + 3 * tier2)
        player:addMod(xi.mod.ACC, 25 + 5 * tier2)
        player:addMod(xi.mod.RACC, 25 + 5 * tier2)
        player:addMod(xi.mod.MACC, 25 + 5 * tier2)
        player:addMod(xi.mod.ATT, 5 + 3 * tier2)
        player:addMod(xi.mod.RATT, 5 + 3 * tier2)
        player:addMod(xi.mod.MATT, 5 + 3 * tier2)
    end

    if warRebirth > 0 then
        player:addMod(xi.mod.DOUBLE_ATTACK, 5 + 10 * warRebirth)
        player:addMod(xi.mod.AXE, 25 + 30 * warRebirth)
        player:addMod(xi.mod.GAXE, 25 + 30 * warRebirth)
        player:addMod(xi.mod.FENCER_CRITHITRATE,  5 + 3 * warRebirth)
        player:addStatusEffect(xi.effect.BERSERK, 25 + player:getMod(xi.mod.BERSERK_POTENCY), 0, 0)
    end

    if mnkRebirth > 0 then
        player:addMod(xi.mod.TACTICAL_GUARD, 20 + 30 * mnkRebirth)
        player:addMod(xi.mod.HTH, 25 + 30 * mnkRebirth)
        player:addMod(xi.mod.GUARD, 25 + 30 * mnkRebirth)
        player:addMod(xi.mod.MARTIAL_ARTS, 10 + 5 * mnkRebirth)
        player:addStatusEffect(xi.effect.IMPETUS, 2, 0, 0)
    end

    if whmRebirth > 0 then
        player:addMod(xi.mod.CURE_POTENCY, 5 * whmRebirth)
        player:addMod(xi.mod.CURE_POTENCY_II, 2 * whmRebirth)
        player:addMod(xi.mod.HEALING, 25 + 30 * whmRebirth)
        player:addMod(xi.mod.DIVINE, 25 + 30 * whmRebirth)
        player:addMod(xi.mod.DIVINE_BENISON, 5 + 5 * whmRebirth)
        player:addStatusEffect(xi.effect.SACROSANCTITY, 3, 0, 0)
    end

    if blmRebirth > 0 then
        player:addMod(xi.mod.MATT, 50 + 35 * blmRebirth)
        player:addMod(xi.mod.ELEM, 25 + 30 * blmRebirth)
        player:addMod(xi.mod.DARK, 25 + 30 * blmRebirth)
        player:addMod(xi.mod.MAG_BURST_BONUS, 10 + 10 * blmRebirth)
        player:addStatusEffect(xi.effect.SUBTLE_SORCERY, 1, 0, 0)
    end

    if rdmRebirth > 0 then
        player:addMod(xi.mod.FASTCAST, 2 + 3 * rdmRebirth)
        player:addMod(xi.mod.MACC, 25 + 30 * rdmRebirth)
        player:addMod(xi.mod.ENFEEBLE, 25 + 30 * rdmRebirth)
        player:addMod(xi.mod.ENHANCE, 25 + 30 * rdmRebirth)
        player:addStatusEffect(xi.effect.SABOTEUR, 1, 0, 0)
    end

    if thfRebirth > 0 then
        player:addMod(xi.mod.TRIPLE_ATTACK, 10 + 4 * thfRebirth)
        player:addMod(xi.mod.DAGGER, 25 + 30 * thfRebirth)
        player:addMod(xi.mod.EVASION, 25 + 30 * thfRebirth)
        player:addMod(xi.mod.CRIT_DMG_INCREASE, 3 + 5 * thfRebirth)
        player:addStatusEffect(xi.effect.FLEE, 100, 0, 0)
    end

    if pldRebirth > 0 then
        player:addMod(xi.mod.SHIELDBLOCKRATE, 5 + 3 * pldRebirth)
        player:addMod(xi.mod.SWORD, 25 + 30 * pldRebirth)
        player:addMod(xi.mod.SHIELD, 25 + 30 * pldRebirth)
        player:addMod(xi.mod.DEF, 50 + 35 * pldRebirth)
        player:addStatusEffect(xi.effect.PALISADE, 30 + player:getJobPointLevel(xi.jp.PALISADE_EFFECT), 0, 0)
    end

    if drkRebirth > 0 then
        player:addMod(xi.mod.ATT, 50 + 35 * drkRebirth)
        player:addMod(xi.mod.GSWORD, 25 + 30 * drkRebirth)
        player:addMod(xi.mod.SCYTHE, 25 + 30 * drkRebirth)
        player:addMod(xi.mod.SMITE, 5 + 5 * drkRebirth)
        player:addStatusEffect(xi.effect.LAST_RESORT, 0, 0, 0)
    end

    if bstRebirth > 0 then
        player:addMod(xi.mod.TANDEM_STRIKE_POWER, 30 + 15 * bstRebirth)
        player:addMod(xi.mod.PET_ATK_DEF, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_ACC_EVA, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_MAB_MDB, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_MACC_MEVA, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_ATTR_BONUS, 50 + 50 * bstRebirth)
    end

    if brdRebirth > 0 then
        player:addMod(xi.mod.MAXIMUM_SONGS_BONUS, 1 * brdRebirth)
        player:addMod(xi.mod.SINGING, 25 + 30 * brdRebirth)
        player:addMod(xi.mod.STRING, 25 + 30 * brdRebirth)
        player:addMod(xi.mod.WIND, 25 + 30 * brdRebirth)
        player:addMod(xi.mod.ALL_SONGS_EFFECT, 1 + 1 * brdRebirth)
        player:addStatusEffect(xi.effect.LAST_RESORT, 0, 0, 0)
    end

    if rngRebirth > 0 then
        player:addMod(xi.mod.RANGED_CRIT_DMG_INCREASE, 15 + 5 * rngRebirth)
        player:addMod(xi.mod.ARCHERY, 25 + 30 * rngRebirth)
        player:addMod(xi.mod.MARKSMAN, 25 + 30 * rngRebirth)
        player:addMod(xi.mod.RECYCLE, 150)
        player:addMod(xi.mod.RANGED_DELAY, 3 + 2 * rngRebirth)
        player:addStatusEffect(xi.effect.SHARPSHOT, 40 + player:getMod(xi.mod.SHARPSHOT), 0, 60)
    end

    if samRebirth > 0 then
        player:addMod(xi.mod.ZANSHIN, 25 + 10 * samRebirth)
        player:addMod(xi.mod.GKATANA, 25 + 30 * samRebirth)
        player:addMod(xi.mod.PARRY, 25 + 30 * samRebirth)
        player:addMod(xi.mod.STORETP, 15 + 15 * samRebirth)
        player:addStatusEffect(xi.effect.MINUET, 32, 0, 0)
    end

    if ninRebirth > 0 then
        player:addMod(xi.mod.DUAL_WIELD, 5)
        player:addMod(xi.mod.KATANA, 25 + 30 * ninRebirth)
        player:addMod(xi.mod.NINJUTSU, 25 + 30 * ninRebirth)
        player:addMod(xi.mod.QUAD_ATTACK, 3 + 2 * ninRebirth)
        player:addStatusEffect(xi.effect.ISSEKIGAN, 25, 0, 0)
    end

    if drgRebirth > 0 then
        player:addMod(xi.mod.CONSERVE_TP, 15 + 10 * drgRebirth)
        player:addMod(xi.mod.POLEARM, 25 + 30 * drgRebirth)
        player:addMod(xi.mod.WYVERN_BREATH_MACC, 35 + 30 * drgRebirth)
        player:addMod(xi.mod.ALL_WSDMG_ALL_HITS, 5 + 5 * drgRebirth)
        player:addStatusEffect(xi.effect.DRAGON_BREAKER, 20, 0, 0)
    end

    if smnRebirth > 0 then
        player:addMod(xi.mod.TANDEM_STRIKE_POWER, 30 + 15 * smnRebirth)
        player:addMod(xi.mod.PET_ATK_DEF, 50 + 50 * smnRebirth)
        player:addMod(xi.mod.PET_ACC_EVA, 50 + 50 * smnRebirth)
        player:addMod(xi.mod.PET_MAB_MDB, 50 + 50 * smnRebirth)
        player:addMod(xi.mod.PET_MACC_MEVA, 50 + 50 * smnRebirth)
        player:addMod(xi.mod.PET_ATTR_BONUS, 50 + 50 * smnRebirth)
    end

    if bluRebirth > 0 then
        player:addMod(xi.mod.STATUSRES, 3 + 1 * bluRebirth)
        player:addMod(xi.mod.BLUE, 25 + 30 * bluRebirth)
        player:addMod(xi.mod.MEVA, 20 + 10 * bluRebirth)
        player:addMod(xi.mod.EXTRA_DUAL_WIELD_ATTACK, 5 + 5 * bluRebirth)
    end

    if corRebirth > 0 then
        player:addMod(xi.mod.MARKSMAN, 25 + 30 * corRebirth)
        player:addMod(xi.mod.RACC, 50 + 50 * corRebirth)
        player:addMod(xi.mod.RATT, 50 + 50 * corRebirth)
        player:addMod(xi.mod.ARCHERY, 25 + 30 * corRebirth)
        player:addCorsairRoll(xi.job.COR, player:getMerit(xi.merit.BUST_DURATION), xi.effect.CHAOS_ROLL, 32, 0, 0, player:getID(), 11, MOD_ATTP)
    end

    if pupRebirth > 0 then
        player:addMod(xi.mod.AUTO_MELEE_SKILL, 45 + 40 * pupRebirth)
        player:addMod(xi.mod.AUTO_RANGED_SKILL, 45 + 40 * pupRebirth)
        player:addMod(xi.mod.AUTO_MAGIC_SKILL, 45 + 40 * pupRebirth)
        player:addMod(xi.mod.AUTOMATON_LVL_BONUS, 10 + 1 * pupRebirth)
    end

    if dncRebirth > 0 then
        player:addMod(xi.mod.SKILLCHAINBONUS, 10 + 5 * dncRebirth)
        player:addMod(xi.mod.GKATANA, 25 + 30 * dncRebirth)
        player:addMod(xi.mod.PARRY, 25 + 30 * dncRebirth)
        player:addMod(xi.mod.ACC, 25 + 30 * dncRebirth)
        player:addStatusEffect(xi.effect.GRAND_PAS, 19, 1, 0)
    end

    if schRebirth > 0 then
        player:addMod(xi.mod.MATT, 20 + 25 * schRebirth)
        player:addMod(xi.mod.ENHANCE, 25 + 30 * schRebirth)
        player:addMod(xi.mod.ENFEEBLE, 25 + 30 * schRebirth)
        player:addMod(xi.mod.MACC, 15 + 25 * schRebirth)
        player:addStatusEffect(xi.effect.TABULA_RASA, math.floor(math.floor(player:getMainLvl() / 4) * 1.5), 0, 0, 0, math.floor(3 * math.floor((player:getMainLvl() - 10) / 10) * 1.5))
    end

    if geoRebirth > 0 then
        player:addMod(xi.mod.MATT, 20 + 25 * geoRebirth)
        player:addMod(xi.mod.GEOMANCY_SKILL, 25 + 30 * geoRebirth)
        player:addMod(xi.mod.HANDBELL_SKILL, 25 + 30 * geoRebirth)
        player:addMod(xi.mod.CONSERVE_MP, 10 + 15 * geoRebirth)
        player:addStatusEffect(xi.effect.BOLSTER, 0, 3, 0)
    end

    if runRebirth > 0 then
        player:addMod(xi.mod.MDEF, 20 + 15 * runRebirth)
        player:addMod(xi.mod.GSWORD, 25 + 30 * runRebirth)
        player:addMod(xi.mod.INQUARTATA, 5 + 5 * runRebirth)
        player:addMod(xi.mod.MATT, 10 + 15 * runRebirth)
        local power = 4                                               -- Naked swordplay starts at 3. Retail confirmed.
        power       = power + power * player:getMod(xi.mod.SWORDPLAY) -- "Swordplay + X" Where X is TICKS.
    
        -- Calculate subPower. (Subtle blow) https://www.bg-wiki.com/ffxi/Sleight_of_Sword
        local subPower = player:getMerit(xi.merit.MERIT_SLEIGHT_OF_SWORD) + 1                            -- Each merit adds 5 "Subtle Blow".
        subPower       = subPower + (subPower / 5) * player:getMod(xi.mod.AUGMENTS_SLEIGHT_OF_SWORD) -- Add augment effect IF player has augment.
    
        player:addStatusEffect(xi.effect.SWORDPLAY, power, 3, 0, 0, subPower, 0)
    end

end)

return m