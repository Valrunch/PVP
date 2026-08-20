$tellraw @a[scores={pvp.id=$(requester_id)}] [{"text":"✅ ","color":"green"},{"selector":"@a[scores={pvp.id=$(target_id)}]","color":"yellow"},{"text":" a accepté ton duel !","color":"green"}]
$tag @a[scores={pvp.id=$(requester_id)}] add pvp.slot1
$tag @a[scores={pvp.id=$(target_id)}] add pvp.slot2
function potatopvp:start_duel
