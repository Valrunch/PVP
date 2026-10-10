scoreboard players add @s pvp.losses 1
execute if entity @a[tag=pvp.duel,tag=!pvp.loser] run title @s subtitle [{"text":"contre ","color":"gray"},{"selector":"@a[tag=pvp.duel,tag=!pvp.loser,limit=1]","color":"yellow"}]
title @s title {"text":"DEFAITE","color":"red","bold":true}
tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Reapparais pour recuperer ton inventaire.","color":"gray"}]
