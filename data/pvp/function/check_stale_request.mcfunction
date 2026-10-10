execute store result storage pvp:tmp requester_id int 1 run scoreboard players get @s pvp.id
execute store result storage pvp:tmp target_id int 1 run scoreboard players get @s pvp.requested_id
function pvp:check_stale_request_clear with storage pvp:tmp
