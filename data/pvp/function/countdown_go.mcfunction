execute as @a[tag=pvp.duel] run title @s title {"text":"COMBATTEZ !","color":"red","bold":true}
execute as @a[tag=pvp.duel] run playsound minecraft:entity.ender_dragon.growl master @s ~ ~ ~ 0.5 2
scoreboard players set #global pvp.state 1
tellraw @a [{"text":"[Duel] ","color":"dark_gray"},{"text":"Duel lance !","color":"red","bold":true}]
