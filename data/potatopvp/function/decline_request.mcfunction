# Contexte : exécuté "as" le joueur qui vient de cliquer [Refuser] (chat ou GUI)
execute unless score @s pvp.pending_from matches 1.. run return run tellraw @s [{"text":"Tu n'as aucune demande de duel en attente.","color":"red"}]

execute store result storage potatopvp:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage potatopvp:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
function potatopvp:decline_notify with storage potatopvp:tmp
