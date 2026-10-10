scoreboard players set @s pvp.saved 0
gamemode survival @s
effect clear @s
effect give @s minecraft:resistance 3 255 true
effect give @s minecraft:instant_health 1 255 true
effect give @s minecraft:saturation 1 255 true
effect give @s minecraft:fire_resistance 10 0 true
execute if entity @s[tag=pvp.reward] run function pvp:give_reward
tellraw @s [{"text":"[Duel] ","color":"dark_gray"},{"text":"Inventaire et position restaures.","color":"green"}]
