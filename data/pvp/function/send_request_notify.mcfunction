$execute unless entity @a[scores={pvp.id=$(target_id)}] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Joueur introuvable.","color":"red"}]
$execute unless entity @a[scores={pvp.id=$(target_id)},tag=!pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur est deja en duel.","color":"red"}]
$execute if entity @a[scores={pvp.id=$(target_id),pvp.pending_from=1..}] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur a deja une demande en attente.","color":"red"}]

$scoreboard players set @s pvp.requested_id $(target_id)
$tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Demande de duel envoyee a ","color":"aqua"},{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":". ","color":"aqua"},{"text":"[Annuler]","color":"red","bold":true,"clickEvent":{"action":"run_command","value":"/trigger pvp.cancel"},"hoverEvent":{"action":"show_text","value":"Annuler ta demande"}}]

$scoreboard players set @a[scores={pvp.id=$(target_id)}] pvp.pending_from $(requester_id)
$scoreboard players set @a[scores={pvp.id=$(target_id)}] pvp.pendingticks 600
$scoreboard players enable @a[scores={pvp.id=$(target_id)}] pvp.accept
$scoreboard players enable @a[scores={pvp.id=$(target_id)}] pvp.decline
$tellraw @a[scores={pvp.id=$(target_id)}] [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@a[scores={pvp.id=$(requester_id)}]","color":"yellow"},{"text":" te defie en duel !","color":"gray"}]
$execute as @a[scores={pvp.id=$(target_id)}] run menu pvp:duel_response
