execute as @a unless score @s pvp.id matches 1.. run function pvp:assign_id
execute as @a[scores={pvp.left=1..}] run function pvp:on_join
execute if score #global pvp.state matches 0 if entity @a[tag=pvp.duel] run function pvp:orphan_duel
execute as @a[scores={pvp.saved=1..},tag=!pvp.duel] unless data entity @s {Health:0.0f} run function pvp:restore_return_state
execute as @a[scores={pvp.trigger=1..}] run menu pvp:main
execute as @a[scores={pvp.trigger=1..}] run scoreboard players enable @s pvp.trigger
execute as @a[scores={pvp.trigger=1..}] run scoreboard players set @s pvp.trigger 0
execute as @a[scores={pvp.request=1..}] run function pvp:send_request
execute as @a[scores={pvp.request=1..}] run scoreboard players enable @s pvp.request
execute as @a[scores={pvp.request=1..}] run scoreboard players set @s pvp.request 0
execute as @a[scores={pvp.accept=1..}] run function pvp:accept_request
execute as @a[scores={pvp.accept=1..}] run scoreboard players set @s pvp.accept 0
execute as @a[scores={pvp.decline=1..}] run function pvp:decline_request
execute as @a[scores={pvp.decline=1..}] run scoreboard players set @s pvp.decline 0
execute as @a[scores={pvp.cancel=1..}] run function pvp:cancel_request
execute as @a[scores={pvp.cancel=1..}] run scoreboard players enable @s pvp.cancel
execute as @a[scores={pvp.cancel=1..}] run scoreboard players set @s pvp.cancel 0
execute as @a[scores={pvp.help=1..}] run function pvp:help
execute as @a[scores={pvp.help=1..}] run scoreboard players enable @s pvp.help
execute as @a[scores={pvp.help=1..}] run scoreboard players set @s pvp.help 0
execute as @a[scores={pvp.stats=1..}] run function pvp:show_stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players enable @s pvp.stats
execute as @a[scores={pvp.stats=1..}] run scoreboard players set @s pvp.stats 0
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=1..}] run scoreboard players remove @s pvp.pendingticks 1
execute as @a[scores={pvp.pending_from=1..,pvp.pendingticks=..0}] run function pvp:expire_request
execute if score #global pvp.state matches 1..2 run function pvp:check_win
execute as @a[tag=pvp_accept_pending] run function pvp:accept_request
tag @a[tag=pvp_accept_pending] remove pvp_accept_pending
