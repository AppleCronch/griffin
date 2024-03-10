-----------------------------------
-- Replace Trust with Trust: Cornelia (configurable)
--
-- The name of the spell itself can't be changed (would require client changes),
-- but everything else can be changed!
-----------------------------------
require('modules/module_utils')
require('scripts/globals/trust')
-----------------------------------
local m = Module:new('ulmia_fix')

-- This is the filename of the trust you're trying to replace, without the '.lua' extension
local trustToReplaceName = 'ulmia'

m:addOverride(string.format('xi.actions.spells.trust.%s.onSpellCast', trustToReplaceName), function(caster, target, spell)
    return xi.trust.spawn(caster, spell)
end)


m:addOverride(string.format('xi.actions.spells.trust.%s.onMobSpawn', trustToReplaceName), function(mob)
    mob:addMod(xi.mod.QUICK_MAGIC, 130)
    mob:addMod(xi.mod.MAXIMUM_SONGS_BONUS, 6)
    mob:addMod(xi.mod.ALL_SONGS_EFFECT, 31)
    mob:addMod(xi.mod.SONG_DURATION_BONUS, 3000)

    xi.trust.teamworkMessage(mob, {
        [xi.magic.spell.PRISHE] = xi.trust.messageOffset.TEAMWORK_1,
        [xi.magic.spell.MILDAURION] = xi.trust.messageOffset.TEAMWORK_2,
    })

    -- TODO: BRD trusts need better logic and major overhaul, for now they compliment each other
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.MARCH, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MARCH)
    mob:addSimpleGambit(ai.t.SELF, ai.c.NOT_STATUS, xi.effect.MADRIGAL, ai.r.MA, ai.s.HIGHEST, xi.magic.spellFamily.MADRIGAL)

    mob:setAutoAttackEnabled(false)

    mob:setMobMod(xi.mobMod.TRUST_DISTANCE, xi.trust.movementType.MID_RANGE)
end)


return m
