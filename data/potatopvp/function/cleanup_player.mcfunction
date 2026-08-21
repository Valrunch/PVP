# Contexte : exécuté "as" chaque ex-duelliste, APRES le retour overworld.
# Pas de "clear @s" ici : Dimensional Inventories vient de restaurer le
# vrai inventaire du joueur au moment du changement de dimension juste
# avant — un clear ici l'effacerait immédiatement. Idem pour les effets
# (le mod les gère aussi lors du changement de pool).
gamemode survival @s
tag @s remove pvp.duel
tag @s remove pvp.slot1
tag @s remove pvp.slot2
tag @s remove pvp.loser
scoreboard players set @s pvp.request 0
scoreboard players set @s pvp.pending_from 0
