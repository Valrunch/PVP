execute if score @s pvp.requested_id matches 1.. run function pvp:check_stale_request
execute if score @s pvp.id = @s pvp.request run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu ne peux pas te defier toi-meme.","color":"red"}]
execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu es deja en duel.","color":"red"}]
execute if score @s pvp.saved matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Reapparais d'abord pour recuperer ton inventaire.","color":"red"}]
execute if score @s pvp.requested_id matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as deja une demande en attente. ","color":"red"},{"text":"[Annuler]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/trigger pvp.cancel"},"hoverEvent":{"action":"show_text","contents":"Annuler ta demande"}}]
execute unless score #global pvp.state matches 0 run return run function pvp:error_busy
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.request
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.id
function pvp:send_request_notify with storage pvp:tmp
