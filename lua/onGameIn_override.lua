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


    if tier1 > 0 then
        local baseBoost = math.floor(5 * (tier1 + math.floor(1.5 * tier2) + math.floor(2 * tier3)))
        player:addMod(xi.mod.STR, baseBoost)
        player:addMod(xi.mod.DEX, baseBoost)
        player:addMod(xi.mod.VIT, baseBoost)
        player:addMod(xi.mod.AGI, baseBoost)
        player:addMod(xi.mod.INT, baseBoost)
        player:addMod(xi.mod.MND, baseBoost)
        player:addMod(xi.mod.CHR, baseBoost)
    end

    if warRebirth > 0 then
        player:addMod(xi.mod.DOUBLE_ATTACK, 5 + 10 * warRebirth)
        player:addMod(xi.mod.AXE, 15 + 20 * warRebirth)
        player:addMod(xi.mod.GAXE, 15 + 20 * warRebirth)
        player:addMod(xi.mod.FENCER_CRITHITRATE,  5 + 3 * warRebirth)
    end

    if mnkRebirth > 0 then
        player:addMod(xi.mod.TACTICAL_GUARD, 20 + 30 * mnkRebirth)
        player:addMod(xi.mod.HTH, 15 + 20 * mnkRebirth)
        player:addMod(xi.mod.GUARD, 15 + 20 * mnkRebirth)
        player:addMod(xi.mod.MARTIAL_ARTS, 10 + 5 * mnkRebirth)
    end

    if whmRebirth > 0 then
        player:addMod(xi.mod.CURE_POTENCY, 5 * whmRebirth)
        player:addMod(xi.mod.CURE_POTENCY_II, 2 * whmRebirth)
        player:addMod(xi.mod.HEALING, 15 + 20 * whmRebirth)
        player:addMod(xi.mod.DIVINE, 15 + 20 * whmRebirth)
        player:addMod(xi.mod.DIVINE_BENISON, 5 + 5 * whmRebirth)
    end

    if blmRebirth > 0 then
        player:addMod(xi.mod.MATT, 50 + 35 * blmRebirth)
        player:addMod(xi.mod.ELEM, 15 + 20 * blmRebirth)
        player:addMod(xi.mod.DARK, 15 + 20 * blmRebirth)
        player:addMod(xi.mod.MAG_BURST_BONUS, 10 + 10 * blmRebirth)
    end

    if rdmRebirth > 0 then
        player:addMod(xi.mod.FASTCAST, 2 + 3 * rdmRebirth)
        player:addMod(xi.mod.MACC, 15 + 20 * rdmRebirth)
        player:addMod(xi.mod.ENFEEBLE, 15 + 20 * rdmRebirth)
        player:addMod(xi.mod.ENHANCE, 15 + 20 * rdmRebirth)
    end

    if thfRebirth > 0 then
        player:addMod(xi.mod.TRIPLE_ATTACK, 10 + 4 * thfRebirth)
        player:addMod(xi.mod.DAGGER, 15 + 20 * thfRebirth)
        player:addMod(xi.mod.EVASION, 15 + 20 * thfRebirth)
        player:addMod(xi.mod.CRIT_DMG_INCREASE, 3 + 5 * thfRebirth)
    end

    if pldRebirth > 0 then
        player:addMod(xi.mod.SHIELDBLOCKRATE, 5 + 3 * pldRebirth)
        player:addMod(xi.mod.SWORD, 15 + 20 * pldRebirth)
        player:addMod(xi.mod.SHIELD, 15 + 20 * pldRebirth)
        player:addMod(xi.mod.DEF, 50 + 35 * pldRebirth)
    end

    if drkRebirth > 0 then
        player:addMod(xi.mod.ATT, 50 + 35 * drkRebirth)
        player:addMod(xi.mod.GSWORD, 15 + 20 * drkRebirth)
        player:addMod(xi.mod.SCYTHE, 15 + 20 * drkRebirth)
        player:addMod(xi.mod.SMITE, 5 + 5 * drkRebirth)
    end

    if bstRebirth > 0 then
        player:addMod(xi.mod.TANDEM_STRIKE_POWER, 30 + 15 * bstRebirth)
        player:addMod(xi.mod.PET_ATK_DEF, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_ACC_EVA, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_MAB_MDB, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_MACC_MEVA, 50 + 50 * bstRebirth)
        player:addMod(xi.mod.PET_ATTR_BONUS, 50 + 50 * bstRebirth)
    end
end)

return m