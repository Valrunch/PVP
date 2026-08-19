# Contexte : exécuté "as" le joueur qui vient de cliquer [Accepter]
# Vérifie que la demande acceptée correspond bien à la dernière reçue
# (anti-demande périmée si plusieurs défis se sont enchaînés).
execute unless score @s pvp.pending_from = @s pvp.accept run return run tellraw @s [{"text":"Cette demande n'est plus valide.","color":"red"}]

execute store result storage pvparena:tmp requester_id int 1 run scoreboard players get @s pvp.pending_from
execute store result storage pvparena:tmp target_id int 1 run scoreboard players get @s pvp.id
scoreboard players set @s pvp.pending_from 0
function pvparena:launch_from_request with storage pvparena:tmp
