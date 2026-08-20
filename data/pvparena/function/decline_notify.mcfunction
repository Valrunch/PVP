tellraw @s [{"text":"Demande refusée.","color":"gray"}]
$execute as @a[scores={pvp.id=$(requester_id)}] run tellraw @s [{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":" a refusé ton duel.","color":"gray"}]
