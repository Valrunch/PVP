# Contexte : execute "as" le joueur qui vient de cliquer [Defier]
# (ou de faire /trigger pvp.request set <id> a la main).
execute if score @s pvp.requested_id matches 1.. run function pvp:check_stale_request
execute if score @s pvp.id = @s pvp.request run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu ne peux pas te defier toi-meme.","color":"red"}]
execute if entity @s[tag=pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu es deja en duel.","color":"red"}]
execute if score @s pvp.requested_id matches 1.. run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Tu as deja une demande en attente. Utilise /trigger pvp.cancel pour l'annuler.","color":"red"}]
execute unless score #global pvp.state matches 0 run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"L'arene est occupee, reessaie dans quelques instants.","color":"red"}]

execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.request
execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.id
function pvp:send_request_notify with storage pvp:tmp
