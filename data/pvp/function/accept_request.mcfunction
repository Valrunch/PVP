execute unless score @s pvp.pending_from matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Aucune demande de duel en attente.","color":"red"}]
execute unless score #global pvp.state matches 0 run return run function pvp:error_busy
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
scoreboard players set @s pvp.pendingticks 0
function pvp:accept_validate with storage pvp:tmp
