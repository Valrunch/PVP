execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu es deja en duel.","color":"red"}]
execute if score @s pvp.saved matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Reapparais d'abord pour recuperer ton inventaire.","color":"red"}]
tag @s add pvp.menu_target
tellraw @s [{"text":"=== Defier un joueur ===","color":"gold"}]
scoreboard players set #candidates pvp.candidates 0
execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] unless score @s pvp.pending_from matches 1.. unless score @s pvp.saved matches 1.. run scoreboard players add #candidates pvp.candidates 1
execute if score #candidates pvp.candidates matches 0 run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Aucun joueur disponible.","color":"gray"}]
execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] unless score @s pvp.pending_from matches 1.. unless score @s pvp.saved matches 1.. run function pvp:menu_send_line
tag @s remove pvp.menu_target
