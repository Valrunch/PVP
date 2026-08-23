tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"La demande de duel a expire.","color":"gray"}]
$scoreboard players set @a[scores={pvp.id=$(requester_id)}] pvp.requested_id 0
$tellraw @a[scores={pvp.id=$(requester_id)}] [{"text":"[Duel] ","color":"dark_gray"},{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":" n'a pas repondu a temps.","color":"gray"}]
