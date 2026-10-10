execute as @a[tag=pvp.duel] at @s unless dimension multiworld:pvp run tag @s remove pvp.duel
scoreboard players set #alive pvp.alive 0
execute as @a[tag=pvp.duel] run scoreboard players add #alive pvp.alive 1
execute if score #alive pvp.alive matches ..1 run return run function pvp:cancel_duel
execute as @a[tag=pvp.duel] if score @s pvp.deaths > @s pvp.deaths_start run tag @s add pvp.loser
execute if entity @a[tag=pvp.loser] run function pvp:end_duel
