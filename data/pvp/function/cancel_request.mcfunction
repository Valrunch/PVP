# Contexte : execute "as" le joueur qui veut annuler SA demande envoyee.
execute unless score @s pvp.requested_id matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu n'as aucune demande de duel en attente.","color":"red"}]

execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.requested_id
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.requested_id 0
function pvp:cancel_notify with storage pvp:tmp
