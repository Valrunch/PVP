tellraw @s [{"text":"Demande refusee.","color":"gray"}]
$execute as @a[scores={pvp.id=$(requester_id)}] run tellraw @s [{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":" a refuse ton duel.","color":"gray"}]
