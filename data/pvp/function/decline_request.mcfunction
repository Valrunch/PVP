# Contexte : exécuté "as" le joueur qui vient de cliquer [Refuser] (chat ou GUI)
execute unless score @s pvp.pending_from matches 1.. run return run tellraw @s [{"text":"Tu n'as aucune demande de duel en attente.","color":"red"}]

execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
function pvp:decline_notify with storage pvp:tmp
