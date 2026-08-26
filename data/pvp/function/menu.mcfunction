# Contexte : execute "as" le joueur qui vient de faire /trigger pvp.trigger
execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu es deja en duel.","color":"red"}]

# pvp.menu_target identifie le joueur POUR QUI on construit le menu.
# On en tague au plus un a la fois. Les commandes Minecraft s'executent
# de facon sequentielle (pas de vraie concurrence serveur), donc deux
# joueurs qui ouvrent le menu "en meme temps" sont en realite traites
# l'un apres l'autre : aucune collision possible ici.
tag @s add pvp.menu_target
scoreboard players operation #menu_target_id pvp.id = @s pvp.id
tellraw @s [{"text":"=== Defier un joueur ===","color":"gold"}]

scoreboard players set #candidates pvp.candidates 0
execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] unless score @s pvp.id = #menu_target_id pvp.id run scoreboard players add #candidates pvp.candidates 1
execute if score #candidates pvp.candidates matches 0 run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Aucun joueur disponible pour l'instant.","color":"gray"}]

execute as @a[tag=!pvp.duel,tag=!pvp.menu_target] unless score @s pvp.id = #menu_target_id pvp.id run function pvp:menu_send_line
tag @s remove pvp.menu_target

tellraw @s [{"text":"Retour au menu : ","color":"dark_gray"},{"text":"/trigger pvp.trigger","color":"yellow"}]
