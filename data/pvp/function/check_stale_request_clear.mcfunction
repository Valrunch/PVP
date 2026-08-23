$execute unless entity @a[scores={pvp.id=$(target_id),pvp.pending_from=$(requester_id)}] run scoreboard players set @s pvp.requested_id 0
