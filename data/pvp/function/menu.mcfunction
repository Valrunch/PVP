# Contexte : exécuté "as" le joueur qui vient de faire /trigger pvp.trigger
execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"Tu es déjà en duel.","color":"red"}]

# pvp.menu_target identifie le joueur POUR QUI on construit le menu.
# On en tague au plus un à la fois : si deux joueurs ouvrent le menu
# exactement au même tick, l'un des deux devra juste refaire /trigger.
tag @s add pvp.menu_target
tellraw @s [{"text":"=== Défier un joueur ===","color":"gold"}]

scoreboard players set #candidates pvp.state 0
execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] run scoreboard players add #candidates pvp.state 1
execute if score #candidates pvp.state matches 0 run tellraw @s [{"text":"Aucun joueur disponible pour l'instant.","color":"gray"}]

execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] run function pvp:menu_send_line
tag @s remove pvp.menu_target
