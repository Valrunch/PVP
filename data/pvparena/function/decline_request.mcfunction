# Contexte : exécuté "as" le joueur qui vient de cliquer [Refuser]
execute unless score @s pvp.pending_from = @s pvp.decline run return run tellraw @s [{"text":"Cette demande n'est plus valide.","color":"red"}]

execute store result storage pvparena:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage pvparena:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
function pvparena:decline_notify with storage pvparena:tmp
