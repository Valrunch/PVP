scoreboard players add @s pvp.wins 0
scoreboard players add @s pvp.losses 0
tellraw @s [{"text":"=== Tes stats PvP ===  ","color":"gold"},{"text":"Victoires: ","color":"gray"},{"score":{"name":"@s","objective":"pvp.wins"},"color":"green"},{"text":"  Defaites: ","color":"gray"},{"score":{"name":"@s","objective":"pvp.losses"},"color":"red"}]
execute store result storage pvp:tmp key.id int 1 run scoreboard players get @s pvp.id
function pvp:show_stats_list with storage pvp:tmp key
