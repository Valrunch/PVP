# Contexte : exécuté "as" le joueur qui vient de cliquer [Défier]
execute if score @s pvp.id = @s pvp.request run return run tellraw @s [{"text":"Tu ne peux pas te défier toi-même.","color":"red"}]
execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"Tu es déjà en duel.","color":"red"}]
execute if score @s pvp.pending_from matches 1.. run return run tellraw @s [{"text":"Tu as déjà une demande de duel en attente.","color":"red"}]

execute store result storage pvparena:tmp target_id int 1 run scoreboard players get @s pvp.request
execute store result storage pvparena:tmp requester_id int 1 run scoreboard players get @s pvp.id
function pvparena:send_request_notify with storage pvparena:tmp
