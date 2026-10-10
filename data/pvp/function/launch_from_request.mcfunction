$scoreboard players set @a[scores={pvp.id=$(requester_id)}] pvp.requested_id 0
$scoreboard players set @a[scores={pvp.id=$(requester_id)}] pvp.pending_from 0
$scoreboard players set @a[scores={pvp.id=$(requester_id)}] pvp.pendingticks 0
$tag @a[scores={pvp.id=$(requester_id)}] add pvp.slot1
$tag @a[scores={pvp.id=$(target_id)}] add pvp.slot2
function pvp:start_duel
