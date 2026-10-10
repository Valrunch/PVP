$execute unless entity @a[scores={pvp.id=$(requester_id)}] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur n'est plus en ligne.","color":"red"}]
$execute unless entity @a[scores={pvp.id=$(requester_id)},tag=!pvp.duel] run return run tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Ce joueur est deja en duel.","color":"red"}]
scoreboard players set #abort pvp.tmp 0
function pvp:vault_ready
$execute as @a[scores={pvp.id=$(requester_id)}] run function pvp:vault_ready
execute if score #abort pvp.tmp matches 1 run return run function pvp:abort_accept with storage pvp:tmp
function pvp:launch_from_request with storage pvp:tmp
