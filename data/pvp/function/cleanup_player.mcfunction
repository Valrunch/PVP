# Nettoyage des tags et scores
tag @s remove pvp.duel
tag @s remove pvp.slot1
tag @s remove pvp.slot2
tag @s remove pvp.loser

scoreboard players set @s pvp.request 0
scoreboard players set @s pvp.requested_id 0
scoreboard players set @s pvp.pending_from 0
scoreboard players set @s pvp.pendingticks 0

gamemode survival @s

# Sécurité anti-mort au respawn
effect clear @s
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true