tag @a[tag=pvp.slot1] add pvp.duel
tag @a[tag=pvp.slot2] add pvp.duel
execute as @a[tag=pvp.duel] run function pvp:save_return_state
execute as @a[tag=pvp.duel] unless score @s pvp.saved matches 1.. run return run function pvp:abort_start
execute as @a[tag=pvp.duel] run scoreboard players operation @s pvp.deaths_start = @s pvp.deaths
execute as @a[tag=pvp.slot1] in multiworld:pvp run tp @s 150 6.00 -139 90 0
execute as @a[tag=pvp.slot2] in multiworld:pvp run tp @s 32 6.00 -136 -90 0
execute as @a[tag=pvp.duel] run function pvp:prepare_player
execute as @a[tag=pvp.duel] run effect give @s minecraft:resistance 3 255 true
schedule clear pvp:countdown_2
schedule clear pvp:countdown_1
schedule clear pvp:countdown_go
scoreboard players set #global pvp.state 2
function pvp:countdown_3
