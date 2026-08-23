tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Demande de duel annulee.","color":"gray"}]
$tellraw @a[scores={pvp.id=$(target_id),pvp.pending_from=$(requester_id)}] [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@a[scores={pvp.id=$(requester_id)}]","color":"yellow"},{"text":" a annule sa demande.","color":"gray"}]
$scoreboard players set @a[scores={pvp.id=$(target_id),pvp.pending_from=$(requester_id)}] pvp.pendingticks 0
$scoreboard players set @a[scores={pvp.id=$(target_id),pvp.pending_from=$(requester_id)}] pvp.pending_from 0
