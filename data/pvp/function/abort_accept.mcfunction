tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Duel impossible pour l'instant. Reessaie dans quelques secondes.","color":"red"}]
$tellraw @a[scores={pvp.id=$(requester_id)}] [{"text":"[Duel] ","color":"dark_gray"},{"text":"Duel impossible pour l'instant. Reessaie dans quelques secondes.","color":"red"}]
$scoreboard players set @a[scores={pvp.id=$(requester_id)}] pvp.requested_id 0
