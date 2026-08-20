execute as @a[tag=pvp.duel] run title @s title {"text":"2","color":"yellow","bold":true}
execute as @a[tag=pvp.duel] run playsound minecraft:block.note_block.pling master @s ~ ~ ~ 1 1
schedule function potatopvp:countdown_1 20
