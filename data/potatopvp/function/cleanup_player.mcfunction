# Contexte : exécuté "as" chaque ex-duelliste
gamemode survival @s
clear @s
effect clear @s
tag @s remove pvp.duel
tag @s remove pvp.slot1
tag @s remove pvp.slot2
tag @s remove pvp.loser
scoreboard players set @s pvp.request 0
scoreboard players set @s pvp.pending_from 0
