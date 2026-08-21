$tellraw @s [{"text":"Demande de duel envoyee a ","color":"aqua"},{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":".","color":"aqua"}]
$execute as @a[scores={pvp.id=$(target_id)}] run scoreboard players set @s pvp.pending_from $(requester_id)
$execute as @a[scores={pvp.id=$(target_id)}] run scoreboard players enable @s pvp.accept
$execute as @a[scores={pvp.id=$(target_id)}] run scoreboard players enable @s pvp.decline
$execute as @a[scores={pvp.id=$(target_id)}] run tellraw @s [{"text":"\u2694 ","color":"red"},{"selector":"@a[scores={pvp.id=$(requester_id)}]","color":"yellow"},{"text":" te defie en duel !","color":"gray"}]
$execute as @a[scores={pvp.id=$(target_id)}] run menu potatopvp:duel_response
