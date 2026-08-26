# Pendant un duel, on ne re-donne pas l'item menu sinon il "pop"/"depop"
# a l'infini a chaque tick. On le remet seulement quand le joueur est sorti
# du combat.
execute if entity @s[tag=pvp.duel] run function pvp:ensure_pvp_compass_skip
execute unless entity @s[tag=pvp.duel] run function pvp:ensure_pvp_compass_give
